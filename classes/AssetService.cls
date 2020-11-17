public without sharing class AssetService {
	
	/*
	 *	Service class for the Asset object trigger AssetTrigger.trigger.
	 *
	 */
	
	// Populate fields on an Asset from the related Project
	// - before insert, before update
	public static void AssetFromProject(List<Asset> newList, Map<Id, Asset> oldMap, Boolean isInsert) {
		Set<Id> pIds = new Set<Id>();
		Map<Id, Schema.RecordTypeInfo> rtByIdMap = Schema.SObjectType.Asset.getRecordTypeInfosById();
		
		for (Asset a :newList) {
			if (rtByIdMap.containsKey(a.RecordTypeId) && rtByIdMap.get(a.RecordTypeId).getName() == 'Operations Asset') {
				
				if (isInsert) {
					if (a.Project__c != null) {
						pIds.add(a.Project__c);
					}
				}
				
				if (!isInsert) {
					if (a.Project__c != oldMap.get(a.Id).Project__c) {
						if (a.Project__c != null) {
							pIds.add(a.Project__c);
						} else {
							// Clear the fields if Project lookup just set to null
							a.Contract__c = null;	// Clear Contract lookup if Project lookup just set to null
						}
					}
				}
			}
		}
		
		// Set the fields on the Asset from the related Project
		if (!pIds.isEmpty()) {
			Map<Id, AcctSeed__Project__c> projectMap = new Map<Id, AcctSeed__Project__c>([select Id, AcctSeed__Account__c, Contract__c from AcctSeed__Project__c where Id in :pIds]);
			for (Asset a :newList) {
				if (projectMap.containsKey(a.Project__c)) {
					a.AccountId = projectMap.get(a.Project__c).AcctSeed__Account__c;
					a.Contract__c = projectMap.get(a.Project__c).Contract__c;
				}
			}
		}
	}
}