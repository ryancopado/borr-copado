trigger projectBoxFolder on AcctSeed__Project__c (after insert) {
	
	/*
	 *	Create box folders and sub folders for new Projects - note: this will only 
	 *	happen for the first Project being inserted (it's the only way
	 *	to stay under the SFDC max callout limit of 100).
	 *
	 */
	
	// Get the record type and box folder information for this object
	String allRecordTypes = '**all**';
	Map<Id, Schema.RecordTypeInfo> rtMapById = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosById();
	Set<String> rtBoxFolders = new Set<String>();
	List<AutomaticBoxFolders__c> autoBoxFolderList = AutomaticBoxFolders__c.getall().values();
	for (AutomaticBoxFolders__c bf :autoBoxFolderList) {
		if (bf.Object_API_Name__c == 'AcctSeed__Project__c' && bf.IsActive__c) {
			if (!rtBoxFolders.contains(bf.Record_Type_Label__c)) {
				rtBoxFolders.add(bf.Record_Type_Label__c);
			}
		}
	}
	
	List<Id> pIds = new List<Id>();
	for (AcctSeed__Project__c p :trigger.new) {
		if (rtMapById.containsKey(p.RecordTypeId)) {
			if (rtBoxFolders.contains(allRecordTypes) || rtBoxFolders.contains(rtMapById.get(p.RecordTypeId).getName())) {
				pIds.add(p.Id);
			}
		}
	}
	
	// Create box folders - can only do this for one record
	if (!pIds.isEmpty()) {
		
		system.debug('*****projectBoxFolder Ids of inserted Projects that need box folders created: ' + pIds);
		system.debug('*****projectBoxFolder creating box folders for Project Id: ' + pIds[0]);
		
		BatchBoxFolders BBF =  new BatchBoxFolders();
		BBF.bbfQueryString = 'SELECT Id, Box_Folders__c, Box_Most_Recent_Error__c From AcctSeed__Project__c WHERE Id = \'' + pIds[0] + '\'';
		BBF.objectName = 'AcctSeed__Project__c';
		BBF.recordId = pIds[0];
		Database.executeBatch(BBF, 1);
	}
}