trigger SiteRollUp on Site__c (after delete, after insert, after undelete, after update) {
	
	/*
	 *	Determine the earliest "Mobilization Date" and the latest "PTO Date" on all Site records associated with a Project.
	 *
	 *	Perform a roll up sum on various Site fields to Site parent records.
	 *
	 */
	
	List<Id> pIds = new List<Id>();
	
	// Get all the Project record Ids
	if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
		for (Integer i=0; i<trigger.new.size(); i++) {
			if (trigger.isUpdate) {
				if ( (trigger.new[i].Mobilization_Date__c != trigger.old[i].Mobilization_Date__c) ||
					 (trigger.new[i].PTO_Date__c != trigger.old[i].PTO_Date__c) ) {
					pIds.add(trigger.new[i].Project__c);
				}
				
				if (trigger.new[i].Project__c != trigger.old[i].Project__c) {
					pIds.add(trigger.new[i].Project__c);
					pIds.add(trigger.old[i].Project__c);
				}
			} else {
				pIds.add(trigger.new[i].Project__c);
			}
		}
	}
	
	if (trigger.isDelete) {
		for (Site__c s :trigger.old) {
			pIds.add(s.Project__c);
		}
	}
	
	if (!pIds.isEmpty()) {
		
		// Get all the Project records and their associated Site records
		Map<Id, AcctSeed__Project__c> pMap = new Map<Id, AcctSeed__Project__c>([select Id, First_Mobilization_Date__c, Last_PTO_Date__c from AcctSeed__Project__c where Id in :pIds]);
		Map<Id, Site__c> sMap = new Map<Id, Site__c>([select Id, Mobilization_Date__c, Project__c, PTO_Date__c from Site__c where Project__c in :pMap.keySet()]);
		Boolean updateProjects = false;
		
		// Determine "First Mobilization Date" and "Last PTO Date" for each Project
		for (Site__c s :sMap.values()) {
			if (s.Mobilization_Date__c != null) {
				if (pMap.get(s.Project__c).First_Mobilization_Date__c != null) {
					if (s.Mobilization_Date__c < pMap.get(s.Project__c).First_Mobilization_Date__c) {
						pMap.get(s.Project__c).First_Mobilization_Date__c = s.Mobilization_Date__c;
						updateProjects = true;
					}
				} else {
					pMap.get(s.Project__c).First_Mobilization_Date__c = s.Mobilization_Date__c;
					updateProjects = true;
				}
			}
			
			if (s.PTO_Date__c != null) {
				if (pMap.get(s.Project__c).Last_PTO_Date__c != null) {
					if (s.PTO_Date__c > pMap.get(s.Project__c).Last_PTO_Date__c) {
						pMap.get(s.Project__c).Last_PTO_Date__c = s.PTO_Date__c;
						updateProjects = true;
					}
				} else {
					pMap.get(s.Project__c).Last_PTO_Date__c = s.PTO_Date__c;
					updateProjects = true;
				}
			}
		}
		
		if (updateProjects) {
			update pMap.values();
		}
	}
	
	//Fields to roll up for all Site records
	List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
		new List<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'Project_Size_Watts_STC__c', 'Overall_Project_Size_Watts_STC__c')
		};
	
	//Fire the appropriate triggers on Insert, Update and Delete     
	if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
		List<Site__c> records = new List<Site__c>();
		
		if (trigger.isUpdate) {
			for (integer i=0; i<trigger.new.size(); i++) {
				if ( (trigger.new[i].get('Project_Size_Watts_STC__c') != trigger.old[i].get('Project_Size_Watts_STC__c')) || 
					 (trigger.new[i].get('Project__c') != trigger.old[i].get('Project__c')) ) {
					records.add(trigger.new[i]);
					
					if (trigger.new[i].get('Project__c') != trigger.old[i].get('Project__c')) {
						records.add(trigger.old[i]);
					}
				}
			}
		} else {
			records.addAll(trigger.new);
		}
		
		if (!records.isEmpty()) {  
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'Site__c', 'Project__c', 'AcctSeed__Project__c', '');
		}
	}
	
	//Fire slightly differently on Delete
	if (trigger.isDelete) {
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'Site__c', 'Project__c', 'AcctSeed__Project__c', '');
	}
}