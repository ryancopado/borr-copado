@isTest
private class PendingWorkControllerTest {
  private static Account newAccount(String accountName) {
    return new Account(
      Name = accountName
    );
  }
  private static AcctSeed__Project__c newProject(String projectName, Id accountId) {
    return new AcctSeed__Project__c(
      Name = projectName,
      AcctSeed__Account__c = accountId
    );
  }
  private static Case newCase(Id accountId) {
    return newCase(accountId, null);
  }
  private static Case newCase(Id accountId, Id projectId) {
    return new Case(
      AccountId = accountId,
      Project__c = projectId
    );
  }
  private static WorkOrder newWorkOrder(Id caseId) {
    return new WorkOrder(
      CaseId = caseId,
      Status = PendingWorkController.WORKORDER_STATUS[0]
    );
  }
  private static Pending_Work__c newPendingWork(Id accountId, Id projectId, Id caseId) {
    return new Pending_Work__c(
      Account__c = accountId,
      Project__c = projectId,
      Case__c = caseId,
      status__c = PendingWorkController.PENDINGWORK_STATUS[0]
    );
  }
  
  @isTest
  static void relatedWorkOrderTest() {
    Account testAccount = newAccount('Test Company');
    insert testAccount;
    AcctSeed__Project__c testProject = newProject('testProject', testAccount.Id);
    insert testProject;
    Case testPriorCase = newCase(testAccount.Id, testProject.Id);
    insert testPriorCase;
    Pending_Work__c testPendingWork = newPendingWork(testAccount.Id, testProject.Id, testPriorCase.Id);
    insert testPendingWork;

    Case testNewCase = newCase(testAccount.Id, testProject.Id);
    insert testNewCase;
    WorkOrder testWorkOrder = newWorkOrder(testNewCase.Id);
    insert testWorkOrder;
    list<Pending_Work__c> returnWork = PendingWorkController.getCaseRelatedWork(testNewCase.Id);
    system.assert(!returnWork.isEmpty(),'Project related work found');

    list<WorkOrder> returnWorkOrder = PendingWorkController.getCaseRelatedWorkOrders(testNewCase.Id);
    system.assert(!returnWorkOrder.isEmpty(),'case related work orders returned');
  }
  @isTest
  static void createWorkorderlineitemsTest() {
    Account testAccount = newAccount('Test Company');
    insert testAccount;
    AcctSeed__Project__c testProject = newProject('testProject', testAccount.Id);
    insert testProject;
    Case testPriorCase = newCase(testAccount.Id, testProject.Id);
    insert testPriorCase;
    Pending_Work__c testPendingWork = newPendingWork(testAccount.Id, testProject.Id, testPriorCase.Id);
    insert testPendingWork;

    Case testNewCase = newCase(testAccount.Id, testProject.Id);
    insert testNewCase;
    WorkOrder testWorkOrder = newWorkOrder(testNewCase.Id);
    insert testWorkOrder;
    String returnResponse = PendingWorkController.createWorkOrderLineItems(testNewCase.Id,testWorkOrder.Id,new list<Id>{testPendingWork.Id});
    system.assert('success'.equalsIgnoreCase(returnResponse), 'method successful');

    list<WorkOrderLineItem> insertedWorkOrderLineItem = [select id from WorkOrderLineItem where WorkOrderId = :testWorkOrder.Id];
    system.assert(!insertedWorkOrderLineItem.isEmpty(), 'Line items created');
  }
}