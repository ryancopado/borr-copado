trigger oppUpdate on Opportunity (after update) {
	//Maps of Opps that have changed.
	Map<Id, Opportunity> oppsWithNewOwner = new Map<Id, Opportunity>();
	Map<Id, Opportunity> oppsSigned = new Map<Id,Opportunity>();
	Map<Id, Opportunity> oppsSignedBooked = new Map<Id,Opportunity>();
	List<Id> oppsSignedId = new List<Id>();
	List<Id> oppsEPCSignedId = new List<Id>();
	Map<Id, Schema.RecordTypeInfo> rtByIdMap = Schema.SObjectType.Opportunity.getRecordTypeInfosById();
    Map<Id, Opportunity> oppsClosed = new Map<Id,Opportunity>();
    List<Opportunity> oppsPType = new List<Opportunity>();
    Map<Id, Opportunity> oppsTaxStatus = new Map<Id,Opportunity>();
    Map<Id, Opportunity> oppsChangeOrders = new Map<Id,Opportunity>();
    Id defaultOMOpportunityOwner = '005340000077cE1';  // Phillip Stephenson is the default O&M Opportunity Owner
	    
	//Trigger.new is an array of opportunities containing the updates ECs. The loop runs through the list and adds any 
	//opportunities that have new ECs to the oppsWithNewOwner map.
	for (Integer i = 0; i <Trigger.new.size(); i++) {
		if (Trigger.old[i].OwnerId != Trigger.new[i].OwnerId) {
			oppsWithNewOwner.put(Trigger.old[i].Id, Trigger.new[i]);
		}
		if (Trigger.new[i].StageName == 'Contract Signed' && Trigger.old[i].StageName != 'Contract Signed') {
            oppsSigned.put(Trigger.new[i].Id, Trigger.new[i]);
            oppsSignedId.add(Trigger.new[i].Id);
        }
        if ( (Trigger.new[i].StageName == 'Contract Signed' && Trigger.old[i].StageName != 'Contract Signed') || 
        	 (Trigger.new[i].StageName == 'Project Booked' && Trigger.old[i].StageName != 'Project Booked') ) {
            oppsSignedBooked.put(Trigger.new[i].Id, Trigger.new[i]);
        }
        if (rtByIdMap.containsKey(Trigger.new[i].RecordTypeId) && rtByIdMap.get(Trigger.new[i].RecordTypeId).getName() == 'Development') {
        	if (Trigger.new[i].StageName == 'EPC Signed' && Trigger.old[i].StageName != 'EPC Signed') {
        		oppsEPCSignedId.add(Trigger.new[i].Id);
        	}
        }
        if (Trigger.new[i].StageName == 'Closed Lost' && Trigger.old[i].StageName != 'Closed Lost') {
            oppsClosed.put(Trigger.new[i].Id, Trigger.new[i]);
        }
        if ( (Trigger.new[i].Job_Type__c != Trigger.old[i].Job_Type__c) ||
        	 (Trigger.new[i].Type != Trigger.old[i].Type) ) {
			oppsPType.add(Trigger.new[i]);
        }
        if (Trigger.new[i].Tax_Exemption__c != Trigger.old[i].Tax_Exemption__c) {
        	oppsTaxStatus.put(Trigger.new[i].Id, Trigger.new[i]);
        }
		if (trigger.new[i].Change_Orders__c != trigger.old[i].Change_Orders__c) {
			oppsChangeOrders.put(trigger.new[i].Id, trigger.new[i]);
		}
	}
	if(oppsWithNewOwner.size() > 0) {
		oppUpdates.ownerUpdate(oppsWithNewOwner);
	}
	if(oppsSigned.size() > 0) { 
        oppUpdates.addCommission(oppsSigned);
        ProjectCreate.contractSigned(oppsSignedId);
	}
	if (!oppsEPCSignedId.isEmpty()) {
		ProjectCreate.contractSigned(oppsEPCSignedId);
	}
	if (!oppsSignedBooked.isEmpty()) {
		if (oppUpdates.runOnce()) {
			// If Opportunity has record type "DevelopmentSite" or "CaptiveOnSite" create an "O_M_Opportunity" Opportunity
			/*
			List<RecordType> rtList = new List<RecordType>();
			rtList = [select Id, DeveloperName from RecordType where SobjectType = 'Opportunity'];
			Id rtDevId = null;
			Id rtCapId = null;
			Id rtOMId = null;
			for (RecordType rt :rtList) {
				if (rt.DeveloperName == 'DevelopmentSite') {
					rtDevId = rt.Id;
				}
				if (rt.DeveloperName == 'CaptiveOnSite') {
					rtCapId = rt.Id;
				}
				if (rt.DeveloperName == 'O_M_Opportunity') {
					rtOMId = rt.Id;
				}
			}
			*/
			Map<String, Schema.RecordTypeInfo> rtByNameMap = Schema.SObjectType.Opportunity.getRecordTypeInfosByName();
			Map<Id, Opportunity> epcMap = new Map<Id, Opportunity>();
			for (Opportunity o :oppsSignedBooked.values()) {
				/*
				if (o.RecordTypeId == rtDevId || o.RecordTypeId == rtCapId) {
					epcMap.put(o.Id, o);
				}
				*/
				if ( rtByIdMap.containsKey(o.RecordTypeId) && 
					 (rtByIdMap.get(o.RecordTypeId).getName() == 'Development' || rtByIdMap.get(o.RecordTypeId).getName() == 'Captive/OnSite')) {
					epcMap.put(o.Id, o);
				}
			}
			if (!epcMap.isEmpty()) {
				List<Opportunity> oppInList = new List<Opportunity>();
				for (Opportunity o :epcMap.values()) {
					oppInList.add(new Opportunity(
						Name = o.Name + ' O&M',
						AccountId = o.AccountId,
						EPC_Opportunity__c = o.Id,
						StageName = 'Prospecting',
						CloseDate = system.today(),
						OwnerId = defaultOMOpportunityOwner,
						//RecordTypeId = rtOMId)
						RecordTypeId = rtByNameMap.get('O&M Opportunity').getRecordTypeId())
					);
				}
				insert oppInList;
			}
		}
    }
    if(oppsClosed.size() > 0){ 
        oppUpdates.removeCommission(oppsClosed);
    }
    if (oppsPType.size() > 0) {
    	ProjectCreate.updatePType(oppsPType);
    }
    if (oppsTaxStatus.size() > 0) {
    	oppUpdates.taxRateUpdate(oppsTaxStatus);
    }
    if (!oppsChangeOrders.isEmpty()) {
    	ProjectCreate.updateOpportunityChangeOrder(oppsChangeOrders);
    }
}