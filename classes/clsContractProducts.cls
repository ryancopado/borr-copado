public with sharing class clsContractProducts {
    
    List<OpportunityLineItem> ListOfProducts;
    
    public clsContractProducts(ApexPages.StandardController controller) {
        
        List<Contract> ListOfContract =[select id,ASproject__c,ASProject__r.AcctSeed__Opportunity__c from Contract where id= :((Contract) Controller.getrecord()).id];
        
        if (ListOfContract.size()>0)
        ListOfProducts=[Select o.Catalog_Price__c, o.Closed__c, o.ListPrice, o.Product_Description__c
                        , o.Project_Watts__c, o.Qty_Invoiced__c, o.Qty_Issued__c, o.Qty_Requested__c
                        , o.Quantity, o.Sales_Order_Line_TXnID__c, o.ServiceDate, o.TotalPrice, o.UnitPrice, o.Discount 
                        from OpportunityLineItem o Where   o.Opportunity.Id  = :ListOfContract[0].ASProject__r.AcctSeed__Opportunity__c  ];
                        
               
    }
    
    public List<OpportunityLineItem> getProducts()
    {
        return ListOfProducts;
    }
    
     
     
     
     public static Contract SetTestData(){
     
         List<RecordType> ListOfRecordType=[Select r.Description, r.Id, r.Name from RecordType r Where r.Name='Commercial Project'];
         
          
         Account ACC=New Account();
         ACC.Name='TestAccount';
         ACC.Type='Business';
         ACC.Job_Type__c='Commercial';         
         ACC.Branch__c='Berkeley'; 
         
          ACC.ShippingStreet='x';
          ACC.ShippingCity='x';
          ACC.ShippingState='x';
          ACC.ShippingPostalCode='x';
          ACC.Branch__c='Berkeley';
          ACC.RecordTypeId =  '012300000000ZtU';
                 
         Insert ACC;
         
         List<Contact> ListOfContact=new  List<Contact>();
         ListOfContact.ADD(new Contact(AccountId=ACC.ID,FirstName='FirstTest1',LastName='LastTest1')); 
         ListOfContact.ADD(new Contact(AccountId=ACC.ID,FirstName='FirstTest2',LastName='LastTest2'));          
         ListOfContact.ADD(new Contact(AccountId=ACC.ID,FirstName='FirstTest3',LastName='LastTest3')); 
          
         insert ListOfContact;
         
         Opportunity Opp=new Opportunity();
 
         Opp.Approximate_Install_Date__c=system.now().Date();
         Opp.Rebate_Assigned_To__c=([Select Id from User limit 1][0]).id;
         Opp.Expected_Rebate__c=20;
         Opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
         Opp.Name='Test Opportunity';
         Opp.Job_Type__c ='PV Direct';                                  
         Opp.Accountid =ACC.id;
         
         Opp.StageName='Project Awarded';
         //Opp.ForecastCategory='Commit';
         Opp.Last_Date_Called__c=system.now().Date();          
         Opp.Module_Delivery_Date__c =system.now().Date();         
         Opp.Inverter_Delivery_Date__c =system.now().Date();
         Opp.Racking_Delivery_Date__c =system.now().Date();          
         Opp.CloseDate=system.now().date();                  
         Opp.Type='Turnkey System';
         Opp.Proposal_Submitted_Date__c = system.today();
         Opp.Proposed_System_Size__c = 10000;
         Opp.Expected_Rebate__c = 0;
         Opp.System_Owner__c = ListOfContact[0].Id;
         Opp.Utility_Rate__c = 'N/A';
         Opp.Amount = 10000;
         Opp.Prevailing_Wage__c = 'No';
         Opp.Original_Contract_System_Size__c = 1000;
         Opp.Financing__c = 'Cash';
         Insert Opp;
         
         List<OpportunityLineItem> ListOfOLI=new List<OpportunityLineItem>();
         List<PriceBookEntry> ListOfPriceBookEntry=[Select p.Id from PricebookEntry p where IsActive=True Limit 2];
         
         For (PriceBookEntry PBE: ListOfPriceBookEntry){  

             OpportunityLineItem OLI=new OpportunityLineItem();
             OLI.OpportunityId =Opp.ID;
             OLI.Quantity =2;
             OLI.TotalPrice =9;
             OLI.PricebookEntryId=PBE.ID;
             ListOfOLI.ADD(OLI);      
         }
         
         INSERT ListOfOLI;
         
         
         
         list<OpportunityContactRole> ListOfOpportunityContactRole=new list<OpportunityContactRole>();
         ListOfOpportunityContactRole.add(new OpportunityContactRole(Role='Test1',ContactId=ListOfContact[1].id,OpportunityId =Opp.ID));
         ListOfOpportunityContactRole.add(new OpportunityContactRole(Role='Test2',ContactId=ListOfContact[2].id,OpportunityId =Opp.ID));
         Insert ListOfOpportunityContactRole;
                           
         AcctSeed__Project__c Project=new AcctSeed__Project__c ();
         Project.RecordType=ListOfRecordType[0];
         Project.AcctSeed__Opportunity__c=Opp.id;
         Project.Name='Test Project';
         Insert Project;
         
         Production_Modeling__c ProductionModel=new Production_Modeling__c();
         ProductionModel.Opportunity__c=Opp.id;
         ProductionModel.Name='Test Model';
         ProductionModel.Annual_Production_MWh__c=200;
         ProductionModel.Specific_Yield_kWh_kWp__c=300;
          
         insert ProductionModel;
         
         /*
         ProjectPartner__c ProjectPartner=new ProjectPartner__c();
         ProjectPartner.AccountId__c =ACC.id;
         ProjectPartner.Role__c ='Contractor';         
         ProjectPartner.Primary_Contact__c=ListOfContact[0].id;
         ProjectPartner.ASProject__c=Project.id;
         
         insert ProjectPartner;
         */
         
         Contract Contract=new Contract();
         Contract.Accountid=ACC.ID;
         Contract.ASproject__c=Project.id;
         Contract.Name='TestContract';
         Contract.Type__c='Warranty and Paid';
         Contract.Contract_Amount__c=200;
         Contract.Contract_Status__c='New';
         Contract.ContractTerm=5;
               
         Insert Contract;
         
         return Contract;

     }
        
        static testMethod void testclsContractProducts() {
     
        
         SOBJECT Contract=SetTestData();
         ApexPages.StandardController controller=new ApexPages.StandardController(Contract);
         clsContractProducts clsContractProducts =new clsContractProducts (controller);
         clsContractProducts.getProducts();
     
     }
}