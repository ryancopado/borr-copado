trigger changeRate on User (before update, after update) {
	/*
	if (Trigger.isBefore) {
		for (Integer i=0; i<Trigger.new.size(); i++) {
			// If Rate is about to change, save current values
			if (Trigger.new[i].Rate__c != Trigger.old[i].Rate__c) {
				Trigger.new[i].Rate3__c = Trigger.old[i].Rate2__c;
				Trigger.new[i].Rate2__c = Trigger.old[i].Rate1__c;
				Trigger.new[i].Rate1__c = Trigger.old[i].Rate__c;
				Trigger.new[i].Rate3_Effective_Date__c = Trigger.old[i].Rate2_Effective_Date__c;
				Trigger.new[i].Rate2_Effective_Date__c = Trigger.old[i].Rate1_Effective_Date__c;
				Trigger.new[i].Rate1_Effective_Date__c = Trigger.old[i].Rate_Effective_Date__c;
			}
			// Take care of potential null fields
			if (Trigger.new[i].Rate__c == null) {
				Trigger.new[i].Rate__c = 0;
			}
			if (Trigger.new[i].Rate1__c == null) {
				Trigger.new[i].Rate1__c = Trigger.new[i].Rate__c;
			}
			if (Trigger.new[i].Rate2__c == null) {
				Trigger.new[i].Rate2__c = Trigger.new[i].Rate1__c;
			}
			if (Trigger.new[i].Rate3__c == null) {
				Trigger.new[i].Rate3__c = Trigger.new[i].Rate2__c;
			}
		}
	}
	
	if (Trigger.isAfter) {
		// Make a list of all User records with changed Rate or Rate Effective Date
		List<User> newU = new List<User>();
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            if (Trigger.new[i].Rate__c != Trigger.old[i].Rate__c || Trigger.new[i].Rate_Effective_Date__c != Trigger.old[i].Rate_Effective_Date__c) {
            	newU.add(Trigger.new[i]);
            } 
        }
        // Recalculate rates on associated Time Entry records
        if(newU.size() > 0) {
        	recalcTE.recalcInternalRates(newU);
        }
	}
	*/
}