@istest
public class ContactTrigger_Test {

@testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    }

// TestMethod1 will work on insertion of contact.
    static testmethod void testmethod1(){
        
       // Account Dummy Data 
       Account acc = new Account();
        acc.name = 'test';
        acc.Type = 'Customers';
        acc.Industry = 'Airport';
        acc.Job_Type__c ='Public';
        acc.Description ='test destricption';
        acc.Branch__c = 'So Cal';
        acc.Phone = '9876543210';
        insert acc;
       
       // Contact Dummy Data 
        Map<Id,Contact> mapcon = new Map<Id,Contact>();
        List<contact> c = new List<contact>();
        Contact con = new Contact();
        con.lastname = 'Contact lastname';
        con.accountId = acc.Id;
        con.Contact_Type__c = 'O&M Billing Contact';
        System.Test.StartTest();
        insert con;
        c.add(con);
        mapcon.put(con.id,con);

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
        
        contr.Regional_Manager_User__c = userid.Id;
        contr.Area_Supervisor__c = userid.id;
        insert contr;
        //class schema
        ContactTriggerHandler contrig = new ContactTriggerHandler();
        // Method called from Class
        ContactTriggerHandler.createContactRole(c,mapcon,false,true,true);
        System.Test.StopTest();
     }
    
    // TestMethod2 will work on updation.Contacttype value is not null at the time of insertion.
     static testmethod void testmethod2(){
        
       Account acc = new Account();
        acc.name = 'test';
        acc.Type = 'Customers';
        acc.Industry = 'Airport';
        acc.Job_Type__c ='Public';
        acc.Description ='test destricption';
        acc.Branch__c = 'So Cal';
        acc.Phone = '9876543210';
        insert acc;
        
        Map<Id,Contact> mapcon = new Map<Id,Contact>();
        List<contact> c = new List<contact>();
        Contact con = new Contact();
        con.lastname = 'Contact lastname';
        con.accountId = acc.Id;
        con.Contact_Type__c = '';
        
        insert con;
         System.Test.StartTest();
         con.Contact_Type__c = 'O&M Billing Contact';
         update con;
        c.add(con);
        mapcon.put(con.id,con);

        Opportunity opp = new Opportunity();
        opp.name = 'Test Opportunity';
        opp.accountId = acc.Id;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today()+2;
        opp.Opportunity_Lead_Source__c = 'Affiliate';
        opp.Opportunity_Lead_Source_Specifics__c = 'test';
        opp.accountId = acc.Id;
        insert opp;

        AcctSeed__Project__c projectDummy = new AcctSeed__Project__c();
        projectDummy.Intx_Apps__c = 'test';
        projectDummy.Branch__c = 'San Diego';
        projectDummy.AcctSeed__Opportunity__c = opp.Id;
        insert projectDummy;
         user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];

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
          contr.Regional_Manager_User__c = userid.Id;
        contr.Area_Supervisor__c = userid.id;
        insert contr;
         
        
        ContactTriggerHandler contrig = new ContactTriggerHandler();
        ContactTriggerHandler.createContactRole(c,mapcon,true,false,true);
        System.Test.StopTest();
     }
    
    //TestMethod3 will work on updation.Contacttype value is null at the time of insertion.
     static testmethod void testmethod3(){
        
       Account acc = new Account();
        acc.name = 'test';
        acc.Type = 'Customers';
        acc.Industry = 'Airport';
        acc.Job_Type__c ='Public';
        acc.Description ='test destricption';
        acc.Branch__c = 'So Cal';
        acc.Phone = '9876543210';
        insert acc;
        
        Map<Id,Contact> mapcon = new Map<Id,Contact>();
        List<contact> c = new List<contact>();
        Contact con = new Contact();
        con.lastname = 'Contact lastname';
        con.accountId = acc.Id;
        con.Contact_Type__c = 'O&M Billing Contact';
        
        insert con;
         System.Test.StartTest();
         con.Contact_Type__c = '';
         update con;
        c.add(con);
        mapcon.put(con.id,con);

        Opportunity opp = new Opportunity();
        opp.name = 'Test Opportunity';
        opp.accountId = acc.Id;
        opp.StageName = 'Prospecting';
        opp.CloseDate = Date.today()+2;
        opp.Opportunity_Lead_Source__c = 'Affiliate';
        opp.Opportunity_Lead_Source_Specifics__c = 'test';
        opp.accountId = acc.Id;
        insert opp;

        AcctSeed__Project__c projectDummy = new AcctSeed__Project__c();
        projectDummy.Intx_Apps__c = 'test';
        projectDummy.Branch__c = 'San Diego';
        projectDummy.AcctSeed__Opportunity__c = opp.Id;
        insert projectDummy;
   user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];
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
          contr.Regional_Manager_User__c = userid.Id;
        contr.Area_Supervisor__c = userid.id;
        insert contr;
         
        
        ContactTriggerHandler contrig = new ContactTriggerHandler();
        ContactTriggerHandler.createContactRole(c,mapcon,true,false,true);
        System.Test.StopTest();
     }
}