trigger changeProjectRate on Team_Member__c (before update, after update) {
	
	if (Trigger.isBefore) {
		for (Integer i=0; i<Trigger.new.size(); i++) {
			// If Rate (Project) is about to change, save current values
			if (Trigger.new[i].Rate_Project__c != Trigger.old[i].Rate_Project__c) {
				Trigger.new[i].Rate3_Project__c = Trigger.old[i].Rate2_Project__c;
				Trigger.new[i].Rate2_Project__c = Trigger.old[i].Rate1_Project__c;
				Trigger.new[i].Rate1_Project__c = Trigger.old[i].Rate_Project__c;
				Trigger.new[i].Rate3_Effective_Date_Project__c = Trigger.old[i].Rate2_Effective_Date_Project__c;
				Trigger.new[i].Rate2_Effective_Date_Project__c = Trigger.old[i].Rate1_Effective_Date_Project__c;
				Trigger.new[i].Rate1_Effective_Date_Project__c = Trigger.old[i].Rate_Effective_Date_Project__c;
			}
			// Take care of potential null fields
			if (Trigger.new[i].Rate_Project__c == null) {
				Trigger.new[i].Rate_Project__c = 0;
			}
			if (Trigger.new[i].Rate1_Project__c == null) {
				Trigger.new[i].Rate1_Project__c = Trigger.new[i].Rate_Project__c;
			}
			if (Trigger.new[i].Rate2_Project__c == null) {
				Trigger.new[i].Rate2_Project__c = Trigger.new[i].Rate1_Project__c;
			}
			if (Trigger.new[i].Rate3_Project__c == null) {
				Trigger.new[i].Rate3_Project__c = Trigger.new[i].Rate2_Project__c;
			}
		}
	}
	
	if (Trigger.isAfter) {
		// Make a list of all Team Members with changed Rate (Project) or Rate Effective Date (Project)
		List<Team_Member__c> newTM = new List<Team_Member__c>();
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            if (Trigger.new[i].Rate_Project__c != Trigger.old[i].Rate_Project__c || Trigger.new[i].Rate_Effective_Date_Project__c != Trigger.old[i].Rate_Effective_Date_Project__c) {
            	newTM.add(Trigger.new[i]);
            } 
        }
        // Recalculate rates on associated Time Entry records
        if(newTM.size() > 0) {
        	recalcTE.recalcProjectRates(newTM);
        }
	}
}