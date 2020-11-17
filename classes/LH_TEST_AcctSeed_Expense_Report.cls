@isTest(SeeAllData=true)
public class LH_TEST_AcctSeed_Expense_Report {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM AcctSeed__Expense_Report__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeed__Expense_Report__c()
            );
        }
       Database.upsert(sourceList);
    }
}