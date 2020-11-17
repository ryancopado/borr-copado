public with sharing class CaseMaintenanceReportController {
	
	// Methods to create a Case Maintenance Report pdf from a Case record and send it as an email attachment.
	
	ApexPages.StandardController stdController;
	public Case cmrCase {get; set;}
	public List<Component__c> componentList {get; set;}
	public Map<String, List<Maintenance_Item__c>> nonConformanceMap {get; set;}
	public List<String> nonConformanceComponents {get; set;}
	public Map<String, ComponentSummary> cmpSummaryMap {get; set;}
	public List<String> cmpSummaryMapKeys {get; set;}
	
	// Constructor
	public CaseMaintenanceReportController(ApexPages.StandardController stdController) {
		
		// Get the data for the maintenance report - case, components, photo attachments, maintenance items
		this.cmrCase = (Case)stdController.getRecord();
		cmrCase = [select Id, CaseNumber, Account.Name, Account.Logo_Document_Name__c, Contact.Name, Contact.Email, Contact.Phone, Owner.Name, Site__r.Name, 
				Maintenance_Type__c, CreatedDate, Performance_Maintenance_Introduction__c, Performance_Maintenance_Conclusion__c 
				from Case where Id = :this.cmrCase.Id];
		
		componentList = new List<Component__c>();
		componentList = [select Id, Name, Case__c, Component_Type__c, Summary__c 
				from Component__c where Case__c = :cmrCase.Id];
		List<Id> cmpIds = new List<Id>();
		for (Component__c c :componentList) {
			cmpIds.add(c.Id);
		}
		
		List<Maintenance_Item__c> maintenanceList = new List<Maintenance_Item__c>();
		maintenanceList = [select Id, Name, Component__c, Component_Type__c, Item__c, Completed__c, 
				Follow_Up_Required__c, Notes__c from Maintenance_Item__c where Component__c in :cmpIds];
		
		// Create the non-conformance maintenance item map
		nonConformanceMap = new Map<String, List<Maintenance_Item__c>>();
		nonConformanceComponents = new List<String>();
		for (Maintenance_Item__c mi :maintenanceList) {
			if (mi.Follow_Up_Required__c == 'Yes' || mi.Follow_Up_Required__c == 'Performed during visit') {
				if (!nonConformanceMap.containsKey(mi.Component_Type__c)) {
					nonConformanceMap.put(mi.Component_Type__c, new List<Maintenance_Item__c>());
				}
				nonConformanceMap.get(mi.Component_Type__c).add(mi);
			}
		}
		nonConformanceComponents.addAll(nonConformanceMap.keySet());
		
		// Create the component summary list
		List<Attachment> cmpAttList = new List<Attachment>();
		cmpAttList = [select Id, ParentId from Attachment where ParentId in :cmpIds];
		List<Id> cmpAttIds = new List<Id>();
		List<Maintenance_Item__c> cmpCheckList = new List<Maintenance_Item__c>();
		cmpSummaryMap = new Map<String, ComponentSummary>();
		for (Component__c c :componentList) {
			cmpAttIds.clear();
			for (Attachment a :cmpAttList) {
				if (c.Id == a.ParentId) {
					cmpAttIds.add(a.Id);
				}
			}
			
			cmpCheckList.clear();
			for (Maintenance_Item__c m :maintenanceList) {
				if (c.Id == m.Component__c && m.Completed__c) {
					cmpCheckList.add(m);
				}
			}
			
			cmpSummaryMap.put(c.Component_Type__c, new ComponentSummary(c, cmpAttIds, cmpCheckList));
		}
		cmpSummaryMapKeys = new List<String>();
		cmpSummaryMapKeys.addAll(cmpSummaryMap.keySet());
	}
	
	// Get the URL of the document logo to include in the case maintenance report pdf
	public string getDocumentLogoUrl() {
		String instance;
		String strDocURL;
		String documentName = 'Borrego Logo - Transparent';
		
		if (String.isNotBlank(cmrCase.Account.Logo_Document_Name__c)) {
			documentName = cmrCase.Account.Logo_Document_Name__c;
		}
		
		List<Document> lstDocument = [select Id, Name from Document where Name = :documentName limit 1];
		
		instance = URL.getSalesforceBaseUrl().getHost().substringBefore('.');
		strDocURL = 'https://c.' + instance + '.content.force.com/servlet/servlet.FileDownload?file=';
		if (!Test.isRunningTest()) {
			strDocURL += lstDocument[0].Id;
		}
		
		return strDocUrl;
	}
	
	public class ComponentImage {
		public Id imageLeftId {get; set;}
		public Id imageRightId {get; set;}
		
		public ComponentImage() {
			imageLeftId = null;
			imageRightId = null;
		}
		
		public ComponentImage(Id leftId, Id rightId) {
			imageLeftId = leftId;
			imageRightId = RightId;
		}
	}
	
	public class ComponentSummary {
		public Component__c cmp {get; set;}
		public List<ComponentImage> cmpImages {get; set;}
		public List<Maintenance_Item__c> checkListItems {get; set;}
		
		public ComponentSummary() {
			cmp = new Component__c();
			cmpImages = new List<ComponentImage>();
			checklistItems = new List<Maintenance_Item__c>();
		}
		
		public ComponentSummary(Component__c c, List<Id> ciIdList, List<Maintenance_Item__c> miList) {
			cmp = new Component__c(
				Id = c.Id,
				Component_Type__c = c.Component_Type__c,
				Summary__c = c.Summary__c
			);
			
			cmpImages = new List<ComponentImage>();
			Id rightId;
			for (Integer i=0; i<ciIdList.size(); i+=2) {
				if (i+1 < ciIdList.size()) {
					rightId = ciIdList[i+1];
				} else {
					rightId = null;
				}
				cmpImages.add(new ComponentImage(ciIdList[i], rightId));
			}
			checkListItems = new List<Maintenance_Item__c>();
			checkListItems.addAll(miList);
		}
	}
}