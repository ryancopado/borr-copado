@isTest(SeeAllData=true)
public class LH_TEST_Specification_1 {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Specification_1__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Specification_1__c()
            );
        }
       Database.upsert(sourceList);
    }
}