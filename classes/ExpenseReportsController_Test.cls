@isTest
public class ExpenseReportsController_Test {

    
    @testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    }
    
    public static testmethod void  ExpenseReportsTest(){
    
        
         
        //create a user record
        user u=new user();
        u.LastName='test';
        u.Alias='mytest';
        u.Email='lbahadur@sumoscheduler.com';
        u.Username='mytest@sumoscheduler.com';
        u.CompanyName='Borrego';
        u.ProfileId = [SELECT Id FROM Profile  LIMIT 1].Id;
        u.TimeZoneSidKey = 'America/Los_Angeles';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        u.LocaleSidKey = 'en_US';
        u.Department = 'Marketing';
        insert u;
       
        //create a AcctSeed__Expense_Report__c record
        List<AcctSeed__Expense_Report__c> expraplist = new List<AcctSeed__Expense_Report__c>();
        AcctSeed__Expense_Report__c exprap=new AcctSeed__Expense_Report__c();
        exprap.name='Frantz Renard';
        exprap.AcctSeed__Employee__c=u.id;
        exprap.AcctSeed__Status__c = 'In Process';  
        exprap.AcctSeed__Ledger__c = [SELECT Id FROM AcctSeed__Ledger__c WHERE AcctSeed__Type__c = 'Transactional' LIMIT 1].Id;
       // exprap.Branch__c='Corporate';
        insert exprap;
        expraplist.add(exprap);
        
        /* create ledger record 
        List<AcctSeed__Ledger__c> ledgers = new List<AcctSeed__Ledger__c>();
        ledgers.add(
            new AcctSeed__Ledger__c(
                Name = 'MainCompany',
                AcctSeed__Type__c = 'Transactional',
                AcctSeed__Billing_Activity_Statement_Format__c='a1U34000003y3Ql',
                AcctSeed__Billing_Outstanding_Statement_Format__c='a1U80000000COOs',
                AcctSeed__Default_Bank_Account__c= 'a1m80000000p2lF',
                AcctSeed__Default_Billing_Format__c='a1U80000000AbRO',
                AcctSeed__Default_Purchase_Order_Format__c='a1U80000000COQ8',
                AcctSeed__Default_Packing_Slip_Format__c='a1U34000004Abf2' 
                
            )
        );
        
        insert ledgers;
        */
        //create Cost_Code__c record 
        Cost_Code__c cc=new Cost_Code__c();
        cc.Name='Civil Engineering';
        cc.Number__c='03-1318';
        cc.Category__c='s';
        cc.Active__c=true;
       // cc.EPC_Cost_Grouping__c='Engineering';//commented out by DK on 1/13/2020 due to restricted picklist value error to validate the job number change set
        //cc.Core_EPC_Cost__c=true;
        insert cc;
        
         //create a Account record for opportunity
        Account acc=new Account();
        acc.name='test4';
        acc.Branch__c='Mid Atlantic';
        acc.Type='buyer';
        acc.Industry='Airport';
        acc.Job_Type__c='public';
        acc.Phone='1231231230';
        acc.Description='testmyarea';
        insert acc;
        
        // creaet Opportunity record 
        Opportunity opp=new Opportunity();
        opp.AccountId=acc.Id;
        opp.Name='abc';
        opp.StageName='PROSPECTING';
        opp.CloseDate=system.today();
        opp.Opportunity_Lead_Source__c='Affiliate';
        opp.Opportunity_Lead_Source_Specifics__c='abcd';
        insert opp;
        
        //create AcctSeed__Project__c project record 
        AcctSeed__Project__c proj=new AcctSeed__Project__c();
        proj.Name='test123';
        proj.Branch__c='Mid Atlantic';
        proj.AcctSeed__Opportunity__c=opp.Id;
        insert proj;
        
        //create a AcctSeed__GL_Account__c record 
        AcctSeed__GL_Account__c glacc=new AcctSeed__GL_Account__c();
        glacc.Name='test11';
        glacc.BalSheet_Type__c='01Cash';
        glacc.IncStmt_Type__c='09Other Income';
        glacc.AcctSeed__Type__c='Expense';
        glacc.AcctSeed__Active__c=true;
        glacc.AcctSeed__Bank__c = false;   //true;
        glacc.AcctSeed__Used_in_Expense_Reports__c = true;
        insert glacc;
        
        //create AcctSeed__Project_Task__c record
        AcctSeed__Project_Task__c ptask=new AcctSeed__Project_Task__c();
        ptask.Name='test33';
        ptask.Cost_Code__c=cc.Id;
        ptask.AcctSeed__Labor_GL_Account__c=glacc.id;    
        ptask.AcctSeed__Project__c=proj.id;
        insert ptask;
        
        // create AcctSeed__Accounting_Variable__c record
        AcctSeed__Accounting_Variable__c accvar=new AcctSeed__Accounting_Variable__c();
        accvar.Name='O&M';
        accvar.AcctSeed__Type__c='GL Account Variable 3';
        insert accvar;
        
        // create AcctSeed__Accounting_Variable__c record
        AcctSeed__Accounting_Variable__c accvar1=new AcctSeed__Accounting_Variable__c();
        accvar1.Name='O&M';
        accvar1.AcctSeed__Type__c='GL Account Variable 2';
        insert accvar1;
        
        //Creating data for AcctSeed__Accounting_Period__c
        AcctSeed__Accounting_Period__c accperiod = new AcctSeed__Accounting_Period__c();
        accperiod.Name = '1996-08';
        accperiod.AcctSeed__Start_Date__c = Date.Today();
        accperiod.AcctSeed__End_Date__c = Date.Today()+2;
        accperiod.AcctSeed__Status__c = 'Open';
        insert accperiod;
        
        //create AcctSeed__Expense_Line__c record 
        List<Sobject> explineid = new List<Sobject>();
        AcctSeed__Expense_Line__c expline=new AcctSeed__Expense_Line__c();
        expline.AcctSeed__Expense_Report__c=exprap.id;
        expline.AcctSeed__Amount__c=100;
        expline.Branch__c = 'Corporate';
        expline.Ops_Division__c = accvar.id;
        expline.AcctSeed__Date__c=system.today();
        expline.VendorText__c='test22';
       expline.AcctSeed__Expense_GL_Account__c=glacc.id;
        expline.AcctSeed__Project_Task__c=ptask.Id;
        expline.AcctSeed__Project__c= proj.Id; 
        expline.AcctSeed__Internal_Comment__c='mytestarea';
        expline.Sales_Segment__c=accvar1.Id;
        expline.AcctSeed__Invoice_Comment__c='test vendor';
        system.debug('Look Line' +expline);
        insert expline;
        explineid.add([Select Id From AcctSeed__Expense_Line__c Where Id=:expline.Id]);
        System.debug('======================================explineid:'+explineid);
        AcctSeed__Journal_Entry__c journalEntries = new AcctSeed__Journal_Entry__c();
        journalEntries.Name = 'journal test';
        journalEntries.AcctSeed__Journal_Date__c = Date.Today();
        journalEntries.AcctSeed__Ledger__c = [SELECT Id FROM AcctSeed__Ledger__c WHERE AcctSeed__Type__c = 'Transactional' LIMIT 1].Id;
        insert journalEntries;
        
        ApexPages.currentPage().getParameters().put('retUrl','/test');
            
        ApexPages.StandardSetController setcontroller = new ApexPages.StandardSetController(expraplist);
        setcontroller.setSelected(expraplist);
        ExpenseReportsController  erc = new ExpenseReportsController(setcontroller);
        erc.doLoad();
        
        accperiod.Name = System.now().year() + '-' + System.now().format('MM');
        update accperiod;
        ExpenseReportsController  erc1 = new ExpenseReportsController(setcontroller);
        erc1.doLoad();
        
    }
}