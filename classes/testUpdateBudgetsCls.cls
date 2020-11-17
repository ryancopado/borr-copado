@isTest (SeeAllData = true) 
private class testUpdateBudgetsCls {

    public static testmethod void budgetTest1() { 
		
		//Initialize all required objects base objects
		TestAllProjectRollUpTriggers.initalizeBaseObjects();
		
		//Create a new project task
		AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
		insert projectTask;
		/*
		TestAllProjectRollUpTriggers.testProject.PM_Lock__c = false;
		update TestAllProjectRollUpTriggers.testProject;
		*/
		ApexPages.StandardController stdController = new ApexPages.Standardcontroller(TestAllProjectRollUpTriggers.testProject);
		
		UpdateBudgetsCls theController = new UpdateBudgetsCls(stdController);
		
		List<String> Profiless = new List<String> {'Sys Admin w/o HR','System Administrator'};
		List<profile> profiles = [select id from profile where id=:Userinfo.getProfileId() and name in: Profiless];
		
		if (profiles.isEmpty()) {
			System.assert(!theController.getAmISysAdmin() );
		} else {
			System.assert(theController.getAmISysAdmin() );
		}
		
		List<String> PMProfiles = new List<String> {'Sys Admin w/o HR','System Administrator','Borrego - PM','Borrego - COO','Borrego-Dir of Ops'};
		profiles = [select id from profile where id=:Userinfo.getProfileId() and  name in: PMProfiles];
		
		if (profiles.isEmpty()) {
			System.assert(!theController.getAmIPM() );
		} else {
			System.assert(theController.getAmIPM() );
		}
		theController.getAmIApps();
		
		System.assert(!theController.theProject.PM_Lock__c);
		theController.getUnlock();
		theController.PMsave();
		theController.SaveIt();
		/*
		theController.LockIt();

		System.assert(theController.theProject.PM_Lock__c);
		
		theController.unLockIt();
		System.assert(!theController.theProject.PM_Lock__c);
		
		theController.Cancel();
		
		ApexPages.currentPage().getParameters().put('columnSort', 'Name');
		theController.sortLineItems();
		theController.sortLineItems();
		ApexPages.currentPage().getParameters().put('columnSort', 'Category');
		theController.sortLineItems();
		theController.sortLineItems();
		ApexPages.currentPage().getParameters().put('columnSort', 'Grouping');
		theController.sortLineItems();
		theController.sortLineItems();
		*/
    }
    
    public static testmethod void budgetTest2() { 
		
		//Initialize all required objects base objects
		TestAllProjectRollUpTriggers.initalizeBaseObjects();
		/*
		//Create a new project task
		AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
		insert projectTask;
		
		TestAllProjectRollUpTriggers.testProject.PM_Lock__c = false;
		update TestAllProjectRollUpTriggers.testProject;
		*/
		ApexPages.StandardController stdController = new ApexPages.Standardcontroller(TestAllProjectRollUpTriggers.testProject);
		
		UpdateBudgetsCls theController = new UpdateBudgetsCls(stdController);
		/*
		List<String> Profiless = new List<String> {'Sys Admin w/o HR','System Administrator'};
		List<profile> profiles = [select id from profile where id=:Userinfo.getProfileId() and name in: Profiless];
		
		if (profiles.isEmpty()) {
			System.assert(!theController.getAmISysAdmin() );
		} else {
			System.assert(theController.getAmISysAdmin() );
		}
		
		List<String> PMProfiles = new List<String> {'Sys Admin w/o HR','System Administrator','Borrego - PM','Borrego - COO','Borrego-Dir of Ops'};
		profiles = [select id from profile where id=:Userinfo.getProfileId() and  name in: PMProfiles];
		
		if (profiles.isEmpty()) {
			System.assert(!theController.getAmIPM() );
		} else {
			System.assert(theController.getAmIPM() );
		}
		
		System.assert(!theController.theProject.PM_Lock__c);
		theController.getUnlock();
		theController.PMsave();
		theController.SaveIt();
		*/
		theController.LockIt();

		System.assert(theController.theProject.PM_Lock__c);
		
		theController.unLockIt();
		System.assert(!theController.theProject.PM_Lock__c);
		
		theController.getLock();
		theController.Cancel();
		/*
		ApexPages.currentPage().getParameters().put('columnSort', 'Name');
		theController.sortLineItems();
		theController.sortLineItems();
		ApexPages.currentPage().getParameters().put('columnSort', 'Category');
		theController.sortLineItems();
		theController.sortLineItems();
		ApexPages.currentPage().getParameters().put('columnSort', 'Grouping');
		theController.sortLineItems();
		theController.sortLineItems();
		*/
    }
    
    public static testmethod void budgetTest3() { 
		
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
		/*
		TestAllProjectRollUpTriggers.testProject.PM_Lock__c = false;
		update TestAllProjectRollUpTriggers.testProject;
		*/
		ApexPages.StandardController stdController = new ApexPages.Standardcontroller(TestAllProjectRollUpTriggers.testProject);
		
		UpdateBudgetsCls theController = new UpdateBudgetsCls(stdController);
		/*
		List<String> Profiless = new List<String> {'Sys Admin w/o HR','System Administrator'};
		List<profile> profiles = [select id from profile where id=:Userinfo.getProfileId() and name in: Profiless];
		
		if (profiles.isEmpty()) {
			System.assert(!theController.getAmISysAdmin() );
		} else {
			System.assert(theController.getAmISysAdmin() );
		}
		
		List<String> PMProfiles = new List<String> {'Sys Admin w/o HR','System Administrator','Borrego - PM','Borrego - COO','Borrego-Dir of Ops'};
		profiles = [select id from profile where id=:Userinfo.getProfileId() and  name in: PMProfiles];
		
		if (profiles.isEmpty()) {
			System.assert(!theController.getAmIPM() );
		} else {
			System.assert(theController.getAmIPM() );
		}
		
		System.assert(!theController.theProject.PM_Lock__c);
		theController.getUnlock();
		theController.PMsave();
		theController.SaveIt();
		
		theController.LockIt();

		System.assert(theController.theProject.PM_Lock__c);
		
		theController.unLockIt();
		System.assert(!theController.theProject.PM_Lock__c);
		
		theController.Cancel();
		*/
		ApexPages.currentPage().getParameters().put('columnSort', 'Name');
		theController.sortLineItems();
		theController.sortLineItems();
		ApexPages.currentPage().getParameters().put('columnSort', 'Category');
		theController.sortLineItems();
		theController.sortLineItems();
		ApexPages.currentPage().getParameters().put('columnSort', 'Grouping');
		theController.sortLineItems();
		theController.sortLineItems();
		
		theController.LockSalesBudget();
		theController.unLockSalesBudget();
		
    }
}