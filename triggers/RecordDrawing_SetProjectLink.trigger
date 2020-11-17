trigger RecordDrawing_SetProjectLink on Record_Drawing_1__c (before insert, before update) {
	
	// Set the "Project Link" field to the same value as the "Project" field of the parent Issue Tracker record.
	// This is done so that these records will show up on the Project record associated with the Issue Tracker
	// record.
	
	List<Request_for_Information_RFI__c> itList = new List<Request_for_Information_RFI__c>();
	List<Id> itIds = new List<Id>();
	Map<Id, Request_for_Information_RFI__c> itMap = new Map<Id, Request_for_Information_RFI__c>();
	
	for (Record_Drawing_1__c rd :trigger.new) {
		itIds.add(rd.Issue_Tracker__c);
	}
	itList = [SELECT Id, ASProject__c FROM Request_for_Information_RFI__c WHERE Id IN: itIds];
	for (Request_for_Information_RFI__c it : itList) {
		itMap.put(it.Id, it);
	}
	for (Record_Drawing_1__c rd :trigger.new) {
		rd.Project_Link__c = itMap.get(rd.Issue_Tracker__c).ASProject__c;
	}
}