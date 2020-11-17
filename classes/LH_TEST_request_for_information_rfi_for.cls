@isTest(SeeAllData=true)
public class LH_TEST_request_for_information_rfi_for {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM request_for_information_rfi__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new request_for_information_rfi__c()
            );
        }
       Database.upsert(sourceList);
    }
}