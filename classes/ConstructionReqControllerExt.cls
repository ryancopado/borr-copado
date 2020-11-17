public with sharing class ConstructionReqControllerExt {
    
    ApexPages.StandardController stdController;
    private final AcctSeedERP__Sales_Order_Line__c cr;
    
    public AcctSeedERP__Sales_Order_Line__c conReq {get; set;}
    public Boolean isProductError {get; set;}
    public Boolean isMajorComponent {get; set;}
    public Boolean isService {get; set;}
    public Boolean isNew {get; set;}
    public Boolean editReadonlyFields {get; set;}
    public String isLockedReturn {get; set;}
    public String rtName {get; set;}
    List<Project_Products__c> productList = new List<Project_Products__c>();
    
    // Methods for creation of a new Construction Requisition of record type Major Component.  This assumes there is a button that is launching
    // visualforce page SalesOrderLine_new from a Project record with parameters for Sales Order and Project.
    // This is all so we can help the user select the product for the new Construction Requisition that is one
    // of the products associated with the Opportunity.
    public ConstructionReqControllerExt(ApexPages.StandardController stdController) {
        
        this.cr = (AcctSeedERP__Sales_Order_Line__c)stdController.getRecord();
    }
    
    // Initialize everything for the visualforce page
    public PageReference initConstructionReq() {
        
        Dynamic_Field_Id_Setting__c FieldIds;
        AcctSeedERP__Sales_Order__c salesOrder;
        AcctSeed__Project__c project;
        List<Project_Products__c> projProds = new List<Project_Products__c>();
        List<Id> priceBookEntryIds = new List<Id>();
        List<Id> productIds = new List<Id>();
        List<PricebookEntry> priceBookEntryList = new List<PricebookEntry>();
        String ent;
        PageReference pr = null;
        
        isNew = false;
        isMajorComponent = true;
        isService = false;
        isProductError = false;
        isLockedReturn = null;
        this.stdController = stdController;
        
        // Determine if the user can edit read-only fields
        Profile userProfile = [select Id, PermissionsEditReadonlyFields from Profile where Id = :UserInfo.getProfileId()];
        editReadonlyFields = userProfile.PermissionsEditReadonlyFields;
        
        if (this.cr.Id != null) {
            getConstructionRequisition();
            if (conReq.Opportunity_Product__c == null) {
                conReq.Opportunity_Product__c = '';
            }
            /*
            constructionReq = [SELECT Id, Name, AcctSeedERP__Sales_Order__c, Status__c, Tax_Group__c, Approval_Status__c, Sales_Tax_Rate_Percent__c, 
                    AcctSeedERP__Project__c, Ship_to_Account__c, AcctSeedERP__Project_Task__c, Development_Cost__c, Project_PM__c, Backcharge__c, RecordTypeId, 
                    Backcharge_To__c, Vendor__c, AcctSeedERP__Quantity_Ordered__c, Vendor_Contact__c, Unit_Cost__c, Opportunity_Product__c, 
                    Development_Cost_Line_Item__c, Con_Req_Group__r.IsLocked__c, 
                    AcctSeedERP__Product__c, Freight__c, Requested_Delivery_Date__c, Racking_Watts__c, Additional_Notes__c, AcctSeedERP__Purchase_Order_Line__c 
                    FROM AcctSeedERP__Sales_Order_Line__c WHERE Id =: conReqId];
            */
            if (conReq.Con_Req_Group__r.IsLocked__c) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Record is locked. Cannot edit a locked record.'));
                isLockedReturn = '/' + conReq.Id;
                return null;
            }
            
        } else {
            isNew = TRUE;
            conReq = this.cr;
        }
        
        if (isNew) {
            conReq.Opportunity_Product__c = '';
            
            // Get the page parameters
            FieldIds = [SELECT Sales_Order_Line_Project_Field_Id__c, Sales_Order_Line_Sales_Order_Field_Id__c, Sales_Order_Line_Ent__c FROM Dynamic_Field_Id_Setting__c];
            conReq.AcctSeedERP__Project__c = ApexPages.currentPage().getParameters().get('CF' + FieldIds.Sales_Order_Line_Project_Field_Id__c);
            conReq.AcctSeedERP__Sales_Order__c = ApexPages.currentPage().getParameters().get('CF' + FieldIds.Sales_Order_Line_Sales_Order_Field_Id__c);
            ent = ApexPages.currentPage().getParameters().get('ent');
            conReq.RecordTypeId = ApexPages.currentPage().getParameters().get('RecordType');
            
            system.debug('look fieldid' +FieldIds);
        }
        
        // Get the RecordType Name, if not "Major Component", hand-off to standard new or edit page
        RecordType rt = [SELECT Id, Name FROM RecordType WHERE Id =: conReq.RecordTypeId];
        rtName = rt.Name;
        if (rtName != 'Major Component') {
            isMajorComponent = FALSE;
            if (rtName == 'Service') {
                isService = true;
            }
            if (isNew) {
                salesOrder = [SELECT Id, Name FROM AcctSeedERP__Sales_Order__c WHERE Id =: conReq.AcctSeedERP__Sales_Order__c];
                project = [select Id, Name from AcctSeed__Project__c where Id = :conReq.AcctSeedERP__Project__c];
                pr = new PageReference('/a2B/e?retURL=/' + conReq.AcctSeedERP__Project__c);
                pr.getParameters().put('CF' + FieldIds.Sales_Order_Line_Sales_Order_Field_Id__c, salesOrder.Name);
                pr.getParameters().put('CF' + FieldIds.Sales_Order_Line_Project_Field_Id__c, project.Name);
                pr.getParameters().put('RecordType', conReq.RecordTypeId);
                pr.getParameters().put('ent', ent);
                
                //system.debug('*****standardURL = ' + standardURL);
                system.debug('*****pr = ' + pr);
                
            }
            
        } else {
        
            // Initialize the set of Products that are associated with the Project
            productList = [select Id, Project__c, Product__c, Product__r.Name from Project_Products__c where Project__c = :conReq.AcctSeedERP__Project__c];
            if (conReq.Opportunity_Product__c == null) {
                conReq.Opportunity_Product__c = '';
            }
            if (conReq.Opportunity_Product__c != '') {
                Boolean inList = false;
                for (Project_Products__c pp :productList) {
                    if (conReq.Opportunity_Product__c == pp.Product__c) {
                        inList = true;
                    }
                }
                if (!inList) {
                    conReq.Opportunity_Product__c = '';
                }
            }
        }
        return pr;
    }
    
    // Read in all of the fields on the Construction Requisition record
    private void getConstructionRequisition() {
        String selects;
        Map<String, Schema.SObjectField> fMap;
        List<string> selectFields;
        fMap = Schema.getGlobalDescribe().get('AcctSeedERP__Sales_Order_Line__c').getDescribe().Fields.getMap();
        selectFields = new List<string>();
        if (fMap != null) {
            for (Schema.SObjectField ft : fMap.values()) {
                Schema.DescribeFieldResult fd = ft.getDescribe();
                selectFields.add(fd.getName());
            }
        }
        selects = 'CreatedBy.Name,LastModifiedBy.Name,Con_Req_Group__r.IsLocked__c,';
        if (!selectFields.isEmpty()) {
            for (string s:selectFields) {
                selects += s + ',';
            }
            if (selects.endsWith(',')) {
                selects = selects.substring(0,selects.lastIndexOf(','));
            }
        }
        
        system.debug('*****con req group field list = ' + selects);
        
        conReq = (AcctSeedERP__Sales_Order_Line__c)Database.query('SELECT ' + selects + ' FROM AcctSeedERP__Sales_Order_Line__c WHERE Id = \'' + this.cr.Id + '\'');
     //  system.debug('Look update' +conReq);
    }
    
    // Populate and return the drop-down list of Opportunity products
    public List<SelectOption> getProjProducts() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '--None--'));
        for (Project_Products__c pr :productList) {
            if (pr.Product__r.Name != 'Turnkey Installation Services') {
                options.add(new SelectOption(pr.Product__c, pr.Product__r.Name));
                /*
                if (!isNew && pr.Product__c == conReq.AcctSeedERP__Product__c) {
                    options[0].setLabel(pr.Product__r.Name);
                }
                */
            }
        }
        return options;
    }
    
    // Save the new Construction Requisition
    public PageReference saveMajorConstructionReq() {
        
        isProductError = FALSE;
        if (isMajorComponent) {
            if (conReq.Opportunity_Product__c == NULL || conReq.Opportunity_Product__c == '') {
                isProductError = TRUE;
                return null;
            } else {
                // Take the product selected from the dynamic Opportunity Product pick list and set the Product field
                conReq.AcctSeedERP__Product__c = conReq.Opportunity_Product__c;
            }
        }
        
        /*
        if (isProductError) {
            return NULL;
        }
        
        // Take the product selected from the dynamic Opportunity Product pick list and set the Product field
        conReq.AcctSeedERP__Product__c = conReq.Opportunity_Product__c;
        */
        
        Savepoint sp = Database.setSavepoint();
        try {
        
               
            upsert conReq;
               
        }
        catch(Exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
            Database.rollback(sp);
            return null;
        }
    
        PageReference crPage = new ApexPages.Standardcontroller(conReq).view();
        crPage.setRedirect(true);
        return (crPage);
    }
    
    // For testing purposes, set the required fields on the new Construction Requisition
    public void requiredFieldSetForTest(Id ShipTo, Id LineItem, Id Vendor, Id Product) {
        conReq.Ship_to_Account__c = ShipTo;
        conReq.AcctSeedERP__Project_Task__c = LineItem;
        conReq.Vendor__c = Vendor;
        conReq.Opportunity_Product__c = Product;
        conReq.AcctSeedERP__Quantity_Ordered__c = 2;
        conReq.Unit_Cost__c = 5000;
        conReq.Requested_Delivery_Date__c = system.today();
        conReq.Additional_Notes__c = 'This is a test';
    }
    
    
 /*   @isTest(seeAllData=true)
    public static void ConstructionReqControllerExtTest() {
        
        // Create test data
        Account vendorAccount = new Account(
            Branch__c = 'New England',
            Name = 'TESTvendor',
            Phone = '123-456-7890',
            Target_Market__c = 'Agriculture',
            Type = 'Customers',
            Job_Type__c = 'Private',
            Small_Business_Type__c = 'Veteran Owned',
            Description = 'This is a test',
            ShippingCity = 'San Francisco'
        );
        insert vendorAccount;

        AcctSeed__Project__c testProject = [SELECT Id, Name, AcctSeed__Opportunity__c, AcctSeed__Account__c FROM AcctSeed__Project__c WHERE Name =: 'Loft 27'];
        AcctSeed__Project_Task__c projectTask = [SELECT Id, Name, AcctSeed__Project__c FROM AcctSeed__Project_Task__c WHERE AcctSeed__Project__c =: testProject.Id AND Name =: 'Solar Modules'];
        AcctSeedERP__Sales_Order__c salesOrder = [SELECT Id, Name, Project__c FROM AcctSeedERP__Sales_Order__c WHERE Project__c =: testProject.Id];
        RecordType rt = [SELECT Id, Name FROM RecordType WHERE Name =: 'Major Component'];
                
        // Add the parameters to our page
        Dynamic_Field_Id_Setting__c FieldIds = [SELECT Sales_Order_Line_Project_Field_Id__c, Sales_Order_Line_Sales_Order_Field_Id__c, Sales_Order_Line_Ent__c FROM Dynamic_Field_Id_Setting__c];
        ApexPages.currentPage().getParameters().put('CF' + FieldIds.Sales_Order_Line_Project_Field_Id__c, testProject.Id);
        ApexPages.currentPage().getParameters().put('CF' + FieldIds.Sales_Order_Line_Sales_Order_Field_Id__c, salesOrder.Id);
        ApexPages.currentPage().getParameters().put('ent', FieldIds.Sales_Order_Line_Ent__c);
        ApexPages.currentPage().getParameters().put('RecordType', rt.Id);
                
        //Instantiate a new controller to test the page
        AcctSeedERP__Sales_Order_Line__c conrequisition = new AcctSeedERP__Sales_Order_Line__c();
        ApexPages.StandardController std = new ApexPages.StandardController(conrequisition);
        ConstructionReqControllerExt ctl = new ConstructionReqControllerExt(std);
        ctl.initConstructionReq();
        List<SelectOption> opt = ctl.getProjProducts();
        ctl.requiredFieldSetForTest(testProject.AcctSeed__Account__c, projectTask.Id, vendorAccount.Id, opt[1].getValue());
        PageReference pr = ctl.saveMajorConstructionReq();
    } */

}