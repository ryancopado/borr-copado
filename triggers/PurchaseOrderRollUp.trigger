trigger PurchaseOrderRollUp on AcctSeedERP__Purchase_Order__c (after delete, after insert, after undelete, after update) {
	
	/*
	 *	Perform roll up sum operations on various Purchase Order fields to fields on parent objects.
	 *
	 */
	
	//Fields to roll up for all Purchase Order records to Terms & Conditions
	List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsTC = 
		new List<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'Total_Volume_Purchased__c', 'Total_Volume_Purchased_Roll_Up__c')
		};
	
	//Fields to roll up for all Purchase Order records to Volume Commitment records
	List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsVC = 
		new List<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'Total_Volume_Purchased__c', 'Total_Volume_Purchased_Roll_Up_kW__c')
		};
	
    //Fire the appropriate triggers on Insert, Update and Delete     
    if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
		List<AcctSeedERP__Purchase_Order__c> records = new List<AcctSeedERP__Purchase_Order__c>();
		
		if (trigger.isUpdate) {
			for (Integer i=0; i<trigger.new.size(); i++) {
				if ( (trigger.new[i].get('Total_Volume_Purchased__c') != trigger.old[i].get('Total_Volume_Purchased__c')) ||
					 (trigger.new[i].get('Volume_Commitment__c') != trigger.old[i].get('Volume_Commitment__c')) || 
					 (trigger.new[i].get('Terms_Conditions__c') != trigger.old[i].get('Terms_Conditions__c')) ) {
					records.add(trigger.new[i]);
				}
				if ( (trigger.new[i].get('Terms_Conditions__c') != trigger.old[i].get('Terms_Conditions__c')) ||
					 (trigger.new[i].get('Volume_Commitment__c') != trigger.old[i].get('Volume_Commitment__c')) ) {
					records.add(trigger.old[i]);
				}
			}
		} else {
			records.addAll(trigger.new);
		}
		
		if (!records.isEmpty()) {  
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsTC, records, 'AcctSeedERP__Purchase_Order__c', 'Terms_Conditions__c', 'Terms_Conditions__c', '');
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsVC, records, 'AcctSeedERP__Purchase_Order__c', 'Volume_Commitment__c', 'Volume_Commitment__c', '');
		}
	}
	
	//Fire slightly differently on Delete
	if (trigger.isDelete) {
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsTC, trigger.old, 'AcctSeedERP__Purchase_Order__c', 'Terms_Conditions__c', 'Terms_Conditions__c', '');
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsVC, trigger.old, 'AcctSeedERP__Purchase_Order__c', 'Volume_Commitment__c', 'Volume_Commitment__c', '');
	}
}