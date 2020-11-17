trigger BillingPosted on AcctSeed__Billing__c (after update) {
    Set<Id> APIds = new Set<Id>();
    Set<Id> statusIds = new Set<Id>();
    List<AcctSeed__Billing_Line__c> records = new List<AcctSeed__Billing_Line__c>();
    
    /*
    List<String> APIds = new List<String>();
    for(integer i=0;i<trigger.new.size();i++){
        //if(trigger.new[i].get('AcctSeed__Status__c') != trigger.old[i].get('AcctSeed__Status__c') || (trigger.new[i].get('AcctSeed__Balance__c') ==0 && trigger.old[i].get('AcctSeed__Balance__c') !=0))
        if(trigger.new[i].get('AcctSeed__Status__c') != trigger.old[i].get('AcctSeed__Status__c') || trigger.new[i].get('AcctSeed__Received_Amount__c') != trigger.old[i].get('AcctSeed__Received_Amount__c')) {
            APIds.add(trigger.new[i].Id);
        }
    }
    */
    
    for (AcctSeed__Billing__c b :trigger.new) {
        if (b.AcctSeed__Status__c != trigger.oldMap.get(b.Id).AcctSeed__Status__c) {
            statusIds.add(b.Id);
        } else {
            if (b.AcctSeed__Received_Amount__c != trigger.oldMap.get(b.Id).AcctSeed__Received_Amount__c) {
                APIds.add(b.Id);
            }
        }
    }
    APIds.addAll(statusIds);

    if (!APIds.isEmpty()) {
        records = [select Id, AcctSeed__Billing__c, AcctSeed__Total__c, Billing_Amount_Received__c, AcctSeed__Project_Task__c, AcctSeed__Project__c, Retention__c, Case__c from AcctSeed__Billing_Line__c where AcctSeed__Billing__c in:APIds];
        
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
        
        if(!records.isEmpty()){
            
            // Query filter for GL Account
            List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
            glaList = [select Id from AcctSeed__GL_Account__c where Name like '3000%' or Name like '3001%' or Name like '1202%' or Name like '3301%'];
            String glaFilter = '';
            if (glaList.size() > 0) {
                glaFilter += ' and (AcctSeed__Revenue_GL_Account__c = \'' + glaList[0].Id + '\'';
                for (Integer i=1; i<glaList.size(); i++) {
                    glaFilter += ' or AcctSeed__Revenue_GL_Account__c = \'' + glaList[i].Id + '\'';
                }
                glaFilter += ')';
            }
                
            // Limit Billing Line records summed up to the Project for fieldDefinitionsEPC so that
            // there is only one Billing Line record in the list to sum that has the same associated Billing and Project records
            List<AcctSeed__Billing_Line__c> recordsProject = new List<AcctSeed__Billing_Line__c>();
            List<Id> pIds = new List<Id>();
            List<AcctSeed__Billing_Line__c> recordsEPC = new List<AcctSeed__Billing_Line__c>();
            Boolean inList;
            String idString = '';
            for (AcctSeed__Billing_Line__c bl :records) {
                if (bl.AcctSeed__Project__c != null) {
                    pIds.add(bl.AcctSeed__Project__c);
                }
            }
            if (!pIds.isEmpty()) {
                // First get all Billing Line records associated with the Project(s)
               recordsProject = [select id, Billing_Amount_Received__c, AcctSeed__Billing__c, AcctSeed__Project__c,AcctSeed__GL_Account_Variable_1__r.Name from AcctSeed__Billing_Line__c where AcctSeed__Project__c in :pIds];
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
            system.debug('This is records' +records);
            system.debug('This is  project records' +pIds);
            system.debug('This is  project records BU' +recordsProject);
          //AcctSeed__Project__c projectBU = new AcctSeed__Project__c();
            
            if (!pIds.isEmpty()){
        List<AcctSeed__Project__c>projectBU=[select id,Sales_Segment__r.Name from AcctSeed__Project__c  where id in:pIds];
        string salessegmentname;
            
            system.debug('this is running query' +pids);
             for(integer i=0;i<projectBU.size();i++)
            {
            AcctSeed__Project__c projectrec = new AcctSeed__Project__c();
            projectrec =projectBU.get(i);
            system.debug('Look Here ' +projectrec);
            
            
            if(projectrec.Sales_Segment__r.Name =='Development')
            {
            
            system.debug('this is develop');
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll,records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Parent_Status__c = \'Posted\' and ( NOT AcctSeed__Project_Task__r.Name LIKE \'Ret%\') and AcctSeed__Revenue_GL_Account__r.Name LIKE \'3301%\'');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllProject, records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Parent_Status__c = \'Posted\' and (AcctSeed__Revenue_GL_Account__r.Name LIKE \'3301%\' or AcctSeed__Revenue_GL_Account__r.Name LIKE \'1202%\')');
            }
            else
            {
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll,records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Parent_Status__c = \'Posted\' and ( NOT AcctSeed__Project_Task__r.Name LIKE \'Ret%\') and AcctSeed__Revenue_GL_Account__r.Name LIKE \'3000%\'');
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllProject, records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Parent_Status__c = \'Posted\' and (AcctSeed__Revenue_GL_Account__r.Name LIKE \'3000%\' or AcctSeed__Revenue_GL_Account__r.Name LIKE \'1202%\')');
            }
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPaid,records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and (NOT AcctSeed__Project_Task__r.Name LIKE \'Ret%\') and AcctSeed__Billing__r.AcctSeed__Balance__c = 0');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsRetentionBL, records, 'AcctSeed__Billing_Line__c', 'Retention__c', 'Retention__c', ' and AcctSeed__Billing__r.AcctSeed__Status__c != \'Rejected\' and AcctSeed__Billing__r.AcctSeed__Status__c != \'Recalled\'');
            
            if (idString.length() > 0) {
                RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsEPC, records, 'AcctSeed__Billing_Line__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter + idString);
            }
        }
        }
        
        
        // If the Billing status has changed, update case records related to the related billing line records
        if (!statusIds.isEmpty()) {
            Set<Id> cIds = new Set<Id>();
            for (AcctSeed__Billing_Line__c bl :records) {
                if (statusIds.contains(bl.AcctSeed__Billing__c)) {
                    if (bl.Case__c != null) {
                        cIds.add(bl.Case__c);
                    }
                }
            }
            
            if (!cIds.isEmpty()) {
                CaseService.billingStatus(cIds);
            }
        }
    }
}
}