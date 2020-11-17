@isTest
private class testServiceVisit_AssetCtlExt {
    
 /*   @testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    } */
    /*
     *  Test methods for ServiceVisit_AssetCtlExt.cls
     *
     */
    
    // Create test data
   @testSetup  static void nsvTestData() {
   
    ASeedAccountingSettingsSetupTest.testDataSetup();
        
        Account acc = new Account(Name = 'nsvAccount');
        insert acc;
        
          Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
        
         Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = acc.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), Financing__c = 'Cash', 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert testOpportunity;
        
        
       
        
      
        
        Contract cntrct = new Contract(Name = 'nsvContract', AccountId = acc.Id, Type__c = 'O&M');
        insert cntrct;
        
        Product2 p = new Product2(Name = 'Miscellaneous', IsActive = true);
        insert p;
        
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Account__c = acc.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Branch__c = 'San Diego',PC_Code__c = 10);  // ,PC_Code__c = '10''
        insert testProject;
        
        Map<String, Schema.RecordTypeInfo> rtAssetMap = Schema.SObjectType.Asset.getRecordTypeInfosByName();
        List<Asset> assetList = new List<Asset>();
        assetList.add(new Asset(Name = 'nsvAsset1', AccountId = acc.Id, Product2Id = p.Id, RecordTypeId = rtAssetMap.get('Operations Asset').getRecordTypeId(), Contract__c = cntrct.Id, Component_Type__c = 'Transformer'));//modified by DK to fix deployment error
        assetList.add(new Asset(Name = 'nsvAsset2', AccountId = acc.Id, Product2Id = p.Id, RecordTypeId = rtAssetMap.get('Operations Asset').getRecordTypeId(), Contract__c = cntrct.Id, Component_Type__c = 'BOP'));
        assetList.add(new Asset(Name = 'nsvAsset3', AccountId = acc.Id, Product2Id = p.Id, RecordTypeId = rtAssetMap.get('Operations Asset').getRecordTypeId(), Contract__c = cntrct.Id, Component_Type__c = 'Transformer'));//modified by DK to fix deployment error
        insert assetList;
        
        Map<String, Schema.RecordTypeInfo> rtCaseMap = Schema.SObjectType.Case.getRecordTypeInfosByName();
        Case testCase = new Case(AccountId = acc.Id, ServiceContract_Case__c = cntrct.Id, RecordTypeId = rtCaseMap.get('Performance Investigation').getRecordTypeId()); //,Work_Type__c ='Other'
        insert testCase;
        
        Map<String, Schema.RecordTypeInfo> rtSVMap = Schema.SObjectType.SV__c.getRecordTypeInfosByName();
        SV__c testSV = new SV__c(Account__c = acc.Id, Contract__c = cntrct.Id, Case__c = testCase.Id, Project__c =testProject.Id, RecordTypeId = rtSVMap.get('Reactive').getRecordTypeId());
        insert testSV;
    }
    
    static testMethod void svaTest1() {
        
        SV__c testSV = [select Id from SV__c limit 1];
        
        ApexPages.StandardController std = new ApexPages.StandardController(testSV);
        ApexPages.currentPage().getParameters().put('id', testSV.Id);
        ServiceVisit_AssetCtlExt ctl = new ServiceVisit_AssetCtlExt(std);
        
        List<SelectOption> assetOptions = ctl.getassets();
        system.debug('LOOK HERE' +assetOptions);
        
        if (assetOptions.size() == 1){
        
        system.assertEquals(1, assetOptions.size());}
        else{ 
        system.assertEquals(3, assetOptions.size());
        }
        
        
        String selectedAsset = assetOptions[0].getValue();   //'02i1g000002nWacAAE'; assetOptions[0].getValue()  //
        system.debug('LOOOOOOOK' +selectedAsset );
        ctl.setselectedAsset(selectedAsset);
        selectedAsset = ctl.getselectedAsset();
        system.debug('LOOK HERE' +selectedAsset );
        
        PageReference pr = ctl.assetChanged();
        pr = ctl.assetOfflineChanged();
        pr = ctl.saveAsset();
        
  /*      testSV = [select Id, Asset__c from SV__c];
        system.debug('LOOK HERE' +selectedAsset );
        system.debug('The ID' +testSV.Asset__c);
        system.assertEquals(testSV.Asset__c, selectedAsset ); */
        
        selectedAsset = assetOptions[0].getValue();
        ctl.setselectedAsset(selectedAsset);
        pr = ctl.assetChanged();
        
        selectedAsset = '02i1g000002nWacAAE';
        ctl.setselectedAsset(selectedAsset);
        pr = ctl.assetChanged();
        
        SV__c newSV = new SV__c();
        std = new ApexPages.StandardController(newSV);
        ctl = new ServiceVisit_AssetCtlExt(std);
    }
}