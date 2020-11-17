@isTest(SeeAllData = true)
private class testConReqGroupControllerExt {
    
    /*
     *  Methods for testing ConReqGroupControllerExt.cls
     *
     */
     
     /* code deactivated on 3/22/2019 to push the changeset 'Error was Lastvieweddate' MG*/

   static testMethod void testConReqGroup1() {

        //Initialize all required objects base objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects();
        
        Project_Products__c pp = new Project_Products__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Product__c = TestAllProjectRollUpTriggers.testProduct.Id
        );
        insert pp;

        Test.StartTest();
               
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;       
        
        //Create a Sales Order Line to use on the Project Task
        AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(Unit_Cost__c= 1, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, Opportunity_Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id, AcctSeedERP__Quantity_Ordered__c = 1, AcctSeedERP__Project_Task__c = projectTask.Id, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id);
        insert salesOrderLine;
        
        // Create the Con Req Group object
        Con_Req_Group__c conReqGroup = new Con_Req_Group__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id
        );
        insert conReqGroup;
        salesOrderLine.Con_Req_Group__c = conReqGroup.Id;
        update salesOrderLine;
        
        //Instantiate a new controller
        ApexPages.StandardController std = new ApexPages.StandardController(conReqGroup);
        ConReqGroupControllerExt ctl = new ConReqGroupControllerExt(std);
        
        ctl.getProjProducts();
        ctl.editGroup();
        ctl.cancelGroup();
        ctl.editGroup();
        conReqGroup.Requested_Delivery_Date__c = system.today();
        ctl.saveGroup();
        
        //--------------------
        ctl.submitGroup();
        ctl.clearLock();
        ctl.recallApproved();
        ctl.deleteSolLine();
        
        //-----------------
        Test.stopTest();  
    }
    
    static testMethod void testConReqGroup2() {

        //Initialize all required objects base objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects();
        
        Project_Products__c pp = new Project_Products__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Product__c = TestAllProjectRollUpTriggers.testProduct.Id
        );
        insert pp;

        Test.StartTest();
               
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;       
        
        //Create a Sales Order Line to use on the Project Task
        AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(Unit_Cost__c= 1, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, Opportunity_Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id, AcctSeedERP__Quantity_Ordered__c = 1, AcctSeedERP__Project_Task__c = projectTask.Id, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id);
        insert salesOrderLine;
        
        // Create the Con Req Group object
        Con_Req_Group__c conReqGroup = new Con_Req_Group__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id
        );
        insert conReqGroup;
        salesOrderLine.Con_Req_Group__c = conReqGroup.Id;
        update salesOrderLine;
        
        //Instantiate a new controller
        ApexPages.StandardController std = new ApexPages.StandardController(conReqGroup);
        ConReqGroupControllerExt ctl = new ConReqGroupControllerExt(std);
        
        ctl.detailAllSolLines();
        ctl.cancelAllSolLines();
        ctl.editAllSolLines();
        salesOrderLine.Not_To_Exceed__c = 'Yes';
        ctl.saveAllSolLines();
        
        ApexPages.currentPage().getParameters().put('solId', salesOrderLine.Id);
        
        ctl.detailSolLine();
        ctl.editSolLine();
        ctl.cloneSolLine();
        
        Test.stopTest();  
    }
    
    static testMethod void testConReqGroup3() {

        //Initialize all required objects base objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects();
        
        Project_Products__c pp = new Project_Products__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Product__c = TestAllProjectRollUpTriggers.testProduct.Id
        );
        insert pp;

        Test.StartTest();
               
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;       
        
        //Create a Sales Order Line to use on the Project Task
        AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(Unit_Cost__c= 1, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, Opportunity_Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id, AcctSeedERP__Quantity_Ordered__c = 1, AcctSeedERP__Project_Task__c = projectTask.Id, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id);
        insert salesOrderLine;
        
        // Create the Con Req Group object
        Con_Req_Group__c conReqGroup = new Con_Req_Group__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id
        );
        insert conReqGroup;
        salesOrderLine.Con_Req_Group__c = conReqGroup.Id;
        update salesOrderLine;
        
        //Instantiate a new controller
        ApexPages.StandardController std = new ApexPages.StandardController(conReqGroup);
        ConReqGroupControllerExt ctl = new ConReqGroupControllerExt(std);
        
        ApexPages.currentPage().getParameters().put('solId', salesOrderLine.Id);
        
        ctl.saveSolLine();
        
        Test.stopTest();  
    }
    
    static testMethod void testConReqGroup4() {

        //Initialize all required objects base objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects();
        
        Project_Products__c pp = new Project_Products__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Product__c = TestAllProjectRollUpTriggers.testProduct.Id
        );
        insert pp;

        Test.StartTest();
               
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;       
        
        //Create a Sales Order Line to use on the Project Task
        AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(Unit_Cost__c= 1, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, Opportunity_Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id, AcctSeedERP__Quantity_Ordered__c = 1, AcctSeedERP__Project_Task__c = projectTask.Id, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id);
        insert salesOrderLine;
        
        // Create the Con Req Group object
        Con_Req_Group__c conReqGroup = new Con_Req_Group__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id
        );
        insert conReqGroup;
        salesOrderLine.Con_Req_Group__c = conReqGroup.Id;
        update salesOrderLine;
        
        //Instantiate a new controller
        ApexPages.StandardController std = new ApexPages.StandardController(conReqGroup);
        ConReqGroupControllerExt ctl = new ConReqGroupControllerExt(std);
        
        ApexPages.currentPage().getParameters().put('solId', salesOrderLine.Id);
        
        ctl.saveAndNewSolLine();
        
        Test.stopTest();  
    }
    
    static testMethod void testConReqGroup5() {

        //Initialize all required objects base objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects();
        
        Project_Products__c pp = new Project_Products__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Product__c = TestAllProjectRollUpTriggers.testProduct.Id
        );
        insert pp;

        Test.StartTest();
               
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;       
        
        //Create a Sales Order Line to use on the Project Task
        AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(Unit_Cost__c= 1, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, Opportunity_Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id, AcctSeedERP__Quantity_Ordered__c = 1, AcctSeedERP__Project_Task__c = projectTask.Id, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id);
        insert salesOrderLine;
        
        // Create the Con Req Group object
        Con_Req_Group__c conReqGroup = new Con_Req_Group__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id
        );
        insert conReqGroup;
        salesOrderLine.Con_Req_Group__c = conReqGroup.Id;
        update salesOrderLine;
        
        //Instantiate a new controller
        ApexPages.StandardController std = new ApexPages.StandardController(conReqGroup);
        ConReqGroupControllerExt ctl = new ConReqGroupControllerExt(std);
        
        ApexPages.currentPage().getParameters().put('solId', salesOrderLine.Id);
        ctl.cancelSolLine();
        
        List<SelectOption> options = ctl.getsolRecordTypes();
        ctl.addSolLine();
        ctl.setsolRTSelected(options[0].getValue());
        String rtSelected = ctl.getsolRTSelected();
        ctl.selectSolRecordType();
        ctl.cancelSolRecordType();
        
        Test.stopTest();  
    }
    
    static testMethod void testConReqGroup6() {

        //Initialize all required objects base objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects();
        
        Project_Products__c pp = new Project_Products__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Product__c = TestAllProjectRollUpTriggers.testProduct.Id
        );
        insert pp;

        Test.StartTest();
               
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;       
        
        //Create a Sales Order Line to use on the Project Task
        AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(Unit_Cost__c= 1, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, Opportunity_Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id, AcctSeedERP__Quantity_Ordered__c = 1, AcctSeedERP__Project_Task__c = projectTask.Id, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id);
        insert salesOrderLine;
        
        // Create the Con Req Group object
        Con_Req_Group__c conReqGroup = new Con_Req_Group__c(
            Project__c = TestAllProjectRollUpTriggers.testProject.Id,
            Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id
        );
        insert conReqGroup;
        salesOrderLine.Con_Req_Group__c = conReqGroup.Id;
        update salesOrderLine;
        
        Attachment att = new Attachment(
            Body = Blob.valueof('This is the body of the attachment'),
            Name = 'File Attachment',
            ParentId = conReqGroup.Id
        );
        insert att;
        delete att;
        
        Test.stopTest();  
    } 
}