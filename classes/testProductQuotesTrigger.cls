@isTest
private class testProductQuotesTrigger {
    
    
    
    /*
     *  Test methods for ProductQuotesTrigger.trigger, ProductQuotesService.cls, TestReportTrigger.trigger, TestReportService.cls.
     *
     */
    
    // Create test data
    @testSetup static void pqTestData() {
        
        Account acc = new Account(Name = 'pqAccount');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
        
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = acc.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), Financing__c = 'Cash', 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert testOpportunity;
        
        ASeedAccountingSettingsSetupTest.testDataSetup(); 
        
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Account__c = acc.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Branch__c = 'San Diego',PC_Code__c = 10);
        insert testProject;
        
        Request_for_Information_RFI__c issueTracker = new Request_for_Information_RFI__c(ASProject__c = testProject.Id);
        insert issueTracker;
    }
    
    static testMethod void pqTest1() {
        
        Request_for_Information_RFI__c it = [select Id, ASProject__c from Request_for_Information_RFI__c];
        
        Product_Quotes__c pq = new Product_Quotes__c(Issue_Tracker__c = it.Id);
        insert pq;
        pq = [select Id, Issue_Tracker__c, Project__c from Product_Quotes__c];
        system.assertEquals(it.ASProject__c, pq.Project__c);
        
        Test_Report__c tr = new Test_Report__c(Issue_Tracker__c = it.Id);
        insert tr;
        tr = [select Id, Issue_Tracker__c, Project__c from Test_Report__c];
        system.assertEquals(it.ASProject__c, tr.Project__c);
    }
}