public with sharing class RequisitionFormSelectedUserCtlExt {
	
	public SFDC_Purchase_Requisition__c reqList1 {get; set;}
	public List<SelectOption> selectedUsers {get; set;}
    public List<SelectOption> allUsers {get; set;}
	
	public RequisitionFormSelectedUserCtlExt (ApexPages.StandardController controller) {
	
		List<SFDC_Purchase_Requisition__c> reqList = new List<SFDC_Purchase_Requisition__c>();
		reqList = [select Id, Approval_Email_1__c, Approval_Email_2__c, Approval_Email_3__c, Approval_Email_4__c, Selected_Users__c 
				from SFDC_Purchase_Requisition__c where Id = :ApexPages.currentPage().getParameters().get('Id')];
		
		reqList1 = null;
		if (!reqList.isEmpty()) {
			reqList1 = reqList[0];
		}
		
		selectedUsers = new List<SelectOption>();
		allUsers = new List<SelectOption>();
		
		List<User> userList = new List<User>();
		userList = [select Id, Name, Email from User where isActive = true order by Name];
		
		for (User u :userList) {
			String strSelectedUsers = reqList1.Selected_Users__c;
			if (String.isNotBlank(strSelectedUsers)) {
				if (strSelectedUsers.contains(u.Id)) {
					selectedUsers.add(new SelectOption(u.Id, u.Name));
				} else {
					allUsers.add(new SelectOption(u.Id, u.Name));
				}
			} else {
				allUsers.add(new SelectOption(u.Id, u.Name));
			}
		}
	}
	
	// Save the selected user's email address in the approval email fields
	public PageReference save() {
		Set<Id> uIds = new Set<Id>();
		List<User> uList = new List<User>();
		String strSelectedOptions = '';
		PageReference pr = null;
		
		if (selectedUsers.size() <= 4) {
			reqList1.Approval_Email_1__c = null;
			reqList1.Approval_Email_2__c = null;
			reqList1.Approval_Email_3__c = null;
			reqList1.Approval_Email_4__c = null;
			
			for (SelectOption so: selectedUsers) {
				if (strSelectedOptions == '') {
					strSelectedOptions += so.getValue();
				} else {
					strSelectedOptions += ',' + so.getValue();
				}
				uIds.add(so.getValue());
			}
			
			reqList1.Selected_Users__c = strSelectedOptions;
			uList = [select Id, Email from User where Id in :uIds];
			for (Integer i=0; i<uList.size(); i++) {
				if (i == 0) {
					reqList1.Approval_Email_1__c = uList[i].Email;
				}
				if (i == 1) {
					reqList1.Approval_Email_2__c = uList[i].Email;
				}
				if (i == 2) {
					reqList1.Approval_Email_3__c = uList[i].Email;
				}
				if (i == 3) {
					reqList1.Approval_Email_4__c = uList[i].Email;
				}
			}
			
			try {
				update reqList1;
			} catch(Exception e) {
				Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, 'Requisition Form save exception: ' + e.getMessage()));
			}
		} else {
			Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, 'Only 4 users may be selected.'));
		}
		
		return pr;
	}
}