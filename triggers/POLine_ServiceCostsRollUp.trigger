trigger POLine_ServiceCostsRollUp on AcctSeedERP__Purchase_Order_Line__c (after delete, after insert, after update, before insert, before update) {
	/*
	// Find all the Service Contracts associated with these Purchase Order Lines and calculate the "Service Costs (this year)" field.
	
	Map<Id, AcctSeedERP__Purchase_Order__c> poMap = new Map<Id, AcctSeedERP__Purchase_Order__c>();
	List<AcctSeedERP__Purchase_Order_Line__c> poLineTrigger = new List<AcctSeedERP__Purchase_Order_Line__c>();
	List<AcctSeedERP__Purchase_Order__c> poList = new List<AcctSeedERP__Purchase_Order__c>();
	List<Id> conReqIds = new List<Id>();
	List<Id> poLineIds = new List<Id>();
	List<Id> poIds = new List<Id>();
	RecordType rtService = new RecordType();
	List<AcctSeedERP__Sales_Order_Line__c> conReq = new List<AcctSeedERP__Sales_Order_Line__c>();
	List<Id> svIds = new List<Id>();
	List<SV__c> serviceVisits = new List<SV__c>();
	List<Id> conIds = new List<Id>();
	
	// If trigger is before insert/update, make sure the Construction Requisition lookup field is filled in so that we can find
	// the associated Construction Requisition in the after delete trigger
	if (trigger.isBefore) {
		rtService = [SELECT Id, Name FROM RecordType WHERE Name = 'Service' and SobjectType = 'AcctSeedERP__Sales_Order_Line__c'];
		conReq = [SELECT Id, RecordTypeId, Service_Visit__c, AcctSeedERP__Purchase_Order_Line__c FROM AcctSeedERP__Sales_Order_Line__c 
				WHERE RecordTypeId =: rtService.Id AND AcctSeedERP__Purchase_Order_Line__c IN: trigger.new];
		for (AcctSeedERP__Sales_Order_Line__c cr : conReq) {
			if (cr.AcctSeedERP__Purchase_Order_Line__c != NULL) {
				if (trigger.newMap.containsKey(cr.AcctSeedERP__Purchase_Order_Line__c)) {
					trigger.newMap.get(cr.AcctSeedERP__Purchase_Order_Line__c).Construction_Req__c = cr.Id;
				}
			}
		}

	} else {
	
		if (trigger.isDelete) {
			poLineTrigger.addAll(trigger.old);
		} else {
			poLineTrigger.addAll(trigger.new);
		}
	
		for (AcctSeedERP__Purchase_Order_Line__c pol : poLineTrigger) {
			poIds.add(pol.AcctSeedERP__Purchase_Order__c);
		}
	
		system.debug('*****POLine number of poIds = ' + poIds.size());

		poList = [SELECT Id, AcctSeedERP__Status__c, PO_Closed_Date__c FROM AcctSeedERP__Purchase_Order__c WHERE Id IN: poIds];
		for (AcctSeedERP__Purchase_Order__c po : poList) {
			if (po.PO_Closed_Date__c != NULL) {
				if (po.AcctSeedERP__Status__c == 'Closed' && po.PO_Closed_Date__c.year() == system.today().year()) {
					poMap.put(po.Id, po);
				}
			}
		}
	
		system.debug('*****POLine number of poMap = ' + poMap.size());
	
		if (poMap.size() > 0) {
			for (AcctSeedERP__Purchase_Order_Line__c pol : poLineTrigger) {
				if (poMap.containsKey(pol.AcctSeedERP__Purchase_Order__c)) {
					poLineIds.add(pol.Id);
					if (pol.Construction_Req__c != NULL) {
						conReqIds.add(pol.Construction_Req__c);
					}
				}
			}
		}
	
		system.debug('*****POLine 1 number of poLineIds = ' + poLineIds.size() + ' number of conReqIds = ' + conReqIds.size());
	
		if (trigger.isUpdate) {
			for (AcctSeedERP__Purchase_Order_Line__c pol : trigger.new) {
				if (trigger.oldMap.get(pol.Id).Construction_Req__c != NULL) {	
					// Include the old Construction Requisition Id if this field just changed and is different from current value
					if (pol.Construction_Req__c == NULL || pol.Construction_Req__c != trigger.oldMap.get(pol.Id).Construction_Req__c) {
						conReqIds.add(trigger.oldMap.get(pol.Id).Construction_Req__c);
					}
				}
			}
		}
	
		system.debug('*****POLine 2 number of poLineIds = ' + poLineIds.size() + ' number of conReqIds = ' + conReqIds.size());
	
		if (poLineIds.size() > 0 || conReqIds.size() > 0) {
			rtService = [SELECT Id, DeveloperName FROM RecordType WHERE DeveloperName = 'Service' and SobjectType = 'AcctSeedERP__Sales_Order_Line__c'];
			conReq = [SELECT Id, RecordTypeId, Service_Visit__c, AcctSeedERP__Purchase_Order_Line__c FROM AcctSeedERP__Sales_Order_Line__c 
					WHERE RecordTypeId =: rtService.Id AND (AcctSeedERP__Purchase_Order_Line__c IN: poLineIds OR Id IN: conReqIds)];
			
			system.debug('*****POLine number of conReq = ' + conReq.size());
		
			if (conReq.size() > 0) {
				for (AcctSeedERP__Sales_Order_Line__c cr : conReq) {
					svIds.add(cr.Service_Visit__c);
				}
				serviceVisits = [SELECT Id, Contract__c FROM SV__c WHERE Id IN: svIds];
			
				system.debug('*****POLine number of serviceVisits = ' + serviceVisits.size());
			
				if (serviceVisits.size() > 0) {
					for (SV__c sv : serviceVisits) {
						conIds.add(sv.Contract__c);
					}
				
					system.debug('*****POLine number of conIds = ' + conIds.size());
	
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