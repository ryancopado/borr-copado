@isTest(SeeAllData=true)
public class RHX_TEST_Addresses {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Addresses__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Addresses__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}