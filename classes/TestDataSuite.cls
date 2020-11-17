@isTest(seeAllData=true)
public class TestDataSuite {
    public static User[] users;
    public static Account[] accounts;
    public static Contact[] contacts;
    public static AcctSeed__Accounting_Period__c[] acctPeriods;
    public static AcctSeed__GL_Account__c[] glAccounts;
    public static AcctSeed__Accounting_Settings__c[] settings;
    public static AcctSeed__Project__c[] projects;  
    public static AcctSeed__Project_Task__c[] projectTasks;
    public static AcctSeed__Time_Card_Period__c[] periods;
    public static AcctSeed__Time_Card__c[] timeCards;
    public static AcctSeed__Time_Card_Line__c[] timeCardLines;
    public static AcctSeed__Time_Card_Day__c[] timeCardDays;
    public static AcctSeed__Billing_Rates__c[] billingRates;
    public static AcctSeed__Expense_Report__c[] expenseReports;
    public static AcctSeed__Expense_Line__c[] expenses;
    public static AcctSeed__Account_Payable__c[] accountPayables;
    public static AcctSeed__Account_Payable_Line__c[] accountPayableLines;
    public static AcctSeed__Billing_Format__c[] billingFormats;
    public static AcctSeed__Billing__c[] billings;
    public static AcctSeed__Billing_Line__c[] billingLines;
    public static AcctSeed__Journal_Entry__c[] journalEntries;
    public static AcctSeed__Journal_Entry_Line__c[] journalEntryLines;
    public static AcctSeed__Cash_Disbursement_Batch__c[] cashDisbursementBatch;
    public static AcctSeed__Cash_Disbursement__c[] cashDisbursements;
    public static AcctSeed__AP_Disbursement__c[] apDisbursements;
    public static AcctSeed__Cash_Receipt__c[] cashReceipts;
    public static AcctSeed__Scheduled_Revenue_Expense__c[] scheduledRevenues;
    public static AcctSeed__Time_Card_Accounting_Period__c[] timeCardAccountPeriods;
    //public static AcctSeed__Bank_Reconciliation__c[] bankRecs;
    public static AcctSeed__Ledger__c[] ledgers;
    public static AcctSeed__Accounting_Variable__c[] accountingVariables1;
    public static AcctSeed__Accounting_Variable__c[] accountingVariables2;
    public static AcctSeed__Accounting_Variable__c[] accountingVariables3;
    public static AcctSeed__Accounting_Variable__c[] accountingVariables4;

    // Used to disable triggers thus preventing over running SOQL query limit
    public static Boolean isDataSetup = false;
    
