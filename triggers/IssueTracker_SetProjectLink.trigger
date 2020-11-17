trigger IssueTracker_SetProjectLink on Request_for_Information_RFI__c (before insert, before update) {
	
	// Set the "Project Link" field to the same value as the "Project" field if the record type
	// is not "Specs and Submittals".  This is done to control what Issue Tracker records are shown on the
	// related list of the associated Project record.
	
	RecordType rt = [SELECT Id, Name FROM RecordType WHERE Name =: 'Specs and Submittals'];
	for (Request_for_Information_RFI__c it : trigger.new) {
		if (it.RecordTypeId != rt.Id) {
			it.Project_Link__c = it.ASProject__c;
		} else {
			it.Project_Link__c = NULL;
		}
	}

}