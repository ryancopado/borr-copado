@isTest
private class testServiceVist_ProjectCtlExt {

@testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    }
    
    /*
     *  Test methods for ServiceVisit_ProjectCtlExt.cls
     *
     */
    
    // Create test data
    @testSetup static void svpTestData() {
        
        Account acc = new Account(Name = 'svpAccount');
        insert acc;
        
        Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
        
         user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];
        
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = acc.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), Financing__c = 'Cash', 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert testOpportunity;
        
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Account__c = acc.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Branch__c = 'San Diego',PC_Code__c = 10);
        insert testProject;
        
        Contract cntrct = new Contract(Name = 'nsvContract', AccountId = acc.Id, Type__c = 'Other', ASProject__c = testProject.Id, Contract_Status__c = 'Active',Area_Supervisor__c=userid.id,Regional_Manager_User__c=userid.id);
        insert cntrct;
        
        Map<String, Schema.RecordTypeInfo> rtSVMap = Schema.SObjectType.SV__c.getRecordTypeInfosByName();
        SV__c testSV = new SV__c(Account__c = acc.Id, Project__c = testProject.Id, Contract__c = cntrct.Id, RecordTypeId = rtSVMap.get('Admin Service Visit').getRecordTypeId());
        insert testSV;
    }
    
    static testMethod void svpTest1() {
        SV__c testSV = [select Id from SV__c];
        
        ApexPages.StandardController std = new ApexPages.StandardController(testSV);
        ServiceVisit_ProjectCtlExt ctl = new ServiceVisit_ProjectCtlExt(std);
        
        ctl.getcontracts();
        String selContract = ctl.getselectedContract();
        ctl.projectChanged();
        ctl.setselectedContract(selContract);
        ctl.saveServiceVisit();
    }
}