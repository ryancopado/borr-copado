trigger AS_projectAfterUpdate on AcctSeed__Project__c (after update) {
	
	/*
	 *	Set the Project PM field on the associated Sales Order Line, Con Req Group and Contract records to the 
	 *	updated Owner field on the Project
	 *
	 *	Change the value of field RollUp Remaining Available Budget on the associated Sales Order Line
	 *	if the Overall Project Status or PM Lock fields have changed.
	 *
	 */
/*	
	Map<Id, AcctSeed__Project__c> pMap = new map<Id, AcctSeed__Project__c>();
	//Map<Id, AcctSeed__Project__c> pOwnerMap = new map<Id, AcctSeed__Project__c>();

	for (AcctSeed__Project__c p :trigger.new) {
		if ( (p.OwnerId != trigger.oldMap.get(p.Id).OwnerId) ||
			 (p.PM_Lock__c != trigger.oldMap.get(p.Id).PM_Lock__c) ||
			 (p.Overall_Project_Status__c != trigger.oldMap.get(p.Id).Overall_Project_Status__c) ) {
			pMap.put(p.Id, p);
 		}
 		
 		//if (p.OwnerId != trigger.oldMap.get(p.Id).OwnerId) {
 			//pOwnerMap.put(p.Id, p);
 		//}
 		
 	}
 	
	if (!pMap.isEmpty()) {
		List<AcctSeedERP__Sales_Order_Line__c> solUpList = new List<AcctSeedERP__Sales_Order_Line__c>();
		List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
		solList = [select Id, Project_PM__c, AcctSeedERP__Project__c, Con_Req_Group__c, RollUp_Remaining_Available_Budget__c  
					from AcctSeedERP__Sales_Order_Line__c where  AcctSeedERP__Project__c in: pMap.keySet()];
		Map<Id, Con_Req_Group__c> crgMap = new Map<Id, Con_Req_Group__c>([select Id, Project_PM__c, Project__c 
					from Con_Req_Group__c where  Project__c in: pMap.keySet()]);
		
		// Update the Project PM field of all associated Con Req Group records - this will have the side
		// effect of updating the Project PM field of all of the Sales Order Lines that are associated with the
		// Con Req Group records.
		List<Con_Req_Group__c> crgUpList = new List<Con_Req_Group__c>();
		for (Con_Req_Group__c crg :crgMap.values()) {
			if (trigger.newMap.get(crg.Project__c).OwnerId != trigger.oldMap.get(crg.Project__c).OwnerId) {
				crg.Project_PM__c = pMap.get(crg.Project__c).OwnerId;
				crgUpList.add(crg);
			}
		}
		
		// Update the Project PM field of the Sales Order Line records that are not associated
		// with a Con Req Group record and set the RollUp Remaining Available Budget field if warranted
		Boolean solUpdate;
		for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
			solUpdate = false;
			if ( (!crgMap.containsKey(sol.Con_Req_Group__c)) && 
				 (trigger.newMap.get(sol.AcctSeedERP__Project__c).OwnerId != trigger.oldMap.get(sol.AcctSeedERP__Project__c).OwnerId) ) {
				sol.Project_PM__c = pMap.get(sol.AcctSeedERP__Project__c).OwnerId;
				solUpdate = true;
			}
			
			if ( (sol.Con_Req_Group__c != null) && 
				 ((trigger.newMap.get(sol.AcctSeedERP__Project__c).PM_Lock__c != trigger.oldMap.get(sol.AcctSeedERP__Project__c).PM_Lock__c) ||
				  (trigger.newMap.get(sol.AcctSeedERP__Project__c).Overall_Project_Status__c != trigger.oldMap.get(sol.AcctSeedERP__Project__c).Overall_Project_Status__c)) ) {
				sol.RollUp_Remaining_Available_Budget__c = !sol.RollUp_Remaining_Available_Budget__c;
				solUpdate = true;
			}
			
			if (solUpdate == true) {
				solUpList.add(sol);
			}
		}
		
		// Update the PM field on related Contract records
		//List<Contract> cList = new List<Contract>();
		//if (!pOwnerMap.isEmpty()) {
			//cList = [select Id, ASProject__c, PM__c from Contract where ASProject__c in :pOwnerMap.keySet()];
		//}
		//for (Contract c :cList) {
			//c.PM__c = pOwnerMap.get(c.ASProject__c).OwnerId;
		//}
		
		if (!crgUpList.isEmpty()) {
			update crgUpList;
		}
		if (!solUpList.isEmpty()) {
			update solUpList;
		}
		
		//if (!cList.isEmpty()) {
			//update cList;
		//}	
	}
*/
}