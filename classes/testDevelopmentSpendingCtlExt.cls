@isTest
private class testDevelopmentSpendingCtlExt {
	
	/*
	 * Test methods for testing classes and triggers related to the Development Spending object. 
	 */
	
	static testMethod void testDevSpending() {
		
		List<Development_Spending__c> dsList = new List<Development_Spending__c>();
		dsList.add(new Development_Spending__c(
			Requested_Amount__c = 1000,
			Approved__c = true)
		);
		dsList.add(new Development_Spending__c(
			Requested_Amount__c = 2000,
			Approved__c = false)
		);
		dsList.add(new Development_Spending__c(
			Requested_Amount__c = 3000,
			Approved__c = false)
		);
		insert dsList;
		
		PageReference pageRef = Page.DevelopmentSpending_Approve;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('retURL', dsList[0].Id);
		
		ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(dsList);
		DevelopmentSpendingCtlExt dsctl = new DevelopmentSpendingCtlExt(ssc);
		dsctl.approveDevSpending();
		
		ApexPages.StandardSetController ssc1 = new ApexPages.StandardSetController(dsList);
		List<Development_Spending__c> dsApproved = new List<Development_Spending__c>();
		dsApproved.add(dsList[0]);
		ssc1.setSelected(dsApproved);
		DevelopmentSpendingCtlExt dsctl1 = new DevelopmentSpendingCtlExt(ssc1);
		dsctl1.approveDevSpending();
		
		ApexPages.StandardSetController ssc2 = new ApexPages.StandardSetController(dsList);
		List<Development_Spending__c> dsUnapproved = new List<Development_Spending__c>();
		dsUnapproved.add(dsList[1]);
		dsUnapproved.add(dsList[2]);
		ssc2.setSelected(dsUnapproved);
		DevelopmentSpendingCtlExt dsctl2 = new DevelopmentSpendingCtlExt(ssc2);
		dsctl2.approveDevSpending();
	}
}