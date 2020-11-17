@isTest
private class CasePendingWorkTest {

    @isTest(SeeAllData=true)    
    static void CasePendingWorkTest_V1() {
        id CustomerRecordType  = [select id, DeveloperName from RecordType where SobjectType = 'Account' and DeveloperName = 'Customer' limit 1].id ;
        id ReactiveRecordType  = [select id, DeveloperName from RecordType where SobjectType = 'Case' and DeveloperName = 'Service' limit 1].id ;
        id PR_OMPROJECT  = [select id, DeveloperName from RecordType where SobjectType = 'AcctSeed__Project__c' and DeveloperName = 'O_M_Project' limit 1].id ;
        
        /*
        Account testAccount = new Account();
        testAccount.RecordTypeId = CustomerRecordType ;
        testAccount.Name = '12345-ACCOUNT' ;
        testAccount.Type = 'Customers' ;
        testAccount.Industry = 'Agriculture' ;
        testAccount.Job_Type__c = 'Public' ;
        testAccount.Description = '12345' ;
        //testAccount.Name = 'Silicon Valley' ;
        testAccount.Phone = '12345' ;
        insert testAccount ; 
        
        Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = testAccount.Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
        insert testContact;
        
         //Create Opportunity
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = testAccount.Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                                                            Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Prospecting', Amount = 500000,
                                                            Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), System_Owner__c = testContact.Id, Expected_Rebate__c = 0,
                                                            Proposal_Submitted_Date__c = System.today(), Proposed_System_Size__c = 10000, Utility_Rate__c = 'N/A', Financing__c = 'Cash',
                                                            Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Captive/OnSite').getRecordTypeId());
        insert testOpportunity; 
        
        //Create a Project for this test
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(RecordTypeId = PR_OMPROJECT, Name = '1234 - 2456',AcctSeed__Account__c = testAccount.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Job_Number__c = 'TEST-TEST' , Site_State__c ='T1234-TEST-1234T' ); // , Name = '1234 - 2456',AcctSeed__Account__c = testAccount.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Job_Number__c = 'TEST-TEST' , Site_State__c ='T1234-TEST-1234T'
        //testProject.Site_State__c='MA';
        //testProject.Job_Number__c='99999-9999999';           
        insert testProject; 
        system.debug('testProject.Job_Number__c>> ' + testProject.Job_Number__c);
        */
        AcctSeed__Project__c rcdProject = [select id, AcctSeed__Account__c ,(select id from Contracts__r where Contract_Status__c = 'Active' limit 1)from AcctSeed__Project__c where id = 'a1t340000034Qdj' limit 1];
        
        
        Pending_Work__c rcdPendingWork = new Pending_Work__c();
        rcdPendingWork.Project__c = rcdProject.id ;   
        rcdPendingWork.Status__c = 'Open';
        insert rcdPendingWork ; 
        
        Case rcdCase = new Case();
        rcdCase.AccountId = rcdProject.AcctSeed__Account__c ; //testAccount.id ; 
        rcdCase.RecordTypeId = ReactiveRecordType ; 
        rcdCase.Project__c = rcdProject.id ;   
        rcdCase.Status = 'New' ; 
        rcdCase.Priority = 'Medium' ; 
        rcdCase.Origin = 'Web' ; 
        rcdCase.Reason = 'Other' ;
        //rcdCase.ServiceContract_Case__c = rcdProject.Contracts__r[0].id ;
         rcdCase.Case_Start_Date__c = date.today().adddays(-2);
        insert rcdCase ;
        
        ApexPages.Standardcontroller std = new ApexPages.Standardcontroller( rcdCase );
        CasePendingWork obj = new CasePendingWork(std);
        obj.CreateReactiveService() ; 
        obj.lstPendingWork[0].selected = true ;
        obj.CreateReactiveService() ;   
    }
}