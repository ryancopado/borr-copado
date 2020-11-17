public with sharing class NewServiceVisitController {
	
	public List<SelectOption> recordTypeList {get; set;}
    public String selectedRecordTypeId {get; set;}
	public List<SelectOption> assetOptions {get; set;}
	public Boolean showRecordTypes {get; set;}
	public Boolean showAsset {get; set;}
	public Boolean fatalError {get; set;}
	public Boolean isNewServiceVisit {get; set;}

	Case cs;
	String selectedAsset;
	Map<Id, Asset> assetMap;
    String projectId, accountId, contractId, caseId, assetId;
    String projectName, accountName, contractName, caseName, contractType, assetName;
    String assetComponentType;
    String retURL;
    
    public NewServiceVisitController(ApexPages.StandardController stdController) {
		
		caseId = ApexPages.currentPage().getParameters().get('caseId');
		accountId = ApexPages.currentPage().getParameters().get('accId');
		assetId = ApexPages.currentPage().getParameters().get('assetId');
		retURL = '/';
		
		isNewServiceVisit = true;
        showAsset = false;
        showRecordTypes = false;
        fatalError = false;
        
		if (String.isNotBlank(assetId)) {
			List<Asset> assetList = new List<Asset>();
			assetList = [select Id, Name, AccountId, Account.Name, Component_Type__c, Contract__c, Contract__r.Name, Service_Visit_Case__c, Service_Visit_Case__r.CaseNumber, Project__c, Project__r.Name from Asset where Id = :assetId];
			Asset ast = assetList[0];
			assetName = ast.Name;
			accountId = ast.AccountId;
			accountName = ast.Account.Name;
			contractId = ast.Contract__c;
			contractName = ast.Contract__r.Name;
			projectId = ast.Project__c;
            projectName = ast.Project__r.Name;
            assetComponentType = ast.Component_Type__c;
            caseId = ast.Service_Visit_Case__c;
            caseName = ast.Service_Visit_Case__r.CaseNumber;
            
            retURL += assetId;
            
		} else {
			
			List<Case> listOfCases = new List<Case>();
			listOfCases = [select Id, CaseNumber, RecordTypeId, AccountId, Account.Name, ServiceContract_Case__c, ServiceContract_Case__r.ContractNumber, ServiceContract_Case__r.Type__c, Project__c, Project__r.Name from Case where Id = :caseId];
			contractId = null;
			
			if (!listOfCases.isEmpty()) {
				cs = listOfCases[0];
				accountId = cs.Accountid;
				contractId = cs.ServiceContract_Case__c;
				contractName = cs.ServiceContract_Case__r.ContractNumber;
				contractType = cs.ServiceContract_Case__r.Type__c;
				accountName = cs.Account.Name;
				caseName = cs.CaseNumber;
				projectId = cs.Project__c;
				projectName = cs.Project__r.Name;
			}
			
			if (contractId == null) {
				if (accountId != null) {
					Account acc = [select Name from Account where Id = :accountId];
					accountName = acc.name;
					list<Contract> listOfContracts  =[select Id, ContractNumber from Contract where AccountId = :accountId order by CreatedDate desc];
					
					if (listOfContracts != null && listOfContracts.size() > 0) {
						contractId = listOfContracts[0].Id;
						contractName = listOfContracts[0].contractNumber ;
					}
				}
			}
			
			if (String.isNotBlank(caseId)) {
				retURL += caseId;
			} else {
				if (String.isNotBlank(accountId)) {
					retURL += accountId;
				}
			}
		}
    }
	
	public PageReference initSelectLists() {
		PageReference pr = null;
		Boolean allowAssets = true;
		Set<String> rtNames = new Set<String>();
		
		// Create map of allowable Service Vist record types
		Id defaultRtId = null;
		selectedRecordTypeId = null;
		Map<Id, Schema.RecordTypeInfo> rtSVMap = Schema.SObjectType.SV__c.getRecordTypeInfosById();
		Map<Id, String> allowedRtNameMap = new Map<Id, String>();
		for (Schema.RecordTypeInfo rt :rtSVMap.values()) {
			if (rt.isAvailable() && rt.getName() != 'Master') {
				allowedRtNameMap.put(rt.getRecordTypeId(), rt.getName());
				if (rt.isDefaultRecordTypeMapping()) {
					defaultRtId = rt.getRecordTypeId();
				}
			}
		}
		
		// If we are creating Service Visit from an Asset, set Record Type based upon asset Component Type
		if (String.isNotBlank(assetId)) {
			allowAssets = false;
			rtNames.addAll(allowedRtNameMap.values());
			if (String.isNotBlank(assetComponentType)) {
				Map<String, MaintenanceCaseServiceVisits__c> maintCaseSVs = MaintenanceCaseServiceVisits__c.getAll();
				if (maintCaseSVs.containsKey(assetComponentType)) {
					Map<String, Schema.RecordTypeInfo> rtSVNameMap = Schema.SObjectType.SV__c.getRecordTypeInfosByName();
					if (rtSVNameMap.containsKey(maintCaseSVs.get(assetComponentType).Service_Visit_Record_Type__c)) {
						rtNames.clear();
						rtNames.add(maintCaseSVs.get(assetComponentType).Service_Visit_Record_Type__c);
					}
				}
			}
			
		} else {
			
			// If we are creating Service Visit from Case, further restrict record type list
			Map<String, CaseServiceVisitRecordTypes__c> csvrtMap = CaseServiceVisitRecordTypes__c.getAll();
			Map<Id, Schema.RecordTypeInfo> rtCaseMap = Schema.SObjectType.Case.getRecordTypeInfosById();
			if (String.isNotBlank(caseId)) {
				if (csvrtMap.containsKey(rtCaseMap.get(cs.RecordTypeId).getName())) {
					rtNames.addAll(csvrtMap.get(rtCaseMap.get(cs.RecordTypeId).getName()).Service_Visit_Record_Types__c.split(';'));
					allowAssets = csvrtMap.get(rtCaseMap.get(cs.RecordTypeId).getName()).Asset_Selection__c;
				}
			}
		}
		
		for (Id rt :allowedRtNameMap.keySet()) {
			if (!rtNames.contains(allowedRtNameMap.get(rt))) {
				allowedRtNameMap.remove(rt);
			}
		}
		
		if (allowedRtNameMap.containsKey(defaultRtId)) {
			selectedRecordTypeId = defaultRtId;
		}
		
		recordTypeList = new List<SelectOption>();
		for (Id rt :allowedRtNameMap.keySet()) {
			recordTypeList.add(new SelectOption(rt, allowedRTNameMap.get(rt)));
		}
		
		if (!recordTypeList.isEmpty()) {
			if (selectedRecordTypeId == null || recordTypeList.size() == 1) {
				selectedRecordTypeId = String.valueOf(recordTypeList[0].getValue());
			}
			
			if (recordTypeList.size() > 1) {
				showRecordTypes = true;
			}
		} else {
			selectedRecordTypeId = null;
		}
		
		// Create asset select list
		assetOptions = new List<SelectOption>();
		assetMap = new Map<Id, Asset>();
		assetOptions.add(new SelectOption('--None--','--None--'));
		Map<String, Schema.RecordTypeInfo> rtAssetMap = Schema.SObjectType.Asset.getRecordTypeInfosByName();
		if (String.isBlank(assetId)) {
			
			if (allowAssets) {
			    if (String.isNotBlank(projectId)) {
                    if (String.isNotBlank(caseId)) {
                        assetMap = new Map<Id, Asset>([select Id, Name from Asset where Project__c = :projectId and RecordTypeId =: rtAssetMap.get('Operations Asset').getRecordTypeId()]);
                    } else {
                        assetMap = new Map<Id, Asset>([select Id, Name from Asset where Project__c = :projectId]);
                    }
			    } else if (String.isNotBlank(contractId)) {
			        if (String.isNotBlank(caseId)) {
                        assetMap = new Map<Id, Asset>([select Id, Name from Asset where Contract__c = :contractId and RecordTypeId =: rtAssetMap.get('Operations Asset').getRecordTypeId()]);
                    } else {
                        assetMap = new Map<Id, Asset>([select Id, Name from Asset where Contract__c = :contractId]);
                    }
			    }
			    
                for (Asset a :assetMap.values()) {
                    assetOptions.add(new SelectOption(a.Id, a.Name));
                }
			}
			/*
			if (contractId != null && allowAssets) {
				//assetMap = new Map<Id, Asset>([select Id, Name, Contract__c from Asset where Contract__c = :contractId]);
				if (String.isNotBlank(caseId)) {
					assetMap = new Map<Id, Asset>([select Id, Name, Contract__c from Asset where Contract__c = :contractId and RecordTypeId =: rtAssetMap.get('Operations Asset').getRecordTypeId()]);
				} else {
					assetMap = new Map<Id, Asset>([select Id, Name, Contract__c from Asset where Contract__c = :contractId]);
				}
				
				
				for (Asset a :assetMap.values()) {
					assetOptions.add(new SelectOption(a.Id, a.Name));
				}
			}
			*/
			
		} else {
			assetOptions.add(new SelectOption(assetId, assetName));
		}
		
		if (assetOptions.size() > 1) {
			if (assetOptions.size() == 2) {
				selectedAsset = assetOptions[1].getValue();
			} else {
				selectedAsset = assetOptions[0].getValue();
				showAsset = true;
			}
		} else {
			selectedAsset = null;
		}
		
		system.debug('*****initSelectLists showRecordTypes = ' + showRecordTypes + ' recordTypeList.size = ' + recordTypeList.size() + ' showAsset = ' + showAsset + ' allowAssets = ' + allowAssets + ' assetMap.size = ' + assetMap.size() + ' assetOptions.size = ' + assetOptions.size());
		
		// if no need to select record types or assets, take user to the next step
		if (!showRecordTypes && !showAsset) {
			pr = serviceVisitNewEditPage();
		}
		
		return pr;
	}
    
    public String getselectedAsset() {
		return selectedAsset;
	}
	
	public void setselectedAsset(String aId) {
		selectedAsset = aId;
	}
    
	public pageReference serviceVisitNewEditPage(){
		Map<Id, Schema.RecordTypeInfo> rtSVMap = Schema.SObjectType.SV__c.getRecordTypeInfosById();
		pageReference pageRef;
		
		if (String.isBlank(assetId)) {
			if (selectedAsset != '--None--' && assetMap.containsKey(selectedAsset)) {
				assetId = assetMap.get(selectedAsset).Id;
				assetName = assetMap.get(selectedAsset).Name;
			}
		}
		
		if (isNewServiceVisit) {
			if (rtSVMap.containsKey(selectedRecordTypeId) && rtSVMap.get(selectedRecordTypeId).getName() == 'Reactive') {
				
				pageRef = new pageReference('/apex/ServiceVisit_Asset');
				pageRef.getparameters().put('RecordType', selectedRecordTypeId);
				pageRef.getparameters().put('accountId', accountId);
				pageRef.getparameters().put('caseId', caseId);
				pageRef.getparameters().put('contractId', contractId);
				pageRef.getparameters().put('projectId', projectId);
				pageRef.getparameters().put('contractType', contractType);
				pageRef.getparameters().put('assetId', assetId);
				
			} else {
				
				pageRef = new pageReference('/a0c/e');
				Dynamic_Field_Id_Setting__c fieldIds = Dynamic_Field_Id_Setting__c.getOrgDefaults();
				
				if (String.isNotBlank(selectedRecordTypeId)) {
					pageRef.getparameters().put('RecordType', selectedRecordTypeId);
				}
				
				pageRef.getparameters().put('CF' + fieldIds.SV_Account__c + '_lkid', accountId);
				pageRef.getparameters().put('CF' + fieldIds.SV_Account__c, accountName);
				
				pageRef.getparameters().put('CF' + fieldIds.SV_Case__c + '_lkid', caseId);
				pageRef.getparameters().put('CF' + fieldIds.SV_Case__c, caseName);
				
				pageRef.getparameters().put('CF' + fieldIds.SV_Contract__c + '_lkid', contractId);
				pageRef.getparameters().put('CF' + fieldIds.SV_Contract__c, contractName);
				
				pageRef.getparameters().put('CF' + fieldIds.SV_Project__c + '_lkid', projectId);
				pageRef.getparameters().put('CF' + fieldIds.SV_Project__c, projectName);
				
				pageRef.getparameters().put(fieldIds.SV_ContractType__c, contractType);
				
				pageRef.getparameters().put('CF' + fieldIds.SV_Asset__c + '_lkid', assetId);
				pageRef.getparameters().put('CF' + fieldIds.SV_Asset__c, assetName);
			}
		}
		
		pageRef.getparameters().put('retURL', retURL);   
		pageRef.setRedirect(true);     
		return pageRef;
	}
	
	// Record the case record type selected
    public PageReference saveRecordType() {
		PageReference pr = null;
		
		if (selectedRecordTypeId != null) {
			showRecordTypes = false;
			if (!showAsset) {
				pr = serviceVisitNewEditPage();
			}
		} else {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select a record type.'));
		}
		
		return pr;
    }
    
    public PageReference cancelServiceVisit() {
		PageReference pr = new PageReference(retURL);
		return pr;
	}
	
	public PageReference saveAsset() {
		return serviceVisitNewEditPage();
	}
}