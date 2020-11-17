@isTest(SeeAllData=true)
public class LH_TEST_Request_for_Information_RFI {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Request_for_Information_RFI__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Request_for_Information_RFI__c()
            );
        }
       Database.upsert(sourceList);
    }
}