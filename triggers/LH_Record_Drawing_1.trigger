trigger LH_Record_Drawing_1 on Record_Drawing_1__c(before update, before insert, after update, after insert) {
     if(trigger.isBefore){
        LH.LH_Realtime_Run.performTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
        'Child Object Name' => 'Record_Drawing_1__c'
        });
     }
     else if(trigger.isAfter){
        LH.LH_Realtime_Run.performParentTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
        'Parent Object Name' => 'Record_Drawing_1__c'
        });
     }
}