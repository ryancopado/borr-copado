@isTest(SeeAllData=true)
public class LH_TEST_SFDC_Purchase_Requisition {
    static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
            FROM SFDC_Purchase_Requisition__c ORDER BY lastmodifieddate DESC LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new SFDC_Purchase_Requisition__c()
            );
        }
        Database.upsert(sourceList);
    }
}