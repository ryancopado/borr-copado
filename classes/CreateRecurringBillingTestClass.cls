@isTest(seealldata=true)
public class CreateRecurringBillingTestClass 
{
    static testMethod void testMethod1() 
 {
      
      Test.startTest();
      //ASeedAccountingSettingsSetupTest.testDataSetup(); 
      //
      user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];
      
      Contract testcontract= new Contract();
      testcontract.AccountId='0013000000LBRIs';
      
      testcontract.Description='test';
      testcontract.Contract_Status__c='Pending';
      testcontract.Branch__c='New England';
      testcontract.O_M_Package__c='Reactive';
      testcontract.ASProject__c='a1t340000047bVz';
      testcontract.Does_Contract_Auto_Renew__c='Yes';
      testcontract.Service_Contract_Start_Date__c= Date.newinstance(2010, 11, 01);
      testcontract.ContractTerm=84;
      testcontract.EndDate= Date.newinstance(2018, 12, 13);
      testcontract.Contract_Amount__c=314.58; 
      testcontract.MinimumBillableTravelTime__c=0;
      testcontract.Status=' NullVoid';
      testcontract.Escalator__c=2;
      testcontract.Type__c='O&M';
      //testcontract.Recurring_Billing_Name__c=
      testcontract.Payment_Options__c='Anniversary in Advance';
      testcontract.Escalator_Details__c='Increases on anniversary date of contract';
      testcontract.Date_of_First_Escalator_to_be_Applied__c=Date.newinstance(2011, 3, 11);  
      insert testcontract;
      testcontract.Contract_Status__c='Active';
      testcontract.Service_Contract_Tier__c='Tier 0';
      testcontract.Monitoring_Required__c ='No';  
     testcontract.Area_Supervisor__c=userid.id;
     testcontract.Regional_Manager_User__c=userid.id;
      update testcontract;
      
      
           /*AcctSeed__Recurring_Billing__c testrecurringbilling= new AcctSeed__Recurring_Billing__c();
           testrecurringbilling.Name='AES Distributed Energy - Information Technology (DOIT) - O&M';
           testrecurringbilling.AcctSeed__Customer__c='0013400001KBNN4';
           testrecurringbilling.AcctSeed__Status__c='Active';
           testrecurringbilling.AcctSeed__Billing_Frequency__c='Anniversary in Advance';
           testrecurringbilling.AcctSeed__Next_Billing_Date__c=Date.newinstance(2018, 12, 31);
           testrecurringbilling.Service_Contract__c='80034000001FX4m';
           insert testrecurringbilling;*/
           Test.stopTest();
      
      
      
 
        }
}