@isTest class Renewcontractsbatch_Test {
    @isTest static void test() {
        // Use isolation mode-- we need to make test data
        Account a = new Account(Name='ABC Training Trust',Branch__c='New England',Phone='24352535',Type='Other',Description='Updated');
        
        insert a;
         DateTime dT = System.now();
         Date endDate = date.newinstance(dT.year(), dT.month(), dT.day());  
        
        user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];

             
   Contract c=new Contract (Name='ABC Training Trust',AccountId=a.id,Description='Updated Test',Branch__c='New England',Contract_Status__c='Active',
                            Does_Contract_Auto_Renew__c='Yes',Contract_Amount__c=20000,ContractTerm=12,Service_Contract_Start_Date__c=Date.newInstance(2018,12,05),Enddate=endDate ,Status='NullVoid',Area_Supervisor__c=userid.id,Regional_Manager_User__c=userid.id);
    
    insert c;
        c.Contract_Amount__c=10000;
        update c;
     System.Test.startTest();
    
    RenewContractsbatch rf = new RenewContractsbatch();
    UpdateLaborfieldBatch lb=new UpdateLaborfieldBatch ();
    system.debug('The answer' +rf);
    Database.executeBatch(rf,1);
    Database.executeBatch(lb,1);
     System.Test.stopTest();
        

    }
    @isTest static void test1() {
    
         DateTime dT = System.now();
         Date endDate = date.newinstance(dT.year(), dT.month(), dT.day()); 
        
        user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];

             
     Account a = new Account(Name='ABC Training Trust',Branch__c='New England',Phone='24352535',Type='Other',Description='Updated');
       insert a; 
    Contract c1=new Contract (Name='ABC Training Trust',AccountId=a.id,Description='Updated Test',Branch__c='New England',Contract_Status__c='Active',
                            Does_Contract_Auto_Renew__c='No',Contract_Amount__c=20000,ContractTerm=12,Service_Contract_Start_Date__c=Date.newInstance(2019,04,05),Enddate=endDate ,Status='NullVoid',RecordTypeId='012340000007kck',Area_Supervisor__c=userid.id,Regional_Manager_User__c=userid.id);
    
    insert c1;
         c1.Contract_Amount__c=10000;
        update c1;
        
        
        system.debug('this is contract -->' +c1);
    Service_Contract_Escalator__c testescalator=new Service_Contract_Escalator__c();
      testescalator.Service_Contract__c=c1.id;
      testescalator.Year__c=1;
      testescalator.CurrentYearContractValue__c=20000;
      
    insert testescalator;
    
    Service_Contract_Escalator__c testescalator1=new Service_Contract_Escalator__c();
      testescalator1.Service_Contract__c=c1.id;
      testescalator1.Year__c=2;
      testescalator1.CurrentYearContractValue__c=30000;
       insert testescalator1;
    
    
        system.debug('this is service escalator'+testescalator);
    System.Test.startTest();
    UpdateContractfieldBatch uf=new UpdateContractfieldBatch();
        UpdateLaborfieldBatch lb=new UpdateLaborfieldBatch ();
        system.debug('this is update testclass-->' +uf);
    
    Database.executeBatch(uf);
         Database.executeBatch(lb,1);
        
    System.Test.stopTest();
    }
}