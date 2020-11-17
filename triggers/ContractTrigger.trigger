trigger ContractTrigger on Contract (after update) {
	
	if (trigger.isAfter) {
		
		if (trigger.isUpdate) {
			
			ContractService.contractToCase(trigger.newMap, trigger.oldMap);
			
		}
	}
}