@isTest(seealldata=True)
public class UpdateBillingdatesTestClass 
{
  /*   @testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    } */
    
    
 {
 
  //ASeedAccountingSettingsSetupTest.testDataSetup();
  
  
 test.starttest();
     AcctSeed__Billing__c[] billings = new List <AcctSeed__Billing__c> ();
     billings.add(
     new AcctSeed__Billing__c(
        AcctSeed__Billing_Cycle_Start_Date__c = System.today(),
        AcctSeed__Billing_Cycle_End_Date__c = System.today() + 30,
        AcctSeed__Date__c = System.today(),
        AcctSeed__Customer__c = '0013400001KBNN4', //[select id from Account Limit 1].id,//'0013400001KBNN4',
        AcctSeed__Status__c = 'Approved',
        AcctSeed__Accounting_Period__c='a1M2H00000Dn181',
        AcctSeed__Due_Date2__c = System.today() + 30,
        Service_Contract__c='80034000002EC1M',//[select id from contract Limit 1].id,//80034000002EC1M
        AcctSeed__Recurring_Billing__c=[select Id from AcctSeed__Recurring_Billing__c where AcctSeed__Billing_Frequency__c='Quarterly in Arrears' limit 1].Id //'a3234000003LIVq'
    )
);


insert billings;

AcctSeed__Billing_Line__c[] bLines = new List <AcctSeed__Billing_Line__c> ();
for (AcctSeed__Billing__c bill : billings) {
    AcctSeed__Billing_Line__c objBillingLine = new AcctSeed__Billing_Line__c();
    objBillingLine.AcctSeed__Billing__c = bill.id;
    objBillingLine.AcctSeed__Date__c = System.today();
    //objBillingLine.AcctSeed__Last_Billing_Date__c = Date.newinstance(2018, 11, 08);
    objBillingLine.AcctSeed__Rate__c = 25;
    objBillingLine.AcctSeed__Hours_Units__c = 1;
    objBillingLine.AcctSeed__Project__c=[select id from AcctSeed__Project__c Limit 1].Id;
    
    bLines.add(objBillingLine);

 
}

  insert bLines;

   AcctSeed.PostResult[] postResults = AcctSeed.BillingPostService.postBillings(billings);
 test.stoptest();
 }

////
static testMethod void testMethod2() {
test.starttest();
 AcctSeed__Billing__c[] billings1 = new List <AcctSeed__Billing__c> ();
billings1.add(
    new AcctSeed__Billing__c(
        AcctSeed__Billing_Cycle_Start_Date__c = System.today(),
        AcctSeed__Billing_Cycle_End_Date__c = System.today() + 30,
        AcctSeed__Date__c = System.today(),
        AcctSeed__Customer__c = [select Id from account limit 1].Id, // '0013400001MvI72',
        AcctSeed__Status__c = 'Approved',
        AcctSeed__Due_Date2__c = System.today() + 30,
        AcctSeed__Accounting_Period__c='a1M2H00000Dn181',
        Service_Contract__c= '80034000002EC1M', //[select id from contract Limit 1].id,'80034000001zvoI',
        AcctSeed__Recurring_Billing__c=[select Id from AcctSeed__Recurring_Billing__c where AcctSeed__Billing_Frequency__c='lump sum' order by id desc limit 1].Id //'a3234000003YJOU'
    )
);

insert billings1;
system.debug('Lump Look here' + billings1);

AcctSeed__Billing_Line__c[] bLines1 = new List <AcctSeed__Billing_Line__c> ();
for (AcctSeed__Billing__c bill1 : billings1) {
    AcctSeed__Billing_Line__c objBillingLine = new AcctSeed__Billing_Line__c();
    objBillingLine.AcctSeed__Billing__c = bill1.id;
    objBillingLine.AcctSeed__Date__c = System.today();
    //objBillingLine.AcctSeed__Last_Billing_Date__c = Date.newinstance(2018, 11, 08);
    objBillingLine.AcctSeed__Rate__c = 25;
    objBillingLine.AcctSeed__Hours_Units__c = 1;
    objBillingLine.AcctSeed__Project__c=[select id from AcctSeed__Project__c Limit 1].Id;
    
    bLines1.add(objBillingLine);

  }

insert bLines1;

    
   AcctSeed.PostResult[] postResults1 = AcctSeed.BillingPostService.postBillings(billings1);
   test.stoptest();
   }
////

static testMethod void testMethod3() {
test.starttest();

AcctSeed__Billing__c[] billings2 = new List <AcctSeed__Billing__c> ();
billings2.add(
    new AcctSeed__Billing__c(
        AcctSeed__Billing_Cycle_Start_Date__c = System.today(),
        AcctSeed__Billing_Cycle_End_Date__c = System.today() + 30,
        AcctSeed__Date__c = System.today(),
        AcctSeed__Customer__c =[select Id from account limit 1].Id,
        AcctSeed__Status__c = 'Approved',
        AcctSeed__Accounting_Period__c='a1M2H00000Dn181',
        AcctSeed__Due_Date2__c = System.today() + 30,
        Service_Contract__c='80034000002EC1M', //[select id from contract Limit 1].id,'800340000026esN',
        AcctSeed__Recurring_Billing__c=[select Id from AcctSeed__Recurring_Billing__c where AcctSeed__Billing_Frequency__c='Annual in Advance' limit 1].Id)
);


insert billings2;

AcctSeed__Billing_Line__c[] bLines2 = new List <AcctSeed__Billing_Line__c> ();
for (AcctSeed__Billing__c bill2 : billings2) {
    AcctSeed__Billing_Line__c objBillingLine2 = new AcctSeed__Billing_Line__c();
    objBillingLine2.AcctSeed__Billing__c = bill2.id;
    objBillingLine2.AcctSeed__Date__c = System.today();
    objBillingLine2.AcctSeed__Rate__c = 25;
    objBillingLine2.AcctSeed__Hours_Units__c = 1;
    objBillingLine2.AcctSeed__Project__c=[select id from AcctSeed__Project__c Limit 1].Id;
    
    bLines2.add(objBillingLine2);

}

insert bLines2;

    
   AcctSeed.PostResult[] postResults2 = AcctSeed.BillingPostService.postBillings(billings2);
     
  test.stoptest();   
  }
    
     
static testMethod void testMethod4() {
test.starttest();

AcctSeed__Billing__c[] billings3 = new List <AcctSeed__Billing__c> ();
billings3.add(
    new AcctSeed__Billing__c(
        AcctSeed__Billing_Cycle_Start_Date__c = System.today(),
        AcctSeed__Billing_Cycle_End_Date__c = System.today() + 30,
        AcctSeed__Date__c = System.today(),
        AcctSeed__Customer__c = [select Id from account limit 1].Id,
        AcctSeed__Status__c = 'Approved',
        AcctSeed__Accounting_Period__c='a1M2H00000Dn181',
        AcctSeed__Due_Date2__c = System.today() + 30,
        Service_Contract__c='80034000002EC1M', //'[select id from contract Limit 1].id, '80080000000pMWSAA2',
        AcctSeed__Recurring_Billing__c= [select Id from AcctSeed__Recurring_Billing__c where AcctSeed__Billing_Frequency__c='Mid Semi-Annual' limit 1].Id //'a3234000003D5lP'
    )
);


insert billings3;

AcctSeed__Billing_Line__c[] bLines3 = new List <AcctSeed__Billing_Line__c> ();
for (AcctSeed__Billing__c bill3 : billings3) {
    AcctSeed__Billing_Line__c objBillingLine3 = new AcctSeed__Billing_Line__c();
    objBillingLine3.AcctSeed__Billing__c = bill3.id;
    objBillingLine3.AcctSeed__Date__c = System.today();
    objBillingLine3.AcctSeed__Rate__c = 25;
    objBillingLine3.AcctSeed__Hours_Units__c = 1;
    objBillingLine3.AcctSeed__Project__c=[select id from AcctSeed__Project__c Limit 1].Id;
    
    bLines3.add(objBillingLine3);

}

insert bLines3;

    
   AcctSeed.PostResult[] postResults3 = AcctSeed.BillingPostService.postBillings(billings3);
     
  test.stoptest();   
  }
  
