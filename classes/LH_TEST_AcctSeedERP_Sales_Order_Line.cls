@isTest(SeeAllData=true)
public class LH_TEST_AcctSeedERP_Sales_Order_Line {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM AcctSeedERP__Sales_Order_Line__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeedERP__Sales_Order_Line__c()
            );
        }
       Database.upsert(sourceList);
    }
}