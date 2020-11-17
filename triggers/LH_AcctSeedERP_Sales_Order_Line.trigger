trigger LH_AcctSeedERP_Sales_Order_Line on AcctSeedERP__Sales_Order_Line__c(before update, before insert, after update, after insert) {
     if(trigger.isBefore){
        LH.LH_Realtime_Run.performTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
        'Child Object Name' => 'AcctSeedERP__Sales_Order_Line__c'
        });
     }
     else if(trigger.isAfter){
        LH.LH_Realtime_Run.performParentTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
        'Parent Object Name' => 'AcctSeedERP__Sales_Order_Line__c'
        });
     }
}