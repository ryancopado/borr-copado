trigger manualAsset on Asset (before insert) {
	
	/* Commented out because no longer necessary (trigger is also deactivated) 2016-10-30
	// Populate Account field from related Contract record if not already set
	if (trigger.isBefore) {
		if (trigger.isInsert) {
			Set<Id> contractIds = new Set<Id>();
			for (Asset a :trigger.new) {
				if (a.Contract__c != null && a.AccountId == null) {
					contractIds.add(a.Contract__c);
				}
			}
			
			if (!contractIds.isEmpty()) {
				Map<Id, Contract> contractMap = new Map<Id, Contract>([select Id, AccountId from Contract where Id in :contractIds]);
				for (Asset a :trigger.new) {
					if (contractMap.containsKey(a.Contract__c)) {
						a.AccountId = contractMap.get(a.Contract__c).AccountId;
					}
				}
			}
		}
	}
	*/
	
	
    /* Entire trigger below commented out because it is no longer necessary - 2016-10-25
    //If an Asset is being created manually, verify that all the proper
    //conditions exist for Asset creation.
    List<Asset> mAssets = new List<Asset>();
    for (Integer i=0; i<Trigger.new.size(); i++) {
        if (Trigger.new[i].Auto_Create__c != true) {
            mAssets.add(Trigger.new[i]);
        } else {
            Trigger.new[i].Auto_Create__c = false;
        }
    }   
    
    //First verify that the Asset record contains the required basic information.
    Map<Id,Schema.RecordTypeInfo> rtAssetMapById = Schema.SObjectType.Asset.getRecordTypeInfosById();
    List<Id> accId = new List<Id>();
    List<Id> oppId = new List<Id>();
    List<Id> p2Id = new List<Id>();
    List<Asset> assets = new List<Asset>();
    for (Integer i=0; i<mAssets.size(); i++) {
        if (mAssets[i].AccountId == null || mAssets[i].Product2Id == null || 
        	(mAssets[i].Opportunity__c == null && (!rtAssetMapById.containsKey(mAssets[i].RecordTypeId) || rtAssetMapById.get(mAssets[i].RecordTypeId).getName() != 'Spare Parts'))) { 
            mAssets[i].addError(' Account, Opportunity, and Product must be filled in.');
        } else {
            assets.add(mAssets[i]);
            accId.add(mAssets[i].AccountId);
            if (mAssets[i].Opportunity__c != null) {
            	oppId.add(mAssets[i].Opportunity__c);
            }
            p2Id.add(mAssets[i].Product2Id);
        }
    }
    
    //Get the Account, Account and Product RecordType, Opportunity, and Project records
    //associated with each Asset record.
    if (assets.size() > 0) {
        Account[] acc = [select Id, RecordTypeId from Account where Id in:accId];
        Opportunity[] opp = [select Id, Type, StageName from Opportunity where Id in:oppId];
        Product2[] p2 = [select Id, RecordTypeId from Product2 where Id in:p2Id];
        SFDC_Project__c[] pro = [select Id, Opportunity__c, Interconnection_Status__c from SFDC_Project__c
                    where Opportunity__c in:oppId];
        List<Id> rtId = new List<Id>();
        Map<Id, Account> accMap = new Map<Id, Account>();
        for (Integer i=0; i<acc.size(); i++) {
            rtId.add(acc[i].RecordTypeId);
            accMap.put(acc[i].Id, acc[i]);
        }
        for (Integer i=0; i<p2.size(); i++) {
            rtId.add(p2[i].RecordTypeId);
        }
        RecordType[] rt = [select Id, Name from RecordType where Id in:rtId];
        Map<Id, RecordType> rtMap = new Map<Id, RecordType>();
        for (Integer i=0; i<rt.size(); i++) {
            rtMap.put(rt[i].Id, rt[i]);
        }
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
        for (Integer i=0; i<opp.size(); i++) {
            oppMap.put(opp[i].Id, opp[i]);
        }
        Map<Id, Product2> p2Map = new Map<Id, Product2>();
        for (Integer i=0; i<p2.size(); i++) {
            p2Map.put(p2[i].Id, p2[i]);
        }
    
        //Verify that the proper conditions exist for creating each Asset record
        for (Integer i=0; i<assets.size(); i++) {
            Boolean projectExists = false;
            for (Integer p=0; p<pro.size(); p++) {
                if (pro[p].Opportunity__c == assets[i].Opportunity__c) {
                    projectExists = true;
                   // if (pro[p].Interconnection_Status__c != 'Permission To Operate') {
                     //   assets[i].addError(' Interconnection Status must be "Permission To Operate".');
                   // }
                }
            }
			//if (projectExists == false) {
                //assets[i].addError(' Opportunity must have an associated Project.');
            //}
            //if (oppMap.get(assets[i].Opportunity__c).StageName != 'Contract Signed') {
                //assets[i].addError(' Opportunity Stage must be "Contract Signed".');
            //}
            //if (oppMap.get(assets[i].Opportunity__c).Type != 'Turnkey System') {
                //assets[i].addError(' Opportunity Type must be "Turnkey System".');
            //}
            //if (rtMap.get(p2Map.get(assets[i].Product2Id).RecordTypeId).Name != 'Inverter') {
                //assets[i].addError(' Product must be of type Inverter.');
            //}
            //if (rtMap.get(accMap.get(assets[i].AccountId).RecordTypeId).Name != 'Customer') {
                //assets[i].addError(' Account RecordType must be "Customer".');
            //}
        }
    }
    */
}