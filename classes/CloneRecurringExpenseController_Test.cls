@isTest // (seealldata=true)
public class CloneRecurringExpenseController_Test {

    @testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    } 
    
    
    public static testmethod void populateFieldsTest(){
       
        AcctSeed__GL_Account__c glaccount = new AcctSeed__GL_Account__c();
        glaccount.name = 'Test';
        glaccount.BalSheet_Type__c = '28 Income Statement';
        glaccount.IncStmt_Type__c = '01Revenue, Net';
        glaccount.AcctSeed__Type__c = 'Expense';
        glaccount.AcctSeed__Bank__c = True;
        insert glaccount;
        
        //Added to map GL Account in AvaTax profile
        AcctSeed__GL_Account__c accGLAccount = new AcctSeed__GL_Account__c(Name='STGL', AcctSeed__Type__c='Balance Sheet', AcctSeed__Sub_Type_1__c='Liabilities', AcctSeed__Sub_Type_2__c='Current Liabilities');
        insert accGLAccount;

        //Below code will create AvaTax profile in test class
        AvaAcctSeed__CBAvaTaxSetting__c cfg = new AvaAcctSeed__CBAvaTaxSetting__c(Name='Demo', AvaAcctSeed__ST_ProductCode__c='AvaTaxProductCode',
            AvaAcctSeed__Active_AvaTax_Setting__c=true,AvaAcctSeed__CompanyCode__c='Default',AvaAcctSeed__Tax_Schedule__c = 'AvaTaxPOS', AvaAcctSeed__Origin_Address__c='900 winslow way e',
            AvaAcctSeed__Origin_City__c='BI',AvaAcctSeed__Origin_Region__c='WA', AvaAcctSeed__Origin_Postal_Code__c='98110',AvaAcctSeed__Enable_Entity_Use_Code__c = true,
            AvaAcctSeed__ServiceURL__c='https://avatax.avalara.net' , AvaAcctSeed__UserName__c='testUserName',AvaAcctSeed__Customer_Code_Field__c = 'Account Number',
            AvaAcctSeed__Password__c='TestPassword',AvaAcctSeed__GL_Account__c=accGLAccount.Id, AvaAcctSeed__Verify_Validations__c=false, AvaAcctSeed__Enable_Tax_Calculation__c=true, AvaAcctSeed__Enable_Address_Validation__c=true);
        
        insert cfg;

        //Creating data for AcctSeed__Accounting_Period__c
        AcctSeed__Accounting_Period__c accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().addMonths(1).year() + '-' + System.now().addMonths(1).format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today().addMonths(1);
        accperiod.AcctSeed__End_Date__c = Date.today().addMonths(1)+2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;
        
        accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().addMonths(2).year() + '-' + System.now().addMonths(2).format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today().addMonths(2);
        accperiod.AcctSeed__End_Date__c = Date.today().addMonths(2) + 2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;
        
        accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().year() + '-' + System.now().format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today();
        accperiod.AcctSeed__End_Date__c = Date.today()+2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;
        
        Tax_Group__c taxgroup = new Tax_Group__c();
        taxgroup.name = 'Test';
        insert taxgroup;
        
        AcctSeed__Ledger__c ledg = new AcctSeed__Ledger__c();
        ledg.Name = 'test';
        ledg.AcctSeed__Type__c = 'Transactional';
        ledg.AcctSeed__Billing_Activity_Statement_Format__c='a1U34000003y3Ql';
        ledg.AcctSeed__Billing_Outstanding_Statement_Format__c='a1U80000000COOs';
        ledg.AcctSeed__Default_Bank_Account__c= 'a1m80000000p2ic';
        ledg.AcctSeed__Default_Billing_Format__c='a1U80000000AbRO';
        ledg.AcctSeed__Default_Purchase_Order_Format__c='a1U80000000COQ8';
        ledg.AcctSeed__Default_Packing_Slip_Format__c='a1U34000004Abf2';
      //  insert ledg;
        
        
        //create a Account record
        Account acc = new Account();
        acc.Name= 'Joseph and Tabitha Terry';
        acc.Branch__c= 'Mid Atlantic';
        acc.Phone= '1231231230';
        acc.Type= 'Customers';
        acc.Industry= 'Affordable Housing';
        acc.Job_Type__c= 'Private';
        acc.Description= 'Land in Whitehall, NGrid F';
        insert acc;
        
        AcctSeed__Billing_Format__c billpdf = new AcctSeed__Billing_Format__c();
        billpdf.Name = 'test pdf';
        billpdf.AcctSeed__Default_Email_Template__c = '  Billing_Approved ';
        billpdf.AcctSeed__Visualforce_PDF_Page__c = 'ProjectBillingPDF';
        insert billpdf;
        
        AcctSeed__Accounting_Settings__c accsetting = new AcctSeed__Accounting_Settings__c();
        accsetting.AcctSeed__Default_Ledger__c = ledg.Id;
        accsetting.AcctSeed__Default_Bank_Account__c =  glaccount.Id;
        accsetting.AcctSeed__AR_Control_GL_Account__c = 'a1m80000000p2kt';
        accsetting.AcctSeed__Default_Billing_Format__c = billpdf.Id;
        accsetting.AcctSeed__Current_Year_Earnings_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Retained_Earnings_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Revenue_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Unapplied_Cash_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__AP_Control_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Billing_Activity_Statement_Format__c = billpdf.Id;
        accsetting.AcctSeed__Billing_Outstanding_Statement_Format__c = billpdf.Id;
        accsetting.AcctSeed__Labor_GL_Account__c = 'a1m80000000p2kt';
      //  insert accsetting;
        
        //Opportunity dummy data
        Opportunity opp = new Opportunity();
        opp.name = 'Test Opportunity';
        opp.accountId = acc.Id;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today()+2;
        opp.Opportunity_Lead_Source__c = 'Affiliate';
        opp.Opportunity_Lead_Source_Specifics__c = 'test';
        opp.accountId = acc.Id;
        insert opp;
        
        
        //Project Dummy Data
        AcctSeed__Project__c projectDummy = new AcctSeed__Project__c();
        projectDummy.Intx_Apps__c = 'test';
        projectDummy.Branch__c = 'San Diego';
        projectDummy.AcctSeed__Opportunity__c = opp.Id;
       // projectDummy.Default_Expense_GL_Account__c='a1m80000000p2kt';
        insert projectDummy; 
        user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];
        //Contract Dummy Data
        Contract contr = new Contract();
        contr.AccountId = acc.Id;
        contr.ASProject__c = projectDummy.Id;
        contr.AccountId = acc.Id;
        contr.Description = 'test description';
        contr.Contract_Status__c = 'Active';
        contr.Branch__c ='New England';
        contr.O_M_Package__c = 'Basic';
        contr.Does_Contract_Auto_Renew__c = 'Yes'; 
        contr.StartDate = Date.today();
        contr.ContractTerm = 2;
        contr.EndDate = Date.today()+2 ;
        contr.Contract_Amount__c = 1000;
        contr.status = 'NullVoid';
        contr.Area_Supervisor__c =userid.id;
        contr.Regional_Manager_User__c = userid.id;
        insert contr;
        
        
        AcctSeed__Billing__c bill = new AcctSeed__Billing__c();
        bill.Tax_Group__c = taxgroup.Id;
        bill.AcctSeed__Customer__c = acc.Id;
        bill.AcctSeed__Date__c =  Date.newInstance(2017 , 10 ,20);
        bill.AcctSeed__Accounting_Period__c = accperiod.Id;
        bill.Service_Contract__c = contr.id;
        bill.AcctSeed__Billing_Format__c = billpdf.Id;
        bill.AcctSeed__Ledger__c = ledg.Id;
        insert bill;
        
        // create AcctSeed__Accounting_Variable__c record
        AcctSeed__Accounting_Variable__c accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='Nor Cal';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        insert accvar;
        
        AcctSeed__Accounting_Variable__c accvar2 = new AcctSeed__Accounting_Variable__c();
        accvar2.Name='O&M';
        accvar2.AcctSeed__Type__c='GL Account Variable 2';
        accvar2.AcctSeed__Active__c=true;
        insert accvar2;
        
        AcctSeed__Accounting_Variable__c accvar3 = new AcctSeed__Accounting_Variable__c();
        accvar3.Name='O&M';
        accvar3.AcctSeed__Type__c='GL Account Variable 3';
        accvar3.AcctSeed__Active__c=true;
        insert accvar3;
        
        Cost_Code__c costcode = new Cost_Code__c();
        costcode.name = 'Test';
        costcode.Number__c = '01-1530';
        costcode.Category__c = 'P';
        insert costcode;
        
        AcctSeed__Project_Task__c projecttask = new AcctSeed__Project_Task__c();
        projecttask.Cost_Code__c = costcode.Id;
        projecttask.Name = 'test project task';
        projecttask.AcctSeed__Labor_GL_Account__c = glaccount.Id;
        projecttask.AcctSeed__GL_Account_Variable_1__c = accvar.Id;
        projecttask.AcctSeed__Project__c = projectDummy.Id;
        projecttask.AcctSeed__GL_Account_Variable_2__c = accvar2.Id;
        projecttask.AcctSeed__GL_Account_Variable_3__c = accvar3.Id;
       // projecttask.AcctSeed__GL_Account_Variable_4__c = glaccount.Id;
        insert projecttask;
        
        List<AcctSeed__Scheduled_Revenue_Expense__c> listschrevexp = new List<AcctSeed__Scheduled_Revenue_Expense__c>();
        AcctSeed__Scheduled_Revenue_Expense__c schrevexp = new AcctSeed__Scheduled_Revenue_Expense__c();
        schrevexp.Name = 'Scheduled Revenue Expense test';
        schrevexp.AcctSeed__Amount__c = 1000;
        schrevexp.AcctSeed__Credit_GL_Account__c = glaccount.Id;
        schrevexp.AcctSeed__Debit_GL_Account__c = glaccount.Id;
        schrevexp.AcctSeed__Accounting_Period__c = accperiod.Id;
        schrevexp.AcctSeed__Project__c = Null ;
        schrevexp.AcctSeed__Billing__c = bill.Id;
        schrevexp.AcctSeed__Project_Task__c = projecttask.id;
        schrevexp.Number_of_Periods__c = 2;
        schrevexp.Prorate_Start_Day__c = 5;
        try{
            insert schrevexp;
          listschrevexp.add(schrevexp);
        }
        catch(Exception e){
            //System.Assert(e.getMessage().contains('This Scheduled Revenue Expense record has been set up to create Scheduled Revenue Expense records for Accounting periods which do not exist or have a status = closed. Please setup the future Accounting Periods needed for the number of recurring Scheduled Revenue Expenses'));
        }
        CloneRevExpActions crea = new CloneRevExpActions();
        CloneRevExpActions.setProrateAmount(listschrevexp);  
        CloneRevExpActions.cloneScheduledRevenueExpense(listschrevexp);
    }
    
    public static testmethod void populateFieldsTest1(){
       
        AcctSeed__GL_Account__c glaccount = new AcctSeed__GL_Account__c();
    glaccount.name = 'Test';
        glaccount.BalSheet_Type__c = '28 Income Statement';
        glaccount.IncStmt_Type__c = '01Revenue, Net';
        glaccount.AcctSeed__Type__c = 'Expense';
        glaccount.AcctSeed__Bank__c = True;
    insert glaccount;
        
        //Added to map GL Account in AvaTax profile
        AcctSeed__GL_Account__c accGLAccount = new AcctSeed__GL_Account__c(Name='STGL', AcctSeed__Type__c='Balance Sheet', AcctSeed__Sub_Type_1__c='Liabilities', AcctSeed__Sub_Type_2__c='Current Liabilities');
        insert accGLAccount;
        
        //Below code will create AvaTax profile in test class
        AvaAcctSeed__CBAvaTaxSetting__c cfg = new AvaAcctSeed__CBAvaTaxSetting__c(Name='Demo', AvaAcctSeed__ST_ProductCode__c='AvaTaxProductCode',
            AvaAcctSeed__Active_AvaTax_Setting__c=true,AvaAcctSeed__CompanyCode__c='Default',AvaAcctSeed__Tax_Schedule__c = 'AvaTaxPOS', AvaAcctSeed__Origin_Address__c='900 winslow way e',
            AvaAcctSeed__Origin_City__c='BI',AvaAcctSeed__Origin_Region__c='WA', AvaAcctSeed__Origin_Postal_Code__c='98110',AvaAcctSeed__Enable_Entity_Use_Code__c = true,
            AvaAcctSeed__ServiceURL__c='https://avatax.avalara.net' , AvaAcctSeed__UserName__c='testUserName',AvaAcctSeed__Customer_Code_Field__c = 'Account Number',
            AvaAcctSeed__Password__c='TestPassword',AvaAcctSeed__GL_Account__c=accGLAccount.Id, AvaAcctSeed__Verify_Validations__c=false, AvaAcctSeed__Enable_Tax_Calculation__c=true, AvaAcctSeed__Enable_Address_Validation__c=true);
        
        insert cfg;
        
        //Creating data for AcctSeed__Accounting_Period__c
        AcctSeed__Accounting_Period__c accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().addMonths(1).year() + '-' + System.now().addMonths(1).format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today().addMonths(1);
        accperiod.AcctSeed__End_Date__c = Date.today().addMonths(1)+2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;
        
        /*accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().addMonths(2).year() + '-' + System.now().addMonths(2).format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today().addMonths(2);
        accperiod.AcctSeed__End_Date__c = Date.today().addMonths(2) + 2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;*/
        
        accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().year() + '-' + System.now().format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today();
        accperiod.AcctSeed__End_Date__c = Date.today()+2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;
        
        Tax_Group__c taxgroup = new Tax_Group__c();
        taxgroup.name = 'Test';
        insert taxgroup;
        
        AcctSeed__Ledger__c ledg = new AcctSeed__Ledger__c();
        ledg.Name = 'MainCompany'; // 'test';
        ledg.AcctSeed__Type__c = 'Transactional';
        ledg.AcctSeed__Billing_Activity_Statement_Format__c='a1U34000003y3Ql';
        ledg.AcctSeed__Billing_Outstanding_Statement_Format__c='a1U80000000COOs';
        ledg.AcctSeed__Default_Bank_Account__c= 'a1m80000000p2ic';
        ledg.AcctSeed__Default_Billing_Format__c='a1U80000000AbRO';
        ledg.AcctSeed__Default_Purchase_Order_Format__c='a1U80000000COQ8';
        ledg.AcctSeed__Default_Packing_Slip_Format__c='a1U34000004Abf2';
     //   insert ledg;
        
        
        //create a Account record
        Account acc = new Account();
        acc.Name= 'Joseph and Tabitha Terry';
        acc.Branch__c= 'Mid Atlantic';
        acc.Phone= '1231231230';
        acc.Type= 'Customers';
        acc.Industry= 'Affordable Housing';
        acc.Job_Type__c= 'Private';
        acc.Description= 'Land in Whitehall, NGrid F';
        insert acc;
        
        AcctSeed__Billing_Format__c billpdf = new AcctSeed__Billing_Format__c();
        billpdf.Name = 'test pdf';
        billpdf.AcctSeed__Default_Email_Template__c = '  Billing_Approved ';
        billpdf.AcctSeed__Visualforce_PDF_Page__c = 'ProjectBillingPDF';
        insert billpdf;
        
        AcctSeed__Accounting_Settings__c accsetting = new AcctSeed__Accounting_Settings__c();
        accsetting.AcctSeed__Default_Ledger__c = ledg.Id;
        accsetting.AcctSeed__Default_Bank_Account__c =  glaccount.Id;
        accsetting.AcctSeed__AR_Control_GL_Account__c = 'a1m80000000p2kt';
        accsetting.AcctSeed__Default_Billing_Format__c = billpdf.Id;
        accsetting.AcctSeed__Current_Year_Earnings_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Retained_Earnings_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Revenue_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Unapplied_Cash_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__AP_Control_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Billing_Activity_Statement_Format__c = billpdf.Id;
        accsetting.AcctSeed__Billing_Outstanding_Statement_Format__c = billpdf.Id;
        accsetting.AcctSeed__Labor_GL_Account__c = glaccount.Id;
       // insert accsetting;
        
        //Opportunity dummy data
        Opportunity opp = new Opportunity();
        opp.name = 'Test Opportunity';
        opp.accountId = acc.Id;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today()+2;
        opp.Opportunity_Lead_Source__c = 'Affiliate';
        opp.Opportunity_Lead_Source_Specifics__c = 'test';
        opp.accountId = acc.Id;
        insert opp;
        
        
        //Project Dummy Data
        AcctSeed__Project__c projectDummy = new AcctSeed__Project__c();
        projectDummy.Intx_Apps__c = 'test';
        projectDummy.Branch__c = 'San Diego';
        projectDummy.AcctSeed__Opportunity__c = opp.Id;
      //  projectDummy.Default_Expense_GL_Account__c=glaccount.Id;
        insert projectDummy; 
        user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];
        //Contract Dummy Data
        Contract contr = new Contract();
        contr.AccountId = acc.Id;
        contr.ASProject__c = projectDummy.Id;
        contr.AccountId = acc.Id;
        contr.Description = 'test description';
        contr.Contract_Status__c = 'Active';
        contr.Branch__c ='New England';
        contr.O_M_Package__c = 'Basic';
        contr.Does_Contract_Auto_Renew__c = 'Yes'; 
        contr.StartDate = Date.today();
        contr.ContractTerm = 2;
        contr.EndDate = Date.today()+2 ;
        contr.Contract_Amount__c = 1000;
        contr.status = 'NullVoid';
         contr.Area_Supervisor__c =userid.id;
        contr.Regional_Manager_User__c = userid.id;
        insert contr;
        
        
        AcctSeed__Billing__c bill = new AcctSeed__Billing__c();
        bill.Tax_Group__c = taxgroup.Id;
        bill.AcctSeed__Customer__c = acc.Id;
        bill.AcctSeed__Date__c =  Date.newInstance(2017 , 10 ,20);
        bill.AcctSeed__Accounting_Period__c = accperiod.Id;
        bill.Service_Contract__c = contr.id;
        bill.AcctSeed__Billing_Format__c = billpdf.Id;
        bill.AcctSeed__Ledger__c = ledg.Id;
        insert bill;
        
        // create AcctSeed__Accounting_Variable__c record
        AcctSeed__Accounting_Variable__c accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='Nor Cal';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        insert accvar;
        
        AcctSeed__Accounting_Variable__c accvar2 = new AcctSeed__Accounting_Variable__c();
        accvar2.Name='O&M';
        accvar2.AcctSeed__Type__c='GL Account Variable 2';
        accvar2.AcctSeed__Active__c=true;
        insert accvar2;
        
        AcctSeed__Accounting_Variable__c accvar3 = new AcctSeed__Accounting_Variable__c();
        accvar3.Name='O&M';
        accvar3.AcctSeed__Type__c='GL Account Variable 3';
        accvar3.AcctSeed__Active__c=true;
        insert accvar3;
        
        Cost_Code__c costcode = new Cost_Code__c();
        costcode.name = 'Test';
        costcode.Number__c = '01-1530';
        costcode.Category__c = 'P';
        insert costcode;
        
        AcctSeed__Project_Task__c projecttask = new AcctSeed__Project_Task__c();
        projecttask.Cost_Code__c = costcode.Id;
        projecttask.Name = 'test project task';
        projecttask.AcctSeed__Labor_GL_Account__c = glaccount.Id;
        projecttask.AcctSeed__GL_Account_Variable_1__c = accvar.Id;
        projecttask.AcctSeed__Project__c = projectDummy.Id;
        projecttask.AcctSeed__GL_Account_Variable_2__c = accvar2.Id;
        projecttask.AcctSeed__GL_Account_Variable_3__c = accvar3.Id;
       // projecttask.AcctSeed__GL_Account_Variable_4__c = glaccount.Id;
        insert projecttask;
        
        List<AcctSeed__Scheduled_Revenue_Expense__c> listschrevexp = new List<AcctSeed__Scheduled_Revenue_Expense__c>();
        AcctSeed__Scheduled_Revenue_Expense__c schrevexp = new AcctSeed__Scheduled_Revenue_Expense__c();
        schrevexp.Name = 'Scheduled Revenue Expense test';
        schrevexp.AcctSeed__Amount__c = 1000;
        schrevexp.AcctSeed__Credit_GL_Account__c = glaccount.Id;
        schrevexp.AcctSeed__Debit_GL_Account__c = glaccount.Id;
        schrevexp.AcctSeed__Accounting_Period__c = accperiod.Id;
        schrevexp.AcctSeed__Project__c = Null ;
        schrevexp.AcctSeed__Billing__c = bill.Id;
        schrevexp.AcctSeed__Project_Task__c = projecttask.id;
        schrevexp.Number_of_Periods__c = 2;
        schrevexp.Prorate_Start_Day__c = 5;
        try{
            insert schrevexp;
          listschrevexp.add(schrevexp);
        }
        catch(Exception e){
            System.Assert(e.getMessage().contains('This Scheduled Revenue Expense record has been set up to create Scheduled Revenue Expense records for Accounting periods which do not exist or have a status = closed. Please setup the future Accounting Periods needed for the number of recurring Scheduled Revenue Expenses'));
        }
        CloneRevExpActions crea = new CloneRevExpActions();
        CloneRevExpActions.setProrateAmount(listschrevexp);  
    }
    
    /*public static testmethod void populateFieldsTest3(){
       
        AcctSeed__GL_Account__c glaccount = new AcctSeed__GL_Account__c();
    glaccount.name = 'Test';
        glaccount.BalSheet_Type__c = '28 Income Statement';
        glaccount.IncStmt_Type__c = '01Revenue, Net';
        glaccount.AcctSeed__Type__c = 'Expense';
        glaccount.AcctSeed__Bank__c = True;
    insert glaccount;
        
        //Creating data for AcctSeed__Accounting_Period__c
        AcctSeed__Accounting_Period__c accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().addMonths(1).year() + '-' + System.now().addMonths(1).format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today().addMonths(1);
        accperiod.AcctSeed__End_Date__c = Date.today().addMonths(1)+2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;
        
        accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().addMonths(2).year() + '-' + System.now().addMonths(2).format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today().addMonths(2);
        accperiod.AcctSeed__End_Date__c = Date.today().addMonths(2) + 2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;
        
        accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = System.now().year() + '-' + System.now().format('MM');
        accperiod.AcctSeed__Start_Date__c = Date.today();
        accperiod.AcctSeed__End_Date__c = Date.today()+2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;
        
        Tax_Group__c taxgroup = new Tax_Group__c();
        taxgroup.name = 'Test';
        insert taxgroup;
        
        AcctSeed__Ledger__c ledg = new AcctSeed__Ledger__c();
        ledg.Name = 'test';
        ledg.AcctSeed__Type__c = 'Transactional';
        insert ledg;
        
        
        //create a Account record
        Account acc = new Account();
        acc.Name= 'Joseph and Tabitha Terry';
        acc.Branch__c= 'Mid Atlantic';
        acc.Phone= '1231231230';
        acc.Type= 'Customers';
        acc.Industry= 'Affordable Housing';
        acc.Job_Type__c= 'Private';
        acc.Description= 'Land in Whitehall, NGrid F';
        insert acc;
        
        AcctSeed__Billing_Format__c billpdf = new AcctSeed__Billing_Format__c();
        billpdf.Name = 'test pdf';
        billpdf.AcctSeed__Default_Email_Template__c = '  Billing_Approved ';
        billpdf.AcctSeed__Visualforce_PDF_Page__c = 'ProjectBillingPDF';
        insert billpdf;
        
        AcctSeed__Accounting_Settings__c accsetting = new AcctSeed__Accounting_Settings__c();
        accsetting.AcctSeed__Default_Ledger__c = ledg.Id;
        accsetting.AcctSeed__Default_Bank_Account__c =  glaccount.Id;
        accsetting.AcctSeed__AR_Control_GL_Account__c = 'a1m80000000p2kt';
        accsetting.AcctSeed__Default_Billing_Format__c = billpdf.Id;
        accsetting.AcctSeed__Current_Year_Earnings_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Retained_Earnings_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Revenue_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Unapplied_Cash_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__AP_Control_GL_Account__c = glaccount.Id;
        accsetting.AcctSeed__Billing_Activity_Statement_Format__c = billpdf.Id;
        accsetting.AcctSeed__Billing_Outstanding_Statement_Format__c = billpdf.Id;
        accsetting.AcctSeed__Labor_GL_Account__c = glaccount.Id;
        insert accsetting;
        
        //Opportunity dummy data
        Opportunity opp = new Opportunity();
        opp.name = 'Test Opportunity';
        opp.accountId = acc.Id;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today()+2;
        opp.Opportunity_Lead_Source__c = 'Affiliate';
        opp.Opportunity_Lead_Source_Specifics__c = 'test';
        opp.accountId = acc.Id;
        insert opp;
        
        
        //Project Dummy Data
        AcctSeed__Project__c projectDummy = new AcctSeed__Project__c();
        projectDummy.Intx_Apps__c = 'test';
        projectDummy.Branch__c = 'San Diego';
        projectDummy.AcctSeed__Opportunity__c = opp.Id;
        insert projectDummy; 
        
        //Contract Dummy Data
        Contract contr = new Contract();
        contr.AccountId = acc.Id;
        contr.ASProject__c = projectDummy.Id;
        contr.AccountId = acc.Id;
        contr.Description = 'test description';
        contr.Contract_Status__c = 'Active';
        contr.Branch__c ='New England';
        contr.O_M_Package__c = 'Basic';
        contr.Does_Contract_Auto_Renew__c = 'Yes'; 
        contr.StartDate = Date.today();
        contr.ContractTerm = 2;
        contr.EndDate = Date.today()+2 ;
        contr.Contract_Amount__c = 1000;
        contr.status = 'NullVoid';
        insert contr;
        
        
        AcctSeed__Billing__c bill = new AcctSeed__Billing__c();
        bill.Tax_Group__c = taxgroup.Id;
        bill.AcctSeed__Customer__c = acc.Id;
        bill.AcctSeed__Date__c =  Date.newInstance(2017 , 10 ,20);
        bill.AcctSeed__Accounting_Period__c = accperiod.Id;
        bill.Service_Contract__c = contr.id;
        insert bill;
        
        // create AcctSeed__Accounting_Variable__c record
        AcctSeed__Accounting_Variable__c accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='Nor Cal';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        insert accvar;
        
        AcctSeed__Accounting_Variable__c accvar2 = new AcctSeed__Accounting_Variable__c();
        accvar2.Name='O&M';
        accvar2.AcctSeed__Type__c='GL Account Variable 2';
        accvar2.AcctSeed__Active__c=true;
        insert accvar2;
        
        AcctSeed__Accounting_Variable__c accvar3 = new AcctSeed__Accounting_Variable__c();
        accvar3.Name='O&M';
        accvar3.AcctSeed__Type__c='GL Account Variable 3';
        accvar3.AcctSeed__Active__c=true;
        insert accvar3;
        
        Cost_Code__c costcode = new Cost_Code__c();
        costcode.name = 'Test';
        costcode.Number__c = '01-1530';
        costcode.Category__c = 'P';
        insert costcode;
        
        AcctSeed__Project_Task__c projecttask = new AcctSeed__Project_Task__c();
        projecttask.Cost_Code__c = costcode.Id;
        projecttask.Name = 'test project task';
        projecttask.AcctSeed__Labor_GL_Account__c = glaccount.Id;
        projecttask.AcctSeed__GL_Account_Variable_1__c = accvar.Id;
        projecttask.AcctSeed__Project__c = projectDummy.Id;
        projecttask.AcctSeed__GL_Account_Variable_2__c = accvar2.Id;
        projecttask.AcctSeed__GL_Account_Variable_3__c = accvar3.Id;
       // projecttask.AcctSeed__GL_Account_Variable_4__c = glaccount.Id;
        insert projecttask;
        
        List<AcctSeed__Scheduled_Revenue_Expense__c> listschrevexp = new List<AcctSeed__Scheduled_Revenue_Expense__c>();
        AcctSeed__Scheduled_Revenue_Expense__c schrevexp = new AcctSeed__Scheduled_Revenue_Expense__c();
        schrevexp.Name = 'Scheduled Revenue Expense test';
        schrevexp.AcctSeed__Amount__c = 10;
        schrevexp.AcctSeed__Credit_GL_Account__c = glaccount.Id;
        schrevexp.AcctSeed__Debit_GL_Account__c = glaccount.Id;
        schrevexp.AcctSeed__Accounting_Period__c = accperiod.Id;
        schrevexp.AcctSeed__Project__c = Null ;
        schrevexp.AcctSeed__Billing__c = bill.Id;
        schrevexp.AcctSeed__Project_Task__c = projecttask.id;
        schrevexp.Number_of_Periods__c = 2;
        schrevexp.Prorate_Start_Day__c = 5;
        insert schrevexp;
         listschrevexp.add(schrevexp);
        CloneRevExpActions crea = new CloneRevExpActions();
        CloneRevExpActions.cloneScheduledRevenueExpense(listschrevexp);
        CloneRevExpActions.cloneScheduledRevenueExpense(
                              new List<AcctSeed__Scheduled_Revenue_Expense__c>{
                                                    new AcctSeed__Scheduled_Revenue_Expense__c(Number_of_Periods__c=2)
                                                });
    }*/
}