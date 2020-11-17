@isTest(SeeAllData=true)
public class RHX_TEST_AcctSeedERP_Inbound_Inventor163 {
    static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
            FROM AcctSeedERP__Inbound_Inventory_Movement__c order by lastmodifieddate desc LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new AcctSeedERP__Inbound_Inventory_Movement__c()
            );
        }
        rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}