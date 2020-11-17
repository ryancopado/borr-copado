public class ProductionModeling_WeatherStation {
    
    // Class file to control the value and display of the "Weather Station Used" and "Current Approved Weather Station "fields
    // of a Production Modeling record.  Upon creation of a new Production Modeling record, populate the Weather Station Used and
    // Current Approved Weather Station fields with the Current Approved Weather Station field of another Production Modeling
    // record associated with the same Opportunity.  The Current Approved Weather Station field of all Production Modeling records
    // associated with the same Opportunity is set to the Weather Station Used field of the most recent approved Production Modeling
    // record by triggers.
    //
    // NOTE - for now this only works for Production Modeling record create.  Code for edit mode is commented out.
    
    ApexPages.StandardController stdController;
    private final Production_Modeling__c prod_model;
        
    public ProductionModeling_WeatherStation(ApexPages.StandardController stdController) {
        
        Production_Modeling__c editProdModel = new Production_Modeling__c();
        List<Production_Modeling__c> prodModels = new List<Production_Modeling__c>();
        Id oppId;
        Boolean isEdit;
        
        this.prod_model = (Production_Modeling__c)stdController.getRecord();
        isEdit = FALSE;
/*
        if (this.prod_model.Id != NULL) {
            isEdit = TRUE;
            editProdModel = [SELECT Id, Name, Design_Link__c, PSD_Revision__c, Design_Tool_Link__c, Opportunity__c, Status__c, 
                    Production_Modeling_Stage__c, Project__c, Project_Manager__c, System_Size__c, Weather_Station_Used__c, 
                    Number_of_Washings__c, Weather_Station_Notes__c, Percent_of_Downtime_Modeled__c, 
                    Raw_Annual_Production__c, Additional_Derating_Loss__c, Notes__c, Current_Approved_Weather_Station__c
                    FROM Production_Modeling__c WHERE Id =: this.prod_model.Id];
            oppId = editProdModel.Opportunity__c;
        } else {
            oppId = this.prod_model.Opportunity__c;
        }
*/
        oppId = this.prod_model.Opportunity__c; 
        if (!isEdit) {
            prodModels = [SELECT Id, Opportunity__c, Status__c, Current_Approved_Weather_Station__c FROM Production_Modeling__c WHERE Opportunity__c =: oppId];
            if (prodModels.size() > 0) {
                this.prod_model.Weather_Station_Used__c = prodModels[0].Current_Approved_Weather_Station__c;
                this.prod_model.Current_Approved_Weather_Station__c = prodModels[0].Current_Approved_Weather_Station__c;
            }
        }
    }
    
    @isTest(seeAllData=true)
    public static void ProductionModeling_WeatherStationTest() {
        
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
            ShippingCity = 'Park City'
        );
        insert vendorAccount;
        
        Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = vendorAccount.Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
        insert testContact;
        
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = vendorAccount.Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                                                            Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000,
                                                            Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), System_Owner__c = testContact.Id, Expected_Rebate__c = 0,
                                                            Proposal_Submitted_Date__c = System.today(), Proposed_System_Size__c = 10000, Utility_Rate__c = 'N/A', Financing__c = 'Cash', 
                                                            Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                                                            RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert testOpportunity;
        
        List<Production_Modeling__c> testProdModels = new List<Production_Modeling__c>();
        testProdModels.add(new Production_Modeling__c(
            Name = 'testProductionModel1',
            Opportunity__c = testOpportunity.Id,
            Status__c = 'Draft',
            Production_Modeling_Stage__c = '50% Set',
            System_Size__c = 1019200,
            Percent_of_Downtime_Modeled__c = 0.5,
            Raw_Annual_Production__c = 1312,
            Weather_Station_Used__c = 'Steamboat',
            Date_Needed_By__c=Date.newinstance(2018, 3, 11))
        );
        testProdModels.add(new Production_Modeling__c(
            Name = 'testProductionModel2',
            Opportunity__c = testOpportunity.Id,
            Status__c = 'Draft',
            Production_Modeling_Stage__c = '50% Set',
            System_Size__c = 1019200,
            Percent_of_Downtime_Modeled__c = 0.5,
            Raw_Annual_Production__c = 1312,
            Weather_Station_Used__c = 'Vail',
            Date_Needed_By__c=Date.newinstance(2018, 3, 11))
        );
        insert testProdModels;
        
        //Instantiate a new controller to test the page - when no Approved Production Model exists
        Production_Modeling__c prod_model = new Production_Modeling__c();
        ApexPages.StandardController std = new ApexPages.StandardController(prod_model);
        ApexPages.currentPage().getParameters().put('CF00N80000004gIrT', testOpportunity.Name);
        ApexPages.currentPage().getParameters().put('CF00N80000004gIrT_lkid', testOpportunity.Id);
        ProductionModeling_WeatherStation ctl = new ProductionModeling_WeatherStation(std);
        
        //Instantiate a new controller to test the page - when there is an Approved Production Model
        testProdModels[0].Status__c = 'Approved';
        update testProdModels[0];
        ApexPages.currentPage().getParameters().put('CF00N80000004gIrT', testOpportunity.Name);
        ApexPages.currentPage().getParameters().put('CF00N80000004gIrT_lkid', testOpportunity.Id);
        Production_Modeling__c prod_model1 = new Production_Modeling__c();
        ApexPages.StandardController std1 = new ApexPages.StandardController(prod_model1);
        ProductionModeling_WeatherStation ctl1 = new ProductionModeling_WeatherStation(std1);
    }
}