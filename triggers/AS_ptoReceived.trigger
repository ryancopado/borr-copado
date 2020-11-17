trigger AS_ptoReceived on AcctSeed__Project__c (after insert, after update) {
	
	/*
	 *	If the Overall Project Status has just be set to "Construction Completed" call createAssets to create asset
	 *	records for each product if there isn't an asset record already.
	 *
	 *	If the PTO Date has changed, call assetWarranty to update the warranty information
	 *	of the asset record
	 */
	/*
	if (approveELI.IsRecursiveUpdate == null) {
		approveELI.IsRecursiveUpdate = false;
	}
	
	if (approveELI.IsRecursiveUpdate == false) {
		
		List<AcctSeed__Project__c> proAssetCreate = new List<AcctSeed__Project__c>();
		List<AcctSeed__Project__c> proAssetUpdate = new List<AcctSeed__Project__c>();
		
		for (AcctSeed__Project__c p :trigger.new) {
			
			if (p.Overall_Project_Status__c == 'Construction Completed') {
				if (trigger.isInsert) {
					proAssetCreate.add(p);
				}
				
				if (trigger.isUpdate) {
					if (trigger.oldMap.get(p.Id).Overall_Project_Status__c != 'Construction Completed') {
						proAssetCreate.add(p);
					} else {
						if (p.PTO_Date__c != trigger.oldMap.get(p.Id).PTO_Date__c) {
							proAssetUpdate.add(p);
						}
					}
				}
			}
		}
		
		if (!proAssetCreate.isEmpty()) {
			autoAssets.createAssets(proAssetCreate);
		}
		
		if (!proAssetUpdate.isEmpty()) {
			autoAssets.assetWarranty(proAssetUpdate);
		}
	}
	*/
 }