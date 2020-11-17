trigger CasefldupdatefromQuote on SBQQ__Quote__c (after update) {
    
    /* this trigger updates record on the Case object(fld- quote_accepted__c = true)
     * for the validation rule to trigger(When a case is closed the quote status should be accepted)  */

     //list to store the case id of the quote
     Set<Id> caseIdSet = new Set<Id>();
     //list to store the cases, that needs to be update
     List<Case> caseToUpdate = new List<Case>();


     for(SBQQ__Quote__c quote : Trigger.New) {
         if(quote.Case__c != null) {
            caseIdSet.add(quote.Case__c);
         }
     }

     if(caseIdSet.size() > 0) {
         for(Case c : [SELECT Id, Quote_Accepted__c, (SELECT Id FROM Quotes__r WHERE SBQQ__Primary__c = true AND (SBQQ__Status__c = 'Accepted' OR SBQQ__Status__c = 'Rejected')) FROM Case WHERE Id IN: caseIdSet]) {
            //if there is no quote found, then set the Quote_Accepted__c = false on the related case, else set true
            if(c.Quotes__r.size() == 0) {
                 if(c.Quote_Accepted__c != false) {
                    c.Quote_Accepted__c = false;
                    caseToUpdate.add(c);
                 }
             } else if(c.Quotes__r.size() > 0) {
                if(c.Quote_Accepted__c != true) {
                    c.Quote_Accepted__c = true;
                    caseToUpdate.add(c);
                }
             }
         }

         if(caseToUpdate.size() > 0) {
             update caseToUpdate;
         }
     }
}