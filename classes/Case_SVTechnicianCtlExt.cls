public with sharing class Case_SVTechnicianCtlExt {
	
	/*
	 *	Controller extension methods to allow setting the Technician field on a set of Service Visit records.
	 */
	
	private ApexPages.StandardSetController stdSetCon;
	
	public List<SV__c> selectedServiceVisits;
	
	public List<SV__c> svList {get; set;}
	public Boolean isError {get; set;}
	
	public Case_SVTechnicianCtlExt(ApexPages.StandardSetController stdSetCon){
		this.stdSetCon = stdSetCon;
		selectedServiceVisits = stdSetCon.getSelected();
		isError = false;
		svList = new List<SV__c>();
		
		Set<Id> svIds = new Set<Id>();
    	for (SV__c sv :selectedServiceVisits) {
    		svIds.add(sv.Id);
    	}
		
		if (!svIds.isEmpty()) {
			svList = [select Id, Case__c, Technician__c from SV__c where Id in :svIds];
		} else {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select at least one Service Visit.'));
    		isError = true;
		}
    }
    
    public PageReference saveServiceVisits() {
    	PageReference pr = null;
    	
    	for (Integer i=1; i<svList.size(); i++) {
    		svList[i].Technician__c = svList[0].Technician__c;
    	}
    	
    	try {
    		update svList;
    		pr = new PageReference('/' + svList[0].Case__c);
    		pr.setRedirect(true);
    	} catch(Exception e) {
    		ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Service Visit exception: ' + e.getMessage()));
    		isError = true;
    	}
    	
    	return pr;
    }
}