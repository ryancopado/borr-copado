trigger UpdateChangeOrderTotal on Con_Req__c (after insert,after update,after undelete,after delete) {



    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsApproved = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount_Requested_Total__c', 'Change_Order_Total__c')
    };


    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsApprovedChangeRequest = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount_Requested_Total__c', 'Total_CO_Additional_Amount_Requested__c')
    };


    //Fields to roll up for all Account Payable Lines
    list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAllCO = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'AP_Line_CO_Total__c', 'AP_Line_CO_Total__c')
        };  
        
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsApprovedChangeOrder = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Final_Change_Order_Amount__c', 'Project_Change_Order_Total__c')
    };  


     list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsPendingApprovedChangeOrder = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'Final_Change_Order_Amount__c', 'Pending_Change_Order__c')
    }; 

     list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsApprovedESD = 
        new list<RollUpSummaryUtility.fieldDefinition> {
            new RollUpSummaryUtility.fieldDefinition('SUM', 'ESD_Change_Order_Total__c', 'ESD_Change_Order_Total__c')
    };

    if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete){
        list<Con_Req__c> records = new list<Con_Req__c> ();
        
        list<Con_Req__c> recordsCOTotals = new list<Con_Req__c> ();
        
        if(trigger.isUpdate){
            for(integer i=0;i<trigger.new.size();i++){
                
                if ( trigger.new[i].Amount_Requested_Total__c != trigger.old[i].Amount_Requested_Total__c ||
                     trigger.new[i].Status__c == 'Borrego Approved' && trigger.old[i].Status__c != 'Borrego Approved' ) {
                    records.add(trigger.new[i]);
                }
                
                if (trigger.new[i].AP_Line_CO_Total__c != trigger.old[i].AP_Line_CO_Total__c) {
                    recordsCOTotals.add(trigger.new[i]);
                }
                
                if ( (trigger.new[i].Purchase_Order2__c != trigger.old[i].Purchase_Order2__c) || (trigger.new[i].Budget_Line_Item2__c != trigger.old[i].Budget_Line_Item2__c) ) {
                    records.add(trigger.new[i]);
                    records.add(trigger.old[i]);
                }
                 if ( (trigger.new[i].Final_Change_Order_Amount__c!= trigger.old[i].Final_Change_Order_Amount__c) ||( trigger.new[i].Status__c == 'Approved By Customer' && trigger.old[i].Status__c != 'Approved By Customer')) {
                    records.add(trigger.new[i]);
                    records.add(trigger.old[i]);
                }
                   if ( (trigger.new[i].Final_Change_Order_Amount__c!= trigger.old[i].Final_Change_Order_Amount__c) ||( trigger.new[i].Status__c == 'Approval Pending' && trigger.old[i].Status__c != 'Approval Pending')) {
                    records.add(trigger.new[i]);
                    records.add(trigger.old[i]);
                }
                 if ( (trigger.new[i].ESD_Change_Order_Total__c!= trigger.old[i].ESD_Change_Order_Total__c) ||( trigger.new[i].Status__c == 'Approved By Customer' && trigger.old[i].Status__c != 'Approved By Customer') ) {
                    records.add(trigger.new[i]);
                    records.add(trigger.old[i]);
                }
            }
        }else{
            records.addAll(trigger.new);
            recordsCOTotals.addAll(trigger.new);
        }

        if(!records.isEmpty()){
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApproved, records, 'Con_Req__c', 'Purchase_Order2__c', 'AcctSeedERP__Purchase_Order__c', ' and Status__c = \'Borrego Approved\'');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApprovedChangeRequest, records, 'Con_Req__c', 'Budget_Line_Item2__c', 'AcctSeed__Project_Task__c', ' and Status__c = \'Borrego Approved\'');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApprovedChangeOrder, records, 'Con_Req__c', 'ASProject__c', 'AcctSeed__Project__c', ' and Status__c in ( \'Approved By Customer\') and RecordTypeName__c = \'Customer Change Order\'');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApprovedESD, records, 'Con_Req__c', 'ASProject__c', 'AcctSeed__Project__c', ' and Status__c in (\'Approved By Customer\')and RecordTypeName__c = \'Customer Change Order\'');
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPendingApprovedChangeOrder, records, 'Con_Req__c', 'ASProject__c', 'AcctSeed__Project__c', ' and Status__c in ( \'Approval Pending\') and RecordTypeName__c = \'Customer Change Order\'');

        }
        
        if(!recordsCOTotals.isEmpty()){
            RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllCO, recordsCOTotals, 'Con_Req__c', 'Purchase_Order2__c', 'AcctSeedERP__Purchase_Order__c', '');
        }
        
    }
     if(trigger.isDelete){
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApproved, trigger.old, 'Con_Req__c', 'Purchase_Order2__c', 'AcctSeedERP__Purchase_Order__c', ' and Status__c = \'Borrego Approved\'');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApprovedChangeRequest, trigger.old, 'Con_Req__c', 'Budget_Line_Item2__c', 'AcctSeed__Project_Task__c', ' and Status__c = \'Borrego Approved\'');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAllCO, trigger.old, 'Con_Req__c', 'Purchase_Order2__c', 'AcctSeedERP__Purchase_Order__c', '');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApprovedChangeOrder,trigger.old,'Con_Req__c', 'ASProject__c', 'AcctSeed__Project__c', ' and Status__c in (\'Approved By Customer\')and RecordTypeName__c = \'Customer Change Order\'');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsApprovedESD, trigger.old, 'Con_Req__c', 'ASProject__c', 'AcctSeed__Project__c', ' and Status__c in (\'Approved By Customer\')and RecordTypeName__c = \'Customer Change Order\'');
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPendingApprovedChangeOrder,trigger.old,'Con_Req__c', 'ASProject__c', 'AcctSeed__Project__c', ' and Status__c in (\'Approval Pending\')and RecordTypeName__c = \'Customer Change Order\'');

     }


}