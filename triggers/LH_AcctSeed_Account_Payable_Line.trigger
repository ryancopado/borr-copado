trigger LH_AcctSeed_Account_Payable_Line on AcctSeed__Account_Payable_Line__c(before update, before insert, after update, after insert) {
     if(trigger.isBefore){
        LH.LH_Realtime_Run.performTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
        'Child Object Name' => 'AcctSeed__Account_Payable_Line__c'
        });
        
        // Added By Madan - Sept 7, 2017(To populate few fields)
        //AccountPayableLineHandler.populateFields(trigger.new);
     }
     else if(trigger.isAfter){
        LH.LH_Realtime_Run.performParentTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
        'Parent Object Name' => 'AcctSeed__Account_Payable_Line__c'
        });
     }
}