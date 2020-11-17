public with sharing class AccountPayable_RollUpCtlExt {
    
    /*
     *  Execute the account payable rollups for a single record
     */
    
    public AcctSeed__Account_Payable__c ap {get; set;}
    
    public AccountPayable_RollUpCtlExt(ApexPages.StandardController stdController) {
        this.ap = (AcctSeed__Account_Payable__c)stdController.getRecord();
        if (this.ap != null && this.ap.Id != null) {
            this.ap = [select Id, Name, Do_RollUp__c from AcctSeed__Account_Payable__c where Id = :this.ap.Id];
        }
    }
    
    public PageReference executeRollUps() {
        Set<Id> apIds = new Set<Id>();
        
        apIds.add(ap.Id);
        try {
            RollUpSummary.accountPayableRollUp(apIds);
            ap.Do_RollUP__c = false;
            update ap;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Account Payable: rollup execution successful.'));
        } catch(Exception e) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Account Payable: rollup exception: ' + e.getMessage()));
        }
        
        return null;
    }
    
    public PageReference executeAllOutstandingRollUps() {
        BatchAccountPayablePosted batch;
        String queryString = 'SELECT Id, Do_RollUp__c FROM AcctSeed__Account_Payable__c WHERE Id = \'' + ap.Id + '\'';
            
        try {
            if (Test.isRunningTest()) {
                batch = new BatchAccountPayablePosted(queryString);
            } else {
                batch = new BatchAccountPayablePosted();
            }
            Database.executeBatch(batch, batch.AccountPayablePostedBatchSize);
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Account Payable: rollup of all outstanding records initiated successfully. You will receive an email upon completion.'));
        } catch(Exception e) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Account Payable rollup of all outstanding records initiation exception: ' + e.getMessage()));
        }
        
        return null;
    }
}