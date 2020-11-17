public with sharing class AccountPayableLineRollUp {
    
    /*
     *  Methods to rollup the sum of various fields on Account Payable Line records to related objects.
     *  This is performed asynchronously because of the number of queries performed.
     *
     */
    public static Set<Id> setAccountPayableStatusChanged {get;set;}
    
    @future
    public static void rollUpAccountPayableLine(Set<Id> ptIds, Set<Id> pIds, Set<Id> polIds, Set<Id> coIds, Set<Id> rIds) {
        
        //Fields to roll up for all Account Payable Lines
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolar = 
            new list<RollUpSummaryUtility.fieldDefinition> {
                new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Solar_Account_Payable_Lines__c')
            };
        
        //Fields to roll up for Posted Account Payable Lines
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsPosted = 
            new list<RollUpSummaryUtility.fieldDefinition> {
                new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Account_Payable_Line_Amount__c')
            };
        
        //Fields to roll up for all Account Payable Lines
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
            new list<RollUpSummaryUtility.fieldDefinition> {
                new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_All_Account_Payable_Lines__c')
            };
        
        //Fields to roll up for all Account Payable Lines that are on hold
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllHold = 
            new list<RollUpSummaryUtility.fieldDefinition> {
                new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'On_Hold_Invoices__c')
            };
        
        //Fields to roll up for all Account Payable Lines
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllCO = 
            new list<RollUpSummaryUtility.fieldDefinition> {
                new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'AP_Line_CO_Total__c')
            };  
         //system.debug('Amount' +fieldDefinitionsAllCO.AcctSeed__Amount__c);
         
         //system.debug('Co Total' +fieldDefinitionsAllCO.AP_Line_CO_Total__c);
         
        //Fields to roll up for all Account Payable Lines - roll up to Retention
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsRetentionAPL = 
            new list<RollUpSummaryUtility.fieldDefinition> {
                new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_AP_Lines__c')
            };
        
        //Fields to roll up for all Account Payable Lines with null CO and null POL - roll up to Project Task
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsNonPOCosts = 
            new list<RollUpSummaryUtility.fieldDefinition> {
                new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Non_PO_Costs_RollUp__c')
            };
        
        // Record the parent Ids in APLine records that need to have a roll up calculated
        List<AcctSeed__Account_Payable_Line__c> recordsPT = new List<AcctSeed__Account_Payable_Line__c>();
        for (Id i :ptIds) {
            recordsPT.add(new AcctSeed__Account_Payable_Line__c(AcctSeed__Project_Task__c = i));
        }
        List<AcctSeed__Account_Payable_Line__c> recordsP = new List<AcctSeed__Account_Payable_Line__c>();
        for (Id i :pIds) {
            recordsP.add(new AcctSeed__Account_Payable_Line__c(AcctSeed__Project__c = i));
        }
        List<AcctSeed__Account_Payable_Line__c> recordsPOL = new List<AcctSeed__Account_Payable_Line__c>();
        for (Id i :polIds) {
            recordsPOL.add(new AcctSeed__Account_Payable_Line__c(AcctSeedERP__Purchase_Order_Line__c = i));
        }
        List<AcctSeed__Account_Payable_Line__c> recordsCO = new List<AcctSeed__Account_Payable_Line__c>();
        for (Id i :coIds) {
            recordsCO.add(new AcctSeed__Account_Payable_Line__c(Change_Order__c = i));
        }
        List<AcctSeed__Account_Payable_Line__c> recordsR = new List<AcctSeed__Account_Payable_Line__c>();
        for (Id i :rIds) {
            recordsR.add(new AcctSeed__Account_Payable_Line__c(Retention__c = i));
        }
        
        // Create the Expense GL Account filter and the Project Task record type filter
        List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
        glaList = [select Id from AcctSeed__GL_Account__c where Name like '3%'];
        String glaFilter = '';
        if (glaList.size() > 0) {
            glaFilter += ' and (AcctSeed__Expense_GL_Account__c = \'' + glaList[0].Id + '\'';
            for (Integer i=1; i<glaList.size(); i++) {
                glaFilter += ' or AcctSeed__Expense_GL_Account__c = \'' + glaList[i].Id + '\'';
            }
            glaFilter += ')';
        }
        
        Map<String, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName();
        String liFilter = '';
        if (rtMap.containsKey('Budget Line Item')) {
            liFilter = ' and AcctSeed__Project_Task__r.RecordTypeId = \'' + rtMap.get('Budget Line Item').getRecordTypeId() + '\'';
        }
        
        // Set up the Cost Code filters
        RollUpSummaryUtility.costCodeIdFilters ccIdFilters = new RollUpSummaryUtility.costCodeIdFilters();
        String moduleFilter = '';
        if (ccIdFilters.moduleIdFilter != '') {
            moduleFilter = ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.moduleIdFilter;
        }
        String solarModuleFilter = '';
        if (ccIdFilters.solarModuleIdFilter != '') {
            solarModuleFilter = ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.solarModuleIdFilter;
        }
        
        // Execute the roll ups
        if (!recordsPT.isEmpty()) {
            // Changed By Madan - Sept 11, 2017(Added additional Filter Invoice Status should not be Canceled Or Rejected)
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, recordsPT, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and Invoice_Status__c != \'Rejected\' AND Invoice_Status__c != \'Canceled\'' + glaFilter);
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllHold, recordsPT, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and Invoice_Status__c = \'ON HOLD\'');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsNonPOCosts, recordsPT, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and Change_Order__c = null and AcctSeedERP__Purchase_Order_Line__c = null');
        }
        
        if (!recordsP.isEmpty()) {
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPosted, recordsP, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Partially Paid\')');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, recordsP, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\'' + glaFilter + liFilter);
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsP, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', solarModuleFilter + ' and Use_Old_CC__c = true');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsP, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', moduleFilter + ' and Use_Old_CC__c = false');
        }
        
        if (!recordsPOL.isEmpty()) {
            // Changed By Madan - Sept 11, 2017(Added additional Filter Invoice Status should not be Canceled Or Rejected)
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, recordsPOL, 'AcctSeed__Account_Payable_Line__c', 'AcctSeedERP__Purchase_Order_Line__c', 'AcctSeedERP__Purchase_Order_Line__c', ' AND Invoice_Status__c != \'Rejected\' AND Invoice_Status__c!=\'Canceled\' ');
        }
        
        
        system.debug('Roll Up Total' +recordsCO);
        
        system.debug('Total' +fieldDefinitionsAllCO);
        
        if (!recordsCO.isEmpty()) {
        
        system.debug('Entering if condition');
            // Changed By Madan - Sept 11, 2017(Added additional Filter Invoice Status should not be Canceled Or Rejected)
            // changed by divya on 8/28/2019 (additional filter for payment status partially paid on AP)
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllCO, recordsCO, 'AcctSeed__Account_Payable_Line__c', 'Change_Order__c', 'Con_req__c', ' AND (Invoice_Status__c!=\'Rejected\' AND Invoice_Status__c!=\'Canceled\') and (AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\') and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Unpaid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Partially Paid\')');
        }
        
        system.debug('Roll Up Total' +recordsCO);
        
        if (!recordsR.isEmpty()) {
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsRetentionAPL, recordsR, 'AcctSeed__Account_Payable_Line__c', 'Retention__c', 'Retention__c', ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\'');
        }
    }
}