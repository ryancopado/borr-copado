trigger AccountPayable_FinalInvoice on AcctSeed__Account_Payable__c (after delete, after insert, after update, before insert, before update) {
	
	// Before Triggers - verify that there is only one Account Payable record marked Final Invoice per Purchase Order
	
	// After Triggers - set the Final Invoice Status field of all associated Purchase Order Lines (associated via the 
	// associated Purchase Order) based upon the Invoice Status field of the Account Payable that is marked Final Invoice
	List<AcctSeed__Account_Payable__c> apList = new List<AcctSeed__Account_Payable__c>();
	List<AcctSeedERP__Purchase_Order_Line__c> polList = new List<AcctSeedERP__Purchase_Order_Line__c>();
	List<Id> poIds = new List<Id>();
	List<AcctSeedERP__Purchase_Order__c> poList = new List<AcctSeedERP__Purchase_Order__c>();
	Map<Id, AcctSeedERP__Purchase_Order__c> poMap = new Map<Id, AcctSeedERP__Purchase_Order__c>();
	Boolean finalInvoiceError;
	
	// Determine the set of AP Invoice records and Purchase Order Ids we care about
	if (trigger.isDelete) {
		for (AcctSeed__Account_Payable__c ap : trigger.old) {
			if (ap.Final_Invoice__c && ap.Purchase_Order__c != null) {
				apList.add(ap);
				poIds.add(ap.Purchase_Order__c);
			}
		}
	} else {
		for (AcctSeed__Account_Payable__c ap : trigger.new) {
			if (trigger.isInsert) {
				if (ap.Final_Invoice__c && ap.Purchase_Order__c != null) {
					apList.add(ap);
					poIds.add(ap.Purchase_Order__c);
				}
			} else {
				// If Purchase Order lookup has changed, get the new and old Purchase Order Id
				if (ap.Purchase_Order__c != trigger.oldMap.get(ap.Id).Purchase_Order__c) {
					if (trigger.oldMap.get(ap.Id).Final_Invoice__c && trigger.oldMap.get(ap.Id).Purchase_Order__c != null) {
						apList.add(ap);
						poIds.add(trigger.oldMap.get(ap.Id).Purchase_Order__c);
					}
					if (ap.Final_Invoice__c && ap.Purchase_Order__c != null) {
						apList.add(ap);
						poIds.add(ap.Purchase_Order__c);
					}
				} else {
					// If Final Invoice has changed or it is a Final Invoice and the Status has changed, get the Purchase Order Id
					if (ap.Purchase_Order__c != null) {
						if ( (ap.Final_Invoice__c != trigger.oldMap.get(ap.Id).Final_Invoice__c) || 
							 (ap.Final_Invoice__c && ap.AcctSeed__Status__c != trigger.oldMap.get(ap.Id).AcctSeed__Status__c) ) {
							apList.add(ap);
							poIds.add(ap.Purchase_Order__c);
						}
					}
				}
			}
		}
	}
	
	if (!poIds.isEmpty()) {
		
		// Get the associated Purchase Order and Purchase Order Line records for those Account Payable records that we care about
		poList = [select Id, Name from AcctSeedERP__Purchase_Order__c where Id in: poIds];
		for (AcctSeedERP__Purchase_Order__c po : poList) {
			poMap.put(po.Id, po);
		}
		polList = [select Id, AcctSeedERP__Purchase_Order__c, Final_Invoice_Status__c from AcctSeedERP__Purchase_Order_Line__c where AcctSeedERP__Purchase_Order__c in: poIds];
		
		if (!polList.isEmpty()) {
			
			// If this is a before trigger, verify that there is only one AP Invoice marked Final Invoice per Purchase Order
			if (trigger.isBefore) {
				for (AcctSeed__Account_Payable__c ap : apList) {
					finalInvoiceError = false;
					for (AcctSeedERP__Purchase_Order_Line__c pol : polList) {
						if (ap.Purchase_Order__c == pol.AcctSeedERP__Purchase_Order__c) {
							// Before Insert trigger
							if (trigger.isInsert) {
								if (pol.Final_Invoice_Status__c != null) {
									finalInvoiceError = true;
								}
							} else {
								// Before Update trigger
								if ( (ap.Final_Invoice__c) && (pol.Final_Invoice_Status__c != null) &&
									 (ap.Final_Invoice__c != trigger.oldMap.get(ap.Id).Final_Invoice__c || ap.Purchase_Order__c != trigger.oldMap.get(ap.Id).Purchase_Order__c) ) {
									 	finalInvoiceError = true;
								}
							}
						}
					}
					if (finalInvoiceError) {
						trigger.newMap.get(ap.Id).addError('Purchase Order: ' + poMap.get(ap.Purchase_Order__c).Name + ' already has an AP Invoice marked "Final Invoice".');
					}
				}
			}
			
			// If this is an after trigger - update field Final Invoice Status of each Purchase Order Line associated via the Purchase Order
			if (trigger.isAfter) {
				for (AcctSeed__Account_Payable__c ap : apList) {
					for (AcctSeedERP__Purchase_Order_Line__c pol : polList) {
						if (ap.Purchase_Order__c == pol.AcctSeedERP__Purchase_Order__c) {
							if (trigger.isDelete) {
								pol.Final_Invoice_Status__c = null;
							}
							if (trigger.isInsert) {
								pol.Final_Invoice_Status__c = ap.AcctSeed__Status__c;
							}
							if (trigger.isUpdate) {
								if (ap.Final_Invoice__c) {
									pol.Final_Invoice_Status__c = ap.AcctSeed__Status__c;
								} else {
									pol.Final_Invoice_Status__c = null;
								}
							}
						}
						if (trigger.isUpdate) {
							if (ap.Purchase_Order__c != trigger.oldMap.get(ap.Id).Purchase_Order__c) {
								if (trigger.oldMap.get(ap.Id).Final_Invoice__c) {
									if (trigger.oldMap.get(ap.Id).Purchase_Order__c == pol.AcctSeedERP__Purchase_Order__c) {
										pol.Final_Invoice_Status__c = null;
									}
								}
							}
						}
					}
				}
				update polList;
			}
		}
	}
}