@isTest
private class testCaseSiteController {
	
	/*
	 *	Test methods for CaseSiteController.
	 */

    static testMethod void cscTest1() {
		
		// Create test data
		Account acc = new Account(Name = 'billybob - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
					Project_End_Date__c = null, ShippingStreet = 'Main Street', ShippingCity = 'San Francisco');
		insert acc;
		
		//Asset ass = new Asset(AccountId = acc.Id, Name = 'DAS 1');
		//insert ass;
		
		AcctSeed__Project__c proj = new AcctSeed__Project__c(Name = 'billybob - 2456', AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
					Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
					Job_Number__c = '000-000');
		insert proj;
		
		/*
		Site__c projSite = new Site__c(Name = 'billybob site 1', Project__c = proj.Id);
		insert projSite;
		*/
		
		Map<String, Schema.RecordTypeInfo> rtMap = Schema.SobjectType.Case.getRecordTypeInfosByName();
		Id caseRtId = rtMap.get('Reactive').getRecordTypeId();
		
		Case testCase = new Case(Status = 'New', AccountId = acc.Id, RecordTypeId = caseRtId);
        insert testCase;
		
		// Start our test by instantiating a new controller
		ApexPages.StandardController std = new ApexPages.StandardController(testCase);
		CaseSiteController ctl = new CaseSiteController(std);
		ctl.saveRecordType();
		
		ApexPages.currentPage().getParameters().put('caseId', testCase.Id);
		ApexPages.currentPage().getParameters().put('accountId', acc.Id);
		ApexPages.currentPage().getParameters().put('RecordType', caseRtId);
		std = new ApexPages.StandardController(testCase);
		ctl = new CaseSiteController(std);
		
		/*
		List<SelectOption> siteOptions = ctl.getSiteOptions();
		ctl.setselectedSite(projSite.Id);
		String siteId = ctl.getselectedSite();
		*/
		List<SelectOption> projOptions = ctl.getProjectOptions();
		ctl.setselectedProject(proj.Id);
		String projId = ctl.getselectedProject();
		//List<SelectOption> assetOptions = ctl.getAssetOptions();
		//ctl.setselectedAsset('--None--');
		//String assetId = ctl.getselectedAsset();
		//ctl.saveSite();
		ctl.saveProject();
		ctl.changeAccount();
		/*
		ctl.changeSite();
		ctl.cancelSite();
		*/
		ctl.changeProject();
		ctl.cancelProject();
	}
}