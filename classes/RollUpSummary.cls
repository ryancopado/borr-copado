public class RollUpSummary {
    
    // Account Payable Roll Ups
    public static void accountPayableRollUp(Set<Id> apIds) {
        
        if (!apIds.isEmpty()) {
            
            // Create parent record maps of account payable line records for the rollups, one account payable line record per parent record.
            // This reduces the CPU time required to do the rollups in RollUpSummaryUtility.cls
            Map<Id, AcctSeed__Account_Payable_Line__c> projectMap = new Map<Id, AcctSeed__Account_Payable_Line__c>();
            Map<Id, AcctSeed__Account_Payable_Line__c> changeOrderMap = new Map<Id, AcctSeed__Account_Payable_Line__c>();
            Map<Id, AcctSeed__Account_Payable_Line__c> retentionMap = new Map<Id, AcctSeed__Account_Payable_Line__c>();
            Map<Id, AcctSeed__Account_Payable_Line__c> projectTaskMap = new Map<Id, AcctSeed__Account_Payable_Line__c>();
            List<AcctSeed__Account_Payable_Line__c> records = new List<AcctSeed__Account_Payable_Line__c>();
            records = [select id, AcctSeed__Amount__c, AcctSeed__Account_Payable__c, AcctSeed__Project__c, AcctSeed__Project_Task__c, Change_Order__c, Retention__c, Use_Old_CC__c from AcctSeed__Account_Payable_Line__c where AcctSeed__Account_Payable__c in :apIds];
            for (AcctSeed__Account_Payable_Line__c apl :records) {
                if (apl.AcctSeed__Project__c != null) {
                    projectMap.put(apl.AcctSeed__Project__c, apl);
                }
                if (apl.Change_Order__c != null) {
                    changeOrderMap.put(apl.Change_Order__c, apl);
                }
                if (apl.Retention__c != null) {
                    retentionMap.put(apl.Retention__c, apl);
                }
                if (apl.AcctSeed__Project_Task__c != null) {
                    projectTaskMap.put(apl.AcctSeed__Project_Task__c, apl);
                }
            }
            
            if (!records.isEmpty()) {
                
                // Set up query filters
                // Query filter for GL Account
                List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
                glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
                String glaFilter = '';
                if (glaList.size() > 0) {
                    glaFilter += ' and (AcctSeed__Expense_GL_Account__c = \'' + glaList[0].Id + '\'';
                    for (Integer i=1; i<glaList.size(); i++) {
                        glaFilter += ' or AcctSeed__Expense_GL_Account__c = \'' + glaList[i].Id + '\'';
                    }
                    glaFilter += ')';
                }
                
                // Query filter for Line Item record type
                List<RecordType> liRtList = new List<RecordType>([select Id from RecordType 
                        where Name = 'Budget Line Item' and SobjectType = 'AcctSeed__Project_Task__c']);
                String liFilter = '';
                if (!liRtList.isEmpty()) {
                    liFilter = ' and AcctSeed__Project_Task__r.RecordTypeId = \'' + liRtList[0].Id + '\'';
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
                
                // Rollup definitions
                // Fields to roll up for Posted Account Payable Lines
                List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsPosted = 
                    new List<RollUpSummaryUtility.fieldDefinition> {
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Account_Payable_Line_Amount__c')
                        //new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Account_Payable__r.AcctSeed__Paid_Amount__c', 'Roll_Up_Account_Payable_Line_Amount__c')
                    };
                
                // Fields to roll up for all Account Payable Lines
                List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolar = 
                    new List<RollUpSummaryUtility.fieldDefinition> {
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Solar_Account_Payable_Lines__c')
                    };
                
                // Fields to roll up for all Account Payable Lines
                List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
                    new list<RollUpSummaryUtility.fieldDefinition> {
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_All_Account_Payable_Lines__c')
                    };
                
                // Fields to roll up for all Account Payable Lines that are on hold
                List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllHold = 
                    new list<RollUpSummaryUtility.fieldDefinition> {
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'On_Hold_Invoices__c')
                    };
                
                // Fields to roll up for all Account Payable Lines
                List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllCO = 
                    new list<RollUpSummaryUtility.fieldDefinition> {
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'AP_Line_CO_Total__c')
                    };
                
                // Fields to roll up for all Account Payable Lines - roll up to Retention
                List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsRetentionAPL = 
                    new list<RollUpSummaryUtility.fieldDefinition> {
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_AP_Lines__c')
                    };
                
                // Execute the rollups
                if (!projectMap.isEmpty()) {
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPosted, projectMap.values(), 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Partially Paid\')');
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, projectMap.values(), 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\'' + glaFilter + liFilter);
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, projectMap.values(), 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', solarModuleFilter);
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, projectMap.values(), 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', moduleFilter);
                }
                
                if (!changeOrderMap.isEmpty()) {
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllCO, changeOrderMap.values(), 'AcctSeed__Account_Payable_Line__c', 'Change_Order__c', 'Con_req__c', ' and (AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\') and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Unpaid\')');
                }
                
                if (!retentionMap.isEmpty()) {
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsRetentionAPL, retentionMap.values(), 'AcctSeed__Account_Payable_Line__c', 'Retention__c', 'Retention__c', ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\'');
                }
                
                if (!projectTaskMap.isEmpty()) {
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, projectTaskMap.values(), 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\' and AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Canceled\'' + glaFilter);
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllHold, projectTaskMap.values(), 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'ON HOLD\'');
                }
            }
        }
    }
    
    // Journal Entry Roll Ups
    public static void journalEntryRollUp(Set<Id> jeIds) {
        system.debug('this is rollupSummary starting' +jeIds);
        if (!jeIds.isEmpty()) {
            
            // Get all the Journal Entry Line records that may need to be rolled up
            List<AcctSeed__Journal_Entry_Line__c> jelRecords = new List<AcctSeed__Journal_Entry_Line__c>();
            jelRecords = [select Id, AcctSeed__Debit__c, AcctSeed__Credit__c, AcctSeed__Project_Task__c, AcctSeed__Project__c, Use_Old_CC__c from AcctSeed__Journal_Entry_Line__c where AcctSeed__Journal_Entry__c in :jeIds];
            
            // Create two maps - one Journal Entry Line per Project Task parent and one Journal Entry Line per Project parent
            Map<Id, AcctSeed__Journal_Entry_Line__c> jelProjectMap = new Map<Id, AcctSeed__Journal_Entry_Line__c>();
            Map<Id, AcctSeed__Journal_Entry_Line__c> jelProjectTaskMap = new Map<Id, AcctSeed__Journal_Entry_Line__c>();
            for (AcctSeed__Journal_Entry_Line__c jel :jelRecords) {
                if (jel.AcctSeed__Project_Task__c != null) {
                    jelProjectTaskMap.put(jel.AcctSeed__Project_Task__c, jel);
                }
                if (jel.AcctSeed__Project__c != null) {
                    jelProjectMap.put(jel.AcctSeed__Project__c, jel);
                }
            }
            
            if (!jelProjectTaskMap.isEmpty() || !jelProjectMap.isEmpty()) {
                
                // Fields to roll up from Journal Entry Line to Project Task parent
                List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
                    new List<RollUpSummaryUtility.fieldDefinition> {
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Journal_Entry_Debit__c'),
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Journal_Entry_Credit__c')
                    };
                
                // Fields to roll up from Journal Entry Line to Project parent with module filters
                List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolarProject = 
                    new List<RollUpSummaryUtility.fieldDefinition> {
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Credit__c'),
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Debit__c')
                    };
                
                // Fields to roll up from Journal Entry Line to Project parent with Project Task (Line Item) filter
                List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllProject = 
                    new List<RollUpSummaryUtility.fieldDefinition> {
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Journal_Entry_Lines_Debit__c'),
                        new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Journal_Entry_Lines_Credit__c')
                    };
                
                // Query filter for GL Account
                List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
                glaList = [select Id from AcctSeed__GL_Account__c where Name like '3%'];
                String glaFilter = '';
                if (glaList.size() > 0) {
                    glaFilter += ' and (AcctSeed__GL_Account__c = \'' + glaList[0].Id + '\'';
                    for (Integer i=1; i<glaList.size(); i++) {
                        glaFilter += ' or AcctSeed__GL_Account__c = \'' + glaList[i].Id + '\'';
                    }
                    glaFilter += ')';
                }
                
                // Query filter for Line Item record type
                List<RecordType> liRtList = new List<RecordType>([select Id from RecordType 
                        where Name = 'Budget Line Item' and SobjectType = 'AcctSeed__Project_Task__c']);
                String liFilter = '';
                if (!liRtList.isEmpty()) {
                    liFilter = ' and AcctSeed__Project_Task__r.RecordTypeId = \'' + liRtList[0].Id + '\'';
                }
                
                // Set up the Cost Code filters
                RollUpSummaryUtility.costCodeIdFilters ccIdFilters = new RollUpSummaryUtility.costCodeIdFilters();
                String moduleFilter = '';
                if (ccIdFilters.moduleIdFilter != '') {
                    moduleFilter = ' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.moduleIdFilter;
                }
                String solarModuleFilter = '';
                if (ccIdFilters.solarModuleIdFilter != '') {
                    solarModuleFilter = ' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.solarModuleIdFilter;
                }
                
                if (!jelProjectTaskMap.isEmpty()) {
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, jelProjectTaskMap.values(), 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter + ' and AcctSeed__Parent_Status__c = \'Posted\' ');
                }
                
                if (!jelProjectMap.isEmpty()) {
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllProject, jelProjectMap.values(), 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + liFilter + ' and AcctSeed__Parent_Status__c = \'Posted\' ');
                    
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, jelProjectMap.values(), 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + solarModuleFilter + ' and Use_Old_CC__c = true' + ' and AcctSeed__Parent_Status__c = \'Posted\' ');
                    
                    RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, jelProjectMap.values(), 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + moduleFilter + ' and Use_Old_CC__c = false'  + ' and AcctSeed__Parent_Status__c = \'Posted\' ');
                }
            }
        }
    }
}