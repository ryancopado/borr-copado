@isTest(SeeAllData=true)
public class RHX_TEST_Pricing_Tool_Approval {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Pricing_Tool_Approval__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Pricing_Tool_Approval__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}