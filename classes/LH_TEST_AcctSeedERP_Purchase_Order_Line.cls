@isTest(SeeAllData=true)
public class LH_TEST_AcctSeedERP_Purchase_Order_Line {
	static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM AcctSeedERP__Purchase_Order_Line__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeedERP__Purchase_Order_Line__c()
            );
        }
    	Database.upsert(sourceList);
    }
}