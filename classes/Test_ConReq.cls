/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(SeeAllData=true)
public class Test_ConReq {

   /* public static testmethod void conreqTest() {
                       
        //Set Page Parameters
        User owner = [select Id from User where Name = 'System User'];
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
        
        Budget__c budget = new Budget__c(Project__c = proj[0].Id);
        insert budget;
        
        Cost_Code__c solar = [select Id from Cost_Code__c where Name = 'Solar Modules'];
        
        List<Cost_Code__c> ListOfCostCode=new List<Cost_Code__c>();
        
        Cost_Code__c minor_comp;
        ListOfCostCode= [select Id from Cost_Code__c where Name = 'Roofing'];
        
        If (ListOfCostCode.size()>0) 
            Minor_comp=ListOfCostCode[0];

        
        Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0];
        bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = solar.Id));
       IF (Minor_comp!=NULL){
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
        }
        insert bli; 
        
        RecordType major = [select Id from RecordType where Name = 'Major Component Requisition'];
        RecordType minor = [select Id from RecordType where Name = 'Minor Component Requisition'];
        RecordType sub = [select Id from RecordType where Name = 'Subcontractor Requisition'];
        RecordType change = [select Id from RecordType where Name = 'Change Order'];
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(Project__c = proj[0].Id, Budget_Line_Item__c = bli[0].Id, Status__c = 'New', Quantity__c = 2, Type__c = 'Original Order')); 
        req.add(new Con_Req__c(Project__c = proj[0].Id, Budget_Line_Item__c = bli[1].Id, Status__c = 'Approved'));
        req.add(new Con_Req__c(Project__c = proj[0].Id, Budget_Line_Item__c = bli[2].Id,Status__c = 'Approved By Customer'));
        req.add(new Con_Req__c(Project__c = proj[0].Id));
        req.add(new Con_Req__c(Service_Visit__c = sv.Id, Tax_Rate__c = null));
        req.add(new Con_Req__c(Service_Visit__c = sv.Id));
        req.add(new Con_Req__c(Service_Visit__c = sv.Id));
        insert req;
        
        Cost_Breakdown__c[] CBs = new Cost_Breakdown__c[0];
        CBs.add(new Cost_Breakdown__c(Quantity__c = 1, Description__c = 'Cheese', Unit_Cost__c = 10, Construction_Requisition__c = req[3].Id)); 
        insert CBs;
                                  
        //Test New Page
        PageReference pageRef = Page.conreq_new;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController con = new ApexPages.StandardController(new Con_Req__c());
        con_req ext = new con_req(con);
        
        //Set Page Parameters
        ApexPages.StandardController conMJ = new ApexPages.StandardController(req[0]);
        con_req extMJ = new con_req(conMJ);

        ApexPages.currentPage().getParameters().put('CF00N800000033IyZ_lkid', req[0].Budget_Line_Item__c); 
        //Call all methods on New page 
          extMJ.setProj();
          extMJ.setTaxRate();   
          extMJ.setLineItems(bli[0].Id);
          extMJ.getLines();
          extMJ.getLineItems();
          extMJ.setProductLines(ProdMake.Id);
          extMJ.getProducts();
          extMJ.getProductLines();
          extMJ.getVisibility();
          extMJ.getRecordType();
          extMJ.getService();
          extMJ.olis(); 
          PageReference result = extMJ.saves();
        
        ApexPages.StandardController conMJsv = new ApexPages.StandardController(req[4]);
        con_req extMJsv = new con_req(conMJsv);
        ApexPages.currentPage().getParameters().put('CF00N80000003ZtTp_lkid', sv.Id); 
          extMJsv.setProj();
          extMJsv.setTaxRate(); 
          extMJsv.getService();    
          extMJsv.getVisibility();     
          PageReference result1 = extMJsv.saves();  
         
        ApexPages.StandardController conMN = new ApexPages.StandardController(req[1]);
        con_req extMN = new con_req(conMN);
                   
        ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);
        extMN = new con_req(conMN); 
          extMN.setProj();
          extMN.proj();
          extMN.getRecordType();     
          if (bli.size()>1)
              extMN.setLineItems(bli[1].Id); 
          PageReference result2 = extMN.saves();
        
        if (Req.size()>5){
            ApexPages.StandardController conMNsv = new ApexPages.StandardController(req[5]);
            con_req extMNsv = new con_req(conMNsv);
              
            ApexPages.currentPage().getParameters().put('CF00N80000003ZtTp_lkid', sv.Id);
              extMNsv.setProj();
              extMNsv.getService();    
              extMNsv.getVisibility();     
              PageReference result3 = extMNsv.saves();
        }
        
        ApexPages.StandardController conS = new ApexPages.StandardController(req[2]);
        con_req extS = new con_req(conS);
                   
        ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);
          extS.setProj();
          extS.getRecordType();     
          if (bli.size()>2)
              extS.setLineItems(bli[2].Id); 
          PageReference result4 = extS.saves();
        
        if (Req.size()>6){
        ApexPages.StandardController conSsv = new ApexPages.StandardController(req[6]);
        con_req extSsv = new con_req(conSsv);
          
        ApexPages.currentPage().getParameters().put('CF00N80000003ZtTp_lkid', sv.Id);
          extSsv.setProj();
          extSsv.getService();    
          extSsv.getVisibility();     
          PageReference result5 = extSsv.saves();
        }
          
        ApexPages.StandardController conC = new ApexPages.StandardController(req[3]);
        con_req extC = new con_req(conC);
                   
        ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);
          extC.setProj();
          extC.setDefaults();  
          extC.setComponents(CBs);
          extC.getCBs();
          extC.getVisibility();      
          PageReference result6 = ext.saves();
          PageReference result7 = extC.add();
          PageReference result8 = extC.reset();     
    } */
    
