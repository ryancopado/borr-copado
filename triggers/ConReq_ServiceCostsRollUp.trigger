trigger ConReq_ServiceCostsRollUp on AcctSeedERP__Sales_Order_Line__c (after delete, after insert, after update) {
	/*
	// Find all the Service Contracts associated with these Construction Requisitions and calculate the "Service Costs (this year)" field.
	
	//RecordType rtService = new RecordType();
	List<Id> svIds = new List<Id>();
	List<SV__c> serviceVisits = new List<SV__c>();
	List<Id> conIds = new List<Id>();
	Id rtServiceId = '012800000007hO9';
	
	//rtService = [SELECT Id, Name FROM RecordType WHERE Name = 'Service' and SobjectType = 'AcctSeedERP__Sales_Order_Line__c'];
	if (trigger.isDelete) {
		for (AcctSeedERP__Sales_Order_Line__c cr : trigger.old) {
			if (cr.RecordTypeId == rtServiceId) {
				if (cr.Service_Visit__c != NULL) {
					svIds.add(cr.Service_Visit__c);
				}
			}
		}
		
		system.debug('*****ConReq isDelete, number of svIds = ' + svIds.size());
		
	} else {
		for (AcctSeedERP__Sales_Order_Line__c cr : trigger.new) {
			if (cr.RecordTypeId == rtServiceId) {
				if (cr.Service_Visit__c != NULL) {
					svIds.add(cr.Service_Visit__c);
				}
				
				// If the Service Visit field has just changed, include the old Service Visit Id if different than current value
				if (trigger.isUpdate) {
					if (trigger.oldMap.get(cr.Id).Service_Visit__c != NULL) {
						if (cr.Service_Visit__c == NULL || cr.Service_Visit__c != trigger.oldMap.get(cr.Id).Service_Visit__c) {
							svIds.add(trigger.oldMap.get(cr.Id).Service_Visit__c);
						}
					}
				}
			}
			
		}
		
		system.debug('*****ConReq isInsert/Update, number of svIds = ' + svIds.size());
	}
			
	if (svIds.size() > 0) {
		serviceVisits = [SELECT Id, Contract__c FROM SV__c WHERE Id IN: svIds];
			
		if (serviceVisits.size() > 0) {
			for (SV__c sv : serviceVisits) {
				conIds.add(sv.Contract__c);
			}
	
			// Calculate the Service Costs (this year) field for each Service Contract
			if (conIds.size() > 0) {
				ServiceCostsThisYearRollUpUtility.rollUpServiceCosts(conIds);
			}
		}
	}
	*/	
}