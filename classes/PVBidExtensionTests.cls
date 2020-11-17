@isTest(seeAllData=false)
public class PVBidExtensionTests {

    private static Pricing_Tool_Approval__c request;
    private static AcctSeed__Project__c project;
    
    @testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    }
    
    static void init () {
        Account a = new Account (Name = 'Vandelay Industries');
        insert a;
        
        Opportunity o = new Opportunity ();
        o.Amount = 100000;
        o.Name = 'Testing PVBid';
        o.CloseDate = System.today().addDays(7);
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;
        //o.Team__c='a1O5500000CTyCo';
        insert o;
        
        request = new Pricing_Tool_Approval__c ();
        request.ProjectId__c = '1701';
        request.BidId__c = '5305';
        request.Production_Guarantee_Level__c = 'test';
        request.Opportunity__c = o.Id;
        request.Mobilization_Date__c = Date.newInstance(2018, 9, 1);      
        insert request;
        
        project = new AcctSeed__Project__c ();
        project.Branch__c = 'Boston';
        project.Pricing_Request__c = request.Id;
        project.AcctSeed__Opportunity__c = o.Id;
        project.Job_Number__c = '12345';
        project.Name = 'test';
        insert project;
        
        Cost_Code__c testCC = new Cost_Code__c ();
        testCC.Name = 'AC Electrical - Labor';
        testCC.Number__c = '01-1530';
        testCC.Category__c = 'L';
        testCC.PVBidComponentID__c = '388';
        insert testCC;
    }
    
    static testMethod void testPVBidSync () {
        init ();
        System.Test.startTest();

        Apexpages.StandardController prController = new Apexpages.StandardController(request);
        PVBidExtension ext = new  PVBidExtension(prController);  
        
        // set the variables that are set by the JS since we're headless here.
        ext.finalEPC = '1';
        ext.ineligibleCosts = '1';
        ext.finalEPCTotal = '1';
        ext.directMarginPercentage = '1';
        ext.modulePriceAssumption = '1';
        ext.systemSize = '1';
        ext.grossMargin = '1';
        ext.bidTitle = 'placeholder';
        ext.DirectCOGS = '1000.25';
        ext.DirectCOGSPerWatt = '25';
        ext.esdFinalPrice = '5';
        ext.esdCost = '1';
        ext.grossMarginPercentage = '0.25';
        ext.directMarginDollars = '500';
        ext.UtilityUpgrades='0.25';
        ext.AffiliateFee='0.25';
        ext.storagemargin='0.25';
        ext.storageenergy ='25';
        ext.energystoragesys ='25';
        ext.enerystorageunit ='25';
        ext.pvtotal ='25';
        ext.storagepower = '25';
            
        
        
        
        ext.receiveDataFromPVBid();      
        
        System.Test.stopTest();
    }
    
    static testMethod void testPVBidLineItemSync () {
        init ();
        System.Test.startTest();

        Apexpages.StandardController projectController = new Apexpages.StandardController(project);
        PVBidLineItemSyncExtension ext = new  PVBidLineItemSyncExtension(projectController);  
        
        // set the variables that are set by the JS since we're headless here.
        ext.componentIds = '388,';
        ext.costs = '1234,';
        ext.titles = '01-1530 - AC Electrical - Labor,';
        
        ext.addLineItems();   
        ext.errorCondition();
        ext.successCondition();
        
        System.Test.stopTest();
    }
}