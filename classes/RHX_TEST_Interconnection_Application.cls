@isTest(SeeAllData=true)
public class RHX_TEST_Interconnection_Application {

    static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
            FROM Interconnection_Application__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Interconnection_Application__c()
            );
        }
        rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
    
}