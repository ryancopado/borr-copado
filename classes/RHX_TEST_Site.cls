@isTest(SeeAllData=true)
public class RHX_TEST_Site {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Site__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Site__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}