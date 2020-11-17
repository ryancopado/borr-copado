trigger UserTrigger on User (after update, before insert, before update) {
	
	if (trigger.isBefore) {
		if (trigger.isInsert) {
			UserService.asvFields(trigger.new, null, trigger.isInsert);
		}
		
		if (trigger.isUpdate) {
			UserService.changeRate(trigger.new, trigger.oldMap);
			UserService.asvFields(trigger.new, trigger.oldMap, trigger.isInsert);
		}
	}
	
	if (trigger.isAfter) {
		if (trigger.isInsert) {
			
		}
		
		if (trigger.isUpdate) {
			UserService.recalculateTERates(trigger.new, trigger.oldMap);
		}
	}
}