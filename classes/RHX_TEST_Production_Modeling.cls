@isTest(SeeAllData=true)
public class RHX_TEST_Production_Modeling {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Production_Modeling__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Production_Modeling__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}