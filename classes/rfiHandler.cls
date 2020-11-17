public class rfiHandler {
	
	
	
	//takes a list of rfis and a list of project Ids. We get the related projects and put their owner ids into the 
	//rfi pm field.
	
	public static void setPM (List<Id> projectIds, Map<Id, Request_for_Information_RFI__c> rfisById, Boolean isAfter){
		
		List<Request_for_Information_RFI__c> rfisToUpdate = new List<Request_for_Information_RFI__c>{};
		
		Map<Id,AcctSeed__Project__c> relatedProjects = new Map<Id,AcctSeed__Project__c>([SELECT Id, OwnerId
																	FROM AcctSeed__Project__c 
																	WHERE Id IN :projectIds]);
											
		for (Request_for_Information_RFI__c currentRfi : rfisById.values()) {
			//get map id
			Id currentProjectId = rfisById.get(currentRfi.Id).ASProject__c;
			if( relatedProjects.containskey(currentProjectId)){
				currentRfi.Project_PM__c = relatedProjects.get(currentProjectId).OwnerId;
			}
			rfisToUpdate.add(currentRfi);
		}

		if (isAfter){
			update rfisToUpdate;
		}

	}
	
	public static testmethod void rfiHandlerTest() {
		
		Request_for_Information_RFI__c testRfi = TestMethods.getRfi();
		AcctSeed__Project__c testProject = TestMethods.getProjectList()[0]; 
		
		testRfi.ASProject__c = testProject.Id;
		update testRfi;
		
				
		Attachment testAttachment = TestMethods.getAttachment();
		update testAttachment;
		
		List<Id> projId = new List<Id>{testProject.Id};
		Map<Id, Request_for_Information_RFI__c> rfiMap =  new Map<Id, Request_for_Information_RFI__c>();
		rfiMap.put(testRfi.Id, testRfi);
		
		setPM ( projId, rfiMap, true);

		
		
		
		//System.assertEquals(testProject.OwnerId, testRfi.Project_PM__c);
		
	}
}