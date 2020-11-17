trigger LH_Pricing_Tool_Approval on Pricing_Tool_Approval__c(before update, before insert, after update, after insert) {
  	 if(trigger.isBefore){
	 	LH.LH_Realtime_Run.performTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
		'Child Object Name' => 'Pricing_Tool_Approval__c'
    	});
	 }
     else if(trigger.isAfter){
		LH.LH_Realtime_Run.performParentTriggerLookups(trigger.oldMap, trigger.new, new Map<string, string>{
		'Parent Object Name' => 'Pricing_Tool_Approval__c'
		});
	 }
}