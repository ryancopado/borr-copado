@IsTest
Private class Test_Contract{

    public static testMethod Void TestCreate(){
    
        Account[] acc = new Account[0];
        acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'Berkeley', Project_End_Date__c = null, ShippingCity = 'Park City'));
        acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'Boston', Project_End_Date__c = null, ShippingCity = 'Park City')); 
        acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'San Diego', Project_End_Date__c = null, ShippingCity = 'Park City'));
        acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'Mid Atlantic', Project_End_Date__c = null, ShippingCity = 'Park City'));
        acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'Corporate', Project_End_Date__c = null, ShippingCity = 'Park City')); 
        insert acc;
    
        Contract[] con = new Contract[0];
        con.add(new Contract(AccountId = acc[0].Id)); 
        con.add(new Contract(AccountId = acc[0].Id));
        con.add(new Contract(AccountId = acc[1].Id)); 
        con.add(new Contract(AccountId = acc[1].Id));
        con.add(new Contract(AccountId = acc[2].Id));
        con.add(new Contract(AccountId = acc[2].Id));
        con.add(new Contract(AccountId = acc[3].Id));
        con.add(new Contract(AccountId = acc[4].Id));
        
        insert con;
    
    }
    
    public static testMethod Void TestContractTrigger(){    
    
         Contract Contract= clsContractProducts.SetTestData();
         
          Update Contract;
          
          Account Account=[select Branch__C from Account where id=:Contract.Accountid];
          
          Account.Branch__c='Boston';
          Update Account;
          Update Contract;
          
          
          Account.Branch__c='Mid Atlantic';                    
          Update Account;
          Update Contract;        
          
          integer i=0;
           
         /*  for(i=0;i<1100;i++)
           {
               Contract c=new Contract ();
                c.Accountid= Contract.Accountid;
                c.Project__C=  Contract.Project__C;
                c.Name=  Contract.Name + string.valueof(i);
                c.Type__c=  Contract.Type__c;
                c.Contract_Amount__c=  Contract.Contract_Amount__c;
                c.Contract_Status__c=  Contract.Contract_Status__c;
                c.ContractTerm=  Contract.ContractTerm;
               
                 Insert c;
           }*/
                      
    
    }
     public static testMethod Void TestContractTrigger2(){    
    
         Contract Contract= clsContractProducts.SetTestData();
         
          Update Contract;
          
          Account Account=[select Branch__C from Account where id=:Contract.Accountid];
          
          Account.Branch__c='Boston';
          Update Account;
          Update Contract;
          
          
          Account.Branch__c='San Diego';
          Update Account;
          Update Contract;
                    
          integer i=0;
           
         /*  for(i=0;i<1100;i++)
           {
               Contract c=new Contract ();
                c.Accountid= Contract.Accountid;
                c.Project__C=  Contract.Project__C;
                c.Name=  Contract.Name + string.valueof(i);
                c.Type__c=  Contract.Type__c;
                c.Contract_Amount__c=  Contract.Contract_Amount__c;
                c.Contract_Status__c=  Contract.Contract_Status__c;
                c.ContractTerm=  Contract.ContractTerm;
               
                 Insert c;
           }*/
                      
    
    }

 
     public static testMethod Void TestContractTrigger3(){    
    
         Contract Contract= clsContractProducts.SetTestData();
         
          Update Contract;
          
          Account Account=[select Branch__C from Account where id=:Contract.Accountid];
          
          Account.Branch__c='Boston';
          Update Account;
          Update Contract;
          
          
          Contract.Contract_Number__c='';
          Update Contract;
          
          integer i=0;
           
         /*  for(i=0;i<1100;i++)
           {
               Contract c=new Contract ();
                c.Accountid= Contract.Accountid;
                c.Project__C=  Contract.Project__C;
                c.Name=  Contract.Name + string.valueof(i);
                c.Type__c=  Contract.Type__c;
                c.Contract_Amount__c=  Contract.Contract_Amount__c;
                c.Contract_Status__c=  Contract.Contract_Status__c;
                c.ContractTerm=  Contract.ContractTerm;
               
                 Insert c;
           }*/
                      
    
    }
    
    public static testMethod Void TestcontractControllerExt() {
        
        Opportunity opp = new Opportunity();
        opp = TestMethods.getOpportunity();
        
        Id rtOMId = [select Id from RecordType where SobjectType = 'Opportunity' and DeveloperName = 'O_M_Opportunity'].Id;
        opp.RecordTypeId = rtOMId;
        opp.StageName = 'Contract Signed';
        opp.Commencement_Date_Option__c = 'PTO Date';
        opp.Prevailing_Wage__c = 'No';
        update opp;
        
        //Instantiate a new controller
        Contract cntrct = new Contract();
        ApexPages.StandardController std = new ApexPages.StandardController(cntrct);
        ApexPages.currentPage().getParameters().put('oppId', opp.Id);
        contractControllerExt ctl = new contractControllerExt(std);
       ctl.createPaidContract(); //commented on 4/8 by M.G due to too many SOQl Query .
    }    
}