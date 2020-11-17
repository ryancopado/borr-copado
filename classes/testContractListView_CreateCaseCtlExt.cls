@isTest
private class testContractListView_CreateCaseCtlExt {
	
	/*
	 *	Test methods for Asset_ServiceVisitCtlExt
	 *
	 */
	
	// Create test data
	@testSetup static void csvTestData() {
		
		Account acc = new Account(Name = 'csvAccount');
    	insert acc;
    	
    	Contract cntrct = new Contract(Name = 'csvContract', AccountId = acc.Id, Type__c = 'O&M');
    	insert cntrct;
	}
	
	static testMethod void clvTest1() {
		
		List<Contract> cntrctList = new List<Contract>();
		ApexPages.StandardSetController stdSet = new ApexPages.StandardSetController(cntrctList);
		ContractListView_CreateCaseCtlExt ctl = new ContractListView_CreateCaseCtlExt(stdSet);
		ctl.createCase();
		
		cntrctList = [select Id from Contract];
		stdSet = new ApexPages.StandardSetController(cntrctList);
		stdSet.setSelected(cntrctList);
		ctl = new ContractListView_CreateCaseCtlExt(stdSet);
		ctl.createCase();
	}
}