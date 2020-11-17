trigger invoicePaid on Invoices__c (after update) {
	List<Invoices__c> inv = new List<Invoices__c>();
	List<Invoices__c> invP = new List<Invoices__c>();
	for(Integer i = 0; i <Trigger.new.size(); i++) {
		if(Trigger.new[i].Status__c == 'Paid' && Trigger.old[i].Status__c != 'Paid'){
			inv.add(Trigger.new[i]);
		}
		if(Trigger.new[i].Status__c == 'Approved' && Trigger.old[i].Status__c != 'Approved'){
			invP.add(Trigger.new[i]);
		}
	}
	if(inv.size() > 0){
		pvTotals.invoiced(inv); 
	}
	if(invP.size() > 0){
		pvTotals.approved(invP); 
	}
}