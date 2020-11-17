trigger ProjectTaskRollUp on AcctSeed__Project_Task__c (after delete, after insert, after update, after undelete) {

     //Retrieve the Id of the Budget Line Item RecordType         
     Id rtId = [select Id from RecordType where name='Budget Line Item' and SObjectType='AcctSeed__Project_Task__c' limit 1].Id; 
          
	// Set up the Cost Code filters
	RollUpSummaryUtility.costCodeIdFilters ccIdFilters = new RollUpSummaryUtility.costCodeIdFilters();
	String projectTasksOHFilter = ' and RecordTypeId = \'' + rtId + '\'';
	if (ccIdFilters.ohIdFilter != '') {
		projectTasksOHFilter = projectTasksOHFilter + ' and Cost_Code__c in ' + ccIdFilters.ohIdFilter;
	}
	String budgetTasksNotSGAFilter = ' and RecordTypeId = \'' + rtId + '\'';
	if (ccIdFilters.sgaIdFilter != '') {
		budgetTasksNotSGAFilter = budgetTasksNotSGAFilter + ' and Cost_Code__c not in ' + ccIdFilters.sgaIdFilter;
	}
	String projectTasksModuleFilter = ' and Name != \'Retainage-Sub\'';
	if (ccIdFilters.moduleIdFilter != '') {
		projectTasksModuleFilter = projectTasksModuleFilter + ' and Cost_Code__c in ' + ccIdFilters.moduleIdFilter;
	}
	String projectTasksSolarFilter = ' and Name != \'Retainage-Sub\'';
	if (ccIdFilters.solarModuleIdFilter != '') {
		projectTasksSolarFilter = projectTasksSolarFilter + ' and Cost_Code__c in ' + ccIdFilters.solarModuleIdFilter;
	}
	//system.debug('*****ProjectTaskRollUp projectTasksOHFilter = ' + projectTasksOHFilter);
	//system.debug('*****ProjectTaskRollUp budgetTasksNotSGAFilter = ' + budgetTasksNotSGAFilter);
	//system.debug('*****ProjectTaskRollUp projectTasksModuleFilter = ' + projectTasksModuleFilter);
	//system.debug('*****ProjectTaskRollUp projectTasksSolarFilter = ' + projectTasksSolarFilter);
        
	//Fields to roll up for all Budget Types
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsBudgetAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Budgeted_Amount__c', 'Roll_Up_Budget_Line_Items__c')
        };       
        
    //Fields to roll up for Budget Type not Category SGA
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsBudgetNotSGA = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Budgeted_Amount__c', 'Roll_Up_Budget_Tasks_not_OH__c')
        };
        
    //Fields to roll up for all Project Types of Category OH
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllOH = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Budgeted_Amount__c', 'Roll_Up_Project_Tasks_with_Category_OH__c'),
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Roll_Up_Journal_Entry_Debit__c', 'Roll_Up_Budget_Tasks_OH_Debits__c')
        };        
        
    //Fields to roll up for all Project Types of Category Solar Module
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllSolarMod = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Budgeted_Amount__c', 'Roll_Up_Solar_Module_Project_Tasks__c'),
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Roll_Up_Purchase_Order_Line_Totals__c', 'Roll_Up_Solar_Modules_Cost__c')
        };  
        
    //Fields to roll up for all Project Types
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Roll_Up_Journal_Entry_Debit__c', 'Roll_Up_Accumulated_Direct_Cost__c')
        }; 
        
        
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllExeptRetention = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Roll_Up_Billed_To_Date__c', 'Roll_Up_Billed_To_Date__c')
        }; 
        
	list<AcctSeed__Project_Task__c> recordsOldSolarMod = new list<AcctSeed__Project_Task__c>();
	list<AcctSeed__Project_Task__c> recordsNewSolarMod = new list<AcctSeed__Project_Task__c>();
    
    //Fire the appropriate triggers on Insert, Update and Delete     
    if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
        
        list<AcctSeed__Project_Task__c> recordsBudgetAll = new list<AcctSeed__Project_Task__c> ();
        list<AcctSeed__Project_Task__c> recordsBudgetNotSGA = new list<AcctSeed__Project_Task__c> ();
        list<AcctSeed__Project_Task__c> recordsAllOH = new list<AcctSeed__Project_Task__c> ();
        //list<AcctSeed__Project_Task__c> recordsAllSolarMod = new list<AcctSeed__Project_Task__c> ();
        list<AcctSeed__Project_Task__c> recordsAll = new list<AcctSeed__Project_Task__c> ();
        list<AcctSeed__Project_Task__c> recordsAllExceptRetention = new list<AcctSeed__Project_Task__c> ();
        
        if(trigger.isUpdate){
            for(integer i=0;i<trigger.new.size();i++){
                if(trigger.new[i].get('AcctSeed__Budgeted_Amount__c') != trigger.old[i].get('AcctSeed__Budgeted_Amount__c')){
                    recordsBudgetAll.add(trigger.new[i]);
                }
                
                if(trigger.new[i].get('AcctSeed__Budgeted_Amount__c') != trigger.old[i].get('AcctSeed__Budgeted_Amount__c')){
                    recordsBudgetNotSGA.add(trigger.new[i]);
                }
                
                if((trigger.new[i].get('AcctSeed__Budgeted_Amount__c') != trigger.old[i].get('AcctSeed__Budgeted_Amount__c')) || (trigger.new[i].get('Roll_Up_Journal_Entry_Debit__c') != trigger.old[i].get('Roll_Up_Journal_Entry_Debit__c'))){
                    recordsAllOH.add(trigger.new[i]);
                }
                
				if ((trigger.new[i].get('AcctSeed__Budgeted_Amount__c') != trigger.old[i].get('AcctSeed__Budgeted_Amount__c')) || (trigger.new[i].get('Roll_Up_Purchase_Order_Line_Totals__c') != trigger.old[i].get('Roll_Up_Purchase_Order_Line_Totals__c'))) {
					//recordsAllSolarMod.add(trigger.new[i]);
					if (trigger.new[i].Use_Old_CC__c) {
						recordsOldSolarMod.add(trigger.new[i]);
					} else {
						recordsNewSolarMod.add(trigger.new[i]);
					}
                }
                
                if (trigger.new[i].get('Roll_Up_Journal_Entry_Debit__c') != trigger.old[i].get('Roll_Up_Journal_Entry_Debit__c')) {
                    recordsAll.add(trigger.new[i]);
                }
                
                if (trigger.new[i].get('Roll_Up_Billed_To_Date__c') != trigger.old[i].get('Roll_Up_Billed_To_Date__c')) {
                    recordsAllExceptRetention.add(trigger.new[i]);
                }            
            }
            
        } else {
        	
            /*
            recordsBudgetAll.addAll(trigger.new);
            recordsBudgetNotSGA.addAll(trigger.new);
            recordsAllOH.addAll(trigger.new);
            recordsAll.addAll(trigger.new);
            //recordsAllSolarMod.addAll(trigger.new);
            for (Integer i=0; i<trigger.new.size(); i++) {
            	if (trigger.new[i].Use_Old_CC__c) {
					recordsOldSolarMod.add(trigger.new[i]);
				} else {
					recordsNewSolarMod.add(trigger.new[i]);
				}
            }
            */
            
            // Trigger is insert - only do roll ups if roll up fields have values in them
            for (AcctSeed__Project_Task__c pt :trigger.new) {
            	if (pt.AcctSeed__Budgeted_Amount__c != null && pt.AcctSeed__Budgeted_Amount__c != 0) {
            		recordsBudgetAll.add(pt);
            		recordsBudgetNotSGA.add(pt);
            		recordsAllOH.add(pt);
            		if (pt.Use_Old_CC__c) {
            			recordsOldSolarMod.add(pt);
            		} else {
            			recordsNewSolarMod.add(pt);
            		}
            	} else {
            		if (pt.Roll_Up_Purchase_Order_Line_Totals__c != null && pt.Roll_Up_Purchase_Order_Line_Totals__c != 0) {
            			if (pt.Use_Old_CC__c) {
            				recordsOldSolarMod.add(pt);
            			} else {
            				recordsNewSolarMod.add(pt);
            			}
            		}
            	}
            	if (pt.Roll_Up_Journal_Entry_Debit__c != null && pt.Roll_Up_Journal_Entry_Debit__c != 0) {
            		if (pt.AcctSeed__Budgeted_Amount__c == null || pt.AcctSeed__Budgeted_Amount__c == 0) {
            			recordsAllOH.add(pt);
            		}
            		recordsAll.add(pt);
            	}
            	if (pt.Roll_Up_Billed_To_Date__c != null && pt.Roll_Up_Billed_To_Date__c != 0) {
            		recordsAllExceptRetention.add(pt);
            	}
            }
        }
        
        if(!recordsBudgetAll.isEmpty()){  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsBudgetAll, recordsBudgetAll, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and RecordTypeId = \'' + rtId + '\'');
        }

        if(!recordsBudgetNotSGA.isEmpty()){  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsBudgetNotSGA, recordsBudgetNotSGA, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', budgetTasksNotSGAFilter);
        }
        
        if(!recordsAllOH.isEmpty()){  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllOH, recordsAllOH, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', projectTasksOHFilter);
        }
