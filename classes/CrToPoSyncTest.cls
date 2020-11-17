@isTest(seeAllData=true)
public with sharing class CrToPoSyncTest {


    static testMethod void testCRtoPOSync() {

        //Initialize all required objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects();       

        Test.StartTest();
               
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;       
        
        //Create a Sales Order Line to use on the Project Task
       
    
        
        AcctSeedERP__Purchase_Order_Line__c purchaseOrderLine = new AcctSeedERP__Purchase_Order_Line__c(AcctSeedERP__Purchase_Order__c = TestAllProjectRollUpTriggers.testPurchaseOrder.Id, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Quantity__c = 1, AcctSeedERP__Unit_Price__c = 1.00, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeedERP__Project_Task__c = projectTask.Id);
        insert purchaseOrderLine; 
        
        
        
         AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(Unit_Cost__c= 1,AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id, AcctSeedERP__Quantity_Ordered__c = 1, AcctSeedERP__Project_Task__c = projectTask.Id, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id);
         
         
         
        insert salesOrderLine;
        
        
        
        salesOrderLine.Ship_to_Account__c = TestAllProjectRollUpTriggers.testAccount.Id;
        salesOrderLine.Vendor_Contact__c = TestAllProjectRollUpTriggers.testContact.Id;
        
        
        salesOrderLine.AcctSeedERP__Purchase_Order_Line__c = purchaseOrderLine.Id;
        
        update salesOrderLine;
        
        
        
        
        List<AcctSeedERP__Purchase_Order_Line__c> POLines = [select Ship_to_Account__c from AcctSeedERP__Purchase_Order_Line__c where id =:purchaseOrderLine.ID];
    
        List<AcctSeedERP__Purchase_Order__c> POs = [select AcctSeedERP__Vendor_Contact__c, AcctSeedERP__Shipping_Company__c from AcctSeedERP__Purchase_Order__c where id =: TestAllProjectRollUpTriggers.testPurchaseOrder.Id];

        
        
        System.assert(POLines[0].Ship_to_Account__c == TestAllProjectRollUpTriggers.testAccount.Id);
        System.assert(POs[0].AcctSeedERP__Vendor_Contact__c == TestAllProjectRollUpTriggers.testContact.Id);
        
        Test.stopTest();  
        

    }

}