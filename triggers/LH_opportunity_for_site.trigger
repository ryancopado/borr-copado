trigger LH_opportunity_for_site on opportunity(before update, before insert, after update, after insert) {
     if(trigger.isAfter && trigger.isUpdate){
        LH.LH_Realtime_Run.performFkTriggerLookups(trigger.oldMap, trigger.newMap, new Map<string, string>{
        'Foreign Key Object Name' => 'opportunity',
        'Child Object Name' => 'site__c'
        });
     }
}