/*        
        if(!recordsAllSolarMod.isEmpty()){  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllSolarMod, recordsAllSolarMod, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', projectTasksSolarModFilter);
        }
*/        
        //system.debug('*****ProjectTaskRollUp recordsOldSolarMod.size = ' + recordsOldSolarMod.size());
        if (!recordsOldSolarMod.isEmpty()) {  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllSolarMod, recordsOldSolarMod, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', projectTasksSolarFilter);
        }
        //system.debug('*****ProjectTaskRollUp recordsNewSolarMod.size = ' + recordsNewSolarMod.size());
        if (!recordsNewSolarMod.isEmpty()) {  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllSolarMod, recordsNewSolarMod, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', projectTasksModuleFilter);
        }
        
        if (!recordsAll.isEmpty()) {  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, recordsAll, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', '');
        }
        
        if (!recordsAllExceptRetention.isEmpty()) {  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllExeptRetention, recordsAllExceptRetention, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and ( NOT Name LIKE \'Ret%\')');
            //RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllExeptRetention, recordsAllExceptRetention, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and Name != \'Retention Billing\'  and Name != \'Retainage-Sub\'');
        }
    }
     
    //Fire slightly differently on Delete
    if (trigger.isDelete) {
         
		for (Integer i=0; i<trigger.old.size(); i++) {
			if (trigger.old[i].Use_Old_CC__c) {
				recordsOldSolarMod.add(trigger.old[i]);
			} else {
				recordsNewSolarMod.add(trigger.old[i]);
			}
		}
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsBudgetAll, trigger.old, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', 'and RecordTypeId = \'' + rtId + '\'');
  
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsBudgetNotSGA, trigger.old, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', budgetTasksNotSGAFilter);

        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllOH, trigger.old, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', projectTasksOHFilter);
        
        //RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllSolarMod, trigger.old, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', projectTasksSolarModFilter);
        if (!recordsOldSolarMod.isEmpty()) {  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllSolarMod, recordsOldSolarMod, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', projectTasksSolarFilter);
        }
        if (!recordsNewSolarMod.isEmpty()) {  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllSolarMod, recordsNewSolarMod, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', projectTasksModuleFilter);
        }

        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', '');
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllExeptRetention, trigger.old, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and ( NOT Name LIKE \'Ret%\')');
        //RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllExeptRetention, trigger.old, 'AcctSeed__Project_Task__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and Name != \'Retention Billing\'  and Name != \'Retainage-Sub\'');
    }
}