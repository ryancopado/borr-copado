public with sharing class ProjectOpportunityProducts {

/* deactivate as per emily 12/141/18 -- MG
    AcctSeed__Project__c theProject;

    public List<OpportunityLineItem> oppProducts{get;set;}

    public ProjectOpportunityProducts(ApexPages.StandardController stdController) {
        theProject = (AcctSeed__Project__c)stdController.getRecord(); 
        
        
       initOppProduct();
    }
    
    private void initOppProduct(){
        
        oppProducts = [select PricebookEntryId,PricebookEntry.Name, type__c,Quantity,TotalPrice,Owner_Supplied_Product__c from OpportunityLineItem where OpportunityId =: theProject.AcctSeed__Opportunity__c ];
        
    }
    
   deactivate as per emily 12/141/18 -- MG */ 
    

}