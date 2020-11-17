@isTest(SeeAllData=true)
public class LH_TEST_AcctSeed_Billing_Line {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM AcctSeed__Billing_Line__c ORDER BY CreatedDate DESC LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeed__Billing_Line__c()
            );
        }
       Database.upsert(sourceList);
    }
}