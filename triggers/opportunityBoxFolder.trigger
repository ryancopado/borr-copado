trigger opportunityBoxFolder on Opportunity (after insert) {
	
	/*
	 *	Create box folders and sub folders for new Opportunities - note: this will only 
	 *	happen for the first Opportunity being inserted (it's the only way
	 *	to stay under the SFDC max callout limit of 100).
	 *
	 */
	
	// Get the record type and box folder information for this object
	String allRecordTypes = '**all**';
	Map<Id, Schema.RecordTypeInfo> rtMapById = Schema.SObjectType.Opportunity.getRecordTypeInfosById();
	Set<String> rtBoxFolders = new Set<String>();
	List<AutomaticBoxFolders__c> autoBoxFolderList = AutomaticBoxFolders__c.getall().values();
	for (AutomaticBoxFolders__c bf :autoBoxFolderList) {
		if (bf.Object_API_Name__c == 'Opportunity' && bf.IsActive__c) {
			if (!rtBoxFolders.contains(bf.Record_Type_Label__c)) {
				rtBoxFolders.add(bf.Record_Type_Label__c);
			}
		}
	}
	
	List<Id> oIds = new List<Id>();
	for (Opportunity o :trigger.new) {
		if (rtMapById.containsKey(o.RecordTypeId)) {
			if (rtBoxFolders.contains(allRecordTypes) || rtBoxFolders.contains(rtMapById.get(o.RecordTypeId).getName())) {
				oIds.add(o.Id);
			}
		}
	}
	
	// Create box folders - can only do this for one record
	if (!oIds.isEmpty()) {
		
		system.debug('*****opportunityBoxFolder Ids of inserted Opportunities that need box folders created: ' + oIds);
		system.debug('*****opportunityBoxFolder creating box folders for Opportunity Id: ' + oIds[0]);
		
		BatchBoxFolders BBF =  new BatchBoxFolders();
		BBF.bbfQueryString = 'SELECT Id, Box_Folders__c, Box_Most_Recent_Error__c From Opportunity WHERE Id = \'' + oIds[0] + '\'';
		BBF.objectName = 'Opportunity';
		BBF.recordId = oIds[0];
		Database.executeBatch(BBF, 1);
	}
	
	/*
	// Get the record type and box folder information for this object
	String allRecordTypes = '**all**';
	Map<Id, Schema.RecordTypeInfo> rtMapById = Schema.SObjectType.Opportunity.getRecordTypeInfosById();
	Set<String> rtBoxFolders = new Set<String>();
	List<AutomaticBoxFolders__c> autoBoxFolderList = AutomaticBoxFolders__c.getall().values();
	for (AutomaticBoxFolders__c bf :autoBoxFolderList) {
		if (bf.Object_API_Name__c == 'Opportunity' && bf.IsActive__c) {
			rtBoxFolders.add(bf.Record_Type_Label__c);
		}
	}
	
	List<Id> oppIds = new List<Id>();
	for (Opportunity o :trigger.new) {
		if (rtMapById.containsKey(o.RecordTypeId)) {
			if (rtBoxFolders.contains(rtMapById.get(o.RecordTypeId).getName()) || rtBoxFolders.contains(allRecordTypes)) {
				oppIds.add(o.Id);
			}
		}
	}
	
	// Create any needed box folders
	if (!oppIds.isEmpty()) {
		BoxHandler.createAllFolders(oppIds);
	}
	*/
}