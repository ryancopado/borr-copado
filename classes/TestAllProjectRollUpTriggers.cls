@isTest(seealldata=True) 

public class TestAllProjectRollUpTriggers {

    public static Account testAccount = null;
    public static Contact testContact = null;
    public static Opportunity testOpportunity = null;
    public static AcctSeed__Project__c testProject = null;
    public static AcctSeed__GL_Account__c testGLAccount = null;
    public static AcctSeed__GL_Account__c testGLAccount1 = null;
    public static AcctSeed__Account_Payable__c testAccountsPayable = null;
    public static Product2 testProduct = null;
    public static AcctSeedERP__Sales_Order__c testSalesOrder = null;
    public static AcctSeed__Billing__c testBilling = null;
    public static AcctSeed__Accounting_Period__c testAccountingPeriod = null;
    public static AcctSeedERP__Purchase_Order__c testPurchaseOrder = null;
    public static AcctSeedERP__Warehouse__c testWarehouse = null;
    
    public static AcctSeedERP__Location__c testLocation = null;

    public static AcctSeedERP__Inventory_Balance__c testInventoryBalance = null;
    
    
    public static testMethod void initalizeBaseObjects(){
        if(testAccount == null){
            //Create Account
            TestAllProjectRollUpTriggers.testAccount = new Account(Name = 'Test test', Branch__c = 'Southeast', ShippingCity = 'San Francisco');
            insert TestAllProjectRollUpTriggers.testAccount;
            
            
            testContact = new Contact(
                FirstName = 'John',
                LastName = 'Doe',
                accountId = testAccount.Id
            );
            
            insert testContact;
            
            //Create Opportunity
            TestAllProjectRollUpTriggers.testOpportunity = new Opportunity(Name = 'Test test', AccountId = TestAllProjectRollUpTriggers.testAccount.Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                                                                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000, Proposed_System_Size__c = 10000,
                                                                System_Owner__c = testContact.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                                                                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), Financing__c = 'Cash', 
                                                                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
            insert TestAllProjectRollUpTriggers.testOpportunity;                            
    
            //Create a Project for this test
            TestAllProjectRollUpTriggers.testProject = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Account__c = TestAllProjectRollUpTriggers.testAccount.Id, AcctSeed__Opportunity__c = TestAllProjectRollUpTriggers.testOpportunity.Id, Branch__c = 'Southeast',PC_Code__c = 10, LH_Applications_Eng__c = UserInfo.getUserId());
            insert TestAllProjectRollUpTriggers.testProject;
    
            //Create a new GL Account to use for this test
            TestAllProjectRollUpTriggers.testGLAccount = new AcctSeed__GL_Account__c(AcctSeed__Type__c = 'Expense', Name = 'Test GL Account');
            insert TestAllProjectRollUpTriggers.testGLAccount;
            
               
            //Create an Accounting Period to use for the test
            TestAllProjectRollUpTriggers.testAccountingPeriod = new AcctSeed__Accounting_Period__c(Name = '2200-01',AcctSeed__Start_Date__c = date.today().addYears(5), AcctSeed__End_Date__c = date.today().addYears(5).addMonths(3), AcctSeed__Status__c = 'Open');
            insert TestAllProjectRollUpTriggers.testAccountingPeriod;
            
            //Create a new Account Payable to use for this test
            TestAllProjectRollUpTriggers.testAccountsPayable = new AcctSeed__Account_Payable__c(AcctSeed__Status__c = 'In Process', AcctSeed__Payee_Reference__c = 'Test Account Payable', AcctSeed__Date__c = date.today(), AcctSeed__Due_Date__c = date.today(), AcctSeed__Contact__c = TestMethods.getContact().Id, AcctSeed__Accounting_Period__c = TestAllProjectRollUpTriggers.testAccountingPeriod.Id);
            insert TestAllProjectRollUpTriggers.testAccountsPayable;
        
            //Create a Product to use for this test
            TestAllProjectRollUpTriggers.testProduct = new Product2(Name = 'Test Trigger Product - DELETEME', AcctSeed__Inventory_Type__c = 'Purchased', AcctSeed__Inventory_Product__c = true, RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Solar Module').getRecordTypeId(), 
                                                                    ProductCode = 'TESTTRIGGER', Description = 'Test Trigger Product - DELETEME', Manufacturer_Account__c = TestAllProjectRollUpTriggers.testAccount.Id, Status__c = 'Under Consideration', 
                                                                    AcctSeed__Inventory_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Expense_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Revenue_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Unit_Cost__c = 10.00);
            insert TestAllProjectRollUpTriggers.testProduct;
        
            //Create a warehouse
            TestAllProjectRollUpTriggers.testWarehouse = new AcctSeedERP__Warehouse__c(Name = 'Test Warehouse');
            insert TestAllProjectRollUpTriggers.testWarehouse;
            
            //Create a warehouse location
            TestAllProjectRollUpTriggers.testLocation = new AcctSeedERP__Location__c(AcctSeedERP__Warehouse__c = TestAllProjectRollUpTriggers.testWarehouse.Id);
            insert TestAllProjectRollUpTriggers.testLocation;
            
            //Create an inventory balance
            TestAllProjectRollUpTriggers.testInventoryBalance = new AcctSeedERP__Inventory_Balance__c(AcctSeedERP__Warehouse__c = TestAllProjectRollUpTriggers.testWarehouse.Id, AcctSeedERP__Location__c = TestAllProjectRollUpTriggers.testLocation.Id, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id);
            insert TestAllProjectRollUpTriggers.testInventoryBalance;
    
            //Create a Sales Order to use on the Sales Order Line
            TestAllProjectRollUpTriggers.testSalesOrder = new AcctSeedERP__Sales_Order__c(AcctSeedERP__Customer__c = TestAllProjectRollUpTriggers.testAccount.Id, AcctSeedERP__Status__c = 'Open', Project__c = TestAllProjectRollUpTriggers.testProject.Id);
            insert TestAllProjectRollUpTriggers.testSalesOrder;
     
            //Create a Billing to use on the Billing Line
            TestAllProjectRollUpTriggers.testBilling = new AcctSeed__Billing__c(AcctSeed__Date__c = date.today(), AcctSeed__Customer__c = TestAllProjectRollUpTriggers.testAccount.Id, AcctSeed__Accounting_Period__c = TestAllProjectRollUpTriggers.testAccountingPeriod.Id);
            insert TestAllProjectRollUpTriggers.testBilling;
            
            
            //Create an Accounting Period to use for the test
            TestAllProjectRollUpTriggers.testAccountingPeriod = new AcctSeed__Accounting_Period__c(Name = '2300-01',AcctSeed__Start_Date__c = date.today().addYears(10), AcctSeed__End_Date__c = date.today().addYears(10).addMonths(3), AcctSeed__Status__c = 'Open');
            insert TestAllProjectRollUpTriggers.testAccountingPeriod;
            
            
            //Create a Purchase Order to use for the test
            TestAllProjectRollUpTriggers.testPurchaseOrder = new AcctSeedERP__Purchase_Order__c(AcctSeedERP__Type__c = 'Standard', AcctSeedERP__Status__c = 'Open', AcctSeedERP__Order_Date__c = date.today()); //AcctSeedERP__Vendor__c = TestAllProjectRollUpTriggers.testAccount.Id);
            insert TestAllProjectRollUpTriggers.testPurchaseOrder;
            
           
            
            
        }
        
    }

    static testMethod void testProjectRollUpTriggers1() {

        //Initialize all required objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects();       

        Test.StartTest();
               
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;       
        
        //Create a Sales Order Line to use on the Project Task
        AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(Unit_Cost__c= 1,AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id, AcctSeedERP__Quantity_Ordered__c = 1, AcctSeedERP__Project_Task__c = projectTask.Id, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id);
        insert salesOrderLine;
    
        
        //Delete relevant the related objects to invoke delete triggers
        
        delete salesOrderLine;
        //delete projectTask;
        
        Test.stopTest();  
        

    }
    
    static testMethod void testProjectRollUpTriggers2() {
        //Initialize all required objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects(); 
        
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask; 
        
        Test.StartTest();   
                
        //Create a new Billing Line on the Project Task
        AcctSeed__Billing_Line__c billingLine = new AcctSeed__Billing_Line__c(AcctSeed__Billing__c = TestAllProjectRollUpTriggers.testBilling.Id, AcctSeed__Hours_Units__c = 1, AcctSeed__Rate__c = 10.0, AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Project_Task__c = projectTask.Id);
        
        AcctSeed__Billing__c billing = [select Id, Name, AcctSeed__Billing_Format__c from AcctSeed__Billing__c where Id = :TestAllProjectRollUpTriggers.testBilling.Id];
        
        insert billingLine;
        
        
        //Create an Account Payable Line on the Project Task
        AcctSeed__Account_Payable_Line__c accountPayableLine = new AcctSeed__Account_Payable_Line__c(AcctSeed__Date__c = date.today(), AcctSeed__Account_Payable__c = TestAllProjectRollUpTriggers.testAccountsPayable.Id, AcctSeed__Amount__c = 100.00, AcctSeed__Expense_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Project_Task__c = projectTask.Id);
        insert accountPayableLine;
        
        //accountPayableLine.AcctSeed__Amount__c = 200;
        //update accountPayableLine;
        
        delete accountPayableLine;

        delete billingLine;
        
        Test.stopTest();
    
    
    }
    
    static testMethod void testProjectRollUpTriggers3() {
        //Initialize all required objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects(); 
        
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask; 
        
        //Create an Accounting Period that is open today if necessary
        List<AcctSeed__Accounting_Period__c> accountingPeriods = new List<AcctSeed__Accounting_Period__c>();
        accountingPeriods = [select Id, Name, AcctSeed__Start_Date__c, AcctSeed__End_Date__c, AcctSeed__Status__c
                from AcctSeed__Accounting_Period__c where AcctSeed__Status__c = 'Open' and AcctSeed__Start_Date__c <= TODAY and AcctSeed__End_Date__c >= TODAY];
        if (accountingPeriods.isEmpty()) {
            accountingPeriods.add(new AcctSeed__Accounting_Period__c(Name = '2400-01',AcctSeed__Start_Date__c = date.today(), AcctSeed__End_Date__c = date.today().addMonths(3), AcctSeed__Status__c = 'Open'));
            insert accountingPeriods;
        }
        
        Test.StartTest();   
                
        //Inbound Inventory
        AcctSeedERP__Inbound_Inventory_Movement__c inboundInventoryMovement = new AcctSeedERP__Inbound_Inventory_Movement__c(AcctSeedERP__Inventory_Balance__c = TestAllProjectRollUpTriggers.testInventoryBalance.Id, AcctSeedERP__Quantity__c = 5, AcctSeedERP__Type__c = 'Inventory Transfer', AcctSeedERP__Unit_Cost__c = 10.00, AcctSeedERP__Movement_Date__c = date.today(), AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeedERP__Project_Task__c = projectTask.Id);
        insert inboundInventoryMovement;
        
        //Outbound Inventory
        AcctSeedERP__Outbound_Inventory_Movement__c outboundInventoryMovement = new AcctSeedERP__Outbound_Inventory_Movement__c(AcctSeedERP__Inventory_Balance__c = TestAllProjectRollUpTriggers.testInventoryBalance.Id, AcctSeedERP__Quantity__c = 2, AcctSeedERP__Type__c = 'Inventory Transfer', AcctSeedERP__Unit_Cost__c = 10.00, AcctSeedERP__Movement_Date__c = date.today(), AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeedERP__Project_Task__c = projectTask.Id);
        insert outboundInventoryMovement;

        delete outboundInventoryMovement;
        //delete inboundInventoryMovement;
        
        Test.stopTest();
    
    
    }
    
     static testMethod void testProjectRollUpTriggers4() {
        //Initialize all required objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects(); 
        Test.StartTest();
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask; 
        

        //Purchase Order Line
        //AcctSeedERP__Purchase_Order_Line__c
         Test.stopTest();
        AcctSeedERP__Purchase_Order_Line__c purchaseOrderLine = new AcctSeedERP__Purchase_Order_Line__c(AcctSeedERP__Purchase_Order__c = TestAllProjectRollUpTriggers.testPurchaseOrder.Id, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Quantity__c = 1, AcctSeedERP__Unit_Price__c = 1.00, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeedERP__Project_Task__c = projectTask.Id);
        insert purchaseOrderLine; 
        
        delete purchaseOrderLine;
        
    
    
    }
    
    
    
    static testMethod void testProjectRollUpTriggers5() {
        //Initialize all required objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects(); 
        Test.StartTest();
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask; 
        

        //Create a Cash Receipt for use on the Transaction
        AcctSeed__Cash_Receipt__c cashReceipt = new AcctSeed__Cash_Receipt__c(AcctSeed__Account__c = TestAllProjectRollUpTriggers.testAccount.Id, AcctSeed__Status__c = 'In Process', AcctSeed__Amount__c = 10.00, AcctSeed__Payment_Reference__c = '1234', AcctSeed__Purpose__c = 'Customer Receipt', AcctSeed__Accounting_Period__c = TestAllProjectRollUpTriggers.testAccountingPeriod.Id, AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Project_Task__c = projectTask.Id);
       // try{
         insert cashReceipt;
        //} catch (DMLException dme){
        //  System.debug(Logginglevel.INFO,'DMLException from AcctSeed trigger' + dme);
        //}    
                
        //Purchase Order Line
        //AcctSeedERP__Purchase_Order_Line__c
         Test.stopTest();
        AcctSeedERP__Purchase_Order_Line__c purchaseOrderLine = new AcctSeedERP__Purchase_Order_Line__c(AcctSeedERP__Purchase_Order__c = TestAllProjectRollUpTriggers.testPurchaseOrder.Id, AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, AcctSeedERP__Quantity__c = 1, AcctSeedERP__Unit_Price__c = 1.00, AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeedERP__Project_Task__c = projectTask.Id);
        insert purchaseOrderLine; 
        
        //Create an Accounting Period that is open today if necessary
        List<AcctSeed__Accounting_Period__c> accountingPeriods = new List<AcctSeed__Accounting_Period__c>();
        accountingPeriods = [select Id, Name, AcctSeed__Start_Date__c, AcctSeed__End_Date__c, AcctSeed__Status__c 
                from AcctSeed__Accounting_Period__c where AcctSeed__Status__c = 'Open' and AcctSeed__Start_Date__c <= TODAY and AcctSeed__End_Date__c >= TODAY];
        if (accountingPeriods.isEmpty()) {
            accountingPeriods.add(new AcctSeed__Accounting_Period__c(Name = '2500-01',AcctSeed__Start_Date__c = date.today(), AcctSeed__End_Date__c = date.today().addMonths(3), AcctSeed__Status__c = 'Open'));
            insert accountingPeriods;
        }
        
     //create a billing cash
        AcctSeed__Billing_Cash_Receipt__c BCR = new AcctSeed__Billing_Cash_Receipt__c(AcctSeed__Cash_Receipt__c = cashReceipt.Id, AcctSeed__Applied_Amount__c = 0,AcctSeed__Billing__c=TestAllProjectRollUpTriggers.testBilling.id, AcctSeed__Accounting_Period__c = TestAllProjectRollUpTriggers.testAccountingPeriod.Id);
      //  insert BCR;
        
      //  delete BCR;
     //delete cashReceipt;
    }
    
    
    static testMethod void testJournal_Entry_Line() {
        //Initialize all required objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects(); 
        Test.StartTest();
        
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;
        
        AcctSeed__Journal_Entry__c JE = new AcctSeed__Journal_Entry__c(AcctSeed__Accounting_Period__c=TestAllProjectRollUpTriggers.testAccountingPeriod.Id);
        insert JE;
        
        List<AcctSeed__Journal_Entry_Line__c> jelList = new List<AcctSeed__Journal_Entry_Line__c>();
        jelList.add(new AcctSeed__Journal_Entry_Line__c(AcctSeed__Debit__c = 1 ,AcctSeed__GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Journal_Entry__c = JE.Id, AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Project_Task__c = projectTask.Id));
        jelList.add(new AcctSeed__Journal_Entry_Line__c(AcctSeed__Debit__c = 5 ,AcctSeed__GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Journal_Entry__c = JE.Id, AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Project_Task__c = projectTask.Id));
        
        insert jelList;
        delete jelList[1];
        
        JE.Memo__c = 'test';
        update JE;
        
        ApexPages.StandardController std = new ApexPages.StandardController(JE);
        JournalEntry_RollUpCtlExt ctl = new JournalEntry_RollUpCtlExt(std);
        ctl.executeRollUps();
        ctl.executeAllOutstandingRollUps();
        
        Test.stopTest();
    }
    
  /*  static testMethod void testAccountPayable() {
        
        //Initialize all required objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects(); 
        
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;
        
        //Create a new Billing Line on the Project Task
        AcctSeed__Billing_Line__c billingLine = new AcctSeed__Billing_Line__c(AcctSeed__Billing__c = TestAllProjectRollUpTriggers.testBilling.Id, AcctSeed__Hours_Units__c = 1, AcctSeed__Rate__c = 10.0, AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Project_Task__c = projectTask.Id);
        
        AcctSeed__Billing__c billing = [select Id, Name, AcctSeed__Billing_Format__c from AcctSeed__Billing__c where Id = :TestAllProjectRollUpTriggers.testBilling.Id];
        insert billingLine;
       
        //Create an Account Payable Line on the Project Task
        AcctSeed__Account_Payable_Line__c accountPayableLine = new AcctSeed__Account_Payable_Line__c(AcctSeed__Date__c = date.today(), AcctSeed__Account_Payable__c = TestAllProjectRollUpTriggers.testAccountsPayable.Id, AcctSeed__Amount__c = 100.00, AcctSeed__Expense_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Project_Task__c = projectTask.Id);
        system.debug('look here--> ' +accountPayableLine);
        insert accountPayableLine;
        
        Test.StartTest();
        
        //AcctSeed__Account_Payable__c ap = [select Id, AcctSeed__Payment_Status__c, AcctSeed__Status__c from AcctSeed__Account_Payable__c where Id = :TestAllProjectRollUpTriggers.testAccountsPayable.Id];
        //system.debug('*****testAccountPayable paymentStatus = ' + ap.AcctSeed__Payment_Status__c + ' status = ' + ap.AcctSeed__Status__c);
        
        //TestAllProjectRollUpTriggers.testAccountsPayable.AcctSeed__Payment_Status__c = 'Paid';
        //update TestAllProjectRollUpTriggers.testAccountsPayable;
        
    /*    ApexPages.StandardController std = new ApexPages.StandardController(TestAllProjectRollUpTriggers.testAccountsPayable);
        AccountPayable_RollUpCtlExt ctl = new AccountPayable_RollUpCtlExt(std);
        ctl.executeRollUps();
        ctl.executeAllOutstandingRollUps(); */
        
        //the lines  324 -328 commented on 11/3/2020
        
        /*
        TestAllProjectRollUpTriggers.testAccountsPayable.Do_RollUp__c = true;
        update TestAllProjectRollUpTriggers.testAccountsPayable;
        
        //ctl.executeAllOutstandingRollUps();
        String Query = 'SELECT Id, Do_RollUp__c '
            + 'FROM AcctSeed__Account_Payable__c '
            + 'WHERE Id = \'' + TestAllProjectRollUpTriggers.testAccountsPayable.Id + '\'';
        BatchAccountPayablePosted batch = new BatchAccountPayablePosted(Query); 
        Database.executeBatch(batch, batch.AccountPayablePostedBatchSize);
        */
        
  //      Test.stopTest();
        
  //      delete TestAllProjectRollUpTriggers.testAccountsPayable;
 //   } */
    
    
}