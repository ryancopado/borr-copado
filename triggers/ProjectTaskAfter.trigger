trigger ProjectTaskAfter on AcctSeed__Project_Task__c (after delete, after insert, after undelete, after update) {
	
	/*
	 *	When fields Sales Budget, PM Budget, Active Budget, or Line Item Total change, 
	 *	change the value of field RollUp Remaining Available Budget on associated
	 *	Sales Order Line records (this will force Sales Order Line triggers to fire)
	 *
	 */
	
	List<AcctSeed__Project_Task__c> records = new List<AcctSeed__Project_Task__c>();
	List<Id> ptIds = new List<Id>();
	
	
	if (trigger.isInsert || trigger.isUnDelete) {
		ptIds.addAll(trigger.newMap.keySet());
	}
	
	if (trigger.isDelete) {
		ptIds.addAll(trigger.oldMap.keySet());
	}
	
	if (trigger.isUpdate) {
		for (AcctSeed__Project_Task__c pt :trigger.new) {
			if ( (pt.Sales_Budget__c != trigger.oldMap.get(pt.Id).Sales_Budget__c) ||
				 (pt.PM_Budget__c != trigger.oldMap.get(pt.Id).PM_Budget__c) ||
				 (pt.Active_Budget__c != trigger.oldMap.get(pt.Id).Active_Budget__c) ||
				 (pt.Line_Item_Total__c != trigger.oldMap.get(pt.Id).Line_Item_Total__c) ) {
				ptIds.add(pt.Id);
			}
		}
	}
	
	if (!ptIds.isEmpty()) {
		List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
		solList = [select Id, Con_Req_Group__c, RollUp_Remaining_Available_Budget__c from AcctSeedERP__Sales_Order_Line__c where AcctSeedERP__Project_Task__c in :ptIds];
		for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
			if (sol.Con_Req_Group__c != null) {
				sol.RollUp_Remaining_Available_Budget__c = !sol.RollUp_Remaining_Available_Budget__c;
			}
		}
		
		if (!solList.isEmpty()) {
			update solList;
		}
	}
}