@isTest
public class TestQuoteattached {
    
    static testMethod void testMethod1() {
        
        Account acc = new Account(Name = 'nsvAccount');
        insert acc;
    
        Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
   
        Case testCase = new Case(
            Subject = 'This is a test case',
            Description = 'This is the description field',
            AccountId = acc.Id,
            ContactId = con.Id,
            Branch__c = 'San Diego',
            Origin = 'Web',
            Component__c = 'Inverter',
            Reason = 'System Down',
            Production_Effected__c = 'Yes',
            Days_Inverter_Down__c = 1,
         //   userIdEmailSelected__c = system.UserInfo.getUserId(),
         //   otherEmailSelected__c = 'testtest@test.com.training',
            O_M_Issue_Tracking__c = 'Reactive');
        insert testCase;
        
        
        List<SBQQ__Quote__c> quotelist = new List<SBQQ__Quote__c>();
        quotelist.add  (
            new SBQQ__Quote__c(
            SBQQ__SalesRep__c = system.UserInfo.getUserId(),
        	SBQQ__PrimaryContact__c = con.Id,
            Estimated_Start_Date__c = date.today(),
            Billing_State_Tax__c     = 'MA',
            SBQQ__Status__c = 'Draft',
            SBQQ__Type__c = 'Quote',
            Case__c = testCase.Id)
           );
        quotelist.add  (
            new SBQQ__Quote__c(
            SBQQ__SalesRep__c = system.UserInfo.getUserId(),
        	SBQQ__PrimaryContact__c = con.Id,
            Estimated_Start_Date__c = date.today(),
            Billing_State_Tax__c     = 'ME',
            SBQQ__Status__c = 'Draft',
            SBQQ__Type__c = 'Quote',
            Case__c = testCase.Id)
           );
            insert quotelist; 
        
        
        
        delete quotelist[0];
    }

}