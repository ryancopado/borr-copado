trigger bliDelete on Budget_Line_Item__c bulk(before delete) {
	
	List<Budget_Line_Item__c> blis = new List<Budget_Line_Item__c>(System.Trigger.old);
	List<Id> bliID = new List<Id>();
	Budget_Line_Item__c[] budg = [select Id from Budget_Line_Item__c where Id in :blis];
	for (Integer k = 0; k <budg.size(); k++) {
        	bliID.add(budg[k].Id);     
    }
    Map<Id,Id> bliReq = new Map<Id,Id>();
	Con_Req__c[] r = [select Budget_Line_Item__c from Con_Req__c where Budget_Line_Item__c in :bliID];
	for (Integer i = 0; i <r.size(); i++) {
        bliReq.put(r[i].Budget_Line_Item__c, r[i].Id);     
    }  
    for (Integer i = 0; i <Trigger.old.size(); i++) {
		if (bliReq.get(Trigger.old[i].Id) != null) {
	    	Trigger.old[i].addError('You cannot delete a Budget Line Item associated with a Construction Requisition.');
	    }
    } 
}