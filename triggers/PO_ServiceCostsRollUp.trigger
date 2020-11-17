trigger PO_ServiceCostsRollUp on AcctSeedERP__Purchase_Order__c (after insert, after update) {
	/*
	// Find all the Service Contracts associated with these Purchase Orders and calculate the "Service Costs (this year)" field.
	
	List<Id> poIds = new List<Id>();
	List<AcctSeedERP__Purchase_Order_Line__c> poLines = new List<AcctSeedERP__Purchase_Order_Line__c>();
	List<Id> poLineIds = new List<Id>();
	RecordType rtService = new RecordType();
	List<AcctSeedERP__Sales_Order_Line__c> conReq = new List<AcctSeedERP__Sales_Order_Line__c>();
	List<Id> svIds = new List<Id>();
	List<SV__c> serviceVisits = new List<SV__c>();
	List<Id> conIds = new List<Id>();
	
	// Determine if there are any Purchase Orders that have changed such that "Service Costs (this year)" may need to be recalculated
	for (AcctSeedERP__Purchase_Order__c po : trigger.new) {
		if (trigger.isInsert) {
			if (po.PO_Closed_Date__c != NULL) {
				if (po.AcctSeedERP__Status__c == 'Closed' && po.PO_Closed_Date__c.year() == system.today().year()) {
					poIds.add(po.Id);
				}
			}
		} else {
			if (po.AcctSeedERP__Status__c != trigger.oldMap.get(po.Id).AcctSeedERP__Status__c) {
				if (po.AcctSeedERP__Status__c == 'Closed' || trigger.oldMap.get(po.Id).AcctSeedERP__Status__c == 'Closed') {
					poIds.add(po.Id);
				}
			}
		}
	}
	
	if (poIds.size() > 0) {
		poLines = [SELECT Id, AcctSeedERP__Purchase_Order__c, Roll_Up_All_Account_Payable_Lines__c FROM AcctSeedERP__Purchase_Order_Line__c WHERE AcctSeedERP__Purchase_Order__c IN: poIds];
		
		if (poLines.size() > 0) {
			for (AcctSeedERP__Purchase_Order_Line__c pol : poLines) {
				poLineIds.add(pol.Id);
			}
			rtService = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Service' and SobjectType = 'AcctSeedERP__Sales_Order_Line__c'];
			conReq = [SELECT Id, RecordTypeId, Service_Visit__c, AcctSeedERP__Purchase_Order_Line__c FROM AcctSeedERP__Sales_Order_Line__c WHERE RecordTypeId =: rtService.Id AND AcctSeedERP__Purchase_Order_Line__c IN: poLineIds];
			
			if (conReq.size() > 0) {
				for (AcctSeedERP__Sales_Order_Line__c cr : conReq) {
					svIds.add(cr.Service_Visit__c);
				}
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
		}
	}
	*/
}