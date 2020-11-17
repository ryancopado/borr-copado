@isTest(SeeAllData=true)
public class LH_TEST_Test_Report {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Test_Report__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Test_Report__c()
            );
        }
       Database.upsert(sourceList);
    }
}