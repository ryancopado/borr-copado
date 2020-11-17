trigger ExpenseLineDataIntegrity on AcctSeed__Expense_Line__c (before insert, before update) {
	
	// If the Branch field of the Expense Line is blank, set it to the Branch field of its
	// associated Expense Report.
	
	List<Id> erIds = new List<Id>();
	List<AcctSeed__Expense_Report__c> erList = new List<AcctSeed__Expense_Report__c>();
	Map<Id, AcctSeed__Expense_Report__c> erMap = new Map<Id, AcctSeed__Expense_Report__c>();
	
	// Get all the associated Expense Report records
	for (AcctSeed__Expense_Line__c el : Trigger.new) {
		erIds.add(el.AcctSeed__Expense_Report__c);
	}
	erList = [SELECT Id, AcctSeed__Status__c, ReportBranch__c, Sales_Segment__c, Ops_Division__c FROM AcctSeed__Expense_Report__c WHERE Id in: erIds];
	for (AcctSeed__Expense_Report__c er : erList) {
		erMap.put(er.Id, er);
	}

	for (AcctSeed__Expense_Line__c el : Trigger.new) {
		
		// If the Branch field of the Expense Line is blank, set it to the Branch field in the Expense Report
		if (el.Branch__c == NULL && erMap.get(el.AcctSeed__Expense_Report__c).ReportBranch__c != NULL) {
			el.Branch__c = erMap.get(el.AcctSeed__Expense_Report__c).ReportBranch__c;
		}
		// If the Sales Segment or Ops Division fields of the Expense Line are blank, set them to the values in the Expense Report
		if (el.Sales_Segment__c == null) {
			el.Sales_Segment__c = erMap.get(el.AcctSeed__Expense_Report__c).Sales_Segment__c;
		}
		if (el.Ops_Division__c == null) {
			el.Ops_Division__c = erMap.get(el.AcctSeed__Expense_Report__c).Ops_Division__c;
		}
	}
}