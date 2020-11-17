trigger AccountPayableLineRollUp on AcctSeed__Account_Payable_Line__c (after delete, after insert, after update, after undelete) {
	
	// Execute roll ups asynchronously if insert, update or undelete trigger
	if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
		
		Set<Id> ptIds = new Set<Id>();
		Set<Id> pIds = new Set<Id>();
		Set<Id> polIds = new Set<Id>();
		Set<Id> coIds = new Set<Id>();
		Set<Id> rIds = new Set<Id>();
		
		for (Integer i=0; i<trigger.new.size(); i++) {
			if ( (trigger.isInsert) || (trigger.isUnDelete) || 
				 (trigger.new[i].AcctSeed__Amount__c != trigger.old[i].AcctSeed__Amount__c) || 
				 (trigger.new[i].Invoice_Status__c != trigger.old[i].Invoice_Status__c) ||
				 (trigger.isUpdate && AccountPayableLineRollUp.setAccountPayableStatusChanged != null && AccountPayableLineRollUp.setAccountPayableStatusChanged.contains(trigger.new[i].Id)) ) {
				 	
				ptIds.add(trigger.new[i].AcctSeed__Project_Task__c);
				pIds.add(trigger.new[i].AcctSeed__Project__c);
				polIds.add(trigger.new[i].AcctSeedERP__Purchase_Order_Line__c);
				coIds.add(trigger.new[i].Change_Order__c);
				rIds.add(trigger.new[i].Retention__c);
			}
			
			if (trigger.isUpdate) {
				if ( (trigger.new[i].AcctSeed__Project_Task__c != trigger.old[i].AcctSeed__Project_Task__c) || 
					 (trigger.new[i].AcctSeedERP__Purchase_Order_Line__c != trigger.old[i].AcctSeedERP__Purchase_Order_Line__c) || 
					 (trigger.new[i].Change_Order__c != trigger.old[i].Change_Order__c) || 
					 (trigger.new[i].AcctSeed__Expense_GL_Account__c != trigger.old[i].AcctSeed__Expense_GL_Account__c) || 
					 (trigger.new[i].AcctSeed__Project__c != trigger.old[i].AcctSeed__Project__c) || 
					 (trigger.new[i].Retention__c != trigger.old[i].Retention__c) ) {
					ptIds.add(trigger.new[i].AcctSeed__Project_Task__c);
					pIds.add(trigger.new[i].AcctSeed__Project__c);
					polIds.add(trigger.new[i].AcctSeedERP__Purchase_Order_Line__c);
					coIds.add(trigger.new[i].Change_Order__c);
					rIds.add(trigger.new[i].Retention__c);
					
					ptIds.add(trigger.old[i].AcctSeed__Project_Task__c);
					pIds.add(trigger.old[i].AcctSeed__Project__c);
					polIds.add(trigger.old[i].AcctSeedERP__Purchase_Order_Line__c);
					coIds.add(trigger.old[i].Change_Order__c);
					rIds.add(trigger.old[i].Retention__c);
				}
			}
		}
		
		if (!ptIds.isEmpty() || !pIds.isEmpty() || !polIds.isEmpty() || !coIds.isEmpty() || !rIds.isEmpty()) {
			AccountPayableLineRollUp.rollUpAccountPayableLine(ptIds, pIds, polIds, coIds, rIds);
		}
		
		/*
		List<Id> aplIds = new List<Id>();
		for (Integer i=0; i<trigger.new.size(); i++) {
			if (trigger.isUpdate) {
				if (trigger.new[i].AcctSeed__Amount__c != trigger.old[i].AcctSeed__Amount__c) {
					aplIds.add(trigger.new[i].Id);
				}
				if ( (trigger.new[i].AcctSeed__Project_Task__c != trigger.old[i].AcctSeed__Project_Task__c) || 
					 (trigger.new[i].AcctSeedERP__Purchase_Order_Line__c != trigger.old[i].AcctSeedERP__Purchase_Order_Line__c) || 
					 (trigger.new[i].Change_Order__c != trigger.old[i].Change_Order__c) || 
					 (trigger.new[i].AcctSeed__Expense_GL_Account__c != trigger.old[i].AcctSeed__Expense_GL_Account__c) || 
					 (trigger.new[i].Retention__c != trigger.old[i].Retention__c) ) {
					aplIds.add(trigger.new[i].Id);
					aplIds.add(trigger.old[i].Id);
				}
			} else {
				aplIds.add(trigger.new[i].Id);
			}
		}
		
		if (!aplIds.isEmpty()) {
			AccountPayableLineRollUp.rollUpAccountPayableLine(aplIds);
		}
		*/
	}
	
	
    //Fields to roll up for all Account Payable Lines
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolar = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Solar_Account_Payable_Lines__c')
        };
	
	//Fields to roll up for Posted Account Payable Lines
	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsPosted = 
		new list<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Account_Payable_Line_Amount__c')
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
	
	//Fields to roll up for all Account Payable Lines with null CO and null POL - roll up to Project Task
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsNonPOCosts = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Non_PO_Costs_RollUp__c')
        };
	
    //Fire the appropriate triggers on Insert, Update and Delete
    list<AcctSeed__Account_Payable_Line__c> records = new list<AcctSeed__Account_Payable_Line__c> ();
    list<AcctSeed__Account_Payable_Line__c> recordsSolar = new list<AcctSeed__Account_Payable_Line__c> ();
    list<AcctSeed__Account_Payable_Line__c> recordsModule = new list<AcctSeed__Account_Payable_Line__c> ();
    /*
    if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
        
        if (trigger.isUpdate) {
            for (integer i=0;i<trigger.new.size();i++) {
                if (trigger.new[i].AcctSeed__Amount__c != trigger.old[i].AcctSeed__Amount__c) {
                    records.add(trigger.new[i]);
                }
                if ( (trigger.new[i].AcctSeed__Project_Task__c != trigger.old[i].AcctSeed__Project_Task__c) || 
                	 (trigger.new[i].AcctSeedERP__Purchase_Order_Line__c != trigger.old[i].AcctSeedERP__Purchase_Order_Line__c) || 
                	 (trigger.new[i].Change_Order__c != trigger.old[i].Change_Order__c) || 
                	 (trigger.new[i].AcctSeed__Expense_GL_Account__c != trigger.old[i].AcctSeed__Expense_GL_Account__c) || 
                	 (trigger.new[i].Retention__c != trigger.old[i].Retention__c) ) {
                	records.add(trigger.new[i]);
                	records.add(trigger.old[i]);
                }
            }
        } else {
            records.addAll(trigger.new);
        }
		
        for (AcctSeed__Account_Payable_Line__c apl :records) {
        	if (apl.Use_Old_CC__c) {
        		recordsSolar.add(apl);
        	} else {
        		recordsModule.add(apl);
        	}
        }
		
        if (!records.isEmpty()) {
        	
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
        	
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter);
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsNonPOCosts, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and Change_Order__c = null and AcctSeedERP__Purchase_Order_Line__c = null');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPosted, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Partially Paid\')');
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeedERP__Purchase_Order_Line__c', 'AcctSeedERP__Purchase_Order_Line__c', '');
            //RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and (NOT AcctSeed__Expense_GL_Account__r.Name LIKE \'%Retention%\')');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\'' + glaFilter + liFilter);

            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllCO, records, 'AcctSeed__Account_Payable_Line__c', 'Change_Order__c', 'Con_req__c', ' and (AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\') and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Unpaid\')');
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsRetentionAPL, records, 'AcctSeed__Account_Payable_Line__c', 'Retention__c', 'Retention__c', ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\'');
            
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
        } 
    }
    */
     
    //Fire slightly differently on Delete
    if (trigger.isDelete) {
		
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
    	
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and Invoice_Status__c != \'Rejected\'' + glaFilter);
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllHold, trigger.old, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and Invoice_Status__c = \'ON HOLD\'');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsNonPOCosts, trigger.old, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and Change_Order__c = null and AcctSeedERP__Purchase_Order_Line__c = null');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPosted, trigger.old, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Partially Paid\')');
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Account_Payable_Line__c', 'AcctSeedERP__Purchase_Order_Line__c', 'AcctSeedERP__Purchase_Order_Line__c', ''); 
        //RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\' and (NOT AcctSeed__Expense_GL_Account__r.Name LIKE \'%Retention%\')');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and AcctSeed__Account_Payable__r.AcctSeed__Status__c = \'Posted\'' + glaFilter + liFilter);
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllCO, trigger.old, 'AcctSeed__Account_Payable_Line__c', 'Change_Order__c', 'Con_req__c', ' and (AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\') and (AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Paid\' or AcctSeed__Account_Payable__r.AcctSeed__Payment_Status__c = \'Unpaid\')');
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsRetentionAPL, trigger.old, 'AcctSeed__Account_Payable_Line__c', 'Retention__c', 'Retention__c', ' and AcctSeed__Account_Payable__r.AcctSeed__Status__c != \'Rejected\'');
		
		for (AcctSeed__Account_Payable_Line__c apl :trigger.old) {
			if (apl.Use_Old_CC__c) {
				recordsSolar.add(apl);
			} else {
				recordsModule.add(apl);
			}
		}
		
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
    }
}