@isTest(SeeAllData=true)
public class LH_TEST_Shop_Drawing_1 {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Shop_Drawing_1__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Shop_Drawing_1__c()
            );
        }
       Database.upsert(sourceList);
    }
}