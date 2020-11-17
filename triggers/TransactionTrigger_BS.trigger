trigger TransactionTrigger_BS on AcctSeed__Transaction__c (before insert, before update) {
	
	if (trigger.isBefore) {
		
		if (trigger.isInsert) {
			TransactionService.relatedRecordFields(trigger.new, null, trigger.isInsert);
		}
		
		if (trigger.isUpdate) {
			TransactionService.relatedRecordFields(trigger.new, trigger.oldMap, trigger.isInsert);
		}
	}
}