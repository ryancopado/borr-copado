trigger billingTrigger on AcctSeed__Billing__c (after insert) {
    if (trigger.isInsert && trigger.isAfter) {
        List<AcctSeed__Billing__c> billingsToUpdate = new List<AcctSeed__Billing__c>();
        List<Id> currentIds = new List<Id>();
        AcctSeed__Billing__c bill =new AcctSeed__Billing__c();
        
        for (AcctSeed__Billing__c billing : Trigger.new) {
            currentIds.add(billing.id);
        }
        
        List<AcctSeed__Billing__c> currentBillings = [SELECT Id, Name, AcctSeed__Customer__c, Application_Number__c,
                                                      AcctSeed__Proprietary_Billing_Number__c, Quote__r.SBQQ__BillingName__c, Quote__r.Project_Name__c,AcctSeed__Recurring_Billing__c
                                                      FROM AcctSeed__Billing__c WHERE ID IN :currentIds];
         bill= currentBillings.get(0);                                             
        If( bill.AcctSeed__Recurring_Billing__c==null) 
        {                                         
            
        for (AcctSeed__Billing__c billing : currentBillings) {
            //billing.Application_Number__c = 'AV' + billing.Name;
            billing.Application_Number__c=billing.Name;
            String shortBillingProject = billing.Quote__r.SBQQ__BillingName__c + '_' + billing.Quote__r.Project_Name__c;
            //billing.AcctSeed__Proprietary_Billing_Number__c = billing.Quote__r.SBQQ__BillingName__c + '_' + billing.Quote__r.Project_Name__c + '_' + 'AV' + billing.Name;
            billing.AcctSeed__Proprietary_Billing_Number__c = shortBillingProject.left(90) + '_' + Date.today().format();
            billingsToUpdate.add(billing);
        }
        update billingsToUpdate;
    }
    }
    
}