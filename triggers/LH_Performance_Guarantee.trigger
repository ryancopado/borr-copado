trigger LH_Performance_Guarantee on Performance_Guarantee__c(before update, before insert, after update, after insert) {
  	 if(trigger.isBefore){
	 	LH.LH_Realtime_Run.performTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
		'Child Object Name' => 'Performance_Guarantee__c'
    	});
	 }
     else if(trigger.isAfter){
		LH.LH_Realtime_Run.performParentTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
		'Parent Object Name' => 'Performance_Guarantee__c'
		});
	 }
}