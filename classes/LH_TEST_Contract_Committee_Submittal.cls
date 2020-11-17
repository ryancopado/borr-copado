@isTest(SeeAllData=true)
public class LH_TEST_Contract_Committee_Submittal {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Contract_Committee_Submittal__c ORDER BY lastmodifieddate DESC LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Contract_Committee_Submittal__c()
            );
        }
       Database.upsert(sourceList);
    }
}