    /*static User owner = [select Id from User where Name = 'System user'];
    
        public static testmethod void conreqTest() {
                       
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
        User dk = [select Id from User where Name = 'Divya Kalyanasundaram'];
        Product2 ProdMake;
        System.runAs(dk){
           // CreatePriceBook();
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        //PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
        //EntryMake.IsActive = true; update EntryMake;
        
        Pricebook2 StdPB = [select Id from Pricebook2];
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
    
      /*  SFDC_Project__c[] proj = new SFDC_Project__c[0];
        proj.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        
        AcctSeed__Project__c[] proj = new AcctSeed__Project__c[0];
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        SFDC_Project__c sfdc_proj = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id); 
        insert sfdc_proj;
        
        Budget__c budget = new Budget__c(Project__c = sfdc_proj.Id);
        insert budget;
        
        AcctSeedERP__Purchase_Order__c purchaseorder=new AcctSeedERP__Purchase_Order__c(AcctSeedERP__Type__c='Non-Material',AcctSeedERP__Vendor__c=acc.id);
        insert purchaseorder;
        
            
        
        Cost_Code__c solar = [select Id from Cost_Code__c where Name = 'Solar Modules'];
        Cost_Code__c paid=[select Id from Cost_Code__c where Name = 'Paid Service-OM'];
        Cost_Code__c inverter=[select Id from Cost_Code__c where Name = 'Inverters'];
        
        List<Cost_Code__c> ListOfCostCode=new List<Cost_Code__c>();
        
        Cost_Code__c minor_comp;
        ListOfCostCode= [select Id from Cost_Code__c where Name = 'Roofing'];
        
        If (ListOfCostCode.size()>0) 
            minor_comp=ListOfCostCode[0];

        
        Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0];
        bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = solar.Id));
        bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = paid.Id));
        bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = inverter.Id));
        bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
        IF (minor_comp!=NULL){
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
        }
        insert bli; 
        
        
        
        
        //RecordType major,minor,sub,change ;
       
        
        RecordType subchange = [select Id,Name from RecordType where Name = 'Subcontractor Change Order'];
        RecordType material = [select Id,Name from RecordType where Name = 'Material PO Change'];
        RecordType change = [select Id from RecordType where Name = 'Customer Change Order'];
        RecordType internal = [select Id from RecordType where Name = 'Internal Change Order'];
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(ASProject__c = proj[0].Id,  Budget_Line_Item__c = bli[0].Id, Status__c = 'New', Quantity__c = 2, Type__c = 'Original Order',RecordTypeId ='012800000007k0VAAQ')); 
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[1].Id, Status__c = 'Borrego Approved',New_Quantity__c =null  ));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[2].Id,Status__c = 'Approved By Customer'));
        //req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[3].Id,Status__c = 'Approved By Customer'));
        
        req.add(new Con_Req__c(ASProject__c = proj[0].Id));
        req.add(new Con_Req__c(Service_Visit__c = sv.Id, Tax_Rate__c = null));
        req.add(new Con_Req__c(Service_Visit__c = sv.Id));
        req.add(new Con_Req__c(Service_Visit__c = sv.Id));
        insert req;
        
        Cost_Breakdown__c[] CBs = new Cost_Breakdown__c[0];
        CBs.add(new Cost_Breakdown__c(Quantity__c = 1, Description__c = 'Cheese', Unit_Cost__c = 10, Construction_Requisition__c = req[3].Id)); 
        insert CBs;
                                  
        //Test New Page
        PageReference pageRef = Page.conreq_new2;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController con = new ApexPages.StandardController(new Con_Req__c());
        con_req ext = new con_req(con);
        
        //Set Page Parameters
        ApexPages.StandardController conMJ = new ApexPages.StandardController(req[0]);
        con_req extMJ = new con_req(conMJ);

        ApexPages.currentPage().getParameters().put('CF00N800000033IyZ_lkid', req[0].Budget_Line_Item__c); 
        //Call all methods on New page 
          extMJ.setProj();
          extMJ.queryProject();
          extMJ.setTaxRate();   
          extMJ.setLineItems(bli[0].Id);
          extMJ.getLines();
          extMJ.getLineItems();
          extMJ.setProductLines(ProdMake.Id);
          extMJ.getProducts();
          extMJ.getLineProducts();
          extMJ.setRecordType();
          
          extMJ.getProductLines();
          extMJ.getVisibility();
          extMJ.getRecordType();
          extMJ.getService();
          extMJ.olis(); 
          PageReference result = extMJ.saves();
        
           
    } 
    
    Public static void CreatePriceBook(){
        List<Pricebook2> pb = [select Id from Pricebook2 where IsStandard = true];
        if (pb==null){
            PriceBook2 PB2=new PriceBook2();
            PB2.IsActive=true;
            PB2.Name='Test Book';
            PB2.Description='Test PriceBook';
        //  PB2.IsStandard=true;
            Insert PB2;
        }
        else if (pb.size()<=0){
            PriceBook2 PB2=new PriceBook2();
            PB2.IsActive=true;
            PB2.Name='Test Book';
            PB2.Description='Test PriceBook';
            //PB2.IsStandard=true;
            Insert PB2;
        }
       
    }
    
        public static testmethod void conreqTest2() {
                       
        //Set Page Parameters
        //User owner = [select Id from User where Name = 'System User'];
       
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id);
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        User dk = [select Id from User where Name = 'Divya Kalyanasundaram'];
        Product2 ProdMake;
        System.runAs(dk){
           // CreatePriceBook();
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        //PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
        //EntryMake.IsActive = true; update EntryMake;
        
        Pricebook2 StdPB = [select Id from Pricebook2];
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
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        SFDC_Project__c sfdc_proj = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id); 
        insert sfdc_proj;
        
        Budget__c budget = new Budget__c(Project__c = sfdc_proj.Id);
        insert budget;
        AcctSeedERP__Purchase_Order__c purchaseorder=new AcctSeedERP__Purchase_Order__c(AcctSeedERP__Type__c='Non-Material',AcctSeedERP__Vendor__c=acc.id);
        insert purchaseorder;
        
        Cost_Code__c solar = [select Id from Cost_Code__c where Name = 'Solar Modules'];
        Cost_Code__c paid=[select Id from Cost_Code__c where Name = 'Paid Service-OM'];
        
        List<Cost_Code__c> ListOfCostCode=new List<Cost_Code__c>();
        
        Cost_Code__c Major_comp;
        ListOfCostCode= [select Id from Cost_Code__c where Name = 'Roofing'];
        
        If (ListOfCostCode.size()>0) 
            Major_comp=ListOfCostCode[0];

        
        Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0];
        bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = solar.Id));
         bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = paid.Id));
       IF (Major_comp!=NULL){
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = Major_comp.Id));
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = Major_comp.Id));
        }
        insert bli; 
        
        //RecordType major,minor,sub,change ;
        
        
        
        RecordType subchange = [select Id,Name from RecordType where Name = 'Subcontractor Change Order'];
        RecordType material = [select Id,Name from RecordType where Name = 'Material PO Change'];
        RecordType change = [select Id from RecordType where Name = 'Customer Change Order'];
        RecordType internal = [select Id from RecordType where Name = 'Internal Change Order'];
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[0].Id, Status__c = 'New', Quantity__c = 2, Type__c = 'Original Order')); 
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[1].Id, Status__c = 'Borrego Approved'));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[2].Id, Status__c = 'Approved By Customer'));
        //req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[3].Id,Status__c = 'Approved By Customer'));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id,Service_Visit__c = sv.Id, Tax_Rate__c = null));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id,Service_Visit__c = sv.Id));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id,Service_Visit__c = sv.Id));
        insert req;
        
        Cost_Breakdown__c[] CBs = new Cost_Breakdown__c[0];
        CBs.add(new Cost_Breakdown__c(Quantity__c = 1, Description__c = 'Cheese', Unit_Cost__c = 10, Construction_Requisition__c = req[3].Id)); 
        insert CBs;
                             
 
                                  
        //Test New Page
        PageReference pageRef = Page.conreq_new2;
        Test.setCurrentPage(pageRef);
  
         ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);
         
        ApexPages.StandardController conMJsv = new ApexPages.StandardController(req[4]);
        con_req extMJsv = new con_req(conMJsv);
        ApexPages.currentPage().getParameters().put('CF00N80000003ZtTp_lkid', sv.Id); 
          extMJsv.setProj();
          extMJsv.setTaxRate(); 
          extMJsv.getService();    
          extMJsv.getVisibility(); 
               
          PageReference result1 = extMJsv.saves();
          
         
         
    }    
    
    
    
     public static testmethod void conreqTest3() {
                       
        //Set Page Parameters
      //  User owner = [select Id from User where Name = 'System User'];
      
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id);
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        User dk = [select Id from User where Name = 'Divya Kalyanasundaram'];
        Product2 ProdMake;
        System.runAs(dk){
           // CreatePriceBook();
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        //PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
        //EntryMake.IsActive = true; update EntryMake;
        
       Pricebook2 StdPB = [select Id from Pricebook2];
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
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        SFDC_Project__c sfdc_proj = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id); 
        insert sfdc_proj;
        
        Budget__c budget = new Budget__c(Project__c = sfdc_proj.Id);
        insert budget;
        AcctSeedERP__Purchase_Order__c purchaseorder=new AcctSeedERP__Purchase_Order__c(AcctSeedERP__Type__c='Non-Material',AcctSeedERP__Vendor__c=acc.id);
        insert purchaseorder;
        
        Cost_Code__c solar = [select Id from Cost_Code__c where Name = 'Solar Modules'];
        Cost_Code__c paid=[select Id from Cost_Code__c where Name = 'Paid Service-OM'];
        
        List<Cost_Code__c> ListOfCostCode=new List<Cost_Code__c>();
        
        Cost_Code__c minor_comp;
        ListOfCostCode= [select Id from Cost_Code__c where Name = 'Roofing'];
        
        If (ListOfCostCode.size()>0) 
            Minor_comp=ListOfCostCode[0];

        
        Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0];
        bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = solar.Id));
         bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = paid.Id));
       IF (Minor_comp!=NULL){
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
        }
        insert bli; 
        
        
        //RecordType major,minor,sub,change ;
        
       
        
        RecordType subchange = [select Id,Name from RecordType where Name = 'Subcontractor Change Order'];
        RecordType material = [select Id,Name from RecordType where Name = 'Material PO Change'];
        RecordType change = [select Id from RecordType where Name = 'Customer Change Order'];
        RecordType internal = [select Id from RecordType where Name = 'Internal Change Order'];
        Con_Req__c[] req = new Con_Req__c[5];
        req[0]=new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[0].Id, Status__c = 'New', Quantity__c = 2, Type__c = 'Original Order'); 
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[1].Id, Status__c = 'Borrego Approved',New_Quantity__c=null));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[2].Id, Status__c = 'Approved By Customer'));
        //req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[3].Id,Status__c = 'Approved By Customer'));
        req[1]=new Con_Req__c(ASProject__c = proj[0].Id);
        req[2]=new Con_Req__c(Service_Visit__c = sv.Id, Tax_Rate__c = null);
        req[3]=new Con_Req__c(Service_Visit__c = sv.Id);
        req[4]=new Con_Req__c(Service_Visit__c = sv.Id);
        insert req;
        
        Cost_Breakdown__c[] CBs = new Cost_Breakdown__c[0];
        CBs.add(new Cost_Breakdown__c(Quantity__c = 1, Description__c = 'Cheese', Unit_Cost__c = 10, Construction_Requisition__c = req[3].Id)); 
        insert CBs;
                                  
        //Test New Page
        PageReference pageRef = Page.conreq_new2;
        Test.setCurrentPage(pageRef);
        
         
        ApexPages.StandardController conMN = new ApexPages.StandardController(req[1]);
        con_req extMN = new con_req(conMN);
                   
        ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);
        extMN = new con_req(conMN); 
          extMN.setProj();
          try{
              extMN.proj();
              } catch(Exception error) {
                List<Apexpages.Message> msgs = ApexPages.getMessages();
                boolean b = false;
                for(Apexpages.Message msg:msgs){
                if (msg.getDetail().contains('Object Created')) b = true;
                }
                system.assert(b);             
            }
          extMN.getRecordType();     
          if (bli.size()>1)
              extMN.setLineItems(bli[1].Id); 
          PageReference result2 = extMN.saves();
        
        if (Req.size()>5){
            ApexPages.StandardController conMNsv = new ApexPages.StandardController(req[5]);
            con_req extMNsv = new con_req(conMNsv);
              
            ApexPages.currentPage().getParameters().put('CF00N80000003ZtTp_lkid', sv.Id);
              extMNsv.setProj();
              extMNsv.getService();    
              extMNsv.getVisibility();     
              PageReference result3 = extMNsv.saves();
              
        }
        
       
    } 
        public static testmethod void conreqTest4() {
                       
        //Set Page Parameters
      ///  User owner = [select Id from User where Name = 'System User'];
     
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id);
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        User dk = [select Id from User where Name = 'Divya Kalyanasundaram'];
        Product2 ProdMake;
        System.runAs(dk){
            //CreatePriceBook();
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        //PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
        //EntryMake.IsActive = true; update EntryMake;
        
       Pricebook2 StdPB = [select Id from Pricebook2];
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
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        SFDC_Project__c sfdc_proj = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id); 
        insert sfdc_proj;
        
        Budget__c budget = new Budget__c(Project__c = sfdc_proj.Id);
        insert budget;
        AcctSeedERP__Purchase_Order__c purchaseorder=new AcctSeedERP__Purchase_Order__c(AcctSeedERP__Type__c='Non-Material',AcctSeedERP__Vendor__c=acc.id);
        insert purchaseorder;
        
        Cost_Code__c solar = [select Id from Cost_Code__c where Name = 'Solar Modules'];
        Cost_Code__c paid=[select Id from Cost_Code__c where Name = 'Paid Service-OM'];
        
        List<Cost_Code__c> ListOfCostCode=new List<Cost_Code__c>();
        
        Cost_Code__c minor_comp;
        ListOfCostCode= [select Id from Cost_Code__c where Name = 'Roofing'];
        
        If (ListOfCostCode.size()>0) 
            Minor_comp=ListOfCostCode[0];

        
        Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0];
        bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = solar.Id));
         bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = paid.Id));
       IF (Minor_comp!=NULL){
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
        }
        insert bli; 
        
        
        //RecordType major,minor,sub,change ;
        
        
        
        RecordType subchange = [select Id,Name from RecordType where Name = 'Subcontractor Change Order'];
        RecordType material = [select Id,Name from RecordType where Name = 'Material PO Change'];
        RecordType change = [select Id from RecordType where Name = 'Customer Change Order'];
        RecordType internal = [select Id from RecordType where Name = 'Internal Change Order'];
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[0].Id, Status__c = 'New', Quantity__c = 2, Type__c = 'Original Order')); 
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[1].Id, Status__c = 'Borrego Approved',New_Quantity__c=null));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[2].Id, Status__c = 'Approved By Customer'));
        //req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[3].Id,Status__c = 'Approved By Customer'));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id,Service_Visit__c = sv.Id, Tax_Rate__c = null));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id,Service_Visit__c = sv.Id));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id,Service_Visit__c = sv.Id));
        insert req;
        
        Cost_Breakdown__c[] CBs = new Cost_Breakdown__c[0];
        CBs.add(new Cost_Breakdown__c(Quantity__c = 1, Description__c = 'Cheese', Unit_Cost__c = 10, Construction_Requisition__c = req[3].Id)); 
        insert CBs;
                                  
        //Test New Page
        PageReference pageRef = Page.conreq_new2;
        Test.setCurrentPage(pageRef);
        
        ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);

        
        ApexPages.StandardController conS = new ApexPages.StandardController(req[2]);
        con_req extS = new con_req(conS);
         
                   
       
          extS.setProj();
          extS.getRecordType();     
          if (bli.size()>2)
              extS.setLineItems(bli[2].Id); 
          PageReference result4 = extS.saves();
        
        if (Req.size()>6){
        ApexPages.StandardController conSsv = new ApexPages.StandardController(req[6]);
        con_req extSsv = new con_req(conSsv);
          
        ApexPages.currentPage().getParameters().put('CF00N80000003ZtTp_lkid', sv.Id);
        
            ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);
          extSsv.setProj();
          extSsv.getService();    
          extSsv.getVisibility();     
          PageReference result5 = extSsv.saves();
          

        }
          
      
    } 
     
        public static testmethod void conreqTest5() {
                       
        //Set Page Parameters
       // User owner = [select Id from User where Name = 'System User'];
      
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id);
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        User dk = [select Id from User where Name = 'Divya Kalyanasundaram'];
        Product2 ProdMake;
        System.runAs(dk){
            //CreatePriceBook();
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        //PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
        //EntryMake.IsActive = true; update EntryMake;
        
    Pricebook2 StdPB = [select Id from Pricebook2];
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
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        
        
       SFDC_Project__c sfdc_proj = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id); 
        insert sfdc_proj;
        
        Budget__c budget = new Budget__c(Project__c = sfdc_proj.Id);
        insert budget;
        AcctSeedERP__Purchase_Order__c purchaseorder=new AcctSeedERP__Purchase_Order__c(AcctSeedERP__Type__c='Non-Material',AcctSeedERP__Vendor__c=acc.id);
        insert purchaseorder;
        
        Cost_Code__c solar = [select Id from Cost_Code__c where Name = 'Solar Modules'];
        Cost_Code__c paid=[select Id from Cost_Code__c where Name = 'Paid Service-OM'];
        
        List<Cost_Code__c> ListOfCostCode=new List<Cost_Code__c>();
        
        Cost_Code__c minor_comp;
        ListOfCostCode= [select Id from Cost_Code__c where Name = 'Roofing'];
        
        If (ListOfCostCode.size()>0) 
            Minor_comp=ListOfCostCode[0];

        
        Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0];
        bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = solar.Id));
         bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = paid.Id));
       IF (Minor_comp!=NULL){
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
        }
        insert bli; 
        
        
        //RecordType major,minor,sub,change ;
        
       
        
       RecordType subchange = [select Id,Name from RecordType where Name = 'Subcontractor Change Order'];
        RecordType material = [select Id,Name from RecordType where Name = 'Material PO Change'];
        RecordType change = [select Id from RecordType where Name = 'Customer Change Order'];
        RecordType internal = [select Id from RecordType where Name = 'Internal Change Order'];
        RecordType major = [select Id from RecordType where Name = 'Major Component Requisition'];
        RecordType minor = [select Id from RecordType where Name = 'Minor Component Requisition'];
        RecordType sub = [select Id from RecordType where Name = 'Subcontractor Requisition'];
        //RecordType change = [select Id from RecordType where Name = 'Change Order'];
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[0].Id, Status__c = 'New', Quantity__c = 2, Type__c = 'Original Order')); 
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[1].Id, Status__c = 'Borrego Approved',New_Quantity__c=null));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[2].Id, Status__c = 'Approved By Customer'));
        //req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[3].Id,Status__c = 'Approved By Customer'));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Service_Visit__c = sv.Id, Tax_Rate__c = null));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Service_Visit__c = sv.Id));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Service_Visit__c = sv.Id));
        insert req;
        
        Cost_Breakdown__c[] CBs = new Cost_Breakdown__c[0];
        CBs.add(new Cost_Breakdown__c(Quantity__c = 1, Description__c = 'Cheese', Unit_Cost__c = 10, Construction_Requisition__c = req[3].Id)); 
        insert CBs;
                                  
        //Test New Page
        PageReference pageRef = Page.conreq_new2;
        Test.setCurrentPage(pageRef);
        
        ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);
        
        ApexPages.StandardController con = new ApexPages.StandardController(req[3]);
        con_req ext = new con_req(con);
       
        ApexPages.StandardController conC = new ApexPages.StandardController(req[3]);
        con_req extC = new con_req(conC);
         
          extC.setProj();
          extC.setDefaults();  
          extC.setComponents(CBs);
          extC.getCBs();
          extC.getVisibility();      
          PageReference result6 = ext.saves();
          PageReference result7 = extC.add();
          PageReference result8 = extC.reset();
              
    } 
    
    public static testmethod void conreqTest6() 
     {
    
         Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
                            insert acc;
                            
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id); insert sv;
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting',Tax_Exemption__c='Exempt'); 
        insert opp;
        User dk = [select Id from User where Name = 'Divya Kalyanasundaram'];
        Product2 ProdMake;
        System.runAs(dk){
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        Pricebook2 StdPB = [select Id from Pricebook2];
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
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        SFDC_Project__c sfdc_proj = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id); 
        insert sfdc_proj;
        Budget__c budget = new Budget__c(Project__c = sfdc_proj.Id);
        insert budget;
        AcctSeedERP__Purchase_Order__c purchaseorder=new AcctSeedERP__Purchase_Order__c(AcctSeedERP__Type__c='Non-Material',AcctSeedERP__Vendor__c=acc.id);
        insert purchaseorder;
        Cost_Code__c solar = [select Id from Cost_Code__c where Name = 'Solar Modules'];
        Cost_Code__c paid=[select Id from Cost_Code__c where Name = 'Inverters'];
        
        List<Cost_Code__c> ListOfCostCode=new List<Cost_Code__c>();
        
        Cost_Code__c minor_comp;
        ListOfCostCode= [select Id from Cost_Code__c where Name = 'Roofing'];
        
        If (ListOfCostCode.size()>0) 
            Minor_comp=ListOfCostCode[0];
             Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0];
             bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = solar.Id));
             bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = paid.Id));
       IF (Minor_comp!=NULL){
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
            bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
        }
        insert bli; 
        RecordType subchange = [select Id,Name from RecordType where Name = 'Subcontractor Change Order'];
        RecordType material = [select Id,Name from RecordType where Name = 'Material PO Change'];
        RecordType change = [select Id from RecordType where Name = 'Customer Change Order'];
        RecordType internal = [select Id from RecordType where Name = 'Internal Change Order'];
        RecordType major = [select Id from RecordType where Name = 'Major Component Requisition'];
        RecordType minor = [select Id from RecordType where Name = 'Minor Component Requisition'];
        RecordType sub = [select Id from RecordType where Name = 'Subcontractor Requisition'];
        //RecordType change = [select Id from RecordType where Name = 'Change Order'];
        
        system.debug('Prod Id'+ProdMake.id);
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(ASProject__c = proj[0].Id,Service_Visit__c = sv.Id,RecordTypeId ='0128000000077VdAAI', Budget_Line_Item__c = bli[0].Id,
         Status__c = 'New', Quantity__c = 2, Type__c = 'Original Order',Original_Product__c='01t340000045zDEAAY',Original_ProjectProductId__c='01t340000045zDEAAY',RecordType=change,Change_Order_Type__c='System Size or Product Change')); 
        req.add(new Con_Req__c(ASProject__c = proj[0].Id,Service_Visit__c = sv.Id, Tax_Rate__c = 0,Change_Order_Type__c='System Size or Product Change',New_Quantity__c=null,RecordType=internal, Budget_Line_Item__c = bli[1].Id, Status__c = 'Borrego Approved'));
        req.add(new Con_Req__c(ASProject__c = proj[0].Id, Budget_Line_Item__c = bli[2].Id, Status__c = 'New'));
        
        insert req;
        Cost_Breakdown__c[] CBs = new Cost_Breakdown__c[0];
        CBs.add(new Cost_Breakdown__c(Quantity__c = 1, Description__c = 'Cheese', Unit_Cost__c = 10, Construction_Requisition__c = req[2].Id)); 
        insert CBs;
                                  
        //Test New Page
        PageReference pageRef = Page.conreq_new2;
        Test.setCurrentPage(pageRef);        
        ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);
        ApexPages.currentPage().getParameters().put('retURL', '/'+proj[0].Id);          
        ApexPages.StandardController conS = new ApexPages.StandardController(req[0]);
        con_req extS = new con_req(conS);                   
          extS.setProj();
          extS.setDefaults();  
          extS.setComponents(CBs);
          exts.getLineItems();
          extS.getRecordType();
          extS.setRecordType();
          extS.getCBs();
          extS.getVisibility();
          extS.getLines();
          extS.queryProject();
          extS.olis(); 
        
           
          system.debug('Size of list'+bli.size());  
          //PageReference result4 = extS.saves();
        
        
        ApexPages.StandardController conSsv = new ApexPages.StandardController(req[1]);
        con_req extSsv = new con_req(conSsv);
          
        ApexPages.currentPage().getParameters().put('CF00N80000003ZtTp_lkid', sv.Id);
        
        ApexPages.currentPage().getParameters().put('CF00N800000033IyC_lkid', proj[0].Id);
          extSsv.setProj();
          extSsv.setTaxRate();
          extSsv.getService();    
          extSsv.getVisibility();
          extSsv.setRecordType();
          PageReference result5 = extSsv.saves();
         
          
    }*/ 
}