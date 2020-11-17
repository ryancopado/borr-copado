global class recalcTE {
/*
	webService static void recalcTimeEntries(Id[] tmId) {
		
        // Get the set of Time Entry records associated with these Team Member records
        Time_Entry__c[] te = [select Force_Recalc__c, Invoice__c from Time_Entry__c where Team_Member__c in :tmId];
        
        // Set the force recalculation flag to true for each Time Entry record that is not
        // already on an invoice
        List<Time_Entry__c> newTE = new List<Time_Entry__c>();
        for (Integer i=0; i<te.size(); i++) {
        	if (te[i].Invoice__c == null) {
        		te[i].Force_Recalc__c = true;
        		newTE.add(te[i]);
        	}
        }
        
        // Write the Time Entry records - this will cause the rates to be recalculated
        if (newTE.size() > 0) {
        	update te;
        }
	}
*/	
	public static void recalcProjectRates(Team_Member__c[] tm) {
		
		// Force the recalculation of the Rate (Project), Total Cost (Project),
		// Rate (Internal), and Total Cost (Internal) fields for all Time Entry
		// records associated with these Team Member records that are not already
		// on an invoice.
		//
		// Create a list of Team Member record Ids and get the associated Time Entry records
		List<Id> tmId = new List<Id>();
        for (Integer i = 0; i <tm.size(); i++) {
            tmId.add(tm[i].Id); 
        }
        Time_Entry__c[] te = [select Force_Recalc__c, Invoice__c from Time_Entry__c where Team_Member__c in :tmId];
        
        // Set the force recalculation flag to true for each Time Entry record that is not
        // already on an invoice
        List<Time_Entry__c> newTE = new List<Time_Entry__c>();
        for (Integer i=0; i<te.size(); i++) {
        	if (te[i].Invoice__c == null) {
        		te[i].Force_Recalc__c = true;
        		newTE.add(te[i]);
        	}
        }
        
        // Write the Time Entry records - this will cause the Project rates to be recalculated
        if (newTE.size() > 0) {
        	update newTE;
        }
	}
	
	public static void recalcInternalRates(User[] u) {
		
		// Get the Team Member record Ids associated with these user records and
		// call recalcProjectRates to recaluculate the project and internal rates
		// for all Time Entry records associated with those Team Member records.
		List<Id> uId = new List<Id>();
        for (Integer i = 0; i <u.size(); i++) {
            uId.add(u[i].Id); 
        }
        Team_Member__c[] tm = [select Id from Team_Member__c where User__c in :uId];
        recalcProjectRates(tm); 
	}
}