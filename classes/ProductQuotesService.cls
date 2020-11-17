public class ProductQuotesService {
	
	/*
	 *	Service methods for ProductQuotesTrigger.trigger
	 *
	 */
	
	// Set various fields on Product Quotes records upon insert
	// - before insert
	public static void setFieldsOnCreate(List<Product_Quotes__c> newList) {
		Set<Id> itIds = new Set<Id>();
		
		for (Product_Quotes__c pq :newList) {
			if (pq.Issue_Tracker__c != null) {
				itIds.add(pq.Issue_Tracker__c);
			}
		}
		
		if (!itIds.isEmpty()) {
			Map<Id, Request_for_Information_RFI__c> itMap = new Map<Id, Request_for_Information_RFI__c>([select Id, Name, ASProject__c 
					from Request_for_Information_RFI__c where Id in :itIds]);
			
			for (Product_Quotes__c pq :newList) {
				if (itMap.containsKey(pq.Issue_Tracker__c)) {
					pq.Project__c = itMap.get(pq.Issue_Tracker__c).ASProject__c;
				}
			}
		}
	}
}