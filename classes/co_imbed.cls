public class co_imbed {
    
    private final Con_Req__c con_po;
    Public Con_Req__c ConReq {get; set;}
    public co_imbed(ApexPages.StandardController stdController) {
        this.con_po = (Con_Req__c)stdController.getRecord();
        ConReq=[select Id, Prior_Change_Orders__c, Status__c, ASProject__c, Product__c
                            ,Product__r.Family ,Product__r.Name 
                            ,New_QuantityCOConReq__c,
                            ASProject__r.AcctSeed__Opportunity__C from Con_Req__c 
                        where Id = :ApexPages.currentPage().getParameters().get('id')]; 
    }
    /*
    Con_Req__c cr = [select Id, Prior_Change_Orders__c, Status__c, ASProject__c,ASProject__r.AcctSeed__Opportunity__C from Con_Req__c 
                        where Id = :ApexPages.currentPage().getParameters().get('id')];
    */ 
    public void setPrior() {
      /*  AcctSeed__Project__c proj = [select Id, Opportunity__c from AcctSeed__Project__c where Id = :cr.Project__c];
        Opportunity opp = [select Id, Change_Orders__c from Opportunity where Id = :proj.Opportunity__c];
        if(cr.Prior_Change_Orders__c != opp.Change_Orders__c && cr.Status__c != 'Approved'){
            cr.Prior_Change_Orders__c = opp.Change_Orders__c;
            update cr;
        }*/
    }
    
    Public List<OpportunityLineItem> GetProducts(){
    
        
    
        List<OpportunityLineItem> ListOfOpportunityLineItem = new List<OpportunityLineItem>();
        
        ListOfOpportunityLineItem =[Select ID,OpportunityId,Quantity,PricebookEntry.Product2.Name
                                        ,PricebookEntry.Product2.Family from OpportunityLineItem 
                                                Where OpportunityId = :ConReq.ASProject__r.AcctSeed__Opportunity__C
                                                And PricebookEntry.Product2.Family in ('Solar Modules','Inverters','Racking')];
                                                
        return ListOfOpportunityLineItem ;
                                              
    
    }
    
    Public OpportunityLineItem GetNewProductDetail(){
    
        
    
        List<OpportunityLineItem> ListOfOpportunityLineItem = new List<OpportunityLineItem>();
        
        ListOfOpportunityLineItem =[Select ID,OpportunityId,Quantity,PricebookEntry.Product2.Name
                                        ,PricebookEntry.Product2.Family from OpportunityLineItem 
                                                Where OpportunityId = :ConReq.Product__c];
                                                
        OpportunityLineItem OLI;
        
        If(ListOfOpportunityLineItem !=null && ListOfOpportunityLineItem.size()>0)
                                        OLI= ListOfOpportunityLineItem[0];       
                                        
        return OLI;                                            
    
    }
    
    public List<Cost_Breakdown__c> coList;
    public List<Cost_Breakdown__c> getBreaks() {
        coList = [select Name, Quantity__c, Unit_Cost__c, Description__c, Total__c from Cost_Breakdown__c where 
                    Construction_Requisition__c = :ApexPages.currentPage().getParameters().get('id')];
        return coList;
    }
    public String coDate {
      get {
        Date StartDate = System.today();
        Datetime temp = Datetime.newInstance(StartDate.year(), StartDate.month(), StartDate.day());
        return temp.format('MM/dd/yyyy');
      }
      set;
    }   
    
    public static testMethod void testImbed() {
        PageReference pageRef = Page.co;
        Test.setCurrentPage(pageRef);
       
        //RecordType major = [select Id from RecordType where Name = 'Major Component Requisition'];
        //RecordType minor = [select Id from RecordType where Name = 'Minor Component Requisition'];
        RecordType sub = [select Id from RecordType where Name = 'Subcontractor Requisition'];
        //RecordType change = [select Id from RecordType where Name = 'Change Order'];
        
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
        AcctSeed__Project__c  proj = new AcctSeed__Project__c (Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id); 
        insert proj;
        
         Cost_Code__c solar = [select Id from Cost_Code__c where Name = 'Solar Modules'];
        
        List<Cost_Code__c> ListOfCostCode=new List<Cost_Code__c>();
        
        Cost_Code__c minor_comp;
        ListOfCostCode= [select Id from Cost_Code__c where Name = 'Roofing'];
        
        If (ListOfCostCode.size()>0) 
            Minor_comp=ListOfCostCode[0];
            
       //   Budget__c budget = new Budget__c(Project__c = proj.Id);
        //insert budget;
        
        
      //  Budget_Line_Item__c[] bli = new Budget_Line_Item__c[0];
      //  bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = solar.Id));
      // IF (Minor_comp!=NULL){
       //     bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
        //    bli.add(new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = minor_comp.Id));
       // }
       // insert bli; 
        
        Con_Req__c req = new Con_Req__c(ASProject__c = proj.Id,  /*Budget_Line_Item__c = bli[0].Id, */Status__c = 'New', Quantity__c = 2, Type__c = 'Original Order');
        //[select Id from Con_Req__c where RecordTypeId = :change.Id LIMIT 1];
        insert Req;
       
        //RecordType change = [select Id from RecordType where Name = 'Change Order']; 
        //Con_Req__c req = [select Id from Con_Req__c where RecordTypeId = :change.Id LIMIT 1];
        
        ApexPages.currentPage().getParameters().put('id', req.Id);
        ApexPages.StandardController con = new ApexPages.StandardController(req);
        co_imbed ext = new co_imbed(con); 
  
        ext = new co_imbed(con);
            ext.getBreaks();
            ext.setPrior();
            ext.GetNewProductDetail();
            ext.GetProducts();
            String today = ext.coDate;
    } 
}