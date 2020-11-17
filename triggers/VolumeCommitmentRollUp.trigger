trigger VolumeCommitmentRollUp on Volume_Commitment__c (after delete, after insert, after undelete, after update) {
	
	/*
	 *	Perform roll up sum operations on various Volume Commitment fields to fields on parent objects.
	 *
	 */
	
	//Fields to roll up for current quarter to Terms & Conditions records
	List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsCurrentQuarter = 
		new List<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'Vendor_Commitment_kW__c', 'Quarterly_Volume_Commitment_kW__c'),
			new RollUpSummaryUtility.fieldDefinition('SUM', 'Total_Volume_Purchased_Roll_Up_kW__c', 'Quarterly_Total_Volume_Purchased_kW__c')
		};
	
	// Determine current year and current quarter to be used in query filter
	String currentYear = String.valueOf(system.today().year());
	Integer currentMonth = system.today().month();
	String currentQuarter;
	if (currentMonth <= 3) {
		currentQuarter = 'Q1';
	} else {
		if (currentMonth <= 6) {
			currentQuarter = 'Q2';
		} else {
			if (currentMonth <= 9) {
				currentQuarter = 'Q3';
			} else {
				currentQuarter = 'Q4';
			}
		}
	}
	
    //Fire the appropriate triggers on Insert, Update and Delete     
    if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
		List<Volume_Commitment__c> records = new List<Volume_Commitment__c>();
		
		if (trigger.isUpdate) {
			for (Integer i=0; i<trigger.new.size(); i++) {
				if ( (trigger.new[i].get('Vendor_Commitment_kW__c') != trigger.old[i].get('Vendor_Commitment_kW__c')) ||
					 (trigger.new[i].get('Total_Volume_Purchased_Roll_Up_kW__c') != trigger.old[i].get('Total_Volume_Purchased_Roll_Up_kW__c')) || 
					 (trigger.new[i].get('Terms_Conditions__c') != trigger.old[i].get('Terms_Conditions__c')) ) {
					records.add(trigger.new[i]);
				}
				if (trigger.new[i].get('Terms_Conditions__c') != trigger.old[i].get('Terms_Conditions__c')) {
					records.add(trigger.old[i]);
				}
			}
		} else {
			records.addAll(trigger.new);
		}
		
		if (!records.isEmpty()) {  
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsCurrentQuarter, records, 'Volume_Commitment__c', 'Terms_Conditions__c', 'Terms_Conditions__c', ' and Year__c = \'' + currentYear + '\' and Quarter__c = \'' + currentQuarter + '\'');
		}
	}
	
	//Fire slightly differently on Delete
	if (trigger.isDelete) {
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsCurrentQuarter, trigger.old, 'Volume_Commitment__c', 'Terms_Conditions__c', 'Terms_Conditions__c', ' and Year__c = \'' + currentYear + '\' and Quarter__c = \'' + currentQuarter + '\'');
	}

}