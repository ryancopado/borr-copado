@isTest(SeeAllData=true)
public class RHX_TEST_Terms_Conditions {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Terms_Conditions__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Terms_Conditions__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}