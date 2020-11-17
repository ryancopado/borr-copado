public with sharing class Opportunity_SiteControllerExt {
	
	/*
	 *	Controller extension for the Opportunity detail page.
	 *
	 *	Methods to display Site information from related Opportunities.
	 *
	 */
	
	ApexPages.StandardController stdController;
	
	public List<Site__c> sites {get; set;}
	public Opportunity oppty {get; set;}
	
	public Opportunity_SiteControllerExt(ApexPages.StandardController stdController) {
		
		List<Opportunity> relOppList = new List<Opportunity>();
		Set<Id> oIds = new Set<Id>();
		
		this.oppty = (Opportunity)stdController.getRecord();
		relOppList = [select Id, Name, Offtaker_Opportunity__c, Offtaker_Opportunity_2__c from Opportunity where Offtaker_Opportunity__c = :this.oppty.Id or Offtaker_Opportunity_2__c = :this.oppty.Id];
		for (Opportunity o :relOppList) {
			oIds.add(o.Id);
		}
		sites = new List<Site__c>();
		sites = [select Id, Name, Available_Area__c, Project_Size_Watts_STC__c, Type__c, Utility_Zone__c from Site__c where Opportunity__c in :oIds];
	}
}