global class recallReq {
    webService static void recallReq(Id[] reqId){
       /* Con_Req__c requisition = [select Id, RecordTypeId, Product__c, Service_Visit__c,ASProject__c, Purchase_Order__c, Quantity__c, 
                                    Budget_Line_Item__c, Total_Cost_Tax__c from Con_Req__c where Id in :reqId];
        RecordType record = [select Name from RecordType where Id = :requisition.RecordTypeId];
        
        //Con_PO__c con_PO = [select Id, Status__c from Con_PO__c where Id = :requisition.Purchase_Order__c];        
        List<Con_PO__c> ListOfConPO = [select Id, Status__c from Con_PO__c where Id = :requisition.Purchase_Order__c];
        Con_PO__c con_PO;
        
        If(ListOfConPO!=null && ListOfConPO.size()>0)
            con_PO=ListOfConPO[0];
        
        if(requisition.Service_Visit__c == null) {
            if (record.Name == 'Major Component Requisition') {
                try {
                    AcctSeed__Project__c project = [select AcctSeed__Opportunity__c from AcctSeed__Project__c where Id = :requisition.ASProject__c];
                    OpportunityLineItem products = [select Quantity, Qty_Requested__c from OpportunityLineItem where PricebookEntry.Product2.Id = :requisition.Product__c and OpportunityId = :project.AcctSeed__Opportunity__c];
                    if(products.Qty_Requested__c > 0 || products.Qty_Requested__c != null){
                        products.Qty_Requested__c -= requisition.Quantity__c; 
                        update products;
                    }   
                } catch (Exception e) {
                    System.debug(e);
                }
                Budget_Line_Item__c bli = [select PO_Total__c from Budget_Line_Item__c where Id = :requisition.Budget_Line_Item__c];
    
                if(bli.PO_Total__c != null && bli.PO_Total__c != 0.00) {    
                   bli.PO_Total__c -= requisition.Total_Cost_Tax__c;
                }
                update bli;
                
            }
            else if (record.Name == 'Minor Component Requisition' || record.Name == 'Subcontractor Requisition') {  
                Budget_Line_Item__c bli = [select PO_Total__c from Budget_Line_Item__c where Id = :requisition.Budget_Line_Item__c];                
                if(bli.PO_Total__c != null && bli.PO_Total__c != 0.00) {    
                    bli.PO_Total__c -= requisition.Total_Cost_Tax__c;
                }
                update bli;
            }
        } else {
            SV__c sv = [select Id, Cost__c from SV__c where Id = :requisition.Service_Visit__c];
            if(sv.Cost__c != null && sv.Cost__c != 0.00) {    
               sv.Cost__c -= requisition.Total_Cost_Tax__c;
            }
            update sv;
            
        }
        if (con_PO!=null){
        con_PO.Status__c = 'Cancelled';    
        update con_PO;
        }
        requisition.Status__c = 'Recalled'; 
        update requisition;*/
    }
    public static testMethod void recallTest(){
        recallReq.recallReq(null);
     /*RecordType major_Req = [select Id from RecordType where Name = 'Major Component Requisition'];
    RecordType sub_Req = [select Id from RecordType where Name = 'Subcontractor Requisition'];
    
    Cost_Code__c cc = new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'O'); insert cc;
    
    User owner = [select Id from User where Name = 'System User'];
    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null); insert acc;
    Contract c = new Contract(AccountId = acc.Id); insert c;
    SV__c sv = new SV__c(Contract__c = c.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;
    
    Opportunity OppMake = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting'); insert OppMake;
    
    User bh = [select Id from User where Name = 'Bradley Hibberd'];
    Product2 ProdMake;
    System.runAs(bh){
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
    }
    PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
    EntryMake.IsActive = true; update EntryMake;
    OpportunityLineItem oliMake = new OpportunityLineItem(Quantity = 25, PricebookEntryId = EntryMake.Id, OpportunityId = OppMake.Id, 
                                                            TotalPrice = 2500.00, Qty_Requested__c = 5); insert oliMake;
    
    SFDC_Project__c p = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id); insert p;
    
     AcctSeed__Project__c p2 = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = OppMake.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id); 
    insert p2;
    
    Budget__c budget = new Budget__c(Project__c = p.Id);  insert budget; 
    Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = cc.Id, PO_Total__c = 10.0); insert bli;
    
    Con_PO__c po = new Con_PO__c(Unit_Price__c = 50000); insert po;   
    Con_Req__c[] conreqs = new Con_Req__c[3];
/*    conreqs.add(new Con_Req__c(Project__c = p.Id, RecordTypeId = major_Req.Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25, Purchase_Order__c = po.Id));
    conreqs.add(new Con_Req__c(Project__c = p.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli.Id, Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25, Purchase_Order__c = po.Id));
    conreqs.add(new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Cost_Code__c = cc.Id,
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25, Purchase_Order__c = po.Id));





    conreqs[0]=new Con_Req__c(ASProject__c = p2.Id, RecordTypeId = major_Req.Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25);
    conreqs[1]=new Con_Req__c(ASProject__c = p2.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli.Id, Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25);
    conreqs[2]=new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Cost_Code__c = cc.Id,
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25);


    insert conreqs;
       
        Id[] conreq = new Id[1];
        Id[] conreq2 = new Id[1];
        Id[] conreq3 = new Id[1];
        conreq[0]=conreqs[0].Id;
        conreq2.add(conreqs[1].Id);
        conreq3.add(conreqs[2].Id); 
       recallReq.recallReq(conreq);
      // recallReq.recallReq(conreq2);
      //  recallReq.recallReq(conreq3);*/
    }
    
      public static testMethod void recallTest1(){
   /*  RecordType major_Req = [select Id from RecordType where Name = 'Major Component Requisition'];
    RecordType sub_Req = [select Id from RecordType where Name = 'Subcontractor Requisition'];
    
    Cost_Code__c cc = new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'O'); insert cc;
    
    User owner = [select Id from User where Name = 'System User'];
    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null); insert acc;
    Contract c = new Contract(AccountId = acc.Id); insert c;
    SV__c sv = new SV__c(Contract__c = c.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;
    
    Opportunity OppMake = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting'); insert OppMake;
    
    User bh = [select Id from User where Name = 'Bradley Hibberd'];
    Product2 ProdMake;
    System.runAs(bh){
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
    }
    PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
    EntryMake.IsActive = true; update EntryMake;
    OpportunityLineItem oliMake = new OpportunityLineItem(Quantity = 25, PricebookEntryId = EntryMake.Id, OpportunityId = OppMake.Id, 
                                                            TotalPrice = 2500.00, Qty_Requested__c = 5); insert oliMake;
    
    SFDC_Project__c p = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id); insert p;
    
    Budget__c budget = new Budget__c(Project__c = p.Id);  insert budget; 
    Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = cc.Id, PO_Total__c = 10.0); insert bli;
    
    Con_PO__c po = new Con_PO__c(Unit_Price__c = 50000); insert po;   
    Con_Req__c[] conreqs = new Con_Req__c[3];
/*    conreqs.add(new Con_Req__c(Project__c = p.Id, RecordTypeId = major_Req.Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25, Purchase_Order__c = po.Id));
    conreqs.add(new Con_Req__c(Project__c = p.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli.Id, Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25, Purchase_Order__c = po.Id));
    conreqs.add(new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Cost_Code__c = cc.Id,
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25, Purchase_Order__c = po.Id));





    conreqs[0]=new Con_Req__c(Project__c = p.Id, RecordTypeId = major_Req.Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25);
    conreqs[1]=new Con_Req__c(Project__c = p.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli.Id, Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25);
    conreqs[2]=new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Cost_Code__c = cc.Id,
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25);


    insert conreqs;
       
        Id[] conreq = new Id[1];
        Id[] conreq2 = new Id[1];
        Id[] conreq3 = new Id[1];
        conreq[0]=conreqs[0].Id;
        conreq2.add(conreqs[1].Id);
        conreq3.add(conreqs[2].Id); 
    //   recallReq.recallReq(conreq);
       recallReq.recallReq(conreq2);
     //   recallReq.recallReq(conreq3);
    }
    
      public static testMethod void recallTest2(){
     RecordType major_Req = [select Id from RecordType where Name = 'Major Component Requisition'];
    RecordType sub_Req = [select Id from RecordType where Name = 'Subcontractor Requisition'];
    
    Cost_Code__c cc = new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'O'); insert cc;
    
    User owner = [select Id from User where Name = 'System User'];
    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null); insert acc;
    Contract c = new Contract(AccountId = acc.Id); insert c;
    SV__c sv = new SV__c(Contract__c = c.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;
    
    Opportunity OppMake = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting'); insert OppMake;
    
    User bh = [select Id from User where Name = 'Bradley Hibberd'];
    Product2 ProdMake;
    System.runAs(bh){
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
    }
    PricebookEntry EntryMake = [select Id from PricebookEntry where Product2Id = :ProdMake.Id];
    EntryMake.IsActive = true; update EntryMake;
    OpportunityLineItem oliMake = new OpportunityLineItem(Quantity = 25, PricebookEntryId = EntryMake.Id, OpportunityId = OppMake.Id, 
                                                            TotalPrice = 2500.00, Qty_Requested__c = 5); insert oliMake;
    
    SFDC_Project__c p = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id); insert p;
    
    Budget__c budget = new Budget__c(Project__c = p.Id);  insert budget; 
    Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = cc.Id, PO_Total__c = 10.0); insert bli;
    
    Con_PO__c po = new Con_PO__c(Unit_Price__c = 50000); insert po;   
    Con_Req__c[] conreqs = new Con_Req__c[3];
/*    conreqs.add(new Con_Req__c(Project__c = p.Id, RecordTypeId = major_Req.Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25, Purchase_Order__c = po.Id));
    conreqs.add(new Con_Req__c(Project__c = p.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli.Id, Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25, Purchase_Order__c = po.Id));
    conreqs.add(new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Cost_Code__c = cc.Id,
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25, Purchase_Order__c = po.Id));





    conreqs[0]=new Con_Req__c(Project__c = p.Id, RecordTypeId = major_Req.Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25);
    conreqs[1]=new Con_Req__c(Project__c = p.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli.Id, Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25);
    conreqs[2]=new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Cost_Code__c = cc.Id,
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, 
                                Tax_Rate__c = 7.25);


    insert conreqs;
       
        Id[] conreq = new Id[1];
        Id[] conreq2 = new Id[1];
        Id[] conreq3 = new Id[1];
        conreq[0]=conreqs[0].Id;
        conreq2.add(conreqs[1].Id);
        conreq3.add(conreqs[2].Id); 
     //  recallReq.recallReq(conreq);
     //  recallReq.recallReq(conreq2);
        recallReq.recallReq(conreq3);*/
    }
}