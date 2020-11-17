/* Auther: Madan (Forcebrain Developer)
   Date: Jan 18, 2017
   Description: Lock Sales Budget button functionality test class
   */
@isTest(SeeAllData = true) 
private class TestLockSalesBudget {

    static testMethod void myUnitTest() { 
		
		//Initialize all required objects base objects
		TestAllProjectRollUpTriggers.initalizeBaseObjects();
		
		//Create a new project task records
		List<Cost_Code__c> ccList = new List<Cost_Code__c>();
		ccList = [select Id, Category__c, Grouping__c from Cost_Code__c where (Category__c = 'L' or Category__c = 'M' or Category__c = 'S') and Grouping__c != null and Old__c = false and Active__c = true];
		Id cc1Id = null;
		Id cc2Id = null;
		Id cc3Id = null;
		for (Cost_Code__c cc :ccList) {
			if (cc.Category__c == 'M' && cc1Id == null) {
				cc1Id = cc.Id;
			}
			if (cc.Category__c == 'L' && cc2Id == null) {
				cc2Id = cc.Id;
			}
			if (cc.Category__c == 'S' && cc3Id == null) {
				cc3Id = cc.Id;
			}
		}
		List<AcctSeed__Project_Task__c> projectTasks = new List<AcctSeed__Project_Task__c>();
		projectTasks.add(new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task3', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123, Cost_Code__c = cc1Id));
		projectTasks.add(new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task2', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123, Cost_Code__c = cc2Id));
		projectTasks.add(new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task1', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123, Cost_Code__c = cc3Id));
		insert projectTasks;
		
		ApexPages.currentPage().getParameters().put('id',TestAllProjectRollUpTriggers.testProject.Id);
		LockSalesBudget theController = new LockSalesBudget();
		theController.doInit();
    }
}