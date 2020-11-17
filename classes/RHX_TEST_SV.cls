@isTest(SeeAllData=true)
public class RHX_TEST_SV {
    static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
            FROM SV__c ORDER BY lastmodifieddate DESC LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new SV__c()
            );
        }
        rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}