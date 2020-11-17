trigger billingCashReceiptRollUp on AcctSeed__Billing_Cash_Receipt__c (after delete, after insert, after undelete, after update) {
//This needs to use an @future event.
    
    
    
        List<AcctSeed__Billing_Cash_Receipt__c> theBCRs = new List<AcctSeed__Billing_Cash_Receipt__c>();
        
        if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete){
            theBCRs.addAll(trigger.new);
        }
        if(trigger.isDelete){
            theBCRs.addAll(trigger.old);
        }
        List<String>thebillings = new List<String>();
        
        for(AcctSeed__Billing_Cash_Receipt__c bcr:theBCRs){
            thebillings.add(bcr.AcctSeed__Billing__c );
        }
        
        BillingCashReceiptFutureTrigger.calculateReceipt(thebillings);
    
    
}