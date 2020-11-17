trigger ProjectProductRollUp on Project_Products__c (after delete, after insert, after undelete, after update) {
	
	/*
	 *	Performs roll up sums of various fields on Project Product records to related records
	 *
	 */

	//Fields to roll up for all Project Products
	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
		new list<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'Total_Watts_STC__c', 'Project_Size_Watts_STC__c')
		};
	
	//Fire the appropriate triggers on Insert, Update and Delete     
	if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
		list<Project_Products__c> records = new list<Project_Products__c> ();
		
		if (trigger.isUpdate) {
			for (integer i=0; i<trigger.new.size(); i++) {
				if ( (trigger.new[i].get('Watts_STC__c') != trigger.old[i].get('Watts_STC__c')) || 
					 (trigger.new[i].get('Product__c') != trigger.old[i].get('Product__c')) || 
					 (trigger.new[i].get('Site__c') != trigger.old[i].get('Site__c')) || 
					 (trigger.new[i].get('Quantity__c') != trigger.old[i].get('Quantity__c')) ) {
					records.add(trigger.new[i]);
					
					if (trigger.new[i].get('Site__c') != trigger.old[i].get('Site__c')) {
						records.add(trigger.old[i]);
					}
				}
			}
		} else {
			records.addAll(trigger.new);
		}
		
		if (!records.isEmpty()) {  
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'Project_Products__c', 'Site__c', 'Site__c', '');
		}
	}
	
	//Fire slightly differently on Delete
	if (trigger.isDelete) {
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'Project_Products__c', 'Site__c', 'Site__c', '');
	}
}