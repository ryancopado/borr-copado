public with sharing class BillingCashReceiptFutureTrigger {




@future
	public static void calculateReceipt(list<String> ids){
		
		List<AcctSeed__Project__c> prjects = [select id,Roll_Up_Cash_Receipts__c, (select AcctSeed__Billing__c,AcctSeed__Parent_Status__c, AcctSeed__Billing__r.AcctSeed__Received_Amount__c from AcctSeed__Billing_Lines__r) from AcctSeed__Project__c where id in (select AcctSeed__Project__c from AcctSeed__Billing_Line__c where AcctSeed__Billing__c in:ids )];
		
		List<AcctSeed__Project__c> prToUpdate = new List<AcctSeed__Project__c>();
		
		for(AcctSeed__Project__c thePr:prjects){
			String blPasses = '';
			Double theCount = 0;
			for(AcctSeed__Billing_Line__c bli:thePr.AcctSeed__Billing_Lines__r){
				
				if(!blPasses.contains(bli.AcctSeed__Billing__c) && bli.AcctSeed__Parent_Status__c == 'Posted'){
					
					if(bli.AcctSeed__Billing__r.AcctSeed__Received_Amount__c != null){
						theCount += bli.AcctSeed__Billing__r.AcctSeed__Received_Amount__c ;
						blPasses += ',' + bli.AcctSeed__Billing__c;
					}
					
				}
				
				
			}
			
			thePr.Roll_Up_Cash_Receipts__c = theCount;
			
			
			prToUpdate.add(thePr);
			/*if(thePr.AcctSeed__Billing_Lines__r != null && thePr.AcctSeed__Billing_Lines__r.size() >0 && thePr.AcctSeed__Billing_Lines__r[0].AcctSeed__Billing__r.AcctSeed__Received_Amount__c != null){
				if(thePr.Roll_Up_Cash_Receipts__c == null || (thePr.Roll_Up_Cash_Receipts__c != null && thePr.Roll_Up_Cash_Receipts__c != thePr.AcctSeed__Billing_Lines__r[0].AcctSeed__Billing__r.AcctSeed__Received_Amount__c)){
					thePr.Roll_Up_Cash_Receipts__c = thePr.AcctSeed__Billing_Lines__r[0].AcctSeed__Billing__r.AcctSeed__Received_Amount__c ;
					prToUpdate.add(thePr);
				}
			}*/
		}
	
		update prToUpdate;
	}


}