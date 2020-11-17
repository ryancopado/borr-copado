@isTest(SeeAllData=true)
public class LH_TEST_Con_Req {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Con_Req__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Con_Req__c()
            );
        }
       Database.upsert(sourceList);
    }
}