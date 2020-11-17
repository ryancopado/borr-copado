@isTest(SeeAllData=true)
public class LH_TEST_Site {
	static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Site__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Site__c()
            );
        }
    	Database.upsert(sourceList);
    }
}