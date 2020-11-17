global class leadReassignment implements Database.Batchable<sObject> {
	
	// Batch apex - looks for all Lead records that have not been "touched" in the last 6 weeks and sets the 
	// Owner field of the Lead and its associated Leads - Company record to Philip Hall. 
	
	public String query;
	public Integer nDays;
	public String newOwnerId;
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		Map<Id, Lead> ldMap = new Map<Id, Lead>();
		List<Task> tkList = new List<Task>();
		List<Id> lcIds = new List<Id>();
		List<LeadsManager__Leads_Manager__c> lcList = new List<LeadsManager__Leads_Manager__c>();
		Map<Id, LeadsManager__Leads_Manager__c> lcMapOlder = new Map<Id, LeadsManager__Leads_Manager__c>();
		Map<Id, LeadsManager__Leads_Manager__c> lcMapNewer = new Map<Id, LeadsManager__Leads_Manager__c>();
		DateTime nDaysAgo;
		
		// Calculate datetime value that is nDays ago and put all the Leads in a map
		nDaysAgo = system.today() - nDays;
		system.debug('*****nDaysAgo = ' + nDaysAgo);
		for (sObject s : scope) {
			Lead ld = (Lead)s;
			ldMap.put(ld.Id, ld);
			//system.debug('*****Lead Id = ' + ld.Id + ' LeadsCompanyId = ' + ld.LeadsManager__Leads_Manager__c);
		}
		system.debug('*****Number of Leads to process = ' + ldMap.size());
		
		// Get the Activity History for our set of Leads so far
		if (!ldMap.isEmpty()) {
			tkList = [select Id, LastModifiedDate, Subject, WhoId 
					from Task where WhoId in :ldMap.keySet() and (not (Subject like 'Pardot%')) and LastModifiedDate >= :nDaysAgo];
		}
		system.debug('*****Number of Tasks to process = ' + tkList.size());
		
		// Discard all Leads that have a Task LastModifiedDate within the last nDays
		for (Task tk : tkList) {
			ldMap.remove(tk.WhoId);
		}
		system.debug('*****Number of Leads after Task processing = ' + ldMap.size());
		
		// Get all the associated "Leads - Company" records
		for (Lead ld : ldMap.values()) {
			lcIds.add(ld.LeadsManager__Leads_Manager__c);
		}
		if (!lcIds.isEmpty()) {
			lcList = [select Id, OwnerId, LastModifiedDate from LeadsManager__Leads_Manager__c where Id in :lcIds];
			
			// Two maps - one for the records that have not been modified in the last nDays, one for
			// those that have been modified in the last nDays.
			for (LeadsManager__Leads_Manager__c lc : lcList) {
				//system.debug('*****LeadsCompany Id = ' + lc.Id + 'LastModifiedDate = ' + lc.LastModifiedDate);
				if (lc.LastModifiedDate < nDaysAgo) {
					lcMapOlder.put(lc.Id, lc);
				} else {
					lcMapNewer.put(lc.Id, lc);
				}
			}
			system.debug('*****Size of lcMapOlder = ' + lcMapOlder.size());
			system.debug('*****Size of lcMapNewer = ' + lcMapNewer.size());
			
			// Discard all Leads associated with a "Leads - Company" record that has been modified in the last nDays
			for (Lead ld : ldMap.values()) {
				if (lcMapNewer.containsKey(ld.LeadsManager__Leads_Manager__c)) {
					ldMap.remove(ld.Id);
				}
			}
		}
		
		// Set ownership of all un-touched records
		for (Lead ld : ldMap.values()) {
			ld.OwnerId = newOwnerId;
		}
		if (!ldMap.isEmpty()) {
			system.debug('*****Number of Leads to reassign = ' + ldMap.size());
			update ldMap.values();
		}
		
		for (LeadsManager__Leads_Manager__c lc : lcMapOlder.values()) {
			lc.OwnerId = newOwnerId;
		}
		if (!lcMapOlder.isEmpty()) {
			system.debug('*****Number of Leads - Company to reassign = ' + lcMapOlder.size());
			update lcMapOlder.values();
		}
	}

	global void finish(Database.BatchableContext BC) {
		AsyncApexJob a = [select Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email 
				from AsyncApexJob where Id =: BC.getJobId()];
		
		// Send an email to the Apex job's submitter notifying of job completion. 
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		//String[] toAddresses = new String[] {a.CreatedBy.Email};
		List<String> toAddresses = new List<String>();
		toAddresses.add(a.CreatedBy.Email);
		toAddresses.add('etam@borregosolar.com');
		mail.setToAddresses(toAddresses);
		mail.setSubject('leadReassignment Record Clean Up Status: ' + a.Status);
		mail.setPlainTextBody('The batch Apex job leadReassignment processed ' + a.TotalJobItems + ' batches with ' + a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
}