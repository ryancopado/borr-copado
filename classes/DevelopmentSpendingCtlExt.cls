public with sharing class DevelopmentSpendingCtlExt {
	private final List<Development_Spending__c> devSpendSelected;
	public String retURL {get; set;}
	
	public DevelopmentSpendingCtlExt(ApexPages.StandardSetController controller) {
		this.devSpendSelected = (List<Development_Spending__c>)controller.getSelected(); 
	}    
	
	public ApexPages.StandardSetController devSpendRecords {
		get {
			if (devSpendRecords == null) {
				//List<Development_Spending__c> dsSelected = (List<Development_Spending__c>)controller.getSelected();
				devSpendRecords = new ApexPages.StandardSetController(
					Database.getQueryLocator([SELECT Id, Name, Approved__c, LineItem__c, Requested_Amount__c FROM Development_Spending__c WHERE Id IN :devSpendSelected]));
			}
			return devSpendRecords;
		}
		private set;
	}
	public List<Development_Spending__c> getDevSpendRecs() {
		return (List<Development_Spending__c>)devSpendRecords.getRecords();
	}
	
	// Mark the Development Spending records selected approved and add the Requested Amount to the associated Line Item 
	public PageReference approveDevSpending() {
		List<Development_Spending__c> dsList;
		Map<Id, AcctSeed__Project_Task__c> liMap;
		List<Id> liIds = new List<Id>();
		PageReference pr;
		Boolean alreadyApproved = false;
		
		retURL = ApexPages.currentPage().getParameters().get('retURL');
		dsList = getDevSpendRecs();
		for (Development_Spending__c ds :dsList) {
			if (ds.Approved__c) {
				alreadyApproved = true;
			}
		}
		
		system.debug('*****DevelopmentSpendingCtlExt dsList.size = ' + dsList.size() + ' retURL = ' + retURL);
		
		if (!dsList.isEmpty() && (!alreadyApproved)) {
			for (Development_Spending__c ds :dsList) {
				ds.Approved__c = true;
				if (ds.LineItem__c != null) {
					liIds.add(ds.LineItem__c);
				}
			}
			
			if (!liIds.isEmpty()) {
				liMap = new Map<Id, AcctSeed__Project_Task__c>([select Id, Approved_Development_Amount__c from AcctSeed__Project_Task__c where Id in :liIds]);
				for (Development_Spending__c ds :dsList) {
					if (liMap.containsKey(ds.LineItem__c)) {
						if (liMap.get(ds.LineItem__c).Approved_Development_Amount__c == null) {
							liMap.get(ds.LineItem__c).Approved_Development_Amount__c = 0;
						}
						if (ds.Requested_Amount__c != null) {
							liMap.get(ds.LineItem__c).Approved_Development_Amount__c += ds.Requested_Amount__c;
						}
					}
				}
				update liMap.values();
			}
			update dsList;
			pr = new PageReference(retURL);
		} else {
			// Error - no records selected or one or more selected is already approved
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Must select unapproved Development Spending records.'));
			pr = null;
		}
		
		system.debug('*****DevelopmentSpendingCtlExt pr = ' + pr);
		return pr;
	}  
}