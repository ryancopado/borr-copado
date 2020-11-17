trigger JournalEntryLineRollUp on AcctSeed__Journal_Entry_Line__c (after delete, after insert, after update, after undelete) {
    
    RollUpSettings__c rus = RollUpSettings__c.getOrgDefaults();
    if (rus.JEL_Queueable__c) {
        
        /* START OF TRIGGER THAT USES QUEUEABLE APEX TO PERFORM ROLLUPS ASYNCHRONOUSLY */
        
        /* COMMENTED OUT TO AID IN TEST CLASS CODE COVERAGE
        // Determine which Journal Entry Line child records may need to be rolled up to a parent
        List<AcctSeed__Journal_Entry_Line__c> records = new List<AcctSeed__Journal_Entry_Line__c>();
        if (trigger.isInsert || trigger.isUndelete) {
            records.addAll(trigger.new);
        }
        
        if (trigger.isDelete) {
            records.addAll(trigger.old);
        }
        
        if (trigger.isUpdate) {
            for (Integer i=0; i<trigger.new.size(); i++) {
                if (  (trigger.new[i].AcctSeed__Credit__c != trigger.old[i].AcctSeed__Credit__c) || 
                      (trigger.new[i].AcctSeed__Debit__c != trigger.old[i].AcctSeed__Debit__c) ||
                      (trigger.new[i].AcctSeed__GL_Account__c != trigger.old[i].AcctSeed__GL_Account__c) ) {
                    records.add(trigger.new[i]);
                }
            }
        }
        
        if (!records.isEmpty()) {
            
            // Fields to roll up for all JournalEntryLine on Project Task
            List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
                new List<RollUpSummaryUtility.fieldDefinition> {
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Journal_Entry_Debit__c'),
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Journal_Entry_Credit__c')
                };
            
            // Fields to roll up for all JournalEntryLine on Project
            List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolarProject = 
                new List<RollUpSummaryUtility.fieldDefinition> {
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Credit__c'),
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Debit__c')
                };
            
            // Fields to roll up for all JournalEntryLine on Project
            List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllProject = 
                new List<RollUpSummaryUtility.fieldDefinition> {
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Journal_Entry_Lines_Debit__c'),
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Journal_Entry_Lines_Credit__c')
                };
            
            // Query filter for GL Account
            List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
            glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
            String glaFilter = '';
            if (glaList.size() > 0) {
                glaFilter += ' and (AcctSeed__GL_Account__c = \'' + glaList[0].Id + '\'';
                for (Integer i=1; i<glaList.size(); i++) {
                    glaFilter += ' or AcctSeed__GL_Account__c = \'' + glaList[i].Id + '\'';
                }
                glaFilter += ')';
            }
            
            // Query filter for Line Item record type
            List<RecordType> liRtList = new List<RecordType>([select Id from RecordType where Name = 'Budget Line Item' and SobjectType = 'AcctSeed__Project_Task__c']);
            String liFilter = '';
            if (!liRtList.isEmpty()) {
                liFilter = ' and AcctSeed__Project_Task__r.RecordTypeId = \'' + liRtList[0].Id + '\'';
            }
            
            // Set up the Cost Code filters
            RollUpSummaryUtility.costCodeIdFilters ccIdFilters = new RollUpSummaryUtility.costCodeIdFilters();
            String moduleFilter = '';
            if (ccIdFilters.moduleIdFilter != '') {
                moduleFilter = ' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.moduleIdFilter;
            }
            String solarModuleFilter = '';
            if (ccIdFilters.solarModuleIdFilter != '') {
                solarModuleFilter = ' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.solarModuleIdFilter;
            }
            
            // Do the rollups - each rollup is performed in a separate asynchronous job
            Id jobIdJEL1 = System.enqueueJob(new RollUpQueueable(fieldDefinitionsAll, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter + ' and AcctSeed__Parent_Status__c = \'Posted\' '));
            
            Id jobIdJEL2 = System.enqueueJob(new RollUpQueueable(fieldDefinitionsAllProject, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + liFilter + ' and AcctSeed__Parent_Status__c = \'Posted\' '));
            
            Id jobIdJEL3 = System.enqueueJob(new RollUpQueueable(fieldDefinitionsSolarProject, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + solarModuleFilter + ' and Use_Old_CC__c = true' + ' and AcctSeed__Parent_Status__c = \'Posted\' '));
            
            Id jobIdJEL4 = System.enqueueJob(new RollUpQueueable(fieldDefinitionsSolarProject, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + moduleFilter + ' and Use_Old_CC__c = false'  + ' and AcctSeed__Parent_Status__c = \'Posted\' '));
        }  
        */
        
        /* END OF TRIGGER THAT USES QUEUEABLE APEX TO PERFORM ROLLUPS ASYNCHRONOUSLY */
        
    } else {
        
        /* START OF TRIGGER THAT USES @FUTURE METHOD IN JournalPosted.cls TO PERFORM ROLLUPS ASYNCHRONOUSLY */
        Set<Id> jeIds = new Set<Id>();
        
        // Determine the list of Journal Entry record Ids with Journal Entry Line records that need to be rolled up
        if (trigger.isInsert || trigger.isUndelete) {
            for (AcctSeed__Journal_Entry_Line__c jel :trigger.new) {
                jeIds.add(jel.AcctSeed__Journal_Entry__c);
            }
        }
        
        if (trigger.isUpdate) {
            for (Integer i=0; i<trigger.new.size(); i++) {
                if (  (trigger.new[i].AcctSeed__Credit__c != trigger.old[i].AcctSeed__Credit__c) || 
                      (trigger.new[i].AcctSeed__Debit__c != trigger.old[i].AcctSeed__Debit__c) ||
                      (trigger.new[i].AcctSeed__GL_Account__c != trigger.old[i].AcctSeed__GL_Account__c) ) {
                    jeIds.add(trigger.new[i].AcctSeed__Journal_Entry__c);
                }
            }
        }
        
        if (trigger.isDelete) {
            for (AcctSeed__Journal_Entry_Line__c jel :trigger.old) {
                jeIds.add(jel.AcctSeed__Journal_Entry__c);
            }
        }
        
        // Do the roll up
        if (!jeIds.isEmpty()) {
            JournalPosted.rollUpJournalPosted(jeIds, false);
        }
        /* END OF TRIGGER THAT USES @FUTURE METHOD IN JournalPosted.cls TO PERFORM ROLLUPS ASYNCHRONOUSLY */
    
    }
    
    /* START OF TRIGGER THAT PERFORMED ROLLUPS SYNCHRONOUSLY
    //Fields to roll up for all JournalEntryLine
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Journal_Entry_Debit__c'),
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Journal_Entry_Credit__c')
        };
    
    
     //Fields to roll up for all JournalEntryLine on Project
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolarProject = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Credit__c'),
             new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Debit__c')
        }; 
        
    //Fields to roll up for all JournalEntryLine on Project
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllProject = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Journal_Entry_Lines_Debit__c'),
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Journal_Entry_Lines_Credit__c')
        };    
        
    //Fire the appropriate triggers on Insert, Update and Delete
    list<AcctSeed__Journal_Entry_Line__c> recordsSolar = new list<AcctSeed__Journal_Entry_Line__c>();
    list<AcctSeed__Journal_Entry_Line__c> recordsModule = new list<AcctSeed__Journal_Entry_Line__c>();
    if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
        list<AcctSeed__Journal_Entry_Line__c> records = new list<AcctSeed__Journal_Entry_Line__c>();
        
        if (trigger.isUpdate) {
            for (integer i=0;i<trigger.new.size(); i++) {
                if ((trigger.new[i].AcctSeed__Credit__c != trigger.old[i].AcctSeed__Credit__c) || 
                    (trigger.new[i].AcctSeed__Debit__c != trigger.old[i].AcctSeed__Debit__c) ||
                    (trigger.new[i].AcctSeed__GL_Account__c != trigger.old[i].AcctSeed__GL_Account__c)) {
                    records.add(trigger.new[i]);
                    
                    if (trigger.new[i].Use_Old_CC__c) {
                        recordsSolar.add(trigger.new[i]);
                    } else {
                        recordsModule.add(trigger.new[i]);
                    }
                }
            }
        } else {
            records.addAll(trigger.new);
            for (Integer i=0; i<trigger.new.size(); i++) {
                if (trigger.new[i].Use_Old_CC__c) {
                    recordsSolar.add(trigger.new[i]);
                } else {
                    recordsModule.add(trigger.new[i]);
                }
            }
        }
        
        if (!records.isEmpty()) { 
            
            //Query filter for GL Account
            List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
            glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
            String glaFilter = '';
            if (glaList.size() > 0) {
                glaFilter += ' and (AcctSeed__GL_Account__c = \'' + glaList[0].Id + '\'';
                for (Integer i=1; i<glaList.size(); i++) {
                    glaFilter += ' or AcctSeed__GL_Account__c = \'' + glaList[i].Id + '\'';
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
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter + '  and AcctSeed__Parent_Status__c = \'Posted\' ');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllProject, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + liFilter + '  and AcctSeed__Parent_Status__c = \'Posted\' ');
            
            // Set up the Cost Code filters
            RollUpSummaryUtility.costCodeIdFilters ccIdFilters = new RollUpSummaryUtility.costCodeIdFilters();
            String moduleFilter = '';
            if (ccIdFilters.moduleIdFilter != '') {
                moduleFilter = ' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.moduleIdFilter;
            }
            String solarModuleFilter = '';
            if (ccIdFilters.solarModuleIdFilter != '') {
                solarModuleFilter = ' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.solarModuleIdFilter;
            }
            
            if (!recordsSolar.isEmpty()) {
                RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, recordsSolar, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + solarModuleFilter + '   and AcctSeed__Parent_Status__c = \'Posted\' ');
            }
            if (!recordsModule.isEmpty()) {
                RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, recordsModule, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + moduleFilter + '   and AcctSeed__Parent_Status__c = \'Posted\' ');
            }
            
            //RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + projectTasksSolarModFilter + '   and AcctSeed__Parent_Status__c = \'Posted\' ');
        }
    }
    
    //Fire slightly differently on Delete
    if (trigger.isDelete) {
        
        //Query filter for GL Account
        List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
        glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
        String glaFilter = '';
        if (glaList.size() > 0) {
            glaFilter += ' and (AcctSeed__GL_Account__c = \'' + glaList[0].Id + '\'';
            for (Integer i=1; i<glaList.size(); i++) {
                glaFilter += ' or AcctSeed__GL_Account__c = \'' + glaList[i].Id + '\'';
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
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter + '  and AcctSeed__Parent_Status__c = \'Posted\' '); 
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllProject, trigger.old, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + liFilter + '  and AcctSeed__Parent_Status__c = \'Posted\' ');
        
        // Set up the Cost Code filters
        RollUpSummaryUtility.costCodeIdFilters ccIdFilters = new RollUpSummaryUtility.costCodeIdFilters();
        String moduleFilter = '';
        if (ccIdFilters.moduleIdFilter != '') {
            moduleFilter = ' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.moduleIdFilter;
        }
        String solarModuleFilter = '';
        if (ccIdFilters.solarModuleIdFilter != '') {
            solarModuleFilter = ' and AcctSeed__Project_Task__r.Cost_Code__c in ' + ccIdFilters.solarModuleIdFilter;
        }
        
        for (Integer i=0; i<trigger.old.size(); i++) {
            if (trigger.old[i].Use_Old_CC__c) {
                recordsSolar.add(trigger.old[i]);
            } else {
                recordsModule.add(trigger.old[i]);
            }
        }
        
        if (!recordsSolar.isEmpty()) {
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, recordsSolar, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + solarModuleFilter + '  and AcctSeed__Parent_Status__c = \'Posted\' ');
        }
        if (!recordsModule.isEmpty()) {
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, recordsModule, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + moduleFilter + '  and AcctSeed__Parent_Status__c = \'Posted\' ');
        }
    }
    /* END OF TRIGGER THAT PERFORMED ROLLUPS SYNCHRONOUSLY */
}