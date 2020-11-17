trigger ProjectTrigger on AcctSeed__Project__c (after insert, after update, before insert, before update) {
	
	if (trigger.isBefore) {
		
		if (trigger.isInsert) {
			TriggerStopper.insertProjectTrigger = true;
			
			ProjectService.projectBefore(trigger.new, null, trigger.isInsert);
			
			//ProjectService.createProjects(trigger.new, null, trigger.isInsert);
			//ProjectService.OMProjectFromSite(trigger.new, null, trigger.isInsert);
			//ProjectService.OMProjectFromContract(trigger.new, null, trigger.isInsert);
		}
		
		if (trigger.isUpdate) {
            ProjectCreate.isUpdate = trigger.isUpdate;
            ProjectCreate.oldMap = trigger.oldMap;
            ProjectService.projectBefore(trigger.new, trigger.oldMap, trigger.isInsert);
			
			//ProjectService.createProjects(trigger.new, trigger.oldMap, trigger.isInsert);
			
			// START : Added By Madan - Dec 1, 2017(only change Job Number if only Sales Segment changed FROM/TO ESD)
			//ProjectCreate.isUpdate = trigger.isUpdate;
			//ProjectCreate.oldMap = trigger.oldMap;
			// END : Added By Madan - Dec 1, 2017(only change Job Number if only Sales Segment changed FROM/TO ESD)
    		// ---------------------------------------------
			
			//ProjectService.jobNumber(trigger.new, trigger.oldMap);
			//ProjectService.OMProjectFromSite(trigger.new, trigger.oldMap, trigger.isInsert);
			//ProjectService.OMProjectFromContract(trigger.new, trigger.oldMap, trigger.isInsert);
		}
	}
	
	if (trigger.isAfter) {
		
		if (trigger.isInsert) {
			ProjectService.projectAfter(trigger.newMap, null, trigger.isInsert);
			
			//ProjectService.createRelatedRecords(trigger.new, null, trigger.isInsert);
			ProjectService.createServiceContract(trigger.new, null, trigger.isInsert);
		}
		
        if (trigger.isUpdate) {
            if (!TriggerStopper.stopProjectTrigger) {
                
                ProjectService.projectAfter(trigger.newMap, trigger.oldMap, trigger.isInsert);
                
                //ProjectService.createRelatedRecords(trigger.new, trigger.oldMap, trigger.isInsert);
                ProjectService.createServiceContract(trigger.new, trigger.oldMap, trigger.isInsert);
                ProjectService.ProjectToAsset(trigger.newMap, trigger.oldMap);
                //ProjectService.pmLockChange(trigger.new, trigger.oldMap);
                
                TriggerStopper.stopProjectTrigger = (TriggerStopper.insertProjectTrigger) ? false: true;
            }
        }
    }
}