    public static void initialize() {
        isDataSetup = true;     
        Profile p = [select id from profile where name='Sys Admin w/o HR']; 
        /*users = new List<User>();
        
        //TODO: Refactor to query for active users
        users.add(
            new User(
                alias = 'fdca1', 
                email='standarduser@testorg.com', 
                emailencodingkey='UTF-8', 
                lastname='Testing', 
                languagelocalekey='en_US', 
                localesidkey='en_US', 
                profileid = p.Id, 
                timezonesidkey='America/Los_Angeles', 
                username='fdca.user1@testorg.com'
            )
        );

        users.add(
            new User(
                alias = 'fdca2', 
                email='standarduser@testorg.com', 
                emailencodingkey='UTF-8', 
                lastname='Testing', 
                languagelocalekey='en_US', 
                localesidkey='en_US', 
                profileid = p.Id, 
                timezonesidkey='America/Los_Angeles', 
                username='fdca.user2@testorg.com'
            )
        );
             
        insert users; */
                
        users = [SELECT Id, Name FROM User WHERE ProfileId = :p.Id AND IsActive = true];
        
        if (users.isEmpty()) {
            
            users = [SELECT Id, Name FROM User WHERE IsActive = true];
            
            for(User u : users) {
                u.ProfileId = p.Id;
            }
            
            update users;
        
        }  
            
        accounts = new List<Account>();
        Map<String, Schema.RecordTypeInfo> rtAccountByNameMap = Schema.SObjectType.Account.getRecordTypeInfosByName();
        
        accounts.add(
            new Account(
                Name = 'Test Account',
                RecordTypeId = rtAccountByNameMap.get('Vendor- Subcontractor/Non-Material').getRecordTypeId(),
                //Accounting_Status__c = 'Customer & Vendor',
                AcctSeed__Credit_Card_Vendor__c = true,
                ShippingCity = 'San Francisco'
            )
        );

       accounts.add(
            new Account(
                Name = 'Acme Account',
                //Accounting_Status__c = 'Customer & Vendor',
                AcctSeed__Credit_Card_Vendor__c = true,
                ShippingCity = 'San Francisco'
            )
        ); 
                
      //  insert accounts; // commented-throwing error of duplicate value when running test class (MG-7/24/19)

        contacts = new List<Contact>();
        contacts.add(
            new Contact(
                FirstName = 'John',
                LastName = 'Doe',
                accountId = accounts[0].Id
            )
        );
                
        insert contacts;
        
       acctPeriods = new List<AcctSeed__Accounting_Period__c>();
        
        acctPeriods.add(
            new AcctSeed__Accounting_Period__c(
                Name = '2025-06',
                AcctSeed__Start_Date__c = Date.newinstance(2025, 06, 1),
                AcctSeed__End_Date__c = Date.newinstance(2025, 06, 30),
                AcctSeed__Status__c = 'Open'
            )
        );

        acctPeriods.add(
            new AcctSeed__Accounting_Period__c(
                Name = '2025-10',
                AcctSeed__Start_Date__c = Date.newinstance(2025,10, 1),
                AcctSeed__End_Date__c = Date.newinstance(2025,10, 31),
                AcctSeed__Status__c = 'Open'
            )
        );

        acctPeriods.add(
            new AcctSeed__Accounting_Period__c(
                Name = '2025-07',
                AcctSeed__Start_Date__c = Date.newinstance(2025, 07, 1),
                AcctSeed__End_Date__c = Date.newinstance(2025, 07, 31),
                AcctSeed__Status__c = 'Open'
            )
        );

        acctPeriods.add(
            new AcctSeed__Accounting_Period__c(
                Name = '2025-08',
                AcctSeed__Start_Date__c = Date.newinstance(2025, 08, 1),
                AcctSeed__End_Date__c = Date.newinstance(2025, 08, 31),
                AcctSeed__Status__c = 'Open'
            )
        );                      

        acctPeriods.add(
            new AcctSeed__Accounting_Period__c(
                Name = '2025-09',
                AcctSeed__Start_Date__c = Date.newinstance(2025, 09, 1),
                AcctSeed__End_Date__c = Date.newinstance(2025, 09, 30),
                AcctSeed__Status__c 
                = 'Open'
            )
        );                      
        insert acctPeriods ;
                
        glAccounts = new List<AcctSeed__GL_Account__c>();
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '5000-Labor',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense'
            )
        );
        
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '6010-Mileage',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense',
                AcctSeed__Used_In_Expense_Reports__c = true,
                AcctSeed__Mileage_Account__c = true,
                AcctSeed__Mileage_Rate__c = .5
            )
        );
        
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '4000-Consulting Revenue',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Revenue'
            )
        );

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '2000-Accounts Payable',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Revenue'
            )
        );

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '1000-Bank of America Account 5347',
                AcctSeed__Active__c = true,
                AcctSeed__Sub_Type_1__c = 'Assets',
                AcctSeed__Type__c = 'Balance Sheet',
                AcctSeed__Bank__c = true
            )
        );          

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = 'Discount GL Account',
                AcctSeed__Active__c = true,
                AcctSeed__Sub_Type_1__c = 'Assets',
                AcctSeed__Type__c = 'Balance Sheet'
            )
        );  

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = 'Unapplied Cash GL Account',
                AcctSeed__Active__c = true,
                AcctSeed__Sub_Type_1__c = 'Assets',
                AcctSeed__Type__c = 'Balance Sheet'
            )
        ); 

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = 'Lodgings',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense',
                AcctSeed__Used_In_Expense_Reports__c = true
            )
        );    

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = 'Current Year Earnings',
                AcctSeed__Active__c = true,
                AcctSeed__Sub_Type_1__c = 'Assets',
                AcctSeed__Type__c = 'Balance Sheet'
            )
        ); 
               
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = 'Retained Earnings',
                AcctSeed__Active__c = true,
                AcctSeed__Sub_Type_1__c = 'Assets',
                AcctSeed__Type__c = 'Balance Sheet'
            )
        ); 

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = 'AR Control Account',
                AcctSeed__Active__c = true,
                AcctSeed__Sub_Type_1__c = 'Assets',
                AcctSeed__Type__c = 'Balance Sheet'
            )
        ); 
                                            
        insert glAccounts;
        
        glAccounts[0].AcctSeed__TM_Revenue_Conversion__c = glAccounts[2].Id;
        update glAccounts[0];

        ledgers = new List<AcctSeed__Ledger__c>();

       ledgers.add(
            new AcctSeed__Ledger__c(
                AcctSeed__Type__c = 'Transactional',
                AcctSeed__Billing_Activity_Statement_Format__c='a1U34000003y3Ql',
                AcctSeed__Billing_Outstanding_Statement_Format__c='a1U80000000COOs',
                AcctSeed__Default_Bank_Account__c= 'a1m80000000p2ic',
                AcctSeed__Default_Billing_Format__c='a1U80000000AbRO',
                AcctSeed__Default_Purchase_Order_Format__c='a1U80000000COQ8',
                AcctSeed__Default_Packing_Slip_Format__c='a1U34000004Abf2'
                   )
        ); 
                
        ledgers.add(
            new AcctSeed__Ledger__c(
                AcctSeed__Type__c = 'Budget',
                AcctSeed__Billing_Activity_Statement_Format__c='a1U34000003y3Ql',
                AcctSeed__Billing_Outstanding_Statement_Format__c='a1U80000000COOs',
                AcctSeed__Default_Bank_Account__c='a1m80000000p2ic',
                AcctSeed__Default_Billing_Format__c='a1U80000000AbRO',
                AcctSeed__Default_Purchase_Order_Format__c='a1U80000000COQ8',
                AcctSeed__Default_Packing_Slip_Format__c='a1U34000004Abf2'
                )
            
            
        );
        
  //      insert ledgers;   // commented-throwing error of duplicate value when running test class (MG-7/24/19)
                
        /*settings = new List<AcctSeed__Accounting_Settings__c>();
        
        settings.add(
            new AcctSeed__Accounting_Settings__c(
                AcctSeed__AR_Control_GL_Account__c = glAccounts[10].Id,
                AcctSeed__AP_Control_GL_Account__c = glAccounts[3].Id,
                AcctSeed__Labor_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Default_Bank_Account__c = glAccounts[4].Id,   
                AcctSeed__Payment_Discount_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Unapplied_Cash_GL_Account__c = glAccounts[6].Id   ,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Default_Project_Task_Labor_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Current_Year_Earnings_GL_Account__c = glAccounts[8].Id,
                AcctSeed__Retained_Earnings_GL_Account__c = glAccounts[9].Id,
                AcctSeed__Default_Ledger__c = ledgers[0].Id
            )
        );
        insert settings;*/
        
        //Select   From  Where AR_Control_GL_Account__c != null Order By CreatedDate Desc Limit 1
        projects = new List<AcctSeed__Project__c>();    
        projects.add(
            new AcctSeed__Project__c(
                Name = 'Test Project',
                AcctSeed__Account__c = accounts[0].Id,
                AcctSeed__Status__c = 'Active'
            )
        );

        projects.add(
            new AcctSeed__Project__c(
                Name = 'Test Template Project',
                AcctSeed__Account__c = accounts[0].Id,
                AcctSeed__Status__c = 'Active',
                AcctSeed__Template_Project__c = true
            )
        );
        
        insert projects;
        
        projectTasks = new List<AcctSeed__Project_Task__c>();
        projectTasks.add(
            new AcctSeed__Project_Task__c(
                Name = 'Test Project Task 1',
                AcctSeed__Project__c = projects[0].Id,
                AcctSeed__Status__c = 'Active',
                AcctSeed__Labor_GL_Account__c = 'a1m80000000p2ic'
            )
        );
        
        projectTasks.add(
            new AcctSeed__Project_Task__c(
                Name = 'Test Project Task 2',
                AcctSeed__Project__c = projects[0].Id,
                AcctSeed__Status__c = 'Active',
                AcctSeed__Labor_GL_Account__c = 'a1m80000000p2ic'
               
            )
        );

        projectTasks.add(
            new AcctSeed__Project_Task__c(
                Name = 'Test Template Project Task',
                AcctSeed__Project__c = projects[1].Id,
                AcctSeed__Status__c = 'Active',
                AcctSeed__Labor_GL_Account__c = 'a1m80000000p2ic'
                
            )
        );
                
        insert projectTasks;        
        
        
        periods = new List<AcctSeed__Time_Card_Period__c>();
        periods.add(
            new AcctSeed__Time_Card_Period__c(
                Name='2025-06', 
                AcctSeed__Start_Date__c=date.newinstance(2025,06, 3), 
                AcctSeed__End_Date__c=date.newinstance(2025,06, 9)
            )
        );
 
         periods.add(
            new AcctSeed__Time_Card_Period__c(
                Name='2025-07', 
                AcctSeed__Start_Date__c=date.newinstance(2025,07, 1), 
                AcctSeed__End_Date__c=date.newinstance(2025,07, 7)
            )
        );
               
        insert periods; 
        
        timeCardAccountPeriods = new List<AcctSeed__Time_Card_Accounting_Period__c>();
        timeCardAccountPeriods.add(
            new AcctSeed__Time_Card_Accounting_Period__c(
                AcctSeed__Accounting_Period__c = acctPeriods[0].Id,
                AcctSeed__Time_Card_Period__c = periods[0].Id
            )
        );

        timeCardAccountPeriods.add(
            new AcctSeed__Time_Card_Accounting_Period__c(
                AcctSeed__Accounting_Period__c = acctPeriods[1].Id,
                AcctSeed__Time_Card_Period__c = periods[1].Id
            )
        );
       
        insert timeCardAccountPeriods;
        
        timeCards = new List<AcctSeed__Time_Card__c>();
        timeCards.add(
            new AcctSeed__Time_Card__c(
                AcctSeed__Time_Card_Period__c = periods[0].Id,
                AcctSeed__Employee__c = UserInfo.getUserId(),
                AcctSeed__Status__c = 'In Process'
            )   
        );

        timeCards.add(
            new AcctSeed__Time_Card__c(
                AcctSeed__Time_Card_Period__c = periods[1].Id,
                AcctSeed__Employee__c = UserInfo.getUserId(),
                AcctSeed__Status__c = 'In Process'
            )   
        );
        
        insert timeCards;
        
        List<AcctSeed__Accounting_Variable__c> accVariable = new List<AcctSeed__Accounting_Variable__c>();
        accVariable = [SELECT Id FROM AcctSeed__Accounting_Variable__c where AcctSeed__Type__c = 'Time Card Variable 1'];
        
        List<Site__c> sites=new List<Site__c>();
        sites=[select Id,Project__c from Site__c where Project__c!=null limit 1 ];
        Site__c newsite=new Site__c();
        newsite=sites.get(0);
        
         List<AcctSeed__Project_Task__c> projectTasks1 = new List<AcctSeed__Project_Task__c>();
        projectTasks1 = [SELECT Id FROM AcctSeed__Project_Task__c where AcctSeed__Project__c=:newsite.Project__c limit 10];
        
        
         List<AcctSeed__Accounting_Variable__c> accVariable1 = new List<AcctSeed__Accounting_Variable__c>();
        accVariable1 = [SELECT Id FROM AcctSeed__Accounting_Variable__c where AcctSeed__Type__c = 'Time Card Variable 2' and Site__c=:newsite.Id];
        
       
        
        
        timeCardLines = new List<AcctSeed__Time_Card_Line__c>();
        
        timeCardLines.add(
            new AcctSeed__Time_Card_Line__c(
               AcctSeed__Project__c = newsite.Project__c,
               AcctSeed__Project_Task__c = projectTasks1[0].Id,
               AcctSeed__Time_Card__c = timeCards[0].Id,
               AcctSeed__Time_Card_Variable_1__c = accVariable[0].Id,
               AcctSeed__Time_Card_Variable_2__c = accVariable1[0].Id
             //  site__c = 'a6934000001gcbp'   
            )
        );
        
        timeCardLines.add(
            new AcctSeed__Time_Card_Line__c(
               AcctSeed__Project__c = newsite.Project__c,
               AcctSeed__Project_Task__c = projectTasks1[0].Id,
               AcctSeed__Time_Card__c = timeCards[0].Id,
               AcctSeed__Time_Card_Variable_1__c = accVariable[0].Id,
               AcctSeed__Time_Card_Variable_2__c = accVariable1[0].Id
              // site__c = 'a6934000001gcbp'  
            )
        );
        insert timeCardLines;
        
        /*timeCardDays = new List<Time_Card_Day__c>();
        
        timeCardDays.add(
            new Time_Card_Day__c(
                Date__c = periods[0].Start_Date__c,
                Hours__c = 8,
                Time_Card_Line__c = timeCardLines[0].Id
            )
        );
        timeCardDays.add(
            new Time_Card_Day__c(
                Date__c = periods[0].Start_Date__c + 1,
                Hours__c = 8,
                Time_Card_Line__c = timeCardLines[0].Id
            )
        );
        timeCardDays.add(
            new Time_Card_Day__c(
                Date__c = periods[0].Start_Date__c + 2,
                Hours__c = 8,
                Time_Card_Line__c = timeCardLines[0].Id
            )
        );
        timeCardDays.add(
            new Time_Card_Day__c(
                Date__c = periods[0].Start_Date__c + 3,
                Hours__c = 8,
                Time_Card_Line__c = timeCardLines[0].Id
            )
        );  
        
        timeCardDays.add(
            new Time_Card_Day__c(
                Date__c = periods[1].Start_Date__c,
                Hours__c = 8,
                Time_Card_Line__c = timeCardLines[1].Id
            )
        );
        timeCardDays.add(
            new Time_Card_Day__c(
                Date__c = periods[1].Start_Date__c + 1,
                Hours__c = 8,
                Time_Card_Line__c = timeCardLines[1].Id
            )
        );
        timeCardDays.add(
            new Time_Card_Day__c(
                Date__c = periods[1].Start_Date__c + 2,
                Hours__c = 8,
                Time_Card_Line__c = timeCardLines[1].Id
            )
        );
        timeCardDays.add(
            new Time_Card_Day__c(
                Date__c = periods[1].Start_Date__c + 3,
                Hours__c = 8,
                Time_Card_Line__c = timeCardLines[1].Id
            )
        );
        insert timeCardDays;
        
        billingRates = new List<Billing_Rates__c>();
        
        billingRates.add(
            new Billing_Rates__c(
                Project__c = projects[0].Id,
                Project_Task__c = projectTasks[0].Id,
                Employee__c = UserInfo.getUserId(),
                Amount__c = 100,
                Effective_Date__c = System.today()
            )
        );
        
        billingRates.add(
            new Billing_Rates__c(
                Project__c = projects[0].Id,
                Project_Task__c = projectTasks[1].Id,
                Employee__c = UserInfo.getUserId(),
                Amount__c = 100,
                Effective_Date__c = System.today()
            )
        );
        insert billingRates;*/
            
        expenseReports = new List<AcctSeed__Expense_Report__c>();
        expenseReports.add(
            new AcctSeed__Expense_Report__c(
                AcctSeed__Employee__c = users[0].Id,
                AcctSeed__Status__c = 'In Process'        
            )
        );

        expenseReports.add(
            new AcctSeed__Expense_Report__c(
                AcctSeed__Employee__c = users[0].Id,
                AcctSeed__Status__c = 'In Process'        
            )
        );
        
        insert expenseReports;
                    
        expenses = new List<AcctSeed__Expense_Line__c>();
        expenses.add(
            new AcctSeed__Expense_Line__c(
                AcctSeed__Date__c = System.today(),
                AcctSeed__Expense_Report__c = expenseReports[0].Id,
                AcctSeed__Project__c = projects[0].Id,
                AcctSeed__Project_Task__c = projectTasks[0].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[1].Id,
                AcctSeed__Miles__c = 50,
                AcctSeed__Amount__c = 50,
                AcctSeed__Invoice_Comment__c='test vendor'
            )
        );

        expenses.add(
            new AcctSeed__Expense_Line__c(
                AcctSeed__Date__c = System.today(),
                AcctSeed__Expense_Report__c = expenseReports[0].Id,
                AcctSeed__Project__c = projects[0].Id,
                AcctSeed__Project_Task__c = projectTasks[0].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[7].Id,
                AcctSeed__Amount__c = 50,
                VendorText__c = 'Hyatt',
                AcctSeed__Invoice_Comment__c='test vendor'
            )
        );

        expenses.add(
            new AcctSeed__Expense_Line__c(
                AcctSeed__Date__c = System.today(),
                AcctSeed__Expense_Report__c = expenseReports[1].Id,
                AcctSeed__Project__c = projects[0].Id,
                AcctSeed__Project_Task__c = projectTasks[0].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[1].Id,
                AcctSeed__Miles__c = 50,
                AcctSeed__Mileage_Origin__c = 'Las Vegas, NV',
                AcctSeed__Mileage_Destination__c = 'Las Vegas, NM',
                AcctSeed__Amount__c = 50,
                AcctSeed__Invoice_Comment__c='test vendor'
            )
        );

        expenses.add(
            new AcctSeed__Expense_Line__c(
                AcctSeed__Date__c = System.today(),
                AcctSeed__Expense_Report__c = expenseReports[1].Id,
                AcctSeed__Project__c = projects[0].Id,
                AcctSeed__Project_Task__c = projectTasks[0].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[1].Id,
                AcctSeed__Miles__c = 50,
                AcctSeed__Mileage_Origin__c = 'Las Vegas, NV',
                AcctSeed__Mileage_Destination__c = 'Las Vegas, NM',             
                AcctSeed__Amount__c = 50 ,
                AcctSeed__Invoice_Comment__c='test vendor'
            )
        );      
        insert expenses;
             
        accountPayables = new List<AcctSeed__Account_Payable__c>();         
        accountPayables.add(
            new AcctSeed__Account_Payable__c(
                AcctSeed__Payee_Reference__c = '2345sdfghtwsrehfdhdfhdfh',
               // AcctSeed__Payee__c='0018000000aHGmh', 
                AcctSeed__Status__c = 'In Process',
                AcctSeed__Payment_Status__c = 'Unpaid',
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Due_Date__c = acctPeriods[0].AcctSeed__End_Date__c,
                AcctSeed__Vendor__c = '0018000000aHGmh',//accounts[0].Id,
                AcctSeed__Discount_Amount__c = 20,
                AcctSeed__Accounting_Period__c = acctPeriods[0].Id
                )
                
                
            
        );

        accountPayables.add(
            new AcctSeed__Account_Payable__c(
                AcctSeed__Payee_Reference__c ='234sdfigojjnklsndlfg',
              //  AcctSeed__Payee__c='0018000000aHGmh',
                AcctSeed__Status__c = 'In Process',
                AcctSeed__Payment_Status__c = 'Unpaid',
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Due_Date__c = acctPeriods[0].AcctSeed__End_Date__c,
                AcctSeed__Contact__c = contacts[0].Id,
                AcctSeed__Accounting_Period__c = acctPeriods[0].Id
            )
        );
        
        accountPayables.add(
            new AcctSeed__Account_Payable__c(
                AcctSeed__Payee_Reference__c ='2345dfgjpdfkgjdklfgjdfklgfd',
              //  AcctSeed__Payee__c='0018000000aHGmh',
                AcctSeed__Status__c = 'In Process',
                AcctSeed__Payment_Status__c = 'Unpaid',
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Due_Date__c = acctPeriods[0].AcctSeed__End_Date__c,
                AcctSeed__Employee__c = UserInfo.getUserId(),
                AcctSeed__Accounting_Period__c = acctPeriods[0].Id
            )
        );      
        
        accountPayables.add(
            new AcctSeed__Account_Payable__c(
                AcctSeed__Payee_Reference__c ='23453456345345345345435345345345345345345345',
              //  AcctSeed__Payee__c='0018000000aHGmh',
                AcctSeed__Status__c = 'In Process',
                AcctSeed__Payment_Status__c = 'Unpaid',
                AcctSeed__Date__c = acctPeriods[1].AcctSeed__Start_Date__c,
                AcctSeed__Due_Date__c = acctPeriods[1].AcctSeed__End_Date__c,
                AcctSeed__Employee__c = UserInfo.getUserId(),
                AcctSeed__Accounting_Period__c = acctPeriods[1].Id
            )
        );      
        insert accountPayables;
        
        accountPayableLines = new List<AcctSeed__Account_Payable_Line__c>();
        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[0].Id,
                AcctSeed__Amount__c = 45,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );
        
        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[0].Id,
                AcctSeed__Amount__c = 55,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );
        
        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[0].Id,
                AcctSeed__Amount__c = 65,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );
        
        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[1].Id,
                AcctSeed__Amount__c = 45,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );
        
        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[1].Id,
                AcctSeed__Amount__c = 55,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );
        
        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[1].Id,
                AcctSeed__Amount__c = 60,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );

        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[2].Id,
                AcctSeed__Amount__c = 45,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );
        
        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[2].Id,
                AcctSeed__Amount__c = 55,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );
        
        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[2].Id,
                AcctSeed__Amount__c = 55,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );  

        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[3].Id,
                AcctSeed__Amount__c = 55,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );
        
        accountPayableLines.add(
            new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Account_Payable__c = accountPayables[3].Id,
                AcctSeed__Amount__c = 55,
                AcctSeed__Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Expense_GL_Account__c = glAccounts[3].Id
            )
        );          
        insert accountPayableLines;
        /*
        billingFormats = new List<Billing_Format__c>();
        billingFormats.add(
            new Billing_Format__c(
                Name = 'new'
           )
        );      
        insert billingFormats;
        
        billings = new List<Billing__c>();
        billings.add(
            new Billing__c(
                Billing_Cycle_Start_Date__c = acctPeriods[0].Start_Date__c,
                Billing_Cycle_End_Date__c = acctPeriods[0].End_Date__c+3,
                Date__c = acctPeriods[0].Start_Date__c,
                Customer__c = accounts[0].Id,
                Status__c = 'In Process',
                Accounting_Period__c = acctPeriods[0].Id,
                Billing_Format__c = billingFormats[0].Id,
                Due_Date2__c = System.today() + 30
           )
        );

        billings.add(
            new Billing__c(
                Billing_Cycle_Start_Date__c = acctPeriods[0].Start_Date__c,
                Billing_Cycle_End_Date__c = acctPeriods[0].End_Date__c+3,
                Date__c = acctPeriods[0].Start_Date__c,
                Customer__c = accounts[0].Id,
                Status__c = 'In Process',
                Accounting_Period__c = acctPeriods[0].Id,
                Billing_Format__c = billingFormats[0].Id,
                Due_Date2__c = System.today() + 30
           )
        );  
            
        insert billings;
        
        billingLines = new List<Billing_Line__c>();
        billingLines.add(
            new Billing_Line__c(
                Billing__c = billings[0].Id,
                Date__c = acctPeriods[0].Start_Date__c,
                Hours_Units__c = 20,
                Rate__c = 10,
                Revenue_GL_Account__c = glAccounts[2].Id
             )
        );
        
        billingLines.add(
            new Billing_Line__c(
                Billing__c = billings[0].Id,
                Date__c = acctPeriods[0].Start_Date__c,
                Hours_Units__c = 25,
                Rate__c = 10,
                Revenue_GL_Account__c = glAccounts[2].Id
             )
        );      

        billingLines.add(
            new Billing_Line__c(
                Billing__c = billings[1].Id,
                Date__c = acctPeriods[0].Start_Date__c,
                Hours_Units__c = 20,
                Rate__c = 10,
                Revenue_GL_Account__c = glAccounts[2].Id
             )
        );
        
        billingLines.add(
            new Billing_Line__c(
                Billing__c = billings[1].Id,
                Date__c = acctPeriods[0].Start_Date__c,
                Hours_Units__c = 25,
                Rate__c = 10,
                Revenue_GL_Account__c = glAccounts[2].Id
             )
        );          
        insert billingLines;    

        journalEntries = new List<Journal_Entry__c>();

        
        journalEntries.add( 
            new Journal_Entry__c(
                Name='testJournal', 
                Accounting_Period__c = acctPeriods[0].Id,
                Journal_Date__c = System.today(), 
                Status__c='In Process'
            )
        );
        insert journalEntries;
     
        journalEntryLines = new List<Journal_Entry_Line__c>();
        
        journalEntryLines.add(
            new Journal_Entry_Line__c(
                Billable__c=true,
                Journal_Entry__c=journalEntries[0].Id,
                Project__c=projects[0].Id, 
                Project_Task__c=projectTasks[0].Id, 
                Credit__c=100,
                GL_Account__c=glAccounts[0].Id,
                Units__c=10
            )
         );


        journalEntryLines.add(
            new Journal_Entry_Line__c(
                Billable__c=true,
                Journal_Entry__c=journalEntries[0].Id,
                Project__c=projects[0].Id, 
                Project_Task__c=projectTasks[0].Id, 
                Debit__c=100,
                GL_Account__c=glAccounts[0].Id,
                Units__c=10
            )
        );
         
        insert journalEntryLines;
        */
        cashDisbursementBatch = new List<AcctSeed__Cash_Disbursement_Batch__c>();
        cashDisbursementBatch.add(
            new AcctSeed__Cash_Disbursement_Batch__c(
                AcctSeed__Starting_Check_Number__c = 1,
                Name = 'Test Batch'
            )
        );

        cashDisbursementBatch.add(
            new AcctSeed__Cash_Disbursement_Batch__c(
                AcctSeed__Starting_Check_Number__c = 2,
                Name = 'Test Batch 2'
            )
        );
                
        insert cashDisbursementBatch;
        
        cashDisbursements = new List<AcctSeed__Cash_Disbursement__c>();
        cashDisbursements.add(
            new AcctSeed__Cash_Disbursement__c(
                AcctSeed__Cash_Disbursement_Batch__c = cashDisbursementBatch[0].Id,
                AcctSeed__Disbursement_Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Type__c = 'Check',
                AcctSeed__Amount__c = 12,
                AcctSeed__Source__c = 'Account Payable',
                AcctSeed__Bank_Account__c = glAccounts[4].Id,
                AcctSeed__Vendor__c = '00130000009oCRn',//accounts[0].Id,
                AcctSeed__Accounting_Period__c = acctPeriods[0].Id,
                AcctSeed__Status__c = 'In Process'
            )
        );  
        
        cashDisbursements.add(
            new AcctSeed__Cash_Disbursement__c(
                AcctSeed__Cash_Disbursement_Batch__c = cashDisbursementBatch[0].Id,
                AcctSeed__Disbursement_Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Type__c = 'Check',
                AcctSeed__Amount__c = 123,
                AcctSeed__Source__c = 'Account Payable',
                AcctSeed__Bank_Account__c = glAccounts[4].Id,
                AcctSeed__Contact__c = contacts[0].Id,
                AcctSeed__Accounting_Period__c = acctPeriods[0].Id,
                AcctSeed__Status__c = 'In Process'
            )
        );  
        
        cashDisbursements.add(
            new AcctSeed__Cash_Disbursement__c(
                AcctSeed__Cash_Disbursement_Batch__c = cashDisbursementBatch[0].Id,
                AcctSeed__Disbursement_Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Type__c = 'Check',
                AcctSeed__Amount__c = 123,
                AcctSeed__Source__c = 'Account Payable',
                AcctSeed__Bank_Account__c = glAccounts[4].Id,
                AcctSeed__Employee__c = UserInfo.getUserId(),
                AcctSeed__Accounting_Period__c = acctPeriods[0].Id,
                AcctSeed__Status__c = 'In Process'
            )
        );  

        cashDisbursements.add(
            new AcctSeed__Cash_Disbursement__c(
                AcctSeed__Cash_Disbursement_Batch__c = cashDisbursementBatch[1].Id,
                AcctSeed__Disbursement_Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Type__c = 'Check',
                AcctSeed__Amount__c = 123,
                AcctSeed__Source__c = 'Account Payable',
                AcctSeed__Bank_Account__c = glAccounts[4].Id,
                AcctSeed__Debit_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Employee__c = UserInfo.getUserId(),
                AcctSeed__Accounting_Period__c = acctPeriods[0].Id,
                AcctSeed__Status__c = 'Posted'
            )
        );

        cashDisbursements.add(
            new AcctSeed__Cash_Disbursement__c(
                AcctSeed__Cash_Disbursement_Batch__c = cashDisbursementBatch[1].Id,
                AcctSeed__Disbursement_Date__c = acctPeriods[0].AcctSeed__Start_Date__c,
                AcctSeed__Type__c = 'Check',
                AcctSeed__Amount__c = 123,
                AcctSeed__Bank_Account__c = glAccounts[4].Id,
                AcctSeed__Debit_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Employee__c = UserInfo.getUserId(),
                AcctSeed__Accounting_Period__c = acctPeriods[0].Id,
                AcctSeed__Status__c = 'Posted'
            )
        );
                
        insert cashDisbursements;
 /*       
        apDisbursements = new List<AcctSeed__AP_Disbursement__c>();
        apDisbursements.add(
            new AcctSeed__AP_Disbursement__c(
                AcctSeed__Account_Payable__c = accountPayables[0].Id,
                AcctSeed__Cash_Disbursement__c = cashDisbursements[0].Id,
                AcctSeed__Paid_Amount__c = 145
            )
        );

        apDisbursements.add(
            new AcctSeed__AP_Disbursement__c(
                AcctSeed__Account_Payable__c = accountPayables[1].Id,
                AcctSeed__Cash_Disbursement__c = cashDisbursements[1].Id,
                AcctSeed__Paid_Amount__c = 160
            )
        ); 
        
        apDisbursements.add(
            new AcctSeed__AP_Disbursement__c(
                AcctSeed__Account_Payable__c = accountPayables[2].Id,
                AcctSeed__Cash_Disbursement__c = cashDisbursements[2].Id,
                AcctSeed__Paid_Amount__c = 155
            )
        );  
        
        insert apDisbursements;  
        
        cashReceipts = new List<Cash_Receipt__c>();
        
        cashReceipts.add(
            new Cash_Receipt__c(
                Account__c = accounts[0].Id,
                Amount__c = 400,
                Payment_Reference__c = '0000000432',
                Status__c = 'In Process',
                Receipt_Date__c = acctPeriods[1].Start_Date__c,
                Accounting_Period__c = acctPeriods[1].Id,
                Purpose__c = 'Customer Receipt',
                Bank_Account__c = glAccounts[4].Id,
                Credit_GL_Account__c = glAccounts[0].Id
            )
        );
        
        cashReceipts.add(
            new Cash_Receipt__c(
                Account__c = accounts[0].Id,
                Amount__c = 500,
                Payment_Reference__c = '0000000432',
                Status__c = 'In Process',
                Receipt_Date__c = acctPeriods[1].Start_Date__c,
                Accounting_Period__c = acctPeriods[1].Id,
                Purpose__c = 'Customer Receipt',
                Bank_Account__c = glAccounts[4].Id
            )
        );
    
        insert cashReceipts;
        
        scheduledRevenues = new List<Scheduled_Revenue_Expense__c>();
        
        scheduledRevenues.add(
            new Scheduled_Revenue_Expense__c(
                Name = 'Test Rev 1',
                Amount__c = 400,
                Credit_GL_Account__c = glAccounts[1].Id,
                Debit_GL_Account__c = glAccounts[2].Id,
                Accounting_Period__c = acctPeriods[0].Id,
                Status__c = 'Scheduled'
            )
        );
        
        scheduledRevenues.add(
            new Scheduled_Revenue_Expense__c(
                Name = 'Test Rev 2',
                Amount__c = 200,
                Credit_GL_Account__c = glAccounts[1].Id,
                Debit_GL_Account__c = glAccounts[2].Id,
                Accounting_Period__c = acctPeriods[0].Id,
                Status__c = 'Scheduled'
            )
        );
        
        insert scheduledRevenues;
        
        bankRecs = new List<Bank_Reconciliation__c>();
        
        bankRecs.add(
            new Bank_Reconciliation__c(
                Name = 'Test',
                Ledger_Balance__c = 1345.00,
                Bank_Balance__c = 25000,
                GL_Account__c = glAccounts[1].Id,
                Reconciliation_Date__c = System.today()
            )
        );
        
        insert bankRecs;    
        
        /*
        accountingVariables = new List<Accounting_Variable__c>();
        accountingVariables.add(
            new Accounting_Variable__c(
                Name = 'Account Variable Test 1',
                Type__c = 'GL Account Variable 1',
                Active__c = true
            )
        );

        accountingVariables.add(
            new Accounting_Variable__c(
                Name = 'Account Variable Test 2',
                Type__c = 'GL Account Variable 2',
                Active__c = true
            )
        );

        accountingVariables.add(
            new Accounting_Variable__c(
                Name = 'Account Variable Test 3',
                Type__c = 'GL Account Variable 3',
                Active__c = true
            )
        );
        
        accountingVariables.add(
            new Accounting_Variable__c(
                Name = 'Account Variable Test 4',
                Type__c = 'GL Account Variable 4',
                Active__c = true
            )
        );  
        insert accountingVariables;
        */
        /*
        accountingVariables1 = new List<Accounting_Variable__c>();
        
        accountingVariables1.add(
            new Accounting_Variable__c(
                Name = 'Sales',
                Active__c = true,
                Type__c = 'GL Account Variable 1'
            )
        );
        
        accountingVariables1.add(
            new Accounting_Variable__c(
                Name = 'Marketing',
                Active__c = true,
                Type__c = 'GL Account Variable 1'
            )
        );
        
        insert accountingVariables1;
        
        //Set up Accounting Variables 2
        accountingVariables2 = new List<Accounting_Variable__c>();
        
         accountingVariables2.add(
            new Accounting_Variable__c(
                Name = 'Northeast Division',
                Active__c = true,
                Type__c = 'GL Account Variable 2'
            )
        );
        
         accountingVariables2.add(
            new Accounting_Variable__c(
                Name = 'Central Division',
                Active__c = true,
                Type__c = 'GL Account Variable 2'
            )
        );
        
        insert  accountingVariables2;
        
        //Set up Accounting Variables 3
         accountingVariables3 = new List<Accounting_Variable__c>();
        
         accountingVariables3.add(
            new Accounting_Variable__c(
                Name = 'Executive',
                Active__c = true,
                Type__c = 'GL Account Variable 3'
            )
        );
        
         accountingVariables3.add(
            new Accounting_Variable__c(
                Name = 'Administrative',
                Active__c = true,
                Type__c = 'GL Account Variable 3'
            )
        );
        
        insert  accountingVariables3;
    
        //Set up Accounting Variables 4
         accountingVariables4 = new List<Accounting_Variable__c>();
        
         accountingVariables4.add(
            new Accounting_Variable__c(
                Name = 'USA',
                Active__c = true,
                Type__c = 'GL Account Variable 4'
            )
        );
        
         accountingVariables4.add(
            new Accounting_Variable__c(
                Name = 'Canada',
                Active__c = true,
                Type__c = 'GL Account Variable 4'
            )
        );
                
        insert accountingVariables4;*/
        
        isDataSetup = false;
    }
}