/**
 * Author: Madan
 * Date: Nov 24, 2017
 * Description: To increase code coverage of ConReqGroup Trigger and its Handler class
 */
@isTest//(seealldata=True)
private class TestConReqGroup {

    //public static void setup() {
    //  ASeedAccountingSettingsSetupTest.testDataSetup(); 
   // }



    static testMethod void testConReqGroup() {
        ASeedAccountingSettingsSetupTest.testDataSetup(); 

         //Create Account
            Account testAccount = new Account(Name = 'Test test', Branch__c = 'San Diego', ShippingCity = 'San Francisco');
            insert testAccount;
            
            
            contact testContact = new Contact(
                FirstName = 'John',
                LastName = 'Doe',
                accountId = testAccount.Id
            );
            
            insert testContact;
            
             Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = testAccount .Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = testContact.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), Financing__c = 'Cash', 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert testOpportunity;
        
        
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Account__c = testAccount.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Branch__c = 'San Diego',PC_Code__c = 10, LH_Applications_Eng__c = UserInfo.getUserId());
            insert testProject;
        
                    //Create a new GL Account to use for this test
           AcctSeed__GL_Account__c testGLAccount = new AcctSeed__GL_Account__c(AcctSeed__Type__c = 'Expense', Name = 'Test GL Account');
            insert testGLAccount;
            
            //Create an Accounting Period to use for the test
            AcctSeed__Accounting_Period__c testAccountingPeriod = new AcctSeed__Accounting_Period__c(Name = '2200-01',AcctSeed__Start_Date__c = date.today().addYears(5), AcctSeed__End_Date__c = date.today().addYears(5).addMonths(3), AcctSeed__Status__c = 'Open');
            insert testAccountingPeriod;
            
             Id ledgerId = [SELECT Id From AcctSeed__Ledger__c WHERE AcctSeed__Type__c = 'Transactional' LIMIT 1].Id;
            //Create a new Account Payable to use for this test
             AcctSeed__Account_Payable__c testAccountsPayable = new AcctSeed__Account_Payable__c(AcctSeed__Status__c = 'In Process', AcctSeed__Payee_Reference__c = 'Test Account Payable', AcctSeed__Date__c = date.today(), AcctSeed__Due_Date__c = date.today(), AcctSeed__Contact__c = TestMethods.getContact().Id, AcctSeed__Accounting_Period__c = testAccountingPeriod.Id,AcctSeed__Ledger__c =ledgerId);
            insert testAccountsPayable;
        
            //Create a Product to use for this test
            Product2 testProduct = new Product2(Name = 'Test Trigger Product - DELETEME', AcctSeed__Inventory_Type__c = 'Purchased', AcctSeed__Inventory_Product__c = true, RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Solar Module').getRecordTypeId(), 
                                                                    ProductCode = 'TESTTRIGGER', Description = 'Test Trigger Product - DELETEME', Manufacturer_Account__c = testAccount.Id, Status__c = 'Under Consideration', 
                                                                    AcctSeed__Inventory_GL_Account__c = testGLAccount.Id, AcctSeed__Expense_GL_Account__c = testGLAccount.Id, AcctSeed__Revenue_GL_Account__c = testGLAccount.Id, AcctSeed__Unit_Cost__c = 10.00);
            insert testProduct;
              //Create a Sales Order to use on the Sales Order Line
           
            AcctSeedERP__Sales_Order__c testSalesOrder = new AcctSeedERP__Sales_Order__c(AcctSeedERP__Customer__c = testAccount.Id, AcctSeedERP__Status__c = 'Open', Project__c = testProject.Id,AcctSeedERP__Ledger__c = ledgerId);
            insert testSalesOrder;

        //Initialize all required objects base objects
       // try {
        //    TestAllProjectRollUpTriggers.initalizeBaseObjects();
      //  } catch(Exception ex){}
        
        Project_Products__c pp = new Project_Products__c(
            Project__c = testProject.Id, //TestAllProjectRollUpTriggers.testProject.Id,
            Product__c = testProduct.Id //TestAllProjectRollUpTriggers.testProduct.Id
        
        );
        insert pp;

        Test.StartTest();
               
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = testProject.Id, AcctSeed__Labor_GL_Account__c = testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;       
        
        //Create a Sales Order Line to use on the Project Task
        AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(
                                Unit_Cost__c= 1, 
                                AcctSeedERP__Product__c = testProduct.Id, //TestAllProjectRollUpTriggers.testProduct.Id, 
                                Opportunity_Product__c = testProduct.Id, //TestAllProjectRollUpTriggers.testProduct.Id, 
                                AcctSeedERP__Sales_Order__c = testSalesOrder.Id, //TestAllProjectRollUpTriggers.testSalesOrder.Id, 
                                AcctSeedERP__Quantity_Ordered__c = 1, 
                                AcctSeedERP__Project_Task__c = projectTask.Id, 
                                AcctSeedERP__Project__c = testProject.Id);  //TestAllProjectRollUpTriggers.testProject.Id);
        insert salesOrderLine;
        
        //Create a Sales Order to use on the Sales Order Line
        AcctSeedERP__Sales_Order__c so = new AcctSeedERP__Sales_Order__c(AcctSeedERP__Customer__c = testAccount.Id, AcctSeedERP__Status__c = 'Open', Project__c = testProject.Id,AcctSeedERP__Ledger__c = ledgerId);
        insert so;
        
        // Create the Con Req Group object
        Id serviceRTId = Schema.SObjectType.Con_Req_Group__c.getRecordTypeInfosByName().get('Service Visit').getRecordTypeId();
        Con_Req_Group__c conReqGroup = new Con_Req_Group__c(
            Project__c =testProject.Id, //TestAllProjectRollUpTriggers.testProject.Id,
            Sales_Order__c = testSalesOrder.Id, //TestAllProjectRollUpTriggers.testSalesOrder.Id,
            RecordTypeId = serviceRTId,
            Use_Project_Ship_To__c=true
        );
        insert conReqGroup;
        
        system.debug('conReqgroup look here-' +conReqGroup.id);
        
        
        
        List<sObject> sourceList = [SELECT Id 
            FROM Site__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Site__c()
            );
        }
        Database.upsert(sourceList);
         system.debug('Source List -' +sourceList);
        
        Id sourceshipto=sourceList[0].id;
        
        AcctSeedERP__Sales_Order_Line__c salesOrderLine2 = new AcctSeedERP__Sales_Order_Line__c(
                                                                Unit_Cost__c= 1,
                                                                AcctSeedERP__Product__c =testProduct.Id, 
                                                                AcctSeedERP__Sales_Order__c = testSalesOrder.Id, 
                                                                AcctSeedERP__Quantity_Ordered__c = 1, 
                                                                AcctSeedERP__Project_Task__c = projectTask.Id, 
                                                                AcctSeedERP__Project__c = testProject.Id,
                                                                Con_Req_Group__c=conReqGroup.Id);
        insert salesOrderLine2;
        
      //   ASeedAccountingSettingsSetupTest.testDataSetup(); 
        
        // Create Setting Record
        // -----------------------------------------------------------
        AcctSeed__GL_Account__c glaccount = new AcctSeed__GL_Account__c();
        glaccount.name = 'Test';
        glaccount.BalSheet_Type__c = '28 Income Statement';
        glaccount.IncStmt_Type__c = '01Revenue, Net';
        glaccount.AcctSeed__Type__c = 'Expense';
        glaccount.AcctSeed__Bank__c = True;
        //insert glaccount;
        
        //Creating data for AcctSeed__Accounting_Period__c
        AcctSeed__Accounting_Period__c accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().addMonths(1).year() + '-' + System.now().addMonths(1).format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today().addMonths(1);
        accperiod.AcctSeed__End_Date__c = Date.today().addMonths(1)+2;
        accperiod.AcctSeed__Status__c = 'Open';
        //insert accperiod;
        
        accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().addMonths(2).year() + '-' + System.now().addMonths(2).format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today().addMonths(2);
        accperiod.AcctSeed__End_Date__c = Date.today().addMonths(2) + 2;
        accperiod.AcctSeed__Status__c = 'Open';
        //insert accperiod;
        
        accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().year() + '-' + System.now().format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today();
        accperiod.AcctSeed__End_Date__c = Date.today()+2;
        accperiod.AcctSeed__Status__c = 'Open';
        //insert accperiod;
        
        Tax_Group__c taxgroup = new Tax_Group__c();
        taxgroup.name = 'Test';
        //insert taxgroup;
        
        AcctSeed__Ledger__c ledg = new AcctSeed__Ledger__c();
        ledg.Name = 'test';
        ledg.AcctSeed__Type__c = 'Transactional';
        //insert ledg;
        
        
        //create a Account record
        Account acc = new Account();
        acc.Name= 'Joseph and Tabitha Terry';
        acc.Branch__c= 'Mid Atlantic';
        acc.Phone= '1231231230';
        acc.Type= 'Customers';
        acc.Industry= 'Affordable Housing';
        acc.Job_Type__c= 'Private';
        acc.Description= 'Land in Whitehall, NGrid F';
       // insert acc;
        
        AcctSeed__Billing_Format__c billpdf = new AcctSeed__Billing_Format__c();
        billpdf.Name = 'test pdf';
        billpdf.AcctSeed__Default_Email_Template__c = ' Billing_Approved ';
        billpdf.AcctSeed__Visualforce_PDF_Page__c = 'ProjectBillingPDF';
        billpdf.AcctSeed__Type__c = 'Purchase Order';
      //  insert billpdf;
        
        AcctSeed__Accounting_Settings__c accsetting = new AcctSeed__Accounting_Settings__c();
      //  accsetting.AcctSeed__Default_Ledger__c = ledg.Id;
      //  accsetting.AcctSeed__Default_Bank_Account__c =  glaccount.Id;
      //  accsetting.AcctSeed__AR_Control_GL_Account__c = 'a1m80000000p2kt';
      //  accsetting.AcctSeed__Default_Billing_Format__c = billpdf.Id;
      //  accsetting.AcctSeed__Current_Year_Earnings_GL_Account__c = glaccount.Id;
      //  accsetting.AcctSeed__Retained_Earnings_GL_Account__c = glaccount.Id;
      //  accsetting.AcctSeed__Revenue_GL_Account__c = glaccount.Id;
      //  accsetting.AcctSeed__Unapplied_Cash_GL_Account__c = glaccount.Id;
      //  accsetting.AcctSeed__AP_Control_GL_Account__c = glaccount.Id;
      //  accsetting.AcctSeed__Billing_Activity_Statement_Format__c = billpdf.Id;
      //  accsetting.AcctSeed__Billing_Outstanding_Statement_Format__c = billpdf.Id;
      //  accsetting.AcctSeed__Labor_GL_Account__c = glaccount.Id;
      // accsetting.AcctSeed__Default_Purchase_Order_Format__c = billpdf.Id;
      //  insert accsetting;
        /*
        AcctSeedERP__Sales_Order_Line__c salesOrderLine = new AcctSeedERP__Sales_Order_Line__c(
                                                        Unit_Cost__c= 1,
                                                        AcctSeedERP__Product__c = TestAllProjectRollUpTriggers.testProduct.Id, 
                                                        AcctSeedERP__Sales_Order__c = TestAllProjectRollUpTriggers.testSalesOrder.Id, 
                                                        AcctSeedERP__Quantity_Ordered__c = 1, 
                                                        AcctSeedERP__Project_Task__c = projectTask.Id, 
                                                        AcctSeedERP__Project__c = TestAllProjectRollUpTriggers.testProject.Id);
        insert salesOrderLine;
        */
        // -----------------------------------------------------------
        // End of Creation of Setting Record
        
        //id conreqgroupid='a3Q34000002LdRM';
        
      //  conReqGroup.Ship_To_Site__c ='a69340000007wdS';//sourceList[0].Id
        conReqGroup.Project_PM__c = UserInfo.getUserId();
        conReqGroup.Status__c = 'Pending Approval';
        update conReqGroup;
        system.debug('Con Req Group -' +conReqGroup);
        
        // Sales order lookup vaildation test
        try {
            conReqGroup.Sales_Order__c = so.Id;
            update conReqGroup;
        } catch(Exception ex) {}
        
        delete conReqGroup;
        
         Test.StopTest();
        
    }
}