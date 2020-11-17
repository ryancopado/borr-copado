@isTest(SeeAllData=true)
public class RHX_TEST_Product_Quotes {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Product_Quotes__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Product_Quotes__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}