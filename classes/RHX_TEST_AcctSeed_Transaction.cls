@isTest(SeeAllData=true)
public class RHX_TEST_AcctSeed_Transaction {

    static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
            FROM AcctSeed__Transaction__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeed__Transaction__c()
            );
        }
        rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
    
}