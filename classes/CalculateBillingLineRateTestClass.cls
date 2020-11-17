@isTest(seealldata=true)
public class CalculateBillingLineRateTestClass 
{
 /*   static testMethod Void CalculateRate() 
 {
          Account testrecord2 = new Account();
          testrecord2.Name='testaccount2';
          testrecord2.Branch__c='Mid-Atlantic';
          testrecord2.Phone='(609)-524-4500';
          testrecord2.Type='service';
          testrecord2.Industry='Electric Utilities';
          testrecord2.Job_Type__c='Private';
          testrecord2.Description='NY Community Solar - developer'; 
          insert testrecord2;
     
           user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];
          
          Contract testcontract= new Contract();
          testcontract.AccountId='0013000000LBRIs';
          testcontract.Description='test';
          testcontract.Contract_Status__c='Active';
          testcontract.Branch__c='New England';
          testcontract.O_M_Package__c='Reactive';
          testcontract.Does_Contract_Auto_Renew__c='Yes';
          testcontract.Service_Contract_Start_Date__c= Date.newinstance(2010, 11, 01);
          testcontract.ContractTerm=84;
          testcontract.EndDate= Date.newinstance(2018, 12, 13);
          testcontract.Contract_Amount__c=314.58; 
          testcontract.MinimumBillableTravelTime__c=0;
          testcontract.Status=' NullVoid';
          testcontract.Escalator__c=2;
          testcontract.Area_Supervisor__c =userid.id;
          testcontract.Regional_Manager_User__c = userid.id;
          insert testcontract;
          
           AcctSeed__Recurring_Billing__c testrecurringbilling= new AcctSeed__Recurring_Billing__c();
           testrecurringbilling.Name='AES Distributed Energy - Information Technology (DOIT) - O&M';
           testrecurringbilling.AcctSeed__Customer__c='0013400001KBNN4';
           testrecurringbilling.AcctSeed__Status__c='Active';
           testrecurringbilling.AcctSeed__Billing_Frequency__c='Anniversary in Advance';
           testrecurringbilling.AcctSeed__Next_Billing_Date__c=Date.newinstance(2018, 12, 31);
           testrecurringbilling.Service_Contract__c='80034000001FX4m';
           insert testrecurringbilling;
           string testbillingid;
           
            List<AcctSeed__Billing__c> testbilling=[select id from AcctSeed__Billing__c  where AcctSeed__Status__c='In Process' and AcctSeed__Billing_Format__c='a1U34000003y3Ql'];
            if(testbilling.size()>0)
            {
             testbillingid=testbilling[0].id;
             }
         
           //string convertednextbillingdate = string.valueof(testrecurringbilling.AcctSeed__Next_Billing_Date__c);
           //system.debug('nextbillingdate'+  convertednextbillingdate);
           //String formattedDate = convertednextbillingdate.format();
            //system.debug('formattednextbillingdate'+  formattedDate );
            //AcctSeed__Billing__c testbilling=new AcctSeed__Billing__c();
           // testbilling.AcctSeed__Customer__c='0013400001OT0Ox';
            //testbilling.AcctSeed__Date__c=Date.newinstance(2019, 5, 11);
            //testbilling.AcctSeed__Status__c='In Process';
           // insert testbilling;
           // AcctSeed__Billing_Line__c testbillingline=new AcctSeed__Billing_Line__c();
           // testbillingline.AcctSeed__Billing__c='a1X1g000000S26Q';
           // testbillingline.AcctSeed__Date__c=Date.newinstance(2018, 6, 11);
          //  testbillingline.AcctSeed__Hours_Units__c=1;
          //  testbillingline.AcctSeed__Rate__c=1;
          //  testbillingline.AcctSeed__Revenue_GL_Account__c='a1m80000000p2kE';
          //  insert testbillingline;
           
           Test.startTest();
           CalculateBillingLineRate.CalculateRate(testrecurringbilling.AcctSeed__Customer__c,'a3234000003kBGw',testrecurringbilling.Service_Contract__c,testbillingid);
           Test.stopTest();
          
        } */
}