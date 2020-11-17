public without sharing class PendingWorkController {
  @TestVisible private static list<String> WORKORDER_STATUS = new list<String>{'New', 'In Progress', 'On Hold'};
  @TestVisible private static list<String> PENDINGWORK_STATUS = new list<String>{'Open'};
  @AuraEnabled
  public static list<Pending_Work__c> getCaseRelatedWork(String caseId) {
    return [
      Select Id, Name, Asset__c, Asset__r.Name, Project__c, Project__r.Name, Contract__c, Contract__r.ContractNumber, Description_of_Pending_Work__c 
      From Pending_Work__c where Project__c in (select Project__c from case where id= :caseId) and status__c in :PENDINGWORK_STATUS order by Name Asc
    ];
  }
  @AuraEnabled
  public static list<WorkOrder> getCaseRelatedWorkOrders(String caseId) {
    return [
      Select Id, WorkOrderNumber, Status 
      From WorkOrder where CaseId = :caseId and Status in :WORKORDER_STATUS order by createddate Desc
    ];
  }
  @AuraEnabled
  public static string createWorkOrderLineItems(String caseId, String workOrderId, list<String> pendingWorkIds){
    list<WorkOrderLineItem> newWorkOrderLineItems = new list<WorkOrderLineItem>();
    list<Pending_Work__c> updatePendingWorkList = new list<Pending_Work__c>();
    //SELECT Id, LineItemNumber, WorkOrderId, Product2Id, AssetId, OrderId, Description, StartDate, EndDate, Status FROM WorkOrderLineItem
    /* rcdSV.Asset__c = pw.pwrk.Asset__c ;
                     rcdSV.Project__c = pw.pwrk.Project__c ;
                     rcdSV.Case__c = rcdCase.id ; //pw.pwrk.Case__c ;  -- 15-08-2018 Updated as per email from Kumar           
                     rcdSV.Contract__c = pw.pwrk.Contract__c; 
                     rcdSV.Account__c = rcdCase.AccountId ; */
    for (Pending_Work__c currentWork : [Select Id, Name, Asset__c, Project__c, Contract__c, Description_of_Pending_Work__c From Pending_Work__c where Id in :pendingWorkIds AND Project__c in (select Project__c from case where id= :caseId) and status__c in :PENDINGWORK_STATUS]) {
      newWorkOrderLineItems.add(new WorkOrderLineItem(
        WorkOrderId = workOrderId,
        AssetId = currentWork.Asset__c,
        description = currentWork.Description_of_Pending_Work__c,
        External_Id__c = currentWork.Id
      ));
      currentWork.Associated_Case_to_Close__c = caseId;
      currentWork.Work_Order_To_Close__c = workOrderId;
      currentWork.Status__c = 'Assigned';
      currentWork.WOLI_To_Close__r = new WorkOrderLineItem(External_Id__c = currentWork.Id);
      updatePendingWorkList.add(currentWork);
    }
    insert newWorkOrderLineItems;
    update updatePendingWorkList;
    return 'success';
  }
}