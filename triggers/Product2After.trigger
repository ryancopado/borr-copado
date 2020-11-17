trigger Product2After on Product2 (after update) {
	
	/*
	 *	After Update
	 *		- If the Watts (STC) field has changed, copy its value to the Watts (STC) field of related
	 *		Project Product records.
	 *
	 */
	
	List<Id> pIds = new List<Id>();
	for (Product2 p :trigger.new) {
		if (p.Watts_STC__c != trigger.oldMap.get(p.Id).Watts_STC__c) {
			pIds.add(p.Id);
		}
	}
	
	if (!pIds.isEmpty()) {
		List<Project_Products__c> ppList = new List<Project_Products__c>();
		ppList = [select Id, Product__c, Watts_STC__c from Project_Products__c where Product__c in :pIds];
		for (Project_Products__c pp :ppList) {
			pp.Watts_STC__c = trigger.newMap.get(pp.Product__c).Watts_STC__c;
		}
		if (!ppList.isEmpty()) {
			update ppList;
		}
	}
}