trigger PricingToolApproval_CCSub on Pricing_Tool_Approval__c (after update) {
	
	// If various fields on the Pricing Tool Approval record have changed (mostly long text area fields)
	// copy them to the associated Contract Committee Submittal record.
	
	List<Id> ptaIds = new List<Id>();
	List<Contract_Committee_Submittal__c> ccSubList = new List<Contract_Committee_Submittal__c>();
	
	for (Pricing_Tool_Approval__c pta : trigger.new) {
		if ( (pta.Anyone_walked_the_site__c != trigger.oldMap.get(pta.Id).Anyone_walked_the_site__c) ||
			 (pta.Any_sign_of_wetlands__c != trigger.oldMap.get(pta.Id).Any_sign_of_wetlands__c) ||
			 (pta.Are_there_union_labor_requirements__c != trigger.oldMap.get(pta.Id).Are_there_union_labor_requirements__c) ||
			 (pta.Customer_requirements_beyond_code__c != trigger.oldMap.get(pta.Id).Customer_requirements_beyond_code__c) ||
			 (pta.Permit_costs_validated_with_the_town__c != trigger.oldMap.get(pta.Id).Permit_costs_validated_with_the_town__c) ||
			 //(pta.PSD_Revision__c != trigger.oldMap.get(pta.Id).PSD_Revision__c) ||
			 (pta.Town_restrictions_or_mandates__c != trigger.oldMap.get(pta.Id).Town_restrictions_or_mandates__c) ) {
			ptaIds.add(pta.Id);
		}
	}
	
	if (!ptaIds.isEmpty()) {
		ccSubList = [select Id, Pricing_Tool_Approval__c, 
				Anyone_walked_the_site__c, Any_sign_of_wetlands__c, Are_there_union_labor_requirements__c, 
				Customer_requirements_beyond_code__c, Permit_costs_validated_with_the_town__c, PSD_Revision__c, Town_restrictions_or_mandates__c 
				from Contract_Committee_Submittal__c where Pricing_Tool_Approval__c in: ptaIds];
		
		for (Contract_Committee_Submittal__c ccs : ccSubList) {
			ccs.Anyone_walked_the_site__c = trigger.newMap.get(ccs.Pricing_Tool_Approval__c).Anyone_walked_the_site__c;
			ccs.Any_sign_of_wetlands__c = trigger.newMap.get(ccs.Pricing_Tool_Approval__c).Any_sign_of_wetlands__c;
			ccs.Are_there_union_labor_requirements__c = trigger.newMap.get(ccs.Pricing_Tool_Approval__c).Are_there_union_labor_requirements__c;
			ccs.Customer_requirements_beyond_code__c = trigger.newMap.get(ccs.Pricing_Tool_Approval__c).Customer_requirements_beyond_code__c;
			ccs.Permit_costs_validated_with_the_town__c = trigger.newMap.get(ccs.Pricing_Tool_Approval__c).Permit_costs_validated_with_the_town__c;
			//ccs.PSD_Revision__c = trigger.newMap.get(ccs.Pricing_Tool_Approval__c).PSD_Revision__c;
			ccs.Town_restrictions_or_mandates__c = trigger.newMap.get(ccs.Pricing_Tool_Approval__c).Town_restrictions_or_mandates__c;
		}
		
		if (!ccSubList.isEmpty()) {
			update ccSubList;
		}
	}
}