  static testMethod void testMethod5() 
 {
 
  //ASeedAccountingSettingsSetupTest.testDataSetup();
  
  
 test.starttest();
     AcctSeed__Billing__c[] billings = new List <AcctSeed__Billing__c> ();
     billings.add(
     new AcctSeed__Billing__c(
        AcctSeed__Billing_Cycle_Start_Date__c = System.today(),
        AcctSeed__Billing_Cycle_End_Date__c = System.today() + 30,
        AcctSeed__Date__c = Date.newinstance(2025, 12, 31),
        AcctSeed__Customer__c ='0013400001KBNN4', // [select Id from account limit 1].Id,
        AcctSeed__Status__c = 'Approved',
         AcctSeed__Accounting_Period__c='a1M2H00000Dn181',
        AcctSeed__Due_Date2__c = System.today() + 30,
        Service_Contract__c='80034000002EC1M', // [select id from contract Limit 1].id, '80034000002EC1M',
        AcctSeed__Recurring_Billing__c='a3234000003LIVq' //[select Id from AcctSeed__Recurring_Billing__c where AcctSeed__Billing_Frequency__c='Quarterly in Advance' limit 1].Id //'a3234000003LIVq'
    )
);


insert billings;

AcctSeed__Billing_Line__c[] bLines = new List <AcctSeed__Billing_Line__c> ();
for (AcctSeed__Billing__c bill : billings) {
    AcctSeed__Billing_Line__c objBillingLine = new AcctSeed__Billing_Line__c();
    objBillingLine.AcctSeed__Billing__c = bill.id;
    objBillingLine.AcctSeed__Date__c = System.today();
    //objBillingLine.AcctSeed__Last_Billing_Date__c = Date.newinstance(2018, 11, 08);
    objBillingLine.AcctSeed__Rate__c = 25;
    objBillingLine.AcctSeed__Hours_Units__c = 1;
    objBillingLine.AcctSeed__Project__c=[select id from AcctSeed__Project__c Limit 1].Id;
    
    bLines.add(objBillingLine);

 
}

  insert bLines;

   AcctSeed.PostResult[] postResults = AcctSeed.BillingPostService.postBillings(billings);
 test.stoptest();
 }
     
