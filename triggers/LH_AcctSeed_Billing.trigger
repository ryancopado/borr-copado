trigger LH_AcctSeed_Billing on AcctSeed__Billing__c(before update, before insert, after update, after insert) {
  	 if(trigger.isBefore){
	 	LH.LH_Realtime_Run.performTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
		'Child Object Name' => 'AcctSeed__Billing__c'
    	});
	 }
     else if(trigger.isAfter){
		LH.LH_Realtime_Run.performParentTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
		'Parent Object Name' => 'AcctSeed__Billing__c'
		});
	 }
}