@isTest(SeeAllData=true)
public class LH_TEST_AcctSeed_Project_Task {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM AcctSeed__Project_Task__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeed__Project_Task__c()
            );
        }
       Database.upsert(sourceList);
    }
}