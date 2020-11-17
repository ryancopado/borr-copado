public with sharing class Asset_ServiceVisitCtlExt {
	
	/*
	 *	Asset controller for asset creation from a Service Visit - creates a new asset with record type "Operations Asset"
	 *	and pre-populates several fields from the Service Visit record.
	 *
	 */
	
	public Boolean fatalError {get; set;}
	public String retURL {get; set;}
	
	String serviceVisitId;
	SV__c serviceVisit;
	
	public Asset_ServiceVisitCtlExt(ApexPages.StandardController stdController) {
		
		serviceVisitId = ApexPages.currentPage().getParameters().get('serviceVisitId');
		retURL = ApexPages.currentPage().getParameters().get('retURL');
		
		fatalError = false;
	}
	
	public PageReference initRecordTypes() {
		PageReference pr = null;
		
		// Verify URL parameters
		if (String.isNotBlank(serviceVisitId) && String.isNotBlank(retURL)) {
			
			// Verify user has permissions to create an asset record with record type "Operations Asset"
			Map<String, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Asset.getRecordTypeInfosByName();
			if (rtMap.containsKey('Operations Asset') && rtMap.get('Operations Asset').isAvailable()) {
			
				// Read in our service visit record
				List<SV__c> svList = new List<SV__c>();
				svList = [select Id, Account__c, Account__r.Name, Case__c, Case__r.CaseNumber, Contract__c, Contract__r.ContractNumber, Project__c, Project__r.Name from SV__c where Id = :serviceVisitId];
				serviceVisit = svList[0];
				
				// Get the dummy product record to use for the Product lookup field on the new Asset
				String productName = '';
				List<Product2> productList = new List<Product2>();
				productList = [select Id, Name from Product2 where Name = 'Miscellaneous' and IsActive = true limit 1];
				if (!productList.isEmpty()) {
					productName = productList[0].Name;
				}
				
				// Take user to new Asset page with pre-populated fields
				pr = new pageReference('/02i/e');
				
				Dynamic_Field_Id_Setting__c fieldIds = Dynamic_Field_Id_Setting__c.getOrgDefaults();
				pr.getparameters().put('RecordType', rtMap.get('Operations Asset').getRecordTypeId());
				pr.getparameters().put('Account', serviceVisit.Account__r.Name);
				pr.getparameters().put('Product2', productName);
				pr.getparameters().put('Name', '');
				pr.getparameters().put('CF' + fieldIds.Asset_ServiceVisitCase__c + '_lkid', serviceVisit.Case__c);
				pr.getparameters().put('CF' + fieldIds.Asset_ServiceVisitCase__c, serviceVisit.Case__r.CaseNumber);
				pr.getparameters().put('CF' + fieldIds.Asset_Project__c + '_lkid', serviceVisit.Project__c);
				pr.getparameters().put('CF' + fieldIds.Asset_Project__c, serviceVisit.Project__r.Name);
				pr.getparameters().put('CF' + fieldIds.Asset_Contract__c + '_lkid', serviceVisit.Contract__c);
				pr.getparameters().put('CF' + fieldIds.Asset_Contract__c, serviceVisit.Contract__r.ContractNumber);
				pr.getparameters().put(fieldIds.Asset_ProductWarrantyStartDate__c, system.today().format());
				pr.getparameters().put('retURL', retURL);   
				pr.setRedirect(true);

			} else {
				ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Insufficient privileges - Operations Asset record type not available.'));
				fatalError = true;
			}
			
		} else {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Bad page parameters.'));
			fatalError = true;
			if (String.isBlank(retURL)) {
				retURL = '/';
			}
		}
		
		return pr;
	}
}