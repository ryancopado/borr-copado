trigger PurchaseOrderLine_FinalInvoice on AcctSeedERP__Purchase_Order_Line__c (before insert) {
	
	// Get the associated Account Payable records (via the associated Purchase Order) and if
	// they are marked Final Invoice, set the Final Invoice Status field on the Purchase Order Line
	List<Id> poIds = new List<Id>();
	List<AcctSeed__Account_Payable__c> apList = new List<AcctSeed__Account_Payable__c>();
	
	for (AcctSeedERP__Purchase_Order_Line__c pol : trigger.new) {
		poIds.add(pol.AcctSeedERP__Purchase_Order__c);
	}
	apList = [select Id, Final_Invoice__c, AcctSeed__Status__c, Purchase_Order__c from AcctSeed__Account_Payable__c where Purchase_Order__c in: poIds];
	
	for (AcctSeed__Account_Payable__c ap : apList) {
		for (AcctSeedERP__Purchase_Order_Line__c pol : trigger.new) {
			if (ap.Purchase_Order__c == pol.AcctSeedERP__Purchase_Order__c) {
				if (ap.Final_Invoice__c) {
					pol.Final_Invoice_Status__c = ap.AcctSeed__Status__c;
				}
			}
		}
	}
}