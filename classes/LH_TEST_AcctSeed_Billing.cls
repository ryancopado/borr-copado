@isTest(SeeAllData=true)
public class LH_TEST_AcctSeed_Billing {
	static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM AcctSeed__Billing__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeed__Billing__c()
            );
        }
    	Database.upsert(sourceList);
    }
}