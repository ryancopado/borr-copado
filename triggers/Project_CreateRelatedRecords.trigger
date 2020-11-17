trigger Project_CreateRelatedRecords on AcctSeed__Project__c (after update) {
	
	/*
	 *	Create a Sales Order and Site records related to the Project.  If this is
	 *	the first Project created for an Opportunity, associate all Sites connected to
	 *	the Opportunity to the Project, otherwise simply create one Site for the new
	 *	Project.
	 *
	 *	If the Project is of record type O&M Project do not create Site records.
	 *
	 */
	/*
	Set<Id> oppIds = new Set<Id>();
	Map<Id, AcctSeed__Project__c> pSiteMap = new Map<Id, AcctSeed__Project__c>();
	Map<Id, AcctSeed__Project__c> pSOMap = new Map<Id, AcctSeed__Project__c>();
	List<Site__c> siteUpList = new List<Site__c>();
	List<AcctSeedERP__Sales_Order__c> soCreate = new List<AcctSeedERP__Sales_Order__c>();
	Map<Id,Schema.RecordTypeInfo> rtMapById = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosById();
	
	// Only create Sites for Projects with an Opportunity and only create  Sales Orders for Projects 
	// with an Opportunity and an Account
	for (AcctSeed__Project__c p :trigger.new) {
		if (p.AcctSeed__Opportunity__c != null) {
			if (p.AcctSeed__Account__c != null) {
				pSOMap.put(p.Id, p);
			}
			
			if (rtMapById.containsKey(p.RecordTypeId) && rtMapById.get(p.RecordTypeId).getName() != 'O&M Project') {
				pSiteMap.put(p.Id, p);
				oppIds.add(p.AcctSeed__Opportunity__c);
			}
		}
	}
	
	// Determine if we need to create new Site records or simply relate the Site records from the Opportunity to the Project
	if (!oppIds.isEmpty()) {
		List<Site__c> siteList = new List<Site__c>();
		siteList = [select Id, Opportunity__c, Project__c from Site__c where Opportunity__c in :oppIds or Project__c in :pSiteMap.keySet()];
		for (Site__c s :siteList) {
			if (pSiteMap.containsKey(s.Project__c)) {
				pSiteMap.remove(s.Project__c);
				oppIds.remove(s.Opportunity__c);
			}
		}
		//
		//pSiteMap only contains trigger Projects that do not have Sites associated with them
		//
		
		// Count up the number of Projects per Opportunity and number of Sites per Opportunity
		if (!pSiteMap.isEmpty()) {
			List<AcctSeed__Project__c> pList = new List<AcctSeed__Project__c>();
			Map<Id, Integer> oppProjMap = new Map<Id, Integer>();
			Map<Id, Integer> oppSiteMap = new Map<Id, Integer>();
			pList = [select Id, AcctSeed__Opportunity__c from AcctSeed__Project__c where AcctSeed__Opportunity__c in :oppIds];
			for (AcctSeed__Project__c p :pList) {
				if (oppProjMap.containsKey(p.AcctSeed__Opportunity__c)) {
					oppProjMap.put(p.AcctSeed__Opportunity__c, oppProjMap.get(p.AcctSeed__Opportunity__c) + 1);
				} else {
					oppProjMap.put(p.AcctSeed__Opportunity__c, 1);
				}
			}
			for (Site__c s :siteList) {
				if (s.Opportunity__c != null) {
					if (oppSiteMap.containsKey(s.Opportunity__c)) {
						oppSiteMap.put(s.Opportunity__c, oppSiteMap.get(s.Opportunity__c) + 1);
					} else {
						oppSiteMap.put(s.Opportunity__c, 1);
					}
				}
			}
			
			system.debug('*****Project_CreateRelatedRecords isInsert = ' + trigger.isInsert + ' oppProjMap.size = ' + oppProjMap.size() + ' oppSiteMap.size = ' + oppSiteMap.size());
			for (Id i :oppProjMap.keySet()) {
				system.debug('*****Project_CreateRelatedRecords oppProjMap Id = ' + i + ' number of projects = ' + oppProjMap.get(i));
			}
			for (Id i :oppSiteMap.keySet()) {
				system.debug('*****Project_CreateRelatedRecords oppSiteMap Id = ' + i + ' number of projects = ' + oppSiteMap.get(i));
			}
			
			for (AcctSeed__Project__c p :pSiteMap.values()) {
				// If this is the first Project created for an Opportunity, associate all Sites 
				// connected to the Opportunity to the Project, otherwise simply create one Site for the new Project.
				if (oppProjMap.containsKey(p.AcctSeed__Opportunity__c) && oppProjMap.get(p.AcctSeed__Opportunity__c) == 1 &&
					oppSiteMap.containsKey(p.AcctSeed__Opportunity__c)) {
					for (Site__c s :siteList) {
						if (s.Opportunity__c == p.AcctSeed__Opportunity__c) {
							s.Project__c = p.Id;
							siteUpList.add(s);
						}
					}
				} else {
					// Either this is not the first Project for the Opportunity or there are no Sites associated
					// with the Opportunity - create a Site record for each Project
					siteUpList.add(new Site__c(
						Project__c = p.Id,
						Name = p.Name.left(71) + ' - Site 1')
					);
				}
			}
		}
	}
	
	// Create a Sales Order for each Project if it doesn't already have one
	if (!pSOMap.isEmpty()) {
		List<AcctSeedERP__Sales_Order__c> soList = new List<AcctSeedERP__Sales_Order__c>();
		Map<Id, AcctSeedERP__Sales_Order__c> soMap = new Map<Id, AcctSeedERP__Sales_Order__c>();
		soList = [select Id, Project__c from AcctSeedERP__Sales_Order__c where Project__c in: pSOMap.keySet()];
		for (AcctSeedERP__Sales_Order__c so : soList) {
			if (!soMap.containsKey(so.Project__c)) {
				soMap.put(so.Project__c, so);
			}
		}
	
		// Create a Sales Order record for each Project without one
		for (AcctSeed__Project__c p : pSOMap.values()) {
			if (!soMap.containsKey(p.Id)) {
				soCreate.add(new AcctSeedERP__Sales_Order__c(
					Project__c = p.Id,
					AcctSeedERP__Opportunity__c = p.AcctSeed__Opportunity__c,
					AcctSeedERP__Customer__c = p.AcctSeed__Account__c)
				);
			}
		}
	}
		
	if (!soCreate.isEmpty()) {
		insert soCreate;
	}
	
	integer newSites = 0;
	integer updatedSites = 0;
	for (Site__c s :siteUpList) {
		if (s.Id == null) {
			newSites++;
		} else {
			updatedSites++;
		}
	}
	system.debug('*****Project_CreateRelatedRecords newSites = ' + newSites + ' updatedSites = ' + updatedSites + ' total Sites = ' + siteUpList.size());
	
	if (!siteUpList.isEmpty()) {
		upsert siteUpList;
	}
	*/
}