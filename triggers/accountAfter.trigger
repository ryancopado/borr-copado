trigger accountAfter on Account (after update) {
	
	/*
	 *	If the Branch field has changed, set the Service Job Number on all related Contracts
	 */
	
	List<Id> aIds = new List<Id>();
	
	for (Account a :trigger.new) {
		if (a.Branch__c != null && a.Branch__c != trigger.oldMap.get(a.Id).Branch__c) {
			aIds.add(a.Id);
		}
	}
	
	if (!aIds.isEmpty()) {
		List<Contract> cList = new List<Contract>();
		cList = [select Id, AccountId, Acct_Branch__c, Contract_Number__c from Contract where AccountId in :aIds];
		if (!cList.isEmpty()) {
			contractNum.create(cList);
		}
	}
}