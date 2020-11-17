trigger BillingLineRollUp on AcctSeed__Billing_Line__c (after delete, after insert, after update, after undelete) {
   
    //Fields to roll up for all BillingLines
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Total__c', 'Roll_Up_Billed_To_Date__c')
        };
        
        
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllProject = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Total__c', 'To_Date_Billed__c')
        };
    
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsPaid = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Total__c', 'Roll_Up_Billed_To_Date_Paid__c')
        };

	//Fields to roll up for all Billing Lines - roll up to Retention
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsRetentionBL = 
		new list<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Total__c', 'Roll_Up_Billing_Lines__c')
        }; 
	
	//Fields to roll up for EPC Billing Lines - roll up to Project
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsEPC = 
		new list<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'Billing_Amount_Received__c', 'EPC_Payment_Received__c')
        };
        
    //Fire the appropriate triggers on Insert, Update and Delete 
    list<AcctSeed__Billing_Line__c> records = new list<AcctSeed__Billing_Line__c> (); 
    list<AcctSeed__Billing_Line__c> epcList = new list<AcctSeed__Billing_Line__c> ();    
    if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete){
        
        if(trigger.isUpdate){
            for(integer i=0;i<trigger.new.size();i++){
                /*
                if ( (trigger.new[i].AcctSeed__Total__c != trigger.old[i].AcctSeed__Total__c) ||
					 (trigger.new[i].Billing_Amount_Received__c != trigger.old[i].Billing_Amount_Received__c) ) {
                    records.add(trigger.new[i]);
                }
                */
                if (trigger.new[i].AcctSeed__Total__c != trigger.old[i].AcctSeed__Total__c) {
                    records.add(trigger.new[i]);
                }
                if ( (trigger.new[i].Retention__c != trigger.old[i].Retention__c) ||
                	 (trigger.new[i].AcctSeed__Project_Task__c != trigger.old[i].AcctSeed__Project_Task__c) ||
                	 (trigger.new[i].AcctSeed__Project__c != trigger.old[i].AcctSeed__Project__c) ) {
                	records.add(trigger.new[i]);
                	records.add(trigger.old[i]);
                }
                if (trigger.new[i].AcctSeed__Project__c != trigger.old[i].AcctSeed__Project__c) {
                	epcList.add(trigger.new[i]);
                	epcList.add(trigger.old[i]);
                }
            }
        }else{
            records.addAll(trigger.new);
            epcList.addAll(trigger.new);
        }
    }
    
    String EPCglaFilter = '';
    String idString = '';
    if (!epcList.isEmpty() || trigger.isDelete) {
		
		//Query filter for GL Account
		List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
		glaList = [select Id, Name from AcctSeed__GL_Account__c where Name like '3000%' or Name like '3001%' or Name like '1202%'];
		for (AcctSeed__GL_Account__c gla :glaList) {
			if (gla.Name.startsWith('3000') || gla.Name.startsWith('3001') || gla.Name.startsWith('1202')) {
				if (EPCglaFilter == '') {
					EPCglaFilter = ' and (AcctSeed__Revenue_GL_Account__c = \'' + gla.Id + '\'';
				} else {
					EPCglaFilter += ' or AcctSeed__Revenue_GL_Account__c = \'' + gla.Id + '\'';
				}
			}
		}
		if (EPCglaFilter != '') {
			EPCglaFilter += ')';
		}
		
		// Limit Billing Line records summed up to the Project for fieldDefinitionsEPC so that
		// there is only one Billing Line record in the list to sum that has the same associated Billing and Project records
		
		List<AcctSeed__Billing_Line__c> recordsProject = new List<AcctSeed__Billing_Line__c>();
		List<Id> pIds = new List<Id>();
		List<AcctSeed__Billing_Line__c> recordsEPC = new List<AcctSeed__Billing_Line__c>();
		Boolean inList;
		if (trigger.isDelete) {
			for (AcctSeed__Billing_Line__c bl :trigger.old) {
				if (bl.AcctSeed__Project__c != null) {
					pIds.add(bl.AcctSeed__Project__c);
				}
			}
		} else {
			for (AcctSeed__Billing_Line__c bl :epcList) {
				if (bl.AcctSeed__Project__c != null) {
					pIds.add(bl.AcctSeed__Project__c);
				}
			}
		}
		if (!pIds.isEmpty()) {
			// First get all Billing Line records associated with the Project(s)
			recordsProject = [select id, Billing_Amount_Received__c, AcctSeed__Billing__c, AcctSeed__Project__c from AcctSeed__Billing_Line__c where AcctSeed__Project__c in :pIds];
			for (AcctSeed__Billing_Line__c bl :recordsProject) {
				inList = false;
				for (AcctSeed__Billing_Line__c blEPC :recordsEPC) {
					if (blEPC.AcctSeed__Billing__c == bl.AcctSeed__Billing__c && blEPC.AcctSeed__Project__c == bl.AcctSeed__Project__c) {
						inList = true;
					}
				}
				if (!inList) {
					if (recordsEPC.isEmpty()) {
						idString = ' and (Id=\'' + bl.Id + '\'';
					} else {
						idString += 'or Id=\'' + bl.Id + '\'';
					}
					recordsEPC.add(bl);
				}
			}
			if (idString.length() > 0) {
				idString += ')';
			}
		}
    }
	
	if (!records.isEmpty()) {
		
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Parent_Status__c = \'Posted\' and ( NOT AcctSeed__Project_Task__r.Name LIKE \'Ret%\') and AcctSeed__Revenue_GL_Account__r.Name LIKE \'3000%\'');
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllProject, records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Parent_Status__c = \'Posted\' and (AcctSeed__Revenue_GL_Account__r.Name LIKE \'3000%\' or AcctSeed__Revenue_GL_Account__r.Name LIKE \'1202%\')');
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPaid, records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and (NOT AcctSeed__Project_Task__r.Name LIKE \'Ret%\') and AcctSeed__Billing__r.AcctSeed__Balance__c = 0');
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsRetentionBL, records, 'AcctSeed__Billing_Line__c', 'Retention__c', 'Retention__c', ' and AcctSeed__Billing__r.AcctSeed__Status__c != \'Rejected\' and AcctSeed__Billing__r.AcctSeed__Status__c != \'Recalled\'');
		
		/*
		if (idString.length() > 0) {
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsEPC, records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', EPCglaFilter + idString);
		}
		*/
	}
		
	if (!epcList.isEmpty() && idString.length() > 0) {
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsEPC, epcList, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', EPCglaFilter + idString);
	}
	
	if (trigger.isDelete) {
		
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Parent_Status__c = \'Posted\' and ( NOT AcctSeed__Project_Task__r.Name LIKE \'Ret%\') and AcctSeed__Revenue_GL_Account__r.Name LIKE \'3000%\'');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllProject, trigger.old, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Parent_Status__c = \'Posted\' and (AcctSeed__Revenue_GL_Account__r.Name LIKE \'3000%\' or AcctSeed__Revenue_GL_Account__r.Name LIKE \'1202%\')'); 
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPaid, trigger.old, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and (NOT AcctSeed__Project_Task__r.Name LIKE \'Ret%\')  and AcctSeed__Billing__r.AcctSeed__Balance__c = 0');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsRetentionBL, trigger.old, 'AcctSeed__Billing_Line__c', 'Retention__c', 'Retention__c', ' and AcctSeed__Billing__r.AcctSeed__Status__c != \'Rejected\' and AcctSeed__Billing__r.AcctSeed__Status__c != \'Recalled\'');
        
		if (idString.length() > 0) {
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsEPC, trigger.old, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', EPCglaFilter + idString);
		}
	}
}