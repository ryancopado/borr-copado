@isTest(SeeAllData=true)
public class LH_TEST_WorkOrderLineItem {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM WorkOrderLineItem LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new WorkOrderLineItem()
            );
        }
       Database.upsert(sourceList);
    }
}