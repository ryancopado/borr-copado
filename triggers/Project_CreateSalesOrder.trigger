trigger Project_CreateSalesOrder on AcctSeed__Project__c (after update) {
	
	// Create a Sales Order for the Project if one does not already exist
	
	List<AcctSeedERP__Sales_Order__c> soList = new List<AcctSeedERP__Sales_Order__c>();
	List<AcctSeedERP__Sales_Order__c> soCreate = new List<AcctSeedERP__Sales_Order__c>();
	Map<Id, AcctSeed__Project__c> pMap = new Map<Id, AcctSeed__Project__c>();
	Map<Id, AcctSeedERP__Sales_Order__c> soMap = new Map<Id, AcctSeedERP__Sales_Order__c>();
	
	for (AcctSeed__Project__c p : trigger.new) {
		if (p.AcctSeed__Account__c != null && p.AcctSeed__Opportunity__c != null) {
			pMap.put(p.Id, p);
		}
	}
	
	// Only if Project has an Account and Opportunity
	if (pMap.size() > 0) {
		soList = [select Id, Project__c from AcctSeedERP__Sales_Order__c where Project__c in: pMap.keySet()];
		for (AcctSeedERP__Sales_Order__c so : soList) {
			if (!soMap.containsKey(so.Project__c)) {
				soMap.put(so.Project__c, so);
			}
		}
	
		// Create a Sales Order record for each Project without one
		for (AcctSeed__Project__c p : pMap.values()) {
			if (!soMap.containsKey(p.Id)) {
				soCreate.add(new AcctSeedERP__Sales_Order__c(
					Project__c = p.Id,
					AcctSeedERP__Opportunity__c = p.AcctSeed__Opportunity__c,
					AcctSeedERP__Customer__c = p.AcctSeed__Account__c)
				);
			}
		}
	
		if (!soCreate.isEmpty()) {
			insert soCreate;
		}
	}
}