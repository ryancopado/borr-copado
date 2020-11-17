trigger BillingLineTrigger on AcctSeed__Billing_Line__c (after delete, after insert, after undelete, after update, before insert, before update) {
	
	if (trigger.isBefore) {
		
		if (trigger.isInsert) {
			BillingLineService.blsProjectTask(trigger.new, null, trigger.isInsert);
			BillingLineService.blsTaxable(trigger.new, null, trigger.isInsert);
			BillingLineService.blsCase(trigger.new, null, trigger.isInsert);
			BillingLineService.blsproj(trigger.new, null, trigger.isInsert); // added by MG on 2/24 (to populate field business unit and team in BL)
			// Added By Madan - Aug 23, 2017(To pre-populate few fields)
			BillingLineService.populateFields(trigger.new);
		}
		
		if (trigger.isUpdate) {
			BillingLineService.blsProjectTask(trigger.new, trigger.oldMap, trigger.isInsert);
			BillingLineService.blsTaxable(trigger.new, trigger.oldMap, trigger.isInsert);
			BillingLineService.blsCase(trigger.new, trigger.oldMap, trigger.isInsert);
			
			// Added By Madan - Aug 23, 2017(To pre-populate few fields)
			BillingLineService.populateFields(trigger.new);
		}
	}
	
	if (trigger.isAfter) {

		if (trigger.isDelete) {
			BillingLineService.blsCaseBillingStatus(null, trigger.oldMap, trigger.isDelete, trigger.isInsert, trigger.isUndelete, trigger.isUpdate);
		}
		
		if (trigger.isInsert) {
			BillingLineService.blsCaseBillingStatus(trigger.new, null, trigger.isDelete, trigger.isInsert, trigger.isUndelete, trigger.isUpdate);
		}
		
		if (trigger.isUndelete) {
			BillingLineService.blsCaseBillingStatus(trigger.new, null, trigger.isDelete, trigger.isInsert, trigger.isUndelete, trigger.isUpdate);
		}
		
		if (trigger.isUpdate) {
			BillingLineService.blsCaseBillingStatus(trigger.new, trigger.oldMap, trigger.isDelete, trigger.isInsert, trigger.isUndelete, trigger.isUpdate);
		}
	}
}