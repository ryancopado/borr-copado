@isTest(SeeAllData=true)
public class LH_TEST_AcctSeed_Account_Payable_Line {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM AcctSeed__Account_Payable_Line__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeed__Account_Payable_Line__c()
            );
        }
       Database.upsert(sourceList);
    }
}