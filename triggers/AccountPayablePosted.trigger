trigger AccountPayablePosted on AcctSeed__Account_Payable__c (before update, before delete) {
    
    // Before update - set the rollup flag so that the batch job will execute the rollups later
    if (trigger.isUpdate) {
        for (AcctSeed__Account_Payable__c ap :trigger.new) {
            if (  ap.AcctSeed__Status__c != trigger.oldMap.get(ap.Id).AcctSeed__Status__c || 
                  ap.AcctSeed__Payment_Status__c != trigger.oldMap.get(ap.Id).AcctSeed__Payment_Status__c  ) {
                ap.Do_RollUp__c = true;
            }
        }
    }
    
    // Before delete - set the Amount field of all child AP Line records to zero so that
    // AccountPayableLineRollUp.trigger will fire and perform the roll up of all the AP Line fields.
    if (trigger.isDelete) {
        List<AcctSeed__Account_Payable_Line__c> delrecords = new List<AcctSeed__Account_Payable_Line__c>();
        delrecords = [select Id, AcctSeed__Amount__c, AcctSeed__Account_Payable__c, AcctSeed__Project__c from AcctSeed__Account_Payable_Line__c where AcctSeed__Account_Payable__c in :trigger.oldMap.keySet()];
        for (AcctSeed__Account_Payable_Line__c apl :delrecords) {
            apl.AcctSeed__Amount__c = 0;
        }
        if (!delrecords.isEmpty()) {
            update delrecords;
        }
    }
}

