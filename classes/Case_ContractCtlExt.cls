public with sharing class Case_ContractCtlExt {
	
	/*
	 *	Case controller for case creation from a contract - creates list of allowable record types
	 *	for selection and pre-populates several fields.
	 *
	 */
	
	public List<SelectOption> recordTypeList {get; set;}
    public String selectedRecordTypeId {get; set;}
	public Boolean fatalError {get; set;}
	public Boolean showRecordTypes {get; set;}
	
	Contract svCon;
	String contractId;
	String caseRecordTypeId;
	String retURL;
	
	public Case_ContractCtlExt(ApexPages.StandardController stdController) {
		
		contractId = ApexPages.currentPage().getParameters().get('contractId');
		caseRecordTypeId = ApexPages.currentPage().getParameters().get('caseRecordTypeId');
		retURL = ApexPages.currentPage().getParameters().get('retURL');
		
		fatalError = false;
		showRecordTypes = false;
		selectedRecordTypeId = null;
		svCon = new Contract();
	}
	
    public PageReference initRecordTypes() {
        PageReference pr = null;
        
        // Verify URL parameters
        if (String.isNotBlank(contractId) && String.isNotBlank(retURL)) {
            
            // Read in our contract record
            svCon = [select Id, ContractNumber, AccountId, ASProject__c, ASProject__r.Name, Branch__c, Contract_Status__c, Type__c from Contract where Id = :contractId];
            
            if (String.isBlank(caseRecordTypeId)) {
                
                if (svCon.Contract_Status__c == 'Active') {
                    
                    // Create map of allowable Case record types
                    Map<String, ContractTypeCaseRecordTypes__c> ctcrtMap = ContractTypeCaseRecordTypes__c.getAll();
                    Map<String, Set<String>> allowedRtMap = new Map<String, Set<String>>();
                    for (String ct :ctcrtMap.keySet()) {
                        allowedRtMap.put(ct, new Set<String>());
                        allowedRtMap.get(ct).addAll(ctcrtMap.get(ct).Case_Record_Types__c.split(';', 0));
                    }
                    
                    // Determine case record type list for user selection
                    Map<Id, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Case.getRecordTypeInfosById();
                    recordTypeList = new List<SelectOption>();
                    for (Id rt: rtMap.keySet()) {
                        if (rtMap.get(rt).isAvailable() && rtMap.get(rt).getName() != 'Master') {
                            if ( (String.isNotBlank(svCon.Type__c)) && 
                                 (allowedRtMap.containsKey(svCon.Type__c)) && 
                                 (allowedRtMap.get(svCon.Type__c).contains(rtMap.get(rt).getName())) ) {
                                
                                recordTypeList.add(new SelectOption(rt, rtMap.get(rt).getName()));
                                if (rtMap.get(rt).isDefaultRecordTypeMapping()) {
                                    selectedRecordTypeId = rt;
                                }
                            }
                        }
                    }
                    
                    if (!recordTypeList.isEmpty()) {
                        if (selectedRecordTypeId == null) {
                            selectedRecordTypeId = String.valueOf(recordTypeList[0].getValue());
                        }
                        
                        if (recordTypeList.size() > 1) {
                            showRecordTypes = true;
                        } else {
                            
                            // Only one case record type available, take user directly to case new/edit page
                            pr = caseNewEditPage();
                        }
                    } else {
                        fatalError = true;
                        ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Contract Type blank or no Case record types assigned.'));
                    }
                    
                } else {
                    fatalError = true;
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Cases can only be created if Contract Status is Active.'));
                }
                
            } else {
                
                selectedRecordTypeId = caseRecordTypeId;
                pr = caseNewEditPage();
            }
			
		} else {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Bad page parameters.'));
			fatalError = true;
		}
		
		return pr;
	}
	
	// Construct the case new/edit page reference
	private PageReference caseNewEditPage() {
		
		Dynamic_Field_Id_Setting__c fieldIds = Dynamic_Field_Id_Setting__c.getOrgDefaults();
		PageReference pageRef = new PageReference('/500/e');
		
		pageRef.getparameters().put('CF' + fieldIds.Case_ServiceContractCase__c, svCon.ContractNumber);
		pageRef.getparameters().put('CF' + fieldIds.Case_ServiceContractCase__c + '_lkid', contractId);
		
		pageRef.getParameters().put('def_account_id', svCon.AccountId);
		
		pageRef.getparameters().put('CF' + fieldIds.Case_Project__c, svCon.ASProject__r.Name);
		pageRef.getparameters().put('CF' + fieldIds.Case_Project__c + '_lkid', svCon.ASProject__c);
		
		pageRef.getparameters().put(fieldIds.Case_Branch__c, svCon.Branch__c);
		
		pageRef.getparameters().put(fieldIds.Case_ContractType__c, svCon.Type__c);
		
		pageRef.getParameters().put('RecordType', selectedRecordTypeId);
		
		pageRef.getParameters().put('retURL', retURL);
		
		pageRef.setRedirect(true);
		return pageRef;
	}
	
	// Record the case record type selected and take the user to the case new/edit page
    public PageReference saveRecordType() {
		PageReference pr = null;
		
		if (selectedRecordTypeId != null) {
			showRecordTypes = false;
			pr = caseNewEditPage();
		} else {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select a record type.'));
		}
		
		return pr;
    }
}