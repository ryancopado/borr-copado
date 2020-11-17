trigger CCSub_RollUp on Contract_Committee_Submittal__c (after delete, after insert, after undelete, after update) {
	
	//Fields to roll up for all approved Contract Committee Submittal records
	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsApproved = 
		new list<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'Approved_Amount_to_Spend__c', 'Approved_Development_Budget__c')
		};
	
	//Fire the appropriate triggers on Insert, Update and Delete     
	if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
		list<Contract_Committee_Submittal__c> records = new list<Contract_Committee_Submittal__c>();
		
		if (trigger.isUpdate) {
			for (Integer i=0; i<trigger.new.size(); i++) {
                if ( (trigger.new[i].Approved_Amount_to_Spend__c != trigger.old[i].Approved_Amount_to_Spend__c) ||
					 (trigger.new[i].Status__c != trigger.old[i].Status__c) ||
					 (trigger.new[i].Project__c != trigger.old[i].Project__c) ) {
					records.add(trigger.new[i]);
				}
			}
		} else {
			records.addAll(trigger.new);
		}
		
		if (!records.isEmpty()) { 
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApproved, records, 'Contract_Committee_Submittal__c', 'Project__c', 'AcctSeed__Project__c', ' and Status__c = \'Approved\'');
		}
	}
	
    //Fire slightly differently on Delete
    if (trigger.isDelete) {
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApproved, trigger.old, 'Contract_Committee_Submittal__c', 'Project__c', 'AcctSeed__Project__c', ' and Status__c = \'Approved\''); 
	}
}