  static testMethod void testMethod6() 
 {
 
  //ASeedAccountingSettingsSetupTest.testDataSetup();
  
  
 test.starttest();
     AcctSeed__Billing__c[] billings = new List <AcctSeed__Billing__c> ();
     billings.add(
     new AcctSeed__Billing__c(
        AcctSeed__Billing_Cycle_Start_Date__c = System.today(),
        AcctSeed__Billing_Cycle_End_Date__c = System.today() + 30,
        AcctSeed__Date__c = Date.newinstance(2025, 09, 30),
        AcctSeed__Customer__c = '0013400001KBNN4', //[select Id from account limit 1].Id,
        AcctSeed__Status__c = 'Approved',
         AcctSeed__Accounting_Period__c='a1M2H00000Dn181',
        AcctSeed__Due_Date2__c = System.today() + 30,
        Service_Contract__c='80034000002EC1M', //[select id from contract Limit 1].id, '80034000002EC1M',
        AcctSeed__Recurring_Billing__c='a3234000003LIVq' //[select Id from AcctSeed__Recurring_Billing__c where AcctSeed__Billing_Frequency__c='Quarterly in Arrears Equal Installments' limit 1].Id //'a3234000003LIVq'
    )
);


insert billings;

AcctSeed__Billing_Line__c[] bLines = new List <AcctSeed__Billing_Line__c> ();
for (AcctSeed__Billing__c bill : billings) {
    AcctSeed__Billing_Line__c objBillingLine = new AcctSeed__Billing_Line__c();
    objBillingLine.AcctSeed__Billing__c = bill.id;
    objBillingLine.AcctSeed__Date__c = System.today();
    //objBillingLine.AcctSeed__Last_Billing_Date__c = Date.newinstance(2018, 11, 08);
    objBillingLine.AcctSeed__Rate__c = 25;
    objBillingLine.AcctSeed__Hours_Units__c = 1;
    objBillingLine.AcctSeed__Project__c=[select id from AcctSeed__Project__c Limit 1].Id;
    
    bLines.add(objBillingLine);

 
}

  insert bLines;

   AcctSeed.PostResult[] postResults = AcctSeed.BillingPostService.postBillings(billings);
 test.stoptest();
 }
 
