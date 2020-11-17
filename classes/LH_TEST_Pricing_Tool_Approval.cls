@isTest(SeeAllData=true)
public class LH_TEST_Pricing_Tool_Approval {
	static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Pricing_Tool_Approval__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Pricing_Tool_Approval__c()
            );
        }
    	Database.upsert(sourceList);
    }
}