@isTest(SeeAllData=true)
public class RHX_TEST_Volume_Commitment {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Volume_Commitment__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Volume_Commitment__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}