@isTest(seealldata=true) 
public class CreateEscalatorTestClass 
{
    static testMethod void testMethod1() 
 {
 
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
      testcontract.Area_Supervisor__c =userid.id;
      testcontract.Regional_Manager_User__c = userid.id;
      insert testcontract;
     
      Service_Contract_Escalator__c testescalator=new Service_Contract_Escalator__c();
      testescalator.Service_Contract__c=testcontract.id;
      testescalator.Year__c=1;
      testescalator.CurrentYearContractValue__c=314.58;
      testescalator.Current_Year1__c=100;
      testescalator.Current_Year_Solar_Electrician_1_Rate__c=100;
      testescalator.Current_Year_Solar_Electrician_1_OT_Ra__c=100;
      testescalator.Current_Year_Solar_Electrician_2_OT_Ra__c=100;
      testescalator.Current_Year12__c=200;
      testescalator.Current_Year_Solar_Engineer_OT_Rate__c=100;
      testescalator.Current_Year__c=100;
      insert testescalator;
    
       testcontract.EndDate=Date.newinstance(2020,11, 02);
      Update testcontract;
     
      
      
 
        }
}