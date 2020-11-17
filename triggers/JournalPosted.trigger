trigger JournalPosted on AcctSeed__Journal_Entry__c (/*after update,*/ before update) {

    // If the Status field has changed from or to "Posted", mark the Journal Entry so that a roll up will be performed later via batch job
    for (AcctSeed__Journal_Entry__c je :trigger.new) {
        if ( (je.AcctSeed__Status__c != trigger.oldMap.get(je.Id).AcctSeed__Status__c) &&
             (je.AcctSeed__Status__c == 'Posted' || trigger.oldMap.get(je.Id).AcctSeed__Status__c == 'Posted') ) {
            je.Do_RollUp__c = true;
        }
    }
    
    /* Start of code that did the rollups asynchronously via @future or queueable
    // If the Status field has changed from or to "Posted", perform a roll up sum on various fields on the related Journal Entry Line records
    Set<Id> jeIds = new Set<Id>();
    for (AcctSeed__Journal_Entry__c je :trigger.new) {
        if ( (je.AcctSeed__Status__c != trigger.oldMap.get(je.Id).AcctSeed__Status__c) &&
             (je.AcctSeed__Status__c == 'Posted' || trigger.oldMap.get(je.Id).AcctSeed__Status__c == 'Posted') ) {
            jeIds.add(je.Id);
        }
    }
    
    if (!jeIds.isEmpty()) {
        
        RollUpSettings__c rus = RollUpSettings__c.getOrgDefaults();
        if (!rus.JEL_Queueable__c) {
            
            JournalPosted.rollUpJournalPosted(jeIds, true);
            
        } else {
            
            List<AcctSeed__Journal_Entry_Line__c> records = new List<AcctSeed__Journal_Entry_Line__c>();
            records = [select Id, AcctSeed__Debit__c, AcctSeed__Credit__c, AcctSeed__Project_Task__c, AcctSeed__Project__c, Use_Old_CC__c from AcctSeed__Journal_Entry_Line__c where AcctSeed__Journal_Entry__c in :jeIds];
            
            // Fields to roll up from Journal Entry Lines for all JournalEntryLine on Project Task
            List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
                new List<RollUpSummaryUtility.fieldDefinition> {
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Journal_Entry_Debit__c'),
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Journal_Entry_Credit__c')
                };
            
            // Fields to roll up from Journal Entry Lines for all JournalEntryLine on Project
            List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolarProject = 
                new List<RollUpSummaryUtility.fieldDefinition> {
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Credit__c'),
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Debit__c')
                };
            
            // Fields to roll up from Journal Entry Lines for all JournalEntryLine on Project
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
    }
    End of code that did the rollups asynchronously via @future or queueable */
    
    /* Beginning of original trigger code that did all rollups synchronously 
    List<String> APIds = new List<String>();
    list<AcctSeed__Journal_Entry__c> aprecords = new list<AcctSeed__Journal_Entry__c> ();
    
    for(integer i=0;i<trigger.new.size();i++){
        if(trigger.new[i].get('AcctSeed__Status__c') != trigger.old[i].get('AcctSeed__Status__c') ){
            aprecords.add(trigger.new[i]);
        }
    }
    
    for(AcctSeed__Journal_Entry__c Ap:aprecords){
        APIds.add(Ap.Id);
    }

    List<AcctSeed__Journal_Entry_Line__c> records = new List<AcctSeed__Journal_Entry_Line__c>();
    List<AcctSeed__Journal_Entry_Line__c> recordsSolar = new List<AcctSeed__Journal_Entry_Line__c>();
    List<AcctSeed__Journal_Entry_Line__c> recordsModule = new List<AcctSeed__Journal_Entry_Line__c>();
    records = [select id,AcctSeed__Debit__c,AcctSeed__Credit__c,AcctSeed__Project_Task__c,AcctSeed__Project__c, Use_Old_CC__c from AcctSeed__Journal_Entry_Line__c where AcctSeed__Journal_Entry__c in:APIds];
    for (AcctSeed__Journal_Entry_Line__c jel :records) {
        if (jel.Use_Old_CC__c) {
            recordsSolar.add(jel);
        } else {
            recordsModule.add(jel);
        }
    }

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
    }
    /* End of original trigger code that did all rollups synchronously */
}