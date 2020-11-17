trigger LH_request_for_information_rfi_for_reco on request_for_information_rfi__c(before update, before insert, after update, after insert) {
     if(trigger.isAfter && trigger.isUpdate){
        LH.LH_Realtime_Run.performFkTriggerLookups(trigger.oldMap, trigger.newMap, new Map<string, string>{
        'Foreign Key Object Name' => 'request_for_information_rfi__c',
        'Child Object Name' => 'record_drawing_1__c'
        });
     }
}