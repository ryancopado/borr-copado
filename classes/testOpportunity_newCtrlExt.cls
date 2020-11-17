@isTest
private class testOpportunity_newCtrlExt {
	
	/*
	 *	Methods to test Opportunity_newCtrlExt controller extension
	 *
	 */
	
    static testMethod void oppNewUnitTest1() {
		
		// Prepare test data
		Account acc = new Account(
			Name = 'oppNew TESTTEST'
		);
		insert acc;
		
		Map<String, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Opportunity.getRecordTypeInfosByName();
		
		Opportunity opp = new Opportunity();
		ApexPages.StandardController std = new ApexPages.StandardController(opp);
		ApexPages.currentPage().getParameters().put('retURL', acc.Id);
		ApexPages.currentPage().getParameters().put('RecordType', rtMap.get('Development').getRecordTypeId());
		ApexPages.currentPage().getParameters().put('accid', acc.Id);
		Opportunity_newCtrlExt ctl = new Opportunity_newCtrlExt(std);
		
		ctl.enforceOppName();
		ctl.createNewOpportunity();
		ctl.cancelNewOpportunity();
    }
}