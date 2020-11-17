public with sharing class ServiceVisit_ProjectCtlExt {
	
	/*
	 *	Service Visit controller extension - allows user to select a project and then to
	 *	select an active contract from a list of contracts related to the project.
	 *
	 */
	
	ApexPages.StandardController stdController;
	
	public SV__c serviceVisit {get; set;}
	public Boolean fatalError {get; set;}
	
	String selectedContract;
	
	public ServiceVisit_ProjectCtlExt(ApexPages.StandardController stdController) {
		
		try {
			this.serviceVisit = (SV__c)stdController.getRecord();
			this.serviceVisit = [select Id, Name, Project__c, Contract__c, Contract__r.ContractNumber from SV__c where Id = :this.serviceVisit.Id];
			fatalError = false;
		} catch(Exception e) {
			fatalError = true;
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Fatal error: ' + e.getMessage()));
		}
	}
	
	public List<SelectOption> getcontracts() {
		List<SelectOption> contractOptions = new List<SelectOption>();
		List<Contract> contractList = new List<Contract>();
		
		selectedContract = null;
		contractOptions.add(new SelectOption('--None--','--None--'));
		if (serviceVisit.Project__c != null) {
			contractList = [select Id, ContractNumber, ASProject__c, Contract_Status__c from Contract where ASProject__c = :serviceVisit.Project__c and Contract_Status__c = 'Active' order by ContractNumber];
			for (Contract c :contractList) {
				contractOptions.add(new SelectOption(c.Id, c.ContractNumber));
				if (serviceVisit.Contract__c == c.Id) {
					selectedContract = c.Id;
				}
			}
			
			if (selectedContract == null) {
				if (serviceVisit.Contract__c != null) {
					contractOptions.add(new SelectOption(serviceVisit.Contract__c, serviceVisit.Contract__r.ContractNumber));
					selectedContract = serviceVisit.Contract__c;
				} else {
					selectedContract = (contractOptions.size() == 2) ? contractOptions[1].getValue() : contractOptions[0].getValue();
				}
			}
		}
		
		return contractOptions;
	}
	
	public String getselectedContract() {
		return selectedContract;
	}
	
	public void setselectedContract(String cId) {
		selectedContract = cId;
	}
	
	public PageReference projectChanged() {
		serviceVisit.Contract__c = null;
		return null;
	}
	
	public PageReference saveServiceVisit() {
		PageReference pr = null;
		
		if (selectedContract == '--None--') {
			selectedContract = null;
		}
		
		serviceVisit.Contract__c = selectedContract;
		try {
			update serviceVisit;
			pr = new PageReference('/' + serviceVisit.Id);
			pr.setRedirect(true);
		} catch(Exception e) {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Service Visit save exception: ' + e.getMessage()));
		}
		
		return pr;
	}
}