public with sharing class JournalPosted {
    
    /*
     *  Methods to rollup the sum of various fields on Journal Entry Line records to related objects.
     *  This is performed asynchronously because of the number of queries performed.
     *
     */
    
    @future
    public static void rollUpJournalPosted(Set<Id> jeIds, Boolean sendEmail) {
        
        List<AcctSeed__Journal_Entry_Line__c> records = new List<AcctSeed__Journal_Entry_Line__c>();
        records = [select Id, AcctSeed__Debit__c, AcctSeed__Credit__c, AcctSeed__Project_Task__c, AcctSeed__Project__c, Use_Old_CC__c from AcctSeed__Journal_Entry_Line__c where AcctSeed__Journal_Entry__c in :jeIds];
        /*
        List<AcctSeed__Journal_Entry_Line__c> recordsSolar = new List<AcctSeed__Journal_Entry_Line__c>();
        List<AcctSeed__Journal_Entry_Line__c> recordsModule = new List<AcctSeed__Journal_Entry_Line__c>();
        for (AcctSeed__Journal_Entry_Line__c jel :records) {
            if (jel.Use_Old_CC__c) {
                recordsSolar.add(jel);
            } else {
                recordsModule.add(jel);
            }
        }
        */
        
        if (!records.isEmpty()) {
            
            //Fields to roll up for all JournalEntryLine
            List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
                new List<RollUpSummaryUtility.fieldDefinition> {
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Journal_Entry_Debit__c'),
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Journal_Entry_Credit__c')
                };
            
            //Fields to roll up for all JournalEntryLine on Project
            List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsSolarProject = 
                new List<RollUpSummaryUtility.fieldDefinition> {
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Credit__c'),
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Solar_Journal_Entry_Lines_Debit__c')
                };
            
            //Fields to roll up for all JournalEntryLine on Project
            List<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllProject = 
                new List<RollUpSummaryUtility.fieldDefinition> {
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Debit__c', 'Roll_Up_Journal_Entry_Lines_Debit__c'),
                    new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Credit__c', 'Roll_Up_Journal_Entry_Lines_Credit__c')
                };
            
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
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter + ' and AcctSeed__Parent_Status__c = \'Posted\' ');
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllProject, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + liFilter + ' and AcctSeed__Parent_Status__c = \'Posted\' ');
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + solarModuleFilter + ' and Use_Old_CC__c = true' + ' and AcctSeed__Parent_Status__c = \'Posted\' ');
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, records, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + moduleFilter + ' and Use_Old_CC__c = false'  + ' and AcctSeed__Parent_Status__c = \'Posted\' ');
            
            /*
            if (!recordsSolar.isEmpty()) {
                RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, recordsSolar, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + solarModuleFilter + '   and AcctSeed__Parent_Status__c = \'Posted\' ');
            }
            if (!recordsModule.isEmpty()) {
                RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsSolarProject, recordsModule, 'AcctSeed__Journal_Entry_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + moduleFilter + '   and AcctSeed__Parent_Status__c = \'Posted\' ');
            }
            */
            
            // Send email to running user and owner of the Journal Entry record
            if (sendEmail) {
                String runningUserEmail = UserInfo.getUserEmail();
                List<AcctSeed__Journal_Entry__c> jeList = new List<AcctSeed__Journal_Entry__c>();
                jeList = [select Id, Name, OwnerId, Owner.Email from AcctSeed__Journal_Entry__c where Id in :jeIds];
                Messaging.SingleEmailMessage mail;
                List<String> toAddresses = new List<String>();
                String baseURL = URL.getSalesforceBaseUrl().toExternalForm();
                for (AcctSeed__Journal_Entry__c je :jeList) {
                    mail = new Messaging.SingleEmailMessage();
                    toAddresses.clear();
                    toAddresses.add(runningUserEmail);
                    toAddresses.add(je.Owner.Email);
                    mail.setToAddresses(toAddresses);
                    mail.setSubject('Journal Entry ' + je.Name + ' Post/Unpost Process Complete');
                    mail.setPlainTextBody('The Post/Unpost process has completed for'
                        + ' Journal Entry ' + je.Name
                        + '\n' + baseURL + '/' + je.Id);
                    if (!Test.isRunningTest()) {
                        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                    }
                }
            }
        }
    }
}