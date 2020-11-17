@isTest(SeeAllData=true)
public class RHX_TEST_AcctSeed_AP_Disbursement {
    static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
            FROM AcctSeed__AP_Disbursement__c AcctSeed__AP_Disbursement__c order by lastmodifieddate desc LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeed__AP_Disbursement__c()
            );
        }
        rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}