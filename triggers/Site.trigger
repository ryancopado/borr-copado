trigger Site on Site__c (before update, after insert, after undelete, after update) {
	
	/*
	 *	General purpose trigger for the Site__c object.
	 *
	 *	Before Update
	 *		- Don't allow changes to the Project lookup on a Site record unless the Project lookup is null.
	 *
	 *	After Insert, Undelete
	 *		- Create a new Accounting Variable record for each new Site record. This
	 *		is used by the Time Card functionality.
	 *
	 *	After Update
	 *		- If the name or the project of the Site changed, change the name and project of the corresponding Accounting Variable.
	 *		- Update fields on Inspection Checklist records that are copied from the related Site record
	 *		- Update ship to fields on related Con Req Group if necessary
	 *		- Update fields on the related O&M Project if corresponding field changed on Site record
	 *
	 *
	 */
	
	if (trigger.isBefore && trigger.isUpdate) {
		for (Site__c s :trigger.new) {
			if (s.Project__c != trigger.oldMap.get(s.Id).Project__c && trigger.oldMap.get(s.Id).Project__c != null) {
				s.addError('The Project field cannot be changed.');
			}
		}
	}
	
	if (trigger.isAfter && (trigger.isInsert || trigger.isUnDelete)) {
		List<AcctSeed__Accounting_Variable__c> avList = new List<AcctSeed__Accounting_Variable__c>();
		for (Site__c s :trigger.new) {
			avList.add(new AcctSeed__Accounting_Variable__c(
				Name = s.Name,
				Site__c = s.Id,
				Project__c = s.Project__c,
				AcctSeed__Active__c = true,
				AcctSeed__Type__c = 'Time Card Variable 2')
			);
		}
		
		if (!avList.isEmpty()) {
			insert avList;
		}
	}
	
	// Make updates to related Accounting Variable, Inspection Checklist, and Con Req Group records if necessary
	if (trigger.isAfter && trigger.isUpdate) {
		Set<Id> avSiteIds = new Set<Id>();
		Set<Id> icSiteIds = new Set<Id>();
		Set<Id> crgSiteIds = new Set<Id>();
		Set<Id> pSiteIds = new Set<Id>();
		Map<String, EPCSiteToOMProject__c> fieldMap = EPCSiteToOMProject__c.getAll();
		
		for (Site__c s :trigger.new) {
			if (s.Name != trigger.oldMap.get(s.Id).Name || s.Project__c != trigger.oldMap.get(s.Id).Project__c) {
				avSiteIds.add(s.Id);
			}
			
			if ( (s.Project_Manager__c != trigger.oldMap.get(s.Id).Project_Manager__c) ||
				 (s.Electrical_Engineer__c != trigger.oldMap.get(s.Id).Electrical_Engineer__c) ||
				 (s.Structural_Engineer__c != trigger.oldMap.get(s.Id).Structural_Engineer__c) ||
				 (s.Senior_Design_Engineer__c != trigger.oldMap.get(s.Id).Senior_Design_Engineer__c) ||
				 (s.Civil_Engineer__c != trigger.oldMap.get(s.Id).Civil_Engineer__c) ||
				 (s.Site_Superintendent__c != trigger.oldMap.get(s.Id).Site_Superintendent__c) ) {
				icSiteIds.add(s.Id);
			}
			
			if ( (s.Site_Address__c != trigger.oldMap.get(s.Id).Site_Address__c) || 
				 (s.Site_City__c != trigger.oldMap.get(s.Id).Site_City__c) || 
				 (s.Site_State__c != trigger.oldMap.get(s.Id).Site_State__c) || 
				 (s.Site_Zip__c != trigger.oldMap.get(s.Id).Site_Zip__c) ) {
				crgSiteIds.add(s.Id);
			}
			
			for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
				if (s.get(spfm.Site_Field__c) != trigger.oldMap.get(s.Id).get(spfm.Site_Field__c)) {
					pSiteIds.add(s.Id);
					break;
				}
			}
		}
		
		if (!avSiteIds.isEmpty()) {
			List<AcctSeed__Accounting_Variable__c> avList = new List<AcctSeed__Accounting_Variable__c>();
			avList = [select Id, Name, Project__c, Site__c from AcctSeed__Accounting_Variable__c where Site__c in :avSiteIds];
			for (AcctSeed__Accounting_Variable__c av :avList) {
				av.Name = trigger.newMap.get(av.Site__c).Name;
				av.Project__c = trigger.newMap.get(av.Site__c).Project__c;
			}
			
			if (!avList.isEmpty()) {
				update avList;
			}
		}
		
		if (!icSiteIds.isEmpty()) {
			List<Inspection_Checklist__c> icList = new List<Inspection_Checklist__c>();
			icList = [select Id, Site__c, Status__c, Project_Manager__c, Internal_Electrical_Engineer__c, 
					Site_Super__c, Internal_Structural_Contact__c, Senior_Design_Engineer__c, Internal_Civil_Engineer__c 
					from Inspection_Checklist__c where Site__c in :icSiteIds 
					and Status__c != 'Approval Pending' and Status__c != 'Approved'];
			for (Inspection_Checklist__c ic :icList) {
				ic.Project_Manager__c = trigger.newMap.get(ic.Site__c).Project_Manager__c;
	 			ic.Internal_Electrical_Engineer__c = trigger.newMap.get(ic.Site__c).Electrical_Engineer__c;
	 			ic.Internal_Structural_Contact__c = trigger.newMap.get(ic.Site__c).Structural_Engineer__c;
	 			ic.Senior_Design_Engineer__c = trigger.newMap.get(ic.Site__c).Senior_Design_Engineer__c;
	 			ic.Internal_Civil_Engineer__c = trigger.newMap.get(ic.Site__c).Civil_Engineer__c;
	 			ic.Site_Super__c = trigger.newMap.get(ic.Site__c).Site_Superintendent__c;
			}
			
			if (!icList.isEmpty()) {
				update icList;
			}
		}
		
		if (!crgSiteIds.isEmpty()) {
			List<Con_Req_Group__c> crgList = new List<Con_Req_Group__c>();
			crgList = [select Id, Ship_To_Site__c, Ship_To_Street__c, Ship_To_City__c, Ship_To_State__c, Ship_To_Zip__c 
					from Con_Req_Group__c where Ship_To_Site__c in :crgSiteIds];
			for (Con_Req_Group__c crg :crgList) {
				crg.Ship_To_Street__c = trigger.newMap.get(crg.Ship_To_Site__c).Site_Address__c;
				crg.Ship_To_City__c = trigger.newMap.get(crg.Ship_To_Site__c).Site_City__c;
				crg.Ship_To_State__c = trigger.newMap.get(crg.Ship_To_Site__c).Site_State__c;
				crg.Ship_To_Zip__c = trigger.newMap.get(crg.Ship_To_Site__c).Site_Zip__c;
			}
			
			if (!crgList.isEmpty()) {
				update crgList;
			}
		}
		
		if (!pSiteIds.isEmpty()) {
			Map<String, Schema.RecordTypeInfo> rtByNameMap = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosByName();
			String projectQuery = 'SELECT Id, EPC_Site__c, ';
			for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
				projectQuery += spfm.Project_Field__c + ', ';
			}
			projectQuery = projectQuery.removeEnd(', ');
			projectQuery += ' FROM AcctSeed__Project__c WHERE EPC_Site__c IN: pSiteIds AND RecordTypeId = \'' + rtByNameMap.get('O&M Project').getRecordTypeId() + '\'';
			system.debug('*****SiteTrigger projectQuery = ' + projectQuery);
			List<AcctSeed__Project__c> projectList = new List<AcctSeed__Project__c>();
			projectList = Database.query(projectQuery);
			
			for (AcctSeed__Project__c p :projectList) {
				for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
					p.put(spfm.Project_Field__c, trigger.newMap.get(p.EPC_Site__c).get(spfm.Site_Field__c));
				}
			}
			
			if (!projectList.isEmpty()) {
				update projectList;
			}
		}
	}
}