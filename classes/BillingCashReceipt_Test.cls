@isTest(seealldata = true)
public class BillingCashReceipt_Test {
    static testMethod void billingCashReceipt(){
        List<AcctSeed__Billing_Cash_Receipt__c> listBCR = new List<AcctSeed__Billing_Cash_Receipt__c>();
        List<AcctSeed__Billing_Cash_Receipt__c> listNewBCR = new List<AcctSeed__Billing_Cash_Receipt__c>();
        List<AcctSeed__Accounting_Period__c> listAccPeriod = new List<AcctSeed__Accounting_Period__c>();
        listBCR = [SELECT Id, AcctSeed__Billing__c, AcctSeed__Cash_Receipt__c, AcctSeed__Applied_Amount__c, AcctSeed__Accounting_Period__c
                   FROM AcctSeed__Billing_Cash_Receipt__c WHERE AcctSeed__Billing__c != Null AND AcctSeed__Accounting_Period__r.AcctSeed__Status__c = 'Open'
                   AND AcctSeed__Cash_Receipt__c != Null AND AcctSeed__Applied_Amount__c != Null LIMIT 10];
         listAccPeriod = [SELECT Id, AcctSeed__Status__c, AcctSeed__Start_Date__c FROM AcctSeed__Accounting_Period__c 
                          WHERE AcctSeed__Status__c = 'Open' ORDER BY AcctSeed__Start_Date__c ASC];
        for(AcctSeed__Billing_Cash_Receipt__c bcr : listBCR){
            AcctSeed__Billing_Cash_Receipt__c newBCR = new AcctSeed__Billing_Cash_Receipt__c();
            newBCR = bcr.clone(false, true, false, false);
            newBCR.Id = Null;
            newBCR.AcctSeed__Accounting_Period__c = listAccPeriod[0].Id;
            listNewBCR.add(newBCR);
        }
        delete listBCR;
        //undelete listBCR;
        //insert listNewBCR;
    }
}