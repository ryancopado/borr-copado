public with sharing class clsCCSubProducts {
	
	// Controller extension for vfCCSubProducts.page.  Provides mechanism to display Opportunity Products
	// on the Contract Committee Submittal detail page.
	
	List<Project_Products__c> productList = new List<Project_Products__c>();
	public Id ccSubId {get; set;}
	public Contract_Committee_Submittal__c ccSub {get; set;}
    
    public clsCCSubProducts(ApexPages.StandardController controller) {
        
		ccSubId = controller.getrecord().Id;
		ccSub = new Contract_Committee_Submittal__c();
		ccSub = [select Id, Project__c, Are_the_Products_accurate__c from Contract_Committee_Submittal__c where Id = :ccSubId limit 1];
		if (ccSub.Project__c != null) {
			productList = [select Id, Project__c, Product__r.Name, Quantity__c, Site__c, Site__r.Name, Product__r.Family from Project_Products__c where Project__c = :ccSub.Project__c];
		}
    }
    
    public List<Project_Products__c> getProducts() {
		return productList;
	}
	
	/*
	public Boolean accurateProducts {get; set;}
	
	public PageReference verifyProducts() {
		
		if (accurateProducts) {
			ccSub.Are_the_Products_accurate__c = 'Yes';
		} else {
			ccSub.Are_the_Products_accurate__c = 'No';
		}
		
		try {
			update ccSub;
		} catch(Exception e) {
			system.debug('*****Unable to update Contract Committee Submittal, error = ' + e.getMessage());
		}
		
		return null;
	}
	*/
}