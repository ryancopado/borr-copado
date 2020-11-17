trigger AS_createSrvcContract on AcctSeed__Project__c (after insert, after update) {
	
	/*
	 *	If the Overall Project Status has just been set to "Design", create a Warranty contract
	 *	unless one already exists.  If a contract is created, update all Site records
	 *	associated with the project to reference the contract.
	 *
	 */
/*
	if (approveELI.IsRecursiveUpdate == null) {
		approveELI.IsRecursiveUpdate=false;
	}
	
	if (approveELI.IsRecursiveUpdate == false) {
		
		List<Contract> newContracts = new List<Contract>();
		List<Contract> existingContracts = new List<Contract>();
		Map<Id, Contract> cMap;
		boolean doSQL = false;
		for (AcctSeed__Project__c p :trigger.new) {
			if (p.Overall_Project_Status__c == 'Design') {
				if (trigger.isUpdate) {
					if (trigger.oldMap.get(p.Id).Overall_Project_Status__c != 'Design') {
						doSQL = true;
					}
				}
			}
		}
		
		cMap = new Map<Id, Contract>();
		Id rtWarrantyId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Warranty').getRecordTypeId();
		if (doSQL) {
			existingContracts = [select Id, ASProject__c from Contract where ASProject__c in :trigger.newMap.keySet() and RecordTypeId = :rtWarrantyId];
			for (Contract c :existingContracts) {
				cMap.put(c.ASProject__c, c);
			}
		}
		
		for (AcctSeed__Project__c p :trigger.new) {
			if (p.Overall_Project_Status__c == 'Design') {
				if (trigger.isInsert) {
					newContracts.add(new Contract(
						AccountId = p.AcctSeed__Account__c,
						StartDate = system.now().date(),
						ContractTerm = 12,
						Service_Schedule_months__c = 6,
						Contract_Amount__c = 0,
						RecordTypeId = rtWarrantyId,
						ASProject__c = p.Id)
					);
				}
				
				if (trigger.isUpdate) {
					if (trigger.oldMap.get(p.Id).Overall_Project_Status__c != 'Design') {
						if (!cMap.containsKey(p.Id)) {
							newContracts.add(new Contract(
								AccountId = p.AcctSeed__Account__c,
								StartDate = system.now().date(),
								ContractTerm = 12,
								Service_Schedule_months__c = 6,
								Contract_Amount__c = 0,
								RecordTypeId = rtWarrantyId,
								ASProject__c = p.Id)
							);
						}  
					}
				}
			}
		}
		
		// Create the new contracts and associate the project site records to the new contracts
		if (!newContracts.isEmpty()) {
			insert newContracts;
			
			cMap = new Map<Id, Contract>();
			for (Contract c :newContracts) {
				cMap.put(c.ASProject__c, c);
			}
			
			List<Site__c> sites = new List<Site__c>();
			sites = [select Id, Contract__c, Project__c from Site__c where Project__c in :cMap.keySet()];
			for (Site__c s :sites) {
				if (cMap.containsKey(s.Project__c)) {
					s.Contract__c = cMap.get(s.Project__c).Id;
				}
			}
			
			if (!sites.isEmpty()) {
				update sites;
			}
		}
	}
*/
}