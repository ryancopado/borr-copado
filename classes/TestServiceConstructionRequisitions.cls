@IsTest 
private class TestServiceConstructionRequisitions{

    static TestMethod void TestInsertionOfPO(){
    
        /*Account Acc=[Select id from Account limit 1];
        SV__c SV=[Select  Id from SV__c Limit 1];
        Contact Contact=[Select  ID from Contact Limit 1];
        Product2 Product=[Select id from Product2 limit 1];
        Cost_Code__c CostCode=[Select id from Cost_code__c limit 1];*/
        
        
        Account Acc= new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert Acc; 
        Contact Contact=new Contact(FirstName='Test',LastName='Tst',Accountid=Acc.ID); Insert Contact;   
         Contract con = new Contract(AccountId = acc.Id); insert con;                                   
         SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;

        Product2 Product=NEW Product2(NAME='Test'); Insert Product;
        Cost_Code__c CostCode=new Cost_Code__c(NAME='Test',Number__c='4'); Insert CostCode;
        
        Service_Construction_Requisition__c SCR=NEW Service_Construction_Requisition__c();
        SCR.Cost_Code__c=CostCode.ID;
        SCR.Date_Needed__c=Date.today();
        SCR.Product__c=Product.ID;
        SCR.Quantity__c=05;        
        SCR.Service_Visit__c=SV.ID;
        SCR.Ship_To_Account__c=Acc.ID;
        SCR.Status__c='New';
      //  SCR.ServiceVisit__c=sv.ID;  
          
        SCR.Tax_Rate__c=23;
        SCR.Type__c='Paid';
        SCR.Cost__c=34;
        SCR.Vendor_Account__c=Acc.ID;        
        SCR.Vendor_Contact__c=Contact.ID;
        
        Insert SCR;
                  
    }
    
     static TestMethod void TestUpdationOfPO(){
    
       /* Account Acc=[Select id from Account limit 1];
        SV__c SV=[Select  Id from SV__c Limit 1];
        Contact Contact=[Select  ID from Contact Limit 1];
        Product2 Product=[Select id from Product2 limit 1];
        Cost_Code__c CostCode=[Select id from Cost_code__c limit 1];*/
        
        
        Account Acc= new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert Acc; 
        Contact Contact=new Contact(FirstName='Test',LastName='Tst',Accountid=Acc.ID); Insert Contact;  
         Contract con = new Contract(AccountId = acc.Id); insert con;                                    
         SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;

        Product2 Product=NEW Product2(NAME='Test'); Insert Product;
        Cost_Code__c CostCode=new Cost_Code__c(NAME='Test',Number__c='4'); Insert CostCode;
        
        Service_Construction_Requisition__c SCR=NEW Service_Construction_Requisition__c();
        SCR.Cost_Code__c=CostCode.ID;
        SCR.Date_Needed__c= Date.today();
        SCR.Product__c=Product.ID;
        SCR.Quantity__c=05;        
        SCR.Service_Visit__c=SV.ID;
        SCR.Ship_To_Account__c=Acc.ID;
        SCR.Status__c='New';
      //  SCR.ServiceVisit__c=sv.ID;  
          
        SCR.Tax_Rate__c=23;
        SCR.Type__c='Paid';
        SCR.Cost__c=34;
        SCR.Vendor_Account__c=Acc.ID;        
        SCR.Vendor_Contact__c=Contact.ID;
        
        Insert SCR;
        
          SCR.Product__c=Product.ID;
        SCR.Quantity__c=05;        
        //SCR.Service_Visit__c=SV.ID;
        SCR.Ship_To_Account__c=Acc.ID;
        SCR.Status__c='Approved';
      //  SCR.ServiceVisit__c=sv.ID;  
          
        SCR.Tax_Rate__c=23;
        SCR.Type__c='Paid';
        SCR.Cost__c=34;
        SCR.Vendor_Account__c=Acc.ID;        
        SCR.Vendor_Contact__c=Contact.ID;    
        Update scr;      
    }
    
     static TestMethod void TestUpdationOfPO2(){
    
       /* Account Acc=[Select id from Account limit 1];
        SV__c SV=[Select  Id from SV__c Limit 1];
        Contact Contact=[Select  ID from Contact Limit 1];
        Product2 Product=[Select id from Product2 limit 1];
        Cost_Code__c CostCode=[Select id from Cost_code__c limit 1];*/
        
        
        Account Acc= new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert Acc; 
        Contact Contact=new Contact(FirstName='Test',LastName='Tst',Accountid=Acc.ID); Insert Contact;   
         Contract con = new Contract(AccountId = acc.Id); insert con;                                   
         SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;

        Product2 Product=NEW Product2(NAME='Test'); Insert Product;
        Cost_Code__c CostCode=new Cost_Code__c(NAME='Test',Number__c='4'); Insert CostCode;
        
        
        
                                     
        Service_Construction_Requisition__c SCR=NEW Service_Construction_Requisition__c();
        SCR.Cost_Code__c=CostCode.ID;
        SCR.Date_Needed__c= Date.today();
        SCR.Product__c=Product.ID;
        SCR.Quantity__c=05;        
        SCR.Service_Visit__c=SV.ID;
        SCR.Ship_To_Account__c=Acc.ID;
        SCR.Status__c='New';
      //  SCR.ServiceVisit__c=sv.ID;  
          
        SCR.Tax_Rate__c=23;
        SCR.Type__c='Paid';
        SCR.Cost__c=34;
        SCR.Vendor_Account__c=Acc.ID;        
        SCR.Vendor_Contact__c=Contact.ID;
        
        Insert SCR;
        
         SCR.Product__c=Product.ID;
        SCR.Quantity__c=05;        
        //SCR.Service_Visit__c=SV.ID;
        SCR.Ship_To_Account__c=Acc.ID;
        SCR.Status__c='Approved';
      //  SCR.ServiceVisit__c=sv.ID;  
          
        SCR.Tax_Rate__c=23;
        SCR.Type__c='Paid';
        SCR.Cost__c=34;
        SCR.Vendor_Account__c=Acc.ID;        
        SCR.Vendor_Contact__c=Contact.ID;    
        Update scr;      
        
        SCR.Status__c='New';        
        Update scr;  
    }
    
}