/**
 * This class contains methods to test triggers and class files that are related to
 * the objects Proposal Request and Proposal Task.
 */
@isTest
private class testProposalRequest {

    static testMethod void testProposalTaskTrigger() {
    	
    	Account prAccount;
    	Opportunity prOpportunity;
    	Proposal_Request__c proposalRequest;
    	Proposal_Tasks__c proposalTask;
    	
    	// Create test data
    	prAccount = TestMethods.getAccount();
    	prOpportunity = TestMethods.getOpportunity();
    	proposalRequest = new Proposal_Request__c(
    		Opportunity__c = prOpportunity.Id,
    		Sales_Associate_Responsible__c = 'Other',
    		Project_State__c = 'California',
    		RFP_Location__c = 'Not Applicable',
    		Due_Date__c = system.now(),
    		Status__c = 'New'
    	);
    	insert proposalRequest;
    	
    	proposalTask = new Proposal_Tasks__c(
    		Proposal_Request__c = proposalRequest.Id,
    		Person_Responsible__c = UserInfo.getUserId()
    	);
    	insert proposalTask;
    	proposalRequest.Status__c = 'Draft Posted';
    	update proposalRequest;
    }
}