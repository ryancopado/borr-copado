trigger budgetDelete on Budget__c (before delete) {
	
//	Trigger.old[0].addError('You cannot delete a Budget whose Line Items are associated with a Construction Requisition.');
	
	List<Budget__c> budgets = new List<Budget__c>(System.Trigger.old);
	List<Id> bliID = new List<Id>();
	Map<Id,Id> budBli = new Map<Id,Id>();
	Budget_Line_Item__c[] blis = [select Id, Budget__c from Budget_Line_Item__c where Budget__c in :budgets];
	for (Integer k = 0; k <blis.size(); k++) {
        	bliID.add(blis[k].Id);
        	budBli.put(blis[k].Budget__c, blis[k].Id);     
    }
    Map<Id,Id> bliReq = new Map<Id,Id>();
	Con_Req__c[] r = [select Budget_Line_Item__c from Con_Req__c where Budget_Line_Item__c in :bliID];
	for (Integer i = 0; i <r.size(); i++) {
        bliReq.put(r[i].Budget_Line_Item__c, r[i].Id);     
    }  
    for (Integer i = 0; i <Trigger.old.size(); i++) {
		if (bliReq.get(budBli.get(Trigger.old[i].Id)) != null) {
	    	Trigger.old[i].addError('You cannot delete a Budget whose Line Items are associated with a Construction Requisition.');
	    }
    } 
}