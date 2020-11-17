trigger solSetPm on AcctSeedERP__Sales_Order_Line__c (before insert, before update) { // , after insert, after update
    
    List<String> projectIds = new List<String>();
    for(AcctSeedERP__Sales_Order_Line__c so : Trigger.new) {
    	if(so.AcctSeedERP__Project__c != null) {
    		projectIds.add(so.AcctSeedERP__Project__c);
    	}
    }
    Map<id,AcctSeed__Project__c> projectMap = new Map<id,AcctSeed__Project__c>([ SELECT Id,ownerId FROM AcctSeed__Project__c WHERE Id IN : projectIds ]);
    for(AcctSeedERP__Sales_Order_Line__c so : Trigger.new) {
        if(so.AcctSeedERP__Project__c != null) {
        	so.Project_PM__c = projectMap.get(so.AcctSeedERP__Project__c).ownerId;
        }
    }
}