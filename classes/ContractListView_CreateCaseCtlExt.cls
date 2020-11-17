public with sharing class ContractListView_CreateCaseCtlExt {
	
	private ApexPages.StandardSetController stdSetCon;
	
	public List<Contract> selectedContracts;
	
	private String listViewFilterId;
	
	public ContractListView_CreateCaseCtlExt(ApexPages.StandardSetController stdSetCon){
		this.stdSetCon = stdSetCon;
		selectedContracts = stdSetCon.getSelected();
		listViewFilterId = stdSetCon.getFilterId();
	}
	
	public PageReference createCase() {
    	PageReference pr = null;
    	
    	if (selectedContracts.size() == 1) {
    		
			pr = new PageReference('/apex/Case_Contract?contractId=' + selectedContracts[0].Id + '&retURL=/apex/Case_Tab');
			pr.setRedirect(true);
    		
    	} else {
    		ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select only one Contract.'));
    	}
    	
    	return pr;
	}
}