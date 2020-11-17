trigger InspectionChecklist on Inspection_Checklist__c (before insert, before update) {
	
	/*
	 *	Populate various fields on insert or update of Inspection Checklist records from
	 *	the related Site record.
	 */
	 
	Set<Id> sIds = new Set<Id>();
	for (Inspection_Checklist__c ic :trigger.new) {
		if (ic.Site__c != null) {
			if (trigger.isInsert) {
				sIds.add(ic.Site__c);
			}
			if (trigger.isUpdate && ic.Site__c != trigger.oldMap.get(ic.Id).Site__c) {
				sIds.add(ic.Site__c);
			}
		}
	}
	
	Map<Id, Site__c> sMap;
	if (!sIds.isEmpty()) {
		sMap = new Map<Id, Site__c>([select Id, Project_Manager__c,	
				Electrical_Engineer__c, Structural_Engineer__c, Senior_Design_Engineer__c, 
				Civil_Engineer__c, Site_Superintendent__c from Site__c where Id in :sIds]);
	}
	
	for (Inspection_Checklist__c ic :trigger.new) {
		if (ic.Site__c != null) {
			if (!sIds.isEmpty() && sMap.containsKey(ic.Site__c)) {
				ic.Project_Manager__c = sMap.get(ic.Site__c).Project_Manager__c;
	 			ic.Internal_Electrical_Engineer__c = sMap.get(ic.Site__c).Electrical_Engineer__c;
	 			ic.Internal_Structural_Contact__c = sMap.get(ic.Site__c).Structural_Engineer__c;
	 			ic.Senior_Design_Engineer__c = sMap.get(ic.Site__c).Senior_Design_Engineer__c;
	 			ic.Internal_Civil_Engineer__c = sMap.get(ic.Site__c).Civil_Engineer__c;
	 			ic.Site_Super__c = sMap.get(ic.Site__c).Site_Superintendent__c;
			}
		} else {
			ic.Project_Manager__c = null;
	 		ic.Internal_Electrical_Engineer__c = null;
	 		ic.Internal_Structural_Contact__c = null;
	 		ic.Senior_Design_Engineer__c = null;
	 		ic.Internal_Civil_Engineer__c = null;
	 		ic.Site_Super__c = null;
		}
	}
}