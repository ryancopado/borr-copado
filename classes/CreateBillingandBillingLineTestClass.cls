@isTest(seealldata=true)
public class CreateBillingandBillingLineTestClass 
{
    static testMethod Void createbilling() 
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
           testrecurringbilling.Name='Union ESD - Dartmouth Middle School - O&M';
           testrecurringbilling.AcctSeed__Customer__c='0013400001OT0Ox';
           testrecurringbilling.AcctSeed__Status__c='Active';
           testrecurringbilling.AcctSeed__Billing_Frequency__c='Anniversary in Advance';
           testrecurringbilling.AcctSeed__Next_Billing_Date__c=Date.newinstance(2020, 11, 30);
           testrecurringbilling.Service_Contract__c='80034000000VAYR';//'80034000002ELIf';
           insert testrecurringbilling;
           
           //string convertednextbillingdate = string.valueof(testrecurringbilling.AcctSeed__Next_Billing_Date__c);
           //system.debug('nextbillingdate'+  convertednextbillingdate);
           //String formattedDate = convertednextbillingdate.format();
            //system.debug('formattednextbillingdate'+  formattedDate );
            Datetime myDT = datetime.newInstance(testrecurringbilling.AcctSeed__Next_Billing_Date__c.year(), testrecurringbilling.AcctSeed__Next_Billing_Date__c.month(),testrecurringbilling.AcctSeed__Next_Billing_Date__c.day());
            system.debug('datetime'+  myDT);
           String myDate = myDT.format('MM/dd/YYYY');
           system.debug('formattednextbillingdate'+  myDate);
           
           Test.startTest();
           CreateBillingandBillingLine.createbilling(testrecurringbilling.AcctSeed__Customer__c,'a32340000025mFh',testrecurringbilling.Service_Contract__c,myDate);//'a3234000003tEuH'
           Test.stopTest();
          
        }
}