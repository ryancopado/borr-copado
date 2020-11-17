@isTest(SeeAllData=true)
public class RHX_TEST_TimeSheetEntry {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM TimeSheetEntry LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new TimeSheetEntry()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}