/*
trigger AccountPayablePosted on AcctSeed__Account_Payable__c (after update, before delete) {
    
    // If after update trigger, perform a roll up of the associated AP Line records
    if (trigger.isUpdate) {
    	List<String> APIds = new List<String>();
    	list<AcctSeed__Account_Payable__c> aprecords = new list<AcctSeed__Account_Payable__c> ();
    
    	for(integer i=0;i<trigger.new.size();i++) {
        	if (trigger.new[i].get('AcctSeed__Status__c') != trigger.old[i].get('AcctSeed__Status__c') || 
        		//trigger.new[i].AcctSeed__Paid_Amount__c != trigger.old[i].AcctSeed__Paid_Amount__c ||
        		trigger.new[i].get('AcctSeed__Payment_Status__c') != trigger.old[i].get('AcctSeed__Payment_Status__c')) {
            	aprecords.add(trigger.new[i]);
        	}
    	}
    
    	for(AcctSeed__Account_Payable__c Ap:aprecords) {
        	APIds.add(Ap.Id);
    	}

    	List<AcctSeed__Account_Payable_Line__c> records = new List<AcctSeed__Account_Payable_Line__c>();
    	List<AcctSeed__Account_Payable_Line__c> recordsSolar = new List<AcctSeed__Account_Payable_Line__c>();
    	List<AcctSeed__Account_Payable_Line__c> recordsModule = new List<AcctSeed__Account_Payable_Line__c>();
    	records = [select id, AcctSeed__Amount__c, AcctSeed__Account_Payable__c, AcctSeed__Project__c, AcctSeed__Project_Task__c, Change_Order__c, Retention__c, Use_Old_CC__c from AcctSeed__Account_Payable_Line__c where AcctSeed__Account_Payable__c in:APIds];
    	for (AcctSeed__Account_Payable_Line__c apl :records) {
    		if (apl.Use_Old_CC__c) {
    			recordsSolar.add(apl);
    		} else {
    			recordsModule.add(apl);
    		}
    	}
      
		//Fields to roll up for Posted Account Payable Lines
		list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsPosted = 
			new list<RollUpSummaryUtility.fieldDefinition> {
				new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Account_Payable_Line_Amount__c')
				//new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Account_Payable__r.AcctSeed__Paid_Amount__c', 'Roll_Up_Account_Payable_Line_Amount__c')
			};
     	
     	//Fields to roll up for all Account Payable Lines
    	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolar = 
        	new list<RollUpSummaryUtility.fieldDefinition> {
            	new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Solar_Account_Payable_Lines__c')
        	}; 
   
    	//Fields to roll up for all Account Payable Lines
    	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        	new list<RollUpSummaryUtility.fieldDefinition> {
            	new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_All_Account_Payable_Lines__c')
        	};
        
        //Fields to roll up for all Account Payable Lines that are on hold
		list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllHold = 
			new list<RollUpSummaryUtility.fieldDefinition> {
				new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'On_Hold_Invoices__c')
			};
      
		//Fields to roll up for all Account Payable Lines
    	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllCO = 
        	new list<RollUpSummaryUtility.fieldDefinition> {
            	new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'AP_Line_CO_Total__c')
        	}; 
	
		//Fields to roll up for all Account Payable Lines - roll up to Retention
    	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsRetentionAPL = 
			new list<RollUpSummaryUtility.fieldDefinition> {
				new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_AP_Lines__c')
        	}; 
	
		if(!records.isEmpty()) {
			
			//Query filter for GL Account
            List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
            glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
            String glaFilter = '';
            if (glaList.size() > 0) {
            	glaFilter += ' and (AcctSeed__Expense_GL_Account__c = \'' + glaList[0].Id + '\'';
            	for (Integer i=1; i<glaList.size(); i++) {
					glaFilter += ' or AcctSeed__Expense_GL_Account__c = \'' + glaList[i].Id + '\'';
				}
            	glaFilter += ')';
            }
            
            // Query filter for Line Item record type
			List<RecordType> liRtList = new List<RecordType>([select Id from RecordType 
						where Name = 'Budget Line Item' and SobjectType = 'AcctSeed__Project_Task__c']);
			String liFilter = '';
			if (!liRtList.isEmpty()) {
				liFilter = ' and AcctSeed__Project_Task__r.RecordTypeId = \'' + liRtList[0].Id + '\'';
			}
			
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPosted, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Partially Paid\')');
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\'' + glaFilter + liFilter);
			
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllCO, records, 'AcctSeed__Account_Payable_Line__c', 'Change_Order__c', 'Con_req__c', ' and (AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\') and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Unpaid\')');
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsRetentionAPL, records, 'AcctSeed__Account_Payable_Line__c', 'Retention__c', 'Retention__c', ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\'');
			
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\' and AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Canceled\'' + glaFilter);
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllHold, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'ON HOLD\'');
			
			// Set up the Cost Code filters
			RollUpSummaryUtility.costCodeIdFilters ccIdFilters = new RollUpSummaryUtility.costCodeIdFilters();
			String moduleFilter = '';
			if (ccIdFilters.moduleIdFilter != '') {
				moduleFilter = ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.moduleIdFilter;
			}
			String solarModuleFilter = '';
			if (ccIdFilters.solarModuleIdFilter != '') {
				solarModuleFilter = ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.solarModuleIdFilter;
			}
			
			if (!recordsSolar.isEmpty()) {
				RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsSolar, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', solarModuleFilter);
			}
			if (!recordsModule.isEmpty()) {
				RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsModule, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', moduleFilter);
			}
			
			// Added By Madan - Jan 18, 2017(To correct Purhcase Order Line Rollup amount values)
			AccountPayableLineRollUp.setAccountPayableStatusChanged = new Set<Id>();
			for(AcctSeed__Account_Payable_Line__c apl:records) {
				AccountPayableLineRollUp.setAccountPayableStatusChanged.add(apl.Id);
			}
			update records;
		}
    }
    
    // If trigger is before delete, must first set the Amount field of all child AP Line records to zero so that
    // AccountPayableLineRollUp will fire and perform the roll up of all the AP Line fields.
    if (trigger.isDelete) {
    	List<AcctSeed__Account_Payable_Line__c> delrecords = new List<AcctSeed__Account_Payable_Line__c>();
    	delrecords = [select Id, AcctSeed__Amount__c, AcctSeed__Account_Payable__c, AcctSeed__Project__c from AcctSeed__Account_Payable_Line__c where AcctSeed__Account_Payable__c in :trigger.oldMap.keySet()];
    	for (AcctSeed__Account_Payable_Line__c apl : delrecords) {
    		apl.AcctSeed__Amount__c = 0;
    	}
    	if (!delrecords.isEmpty()) {
    		update delrecords;
    	}
    }
}
*/