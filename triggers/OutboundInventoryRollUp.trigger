trigger OutboundInventoryRollUp on AcctSeedERP__Outbound_Inventory_Movement__c (after delete, after insert, after update, after undelete) {
   
    //Fields to roll up for all Outbound Inventory Movements associated with Project Tasks
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsProjectTask = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Value__c', 'Roll_Up_Out_Bound_Inventory_Movements__c')
        };
    
    //Fields to roll up for all Outbound Inventory Lines
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Value__c', 'Roll_Up_Outbound_Inventory_Movement_Ttl__c')
        };
    
     //Fields to roll up for all Outbound Inventory Lines
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolar = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Value__c', 'Roll_Up_Solar_Outbound_Inventory_Movemen__c')
        };
        
    //Fire the appropriate triggers on Insert, Update and Delete
	list<AcctSeedERP__Outbound_Inventory_Movement__c> records = new list<AcctSeedERP__Outbound_Inventory_Movement__c>();
	list<AcctSeedERP__Outbound_Inventory_Movement__c> recordsSolar = new list<AcctSeedERP__Outbound_Inventory_Movement__c>();
	list<AcctSeedERP__Outbound_Inventory_Movement__c> recordsModule = new list<AcctSeedERP__Outbound_Inventory_Movement__c>();
    if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
        
        if (trigger.isUpdate) {
            for (integer i=0;i<trigger.new.size();i++) {
                if ( (trigger.new[i].Value__c != trigger.old[i].Value__c) || 
                	 (trigger.new[i].AcctSeedERP__Debit_GL_Account__c != trigger.old[i].AcctSeedERP__Debit_GL_Account__c) ||
                	 (trigger.new[i].AcctSeedERP__Project__c != trigger.old[i].AcctSeedERP__Project__c) ) {
                    records.add(trigger.new[i]);
                }
                if (trigger.new[i].AcctSeedERP__Project__c != trigger.old[i].AcctSeedERP__Project__c) {
                    records.add(trigger.old[i]);
                }
            }
        } else {
            records.addAll(trigger.new);
        }
         
        if (!records.isEmpty()) { 
			
			// Set the list of records for the roll ups with the Cost Code filters
			for (AcctSeedERP__Outbound_Inventory_Movement__c oim :records) {
				if (oim.Use_Old_CC__c) {
					recordsSolar.add(oim);
				} else {
					recordsModule.add(oim);
				}
			}
			
            //Query filter for GL Account
            List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
            glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
            String glaFilter = '';
            if (glaList.size() > 0) {
            	glaFilter += ' and (AcctSeedERP__Debit_GL_Account__c = \'' + glaList[0].Id + '\'';
            	for (Integer i=1; i<glaList.size(); i++) {
            		glaFilter += ' or AcctSeedERP__Debit_GL_Account__c = \'' + glaList[i].Id + '\'';
            	}
            	glaFilter += ')';
            }
            
            // Query filter for Line Item record type
			List<RecordType> liRtList = new List<RecordType>([select Id from RecordType 
						where Name = 'Budget Line Item' and SobjectType = 'AcctSeed__Project_Task__c']);
			String liFilter = '';
			if (!liRtList.isEmpty()) {
				liFilter = ' and AcctSeedERP__Project_Task__r.RecordTypeId = \'' + liRtList[0].Id + '\'';
			}
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsProjectTask, records, 'AcctSeedERP__Outbound_Inventory_Movement__c', 'AcctSeedERP__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter);
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeedERP__Outbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', glaFilter + liFilter);
			
			// Set up the Cost Code filters
			RollUpSummaryUtility.costCodeIdFilters ccIdFilters = new RollUpSummaryUtility.costCodeIdFilters();
			String moduleFilter = glaFilter;
			if (ccIdFilters.moduleIdFilter != '') {
				moduleFilter = moduleFilter + ' and AcctSeedERP__Project_Task__r.Cost_Code__c in ' + ccIdFilters.moduleIdFilter;
			}
			String solarModuleFilter = glaFilter;
			if (ccIdFilters.solarModuleIdFilter != '') {
				solarModuleFilter = solarModuleFilter + ' and AcctSeedERP__Project_Task__r.Cost_Code__c in ' + ccIdFilters.solarModuleIdFilter;
			}
			
			if (!recordsSolar.isEmpty()) {
				RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsSolar, 'AcctSeedERP__Outbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', solarModuleFilter);
			}
			if (!recordsModule.isEmpty()) {
				RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsModule, 'AcctSeedERP__Outbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', moduleFilter);
			}
        }
    }
     
    //Fire slightly differently on Delete
    if (trigger.isDelete) {
         
        //Query filter for GL Account
		List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
		glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
		String glaFilter = '';
		if (glaList.size() > 0) {
			glaFilter += ' and (AcctSeedERP__Debit_GL_Account__c = \'' + glaList[0].Id + '\'';
			for (Integer i=1; i<glaList.size(); i++) {
				glaFilter += ' or AcctSeedERP__Debit_GL_Account__c = \'' + glaList[i].Id + '\'';
			}
			glaFilter += ')';
		}
		
		// Query filter for Line Item record type
		List<RecordType> liRtList = new List<RecordType>([select Id from RecordType 
				where Name = 'Budget Line Item' and SobjectType = 'AcctSeed__Project_Task__c']);
		String liFilter = '';
		if (!liRtList.isEmpty()) {
			liFilter = ' and AcctSeedERP__Project_Task__r.RecordTypeId = \'' + liRtList[0].Id + '\'';
		}
		
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsProjectTask, trigger.old, 'AcctSeedERP__Outbound_Inventory_Movement__c', 'AcctSeedERP__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter);
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeedERP__Outbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', glaFilter + liFilter);
		
		// Set the list of records for the roll ups with the Cost Code filters
		for (AcctSeedERP__Outbound_Inventory_Movement__c oim :trigger.old) {
			if (oim.Use_Old_CC__c) {
				recordsSolar.add(oim);
			} else {
				recordsModule.add(oim);
			}
		}
		
		// Set up the Cost Code filters
		RollUpSummaryUtility.costCodeIdFilters ccIdFilters = new RollUpSummaryUtility.costCodeIdFilters();
		String moduleFilter = glaFilter;
		if (ccIdFilters.moduleIdFilter != '') {
			moduleFilter = moduleFilter + ' and AcctSeedERP__Project_Task__r.Cost_Code__c in ' + ccIdFilters.moduleIdFilter;
		}
		String solarModuleFilter = glaFilter;
		if (ccIdFilters.solarModuleIdFilter != '') {
			solarModuleFilter = solarModuleFilter + ' and AcctSeedERP__Project_Task__r.Cost_Code__c in ' + ccIdFilters.solarModuleIdFilter;
		}
		
		if (!recordsSolar.isEmpty()) {
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsSolar, 'AcctSeedERP__Outbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', solarModuleFilter);
		}
		if (!recordsModule.isEmpty()) {
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsModule, 'AcctSeedERP__Outbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', moduleFilter);
		}
    }
}