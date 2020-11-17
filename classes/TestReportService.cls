public class TestReportService {
	
	/*
	 *	Service methods for TestReportTrigger.trigger
	 *
	 */
	
	// Set various fields on Test Report records upon insert
	// - before insert
	public static void setFieldsOnCreate(List<Test_Report__c> newList) {
		Set<Id> itIds = new Set<Id>();
		
		for (Test_Report__c tr :newList) {
			if (tr.Issue_Tracker__c != null) {
				itIds.add(tr.Issue_Tracker__c);
			}
		}
		
		if (!itIds.isEmpty()) {
			Map<Id, Request_for_Information_RFI__c> itMap = new Map<Id, Request_for_Information_RFI__c>([select Id, Name, ASProject__c 
					from Request_for_Information_RFI__c where Id in :itIds]);
			
			for (Test_Report__c tr :newList) {
				if (itMap.containsKey(tr.Issue_Tracker__c)) {
					tr.Project__c = itMap.get(tr.Issue_Tracker__c).ASProject__c;
				}
			}
		}
	}
}