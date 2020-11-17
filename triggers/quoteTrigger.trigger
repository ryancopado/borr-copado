trigger quoteTrigger on SBQQ__Quote__c (after insert, after update) {
    
    List<SBQQ__Quote__c> approvedQuotes = new List<SBQQ__Quote__c>();
    List<Id> approvedQuoteIDs = new List<Id>();
    if (Trigger.isInsert) {
        for (SBQQ__Quote__c quote : Trigger.New) {
            if (quote.SBQQ__Status__c == 'Accepted') {
                approvedQuotes.add(quote);
                approvedQuoteIDs.add(quote.Id);
            }
        }
    } else if (Trigger.isUpdate) {
         for (SBQQ__Quote__c quote : Trigger.New) {
            if (quote.SBQQ__Status__c == 'Accepted' && Trigger.OldMap.get(quote.id).SBQQ__Status__c != 'Accepted') {
                approvedQuotes.add(quote);
                approvedQuoteIDs.add(quote.Id);
            }
        }
    }
    QuoteTriggerHandler.approvedQuote(approvedQuoteIDs);
}