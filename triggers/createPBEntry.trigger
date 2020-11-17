trigger createPBEntry on Product2 (after update) {
	
/*		Commented out because now Salesforce automatically adds cloned products to the same Pricebooks 
		that the products being cloned are associated with.  The code below adds the cloned product to
		a pricebook and then Salesforce attempts to add the same product to a pricebook again and an
		error is thrown because the product is already associated with the pricebook.
		Note that by commenting this code out we avoid that error, but we no longer are
		automatically adding the product to a pricebook if the product is manually created.
		
	if(Trigger.isInsert){
		List<Id> prodID = new List<Id>();
		for(Integer i = 0; i<Trigger.new.size(); i++){
			prodID.add(Trigger.new[i].Id);
		}
		PricebookEntry[] pbe = [select Id, UnitPrice, isActive, Product2Id from PricebookEntry where Product2Id in :prodID];
		if(pbe.size() == 0) {
			createPBEntry.addEntry(Trigger.new);
		}
	}
*/

	if(Trigger.isUpdate) {
		List<Product2> upProd = new List<Product2>();
		for(Integer i = 0; i<Trigger.new.size(); i++){
			if(Trigger.new[i].Cost__c != Trigger.old[i].Cost__c){
				upProd.add(Trigger.new[i]);
			}
		}
		if(upProd.size() > 0){
			createPBEntry.upEntry(upProd);
		}
	}
}