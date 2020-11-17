@isTest(SeeAllData=true)
public class LH_TEST_Employee_Development_Tracker {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Employee_Development_Tracker__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Employee_Development_Tracker__c()
            );
        }
       Database.upsert(sourceList);
    }
}