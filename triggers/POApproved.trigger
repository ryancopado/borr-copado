trigger POApproved on AcctSeedERP__Purchase_Order__c (after update) {
    
    List<Id> polPOIds = new List<Id>();
    List<Id> coPOIds = new List<Id>();
    
	for (integer i=0;i<trigger.new.size();i++) {
		if (trigger.new[i].AcctSeedERP__Status__c != trigger.old[i].AcctSeedERP__Status__c) {
			polPOIds.add(trigger.new[i].Id);
		}
        if (trigger.new[i].Change_Order_Total__c != trigger.old[i].Change_Order_Total__c) {
        	coPOIds.add(trigger.new[i].Id);
        }
    }
    
    if (!polPOIds.isEmpty()) {
		List<AcctSeedERP__Purchase_Order_Line__c> records = [select Id, POLine_Total__c, AcctSeedERP__Project_Task__c from AcctSeedERP__Purchase_Order_Line__c where AcctSeedERP__Purchase_Order__c in:polPOIds];
		
		//Fields to roll up for all PurchaseOrderLines
		list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
			new list<RollUpSummaryUtility.fieldDefinition> {
				new RollUpSummaryUtility.fieldDefinition('SUM', 'POLine_Total__c', 'Roll_Up_Purchase_Order_Line_Totals__c')
			};
         
		if (!records.isEmpty()) { 
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeedERP__Purchase_Order_Line__c', 'AcctSeedERP__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c != \'Cancelled\' and AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c != \'Rejected\'');
		}
    }
	
	if (!coPOIds.isEmpty()) {
		// Update the Prior Change Order field of the associated Change Order records
		List<Con_Req__c> coList = new List<Con_Req__c>();
		List<Con_Req__c> coUpList = new List<Con_Req__c>();
		coList = [select Id, Prior_Change_Orders_SUB_MAT__c, Purchase_Order2__c, Status__c from Con_Req__c where Purchase_Order2__c in :coPOIds];
		for (Con_Req__c co :coList) {
			if (co.Status__c != 'Borrego Approved' && co.Status__c != 'Approved By Customer') {
				co.Prior_Change_Orders_SUB_MAT__c = trigger.newMap.get(co.Purchase_Order2__c).Change_Order_Total__c;
				coUpList.add(co);
			}
		}
		if (!coUpList.isEmpty()) {
			update coUpList;
		}
	}
}