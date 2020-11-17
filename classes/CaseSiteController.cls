public with sharing class CaseSiteController {
	
	/*
	 *	Case controller for Project selection on a case record (used to be for Site selection on a case)
	 *
	 */
	
	private final Case cr;
	
	public Case caseRec {get; set;}
	public List<SelectOption> recordTypeList {get; Set;}
    public String selectedRecordTypeId {get; Set;}
    public Boolean showRecordTypes {get; set;}
	public Boolean isNewCase {get; set;}
	public Boolean fatalError {get; set;}
	
	Map<Id, String> projectNameMap;
	String caseId;
	String accountId;
	String assetId;
	String contractId;
	String contractNumber;
	String contractBranch;
	String recordTypeId;
	String retURL;
	//Boolean showAsset;
	//Boolean assetRequired;
	//private List<SelectOption> assets;
	private String selectedProject;
	//private String selectedAsset;
	
	public CaseSiteController(ApexPages.StandardController stdController) {
		
		projectNameMap = new Map<Id, String>();
		caseRec = new Case();
		
		caseId = ApexPages.currentPage().getParameters().get('caseId');
		accountId = ApexPages.currentPage().getParameters().get('accountId');
		//assetId = ApexPages.currentPage().getParameters().get('assetId');
		contractId = ApexPages.currentPage().getParameters().get('contractId');
		recordTypeId = ApexPages.currentPage().getParameters().get('RecordType');
		retURL = ApexPages.currentPage().getParameters().get('retURL');

		selectedProject = '--None--';
		//selectedAsset = '--None--';
		contractNumber = '';
		contractBranch = '';
		showRecordTypes = false;
		fatalError = false;
		selectedRecordTypeId = null;
		recordTypeList = new List<SelectOption>();
		
		if (String.isNotBlank(caseId)) {
			isNewCase = false;
			caseRec = [select Id, CaseNumber, AccountId, AssetId, Project__c from Case where Id = :caseId];
			accountId = caseRec.AccountId;
			if (caseRec.Project__c != null) {
				selectedProject = caseRec.Project__c;
			}
			/*
			if (caseRec.AssetId != null) {
				selectedAsset = caseRec.AssetId;
			}
			*/
			
		} else {
			isNewCase = true;
			if (String.isNotBlank(accountId)) {
				caseRec.AccountId = accountId;
			}
			/*
			if (String.isNotBlank(assetId)) {
				Asset assetRec = [select Id, AccountId, Project__c from Asset where Id = :assetId];
				caseRec.AccountId = assetRec.AccountId;
				if (assetRec.Project__c != null) {
					selectedProject = assetRec.Project__c;
				}
				selectedAsset = assetRec.Id;
			}
			*/
			
			// Create allowed record type map based upon user profile
			Map<Id, String> rtNameMap = new Map<Id, String>();
			Map<Id, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Case.getRecordTypeInfosById();
			Id defaultRecordTypeId = null;
			for (Id rt: rtMap.keySet()) {
				if (rtMap.get(rt).isAvailable() && rtMap.get(rt).getName() != 'Master') {
					rtNameMap.put(rt, rtMap.get(rt).getName());
					if (rtMap.get(rt).isDefaultRecordTypeMapping()) {
						defaultRecordTypeId = rt;
					}
				}
			}
			
			if (!rtNameMap.isEmpty()) {
				
				// If we have a contract Id, base default case record types and field values on contract data
				if (String.isNotBlank(contractId)) {
					Contract contractRec = new Contract();
					contractRec = [select Id, ContractNumber, AccountId, ASProject__c, Branch__c, Type__c from Contract where Id = :contractId];
					contractNumber = contractRec.ContractNumber;
					contractBranch = contractRec.Branch__c;
					caseRec.AccountId = contractRec.AccountId;
					if (contractRec.ASProject__c != null) {
						selectedProject = contractRec.ASProject__c;
					}
					
					// Create map of allowable Case record types based upon contract type
					Map<String, ContractTypeCaseRecordTypes__c> ctcrtMap = ContractTypeCaseRecordTypes__c.getAll();
    				Map<String, Set<String>> allowedRtMap = new Map<String, Set<String>>();
    				for (String ct :ctcrtMap.keySet()) {
    					allowedRtMap.put(ct, new Set<String>());
    					allowedRtMap.get(ct).addAll(ctcrtMap.get(ct).Case_Record_Types__c.split(';', 0));
    				}
    				
    				if (String.isNotBlank(contractRec.Type__c) && allowedRtMap.containsKey(contractRec.Type__c)) {
    					for (Id rt: rtNameMap.keySet()) {
    						if (!allowedRtMap.get(contractRec.Type__c).contains(rtNameMap.get(rt))) {
    							rtNameMap.remove(rt);
    						}
    					}
					} else {
						rtNameMap.clear();
					}
				}
				
				if (!rtNameMap.isEmpty()) {
					for (Id rt: rtNameMap.keySet()) {
						recordTypeList.add(new SelectOption(rt, rtNameMap.get(rt)));
					}
					
					if (rtNameMap.containsKey(defaultRecordTypeId)) {
						selectedRecordTypeId = defaultRecordTypeId;
					} else {
						selectedRecordTypeId = String.valueOf(recordTypeList[0].getValue());
					}
					
					if (recordTypeList.size() == 1) {
						recordTypeId = selectedRecordTypeId;
					} else {
						showRecordTypes = true;
					}
				} else {
					fatalError = true;
        			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No assigned Case record types for Contract Type.'));
				}
					
			} else {
				fatalError = true;
        		ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'User profile has no assigned Case record types.'));
			}
		}
	}
	
	// Record the case record type selected
    public PageReference saveRecordType() {
		
		if (selectedRecordTypeId != null) {
			recordTypeId = selectedRecordTypeId;
			showRecordTypes = false;
		} else {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select a record type.'));
		}
		
		return null;
    }
    
    /*
    // Determine if we should show the Asset field
    public Boolean getshowAsset() {
    	
    	showAsset = true;
		assetRequired = false;
		
		Map<Id,Schema.RecordTypeInfo> rtByIdMap = Schema.SObjectType.Case.getRecordTypeInfosById();
		if (rtByIdMap.containsKey(recordTypeId)) {
			String rtName = rtByIdMap.get(recordTypeId).getName();
			if (rtName == 'Operational Commissioning' || rtName == 'Preoperational Commissioning' || rtName == 'Landscaping' || rtName == 'Maintenance Case' || rtName == 'Project' || rtname == 'Module Washing') {
				showAsset = false;
			} else {
				if (rtName == 'Performance Investigation' || rtName == 'Construction Closeout' || rtName == 'Reactive') {
					assetRequired = true;
				}
			}
		}
		
		return showAsset;
    }
    */
	
	// Project selection
	public List<SelectOption> getProjectOptions() {
		List<SelectOption> projects = new List<SelectOption>();
		projects.add(new SelectOption('--None--','--None--'));
		
		if (caseRec.AccountId != null) {
			List<AcctSeed__Project__c> projList = new List<AcctSeed__Project__c>();
			projectNameMap.clear();
			
			projList = [select Id, Name from AcctSeed__Project__c where AcctSeed__Account__c = :caseRec.AccountId];
			
			for (AcctSeed__Project__c p :projList) {
				projects.add(new SelectOption(p.Id, p.Name));
				projectNameMap.put(p.Id, p.Name);
			}
		}
		return projects;
	}
	
	public String getselectedProject() {
		return selectedProject;
	}
	
	public void setselectedProject(String pId) {
		selectedProject = pId;
	}
	
	/*
	// Asset selection
	public List<SelectOption> getAssetOptions() {
		assets = new List<SelectOption>();
		assets.add(new SelectOption('--None--','--None--'));
		
		if (selectedProject != '--None--') {
			List<Asset> assetList = new List<Asset>();
			assetList = [select Id, Name, Project__c from Asset where Project__c = :selectedProject];
			
			for (Asset a :assetList) {
				assets.add(new SelectOption(a.Id, a.Name));
			}
		}
		
		return assets;
	}
	
	public String getselectedAsset() {
		return selectedAsset;
	}
	
	public void setselectedAsset(String aId) {
		selectedAsset = aId;
	}
	*/
	
	public PageReference changeAccount() {
		selectedProject = '--None--';
		//selectedAsset = '--None--';
		return null;
	}
	
	public PageReference changeProject() {
		//selectedAsset = '--None--';
		return null;
	}
	
	public PageReference cancelProject() {
		String prURL;
		
		if (caseRec.Id != null) {
			prURL = '/' + caseRec.Id;
		} else {
			if (String.isNotBlank(retURL)) {
				prURL = retURL;
			} else {
				prURL = '/';
			}
		}
		
		PageReference pr = new PageReference(prURL);
		return pr;
	}
	
	public PageReference saveProject() {
		
		PageReference pr = null;
		
		if (selectedProject == '--None--') {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You must select a Project.'));
		/*
		if (selectedProject == '--None--' || (assetRequired && assets.size() > 1 && selectedAsset == '--None--')) {
			String requiredFields = '';
			String errMessage = 'You must select';
			if (selectedProject == '--None--') {
				requiredFields += ' a Project';
			}
			if (assetRequired && assets.size() > 1 && selectedAsset == '--None--') {
				if (String.isNotBlank(requiredFields)) {
					requiredFields += ' and';
				}
				requiredFields += ' an Asset';
			}
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, errMessage + requiredFields + '.'));
			*/
			
		} else {
			
			caseRec.Project__c = selectedProject;
			/*
			if (selectedAsset == '--None--') {
				caseRec.AssetId = null;
			} else {
				caseRec.AssetId = selectedAsset;
			}
			*/
			
			if (caseRec.Id != null) {
				
				// Save the potentially new Account, Project, and Asset on an existing case
				try {
					update caseRec;
					pr = new PageReference('/' + caseRec.Id);
				} catch(Exception e) {
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Exception while saving Case = ' + e.getMessage()));
				}
			
			} else {
				
				// Prepopulate the selected Account, Project, Contract, and Branch on a new case
				accountId = caseRec.AccountId;
				/*
				assetId = caseRec.AssetId;
				if (assetId == null) {
					assetId = '';
				}
				*/
				String contractParam = '';
				if (String.isNotBlank(contractNumber)) {
					contractParam = '&CF00N80000004MmKj=' + contractNumber + '&CF00N80000004MmKj_lkid=' + contractId;
				}
				String branchParam = '';
				if (String.isNotBlank(contractBranch)) {
					branchParam = '&00N300000016noV=' + contractBranch;
				}
				//pr = new PageReference('/500/e?retURL=/' + retURL + '&def_account_id=' + accountId + '&def_asset_id=' + assetId + '&RecordType=' + recordTypeId + '&CF00N34000005Wzal=' + projectNameMap.get(selectedProject) + '&CF00N34000005Wzal_lkid=' + selectedProject + contractParam + branchParam + '&ent=Case');
				pr = new PageReference('/500/e?retURL=/' + retURL + '&def_account_id=' + accountId + '&RecordType=' + recordTypeId + '&CF00N34000005Wzal=' + projectNameMap.get(selectedProject) + '&CF00N34000005Wzal_lkid=' + selectedProject + contractParam + branchParam + '&ent=Case');
			}
		}
		return pr;
	}
}