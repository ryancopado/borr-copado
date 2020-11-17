@isTest(SeeAllData=true)
public class LH_TEST_opportunity_for_site {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM opportunity LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new opportunity()
            );
        }
       Database.upsert(sourceList);
    }
}