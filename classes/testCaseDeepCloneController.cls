@isTest
private class testCaseDeepCloneController {
	
	/*
	 *	Test class for CaseDeepCloneController
	 *
	 */
	
    static testMethod void cdcTest1() {
        
        // Create user record to work around SFDC Flow Trigger bug
        /*
        User testUser = new User(
        	LastName = 'jimbobtesttest',
        	Alias = 'jbtsttst',
        	Email = 'jimbobtesttest=borregosolar.com@example.com',
        	UserName = 'jimbobtesttest@borregosolar.com',
        	CommunityNickname = 'jimbobtesttest',
        	ProfileId = '00e30000000iBpb',
        	UserRoleId = '00E8000000160sy',
        	EmailEncodingKey = 'UTF-8',
        	LanguageLocaleKey = 'English'
        );
        */
        /*
		Profile p = [SELECT Id FROM Profile WHERE Name='Sys Admin w/o HR'];
		User testUser = new User(Alias = 'jbtsttst', Email='jimbobtesttest=borregosolar.com@example.com',
			EmailEncodingKey='UTF-8', LastName='jimbobtesttest', LanguageLocaleKey='en_US',
			LocaleSidKey='en_US', ProfileId = p.Id,
			TimeZoneSidKey='America/Los_Angeles', UserName='jimbobtesttest@borregosolar.com');

        //insert testUser;
        system.runAs(testUser) {
        */
        // Create test data
        Case caseToClone = new Case(
        	Status = 'New',
        	Date_Maintenance_Completed__c = system.today()
        );
        insert caseToClone;
        
        List<Component__c> compListToClone = new List<Component__c>();
        compListToClone.add(new Component__c(
        	Case__c = caseToClone.Id,
        	Summary__c = 'This is a test1')
        );
        compListToClone.add(new Component__c(
        	Case__c = caseToClone.Id,
        	Summary__c = 'This is a test2')
        );
        insert compListToClone;
        
        List<Maintenance_Item__c> maintListToClone = new List<Maintenance_Item__c>();
        maintListToClone.add(new Maintenance_Item__c(
        	Component__c = compListToClone[0].Id,
        	Completed__c = true)
        );
        maintListToClone.add(new Maintenance_Item__c(
        	Component__c = compListToClone[0].Id,
        	Completed__c = true)
        );
        maintListToClone.add(new Maintenance_Item__c(
        	Component__c = compListToClone[1].Id,
        	Completed__c = true)
        );
        insert maintListToClone;
		
        // Instantiate a new controller
		ApexPages.StandardController std = new ApexPages.StandardController(caseToClone);
		CaseDeepCloneController ctl = new CaseDeepCloneController(std);
		
		// Execute deep clone and verify results
		ctl.caseDeepClone();
		
		List<Case> caseCloneList = new List<Case>();
		List<Component__c> compCloneList = new List<Component__c>();
		List<Maintenance_Item__c> maintCloneList = new List<Maintenance_Item__c>();
		
		caseCloneList = [select Id, Date_Maintenance_Completed__c from Case where Id != :caseToClone.Id];
		system.assertEquals(1, caseCloneList.size());
		system.assertEquals(null, caseCloneList[0].Date_Maintenance_Completed__c);
		
		compCloneList = [select Id, Case__c, Summary__c from Component__c where Case__c = :caseCloneList[0].Id];
		system.assertEquals(2, compCloneList.size());
		system.assertEquals(true, String.isBlank(compCloneList[0].Summary__c));
		system.assertEquals(true, String.isBlank(compCloneList[1].Summary__c));
		
		maintCloneList = [select Id, Completed__c from Maintenance_Item__c where Component__c = :compCloneList[0].Id or Component__c = :compCloneList[1].Id];
		system.assertEquals(3, maintCloneList.size());
		system.assertEquals(false, maintCloneList[0].Completed__c);
		system.assertEquals(false, maintCloneList[1].Completed__c);
		system.assertEquals(false, maintCloneList[2].Completed__c);
        //}
    }
}