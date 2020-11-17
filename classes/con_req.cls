public with sharing class con_req {
    
    ApexPages.StandardController stdController;
    private final Con_Req__c con_reqs;
    private static AcctSeed__Project__c con_req_proj = new AcctSeed__Project__c();
    private Boolean projectIsSet = false;
    public Boolean projectEdit {get; set;}
    public Boolean showOriginalProduct {get; set;}
    public Boolean taxExempt {get; set;}
    List<Id> productRtIds;
    
    public con_req(ApexPages.StandardController stdController) {
        this.con_reqs = (Con_Req__c)stdController.getRecord(); 
        
        Con_req__c tempCO;
        
        projectEdit = false;
        showOriginalProduct = false;
        taxExempt = false;
        if (this.con_reqs.Id != null) {
           tempCO =[Select Original_Product__c, Original_ProjectProductId__c, Status__c, Record_Type_Name__c from Con_Req__c where Id = :this.con_reqs.Id];
            productLinesForOriginal = tempCO.Original_ProjectProductId__c;
            system.debug('Here in if');
            if (productLinesForOriginal == null) {
                productLinesForOriginal = '--None--';
            } else {
                system.debug('status'+tempCO.Status__c);
                system.debug('product'+tempCO.Original_Product__c);
                system.debug('if'+!ppMap.containsKey(productLinesForOriginal));
                if (!ppMap.containsKey(productLinesForOriginal) && tempCO.Original_Product__c != null && 
                    ((tempCO.Status__c == 'Approved By Customer' && tempCO.Record_Type_Name__c == 'Customer Change Order') || 
                     (tempCO.Status__c == 'Borrego Approved' && tempCO.Record_Type_Name__c == 'Internal Change Order') ) ) {
                    showOriginalProduct = true;
                }
            }
            
        } else {
            system.debug('Here in else');
            // Creating a new Change Order record, determine if this is from a Purchase Order or Line Item (Project Task) record
            productLinesForOriginal = '--None--';
            String retURL = null;
            retURL = ApexPages.currentPage().getParameters().get('retURL');
            system.debug('return url'+retURL);
            if (retURL != null && retURL.length() == 16 && retURL.startsWith('/')) {
                
                Id retId = retURL.substring(1);
                if (retId.getSObjectType().getDescribe().getName() == 'AcctSeedERP__Purchase_Order__c') {
                    
                    // Creating a new Change Order from a Purchase Order, populate some of the Change Order fields
                    //projectEdit = true;
                    List<AcctSeedERP__Purchase_Order__c> poList = new List<AcctSeedERP__Purchase_Order__c>();
                    poList = [select Id, AcctSeedERP__Vendor__c, AcctSeedERP__Vendor_Contact__c from AcctSeedERP__Purchase_Order__c where Id = :retId];
                    if (!poList.isEmpty()) {
                        this.con_reqs.Vendor_Account__c = poList[0].AcctSeedERP__Vendor__c;
                        this.con_reqs.Vendor_Contact__c = poList[0].AcctSeedERP__Vendor_Contact__c;
                    }
                }
                
                if (retId.getSObjectType().getDescribe().getName() == 'AcctSeed__Project_Task__c') {
                    
                    // Creating a new Change Order from a Line Item, populate the Project field
                    List<AcctSeed__Project_Task__c> liList = new List<AcctSeed__Project_Task__c>();
                    liList = [select Id, AcctSeed__Project__c from AcctSeed__Project_Task__c where Id = :retId];
                    if (!liList.isEmpty()) {
                        this.con_reqs.ASProject__c = liList[0].AcctSeed__Project__c;
                    }
                }
            }
        }
        
        if (this.con_reqs.ASProject__c == null) {
            projectEdit = true;
        } else {
            if (this.con_reqs.Project_PM__c == null) {
                AcctSeed__Project__c tempProj = proj();
                if (tempProj != null) {
                    this.con_reqs.Project_PM__c = tempProj.OwnerId;
                }
            }
        }
        
        setTaxRate();
        this.stdController = stdController;
        
        // Get the list of Product record types used
        productRtIds = new List<Id>();
        List<RecordType> rtList = new List<RecordType>();
        rtList = [select Id, DeveloperName from RecordType where SobjectType = 'Product2' and (DeveloperName = 'SolarModule' or DeveloperName = 'Racking' or DeveloperName = 'Inverter')];
        for (RecordType rt :rtList) {
            productRtIds.add(rt.Id);
        }
       
    }
    //Set Project - proj is if making new ConReq off BLI, projs is any other new ConReq
    private String proj = ApexPages.currentPage().getParameters().get('CF00N800000033IyZ_lkid'); 
    private String projs = ApexPages.currentPage().getParameters().get('CF00N800000033IyC_lkid');
    private String service = ApexPages.currentPage().getParameters().get('CF00N80000003ZtTp_lkid'); 
    
    
    
    //Establish record type - indicates what pieces to show/hide
    String recordType = '';
    private RecordType record;
    
    public void setRecordType() {
        
        //system.debug('*****recordtypeId = ' + con_reqs.RecordTypeId);
        
        record = Utilities.getRecordType(con_reqs.RecordTypeId);

       /* if (record.Name == 'Major Component Requisition') {
            recordType = 'major';
            setTaxRate();   
        }
        if (record.Name == 'Minor Component Requisition') {
            recordType = 'minor';
            setTaxRate();  
        } 
        if (record.Name == 'Subcontractor Requisition') {
            recordType = 'sub';
        }*/
        
        if (record != null && record.Name == 'Subcontractor Change Order') {
            recordType = 'subchange';
        }else if (record != null && record.Name == 'Material PO Change') {
            recordType = 'material';
        }else if (record != null && record.Name == 'Customer Change Order') {
            recordType = 'change';
        }else if (record != null && record.Name == 'Internal Change Order') {
            recordType = 'internal';
        }
        
        //system.debug('*****recordtype = ' + recordType);

    }
    
    public void setTaxRate() {
        
        // Set the tax rate if not already set by the user
        if (con_reqs.Tax_Rate__c == null) {
            AcctSeed__Project__c project = proj();
            if (project != null && project.AcctSeed__Opportunity__c != null) {
                Opportunity o = new Opportunity();
                o = [select Id, Tax_Exemption__c, Tax_Group__r.Tax_Group_Percent__c from Opportunity where Id =:project.AcctSeed__Opportunity__c];
                if (o.Tax_Exemption__c == 'Exempt') {
                    con_reqs.Tax_Rate__c = 0;
                    taxExempt = true;
                } else {
                    con_reqs.Tax_Rate__c = o.Tax_Group__r.Tax_Group_Percent__c;
                }
            } else {
                con_reqs.Tax_Rate__c = null;
            }
        }
    }
    
    public String getRecordType() {
        return recordType;
    }
    public Boolean getService (){
        if(con_reqs.Service_Visit__c != null){
            return true;
        } else {
            return false;
        }
    }
    public void setProj() {   
        //clear our flag, allowing us to retrieve a new project
        projectIsSet = false;
        
        if (proj != null){
            Budget_Line_Item__c bli = [select Budget__c from Budget_Line_Item__c where Id = :proj];
            Budget__c budget = [select Project__c from Budget__c where Id = :bli.Budget__c];
            con_reqs.Project__c = budget.Project__c;
        } else if (projs != null){ 
            con_reqs.Project__c = projs;
        } else if (service != null) {
            con_reqs.Service_Visit__c = service; 
        }
        queryProject();
        
        setRecordType(); 
        if(recordType == 'change' || recordType == 'internal') {
            setDefaults();
        }
    }
    
    public void queryProject(){
        try {
            if (con_reqs.ASProject__c != null) {
                con_req_proj = null;
                con_req_proj = [select Id, SFDC_Project_Stage__c, SFDC_Project_End_Date__c,
                                    OwnerId, AcctSeed__Opportunity__c, Job_Number__c, AcctSeed__Account__c
                                    from AcctSeed__Project__c where Id = :con_reqs.ASProject__c];
                
                if (con_req_proj != null) {
                    projectIsSet = true; 
                } else {
                    projectIsSet = false; 
                }
            } else {
                projectIsSet = false;
            }
        } catch (Exception e){
            projectIsSet = false;
            System.debug(Logginglevel.ERROR, 'Failed to retrieve project. error= ' + e  );
        }
    }
    
//Set Default values for Summary of Costs on new Change Order 
    public void setDefaults(){
        con_reqs.Office_Admin_Hours__c = 0;
        if (  con_reqs.Office_Admin_Rate__c ==null) con_reqs.Office_Admin_Rate__c = 45.00;
        if (con_reqs.System_Designer_Hours__c==null) con_reqs.System_Designer_Hours__c = 0;
        if ( con_reqs.System_Designer_Rate__c ==null) con_reqs.System_Designer_Rate__c = 125.00;
        if (con_reqs.Project_Manager_Hours__c ==null) con_reqs.Project_Manager_Hours__c = 0;
        if ( con_reqs.Project_Manager_Rate__c ==null) con_reqs.Project_Manager_Rate__c = 150.00;
        if (con_reqs.Site_Super_Hours__c ==null) con_reqs.Site_Super_Hours__c = 0;
        if ( con_reqs.Site_Super_Rate__c  ==null) con_reqs.Site_Super_Rate__c = 100;
        if (con_reqs.Cartage__c ==null) con_reqs.Cartage__c = 0;
        if (con_reqs.Drive_Time__c ==null) con_reqs.Drive_Time__c = 0;
        if ( con_reqs.Drive_Rate__c  ==null) con_reqs.Drive_Rate__c = 100;
        if (con_reqs.Overhead__c ==null) con_reqs.Overhead__c = 0;
        if (con_reqs.Profit__c ==null) con_reqs.Profit__c = 0;
        if (con_reqs.Tools__c ==null) con_reqs.Tools__c = 0;
        if (con_reqs.Misc_Materials__c ==null) con_reqs.Misc_Materials__c = 0;
    }
    //Determines which parts of the page to show       
    public Boolean getVisibility() {
        if (con_reqs.Status__c == 'New' || con_reqs.Status__c == 'Sent for Signature') {
            return true;
        } else {
            return false;
        }
    }
        
    String lineItems;
    public void setLineItems(String lineItems) { this.lineItems = lineItems; }
    public String getLineItems() { 
        if (lineItems == '' || lineItems == null ){
            return con_reqs.Budget_Line_Item__c;
        }else {
            return lineItems;
        }
    }
    
    
    

    private Budget_Line_Item__c[] bli;
    private Budget__c budget;
    public List<SelectOption> getLines() {
        List<SelectOption> options = new List<SelectOption>();          
        try {
            //AcctSeed__Project__c project = [select SFDC_Project_Stage__c, SFDC_Project_End_Date__c from AcctSeed__Project__c where Id = :con_reqs.Project__c];
            
            budget = [select Id from Budget__c where Project__c = :con_reqs.Project__c ORDER BY CreatedDate DESC LIMIT 1];
            bli = [select Id, Category_Name__c, Cost_Code_Name__c from Budget_Line_Item__c where Budget__c = :budget.Id];
            
                for (Integer i = 0; i <bli.size(); i++) {
                    if (recordType == 'major') {
                        if ((bli[i].Cost_Code_Name__c == 'Solar Modules' ||  bli[i].Cost_Code_Name__c == 'Inverters') && bli[i].Category_Name__c != 'S'){ 
                            options.add(new SelectOption(bli[i].Id, bli[i].Cost_Code_Name__c + ' ' + ' -- ' + ' ' +  bli[i].Category_Name__c));
                        }
                    }
                    if (recordType == 'minor') {
                        if (bli[i].Cost_Code_Name__c != 'Solar Modules' &&  bli[i].Cost_Code_Name__c != 'Inverters' && 
                            (bli[i].Category_Name__c == 'M' || bli[i].Category_Name__c =='O')){ 
                            options.add(new SelectOption(bli[i].Id, bli[i].Cost_Code_Name__c ));
                        }
                    }
                    if (recordType == 'sub' ||recordType == 'subchange' ) {
                        if (bli[i].Category_Name__c == 'S'){ 
                            options.add(new SelectOption(bli[i].Id, bli[i].Cost_Code_Name__c));
                        }
                    }
                }
                if (options.size() == 0){
                    options.add(new SelectOption('', 'Please add a Budget Line Item'));  
                }                                
         } catch (Exception e) {
            System.debug(e);
            options.add(new SelectOption('', 'Please add a Budget Line Item'));
         }
        return options;
    }
   
    String productLines = '';
    Public String productLinesForOriginal{ get; set;}    
    public void setProductLines(String productLines) { this.productLines = productLines; }
    public String getProductLines() { return productLines;  }

    private Map<Id, Project_Products__c> ppMap = new Map<Id, Project_Products__c>();

    public List<SelectOption> getProducts() {
        List<SelectOption> options = new List<SelectOption>();
        AcctSeed__Project__c project = new AcctSeed__Project__c();
        Integer qty;
        
        try {
            project=proj();
            if (project == null || project.Id == null) {
                options.add(new SelectOption('', 'Please enter a Project'));
            } else {
                options.add(new SelectOption('--None--', ''));
                
                ppMap = new Map<Id, Project_Products__c>([select Id, Product__c, Product__r.Name, Quantity__c, Product__r.RecordTypeId 
                        from Project_Products__c where Project__c = :project.Id and Product__r.RecordTypeId in :productRtIds]);

                for (Project_Products__c pp :ppMap.values()) {
                    qty = (Integer)pp.Quantity__c;
                    options.add(new SelectOption(pp.Id, pp.Product__r.Name + ' (' + qty +')'));
                }
            }
        } catch (Exception e) {
            System.debug(e);
        }
        return options;
    }
    
    public List<Project_Products__c> getLineProducts() {
         
        List<Project_Products__c> products = new List<Project_Products__c>();
        AcctSeed__Project__c project = new AcctSeed__Project__c();        
        try {
            project=proj();
            products = [select Product__c, Product__r.Name, Product__r.RecordTypeId from Project_Products__c 
                        where Project__c = :project.Id and Product__r.RecordTypeId in :productRtIds];
         } catch (Exception e) {
            System.debug(e);
            //options.add(new SelectOption('', 'Please enter a Project'));
         }
        return products ;
    }  
    /*
    String vendorLines;
    public void setVendorLines(String vendorLines) { this.vendorLines = vendorLines; }
    public String getVendorLines() { return vendorLines;}
    
    private Account[] vendors;
    private ProjectPartner__c[] pPartner;
    public List<SelectOption> getVendors() {
        List<SelectOption> options = new List<SelectOption>();          
        try {
            pPartner = [select AccountId__c, Primary_Contact__c from ProjectPartner__c 
                            where ProjectId__c = :con_reqs.Project__c];
            List<Id> ppID = new List<Id>();
            for(Integer i = 0; i<pPartner.size(); i++){
                ppID.add(pPartner[i].AccountId__c);
            }
            vendors = [select Name from Account where Id in :ppID];
            for (Integer i = 0; i <vendors.size(); i++) {
                options.add(new SelectOption(vendors[i].Id, vendors[i].Name));
            }
            if (options.size() == 0){
                options.add(new SelectOption('', 'Please add a Project Partner'));  
            }         
         } catch (Exception e) {
            System.debug(e);
            options.add(new SelectOption('', 'Please enter a Project'));
         }
        return options;
    }
    public void setContact() {
        getContacts();
    }
    String contactLines;
    public void setContactLines(String contactLines) { this.contactLines = contactLines; }
    public String getContactLines() { return contactLines;}
    
    private Contact[] contacts;   
    public List<SelectOption> getContacts() {
        List<SelectOption> options = new List<SelectOption>();
        if(vendorLines != null){          
            try {
                contacts = [select Id, Name, Title from Contact 
                                where AccountId = :vendorLines];
                for (Integer i = 0; i <contacts.size(); i++) {
                    if(contacts[i].Title == null){
                        contacts[i].Title = 'Title Missing';
                    }
                    options.add(new SelectOption(contacts[i].Id, contacts[i].Name+' - '+contacts[i].Title));
                }
                if (contacts.size() == 0){
                    options.add(new SelectOption('', 'Please add a Contact to this Vendor'));  
                }        
             } catch (Exception e) {
                System.debug(e);
                options.add(new SelectOption('', 'Please enter a Project'));
             }
        } else {
            options.add(new SelectOption('', 'Please select a Vendor')); 
        }
        return options; 
    }
    */
    //private AcctSeed__Project__c p = new AcctSeed__Project__c();

    private OpportunityLineItem product = new OpportunityLineItem();
    private Con_Req__c[] requested = new Con_Req__c[0];
    
    public AcctSeed__Project__c proj() {
        
        try {
            if (con_req_proj.Id != con_reqs.ASProject__c || projectIsSet == false)   {
                queryProject();
            }
        }catch (Exception e){
            con_req_proj = new AcctSeed__Project__c();
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Object Created'));
        }
        return con_req_proj;
    }
    public void olis() {
        AcctSeed__Project__c p = new AcctSeed__Project__c();  //caspar changed to stored project below
        p = proj();
        List<OpportunityLineItem> ListOfOppLineItems  ;
        try {        
        
                                          
            ListOfOppLineItems  = [select Quantity, Qty_Requested__c, PricebookEntryid, PricebookEntry.Product2.ProductCode,PricebookEntry.Product2.Status__c, 
                                                    PricebookEntry.Product2.Cost__c from OpportunityLineItem 
                                                    where PricebookEntry.Product2.Id = :productLines and Owner_Supplied_Product__c=false and OpportunityId = :p.AcctSeed__Opportunity__c];
          
            system.debug('*****' + ListOfOppLineItems  );                                           
           If(ListOfOppLineItems!=null && ListOfOppLineItems.size()>0)  {                                       
               product=ListOfOppLineItems[0];
              
               }
            /*   
             product   = [select Quantity, Qty_Requested__c, PricebookEntry.Product2.ProductCode,PricebookEntry.Product2.Status__c, 
                                                    PricebookEntry.Product2.Cost__c from OpportunityLineItem 
                                                    where PricebookEntry.Product2.Id = :productLines and OpportunityId = :p.Opportunity__c
                                                    Limit 1];
              */                                      
             system.debug('1*****' + product);         
        }catch (Exception e){
            System.debug(Logginglevel.ERROR, 'failed to assign project. error= ' + e  );
        }     
        
        try {
                                                                        
            requested = [select Quantity__c, Product__c, Status__c from Con_Req__c where Product__c = :productLines and 
                                                Budget_Line_Item__c = :lineItems and Status__c != 'Recalled' and Status__c != 'X - Rejected'];
        }  catch (Exception e){
            System.debug(Logginglevel.ERROR, 'failed to assign requested. error= ' + e  );
        }     
        
                                              
    }                                               
    public PageReference saves() {

        try {
            List<String> fields = new List<String>();
            String errorMessage = null;
            
            // Verify that various fields are set properly
            if (recordType == 'change' || recordType == 'internal') {
                
                if (con_reqs.Change_Order_Type__c == 'System Size or Product Change') {
                    if (con_reqs.New_Product__c != null && productLinesForOriginal != '--None--') {
                        errorMessage = 'Cannot add a new product and change an existing product on the same Change Order.';
                    } else {
                        if (con_reqs.New_Quantity__c == null) {
                            fields.add('New Quantity');
                        }
                        if (con_reqs.New_Product__c == null && productLinesForOriginal == '--None--') {
                            errorMessage = 'Please select either an Original Product or New Product';
                            if (!fields.isEmpty()) {
                                errorMessage += ' and fill in the following fields to continue:\n' + fields;
                            }
                        } else {
                            if (!fields.isEmpty()) {
                                errorMessage = 'Please fill in the following fields to continue:\n' + fields;
                            }
                        }
                    }
                }
                
                if (con_reqs.Change_Order_Type__c == 'Contract Price Change') {
                    if (con_reqs.New_Product__c != null || con_reqs.New_Quantity__c != null || productLinesForOriginal != '--None--') {
                        errorMessage = 'Cannot add or change products with Contract Price Change';
                    }
                }
            }
            
            if (errorMessage != null) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, errorMessage));
                return null;    
            
            } else {
                
                // Set the Original Product field
                if (productLinesForOriginal == '--None--') {
                    con_reqs.Original_Product__c = null;
                    con_reqs.Original_ProjectProductId__c = null;
                } else {
                    con_reqs.Original_ProjectProductId__c = productLinesForOriginal;
                    con_reqs.Original_Product__c = ppMap.get(productLinesForOriginal).Product__c;
                }
                
                // Set the Project and Opportunity and set the tax rate
                AcctSeed__Project__c p = proj();
                Opportunity opp = new Opportunity();
                if (p != null) {
                    opp = [select Id, Amount from Opportunity where Id = :p.AcctSeed__Opportunity__c];
                }
                setTaxRate();
                
                // Set the CO #, Project PM, and Job Number fields if we are creating a new record
                if (ApexPages.currentPage().getParameters().get('id') == null) {
                    List<Con_Req__c> changeOrders = new List<Con_Req__c>();
                    if (recordType == 'change' || recordType == 'internal') {
                        changeOrders = [select Id from Con_Req__c where ASProject__c = :con_reqs.ASProject__c and RecordTypeId = :ApexPages.currentPage().getParameters().get('RecordType')];
                    }
                    if (recordType == 'subchange' || recordType == 'material') {
                        changeOrders = [select Id from Con_Req__c where Purchase_Order2__c = :con_reqs.Purchase_Order2__c and RecordTypeId = :ApexPages.currentPage().getParameters().get('RecordType')];
                    }
                    con_reqs.CO__c = changeOrders.size() + 1;
                    con_reqs.Project_PM__c = p.OwnerId;
                    con_reqs.Job_Number__c = p.Job_Number__c;
                }
                
                if (recordType == 'subchange' || recordType == 'material' ) {
                    return stdController.save();
                }
                
                if (recordType == 'change' || recordType == 'internal') {
                    
                    if (ApexPages.currentPage().getParameters().get('id') != null) {
                        // Updating an existing Change Order, upsert the Cost Breakdown records and save the record
                        upsert cbList;               
                        return stdController.save(); 
                    } else {
                        // Creating a new Change Order
                        con_reqs.Original_Contract_Price__c = opp.Amount;
                        insert con_reqs;
                                
                        if (cbList != null) {
                            for (Cost_Breakdown__c cb :cbList) {
                                if (cb.Construction_Requisition__c == null) {
                                    cb.Construction_Requisition__c = con_reqs.Id;
                                }
                            }
                            insert cbList;
                        }
                        
                        PageReference pr = new PageReference('/' + con_reqs.Id);
                        pr.setRedirect(true);
                        return pr;
                    }
                }
            }    
        }
        catch(DmlException Ex) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, ex.getDmlMessage(0)));
        }    
        return null;
    }
    
    
    //********************************************************************************************************************************
    //**** CHANGE ORDER SECTION ******************************************************************************************************
    public List<Cost_Breakdown__c> cbList;  // list of components to appear in the multi-line
    
    public PageReference reset() {
        cbList = [select Quantity__c, Unit_Cost__c, Description__c,ESD__c from Cost_Breakdown__c
                           where Construction_Requisition__c = :System.currentPageReference().getParameters().get('id')];
        return null;
    }             
    public List<Cost_Breakdown__c> getCBs() {
        if(cbList == null) reset(); 
        return cbList;
    }
    public void setComponents(List<Cost_Breakdown__c> CBs) {
        cbList = CBs;
    }
    public PageReference add() {
        cbList.add(new Cost_Breakdown__c(Construction_Requisition__c = ApexPages.currentPage().getParameters().get('id')));
        return null;
    }
    
    //********************************************************************************************************************************
    
    
  
}