trigger TransactionRollUp on AcctSeed__Transaction__c (after delete, after insert, after update, after undelete) {
    
    if (trigger.isDelete) {
        system.debug('*****TransactionRollUp number of records = ' + trigger.old.size());
    } else {
        system.debug('*****TransactionRollUp number of records = ' + trigger.new.size());
    }
    
    //Fields to roll up for all Transactions
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Transactions__c')
        };
        
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllRetentions = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Total_Retention__c')
        };    
    
    // Fire the appropriate triggers on Insert, Update and Delete
    if (trigger.isInsert || trigger.isUpdate || trigger.isUndelete) {
        Map<Id, AcctSeed__Transaction__c> liMap = new Map<Id, AcctSeed__Transaction__c>();
        Map<Id, AcctSeed__Transaction__c> projMap = new Map<Id, AcctSeed__Transaction__c>();
        
        if (trigger.isUpdate) {
            for (AcctSeed__Transaction__c tran :trigger.new) {
                if (tran.AcctSeed__Amount__c != trigger.oldMap.get(tran.Id).AcctSeed__Amount__c) {
                    liMap.put(tran.AcctSeed__Project_Task__c, tran);
                    projMap.put(tran.AcctSeed__Project__c, tran);
                }
            }
        } else {
            for (AcctSeed__Transaction__c tran :trigger.new) {
                liMap.put(tran.AcctSeed__Project_Task__c, tran);
                projMap.put(tran.AcctSeed__Project__c, tran);
            }
        }
        
        if (!liMap.isEmpty()) {
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, liMap.values(), 'AcctSeed__Transaction__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Amount__c > 0 ');
        }
        
        if (!projMap.isEmpty()) {
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllRetentions, projMap.values(), 'AcctSeed__Transaction__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Project_Task__r.Name = \'Retention Billing\'  and AcctSeed__Amount__c > 0 and AcctSeed__Project_Task__r.recordType.Name = \'Billing Line Item\' ');
        }
    }
        
    /*
    //Fire the appropriate triggers on Insert, Update and Delete     
    if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete){
         
        list<AcctSeed__Transaction__c> records = new list<AcctSeed__Transaction__c> ();
        
        if(trigger.isUpdate){
            for(integer i=0;i<trigger.new.size();i++){
                if(trigger.new[i].get('AcctSeed__Amount__c') != trigger.old[i].get('AcctSeed__Amount__c')){
                    records.add(trigger.new[i]);
                }
            }
        }else{
            records.addAll(trigger.new);
        }
        
        /*
        if (!records.isEmpty()) {
            RollUpSettings__c rus = RollUpSettings__c.getOrgDefaults();
            if (rus.Transaction_Queueable__c) {
                Id jobIdTransaction1 = System.enqueueJob(new RollUpQueueable(fieldDefinitionsAll, records, 'AcctSeed__Transaction__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Amount__c > 0 '));
                
                Id jobIdTransaction2 = System.enqueueJob(new RollUpQueueable(fieldDefinitionsAllRetentions, records, 'AcctSeed__Transaction__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Project_Task__r.Name = \'Retention Billing\'  and AcctSeed__Amount__c > 0 and AcctSeed__Project_Task__r.recordType.Name = \'Billing Line Item\' '));
            } else {
                RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Transaction__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Amount__c > 0 ');
                
                RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllRetentions, records, 'AcctSeed__Transaction__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Project_Task__r.Name = \'Retention Billing\'  and AcctSeed__Amount__c > 0 and AcctSeed__Project_Task__r.recordType.Name = \'Billing Line Item\' ');
            }
        }
        */
        /*
        if (!records.isEmpty()) {
           // RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.new, 'AcctSeed__Transaction__c', 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Account_Payable_Line__c', '');
     
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Transaction__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Amount__c > 0 ');
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllRetentions, records, 'AcctSeed__Transaction__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Project_Task__r.Name = \'Retention Billing\'  and AcctSeed__Amount__c > 0 and AcctSeed__Project_Task__r.recordType.Name = \'Billing Line Item\' ');
        }
        */
    //}
     
    /*
    //Fire slightly differently on Delete
    if (trigger.isDelete) {
        RollUpSettings__c rus = RollUpSettings__c.getOrgDefaults();
        if (rus.Transaction_Queueable__c) {
            Id jobIdTransaction1 = System.enqueueJob(new RollUpQueueable(fieldDefinitionsAll, trigger.old, 'AcctSeed__Transaction__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Amount__c > 0'));
                
            Id jobIdTransaction2 = System.enqueueJob(new RollUpQueueable(fieldDefinitionsAllRetentions, trigger.old, 'AcctSeed__Transaction__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Project_Task__r.Name = \'Retention Billing\'  and AcctSeed__Amount__c > 0   and AcctSeed__Project_Task__r.recordType.Name = \'Billing Line Item\' '));
        } else {
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Transaction__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Amount__c > 0');
            
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllRetentions, trigger.old, 'AcctSeed__Transaction__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Project_Task__r.Name = \'Retention Billing\'  and AcctSeed__Amount__c > 0   and AcctSeed__Project_Task__r.recordType.Name = \'Billing Line Item\' ');
        }
    }
    */
    
    //Fire slightly differently on Delete
    if(trigger.isDelete){
         
       // RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Transaction__c', 'AcctSeed__Account_Payable_Line__c', 'AcctSeed__Account_Payable_Line__c', '');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Transaction__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeed__Amount__c > 0');
         
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllRetentions, trigger.old, 'AcctSeed__Transaction__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', ' and AcctSeed__Project_Task__r.Name = \'Retention Billing\'  and AcctSeed__Amount__c > 0   and AcctSeed__Project_Task__r.recordType.Name = \'Billing Line Item\' ');
             
        
    }
}