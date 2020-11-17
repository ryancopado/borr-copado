@isTest(seealldata=TRUE) 
public class Testrecurringbillinglistview
{
 static testMethod void testMethod1() 
 {
   AcctSeed__Recurring_Billing__c[] Rbillings = new List <AcctSeed__Recurring_Billing__c> ();
     Rbillings.add(
     new AcctSeed__Recurring_Billing__c(
        Name = 'test 1',
        AcctSeed__Customer__c = '0018000000xpgUZ',
        AcctSeed__Status__c= 'Active',
        Service_Contract__c='80034000001FWQk',
       
        AcctSeed__Billing_Frequency__c= 'Monthly in Advance',
        AcctSeed__Next_Billing_Date__c=Date.newinstance(2018, 11, 08)
    )
);

insert Rbillings;
  Test.startTest();
  Test.setCurrentPage(Page.createbilling);
  ApexPages.StandardSetController stdSetController= new ApexPages.StandardSetController(Rbillings);
  stdSetController.setSelected(Rbillings);
  
  recurringbillinglistview_createbilling ext = new recurringbillinglistview_createbilling(stdSetController);
  
  
 
  
  
 Test.stopTest();
 }
 
 static testMethod void testMethod2()
 {
 AcctSeed__Recurring_Billing__c Rbillings = new  AcctSeed__Recurring_Billing__c ();
     Rbillings.Name = 'test 1';
       Rbillings.AcctSeed__Customer__c = '0018000000xpgUZ';
        Rbillings.AcctSeed__Status__c= 'Active';
        Rbillings.Service_Contract__c='80034000001FWQk';
       
        Rbillings.AcctSeed__Billing_Frequency__c= 'Monthly in Advance';
        Rbillings.AcctSeed__Next_Billing_Date__c=Date.newinstance(2018, 11, 08);

insert Rbillings;
system.debug('RB' +Rbillings);


Test.StartTest(); 
  ApexPages.StandardController sc = new ApexPages.standardController(Rbillings);
  recurringbillinglistview_createbilling testAccPlan = new recurringbillinglistview_createbilling(sc);

  PageReference pageRef = Page.createbilling;
   // Add your VF page Name here
  //pageRef.getParameters().put('id','a3234000004654G');
  Test.setCurrentPage(pageRef);
  testAccPlan.RBId='a3234000004654G';
  testAccPlan.RBSC='80034000002LoiF';
  testAccPlan.RBName='0013400001KBNN4';

   testAccPlan .processSelected();
 Test.StopTest();
 }
 }