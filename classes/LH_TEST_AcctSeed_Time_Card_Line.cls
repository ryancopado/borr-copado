@isTest(SeeAllData=true)
public class LH_TEST_AcctSeed_Time_Card_Line {
    static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
            FROM AcctSeed__Time_Card_Line__c ORDER BY lastmodifieddate DESC LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeed__Time_Card_Line__c()
            );
        }
        Database.upsert(sourceList);
    }
}