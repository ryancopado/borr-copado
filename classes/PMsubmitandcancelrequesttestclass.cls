@isTest
public class PMsubmitandcancelrequesttestclass {
    
    //Test class for ProdModellightningcontroller apex class
    
    static testMethod void testMethod1() 
    {
        ASeedAccountingSettingsSetupTest.testDataSetup();
        
         Account acc = new Account(Name = 'nsvAccount');
          insert acc;
      
        
        
         Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
        
        
         Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = acc.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Prospecting', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(),Won_Loss_Explanation__c='test',Tax_Exemption__c='Exempt', Proposal_Submitted_Date__c = System.today(), Financing__c = 'PPA', 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Captive/OnSite').getRecordTypeId());
        insert testOpportunity;
        
        user ur = [select id from user limit 1];
        
         Production_Modeling__c PMtest = new Production_Modeling__c(Name = 'test test',Opportunity__c=testOpportunity.id,Person_Responsible__c=ur.Id,Production_Modeling_Stage__c='Other',Standards__c=acc.Id);
         insert PMtest;
        
         String result = ProdModellightningcontroller.PrdModSubmit(PMtest.id);
        
        
        
      
        
        
    }
    
    static testMethod void testMethod2() 
    {
        ASeedAccountingSettingsSetupTest.testDataSetup();
        
         Account acc = new Account(Name = 'nsvAccount');
          insert acc;
      
        
        
         Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
        
        
         Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = acc.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Prospecting', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(),Won_Loss_Explanation__c='test',Tax_Exemption__c='Exempt', Proposal_Submitted_Date__c = System.today(), Financing__c = 'PPA', 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Captive/OnSite').getRecordTypeId());
        insert testOpportunity;
        
        user ur = [select id from user limit 1];
        
         Production_Modeling__c PMtest = new Production_Modeling__c(Name = 'test test',Opportunity__c=testOpportunity.id,Person_Responsible__c=ur.Id,Production_Modeling_Stage__c='Other',Standards__c=acc.Id,Request_Status__c='Submitted');
         insert PMtest;
        
         String result1 = ProdModellightningcontroller.PrdModCancel(PMtest.id);
        
    
        
      
        
        
    }
    
    
    

}