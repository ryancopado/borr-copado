@isTest(SeeAllData=true)
public class RHX_TEST_Project_Finance_Checklist {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Project_Finance_Checklist__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Project_Finance_Checklist__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}