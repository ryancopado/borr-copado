public with sharing class launchLeadReassignmentBatch {
	
	public static void launchLeadReassignment() {
		
		// Launch the batch job leadReassignment - checks last "touch" of Lead records - must be within the last
		// nDays (see below) or the Lead will be reassigned to the newOwnerId (see below)
		
		Integer nDays = 42;							// Leads must be touched within this many days from today
		String newOwnerId = '0053000000182CR';		// Assign Leads not touched to this user Id - Philip Hall
		//String philipHallId = '0053000000182CR';	// Can ignore Leads owned by Philip Hall - see querystring
		//String jonCerinoId = '00580000003QANn';		// Can ignore Leads owned by Jon Cerino - see querystring
		String standardRecordTypeId = '01230000000974v';
		String nDaysAgoString;
		Date nDaysAgoDate;
		String querystring;
		
		// Format datetime string for SQL query
		nDaysAgoDate = Date.Today() - nDays;
		nDaysAgoString = String.valueOf(nDaysAgoDate);
		nDaysAgoString = nDaysAgoString + 'T00:00:00Z';
		
		// Get the list of users whose Leads we want to consider for possible reassignment
		List<User> userList = new List<User>();
		userList = [select Id from User where Reassign_Leads__c = true];
		
		// Build the Query string for the batch job
		querystring = 'SELECT Id, LeadsManager__Leads_Manager__c, OwnerId FROM Lead ' +
				'WHERE RecordTypeId = \'' + standardRecordTypeId + 
				'\' AND Status != \'Wrong Person With Company\' AND Status != \'Closed/Lost\' AND ' + 
				'Status != \'Company Unqualified\' AND Status != \'PD will not call\' AND ' + 
				'isConverted = false AND isDeleted = false AND ' + 
				'LastModifiedDate < ' + nDaysAgoString +
				' AND (OwnerId = \'';
		if (userList.size() > 0) {
			querystring += userList[0].Id + '\'';
			for (Integer i=1; i<userList.size(); i++) {
				querystring += ' OR OwnerId = \'' + userList[i].Id + '\'';
			}
			querystring += ')';
		} else {
			querystring += '\')';
		}
/*
		querystring = 'SELECT Id, LeadsManager__Leads_Manager__c, OwnerId FROM Lead ' +
				'WHERE OwnerId != \'' + philipHallId + '\' AND OwnerId != \'' + jonCerinoId + 
				'\' AND RecordTypeId = \'' + standardRecordTypeId + 
				'\' AND Status != \'Wrong Person With Company\' AND Status != \'Closed/Lost\' AND ' + 
				'Status != \'Company Unqualified\' AND Status != \'PD will not call\' AND ' + 
				'isConverted = false AND isDeleted = false AND ' + 
				'LastModifiedDate < ' + nDaysAgoString;
				//'LastModifiedDate < ' + nDaysAgoString + ' LIMIT 10';

		String emilyId = '00530000000sGAF';
		newOwnerId = '00580000005Jm9X';
		querystring = 'SELECT Id, LeadsManager__Leads_Manager__c, OwnerId FROM Lead ' +
				'WHERE OwnerId != \'' + philipHallId + '\' AND OwnerId != \'' + jonCerinoId + 
				'\' AND RecordTypeId = \'' + standardRecordTypeId + 
				'\' AND Status != \'Wrong Person With Company\' AND Status != \'Closed/Lost\' AND ' +
				'Status != \'Company Unqualified\' AND Status != \'PD will not call\' AND ' +
				'OwnerId = \'' + emilyId + '\' LIMIT 5';
*/				
		leadReassignment reassign = new leadReassignment();
		reassign.query = querystring; 
		reassign.nDays = nDays;
		reassign.newOwnerId = newOwnerId;
		Id batchprocessId = Database.executeBatch(reassign, 500);
	}
}