public with sharing class CaseDeepCloneController {
	
	/*
	 *	Methods to support custom Case deep clone including related Components and Maintenance Items
	 *
	 */
	
	private final Case cr;
	
	public Case caseRec {get; set;}
	public Case caseClone {get; set;}
	
	// Initialize by cloning the target Case record
	public CaseDeepCloneController(ApexPages.StandardController stdController) {
		
		this.cr = (Case)stdController.getRecord();
		
		caseRec = [select Id, CaseNumber from Case where Id = :cr.Id];
		Set<Id> cIds = new Set<Id>();
		cIds.add(cr.Id);
		List<sObject> sObjList = readSObjectAllFields('Case', cIds);
		caseRec = (Case)sObjList[0];
		caseClone = caseRec.clone(false, true, false, false);
	}
	
	// Save the cloned Case and clone and save the related Components and Maintenance Items
	public PageReference caseDeepClone() {
		PageReference pr = null;
		
		Set<Id> Ids = new Set<Id>();
		List<sObject> sObjList;
		
		List<Component__c> compList = new List<Component__c>();
		compList = [select Id from Component__c where Case__c = :cr.Id];
		for (Component__c c :compList) {
			Ids.add(c.Id);
		}
		sObjList = readSObjectAllFields('Component__c', Ids);
		Map<Id, Component__c> compMap = new Map<Id, Component__c>();
		Component__c comp;
		for (sObject s :sObjList) {
			comp = (Component__c)s;
			compMap.put(comp.Id, comp);
		}
		
		List<Maintenance_Item__c> maintList = new List<Maintenance_Item__c>();
		maintList = [select Id, Component__c from Maintenance_Item__c where Component__c in :compMap.keySet()];
		Ids.clear();
		for (Maintenance_Item__c m :maintList) {
			Ids.add(m.Id);
		}
		sObjList = readSObjectAllFields('Maintenance_Item__c', Ids);
		Map<Id, Maintenance_Item__c> maintMap = new Map<Id, Maintenance_Item__c>();
		Maintenance_Item__c maint;
		for (sObject s :sObjList) {
			maint = (Maintenance_Item__c)s;
			maintMap.put(maint.Id, maint);
		}
		
		Savepoint sp = Database.setSavepoint();
		try {
			
			// Insert the cloned with changes Case
			caseClone.Status = 'New';
			caseClone.Subject = '';
			caseClone.Description = '';
			caseClone.Performance_Maintenance_Introduction__c = '';
			caseClone.Performance_Maintenance_Conclusion__c = '';
			caseClone.Date_Maintenance_Completed__c = null;
			insert caseClone;
		
			// Insert the cloned with changes Component records if any
			Component__c compClone;
			Map<Id, Component__c> compCloneMap = new Map<Id, Component__c>();
			for (Component__c c :compMap.values()) {
				compClone = c.clone(false, true, false, false);
				compClone.Case__c = caseClone.Id;
				compClone.Summary__c = '';
				compCloneMap.put(c.Id, compClone);
			}
			
			if (!compCloneMap.isEmpty()) {
				insert compCloneMap.values();
				
				// Delete the default Maintenance Items created due to inserting new Component records
				Set<Id> compCloneIds = new Set<Id>();
				for (Component__c c :compCloneMap.values()) {
					compCloneIds.add(c.Id);
				}
				
				List<Maintenance_Item__c> defaultMaintList = new List<Maintenance_Item__c>();
				defaultMaintList = [select Id from Maintenance_Item__c where Component__c in :compCloneIds];
				delete defaultMaintList;
				
				system.debug('*****CaseDeepClone compMap size = ' + compMap.size() + ' compCloneMap size = ' + compCloneMap.size() + ' maintMap size = ' + maintMap.size());
				
				// Insert the cloned and changed Maintenance Items if there are any
				Maintenance_Item__c maintClone;
				List<Maintenance_Item__c> maintCloneList = new List<Maintenance_Item__c>();
				for (Maintenance_Item__c m :maintMap.values()) {
					maintClone = m.clone(false, true, false, false);
					maintClone.Component__c = compCloneMap.get(m.Component__c).Id;
					maintClone.Completed__c = false;
					maintClone.Follow_Up_Required__c = 'No';
					maintCloneList.add(maintClone);
				}
				
				system.debug('*****CaseDeepClone maintCloneList size = ' + maintCloneList.size());
				
				if (!maintCloneList.isEmpty()) {
					insert maintCloneList;
				}
			}
			pr = new PageReference('/' + caseClone.Id + '/e?retURL=/' + caseClone.Id);
			
		} catch(Exception e) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
			Database.rollback(sp);
		}

		return pr;
	}
	
	// Return a list of SObjects with all fields from the supplied Ids
	public static List<sObject> readSObjectAllFields(String sObjName, Set<Id> Ids) {
		
		List<sObject> sObjOutList = new List<sObject>();
		if (String.isNotBlank(sObjName) && !Ids.isEmpty()) {
			
			// Get all the object field names and build the query
			SObjectType objType = Schema.getGlobalDescribe().get(sObjName);
			Map<String, Schema.SObjectField> FieldMap = objType.getDescribe().fields.getMap();
			
			String queryString = 'SELECT';
			for (Schema.SObjectField f : FieldMap.values()) {
				queryString += ' ' + f.getDescribe().getName() + ',';
			}
			queryString = queryString.removeEnd(',');
			
			// Build up the list of Ids for the query
			String IdString = '(';
			for (String Idstr :Ids) {
				IdString += '\'' + Idstr + '\',';
			}
			IdString = IdString.removeEnd(',');
			IdString += ')';
			
			queryString += ' FROM ' + sObjName + ' WHERE Id IN ' + IdString;
			
			system.debug('***** queryString = ' + queryString);
			
			sObjOutList = Database.query(queryString);
		}
		return sObjOutList;
	}
}