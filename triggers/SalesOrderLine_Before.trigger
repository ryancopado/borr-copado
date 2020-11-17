trigger SalesOrderLine_Before on AcctSeedERP__Sales_Order_Line__c (before delete, before insert, before update) {
	
	/*
	 *	Sets the Project PM field to the Owner field of the associate Project.
	 *
	 *	If Con Req Group field is not null and has not changed:
	 *		- verify that none of the "group" fields have changed on the associated
	 *		Sales Order Lines.  If they have changed, throw an error.
	 *
	 *	If Con Req Group field is not null and has changed:
	 *		- copy all of the "group" fields to the associated Sales Order Lines.
	 *
	 *	Don't allow changes to Construction Requisition records if the associated
	 *	Con Req Group is locked and a we are before insert.
	 *
	 *  Don't allow Sales Order Lines to be created with a Service Visit/Contract that is expired or complete unless the
	 *  user has role "O&M Warranty Project Manager".
	 *
	 */
	
	List<AcctSeedERP__Sales_Order_Line__c> triggerList = new List<AcctSeedERP__Sales_Order_Line__c>();
	if (trigger.isDelete) {
		triggerList.addAll(trigger.old);
	} else {
		triggerList.addAll(trigger.new);
	}
	
	// Get all the associated Project and Con Req Group records
	List<Id> pIds = new List<Id>();
	List<Id> crgIds = new List<Id>();
	Set<Id> svIds = new Set<Id>();
	for(AcctSeedERP__Sales_Order_Line__c sol :triggerList) {
		if(sol.AcctSeedERP__Project__c != null) {
			pIds.add(sol.AcctSeedERP__Project__c);
		}
		if (sol.Con_Req_Group__c != null) {
			crgIds.add(sol.Con_Req_Group__c);
		}
		if (sol.Service_Visit__c != null) {
		    svIds.add(sol.Service_Visit__c);
		}
	}
	
	Map<Id, AcctSeed__Project__c> pMap = new Map<Id, AcctSeed__Project__c>([select Id, OwnerId from AcctSeed__Project__c where Id in :pIds]);
	Map<Id, Con_Req_Group__c> crgMap = new Map<Id, Con_Req_Group__c>([select Id, Project_PM__c, Sales_Order__c, Project__c, 
				Ship_to_Account__c, Vendor__c, Vendor_Contact__c, Requested_Delivery_Date__c, Status__c, IsLocked__c 
				from Con_Req_Group__c where Id in :crgIds]);
	Map<Id, SV__c> svMap = new Map<Id, SV__c>([select Id, Contract_Status__c from SV__c where Id in :svIds]);
	Map<String, Schema.RecordTypeInfo> rtSVMap = Schema.SObjectType.SV__c.getRecordTypeInfosByName();
	
	// Get the user role
	String roleName = [select Id, Name from UserRole where Id = :UserInfo.getUserRoleId()].Name;
	
	// Iterate through each Sales Order Line record and set the Project PM field and check on the
	// Con Req Group "group" fields.
	for (AcctSeedERP__Sales_Order_Line__c sol :triggerList) {
		
		// Don't allow delete if Con Req Group is locked
		if (trigger.isDelete) {
			if (crgMap.containsKey(sol.Con_Req_Group__c) && crgMap.get(sol.Con_Req_Group__c).IsLocked__c) {
				sol.addError('Con Req Group is locked - cannot delete related Construction Requisition records.');
			}
		}
		
		if (trigger.isInsert) {
		    if (roleName != 'O&M Warranty Project Manager' && rtSVMap.containsKey('Service') && sol.RecordTypeId == rtSVMap.get('Service').getRecordTypeId()) {
		        if (svMap.containsKey(sol.Service_Visit__c)) {
		            if (svMap.get(sol.Service_Visit__c).Contract_Status__c == 'Expired' || svMap.get(sol.Service_Visit__c).Contract_Status__c == 'Paid Contract Complete') {
		                sol.addError('Contract associated with Con Req is either Expired or Paid Contract Complete. Please contact your O&M administrator. Only the Warranty Manager can create these types of CRGs.');
		            }
		        }
		    }

		}
		
		if (trigger.isInsert || trigger.isUpdate) {
		
			// Check the Con Req Group "group" fields
			if (crgMap.containsKey(sol.Con_Req_Group__c)) {
				
				// Can only add new Construction Requisitions if the Con Req Group is not locked
				if (crgMap.get(sol.Con_Req_Group__c).IsLocked__c && trigger.isInsert) {
					
					sol.addError('Con Req Group is locked - cannot add new Construction Requisition records.');
					
				} else {
					
					// If insert or if update and Con Req Group field has not changed, verify that none of the "group" fields have changed
					if (trigger.isInsert || (trigger.isUpdate && sol.Con_Req_Group__c == trigger.oldMap.get(sol.Id).Con_Req_Group__c) ) {
						String errorMsg = 'When part of a Con Req Group, this field can only be set/changed via the associated Con Req Group record.';
						if (sol.AcctSeedERP__Project__c != crgMap.get(sol.Con_Req_Group__c).Project__c) {
							sol.AcctSeedERP__Project__c.addError(errorMsg);
						}
						if (sol.Project_PM__c != crgMap.get(sol.Con_Req_Group__c).Project_PM__c) {
							sol.Project_PM__c.addError(errorMsg);
						}
						if (sol.AcctSeedERP__Sales_Order__c != crgMap.get(sol.Con_Req_Group__c).Sales_Order__c) {
							sol.AcctSeedERP__Sales_Order__c.addError(errorMsg);
						}
						if (sol.Ship_to_Account__c != crgMap.get(sol.Con_Req_Group__c).Ship_to_Account__c) {
							sol.Ship_to_Account__c.addError(errorMsg);
						}
						if (sol.Vendor__c != crgMap.get(sol.Con_Req_Group__c).Vendor__c) {
							sol.Vendor__c.addError(errorMsg);
						}
						if (sol.Vendor_Contact__c != crgMap.get(sol.Con_Req_Group__c).Vendor_Contact__c) {
							sol.Vendor_Contact__c.addError(errorMsg);
						}
						if (sol.Requested_Delivery_Date__c != crgMap.get(sol.Con_Req_Group__c).Requested_Delivery_Date__c) {
							sol.Requested_Delivery_Date__c.addError(errorMsg);
						}
						if (sol.Status__c != crgMap.get(sol.Con_Req_Group__c).Status__c) {
							sol.Status__c.addError(errorMsg);
						}
					}
					
					// If update and Con Req Group field has changed, copy all of the "group" fields
					if (trigger.isUpdate && sol.Con_Req_Group__c != trigger.oldMap.get(sol.Id).Con_Req_Group__c) {
						sol.AcctSeedERP__Project__c = crgMap.get(sol.Con_Req_Group__c).Project__c;
						sol.Project_PM__c = crgMap.get(sol.Con_Req_Group__c).Project_PM__c;
						sol.Ship_to_Account__c = crgMap.get(sol.Con_Req_Group__c).Ship_to_Account__c;
						sol.Vendor__c = crgMap.get(sol.Con_Req_Group__c).Vendor__c;
						sol.Vendor_Contact__c = crgMap.get(sol.Con_Req_Group__c).Vendor_Contact__c;
						sol.Requested_Delivery_Date__c = crgMap.get(sol.Con_Req_Group__c).Requested_Delivery_Date__c;
						sol.Status__c = crgMap.get(sol.Con_Req_Group__c).Status__c;
					}
				}
			
			} else {
			
				// Sale Order Line is not part of a group, Set the Project PM field
				if (pMap.containsKey(sol.AcctSeedERP__Project__c)) {
					sol.Project_PM__c = pMap.get(sol.AcctSeedERP__Project__c).OwnerId;
				}
			}
		}
	}
}