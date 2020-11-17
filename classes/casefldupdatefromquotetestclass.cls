@istest
public class casefldupdatefromquotetestclass {

    
    /* this is test class for casefldupdatefromquote apex class */
    
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
            O_M_Issue_Tracking__c = 'Reactive');
        insert testCase;
        
        
       SBQQ__Quote__c quotelist = new SBQQ__Quote__c(
            SBQQ__SalesRep__c = system.UserInfo.getUserId(),
        	SBQQ__PrimaryContact__c = con.Id,
            SBQQ__Primary__c = TRUE,
            Estimated_Start_Date__c = date.today(),
            Billing_State_Tax__c     = 'MA',
            SBQQ__Status__c = 'Approved',
            SBQQ__Type__c = 'Quote',
            Case__c = testCase.Id);

            insert quotelist;
            
            //update the status
            quotelist.SBQQ__Status__c  = 'Accepted';
            update quotelist;

            //check if case has been updated or not
            System.assertEquals(true, [SELECT Quote_Accepted__c FROM Case WHERE Id =:testCase.Id].Quote_Accepted__c);

            //update the status
            quotelist.SBQQ__Status__c  = 'Proposal Sent';
            update quotelist;

            //check if case has been updated or not
            System.assertEquals(false, [SELECT Quote_Accepted__c FROM Case WHERE Id =:testCase.Id].Quote_Accepted__c);

        }  
    
     
    
}