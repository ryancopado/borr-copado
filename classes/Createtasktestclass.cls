@isTest(seealldata=true)
public class Createtasktestclass {
    static testMethod void testMethod1() 
    {
        
        Account ac= new Account();
        ac.Name='test acc';
        ac.Branch__c='Midwest';
        //ac.Phone='(415)-368-5722';
        ac.Type='Customers';
        ac.Industry='Office/Business Service';
        ac.Job_Type__c='None';
        ac.Description='Test';
        Insert ac;
        
        Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = ac.Id);
        insert con;
        
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = ac.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), Financing__c = 'Cash', SalesOps_Qualified__c=True,
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert testOpportunity;
        
        ac.Procurement_Phase__c='b. Investigating';
        update ac;
    }
}