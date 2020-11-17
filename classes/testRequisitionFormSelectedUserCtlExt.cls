@isTest(seeAllData=true)
private class testRequisitionFormSelectedUserCtlExt {
	
	/*
	 *	Methods for testing class file RequisitionFormSelectedUserCtlExt
	 *
	 */
	 
	static testMethod void rfsuTest1() {
		
		SFDC_Purchase_Requisition__c reqForm = new SFDC_Purchase_Requisition__c();
		insert reqForm;
		
		ApexPages.StandardController std = new ApexPages.StandardController(reqForm);
		ApexPages.currentPage().getParameters().put('Id', reqForm.Id);
		RequisitionFormSelectedUserCtlExt ctl = new RequisitionFormSelectedUserCtlExt(std);
		
		List<User> userList = new List<User>();
		userList = [select Id, Name, Email from User where UserType = 'Standard' and (Name = 'Emily Tam' or Name = 'SFDC Developer')];
		system.assertEquals(2, userList.size());
		
		ctl.selectedUsers.add(new SelectOption(userList[0].Id, userList[0].Name));
		ctl.selectedUsers.add(new SelectOption(userList[1].Id, userList[1].Name));
		
		ctl.save();
		
		reqForm = [select Id, Approval_Email_1__c, Approval_Email_2__c, Approval_Email_3__c, Approval_Email_4__c, Selected_Users__c 
				from SFDC_Purchase_Requisition__c where Id = :reqForm.Id];
		system.assertEquals(userList[0].Email, reqForm.Approval_Email_1__c);
		system.assertEquals(userList[1].Email, reqForm.Approval_Email_2__c);
		system.assertEquals(null, reqForm.Approval_Email_3__c);
		system.assertEquals(null, reqForm.Approval_Email_4__c);
		system.assert(String.isNotBlank(reqForm.Selected_Users__c));
		
		ApexPages.StandardController std1 = new ApexPages.StandardController(reqForm);
		ApexPages.currentPage().getParameters().put('Id', reqForm.Id);
		RequisitionFormSelectedUserCtlExt ctl1 = new RequisitionFormSelectedUserCtlExt(std1);
		system.assertEquals(2, ctl1.selectedUsers.size());
	}
}