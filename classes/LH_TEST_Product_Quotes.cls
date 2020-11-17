@isTest(SeeAllData=true)
public class LH_TEST_Product_Quotes {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Product_Quotes__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Product_Quotes__c()
            );
        }
       Database.upsert(sourceList);
    }
}