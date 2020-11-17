@isTest
private class Test_Opportunity_SiteControllerExt {

	static testMethod void testOpp_SiteControllerExt() {
		
		List<RecordType> rtList = new List<RecordType>();
		rtList = [select Id, DeveloperName from RecordType where SobjectType = 'Opportunity' and (DeveloperName = 'Offtaker' or DeveloperName = 'DevelopmentSite')];
		Id rtOffId;
		Id rtDevId;
		for (RecordType rt :rtList) {
			if (rt.DeveloperName == 'OffTaker') {
				rtOffId = rt.Id;
			}
			if (rt.DeveloperName == 'DevelopmentSite') {
				rtDevId = rt.Id;
			}
		}
		
		List<Opportunity> opp = new List<Opportunity>();
		opp.add(new Opportunity(OwnerId = TestMethods.getUserList()[0].Id, Name = 'Knight - 2456',AccountId = TestMethods.getAccount().Id,Type = 'Turnkey System', CloseDate = System.today(),StageName = 'Prospecting', RecordTypeId = rtOffId, Current_Project_System_Size__c = 1000));
		opp.add(new Opportunity(OwnerId = TestMethods.getUserList()[0].Id, Name = 'Knight - 2457',AccountId = TestMethods.getAccount().Id,Type = 'Turnkey System', CloseDate = System.today(),StageName = 'Prospecting', RecordTypeId = rtDevId, Current_Project_System_Size__c = 1000,Vertical__c ='a382H000001u77B',Original_Contract_System_Size__c=100));
		insert opp;
		
		opp[1].Offtaker_Opportunity__c = opp[0].Id;
		update opp[1];
		
		List<Site__c> sList = new List<Site__c>();
		sList.add(new Site__c(
			Name = '123 Main Street',
			Opportunity__c = opp[1].Id)
		);
		sList.add(new Site__c(
			Name = '456 Main Street',
			Opportunity__c = opp[1].Id)
		);
		insert sList;
		
		//Instantiate a new controller
		ApexPages.StandardController std = new ApexPages.StandardController(opp[0]);
		Opportunity_SiteControllerExt ctl = new Opportunity_SiteControllerExt(std);
	}
}