public with sharing class ContractService {
	
	/*
	 *	Service methods for ContractTrigger.
	 */
	
	// Copy various fields from a contract to related case records.
	// - after update
	public static void contractToCase(Map<Id, Contract> newMap, Map<Id, Contract> oldMap) {
		Set<Id> cntrctIds = new Set<Id>();
		
		for (Contract cntrct :newMap.values()) {
			if (cntrct.Type__c != oldMap.get(cntrct.Id).Type__c) {
				cntrctIds.add(cntrct.Id);
			}
		}
		
		if (!cntrctIds.isEmpty()) {
			List<Case> caseList = new List<Case>();
			caseList = [select Id, CaseNumber, Contract_Type__c, ServiceContract_Case__c 
				from Case where ServiceContract_Case__c in :cntrctIds and IsClosed = false];
			
			for (Case c :caseList) {
				if (newMap.containsKey(c.ServiceContract_Case__c)) {
					c.Contract_Type__c = newMap.get(c.ServiceContract_Case__c).Type__c;
				}
			}
			
			if (!caseList.isEmpty()) {
				update caseList;
			}
		}
	}
}