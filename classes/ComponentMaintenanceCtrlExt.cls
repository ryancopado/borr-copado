public with sharing class ComponentMaintenanceCtrlExt {
	
	/*
	 *	Component with Maintenance Item controller extension. Includes methods
	 *	that support creating and editing Component and all related Maintenance Item 
	 *	records on a single page.
	 *
	 */
	
	ApexPages.StandardController stdController;
	private final Component__c comp;
	public Component__c component {get; set;}
	public List<Maintenance_Item__c> miList {get; set;}
	public Boolean isNew {get; set;}
	Id caseId;
    
    public ComponentMaintenanceCtrlExt(ApexPages.StandardController stdController) {
		
		this.comp = (Component__c)stdController.getRecord();
		component = new Component__c();
		miList = new List<Maintenance_Item__c>();
		
		if (this.comp.Id == null) {
			
			isNew = true;
			caseId = ApexPages.currentPage().getParameters().get('caseId');
			component.Case__c = caseId;
			
		} else {
    	    
			// Read in the Component and related Maintenance Item records
			isNew = false;
			component = [select Id, Name, Case__c, Component_Type__c, Summary__c from Component__c where Id = :this.comp.Id];
			caseId = component.Case__c;
			miList = [select Id, Name, Component_Type__c, Item__c, Completed__c, Follow_Up_Required__c, Notes__c, Component__c from Maintenance_Item__c where Component__c = :this.comp.Id];
		}
    }
    
    // Save the updated Component and Maintenance Item records
    public PageReference saveAll() {
    	PageReference pr = null;
    	
    	try {
    		upsert component;
    		if (isNew) {
    			pr = new PageReference('/apex/ComponentMaintenance_edit?scontrolCaching=1&id=' + component.Id);
    		} else {
    			if (!miList.isEmpty()) {
    				update miList;
    			}
    			pr = new PageReference('/' + component.Id);
    		}
    		pr.setRedirect(true);
    	} catch(Exception e) {
    		ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Exception during saveAll: ' + e.getMessage()));
    	}
    	return pr;
    }
    
    public PageReference saveAndNew() {
    	PageReference pr = null;
    	
    	try {
    		upsert component;
    		if (!miList.isEmpty()) {
    			update miList;
    		}
    		pr = new PageReference('/apex/ComponentMaintenance_edit?caseId=' + caseId + '&retURL=/' + caseId);
    		pr.setRedirect(true);
    	} catch(Exception e) {
    		ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Exception during saveAndNew: ' + e.getMessage()));
    	}
    	return pr;
    }
    
    public PageReference saveComponent() {
    	PageReference pr = null;
    	
    	try {
    		insert component;
    		pr = new PageReference('/' + component.Id);
    		pr.setRedirect(true);
    	} catch(Exception e) {
    		ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Exception during saveComponent: ' + e.getMessage()));
    	}
    	return pr;
    }
}