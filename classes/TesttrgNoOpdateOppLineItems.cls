/** 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts. However, this class is
 * public because we want the test data singletons to be available to external
 * test classes. Only private top-level non-exception class types can be
 * marked as tests
 * 
 * Unit test methods take no arguments, commit no data to the database, and 
 * are flagged with the testMethod keyword in the method definition.
 */
 
@isTest(seeAllData=true)
public class TesttrgNoOpdateOppLineItems {

    
        public static testMethod  void ASTesttrgNoOpdateOppLineItems(){
    
      User owner;
         List<User> ListOfUser=new List<User>();
        ListOfUser = [select Id from User where Name = 'Emily East'];
        
        if (ListOfUser==null)
            ListOfUser = [select Id from User  where isActive=True  limit 1];
        else if(ListOfUser.size()<=0)
           ListOfUser = [select Id from User  where isActive=True  limit 1];       
        
        if (ListOfUser!=null && ListOfUser.size()>0)
            Owner=ListOfUser[0];
    
    Pricebook2 pb = [select name, isactive from Pricebook2 where IsStandard = true limit 1];
    
      Account ACC=NEW Account();
     Acc.Name='Accountabc';
     Acc.ShippingCity ='Park City456';
     insert Acc;
    
       Opportunity oOpportunity=new Opportunity();
        oOpportunity.StageName='Prospecting';
        oOpportunity.CloseDate=date.today();
        oOpportunity.Name='TestOpportunity';
        oOpportunity.TotalOpportunityQuantity=67;
        oOpportunity.AccountId=ACC.id;//[Select id from account limit 1][0].id;
     
        Insert oOpportunity;
        
         Product2 p = new Product2();
         p.Name     = 'TEST';
        insert p;
    
        
        
/*        
        PricebookEntry pbe =[Select Pricebook2Id ,id,product2id,isActive,UnitPrice from PricebookEntry 
                                where Pricebook2Id = :pb.id and Product2Id   = :p.id ];
        if(pbe==null){                        
            pbe= new PricebookEntry();
            pbe.Pricebook2Id = pb.id;
            pbe.Product2Id   = p.id;
            pbe.IsActive     = true;
            pbe.UnitPrice    = 1;
            insert pbe ;
        }
        else{
            if(pbe.isActive==false){
                pbe.isActive=true;
                update pbe;
            }
        }
*/        
		PricebookEntry pbe = new PricebookEntry();
		pbe.Pricebook2Id = pb.id;
		pbe.Product2Id   = p.id;
		pbe.IsActive     = true;
		pbe.UnitPrice    = 1;
		insert pbe;
        
       /*  AcctSeed__Project__c project ;
        project=new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = oOpportunity.Id, AcctSeed__Account__c = ACC.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-99999', OwnerId = owner.Id);
        insert project;*/
    
        Con_PO__c conpos = new Con_PO__c( Quantity__c = 10.00,   Unit_Price__c = 5.00,Project_Name__c='Test');
        insert conpos;
        
        PO_Invoice__c POInvoice=new PO_Invoice__c();
        Insert POInvoice;
        
        Invoice_Distribution_Line__c IDL=new Invoice_Distribution_Line__c( Construction_Purchase_Order1__c=conpos.id,POInvoice__c =POInvoice.ID);
        
        insert IDL;
        
        
        OpportunityLineItem NewOpportunityLineItem =new OpportunityLineItem ();
        NewOpportunityLineItem.OpportunityId=oOpportunity.Id;
       NewOpportunityLineItem.pricebookentryid    = pbe.id;
        
        NewOpportunityLineItem.quantity= 50;
        NewOpportunityLineItem.unitprice =5;          
        Insert NewOpportunityLineItem;
        
        NewOpportunityLineItem =new OpportunityLineItem ();
        NewOpportunityLineItem.OpportunityId=oOpportunity.Id;
        NewOpportunityLineItem.pricebookentryid    = pbe.id;
        
        
         NewOpportunityLineItem.quantity= 50;
        NewOpportunityLineItem.unitprice =5;          
        Insert NewOpportunityLineItem; 
        
        Update NewOpportunityLineItem;
        
        approveELI.IsRecursiveUpdate=False;
        Update oOpportunity;
      }
      
      
      
