global class BoxHandler {
	
	/*
	 *	Methods to support the automatic creation of Box folders and sub folders for the record
	 *	Id provided. These methods create Box folders and sub-folders based upon the data in 
	 *	custom setting AutomaticBoxFolders. The methods are called from a batch job (BatchBoxFolders).
	 *
	 */
	
	/*
	// Create all folders and subfolders for the given list of record Ids
	@future (callout=true)
	public static void createAllFolders(List<Id> recordIds) {
		String topFolder = 'record_name';
		String allRecordTypes = '**all**';
		
		// Get the object record types
		if (!recordIds.isEmpty()) {
			
			// Get the object type
			Schema.SObjectType objType = recordIds[0].getSObjectType();
			
			// Create a map (rtChildToParentMap) of the Box folders that need to be created for each object record type. 
			// The folders will be listed in the order that they need to be created - parent before child.
			List<AutomaticBoxFolders__c> autoBoxFolderList = AutomaticBoxFolders__c.getall().values();
			Map<String, Map<String, AutomaticBoxFolders__c>> rtCTPMap = new Map<String, Map<String, AutomaticBoxFolders__c>>();
			Map<String, String> rtTopFolderMap = new Map<String, String>();
			for (AutomaticBoxFolders__c bf :autoBoxFolderList) {
				if (bf.IsActive__c && bf.Object_API_Name__c == objType.getDescribe().getName()) {
					if (!rtCTPMap.containsKey(bf.Record_Type_Label__c)) {
						rtCTPMap.put(bf.Record_Type_Label__c, new Map<String, AutomaticBoxFolders__c>());
					}
					rtCTPMap.get(bf.Record_Type_Label__c).put(bf.Name, bf);
					if (bf.Folder__c == topFolder) {
						rtTopFolderMap.put(bf.Record_Type_Label__c, bf.Name);
					}
				}
			}
			
			// Sort the active AutomaticBoxFolders__c records parent before child
			Map<String, AutomaticBoxFolders__c> ctpMap;
			Map<String, AutomaticBoxFolders__c> childToParentMap;
			Map<String, Map<String, AutomaticBoxFolders__c>> rtChildToParentMap = new Map<String, Map<String, AutomaticBoxFolders__c>>();
			for (String rt :rtCTPMap.keySet()) {
				if (rtTopFolderMap.containsKey(rt)) {
					rtChildToParentMap.put(rt, new Map<String, AutomaticBoxFolders__c>());
					childToParentMap = rtChildToParentMap.get(rt);
					ctpMap = rtCTPMap.get(rt);
					childToParentMap.put(rtTopFolderMap.get(rt), ctpMap.get(rtTopFolderMap.get(rt)));
					ctpMap.remove(rtTopFolderMap.get(rt));
					
					while (ctpMap.size() > 0) {
						for (String key :ctpMap.keySet()) {
							if (childToParentMap.containsKey(ctpMap.get(key).Parent_Folder_Key__c)) {
								childToParentMap.put(key, ctpMap.get(key));
								ctpMap.remove(key);
							}
						}
					}
				}
			}
			
			system.debug('*****BoxHandler.createFolders rtChildToParentMap = ' + rtChildToParentMap);
			
			// If we have a sorted list of AutomaticBoxFolders__c records, create the folders
			if (!rtChildToParentMap.isEmpty()) {
				
				// Get the record type names for the object
				String queryString = 'SELECT Id, Name FROM RecordType WHERE SobjectType=\'' + objType + '\'';
				List<RecordType> rtList = new List<RecordType>();
				rtList = Database.query(queryString);
				Map<Id, RecordType> rtMap = new Map<Id, RecordType>();
				for (RecordType rt :rtList) {
					rtMap.put(rt.Id, rt);
				}
				
				// Get the recordtypeIds for each record Id provided
				String IdList = '(';
				for (Id rId :recordIds) {
					IdList += '\'' + rId + '\',';
				}
				IdList = IdList.removeEnd(',') + ')';
				queryString = 'SELECT Id, RecordTypeId FROM ' + objType + ' WHERE Id IN ' + IdList;
				List<SObject> sobjList = new List<SObject>();
				sobjList = Database.query(queryString);
				
				String listType = 'List<' + objType + '>';
				List<SObject> objList = (List<SObject>)Type.forName(listType).newInstance();
				objList.addAll((List<sObject>)sobjList);
				
				// Create Box folders for each record Id provided
				String folderId;
				String rtName;
				Id rtId;
				Id objId;
				Map<String, String> folderIdMap = new Map<String, String>();
				box.Toolkit boxToolkit = new box.Toolkit();
				for (sObject s :objList) {
					rtName = '';
					folderId = null;
					rtId = String.valueOf(s.get('RecordTypeId'));
					objId = String.valueOf(s.get('Id'));
					folderIdMap.clear();
					if (rtMap.containsKey(rtId)) {
						if (rtChildToParentMap.containsKey(allRecordTypes)) {
							rtName = allRecordTypes;
						} else {
							if (rtChildToParentMap.containsKey(rtMap.get(rtId).Name)) {
								rtName = rtMap.get(rtId).Name;
							}
						}
						
						if (String.isNotBlank(rtName) && rtTopFolderMap.containsKey(rtName)) {
							childToParentMap = rtChildToParentMap.get(rtName);
							
							for (String folderKey :childToParentMap.keySet()) {
								
								system.debug('*****BoxHandler.createFolders rtName = ' + rtName + ' folderKey = ' + folderKey + ' folderName = ' + childToParentMap.get(folderKey).Folder__c);
								
								if (folderKey == rtTopFolderMap.get(rtName)) {
									
									// Create the top box folder for this Id
									folderId = boxToolkit.createFolderForRecordId(objId, null, true);
									
								} else {
									
									// Create a sub-folder
									folderId = boxToolkit.createFolder(childToParentMap.get(folderKey).Folder__c, folderIdMap.get(childToParentMap.get(folderKey).Parent_Folder_Key__c), null);
									
								}
								folderIdMap.put(folderKey, folderId);
								
								// Check folder creation success
								if (String.isBlank(folderId)) {
									system.debug('*****BoxHandler failed to create folder ' + childToParentMap.get(folderKey).Folder__c + ' forobject Id = ' + objId + ', most recent box error: ' + boxToolkit.mostRecentError);
									break;
								}
							}
						}
					}
				}
				boxToolkit.commitChanges();
			}
		}
	}
	*/
	
	// Creates box folders on demand (via button) for the record Id supplied
	webService static void onDemandCreateFolders(Id recordId) {
		
		// Get the object name
		String objName = recordId.getSObjectType().getDescribe().getName();
		
		system.debug('*****BoxHandler onDemandCreateFolders for ' + objName + ' Id:' + recordId);
		
		BatchBoxFolders BBF =  new BatchBoxFolders();
		BBF.bbfQueryString = 'SELECT Id, Box_Folders__c, Box_Most_Recent_Error__c From ' + objName + ' WHERE Id = \'' + recordId + '\'';
		BBF.objectName = objName;
		BBF.recordId = recordId;
		Database.executeBatch(BBF, 1);
	}
	
	// Data structure to record folders created for a specific record
	public class BoxFolderInfo {
		public String fKy {get; set;}	// Custom Setting AutomaticBoxFolders Name field
		public String fId {get; set;}	// Box folder Id
		public String fNm {get; set;}	// Box folder Name
		
		public BoxFolderInfo() {
			fKy = null;
			fId = null;
			fNm = null;
		}
		
		public BoxFolderInfo(String folderKey, String folderId, String folderName) {
			fKy = folderKey;
			fId = folderId;
			fNm = folderName;
		}
	}
	
	/*
	// For testing purposes - allows execution from tools like workbench
	@future (callout=true)
	public static void createFoldersOnePass(Id recordId) {
		createFolders(recordId);
	}
	*/
	
	// Create up to maxFolders folders for the given record Id
	public static void createFolders(Id recordId) {
		String topFolder = 'record_name';
		String allRecordTypes = '**all**';
		String mostRecentError = '';
		Integer folderCount = 0;
		Integer maxFolders = 40;	// This value must be low enough to stay under the SFDC callout limit which is 100
		Map<String, AutomaticBoxFolders__c> autoBoxFolderMap = new Map<String, AutomaticBoxFolders__c>();
		
		// Get the object record types
		if (recordId != null) {
			
			// Get the object type
			Schema.SObjectType objType = recordId.getSObjectType();
			
			// Get the record type names for the object
			String queryString = 'SELECT Id, Name FROM RecordType WHERE SobjectType=\'' + objType + '\'';
			List<RecordType> rtList = new List<RecordType>();
			rtList = Database.query(queryString);
			Map<Id, RecordType> rtMap = new Map<Id, RecordType>();
			for (RecordType rt :rtList) {
				rtMap.put(rt.Id, rt);
			}
			
			// Get the recordtypeId and list of box folders created so far
			queryString = 'SELECT Id, RecordTypeId, Box_Folders__c, Box_Most_Recent_Error__c FROM ' + objType + ' WHERE Id = \'' + recordId + '\'';
			SObject sObj = (SObject)Type.forName(objType.getDescribe().getName()).newInstance();
			sObj = Database.query(queryString);
			String rtId = String.valueOf(sObj.get('RecordTypeId'));
			String objId = String.valueOf(sObj.get('Id'));
			String boxFolders = String.valueOf(sObj.get('Box_Folders__c'));
			
			// Create a map of the list of all Box folders that should be created for the recordId
			List<AutomaticBoxFolders__c> autoBoxFolderList = AutomaticBoxFolders__c.getall().values();
			for (AutomaticBoxFolders__c bf :autoBoxFolderList) {
				if (bf.IsActive__c && bf.Object_API_Name__c == objType.getDescribe().getName()) {
					if (bf.Record_Type_Label__c == allRecordTypes || (rtMap.containsKey(rtId) && bf.Record_Type_Label__c == rtMap.get(rtId).Name)) {
						autoBoxFolderMap.put(bf.Name, bf);
					}
				}
			}
			
			// Create a map of Box folders created so far and remove them from the list remaining to create
			List<BoxFolderInfo> bfInfoList = new List<BoxFolderInfo>();
			Map<String, BoxFolderInfo> bfInfoMap = new Map<String, BoxFolderInfo>();
			if (String.isNotBlank(boxFolders)) {
				bfInfoList = (List<BoxFolderInfo>)JSON.deserialize(boxFolders, List<BoxFolderInfo>.class);
				for (BoxFolderInfo bfi :bfInfoList) {
					bfInfoMap.put(bfi.fKy, bfi);
					if (autoBoxFolderMap.containsKey(bfi.fKy)) {
						autoBoxFolderMap.remove(bfi.fKy);
					}
				}
			}
			
			// Create up to maxFolders folders for this record - must stay under callout limit (100)
			String folderId;
			box.Toolkit boxToolkit = new box.Toolkit();
			for (AutomaticBoxFolders__c bf :autoBoxFolderMap.values()) {
				
				if (bf.Folder__c == topFolder || bfInfoMap.containsKey(bf.Parent_Folder_Key__c)) {
					
					system.debug('*****BoxHandler.createFolders objType = ' + objType + ' folderKey = ' + bf.Name + ' folderName = ' + bf.Folder__c);
					
					if (bf.Folder__c == topFolder) {
						
						// Create the top box folder for this Id
						folderId = boxToolkit.createFolderForRecordId(objId, null, true);
						
					} else {
						
						// Create a sub-folder
						folderId = boxToolkit.createFolder(bf.Folder__c, bfInfoMap.get(bf.Parent_Folder_Key__c).fId, null);
						
					}
					
					// Check folder creation success
					if (String.isBlank(folderId)) {
						mostRecentError = boxToolkit.mostRecentError;
						system.debug('*****BoxHandler failed to create folder ' + bf.Folder__c + ' for object Id = ' + objId + ', most recent box error: ' + mostRecentError);
						break;
					} else {
						bfInfoMap.put(bf.Name, new BoxFolderInfo(bf.Name, folderId, bf.Folder__c));
						autoBoxFolderMap.remove(bf.Name);
						folderCount++;
					}
				}
				
				// Break out of our folder create loop if we have created the maximum number of folders
				if (folderCount >= maxFolders) {
					break;
				}
			}
			
			if (folderCount > 0) {
				boxToolkit.commitChanges();
			}
			
			if (!bfInfoMap.isEmpty()) {
				sObj.put('Box_Folders__c', JSON.serialize(bfInfoMap.values()));
			} else {
				sObj.put('Box_Folders__c', '');
			}
			sObj.put('Box_Most_Recent_Error__c', mostRecentError);
			update sObj;
		}
		
		system.debug('*****BoxHandler.createFolders folderCount = ' + folderCount + ' remaining folders to create = ' + autoBoxFolderMap.size());
		
	}
}