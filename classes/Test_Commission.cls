/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Test_Commission {

    /*static testMethod void Test_NewCommission() {
        
        List<RecordType> ListOfRecordType=new List<RecordType>();
        List<Opportunity> ListOfOpportunity=new List<Opportunity>();        
        
        ListOfRecordType=[Select ID From RecordType where Name='Affiliates'];
        
        ListOfOpportunity=[Select ID From Opportunity where StageName = 'Contract Signed' Limit 10];
        
        Commission__c Commission=new Commission__c();
          
        User other = [select Id from User where Name = 'Michael Hall']; 
          
        Commission.User__c = other.Id;
        Commission.Percent__c = 3;
        
       
               
        If (ListOfRecordTYPE.Size()>0)
            Commission.RecordTypeId=ListOfRecordType[0].ID;
            
        If (ListOfOpportunity.Size()>0)
            Commission.Opportunity__c=ListOfOpportunity[0].ID;
            
         system.debug('*****Test_NewCommission size of oppList = ' + ListOfOpportunity.size());
         insert Commission;    
        
        ApexPages.StandardController Controller=new ApexPages.StandardController(Commission);

        NewCommission NewCommission =new NewCommission (Controller);        
        
        NewCommission.CheckCommissionRecordType();
        
        Commission=new Commission__c();
        
               
       If (ListOfOpportunity.Size()>0)
            Commission.Opportunity__c=ListOfOpportunity[0].ID;
            
            
          Controller=new ApexPages.StandardController(Commission);

          NewCommission =new NewCommission (Controller);        
        
        NewCommission.CheckCommissionRecordType();
    }
    
     static testMethod void Test_EditCommission() {
        
        List<RecordType> ListOfRecordType=new List<RecordType>();
        List<Opportunity> ListOfOpportunity=new List<Opportunity>();                
        ListOfRecordType=[Select ID From RecordType where Name='Affiliates'];
         
        Commission__c Commission=new Commission__c();
          
        ListOfOpportunity=[Select ID From Opportunity where StageName = 'Contract Signed' Limit 10];          
        User other = [select Id from User where Name = 'Michael Hall']; 
          
        Commission.User__c = other.Id;
        Commission.Percent__c = 3;
        
        If (ListOfOpportunity.Size()>0)
            Commission.Opportunity__c=ListOfOpportunity[0].ID;
            
        If (ListOfRecordTYPE.Size()>0)
            Commission.RecordTypeId=ListOfRecordType[0].ID;
        
        system.debug('*****Test_EditCommission size of oppList = ' + ListOfOpportunity.size());
        insert Commission;
        
        List<Commission__c> ListOfCommission=new List<Commission__C>();
        
        ListOfCommission=[Select ID From Commission__c where RecordType.Name='Affiliates' Limit 10];
        
        If (ListOfCommission.Size()>0)
            Commission=ListOfCommission[0];
        
        ApexPages.StandardController Controller=new ApexPages.StandardController(Commission);

        EditCommission EditCommission =new EditCommission (Controller);        
        
        EditCommission.CheckCommissionRecordType();
        
        
        ListOfCommission=[Select ID From Commission__c where RecordType.Name<>'Affiliates' Limit 10];
        
        If (ListOfCommission.Size()>0)
            Commission=ListOfCommission[0];
        
         Controller=new ApexPages.StandardController(Commission);

          EditCommission =new EditCommission (Controller);        
        
        EditCommission.CheckCommissionRecordType();
        
       }*/
}