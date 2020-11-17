public class ServiceCostsThisYearRollUpUtility {
	
	/***********************************************
	Calculates the "Service Costs (this year)" field of Service Contracts.
	
	Input:  list of Service Contract Ids
	
	Output: Calculates the "Service Costs (this year)" field on each Service Contract in the following way:
		- Calculate the sum of field "AP Lines Total" on all related Purchase Order Lines that are associated
		with a Purchase Order with "Status" field = "Closed" and "PO Closed Date" field = this year that are
		associated with Construction Requisitions of recordtype = "Service" and "Type" field = "Paid", "Warranty",
		or "Warranty Resi".
	
	************************************************/
	/*
	public static void rollUpServiceCosts(List<Id> conIds) {
		
		List<Id> poIds = new List<Id>();
		List<AcctSeedERP__Purchase_Order_Line__c> poLines = new List<AcctSeedERP__Purchase_Order_Line__c>();
		List<Id> poLineIds = new List<Id>();
		RecordType rtService = new RecordType();
		List<AcctSeedERP__Sales_Order_Line__c> conReq = new List<AcctSeedERP__Sales_Order_Line__c>();
		List<SV__c> serviceVisits = new List<SV__c>();
		List<Contract> con = new List<Contract>();
		Map<Id, Contract> conMap = new Map<Id, Contract>();
		Map<Id, SV__c> svMap = new Map<Id, SV__c>();
		Map<Id, AcctSeedERP__Sales_Order_Line__c> conReqMap = new Map<Id, AcctSeedERP__Sales_Order_Line__c>();
		Map<Id, AcctSeedERP__Sales_Order_Line__c> crPolMap = new Map<Id, AcctSeedERP__Sales_Order_Line__c>();
		List<AcctSeedERP__Purchase_Order__c> poList = new List<AcctSeedERP__Purchase_Order__c>();
		List<AcctSeedERP__Purchase_Order_Line__c> poLineSum = new List<AcctSeedERP__Purchase_Order_Line__c>();
		Map<Id, AcctSeedERP__Purchase_Order__c> poMap = new Map<Id, AcctSeedERP__Purchase_Order__c>();

		if (conIds.size() > 0) {
		
			// Get list of Service Contracts that need to have "Service Costs (this year)" calculated
			con = [SELECT Id, Service_Costs_this_year__c FROM Contract WHERE Id IN: conIds];
			//con = [SELECT Id, Service_Costs_Sum_this_year__c FROM Contract WHERE Id IN: conIds];
	
			// Find all Purchase Order Lines ultimately associated with the Service Contracts and calculate "Service Costs (this year)" for each Service Contract
			if (con.size() > 0) {
				rtService = [SELECT Id, Name FROM RecordType WHERE Name = 'Service' and SobjectType = 'AcctSeedERP__Sales_Order_Line__c'];
				for (Contract c : con) {
					c.Service_Costs_this_year__c = 0;
					//c.Service_Costs_Sum_this_year__c = 0;
					conMap.put(c.Id, c);
				}
				
				system.debug('*****Size of conMap = ' + conMap.size());
		
				// Get all the Service Visits associated with the Service Contracts
				serviceVisits = [SELECT Id, Contract__c FROM SV__c WHERE Contract__c IN: conMap.keySet()];
				
				if (serviceVisits.size() > 0) {
					for (SV__c sv: serviceVisits) {
						svMap.put(sv.Id, sv);
					}
		
					// Get all the Construction Requisition of recordtype "Service" with Type field set appropriately that are associated with the Service Visits
					conReq = [SELECT Id, RecordTypeId, Service_Visit__c, AcctSeedERP__Purchase_Order_Line__c, Type__c FROM AcctSeedERP__Sales_Order_Line__c 
							WHERE RecordTypeId =: rtService.Id AND Service_Visit__c IN: svMap.keySet() AND (Type__c =: 'Paid' OR Type__c =: 'Warranty' OR Type__c =: 'Warranty- Resi')];
					
					if (conReq.size() > 0) {
						for (AcctSeedERP__Sales_Order_Line__c cr : conReq) {
							conReqMap.put(cr.Id, cr);
							poLineIds.add(cr.AcctSeedERP__Purchase_Order_Line__c);
							if (!crPolMap.containsKey(cr.AcctSeedERP__Purchase_Order_Line__c)) {
								crPolMap.put(cr.AcctSeedERP__Purchase_Order_Line__c, cr);
							}
						}
		
						// Get all the Purchase Order Lines associated with the Construction Requisitions
						poLines = [SELECT Id, AcctSeedERP__Purchase_Order__c, Roll_Up_All_Account_Payable_Lines__c, Construction_Req__c FROM AcctSeedERP__Purchase_Order_Line__c 
								WHERE Id IN: poLineIds OR Construction_Req__c IN: conReqMap.keySet()];
						
						if (poLines.size() > 0) {
							for (AcctSeedERP__Purchase_Order_Line__c pol : poLines) {
								poIds.add(pol.AcctSeedERP__Purchase_Order__c);
			
								// Sometimes the Construction Requisition field on a Purchase Order Line is blank, if so fill it in so that we can use it in a map below
								if (pol.Construction_Req__c == NULL) {
									pol.Construction_Req__c = crPolMap.get(pol.Id).Id;
								}
							}
		
							// Get all the Purchase Orders associated with the Purchase Order Lines
							poList = [SELECT Id, AcctSeedERP__Status__c, PO_Closed_Date__c FROM AcctSeedERP__Purchase_Order__c WHERE Id IN: poIds];
							for (AcctSeedERP__Purchase_Order__c po : poList) {
								poMap.put(po.Id, po);
							}
		
							system.debug('***** Number of poList = ' + poList.size() + ', first Id = ' + poList[0].Id);
		
							// Identify all the Purchase Order Lines that are associated with a Purchase Order with Status = "Closed" and PO Closed Date = to this year
							for (AcctSeedERP__Purchase_Order_Line__c pol : poLines) {
								if (poMap.get(pol.AcctSeedERP__Purchase_Order__c).PO_Closed_Date__c != NULL) {
									if (poMap.get(pol.AcctSeedERP__Purchase_Order__c).AcctSeedERP__Status__c == 'Closed' && poMap.get(pol.AcctSeedERP__Purchase_Order__c).PO_Closed_Date__c.year() == system.today().year()) {
										poLineSum.add(pol);
									}
								}
							}
		
							if (poLineSum.size() > 0) {
								system.debug('***** Number of poLineSum = ' + poLineSum.size() + ', first Id = ' + poLineSum[0].Id);
							}
		
							// Iterate through the Purchase Order Lines to calculate the new value of the "Service Costs (this year)" field of the related Service Contract
							for (AcctSeedERP__Purchase_Order_Line__c pol : poLineSum) {
								if (pol.Roll_Up_All_Account_Payable_Lines__c != NULL) {
									conMap.get(svMap.get(conReqMap.get(pol.Construction_Req__c).Service_Visit__c).Contract__c).Service_Costs_this_year__c += pol.Roll_Up_All_Account_Payable_Lines__c;
									//conMap.get(svMap.get(conReqMap.get(pol.Construction_Req__c).Service_Visit__c).Contract__c).Service_Costs_Sum_this_year__c += pol.Roll_Up_All_Account_Payable_Lines__c;
								}
							}
						}
					}
				}
				update conMap.values();
			}
		}
	}
	*/
}