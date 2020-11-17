@isTest(SeeAllData=true)
public class RHX_TEST_Contract_Committee_Submittal {

    static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
            FROM Contract_Committee_Submittal__c ORDER BY lastmodifieddate DESC LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Contract_Committee_Submittal__c()
            );
        }
        rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
    
}