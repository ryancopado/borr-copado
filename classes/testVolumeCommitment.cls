@isTest
private class testVolumeCommitment {
	
	/*
	 *	Test methods for class files and triggers working with the Volume Commitment object.
	 *
	 */
	
	static testMethod void vcTest1() {
		
		List<Account> aList = new List<Account>();
		aList.add(new Account(
			Name = 'testtesttestVC',
			Branch__c = 'Nor Cal',
			Phone = '555-555-55555',
			Small_Business_Type__c = 'Small Business',
			Type = 'Other',
			AcctSeed__Accounting_Type__c = 'Vendor',
			RecordTypeId = '012800000007h2p',
			ShippingCity = 'San Francisco')
		);
		insert aList;
		
		system.debug('***** Accounting Type = ' + alist[0].AcctSeed__Accounting_Type__c);
		
		List<Terms_Conditions__c> tcList = new List<Terms_Conditions__c>();
		tcList.add(new Terms_Conditions__c(
			Name = 'testtesttestVC',
			Account__c = aList[0].Id)
		);
		insert tcList;
		
		List<Volume_Commitment__c> vcList = new List<Volume_Commitment__c>();
		vcList.add(new Volume_Commitment__c(
			Name = 'testtesttestVC',
			Year_Quarter__c = '2015-Q2',
			Terms_Conditions__c = tcList[0].Id,
			Status__c = 'Active')
		);
		insert vcList;
	}
}