   public static testMethod  void ASTestConReqTrigger(){
    
   User owner = [select Id from User where Name = 'System User'];
    
       
                       
        //Set Page Parameters
      
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id);
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        User bh = [select Id from User where Name = 'Bradley Hibberd'];
        Product2 ProdMake;
        System.runAs(bh){
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        //PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
        //EntryMake.IsActive = true; update EntryMake;
        
        Pricebook2 StdPB = [select Id from Pricebook2 where IsStandard = true];
        PricebookEntry EntryMake = new PricebookEntry(
        	Product2Id = ProdMake.Id,
        	Pricebook2Id = StdPB.Id,
        	UnitPrice = ProdMake.Cost__c,
        	IsActive = true
        );
        insert EntryMake;
        
        OpportunityLineItem oliMake = new OpportunityLineItem(Quantity = 25, PricebookEntryId = EntryMake.Id, OpportunityId = opp.Id, 
                                            TotalPrice = 2500.00); 
        insert oliMake;
    
        AcctSeed__Project__c[] proj = new AcctSeed__Project__c[0];
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = ACC.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        
        
       
        
        RecordType major,minor,sub,change ;
        
        
        
   
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Product__c=ProdMake.ID,New_QuantityCOConReq__c=5,New_ProductCOConReq__c=ProdMake.ID,Quantity__c=10,
                          
                         Change_Order_Type__c='System Size or Product Change',
                         Status__c = 'New',   Type__c = 'Original Order')); 
       
        insert req;
        req[0].Status__c='Borrego Approved';
        Update req;
        
        
      
                                  
     
      }
      
       public static testMethod  void ASTestConReqTrigger2(){
    
   User owner = [select Id from User where Name = 'System User'];
    
       
                       
        //Set Page Parameters
      
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id);
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        User bh = [select Id from User where Name = 'Bradley Hibberd'];
        Product2 ProdMake;
        System.runAs(bh){
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        //PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
        //EntryMake.IsActive = true; update EntryMake;
        
        Pricebook2 StdPB = [select Id from Pricebook2 where IsStandard = true];
        PricebookEntry EntryMake = new PricebookEntry(
        	Product2Id = ProdMake.Id,
        	Pricebook2Id = StdPB.Id,
        	UnitPrice = ProdMake.Cost__c,
        	IsActive = true
        );
        insert EntryMake;
        
        OpportunityLineItem oliMake = new OpportunityLineItem(Quantity = 25, PricebookEntryId = EntryMake.Id, OpportunityId = opp.Id, 
                                            TotalPrice = 2500.00); 
        insert oliMake;
    
        AcctSeed__Project__c[] proj = new AcctSeed__Project__c[0];
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = ACC.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        
        
       
        
        RecordType major,minor,sub,change ;
        
       
        
   
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Product__c=ProdMake.ID,New_QuantityCOConReq__c=5,New_ProductCOConReq__c=ProdMake.ID,Quantity__c=10,
                          
                         Change_Order_Type__c='System Size or Product Change',
                         Status__c = 'New',   Type__c = 'Original Order')); 
       
       
       
        insert req;
     
        req[0].Status__c='Approved By Customer';
        update req;
        
        
        opp.Name = 'Knight - 2457';
        
        update opp;                     
     
      }
    
    

    public static testMethod  void TesttrgNoOpdateOppLineItems(){
    
      User owner;
         List<User> ListOfUser=new List<User>();
        ListOfUser = [select Id from User where Name = 'Emily East'];
        
        if (ListOfUser==null)
            ListOfUser = [select Id from User  where isActive=True  limit 1];
        else if(ListOfUser.size()<=0)
           ListOfUser = [select Id from User  where isActive=True  limit 1];       
        
        if (ListOfUser!=null && ListOfUser.size()>0)
            Owner=ListOfUser[0];
    
    Pricebook2 pb = [select name, isactive from Pricebook2 where IsStandard = true limit 1];
    
      Account ACC=NEW Account();
     Acc.Name='123account';
     Acc.ShippingCity ='Hopkinton';
     insert Acc;
    
       Opportunity oOpportunity=new Opportunity();
        oOpportunity.StageName='Prospecting';
        oOpportunity.CloseDate=date.today();
        oOpportunity.Name='TestOpportunity';
        oOpportunity.TotalOpportunityQuantity=67;
        oOpportunity.AccountId=ACC.id;//[Select id from account limit 1][0].id;
     
        Insert oOpportunity;
        
         Product2 p = new Product2();
         p.Name     = 'TEST';
        insert p;
    
        
        
/*        
        PricebookEntry pbe =[Select Pricebook2Id ,id,product2id,isActive,UnitPrice from PricebookEntry 
                                where Pricebook2Id = :pb.id and Product2Id   = :p.id ];
        if(pbe==null){                        
            pbe= new PricebookEntry();
            pbe.Pricebook2Id = pb.id;
            pbe.Product2Id   = p.id;
            pbe.IsActive     = true;
            pbe.UnitPrice    = 1;
            insert pbe ;
        }
        else{
            if(pbe.isActive==false){
                pbe.isActive=true;
                update pbe;
            }
        }
*/
        
        PricebookEntry pbe = new PricebookEntry();
		pbe.Pricebook2Id = pb.id;
		pbe.Product2Id   = p.id;
		pbe.IsActive     = true;
		pbe.UnitPrice    = 1;
		insert pbe ;
        
         SFDC_Project__c project ;
        project=new SFDC_Project__c(Name = 'Test',Opportunity__c = oOpportunity.Id, Account__c = ACC.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id); 
        insert project;
    
        Con_PO__c conpos = new Con_PO__c( Quantity__c = 10.00,   Unit_Price__c = 5.00,Project_Name__c='Test');
        insert conpos;
        
        PO_Invoice__c POInvoice=new PO_Invoice__c();
        Insert POInvoice;
        
        Invoice_Distribution_Line__c IDL=new Invoice_Distribution_Line__c( Construction_Purchase_Order1__c=conpos.id,POInvoice__c =POInvoice.ID);
        
        insert IDL;
        
        
        OpportunityLineItem NewOpportunityLineItem =new OpportunityLineItem ();
        NewOpportunityLineItem.OpportunityId=oOpportunity.Id;
       NewOpportunityLineItem.pricebookentryid    = pbe.id;
        
        NewOpportunityLineItem.quantity= 50;
        NewOpportunityLineItem.unitprice =5;          
        Insert NewOpportunityLineItem;
        
        NewOpportunityLineItem =new OpportunityLineItem ();
        NewOpportunityLineItem.OpportunityId=oOpportunity.Id;
        NewOpportunityLineItem.pricebookentryid    = pbe.id;
        
        
         NewOpportunityLineItem.quantity= 50;
        NewOpportunityLineItem.unitprice =5;          
        Insert NewOpportunityLineItem; 
        
        Update NewOpportunityLineItem;
        
        approveELI.IsRecursiveUpdate=False;
        Update oOpportunity;
      }
      
      
      
   public static testMethod  void TestConReqTrigger(){
    
   User owner = [select Id from User where Name = 'System User'];
    
       
                       
        //Set Page Parameters
      
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id);
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        User bh = [select Id from User where Name = 'Bradley Hibberd'];
        Product2 ProdMake;
        System.runAs(bh){
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        //PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
        //EntryMake.IsActive = true; update EntryMake;
        
        Pricebook2 StdPB = [select Id from Pricebook2 where IsStandard = true];
        PricebookEntry EntryMake = new PricebookEntry(
        	Product2Id = ProdMake.Id,
        	Pricebook2Id = StdPB.Id,
        	UnitPrice = ProdMake.Cost__c,
        	IsActive = true
        );
        insert EntryMake;
        
        OpportunityLineItem oliMake = new OpportunityLineItem(Quantity = 25, PricebookEntryId = EntryMake.Id, OpportunityId = opp.Id, 
                                            TotalPrice = 2500.00); 
        insert oliMake;
    
        SFDC_Project__c[] proj = new SFDC_Project__c[0];
        proj.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        
        
       
        
        RecordType major,minor,sub,change ;
        
        
        
   
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(Project__c = proj[0].Id, Product__c=ProdMake.ID,New_QuantityCOConReq__c=5,New_ProductCOConReq__c=ProdMake.ID,Quantity__c=10,
                          
                         Change_Order_Type__c='System Size or Product Change',
                         Status__c = 'New',   Type__c = 'Original Order')); 
       
        insert req;
        req[0].Status__c='Borrego Approved';
        Update req;
        
        
      
                                  
     
      }
      
      /* public static testMethod  void TestConReqTrigger2(){
    
   User owner = [select Id from User where Name = 'System User'];
    
       
                       
        //Set Page Parameters
      
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id);
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        User bh = [select Id from User where Name = 'Bradley Hibberd'];
        Product2 ProdMake;
        System.runAs(bh){
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
        EntryMake.IsActive = true; update EntryMake;
        OpportunityLineItem oliMake = new OpportunityLineItem(Quantity = 25, PricebookEntryId = EntryMake.Id, OpportunityId = opp.Id, 
                                            TotalPrice = 2500.00); 
        insert oliMake;
    
        SFDC_Project__c[] proj = new SFDC_Project__c[0];
        proj.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        
        
       
        
        RecordType major,minor,sub,change ;
        
        List<RecordType> LR = [select Id,Name from RecordType where Name IN ('Major Component Requisition','Minor Component Requisition',
                                               'Subcontractor Requisition','Change Order' )];
                                               
        For(RecordType TempRecType :LR){
        
            If(TempRecType.Name=='Major Component Requisition'){
                major =TempRecType ;            
            }
            else If(TempRecType.Name=='Minor Component Requisition'){
                minor =TempRecType ;            
            }
            else If(TempRecType.Name=='Subcontractor Requisition'){
                sub =TempRecType ;            
            }
            else If(TempRecType.Name=='Change Order'){
                change =TempRecType ;            
            }
        
        }
        
   
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(Project__c = proj[0].Id, Product__c=ProdMake.ID,New_QuantityCOConReq__c=5,New_ProductCOConReq__c=ProdMake.ID,Quantity__c=10,
                          
                         Change_Order_Type__c='System Size or Product Change',
                         Status__c = 'New',   Type__c = 'Original Order')); 
       
        insert req;
     
        
        
        req[0].Status__c='Approved By Customer';
        Update req;
        
                                  
     
      }*/
}