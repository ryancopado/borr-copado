trigger ServiceVisit_ServiceCostsRollUp on SV__c (after delete, after update) {
	/*
	// Find all the Service Contracts associated with these Service Visits and calculate the "Service Costs (this year)" field.
	List<Id> conIds = new List<Id>();
			
	if (trigger.isDelete) {
		for (SV__c sv : trigger.old) {
			conIds.add(sv.Contract__c);
		}
	} else {
		for (SV__c sv : trigger.new) {
			// Add the old and current Contract Id if the current Contract Id is different from the old Contract Id
			if (sv.Contract__c != trigger.oldMap.get(sv.Id).Contract__c) {
				conIds.add(sv.Contract__c);
				conIds.add(trigger.oldMap.get(sv.Id).Contract__c);
			}
		}
	}
	
	// Calculate the Service Costs (this year) field for each Service Contract
	if (conIds.size() > 0) {
		ServiceCostsThisYearRollUpUtility.rollUpServiceCosts(conIds);
	}
	*/
}