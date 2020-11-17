@isTest 
public class ContactRollupCountTest
{
    static testMethod void testMethod1() 
    {
        
        Account acc = new Account();
        acc.Name ='Name';
        acc.Small_Business_Type__c='HUBZone';
        acc.Branch__c='Boston';
        acc.Type='Architect';
        acc.Description='Test desc';
        insert acc;
        
        Contact con=new Contact();
        con.Lastname='Test name';
        con.accountid=acc.id;
        insert con;
       
        opportunity opp= new Opportunity();
        opp.Name= 'Test opp';
        opp.closedate=date.today();
        opp.Stagename='Prospecting';
        opp.amount=100;
        opp.Accountid=acc.id;
        opp.Opportunity_Lead_Source__c='Affiliate';
        opp.Opportunity_Lead_Source_Specifics__c='Test desc';
        opp.Utility_Company__c='SCE';
        opp.Utility_Zone__c='A';
        opp.Estimated_PB3_Submission_Date__c=date.today();
        
        insert opp;
        
        Opportunitycontactrole ocr=new Opportunitycontactrole();
        ocr.Contactid=con.id;
        ocr.OpportunityId= opp.id;
        ocr.Role='Influencer';
        insert ocr;
        
        
        Test.startTest();

            ContactRollupCount obj = new ContactRollupCount();
            DataBase.executeBatch(obj); 
            ContactRollupCountscheduler sh1 = new ContactRollupCountscheduler();

            String sch = '0 0 23 * * ?'; 
            system.schedule('Test Check', sch, sh1); 

            
        Test.stopTest();
    }
}