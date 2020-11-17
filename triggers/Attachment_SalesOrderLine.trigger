trigger Attachment_SalesOrderLine on Attachment (after delete, after insert) {
	
	// Record that an attachment as been made to a Construction Requisition (Sales Order Line) and/or 
	// Con Req Group so that we can use that as entry criteria to an approval process.
	
	Schema.SObjectType token;
	Schema.DescribeSObjectResult dr;
	List<Id> solIds = new List<Id>();
	List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
	List<AcctSeedERP__Sales_Order_Line__c> solUpdate = new List<AcctSeedERP__Sales_Order_Line__c>();
	List<Id> crgIds = new List<Id>();
	List<Con_Req_Group__c> crgList = new List<Con_Req_Group__c>();
	List<Con_Req_Group__c> crgUpdate = new List<Con_Req_Group__c>();
	List<Attachment> attList;
	Map<Id, Attachment> attMap;
	
	if (trigger.isInsert) {
	
		// Find all the Attachments associated with a Sales Order Line and/or Con Req Group
		for (Attachment att : trigger.new) {
			token = att.ParentId.getSObjectType();
			dr = token.getDescribe();
		
        	if (dr.getName() == 'AcctSeedERP__Sales_Order_Line__c') {
				solIds.add(att.ParentId);
        	}
        	if (dr.getName() == 'Con_Req_Group__c') {
				crgIds.add(att.ParentId);
        	}
		}
		
		if (!solIds.isEmpty()) {
			
			// Get the list of associated Sales Order Line records
			solList = [select Id, isAttachment__c from AcctSeedERP__Sales_Order_Line__c where Id in: solIds];
			for (AcctSeedERP__Sales_Order_Line__c sol : solList) {
				if (sol.isAttachment__c != true) {
					sol.isAttachment__c = true;
					solUpdate.add(sol);
				}
			}
			if (!solUpdate.isEmpty()) {
				update solUpdate;
			}
		}
		
		if (!crgIds.isEmpty()) {
			
			// Get the list of associated Con Req Group records
			crgList = [select Id, isAttachment__c from Con_Req_Group__c where Id in: crgIds];
			for (Con_Req_Group__c crg : crgList) {
				if (crg.isAttachment__c != true) {
					crg.isAttachment__c = true;
					crgUpdate.add(crg);
				}
			}
			if (!crgUpdate.isEmpty()) {
				update crgUpdate;
			}
		}
	}
	
	if (trigger.isDelete) {
		
		// Find all the Attachments associated with a Sales Order Line and/or a Con Req Group
		for (Attachment att : trigger.old) {
			token = att.ParentId.getSObjectType();
			dr = token.getDescribe();
		
        	if (dr.getName() == 'AcctSeedERP__Sales_Order_Line__c') {
				solIds.add(att.ParentId);
        	}
        	if (dr.getName() == 'Con_Req_Group__c') {
				crgIds.add(att.ParentId);
        	}
		}
		if (!solIds.isEmpty()) {
			
			// Get the list of associated Sales Order Line records and their list of remaining attachments 
			attList = new List<Attachment>();
			solList = [select Id, isAttachment__c from AcctSeedERP__Sales_Order_Line__c where Id in: solIds];
			attList = [select Id, ParentId from Attachment where ParentId in: solIds];
			attMap = new Map<Id, Attachment>();
			if (!attList.isEmpty()) {
				for (Attachment att : attList) {
					if (!attMap.containsKey(att.ParentId)) {
						attMap.put(att.ParentId, att);
					}
				}
			}
			
			// Set the attachment flag false if no more attachments on each associate Sales Order Line
			for (AcctSeedERP__Sales_Order_Line__c sol : solList) {
				if (!attMap.containsKey(sol.Id)) {
					sol.isAttachment__c = false;		// Sales Order Line has no more attachments
					solUpdate.add(sol);
				}
			}
			if (!solUpdate.isEmpty()) {
				update solUpdate;
			}
		}
		
		if (!crgIds.isEmpty()) {
			
			// Get the list of associated Con Req Group records and their list of remaining attachments 
			attList = new List<Attachment>();
			crgList = [select Id, isAttachment__c from Con_Req_Group__c where Id in: crgIds];
			attList = [select Id, ParentId from Attachment where ParentId in: crgIds];
			attMap = new Map<Id, Attachment>();
			if (!attList.isEmpty()) {
				for (Attachment att : attList) {
					if (!attMap.containsKey(att.ParentId)) {
						attMap.put(att.ParentId, att);
					}
				}
			}
			
			// Set the attachment flag false if no more attachments on each associated Con Req Group
			for (Con_Req_Group__c crg : crgList) {
				if (!attMap.containsKey(crg.Id)) {
					crg.isAttachment__c = false;		// Con Req Group has no more attachments
					crgUpdate.add(crg);
				}
			}
			if (!crgUpdate.isEmpty()) {
				update crgUpdate;
			}
		}
	}
}