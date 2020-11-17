@isTest(SeeAllData=true)
public class quoteTriggerTest {
   static testMethod void insertApprovedQuote() {
       Id devRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor- Material').getRecordTypeId();
       Id caseRecordType = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Reactive').getRecordTypeId();
       Id projectTaskRecordType = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId();
      
       Account a = new Account();
       a.Name = 'this is my test account';
       a.AcctSeed__Accounting_Type__c = 'Customer and Vendor';
       a.RecordTypeId = devRecordTypeId;
       insert a;
       
       Account testaccount = new Account();
       testaccount.Name = 'this has no record type';
       testaccount.AcctSeed__Accounting_Type__c = 'Vendor';
       insert testaccount;

       Contact c = new Contact();
       c.FirstName = 'Test';
       c.LastName = 'Test';
       c.AccountId = testaccount.id;
       c.Phone = '11111111';
       insert c;
       
       Cost_Code__c cc = new Cost_Code__c();
       cc.Active__c = true;
       cc.Old__c = false;
       cc.Number__c = '11111111';
       insert cc;
       
       AcctSeed__Project__c p = new AcctSeed__Project__c();
       p.Account__c = a.id;
       insert p;
       
       AcctSeed__Project_Task__c pt = new AcctSeed__Project_Task__c();
       pt.RecordTypeId = projectTaskRecordType;
       pt.AcctSeed__Project__c = p.id;
       pt.Cost_Code__c = cc.id;
       pt.Not_In_Rollup__c = false;
       insert pt;
       
       AcctSeedERP__Sales_Order__c so = new AcctSeedERP__Sales_Order__c();
       so.Project__c = p.id;
       so.AcctSeedERP__Customer__c = a.id;
       insert so;
       
       Case newCase = new Case();
       //case.recordtypeId = caseRecordType;
       newCase.RecordTypeId = caseRecordType;
       newCase.AccountId = testaccount.id;
       newCase.Status = 'Active';
       newCase.Priority = 'High';
       //newCase.Project__c = 
       newCase.Case_Start_Date__c = Date.today();
       insert newCase;
       
       
       
       SBQQ__Quote__c quote = new SBQQ__Quote__c();
       quote.SBQQ__Account__c = testaccount.id;
       quote.SBQQ__Status__c = 'Approved';
       quote.SBQQ__Primary__c = true;
       quote.Case__c = newCase.Id;
       quote.Payment_Due_Days__c = 10;
       quote.Project__c = p.id;
       quote.Labor_Billing__c ='Billable';
       insert quote;
       
       SBQQ__QuoteLine__c ql1 = new SBQQ__QuoteLine__c();
       ql1.SBQQ__Quote__c = quote.id;
       ql1.Vendor__c = a.id;
       ql1.SBQQ__NetPrice__c = 5.00;
       ql1.SBQQ__Quantity__c = 1;
       ql1.SBQQ__Description__c = 'test';
       ql1.SBQQ__Number__c = 1;
       ql1.Tax_Category__c = 'Labor - Internal';
       ql1.SBQQ__PricingMethod__c = 'List';
       ql1.Vendor__c = a.id;
       ql1.Project__c = p.id;
       //ql1.SBQQ__ProductFamily__c = 'Labor and Service';
       ql1.SBQQ__Product__c = [SELECT Id FROM Product2 WHERE Family = 'Labor and Service' LIMIT 1].id;
       ql1.Project_Line_Item__c = pt.id;
       insert ql1;
       Test.StartTest();
       
       quote.SBQQ__Status__c = 'Accepted';
       update quote;
       
       Test.StopTest();
       //
       //SBQQ__Quote__c newquote = [SELECT Id FROM SBQQ__Quote__c WHERE SBQQ__Status__c = 'Approved' AND Name = 'Q-00019' LIMIT 1];
       
       //newquote.SBQQ__Status__c = 'Accepted';
       //update newquote;
       
       //Case newcase = [SELECT Id FROM Case WHERE CaseNumber  = '00257654' LIMIT 1];
       
       //newcase.Status = 'Active';
       //update newcase;
       //newCase.Status = 'Closed';
      // update newCase;
       
       //newcase.Status = 'Closed';
       //update newcase;
       //
       //AcctSeedERP__Purchase_Order_Line__c pol = new AcctSeedERP__Purchase_Order_Line__c();
       
       
       
   }
}