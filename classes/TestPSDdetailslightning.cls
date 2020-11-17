@isTest(seealldata=true)
public class TestPSDdetailslightning {
    
     static testMethod void testMethod1() 
    {
        
         
        
          Account acc = new Account(Name = 'nsvAccount');
          insert acc;
      
        
        Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
       
      
        opportunity testOpportunity=[select id from opportunity where StageName='Qualified' limit 1];
        
        user userid = [select id from user where isactive=true limit 1];
        
        PSD__c testpsd=new PSD__c(Opportunity__c=testOpportunity.id,Site_Address2__c='test',Which_AC_Rating_is_Required__c='AC',Application_Engineer__c=userid.Id);
        insert testpsd;
        
        PSD_Revision__c testpsr=new PSD_Revision__c(Name='test revision',Pre_Sales_Design__c=testpsd.id,Proposal_Level_Needed__c='L1',Reason_for_modifiction__c='First Draft',Due_Date__c=System.today(),Priority__c='Normal');
        insert testpsr;
        
        List<PSD_Revision__c> result = PSDdetailslightning.Oppdisplay(testOpportunity.id);
        
        
        
        


}
}