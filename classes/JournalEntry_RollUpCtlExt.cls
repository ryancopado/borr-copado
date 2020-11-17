public with sharing class JournalEntry_RollUpCtlExt {
    
    /*
     *  Execute the journal entry rollups for a single record or for all outstanding records
     */
    
    public AcctSeed__Journal_Entry__c je {get; set;}
    
    public JournalEntry_RollUpCtlExt(ApexPages.StandardController stdController) {
        this.je = (AcctSeed__Journal_Entry__c)stdController.getRecord();
        if (this.je != null && this.je.Id != null) {
            this.je = [select Id, Name, Do_RollUp__c from AcctSeed__Journal_Entry__c where Id = :this.je.Id];
        }
    }
    
    public PageReference executeRollUps() {
        Set<Id> jeIds = new Set<Id>();
        
        jeIds.add(je.Id);
        try {
            RollUpSummary.journalEntryRollUp(jeIds);
            je.Do_RollUP__c = false;
            update je;
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Journal Entry: rollup execution successful.'));
        } catch(Exception e) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Journal Entry: rollup exception: ' + e.getMessage()));
        }
        
        return null;
    }
    
    public PageReference executeAllOutstandingRollUps() {
        BatchJournalEntryPosted batch;
        String queryString = 'SELECT Id, Do_RollUp__c FROM AcctSeed__Journal_Entry__c WHERE Id = \'' + je.Id + '\'';
        
        try {
            if (Test.isRunningTest()) {
                batch = new BatchJournalEntryPosted(queryString);
            } else {
                batch = new BatchJournalEntryPosted();
            }
            Database.executeBatch(batch, batch.JournalEntryPostedBatchSize);
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'Journal Entry: rollup of all outstanding records initiated successfully. You will receive an email upon completion.'));
        } catch(Exception e) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Journal Entry rollup of all outstanding records initiation exception: ' + e.getMessage()));
        }
        
        return null;
    }
}