trigger Component on Component__c (after insert) {
	
	/*
	 *	After Insert
	 *		Create the standard set of maintenance items based upon the component type.
	 *
	 */
	
	List<String> maintItems = new List<String>();
	List<Maintenance_Item__c> miList = new List<Maintenance_Item__c>();
	Map<String, ComponentToMaintenanceItem__c> ctmMap = ComponentToMaintenanceItem__c.getAll();
	
	for (Component__c cmp :trigger.new) {
		if (ctmMap.containsKey(cmp.Component_Type__c)) {
			maintItems.clear();
			if (String.isNotBlank(ctmMap.get(cmp.Component_Type__c).Pick_List_Values_1__c)) {
				maintItems.addAll(ctmMap.get(cmp.Component_Type__c).Pick_List_Values_1__c.split(';', 0));
			}
			if (String.isNotBlank(ctmMap.get(cmp.Component_Type__c).Pick_List_Values_2__c)) {
				maintItems.addAll(ctmMap.get(cmp.Component_Type__c).Pick_List_Values_1__c.split(';', 0));
			}
			for (String mi :maintItems) {
				miList.add(new Maintenance_Item__c(
					Component__c = cmp.Id,
					Component_Type__c = cmp.Component_Type__c,
					Item__c = mi)
				);
			}
		}
	}
	
	if (!miList.isEmpty()) {
		insert miList;
	}
}