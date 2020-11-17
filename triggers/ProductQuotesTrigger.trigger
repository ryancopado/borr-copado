trigger ProductQuotesTrigger on Product_Quotes__c (before insert) {
	
	if (trigger.isBefore) {
		
		if (trigger.isInsert) {
			ProductQuotesService.setFieldsOnCreate(trigger.new);
		}
	}
}