 static testMethod void testMethod7() {
test.starttest();

AcctSeed__Billing__c[] billings3 = new List <AcctSeed__Billing__c> ();
billings3.add(
    new AcctSeed__Billing__c(
        AcctSeed__Billing_Cycle_Start_Date__c = System.today(),
        AcctSeed__Billing_Cycle_End_Date__c = System.today() + 30,
        AcctSeed__Date__c = System.today(),
        AcctSeed__Customer__c = [select Id from account limit 1].Id,
        AcctSeed__Status__c = 'Approved',
        AcctSeed__Accounting_Period__c='a1M2H00000Dn181',
        AcctSeed__Due_Date2__c = System.today() + 30,
        Service_Contract__c='80034000002EC1M', // [select id from contract Limit 1].id, '8001g0000001AuL',
        AcctSeed__Recurring_Billing__c= [select Id from AcctSeed__Recurring_Billing__c where AcctSeed__Billing_Frequency__c='Monthly in Advance' limit 1].Id //'a3234000003D5lP'
        
    )
);


insert billings3;
system.debug('Monthly Look here' + billings3);

AcctSeed__Billing_Line__c[] bLines3 = new List <AcctSeed__Billing_Line__c> ();
for (AcctSeed__Billing__c bill3 : billings3) {
    AcctSeed__Billing_Line__c objBillingLine3 = new AcctSeed__Billing_Line__c();
    objBillingLine3.AcctSeed__Billing__c = bill3.id;
    objBillingLine3.AcctSeed__Date__c = System.today();
    objBillingLine3.AcctSeed__Rate__c = 25;
    objBillingLine3.AcctSeed__Hours_Units__c = 1;
    objBillingLine3.AcctSeed__Project__c=[select id from AcctSeed__Project__c Limit 1].Id;
    
    bLines3.add(objBillingLine3);

}

insert bLines3;

    
   AcctSeed.PostResult[] postResults3 = AcctSeed.BillingPostService.postBillings(billings3);
     
  test.stoptest();   
  }
  static testMethod void testMethod8() {
test.starttest();

AcctSeed__Billing__c[] billings3 = new List <AcctSeed__Billing__c> ();
billings3.add(
    new AcctSeed__Billing__c(
        AcctSeed__Billing_Cycle_Start_Date__c = System.today(),
        AcctSeed__Billing_Cycle_End_Date__c = System.today() + 30,
        AcctSeed__Date__c = System.today(),
        AcctSeed__Customer__c = [select Id from account limit 1].Id,
        AcctSeed__Status__c = 'Approved',
        AcctSeed__Accounting_Period__c='a1M2H00000Dn181',
        AcctSeed__Due_Date2__c = System.today() + 30,
        Service_Contract__c= '80034000002EC1M', //[select id from contract Limit 1].id, '800340000026guJ',
        AcctSeed__Recurring_Billing__c= [select Id from AcctSeed__Recurring_Billing__c where AcctSeed__Billing_Frequency__c='Semi-Annual In Advance' limit 1].Id //'a3234000003D5lP'
    )
);


insert billings3;

AcctSeed__Billing_Line__c[] bLines3 = new List <AcctSeed__Billing_Line__c> ();
for (AcctSeed__Billing__c bill3 : billings3) {
    AcctSeed__Billing_Line__c objBillingLine3 = new AcctSeed__Billing_Line__c();
    objBillingLine3.AcctSeed__Billing__c = bill3.id;
    objBillingLine3.AcctSeed__Date__c = System.today();
    objBillingLine3.AcctSeed__Rate__c = 25;
    objBillingLine3.AcctSeed__Hours_Units__c = 1;
    objBillingLine3.AcctSeed__Project__c=[select id from AcctSeed__Project__c Limit 1].Id;
    
    bLines3.add(objBillingLine3);

}

insert bLines3;

    
   AcctSeed.PostResult[] postResults3 = AcctSeed.BillingPostService.postBillings(billings3);
     
  test.stoptest();   
  }
  
 
        }