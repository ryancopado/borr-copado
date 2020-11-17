trigger SalesOrderLine_After on AcctSeedERP__Sales_Order_Line__c (after delete, after insert, after undelete, after update) {
	
	/*
	 *	Update the Not To Exceed field of the associated Purchase Orders based upon changes to the
	 *	Not To Exceed field on the Construction Requisition (Sales Order Line).
	 *
	 *	If the Category field on Construction Requisition has changed, recalculate the value of
	 *	the Category field on the associated Con Req Group record.
	 *
	 *	If the Cost Code Number field on Construction Requisition has changed, recalculate the value of
	 *	the Cost Code Number field on the associated Con Req Group record.
	 *
	 *	If Tax Category or Service Visit has changed, set Billing Status on cases related to the related Service Visit records.
	 *
	 */
	
	// Update the Not To Exceed field of associated Purchase Orders based upon changes to the Not To Exceed
	// field on the Construction Requisition (Sales Order Line)
	List<AcctSeedERP__Sales_Order_Line__c> solNTEList = new List<AcctSeedERP__Sales_Order_Line__c>();
	List<Id> polIds = new List<Id>();
	List<AcctSeedERP__Purchase_Order_Line__c> polList = new List<AcctSeedERP__Purchase_Order_Line__c> ();
	Map<Id, AcctSeedERP__Purchase_Order_Line__c> polMap = new Map<Id, AcctSeedERP__Purchase_Order_Line__c> ();
	List<Id> poIds = new List<Id>();
	List<AcctSeedERP__Purchase_Order__c> poList = new List<AcctSeedERP__Purchase_Order__c> ();
	Map<Id, AcctSeedERP__Purchase_Order__c> poMap = new Map<Id, AcctSeedERP__Purchase_Order__c> ();
	
	if (trigger.isDelete) {
		for (AcctSeedERP__Sales_Order_Line__c sol : trigger.old) {
			if (sol.Not_To_Exceed__c == 'Yes') {
				solNTEList.add(sol);
			}
		}
	}
	if (trigger.isInsert) {
		for (AcctSeedERP__Sales_Order_Line__c sol : trigger.new) {
			if (sol.Not_To_Exceed__c == 'Yes') {
				solNTEList.add(sol);
			}
		}
	}
	if (trigger.isUpdate) {
		for (AcctSeedERP__Sales_Order_Line__c sol : trigger.new) {
			if (sol.Not_To_Exceed__c != trigger.oldMap.get(sol.Id).Not_To_Exceed__c) {
				solNTEList.add(sol);
			}
		}
	}
	
	// Get the set of associated Purchase Order Lines and Purchase Orders for those Sales Order Lines that 
	// have changed in such a way that the Purchase Order field Not To Exceed may need to change
	for (AcctSeedERP__Sales_Order_Line__c sol : solNTEList) {
		if (sol.AcctSeedERP__Purchase_Order_Line__c != null) {
			polIds.add(sol.AcctSeedERP__Purchase_Order_Line__c);
		}
	}
	if (!polIds.isEmpty()) {
		polList = [select Id, AcctSeedERP__Purchase_Order__c from AcctSeedERP__Purchase_Order_Line__c where Id in: polIds];
		for (AcctSeedERP__Purchase_Order_Line__c pol : polList) {
			polMap.put(pol.Id, pol);
			poIds.add(pol.AcctSeedERP__Purchase_Order__c);
		}
		poList = [select Id, Not_To_Exceed__c from AcctSeedERP__Purchase_Order__c where Id in: poIds];
		for (AcctSeedERP__Purchase_Order__c po : poList) {
			poMap.put(po.Id, po);
			po.Not_To_Exceed__c = 'No';
		}
		
		// Get all of the Sales Order Lines associated with our Purchase Order Lines/Purchase Orders
		solNTEList.clear();
		solNTEList = [select Id, Not_To_Exceed__c, AcctSeedERP__Purchase_Order_Line__c 
					from AcctSeedERP__Sales_Order_Line__c where AcctSeedERP__Purchase_Order_Line__c in: polIds];
		
		// Set the Not To Exceed field to 'Yes' if any of the associated Sales Order Lines have field Not To Exceed set to 'Yes'
		for (AcctSeedERP__Sales_Order_Line__c sol : solNTEList) {
			if (sol.Not_To_Exceed__c == 'Yes') {
				poMap.get(polMap.get(sol.AcctSeedERP__Purchase_Order_Line__c).AcctSeedERP__Purchase_Order__c).Not_To_Exceed__c = sol.Not_To_Exceed__c;
			}
		}
		update poMap.values();
	}
	
	// Determine all the Con Req Group records that need to have the Category or Cost Code Number fields recalculated
	List<Id> crgIds = new List<Id>();
	if (trigger.isDelete) {
		for (AcctSeedERP__Sales_Order_Line__c sol : trigger.old) {
			if (sol.Con_Req_Group__c != null) {
				crgIds.add(sol.Con_Req_Group__c);
			}
		}
	}
	
	if (trigger.isInsert || trigger.isUpdate) {
		for (AcctSeedERP__Sales_Order_Line__c sol : trigger.new) {
			if (sol.Con_Req_Group__c != null) {
				if (trigger.isInsert) {
					crgIds.add(sol.Con_Req_Group__c);
				} else {
					if (sol.Category__c != trigger.oldMap.get(sol.Id).Category__c || sol.Cost_Code_Number__c != trigger.oldMap.get(sol.Id).Cost_Code_Number__c) {
						crgIds.add(sol.Con_Req_Group__c);
					}
				}
			}
		}
	}
	
	if (!crgIds.isEmpty()) {
		
		// Get all the Con Req Group records that need to have the Category or Cost Code Number fields recalculated and 
		// their associated Construction Requisition records
		List<Con_Req_Group__c> crgList = new List<Con_Req_Group__c>();
		List<AcctSeedERP__Sales_Order_Line__c> solCatList = new List<AcctSeedERP__Sales_Order_Line__c>();
		crgList = [select Id, Category__c, Cost_Code_Number__c from Con_Req_Group__c where Id in :crgIds];
		solCatList = [select Id, Category__c, Con_Req_Group__c, Cost_Code_Number__c from AcctSeedERP__Sales_Order_Line__c where Con_Req_Group__c in :crgIds];
		
		// Calculate the Category and Cost Code Number fields on the Con Req Group records
		for (Con_Req_Group__c crg :crgList) {
			crg.Category__c = '';
			crg.Cost_Code_Number__c = '';
			for (AcctSeedERP__Sales_Order_Line__c sol :solCatList) {
				if (sol.Con_Req_Group__c == crg.Id) {
					crg.Category__c += sol.Category__c + ';';
					crg.Cost_Code_Number__c += sol.Cost_Code_Number__c + ';';
				}
			}
			if (crg.Category__c != '') {
				crg.Category__c = crg.Category__c.removeEnd(';');
			}
			if (crg.Cost_Code_Number__c != '') {
				crg.Cost_Code_Number__c = crg.Cost_Code_Number__c.removeEnd(';');
			}
		}
		update crgList;
	}
	
	// If Tax Category or Service Visit has changed, set Billing Status on cases related to the related Service Visit records.
	Set<Id> svIds = new Set<Id>();
	if (trigger.isDelete) {
		for (AcctSeedERP__Sales_Order_Line__c sol : trigger.old) {
			if (sol.Service_Visit__c != null) {
				svIds.add(sol.Service_Visit__c);
			}
		}
	}
	
	if (trigger.isInsert || trigger.isUndelete) {
		for (AcctSeedERP__Sales_Order_Line__c sol : trigger.new) {
			if (sol.Service_Visit__c != null) {
				svIds.add(sol.Service_Visit__c);
			}
		}
	}
	
	if (trigger.isUpdate) {
		for (AcctSeedERP__Sales_Order_Line__c sol : trigger.new) {
			if (sol.Tax_Category__c != trigger.oldMap.get(sol.Id).Tax_Category__c) {
				if (sol.Service_Visit__c != null) {
					svIds.add(sol.Service_Visit__c);
				}
			}
			
			if (sol.Service_Visit__c != trigger.oldMap.get(sol.Id).Service_Visit__c) {
				if (sol.Service_Visit__c != null) {
					svIds.add(sol.Service_Visit__c);
				}
				if (trigger.oldMap.get(sol.Id).Service_Visit__c != null) {
					svIds.add(trigger.oldMap.get(sol.Id).Service_Visit__c);
				}
			}
		}
	}
	
	if (!svIds.isEmpty()) {
		Set<Id> cIds = new Set<Id>();
		List<SV__c> svList = new List<SV__c>();
		svList = [select Id, Case__c from SV__c where Id in :svIds];
		for (SV__c sv :svList) {
			if (sv.Case__c != null) {
				cIds.add(sv.Case__c);
			}
		}
		
		if (!cIds.isEmpty()) {
			CaseService.billingStatus(cIds);
		}
	}
}