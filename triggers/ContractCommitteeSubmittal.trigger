trigger ContractCommitteeSubmittal on Contract_Committee_Submittal__c (before insert, before update) {
	
	// Copy various fields (mostly long text area fields) from the associated Pricing Tool Approval and Opportunity records to
	// the Contract Committee Submittal record
	
	List<Id> ptaIds = new List<Id>();
	List<Pricing_Tool_Approval__c> ptaList = new List<Pricing_Tool_Approval__c>();
	Map<Id, Pricing_Tool_Approval__c> ptaMap = new Map<Id, Pricing_Tool_Approval__c>();
	List<Id> oIds = new List<Id>();
	List<Opportunity> oppList = new List<Opportunity>();
	Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
	//List<Id> pIds = new List<Id>();
	
	for (Contract_Committee_Submittal__c ccs : trigger.new) {
		if (ccs.Pricing_Tool_Approval__c != null) {
			ptaIds.add(ccs.Pricing_Tool_Approval__c);
		}
		if (ccs.Opportunity__c != null) {
			oIds.add(ccs.Opportunity__c);
		}
		if (trigger.isUpdate) {
			if (ccs.Pricing_Tool_Approval__c != trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c) {
				if (trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c != null) {
					ptaIds.add(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c);
				}
			}
		}
		/*
		if (trigger.isInsert) {
			if (ccs.Project__c != null) {
				pIds.add(ccs.Project__c);
			}
		}
		*/
	}
	
	if (!ptaIds.isEmpty()) {
		ptaList = [select Id, Anyone_walked_the_site__c, Any_sign_of_wetlands__c, Are_there_union_labor_requirements__c, 
				Customer_requirements_beyond_code__c, Permit_costs_validated_with_the_town__c, PSD_Revision__c, Town_restrictions_or_mandates__c 
				from Pricing_Tool_Approval__c where Id in: ptaIds];
	
		for (Pricing_Tool_Approval__c pta : ptaList) {
			ptaMap.put(pta.Id, pta);
		}
		
		for (Contract_Committee_Submittal__c ccs : trigger.new) {
			
			if (ptaMap.containsKey(ccs.Pricing_Tool_Approval__c)) {
				//ccs.PSD_Revision__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).PSD_Revision__c;
				
				if (trigger.isInsert) {
					
					// On insert with a valid Pricing Tool Approval lookup, copy the fields if they are blank on Contract Committtee Submittal
					if (ccs.Anyone_walked_the_site__c == null) {
						ccs.Anyone_walked_the_site__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Anyone_walked_the_site__c;
					}
					if (ccs.Any_sign_of_wetlands__c == null) {
						ccs.Any_sign_of_wetlands__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Any_sign_of_wetlands__c;
					}
					if (ccs.Are_there_union_labor_requirements__c == null) {
						ccs.Are_there_union_labor_requirements__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Are_there_union_labor_requirements__c;
					}
					if (ccs.Customer_requirements_beyond_code__c == null) {
						ccs.Customer_requirements_beyond_code__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Customer_requirements_beyond_code__c;
					}
					if (ccs.Permit_costs_validated_with_the_town__c == null) {
						ccs.Permit_costs_validated_with_the_town__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Permit_costs_validated_with_the_town__c;
					}
					if (ccs.Town_restrictions_or_mandates__c == null) {
						ccs.Town_restrictions_or_mandates__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Town_restrictions_or_mandates__c;
					}
					
				} else {
					
					if (ccs.Pricing_Tool_Approval__c != trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c) {
						if (trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c == null) {
							
							// On update, with changed Pricing Tool Approval lookup (new value not null, old value is null), copy the fields if they are 
							// blank on Contract Committtee Submittal
							if (ccs.Anyone_walked_the_site__c == null) {
								ccs.Anyone_walked_the_site__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Anyone_walked_the_site__c;
							}
							if (ccs.Any_sign_of_wetlands__c == null) {
								ccs.Any_sign_of_wetlands__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Any_sign_of_wetlands__c;
							}
							if (ccs.Are_there_union_labor_requirements__c == null) {
								ccs.Are_there_union_labor_requirements__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Are_there_union_labor_requirements__c;
							}
							if (ccs.Customer_requirements_beyond_code__c == null) {
								ccs.Customer_requirements_beyond_code__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Customer_requirements_beyond_code__c;
							}
							if (ccs.Permit_costs_validated_with_the_town__c == null) {
								ccs.Permit_costs_validated_with_the_town__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Permit_costs_validated_with_the_town__c;
							}
							if (ccs.Town_restrictions_or_mandates__c == null) {
								ccs.Town_restrictions_or_mandates__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Town_restrictions_or_mandates__c;
							}
						} else {
							
							// On Update, with changed Pricing Tool Approval lookup (new value not null, old value not null), copy the fields if they match
							// the value on the old Pricing Tool Approval record
							if (ccs.Anyone_walked_the_site__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Anyone_walked_the_site__c) {
								ccs.Anyone_walked_the_site__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Anyone_walked_the_site__c;
							}
							if (ccs.Any_sign_of_wetlands__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Any_sign_of_wetlands__c) {
								ccs.Any_sign_of_wetlands__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Any_sign_of_wetlands__c;
							}
							if (ccs.Are_there_union_labor_requirements__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Are_there_union_labor_requirements__c) {
								ccs.Are_there_union_labor_requirements__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Are_there_union_labor_requirements__c;
							}
							if (ccs.Customer_requirements_beyond_code__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Customer_requirements_beyond_code__c) {
								ccs.Customer_requirements_beyond_code__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Customer_requirements_beyond_code__c;
							}
							if (ccs.Permit_costs_validated_with_the_town__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Permit_costs_validated_with_the_town__c) {
								ccs.Permit_costs_validated_with_the_town__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Permit_costs_validated_with_the_town__c;
							}
							if (ccs.Town_restrictions_or_mandates__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Town_restrictions_or_mandates__c) {
								ccs.Town_restrictions_or_mandates__c = ptaMap.get(ccs.Pricing_Tool_Approval__c).Town_restrictions_or_mandates__c;
							}
						}
					}
				}
				
			} else {
				
				if (trigger.isUpdate) {
					//ccs.PSD_Revision__c = null;
					
					if (trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c != null) {
						
						// On update, with null new Pricing Tool Approval, and not null old Pricing Tool Approval, set the fields to null if they match
						// the value on the old Pricing Tool Approval record
						if (ccs.Anyone_walked_the_site__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Anyone_walked_the_site__c) {
							ccs.Anyone_walked_the_site__c = null;
						}
						if (ccs.Any_sign_of_wetlands__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Any_sign_of_wetlands__c) {
							ccs.Any_sign_of_wetlands__c = null;
						}
						if (ccs.Are_there_union_labor_requirements__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Are_there_union_labor_requirements__c) {
							ccs.Are_there_union_labor_requirements__c = null;
						}
						if (ccs.Customer_requirements_beyond_code__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Customer_requirements_beyond_code__c) {
							ccs.Customer_requirements_beyond_code__c = null;
						}
						if (ccs.Permit_costs_validated_with_the_town__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Permit_costs_validated_with_the_town__c) {
							ccs.Permit_costs_validated_with_the_town__c = null;
						}
						if (ccs.Town_restrictions_or_mandates__c == ptaMap.get(trigger.oldMap.get(ccs.Id).Pricing_Tool_Approval__c).Town_restrictions_or_mandates__c) {
							ccs.Town_restrictions_or_mandates__c = null;
						}
					}
				}
			}
		}
	}
	
	if (!oIds.isEmpty()) {
		oppList = [select Id, Financing_Options_Provided__c from Opportunity where Id in: oIds];
		for (Opportunity o : oppList) {
			oppMap.put(o.Id, o);
		}
		for (Contract_Committee_Submittal__c ccs : trigger.new) {
			if (oppMap.containsKey(ccs.Opportunity__c)) {
				ccs.Project_Type__c = oppMap.get(ccs.Opportunity__c).Financing_Options_Provided__c;
			}
		}
	}
	
	/*
	if (!pIds.isEmpty()) {
		Map<Id, AcctSeed__Project__c> pMap = new Map<Id, AcctSeed__Project__c>([select Id, OwnerId from AcctSeed__Project__c where Id in :pIds]);
		for (Contract_Committee_Submittal__c ccs : trigger.new) {
			if (pMap.containsKey(ccs.Project__c)) {
				ccs.Project_Manager_Lookup__c = pMap.get(ccs.Project__c).OwnerId;
			}
		}
	}
	*/
}