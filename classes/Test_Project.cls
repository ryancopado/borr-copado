@IsTest
Private Class Test_Project{

    public static testMethod Void TestProjectStatus(){
    
       List<RecordType> ListOfRecordType=[Select r.Description, r.Id, r.Name from RecordType r Where r.Name='Commercial Project'];
         
          
         Account ACC=New Account();
         ACC.Name='TestAccount';
         ACC.Type='Business';
         ACC.Job_Type__c='Commercial';         
         ACC.Branch__c='Berkeley'; 
         ACC.ShippingStreet='x';
         ACC.ShippingCity='x';
         ACC.ShippingState='x';
         ACC.ShippingPostalCode='x';
         ACC.Branch__c='Berkeley';
         ACC.RecordTypeId =  '012300000000ZtU';
                 
         Insert ACC;
         
         Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = ACC.Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
         insert testContact;
         
         Opportunity Opp=new Opportunity();
 
         Opp.Approximate_Install_Date__c=system.now().Date();
         Opp.Rebate_Assigned_To__c=([Select Id from User limit 1][0]).id;
         Opp.Expected_Rebate__c=20;
         Opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
         Opp.Name='Test Opportunity';
         Opp.Job_Type__c ='PV Direct';                                  
         Opp.Accountid =ACC.id;
         
         Opp.StageName='Project Awarded';
         //Opp.ForecastCategory='Commit';
         Opp.Last_Date_Called__c=system.now().Date();
         Opp.Module_Delivery_Date__c =system.now().Date();         
         Opp.Inverter_Delivery_Date__c =system.now().Date();
         Opp.Racking_Delivery_Date__c =system.now().Date();                  
         Opp.CloseDate=system.now().date();                  
         Opp.Type='Turnkey System';
         Opp.Proposal_Submitted_Date__c = system.today();
         Opp.Proposed_System_Size__c = 10000;
         Opp.Expected_Rebate__c = 0;
         Opp.System_Owner__c = testContact.Id;
         Opp.Utility_Rate__c = 'N/A';
         Opp.Amount = 10000;
         Opp.Prevailing_Wage__c = 'No';
         Opp.Original_Contract_System_Size__c = 1000;
         Opp.Financing__c = 'Cash';
         Insert Opp;
                           
         Sfdc_Project__c Project=new Sfdc_Project__c ();
         Project.RecordType=ListOfRecordType[0];
         Project.Opportunity__c=Opp.id;
         Project.Interconnection_Status__c = 'Application Complete';
         Project.Name='Test Project';
         Insert Project;
         
         Project.Interconnection_Status__c = 'Permission to Operate'; 
         Update Project;
         
         Project.Interconnection_Status__c = 'Application Complete';
         Update Project;
         
         Project=new Sfdc_Project__c ();
         Project.RecordType=ListOfRecordType[0];
         Project.Opportunity__c=Opp.id;
         Project.Interconnection_Status__c = 'Permission to Operate';
         Project.Name='Test Project';
         Insert Project;
         
         Project.Interconnection_Status__c = 'Application Complete';
         Update Project;
         
    }
    
    public static testMethod Void TestAssetCreation1(){
        
        List<RecordType> ListOfRecordType=[Select r.Description, r.Id, r.Name from RecordType r Where r.Name='Commercial Project'];
        List<RecordType> ListOfRecordType1=[Select r.Description, r.Id, r.Name from RecordType r Where r.Name='Customer'];
        
        Account ACC=New Account();
        ACC.Name='TestAccount';
        ACC.Type='Business';
        ACC.Job_Type__c='Commercial';         
        ACC.Branch__c='Berkeley';
        ACC.ShippingStreet='x';
        ACC.ShippingCity='x';
        ACC.ShippingState='x';
        ACC.ShippingPostalCode='x';
        ACC.Branch__c='Berkeley';
        ACC.RecordTypeId =  ListOfRecordType1[0].id;
                 
         Insert ACC;
         
         Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = ACC.Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
         insert testContact;
         
         Opportunity Opp=new Opportunity();
 
         Opp.Approximate_Install_Date__c=system.now().Date();
         Opp.Rebate_Assigned_To__c=([Select Id from User limit 1][0]).id;
         Opp.Expected_Rebate__c=20;
         Opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
         Opp.Name='Test Opportunity';
         Opp.Job_Type__c ='PV Direct';                                  
         Opp.Accountid =ACC.id;
         
         Opp.StageName='Project Awarded';
         //Opp.ForecastCategory='Commit';
         Opp.Last_Date_Called__c=system.now().Date();
         Opp.Module_Delivery_Date__c =system.now().Date();         
         Opp.Inverter_Delivery_Date__c =system.now().Date();
         Opp.Racking_Delivery_Date__c =system.now().Date();                  
         Opp.CloseDate=system.now().date();                  
         Opp.Type='Turnkey System';
         Opp.Proposal_Submitted_Date__c = system.today();
         Opp.Proposed_System_Size__c = 10000;
         Opp.Expected_Rebate__c = 0;
         Opp.System_Owner__c = testContact.Id;
         Opp.Utility_Rate__c = 'N/A';
         Opp.Amount = 10000;
         Opp.Prevailing_Wage__c = 'No';
         Opp.Original_Contract_System_Size__c = 1000;
         Opp.Financing__c = 'Cash';
         Insert Opp;
                           
         Sfdc_Project__c Project=new Sfdc_Project__c ();
         Project.RecordType=ListOfRecordType[0];
         Project.Opportunity__c=Opp.id;
         Project.Interconnection_Status__c = 'Application Complete';
         Project.Name='Test Project';
         Insert Project;
         
         
 
         
         Product2 p = new Product2();
         p.Name     = 'TEST';
         insert p;
         
         Asset ASS=new Asset();
         ASS.Auto_Create__c=true;
         ASS .AccountId=ACC.ID;
         ASS.Opportunity__c=Opp.Id;
         ASS.Product2Id=p.id;
         ASS.Name='Test';
         Insert ASS;
    
    }    
    
    public static testMethod Void TestAssetCreation2(){
    
     List<RecordType> ListOfRecordType=[Select r.Description, r.Id, r.Name from RecordType r Where r.Name='Commercial Project'];
            List<RecordType> ListOfRecordType1=[Select r.Description, r.Id, r.Name from RecordType r Where r.Name='Customer'];  
             List<RecordType> ListOfRecordType2=[Select r.Description, r.Id, r.Name from RecordType r Where r.Name='Inverter'];  
    
    
    
    
            Account ACC=New Account();
         ACC.Name='TestAccount';
         ACC.Type='Business';
         ACC.Job_Type__c='Commercial';         
         ACC.Branch__c='Berkeley'; 
         
          ACC.ShippingStreet='x';
          ACC.ShippingCity='x';
          ACC.ShippingState='x';
          ACC.ShippingPostalCode='x';
          ACC.Branch__c='Berkeley';
          ACC.RecordTypeId =  ListOfRecordType1[0].id;
                 
         Insert ACC;
         
         Opportunity Opp=new Opportunity();
 
         Opp.Approximate_Install_Date__c=system.now().Date();
         Opp.Rebate_Assigned_To__c=([Select Id from User limit 1][0]).id;
         Opp.Expected_Rebate__c=20;
         Opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
         Opp.Name='Test Opportunity';
         Opp.Job_Type__c ='PV Direct';                                  
         Opp.Accountid =ACC.id;
         
         Opp.StageName='Contract Signed';
         //Opp.ForecastCategory='Commit';
         Opp.Last_Date_Called__c=system.now().Date();
         Opp.Module_Delivery_Date__c =system.now().Date();         
         Opp.Inverter_Delivery_Date__c =system.now().Date();
         Opp.Racking_Delivery_Date__c =system.now().Date();                  
         Opp.CloseDate=system.now().date();                  
         Opp.Type='Turnkey System';
         Opp.Financing__c = 'Cash';
         Insert Opp;
                           
         Sfdc_Project__c Project=new Sfdc_Project__c ();
         Project.RecordType=ListOfRecordType[0];
         Project.Opportunity__c=Opp.id;
         Project.Interconnection_Status__c = 'Permission To Operate';
         Project.Name='Test Project';
         
         Project.Account__c=ACC.ID;
         Insert Project;
         
         
 
         
         Product2 p = new Product2();
         p.Name     = 'TEST';
         p.recordtypeid=ListOfRecordType2[0].id;
         p.family='Inverter';
         insert p;
         
         Asset ASS=new Asset();
         ASS.Auto_Create__c=false;
         ASS.AccountId=ACC.ID;
         ASS.Opportunity__c=Opp.Id;
         ASS.Product2Id=p.id;
         ASS.Name='Test';
         Insert ASS;
    
    approveELI.IsRecursiveUpdate=false;
    
        Project.Design_Stage__c = 'As Built';
        Project.SFDC_Project_Stage__c = 'Work 90% Completed';
        Update Project;    
    
    
    
       Project=new Sfdc_Project__c ();
         Project.RecordType=ListOfRecordType[0];
         Project.Opportunity__c=Opp.id;
         Project.Interconnection_Status__c = 'Permission To Operate';
         Project.SFDC_Project_Stage__c ='Work 90% Completed';
         Project.Design_Stage__c = 'As Built';
         Project.Name='Test Project';
         Project.Account__c=ACC.ID;
         Insert Project;
             approveELI.IsRecursiveUpdate=TRUE;
    }  
    
    public static testMethod Void TestOppSiteLayout(){
    
       List<RecordType> ListOfRecordType=[Select r.Description, r.Id, r.Name from RecordType r Where r.Name='Standalone Storage'];
         
          
         Account ACC=New Account();
         ACC.Name='TestAccount';
         ACC.Type='Business';
         ACC.Job_Type__c='Commercial';         
         ACC.Branch__c='Berkeley'; 
         ACC.ShippingStreet='x';
         ACC.ShippingCity='x';
         ACC.ShippingState='x';
         ACC.ShippingPostalCode='x';
         ACC.Branch__c='Berkeley';
         ACC.RecordTypeId =  '012300000000ZtU';
                 
         Insert ACC;
         
         Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = ACC.Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
         insert testContact;
         
         Opportunity Opp=new Opportunity();
 
         Opp.Approximate_Install_Date__c=system.now().Date();
         Opp.Rebate_Assigned_To__c=([Select Id from User limit 1][0]).id;
         Opp.Expected_Rebate__c=20;
         Opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standalone Storage').getRecordTypeId();
         Opp.Name='Test Opportunity';
         Opp.Job_Type__c ='PV Direct';                                  
         Opp.Accountid =ACC.id;
         
         Opp.StageName='Project Awarded';
         //Opp.ForecastCategory='Commit';
         Opp.Last_Date_Called__c=system.now().Date();
         Opp.Module_Delivery_Date__c =system.now().Date();         
         Opp.Inverter_Delivery_Date__c =system.now().Date();
         Opp.Racking_Delivery_Date__c =system.now().Date();                  
         Opp.CloseDate=system.now().date();                  
         Opp.Type='Turnkey System';
         opp.ESS_Energy_kWh__c = 100;
         opp.Vertical__c = 'a382H000001SkGzQAK';
         Opp.Proposal_Submitted_Date__c = system.today();
         Opp.Proposed_System_Size__c = 10000;
         Opp.Expected_Rebate__c = 0;
         Opp.System_Owner__c = testContact.Id;
         Opp.Utility_Rate__c = 'N/A';
         Opp.Amount = 10000;
         Opp.Prevailing_Wage__c = 'No';
         Opp.Original_Contract_System_Size__c = 1000;
         Opp.Financing__c = 'Cash';
         Insert Opp;
                           
         Sfdc_Project__c Project=new Sfdc_Project__c ();
         Project.RecordType=ListOfRecordType[0];
         Project.Opportunity__c=Opp.id;
         Project.Interconnection_Status__c = 'Application Complete';
         Project.Name='Test Project';
         Insert Project;
         
         Project.Interconnection_Status__c = 'Permission to Operate'; 
         Update Project;
         
         //Project.Interconnection_Status__c = 'Application Complete';
         //Update Project;
         
         Project=new Sfdc_Project__c ();
         Project.RecordType=ListOfRecordType[0];
         Project.Opportunity__c=Opp.id;
         Project.Interconnection_Status__c = 'Permission to Operate';
         Project.Name='Test Project';
     //    Insert Project;
        
        
                List<AcctSeed__Project__c> pList = new List<AcctSeed__Project__c>();
        pList = TestMethods.getProjectList();
        
        //        List<opportunity> opplist = new list<opportunity>();
      //  opplist = testmethods.getOpportunity();
        
        List<Site__c> sList = new List<Site__c>();
        sList.add(new Site__c(
            Name = '123 Main Street',
            Project__c = pList[0].Id,
            opportunity__c = opp.id
            )
        );
        sList.add(new Site__c(
            Name = '456 Main Street',
            Project__c = pList[0].Id,
            opportunity__c = opp.id
            )
        );
        insert sList;
        
        List<Project_Products__c> ppList = new List<Project_Products__c>();
        ppList.add(new Project_Products__c(Project__c = pList[0].Id, Site__c = sList[0].Id));
      //  ppList.add(new Project_Products__c(Project__c = pList[0].Id, Site__c = sList[1].Id));
        insert ppList;
        
        //Instantiate a new controller
        ApexPages.StandardController std = new ApexPages.StandardController(opp);
        OpportunityDev_SiteControllerExt ctl = new OpportunityDev_SiteControllerExt(std);
        
        ctl.setselectedTab('456 Main Street');
        ctl.getselectedTab();
        ctl.settabsMaxString('2');
        ctl.refreshPage();
        ctl.gettabsMaxString();
        ctl.getsitesColumns();
        ctl.cloneSite();
        ctl.saveAllSites();
        ctl.editAllSites();
        ctl.cancelAllSites();
        ctl.editAllSites();
        ctl.saveAllSites();
        ctl.plusTabName = '+';
        ctl.setplusTab();
         
        
         
    }
    
    
    public static testMethod Void TestSiteController() {
        
        List<AcctSeed__Project__c> pList = new List<AcctSeed__Project__c>();
        pList = TestMethods.getProjectList();
        
        List<Site__c> sList = new List<Site__c>();
        sList.add(new Site__c(
            Name = '123 Main Street',
            Project__c = pList[0].Id)
        );
        sList.add(new Site__c(
            Name = '456 Main Street',
            Project__c = pList[0].Id)
        );
        insert sList;
        
        List<Project_Products__c> ppList = new List<Project_Products__c>();
        ppList.add(new Project_Products__c(Project__c = pList[0].Id, Site__c = sList[0].Id));
        ppList.add(new Project_Products__c(Project__c = pList[0].Id, Site__c = sList[1].Id));
        insert ppList;
        
        //Instantiate a new controller
        ApexPages.StandardController std = new ApexPages.StandardController(pList[0]);
        Project_SiteControllerExt ctl = new Project_SiteControllerExt(std);
        
        ctl.setselectedTab('456 Main Street');
        ctl.getselectedTab();
        ctl.settabsMaxString('2');
        ctl.refreshPage();
        ctl.gettabsMaxString();
        ctl.getsitesColumns();
        ctl.cloneSite();
        ctl.saveAllSites();
        ctl.editAllSites();
        ctl.cancelAllSites();
        ctl.editAllSites();
        ctl.saveAllSites();
        ctl.plusTabName = '+';
        ctl.setplusTab();
    }
}