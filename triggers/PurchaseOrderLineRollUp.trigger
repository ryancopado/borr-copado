trigger PurchaseOrderLineRollUp on AcctSeedERP__Purchase_Order_Line__c (after delete, after insert, after update, after undelete) {
   
    //Fields to roll up for all PurchaseOrderLines
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'POLine_Total__c', 'Roll_Up_Purchase_Order_Line_Totals__c')
        };
        
    //Fire the appropriate triggers on Insert, Update and Delete     
    if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete){
        list<AcctSeedERP__Purchase_Order_Line__c> records = new list<AcctSeedERP__Purchase_Order_Line__c> ();
        
        if(trigger.isUpdate){
            for(integer i=0;i<trigger.new.size();i++){
                if(trigger.new[i].get('POLine_Total__c') != trigger.old[i].get('POLine_Total__c')){
                    records.add(trigger.new[i]);
                }
                if (trigger.new[i].AcctSeedERP__Project_Task__c != trigger.old[i].AcctSeedERP__Project_Task__c) {
                	records.add(trigger.new[i]);
                	records.add(trigger.old[i]);
                }
            }
        }else{
            records.addAll(trigger.new);
        }
         
        if(!records.isEmpty()){  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeedERP__Purchase_Order_Line__c', 'AcctSeedERP__Project_Task__c', 'AcctSeed__Project_Task__c', ' and AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c != \'Cancelled\' and AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c != \'Rejected\'');
        }
    }
     
    //Fire slightly differently on Delete
    if(trigger.isDelete){
         
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeedERP__Purchase_Order_Line__c', 'AcctSeedERP__Project_Task__c', 'AcctSeed__Project_Task__c', '  and AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c != \'Cancelled\' and AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c != \'Rejected\'');
         
         
    }
     
}