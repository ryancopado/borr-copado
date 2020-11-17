trigger TestReportTrigger on Test_Report__c (before insert) {
	
	if (trigger.isBefore) {
		
		if (trigger.isInsert) {
			TestReportService.setFieldsOnCreate(trigger.new);
		}
	}
}