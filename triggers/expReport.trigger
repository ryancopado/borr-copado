trigger expReport on ER__c (before update, after update, before insert) {
	RecordType proj = [select Id from RecordType where Name = 'Project Expense'];
	if(Trigger.isBefore){
		List<ER__c> upMan = new List<ER__c>();
		for (Integer i = 0; i <Trigger.new.size(); i++) {
			if(Trigger.isUpdate){
			   	if((Trigger.new[i].Status__c == 'Approved' && Trigger.old[i].Status__c != 'Approved')){
					ELI__c[] elis = [select Id from ELI__c where Expense_Header__c = :Trigger.new[i].Id 
										and PV_Direct__c != true and Manager_Approval__c = true 
										and RecordTypeId = :proj.Id];
					if(elis.size() > 0){
						expReport.createBLI(elis);
					}
				}
				if(Trigger.new[i].User__c != Trigger.old[i].User__c){
					upMan.add(Trigger.new[i]);
				}
			}
			if(Trigger.isInsert){
				upMan.add(Trigger.new[i]);
			}
		}
		if(upMan.size() > 0){
			expReport.addManager(upMan);
		}
	}
	if(Trigger.isAfter) {
		for (Integer i = 0; i <Trigger.new.size(); i++) {
		   	if((Trigger.new[i].Status__c == 'Approved' && Trigger.old[i].Status__c != 'Approved')){
				ELI__c[] elis = [select Id, Project__c, Chargeback__c, Approved_Amount__c, Invoice__c from ELI__c 
									where Expense_Header__c = :Trigger.new[i].Id and PV_Direct__c = true 
									and Manager_Approval__c = true];
				if(elis.size() > 0){
					pvTotals.toInvoiceELI(elis);
		   		}
			}
		}
	}
}