@isTest
private class testCase_SVTechnicianCtlExt {
	
	/*
	 *	Test methods for Case_SVTechnicianCtlExt
	 *
	 */
	
	// Create test data
	@testSetup static void csvtTestData() {
		
    	Account acc = new Account(Name = 'csvtAccount');
    	insert acc;
    	
    	Contact con = new Contact(LastName = 'csvtContact', AccountId = acc.Id);
    	insert con;
    	
    	Contract cntrct = new Contract(Name = 'asvContract', AccountId = acc.Id, Type__c = 'O&M');
    	insert cntrct;
    	
    	Case cs = new Case(AccountId = acc.Id, ServiceContract_Case__c = cntrct.Id);
    	insert cs;
    	
    	List<SV__c> svList = new List<SV__c>();
    	svList.add(new SV__c(Account__c = acc.Id, Contract__c = cntrct.Id, Technician__c = null, Case__c = cs.Id));
    	svList.add(new SV__c(Account__c = acc.Id, Contract__c = cntrct.Id, Technician__c = con.Id, Case__c = cs.Id));
    	svList.add(new SV__c(Account__c = acc.Id, Contract__c = cntrct.Id, Technician__c = con.Id, Case__c = cs.Id));
    	insert svList;
	}
	
    static testMethod void csvtTest1() {
		
		List<SV__c> svList = new List<SV__c>();
		ApexPages.StandardSetController stdSet = new ApexPages.StandardSetController(svList);
		Case_SVTechnicianCtlExt ctl = new Case_SVTechnicianCtlExt(stdSet);
		
		svList = [select Id, Technician__c from SV__c];
		stdSet = new ApexPages.StandardSetController(svList);
		stdSet.setSelected(svList);
		ctl = new Case_SVTechnicianCtlExt(stdSet);
		ctl.saveServiceVisits();
    }
}