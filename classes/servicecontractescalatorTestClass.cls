@isTest(seealldata=true)
public class servicecontractescalatorTestClass 
{
    static testMethod Void servicecontractescalatormethod() 
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
      testcontract.Service_Contract_Start_Date__c= Date.newinstance(2016, 11, 01);
      testcontract.ContractTerm=24;
      testcontract.EndDate= Date.newinstance(2018, 11, 02);
      testcontract.Contract_Amount__c=314.58; 
      testcontract.MinimumBillableTravelTime__c=0;
      testcontract.Status=' NullVoid';
      testcontract.Escalator__c=2;
      testcontract.Solar_Electrician_1_OT__c=100;
      testcontract.Labor_Escalator__c=2;
      testcontract.Solar_Electrician_1__c=100;
      testcontract.Solar_Electrician_2__c=200; 
      testcontract.Solar_Electrician_2_OT__c=100; 
      testcontract.Regional_Manager__c=100;
      testcontract.Solar_Engineer__c=100;
      testcontract.Solar_Engineer_OT__c=200; 
     testcontract.Area_Supervisor__c=userid.id;
     testcontract.Regional_Manager_User__c=userid.id;
      insert testcontract;
      
      
      
      Service_Contract_Escalator__c testescalator=new Service_Contract_Escalator__c();
      testescalator.Service_Contract__c=testcontract.id;
      testescalator.PriorYearContractValue__c=314.58;
      testescalator.CurrentYearContractValue__c=314.58;
      testescalator.Year__c=1;
      insert testescalator;
      
      
      String convertedamount=String.valueOf(testcontract.Contract_Amount__c);
      String convertedsolarrate1=String.valueOf(testcontract.Solar_Electrician_1__c);
      String convertedsolarotrate1=String.valueOf(testcontract.Solar_Electrician_1_OT__c);
      String convertedsolarrate2=String.valueOf(testcontract.Solar_Electrician_2__c);
      String convertedsolarotrate2=String.valueOf(testcontract.Solar_Electrician_2_OT__c);
      String convertedregionalmanagerrate=String.valueOf(testcontract.Regional_Manager__c);
      String convertedsolarengineerrate=String.valueOf(testcontract.Solar_Engineer__c);
      String convertedsolarengineerotrate=String.valueOf(testcontract.Solar_Engineer_OT__c);
      
      
      Test.startTest();
      servicecontractescalator.createEscalators(testcontract.id,testcontract.ContractTerm,convertedamount, testcontract.Escalator__c,convertedsolarrate1,testcontract.Labor_Escalator__c,convertedsolarotrate1,convertedsolarrate2,convertedsolarotrate2,convertedregionalmanagerrate,convertedsolarengineerrate,convertedsolarengineerotrate,2);
      updateservicecontractescalator.createEscalators(testcontract.id,testcontract.ContractTerm,convertedamount, testcontract.Escalator__c,convertedsolarrate1,testcontract.Labor_Escalator__c,convertedsolarotrate1,convertedsolarrate2,convertedsolarotrate2,convertedregionalmanagerrate,convertedsolarengineerrate,convertedsolarengineerotrate);
      testcontract.EndDate=Date.newinstance(2020,11, 02);
      Update testcontract;
      Test.stopTest();
      
      
     
      
             }
}