global class BatchJournalEntryPosted implements Database.Batchable<sObject> {
    
    /*
     *  Batch job to perform the rollup SUMs of Journal Entry Line records of the Journal Entry records that 
     *  have recently been posted or unposted.
     *
     */
    
    public Integer JournalEntryPostedBatchSize = 10;
    
    global final String Query;
    global BatchJournalEntryPosted() {
        Query = 'SELECT Id, Do_RollUp__c '
            + 'FROM AcctSeed__Journal_Entry__c '
            + 'WHERE Do_RollUp__c = TRUE';
    }
    
    global BatchJournalEntryPosted(String q) {
        Query = q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Database.QueryLocator ql = Database.getQueryLocator(Query);
        system.debug('*****BatchJournalEntryPosted Query locator: ' + ql);
        return ql;
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        
        Set<Id> jeIds = new Set<Id>();
        for (sObject s :scope) {
            AcctSeed__Journal_Entry__c je = (AcctSeed__Journal_Entry__c)s;
            jeIds.add(je.Id);
            je.Do_RollUp__c = false;
        }
        
        RollUpSummary.journalEntryRollUp(jeIds);
        
        // Clear the do rollup flag on all of the journal entry records
        update scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        
        // Get the status of the batch job just completed
        AsyncApexJob a = [select Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email from AsyncApexJob where Id =: BC.getJobId()];
        
        // Determine what salesforce org we are running in
        Organization org = [select Id, IsSandbox from Organization];
        String orgType = (org.IsSandbox) ? 'sandbox' : 'production';
        
        // Send an email to notify of job completion. 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> toAddresses = new List<String>();
        toAddresses.add(a.CreatedBy.Email);
        toAddresses.add('etam@borregosolar.com');
        mail.setToAddresses(toAddresses);
        mail.setSubject('BatchJournalEntryPosted Status: ' + a.Status);
        mail.setPlainTextBody('Batch Apex job BatchJournalEntryPosted completed execution in Salesforce org ' + orgType + '/' + org.Id + ': processed ' + a.TotalJobItems + ' batches (of up to ' + JournalEntryPostedBatchSize + ' records each) with ' + a.NumberOfErrors + ' failures. Please see the Apex Jobs page for more information.');
        if (!Test.isRunningTest()) {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
}