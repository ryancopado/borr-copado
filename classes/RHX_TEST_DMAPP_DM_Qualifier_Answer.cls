@isTest(SeeAllData=true)
public class RHX_TEST_DMAPP_DM_Qualifier_Answer {

    static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
            FROM DMAPP__DM_Qualifier_Answer__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new DMAPP__DM_Qualifier_Answer__c()
            );
        }
        rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
    
}