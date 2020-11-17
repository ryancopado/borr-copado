trigger InboundInventoryRollUp on AcctSeedERP__Inbound_Inventory_Movement__c (after delete, after insert, after update, after undelete) {
   
    //Fields to roll up for all Inbound Inventory Movements associated with Project Tasks
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsProjectTask = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Value__c', 'Roll_Up_In_Bound_Inventory_Movements__c')
        };
    
    //Fields to roll up for all Outbound Inventory Lines
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Value__c', 'Roll_Up_Inbound_Inventory_Movement_Total__c')
        };
        
        
   //Fields to roll up for all Outbound Inventory Lines
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolar = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Value__c', 'Roll_Up_Solar_Inbound_Inventory_Movement__c')
        };
        
    //Fire the appropriate triggers on Insert, Update and Delete
    list<AcctSeedERP__Inbound_Inventory_Movement__c> records = new list<AcctSeedERP__Inbound_Inventory_Movement__c>();
    list<AcctSeedERP__Inbound_Inventory_Movement__c> recordsSolar = new list<AcctSeedERP__Inbound_Inventory_Movement__c>();
    list<AcctSeedERP__Inbound_Inventory_Movement__c> recordsModule = new list<AcctSeedERP__Inbound_Inventory_Movement__c>();
    if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
        
        if (trigger.isUpdate) {
            for (integer i=0;i<trigger.new.size();i++) {
                if ( (trigger.new[i].Value__c != trigger.old[i].Value__c) || 
                	 (trigger.new[i].AcctSeedERP__Credit_GL_Account__c != trigger.old[i].AcctSeedERP__Credit_GL_Account__c) || 
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
			
        	for (AcctSeedERP__Inbound_Inventory_Movement__c iim :records) {
        		if (iim.Use_Old_CC__c) {
        			recordsSolar.add(iim);
        		} else {
        			recordsModule.add(iim);
        		}
        	}
			
            //Query filter for GL Account
            List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
            glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
            String glaFilter = '';
            if (glaList.size() > 0) {
            	glaFilter += ' and (AcctSeedERP__Credit_GL_Account__c = \'' + glaList[0].Id + '\'';
            	for (Integer i=1; i<glaList.size(); i++) {
            		glaFilter += ' or AcctSeedERP__Credit_GL_Account__c = \'' + glaList[i].Id + '\'';
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
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsProjectTask, records, 'AcctSeedERP__Inbound_Inventory_Movement__c', 'AcctSeedERP__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter);
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeedERP__Inbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', glaFilter + liFilter);
			
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
				RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsSolar, 'AcctSeedERP__Inbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', solarModuleFilter);
			}
			if (!recordsModule.isEmpty()) {
				RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsModule, 'AcctSeedERP__Inbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', moduleFilter);
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
			glaFilter += ' and (AcctSeedERP__Credit_GL_Account__c = \'' + glaList[0].Id + '\'';
			for (Integer i=1; i<glaList.size(); i++) {
				glaFilter += ' or AcctSeedERP__Credit_GL_Account__c = \'' + glaList[i].Id + '\'';
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
		
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsProjectTask, trigger.old, 'AcctSeedERP__Inbound_Inventory_Movement__c', 'AcctSeedERP__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter);
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeedERP__Inbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', glaFilter + liFilter);
/*        
		// Query filter for Solar Module ID - get the Id for the Solar Module cost code
		Id solarModuleId = [select Id from Cost_Code__c where Name = 'Solar Modules' limit 1].Id;   
		String projectTasksSolarModFilter = '';
		if (solarModuleId != null) {
			projectTasksSolarModFilter = projectTasksSolarModFilter + ' and AcctSeedERP__Project_Task__r.Cost_Code__c = \'' + solarModuleId + '\'';
		}
*/		
/*
		// Get the Ids for the Module cost codes
		List<Cost_Code__c> ccList = new List<Cost_Code__c>([select Id from Cost_Code__c where Number__c in ('02-1425', '02-1535', '05-1535')]);
		String solarModuleId = '(';
		for (Integer i=0; i<ccList.size(); i++) {
			if (i > 0) {
				solarModuleId = solarModuleId + ',';
			}
			solarModuleId = solarModuleId + '\'' + ccList[i].Id + '\'';
		}
		solarModuleId = solarModuleId + ')';
		
		//Query filter for Solar Module IDs
		String projectTasksSolarModFilter = '';
		if (solarModuleId != null) {
			projectTasksSolarModFilter = projectTasksSolarModFilter + ' and AcctSeedERP__Project_Task__r.Cost_Code__c in ' + solarModuleId;
		}
		projectTasksSolarModFilter += glaFilter;
		
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, trigger.old, 'AcctSeedERP__Inbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', projectTasksSolarModFilter);
*/
		
		for (AcctSeedERP__Inbound_Inventory_Movement__c iim :trigger.old) {
			if (iim.Use_Old_CC__c) {
				recordsSolar.add(iim);
			} else {
				recordsModule.add(iim);
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
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsSolar, 'AcctSeedERP__Inbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', solarModuleFilter);
		}
		if (!recordsModule.isEmpty()) {
			RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolar, recordsModule, 'AcctSeedERP__Inbound_Inventory_Movement__c', 'AcctSeedERP__Project__c', 'AcctSeed__Project__c', moduleFilter);
		}
    }
}