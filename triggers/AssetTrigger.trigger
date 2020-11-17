trigger AssetTrigger on Asset (before insert, before update) {
	
	if (trigger.isBefore) {
		if (trigger.isInsert) {
			AssetService.AssetFromProject(trigger.new, null, trigger.isInsert);
		}
		
		if (trigger.isUpdate) {
			AssetService.AssetFromProject(trigger.new, trigger.oldMap, trigger.isInsert);
		}
	}
}