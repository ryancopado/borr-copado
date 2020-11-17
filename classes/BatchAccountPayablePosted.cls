global class BatchAccountPayablePosted implements Database.Batchable<sObject> {
    
    /*
     *  Batch job to perform the rollup SUMs of Account Payable Line records of the Account Payable records that 
     *  have recently been posted or unposted.
     *
     */
    
    public Integer AccountPayablePostedBatchSize = 20;
    
    global final String Query;
    global BatchAccountPayablePosted() {
        Query = 'SELECT Id, Do_RollUp__c '
            + 'FROM AcctSeed__Account_Payable__c '
            + 'WHERE Do_RollUp__c = TRUE';
    }
    
    global BatchAccountPayablePosted(String q) {
        Query = q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Database.QueryLocator ql = Database.getQueryLocator(Query);
        system.debug('*****BatchAccountPayablePosted Query locator: ' + ql);
        return ql;
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        
        Set<Id> apIds = new Set<Id>();
        for (sObject s :scope) {
            AcctSeed__Account_Payable__c ap = (AcctSeed__Account_Payable__c)s;
            apIds.add(ap.Id);
            ap.Do_RollUp__c = false;
        }
        
        RollUpSummary.accountPayableRollUp(apIds);
        
        // Clear the do rollup flag on all of the account payable records
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
        mail.setSubject('BatchAccountPayablePosted Status: ' + a.Status);
        mail.setPlainTextBody('Batch Apex job BatchAccountPayablePosted completed execution in Salesforce org ' + orgType + '/' + org.Id + ': processed ' + a.TotalJobItems + ' batches (of up to ' + AccountPayablePostedBatchSize + ' records each) with ' + a.NumberOfErrors + ' failures. Please see the Apex Jobs page for more information.');
        if (!Test.isRunningTest()) {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
}