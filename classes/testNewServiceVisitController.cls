@isTest
private class testNewServiceVisitController {
	
	/*
	 *	Test methods for NewServiceVisitController
	 *
	 */
	
	// Create test data
	@testSetup static void nsvTestData() {
		
		Dynamic_Field_Id_Setting__c fieldIds = new Dynamic_Field_Id_Setting__c(
    		SetupOwnerId = UserInfo.getOrganizationId(),
    		SV_Account__c = 'field1',
    		SV_Case__c = 'field2',
    		SV_Contract__c = 'field3',
    		SV_Project__c = 'field4',
    		SV_ContractType__c = 'field5',
    		SV_Asset__c = 'field6'
    	);
    	insert fieldIds;
    	
    	Account acc = new Account(Name = 'nsvAccount');
    	insert acc;
    	
    	Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
    	insert con;
    	
    	List<MaintenanceCaseServiceVisits__c> mcsvList = new List<MaintenanceCaseServiceVisits__c>();
    	mcsvList.add(new MaintenanceCaseServiceVisits__c(Name = 'BOP', Default_Technician_Id__c = con.Id, Service_Visit_Record_Type__c = 'PM-Site Grounds'));
    	mcsvList.add(new MaintenanceCaseServiceVisits__c(Name = 'Combiner', Default_Technician_Id__c = con.Id, Service_Visit_Record_Type__c = 'PM-Combiner Box'));
    	mcsvList.add(new MaintenanceCaseServiceVisits__c(Name = 'Communication Cabinet', Default_Technician_Id__c = con.Id, Service_Visit_Record_Type__c = 'PM-Communication Cabinet'));
    	mcsvList.add(new MaintenanceCaseServiceVisits__c(Name = 'DAS', Default_Technician_Id__c = con.Id, Service_Visit_Record_Type__c = 'PM-Weather Station/DAS'));
    	mcsvList.add(new MaintenanceCaseServiceVisits__c(Name = 'Inverter', Default_Technician_Id__c = con.Id, Service_Visit_Record_Type__c = 'PM-Inverters'));
    	mcsvList.add(new MaintenanceCaseServiceVisits__c(Name = 'Solar Array', Default_Technician_Id__c = con.Id, Service_Visit_Record_Type__c = 'PM-Solar Array'));
    	mcsvList.add(new MaintenanceCaseServiceVisits__c(Name = 'Switch Gear', Default_Technician_Id__c = con.Id, Service_Visit_Record_Type__c = 'PM-MV Switchgear'));
    	mcsvList.add(new MaintenanceCaseServiceVisits__c(Name = 'Transformer', Default_Technician_Id__c = con.Id, Service_Visit_Record_Type__c = 'PM-Transformers'));
    	insert mcsvList;
    	
    	List<CaseServiceVisitRecordTypes__c> csvrtList = new List<CaseServiceVisitRecordTypes__c>();
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Construction Closeout', Asset_Selection__c = false, Service_Visit_Record_Types__c = 'Other'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Addtional Services', Asset_Selection__c = true, Service_Visit_Record_Types__c = 'Reactive'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Inspection', Asset_Selection__c = true, Service_Visit_Record_Types__c = 'Reactive'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Landscaping', Asset_Selection__c = false, Service_Visit_Record_Types__c = 'Other'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Maintenance Case', Asset_Selection__c = true, Service_Visit_Record_Types__c = 'PM-Combiners;PM-Inverters;PM-Modules;PM-MV Switchgear;PM-Racking;PM-Site Grounds;PM-Transformers;PM-Weather Station/DAS;PM-Wireways/Conduit'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Module Washing', Asset_Selection__c = false, Service_Visit_Record_Types__c = 'Other'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'O&M Admin Support', Asset_Selection__c = false, Service_Visit_Record_Types__c = 'Other'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Operational Commissioning', Asset_Selection__c = false, Service_Visit_Record_Types__c = 'Other'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Performance Investigation', Asset_Selection__c = true, Service_Visit_Record_Types__c = 'Reactive'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Preoperational Commissioning', Asset_Selection__c = false, Service_Visit_Record_Types__c = 'Other'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Project', Asset_Selection__c = false, Service_Visit_Record_Types__c = 'Other'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Reactive', Asset_Selection__c = true, Service_Visit_Record_Types__c = 'Reactive'));
    	csvrtList.add(new CaseServiceVisitRecordTypes__c(Name = 'Warranty', Asset_Selection__c = true, Service_Visit_Record_Types__c = 'Reactive'));
    	insert csvrtList;
    	
    	Contract cntrct = new Contract(Name = 'nsvContract', AccountId = acc.Id, Type__c = 'O&M');
    	insert cntrct;
    	
    	Product2 p = new Product2(Name = 'Miscellaneous', IsActive = true);
    	insert p;
    	
    	Map<String, Schema.RecordTypeInfo> rtAssetMap = Schema.SObjectType.Asset.getRecordTypeInfosByName();
    	List<Asset> assetList = new List<Asset>();
    	assetList.add(new Asset(Name = 'nsvAsset1', AccountId = acc.Id, Product2Id = p.Id, RecordTypeId = rtAssetMap.get('Operations Asset').getRecordTypeId(), Contract__c = cntrct.Id, Component_Type__c = 'Transformer'));//modified by DK to fix Deployment Error
    	assetList.add(new Asset(Name = 'nsvAsset2', AccountId = acc.Id, Product2Id = p.Id, RecordTypeId = rtAssetMap.get('Operations Asset').getRecordTypeId(), Contract__c = cntrct.Id, Component_Type__c = 'BOP'));
    	insert assetList;
    	
    	Map<String, Schema.RecordTypeInfo> rtCaseMap = Schema.SObjectType.Case.getRecordTypeInfosByName();
    	Case testCase = new Case(AccountId = acc.Id, ServiceContract_Case__c = cntrct.Id, RecordTypeId = rtCaseMap.get('Maintenance Case').getRecordTypeId());
    	insert testCase;
	}
	
	static testMethod void nsvTest1() {
		ApexPages.StandardController std;
		NewServiceVisitController ctl;
		
		SV__c sv = new SV__c();
		Account testAccount = [select Id from Account];
		std = new ApexPages.StandardController(sv);
    	ApexPages.currentPage().getParameters().put('accId', testAccount.Id);
		ctl = new NewServiceVisitController(std);
		
		Case testCase = [select Id from Case];
    	std = new ApexPages.StandardController(sv);
    	ApexPages.currentPage().getParameters().put('caseId', testCase.Id);
		ctl = new NewServiceVisitController(std);
		ctl.initSelectLists();
		ctl.selectedRecordTypeId = ctl.recordTypeList[1].getValue();
		ctl.saveRecordType();
		
		List<Asset> assetList = new List<Asset>();
		assetList = [select Id from Asset];
		ctl.setselectedAsset(assetList[0].Id);
		String selectedAsset = ctl.getselectedAsset();
		ctl.saveAsset();
		
		std = new ApexPages.StandardController(sv);
    	ApexPages.currentPage().getParameters().put('assetId', assetList[0].Id);
		ctl = new NewServiceVisitController(std);
		ctl.initSelectLists();
		ctl.cancelServiceVisit();
	}
}