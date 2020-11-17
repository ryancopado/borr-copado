trigger ProjectRollUp on AcctSeed__Project__c (after delete, after insert, after undelete, after update) {

list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsApproved = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Overall_Project_Size_Watts_STC__c', 'Project_System_Size_Roll_Up__c')
    };

    
    
     system.debug('THIS IS THE TRIGGER');
    //Fields to roll up for all Projects
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            //new RollUpSummaryUtility.fieldDefinition('SUM', 'WATTS_STC__c', 'Current_Project_System_Size__c'),
           //new RollUpSummaryUtility.fieldDefinition('SUM',  'Overall_Project_Size_Watts_STC__c',' Project_System_Size_Roll_Up__c'),
           new RollUpSummaryUtility.fieldDefinition('SUM', 'Final_Contract_PriceProject__c', 'Project_Current_Contract_Price_Roll_Up__c')
        };
    
    //Fire the appropriate triggers on Insert, Update and Delete     
    if (trigger.isInsert || trigger.isUpdate || trigger.isUnDelete) {
        list<AcctSeed__Project__c> records = new list<AcctSeed__Project__c> ();
        
        if (trigger.isUpdate) {
        
       
        system.debug('UPDATE STEP');
        
        
            if (!TriggerStopper.stopProjectRollUp) {
            
            system.debug('STOPPER STEP');
                
                /*
                for (integer i=0; i<trigger.new.size(); i++) {
                    if ( (trigger.new[i].get('WATTS_STC__c') != trigger.old[i].get('WATTS_STC__c')) || 
                         (trigger.new[i].get('Opportunity_Change_Orders__c') != trigger.old[i].get('Opportunity_Change_Orders__c')) || 
                         (trigger.new[i].get('AcctSeed__Opportunity__c') != trigger.old[i].get('AcctSeed__Opportunity__c')) || 
                         (trigger.new[i].get('Final_Contract_PriceProject__c') != trigger.old[i].get('Final_Contract_PriceProject__c')) ) {
                        records.add(trigger.new[i]);
                        
                        if (trigger.new[i].get('AcctSeed__Opportunity__c') != trigger.old[i].get('AcctSeed__Opportunity__c')) {
                            records.add(trigger.old[i]);
                        }
                    }
                }
                */
                
                for (AcctSeed__Project__c p :trigger.new) {
                
                
                   if ( (p.Final_Contract_PriceProject__c != trigger.oldMap.get(p.Id).Final_Contract_PriceProject__c) ||
                        
                         (p.AcctSeed__Opportunity__c != trigger.oldMap.get(p.Id).AcctSeed__Opportunity__c) ) {
                        records.add(p);
                        
                        if (p.AcctSeed__Opportunity__c != trigger.oldMap.get(p.Id).AcctSeed__Opportunity__c) {
                            records.add(trigger.oldMap.get(p.Id));
                        }
                    } 
                    
                    /////// updated code for  Project_System_Size_Roll_Up__c added on 8/06/2019
               /*     if ( (p.Overall_Project_Size_Watts_STC__c!= trigger.oldMap.get(p.Id).Overall_Project_Size_Watts_STC__c) ||
                         (p.AcctSeed__Opportunity__c != trigger.oldMap.get(p.Id).AcctSeed__Opportunity__c) ) {
                        records.add(p);
                       system.debug('UPDATE OVERALL');
                        if (p.AcctSeed__Opportunity__c != trigger.oldMap.get(p.Id).AcctSeed__Opportunity__c) {
                            records.add(trigger.oldMap.get(p.Id));
                        }
                        
                         
                    } */
                    
             
                    
                    ///////
                }
                TriggerStopper.stopProjectRollUp = true;
                
                
                
                
            }
        } else {
            records.addAll(trigger.new);
        }
        
        
        
        system.debug('RECORD111' +records);
        
        if (!records.isEmpty()) {  
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Project__c', 'AcctSeed__Opportunity__c', 'Opportunity', '');
            //RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Project__c', 'AcctSeed__Opportunity__c', 'Opportunity', '');
        }
    }
    
    /////////////////////////
      list<AcctSeed__Project__c> records1 = new list<AcctSeed__Project__c> ();
    
     if(trigger.isUpdate){
            for(integer i=0;i<trigger.new.size();i++){
                  if ( trigger.new[i].Overall_Project_Size_Watts_STC__c != trigger.old[i].Overall_Project_Size_Watts_STC__c)
                  {
                  records1.add(trigger.new[i]);
                  records1.add(trigger.old[i]);
                }
                }
                  if(!records1.isEmpty()){
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApproved, records1, 'AcctSeed__Project__c', 'AcctSeed__Opportunity__c', 'Opportunity', '');
            }
    
    //Fire slightly differently on Delete
    if (trigger.isDelete) {
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Project__c', 'AcctSeed__Opportunity__c', 'Opportunity', '');
    }
}
}