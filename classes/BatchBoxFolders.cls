global class BatchBoxFolders implements Database.Batchable<sObject>, Database.AllowsCallouts {
	
	/*
	 *	This batch job works on a single record Id. It calls BoxHandler.createFolders to create up to 
	 *	maxFolders Box folders (see BoxHandler.createFolders for the maxFolders) for the record Id and then based
	 *	upon the return value, it will reschedule itself to create the next set of maxFolders. It will continue 
	 *	to do this until either an error is encountered or all of the folders have been created. This approach
	 *	is necessary to stay under the http callout limit when a particular record requires many Box folders created.
	 *
	 */
	
	public String bbfQueryString;
	public String objectName;
	public String recordId;
	
	public class BoxMostRecentErrorException extends Exception {}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(bbfQueryString);
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> records) {
		
		system.debug('*****BatchBoxFolders number of records to process = ' + records.size());
		
		BoxHandler.createFolders(records[0].Id);
	}
	
	global void finish(Database.BatchableContext BC) {
    	
		// Get the status of the batch job just completed
		AsyncApexJob a = [select Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email from AsyncApexJob where Id =: BC.getJobId()];
		
		// Determine if there are more Box folders to create for recordId.
		// Get the list of Box folders created so far
		String queryString = 'SELECT Id, RecordTypeId, Box_Folders__c, Box_Most_Recent_Error__c From ' + objectName + ' WHERE Id = \'' + recordId + '\'';
		SObject sObj = (SObject)Type.forName(objectName).newInstance();
		sObj = Database.query(queryString);
		String rtId = String.valueOf(sObj.get('RecordTypeId'));
		String boxFolders = String.valueOf(sObj.get('Box_Folders__c'));
		String boxError	= String.valueOf(sObj.get('Box_Most_Recent_Error__c'));
		List<BoxHandler.BoxFolderInfo> bfInfoList = new List<BoxHandler.BoxFolderInfo>();
		if (String.isNotBlank(boxFolders)) {
			bfInfoList = (List<BoxHandler.BoxFolderInfo>)JSON.deserialize(boxFolders, List<BoxHandler.BoxFolderInfo>.class);
		}
		
		// Get the record types for the object and the entire list of Box folders to create
		queryString = 'SELECT Id, Name FROM RecordType WHERE SobjectType=\'' + objectName + '\'';
		List<RecordType> rtList = new List<RecordType>();
		rtList = Database.query(queryString);
		Map<Id, RecordType> rtMap = new Map<Id, RecordType>();
		for (RecordType rt :rtList) {
			rtMap.put(rt.Id, rt);
		}
		
		String allRecordTypes = '**all**';
		Map<String, AutomaticBoxFolders__c> autoBoxFolderMap = new Map<String, AutomaticBoxFolders__c>();
		List<AutomaticBoxFolders__c> autoBoxFolderList = AutomaticBoxFolders__c.getall().values();
		for (AutomaticBoxFolders__c bf :autoBoxFolderList) {
			if (bf.IsActive__c && bf.Object_API_Name__c == objectName) {
				if (bf.Record_Type_Label__c == allRecordTypes || (rtMap.containsKey(rtId) && bf.Record_Type_Label__c == rtMap.get(rtId).Name)) {
					autoBoxFolderMap.put(bf.Name, bf);
				}
			}
		}
		
		// Set reschedule time for another run if required
		DateTime nextRunTime = system.now().addMinutes(1);
		String cronString = nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
							nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
							nextRunTime.month() + ' ? ' + nextRunTime.year();
		
		system.debug('*****BatchBoxFolders finish box folders created so far = ' + bfInfoList.size() + ' total box folders to create = ' + autoBoxFolderMap.size() + ' boxError = ' + boxError + ' NumberOfErrors = ' + a.NumberOfErrors);
		
		if (String.isNotBlank(boxError) || a.NumberOfErrors != 0) {
			throw new BoxMostRecentErrorException('Error while creating Box folders for record Id ' + recordId + ' - most recent Box error: ' + boxError + ', batch job number of errors: ' + a.NumberOfErrors);
		} else {
			if (bfInfoList.size() < autoBoxFolderMap.size()) {
				if (!Test.isRunningTest()) {
					System.schedule(ScheduleBatchBoxFolders.class.getName() + '-' + recordId + '-' + nextRunTime.format(), cronString, new ScheduleBatchBoxFolders(objectName, recordId));
				}
			}
		}
	}
}