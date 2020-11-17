trigger SalesOrderLineRollUp on AcctSeedERP__Sales_Order_Line__c (after delete, after insert, after undelete, after update) {


	//Fields to roll up for all PurchaseOrderLines
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Watts__c', 'WATTS_STC__c')
        };
        
        
	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsApprovedCR = 
		new list<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'SOLine_Total__c', 'Requisition_Costs_to_Date__c')
		};
	
	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsConReqGroupAll = 
		new list<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'SOLine_Total__c', 'Requisition_Total_Roll_Up__c')
		};
	
	/*
	list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsConReqGroupRAB = 
		new list<RollUpSummaryUtility.fieldDefinition> {
			new RollUpSummaryUtility.fieldDefinition('SUM', 'Remaining_Available_Budget__c', 'Remaining_Available_Budget_Roll_Up__c')
		};
	*/
        
    //Fire the appropriate triggers on Insert, Update and Delete
    list<AcctSeedERP__Sales_Order_Line__c> crgAllRecords = new list<AcctSeedERP__Sales_Order_Line__c> ();     
    if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
        list<AcctSeedERP__Sales_Order_Line__c> records = new list<AcctSeedERP__Sales_Order_Line__c> ();
        
        if (trigger.isUpdate) {
            for (integer i=0;i<trigger.new.size();i++) {
				if ( (trigger.new[i].Watts__c != trigger.old[i].Watts__c) || 
					 (trigger.new[i].SOLine_Total__c != trigger.old[i].SOLine_Total__c)  || 
					 (trigger.new[i].Status__c != trigger.old[i].Status__c) ) {
					
					records.add(trigger.new[i]);
                }
                if ( (trigger.new[i].SOLine_Total__c != trigger.old[i].SOLine_Total__c)  || 
					 (trigger.new[i].Remaining_Available_Budget__c != trigger.old[i].Remaining_Available_Budget__c)  || 
					 (trigger.new[i].RollUp_Remaining_Available_Budget__c != trigger.old[i].RollUp_Remaining_Available_Budget__c)  || 
					 (trigger.new[i].Con_Req_Group__c != trigger.old[i].Con_Req_Group__c) ) {
					
					crgAllRecords.add(trigger.new[i]);
					
					if (trigger.new[i].Con_Req_Group__c != trigger.old[i].Con_Req_Group__c) {
						crgAllRecords.add(trigger.old[i]);
					}
                }
            }
        } else {
            records.addAll(trigger.new);
            crgAllRecords.addAll(trigger.new);
        }
         
		if (!records.isEmpty()) {  
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeedERP__Sales_Order_Line__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', ' ');
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApprovedCR, records, 'AcctSeedERP__Sales_Order_Line__c', 'AcctSeedERP__Project_Task__c', 'AcctSeed__Project_Task__c', ' and (Status__c = \'New\' or Status__c = \'Pending Approval\' or Status__c = \'Approved\') ');
		}
		if (!crgAllRecords.isEmpty()) {
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsConReqGroupAll, crgAllRecords, 'AcctSeedERP__Sales_Order_Line__c', 'Con_Req_Group__c', 'Con_Req_Group__c', ' ');
        }
    }
    
    /*
    if (trigger.isDelete) {
    	crgAllRecords.addAll(trigger.old);
    }
    
    
    String crIdString = '';
    if (!crgAllRecords.isEmpty()) {
    	// Prepare the subset of Con Req Group records to include in Remaining Available Budget Roll Up
		Set<Id> crgIds = new Set<Id>();
		for (AcctSeedERP__Sales_Order_Line__c cr :crgAllRecords) {
			crgIds.add(cr.Con_Req_Group__c);
		}
		List<AcctSeedERP__Sales_Order_Line__c> crList = new List<AcctSeedERP__Sales_Order_Line__c>();
		crList = [select Id, Name, AcctSeedERP__Project_Task__c, Con_Req_Group__c, Remaining_Available_Budget__c from AcctSeedERP__Sales_Order_Line__c where Con_Req_Group__c in :crgIds];
		
		Set<Id> liIds = new Set<Id>();
		crgIds.clear();
		Set<Id> crIds = new Set<Id>();
		for (AcctSeedERP__Sales_Order_Line__c cr :crList) {
			if (!liIds.contains(cr.AcctSeedERP__Project_Task__c)) {
				crIds.add(cr.Id);
				liIds.add(cr.AcctSeedERP__Project_Task__c);
				crgIds.add(cr.Con_Req_Group__c);
			} else {
				if (!crgIds.contains(cr.Con_Req_Group__c)) {
					crIds.add(cr.Id);
					crgIds.add(cr.Con_Req_Group__c);
				}
			}
			
			//system.debug('***** SalesOrderLineRollUp crIds = ' + crIds + ' crgIds = ' + crgIds + ' liIds = ' + liIds);
			
		}
		
		crIdString = '(';
		if (!crIds.isEmpty()) {
			for (Id crId :crIds) {
				crIdString += '\'' + crId + '\',';
			}
			crIdString = crIdString.removeEnd(',');
			crIdString += ')';
		}
    }
    
    system.debug('***** SalesOrderLineRollUp crIdString = ' + crIdString);
    
    if (String.isNotBlank(crIdString)) {
    	RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsConReqGroupRAB, crgAllRecords, 'AcctSeedERP__Sales_Order_Line__c', 'Con_Req_Group__c', 'Con_Req_Group__c', ' and Id in ' + crIdString);
    }
    */
     
    //Fire slightly differently on Delete
    if (trigger.isDelete) {
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeedERP__Sales_Order_Line__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', '');
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApprovedCR,  trigger.old, 'AcctSeedERP__Sales_Order_Line__c', 'AcctSeedERP__Project_Task__c', 'AcctSeed__Project_Task__c', ' and (Status__c = \'New\' or Status__c = \'Pending Approval\' or Status__c = \'Approved\' )');
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsConReqGroupAll, trigger.old, 'AcctSeedERP__Sales_Order_Line__c', 'Con_Req_Group__c', 'Con_Req_Group__c', ' ');
    }
}