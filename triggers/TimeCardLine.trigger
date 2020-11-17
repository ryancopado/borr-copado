trigger TimeCardLine on AcctSeed__Time_Card_Line__c (before insert, before update) {
	
	/*
	 *	Set the Site lookup field based upon the Project and Time Card Variable 2 fields
	 *
	 */
	
	Set<Id> tcv2Ids = new Set<Id>();
	for (AcctSeed__Time_Card_Line__c tcl :trigger.new) {
		if (tcl.AcctSeed__Time_Card_Variable_2__c != null) {
			if (trigger.isInsert) {
				tcv2Ids.add(tcl.AcctSeed__Time_Card_Variable_2__c);
			}
			if (trigger.isUpdate) {
				if (tcl.AcctSeed__Project__c != trigger.oldMap.get(tcl.Id).AcctSeed__Project__c || 
					tcl.AcctSeed__Time_Card_Variable_2__c != trigger.oldMap.get(tcl.Id).AcctSeed__Time_Card_Variable_2__c) {
						tcv2Ids.add(tcl.AcctSeed__Time_Card_Variable_2__c);
					}
			}
		}
	}
	
	if (!tcv2Ids.isEmpty()) {
		
		Map<Id, AcctSeed__Accounting_Variable__c> tcv2Map;
		tcv2Map = new Map<Id, AcctSeed__Accounting_Variable__c>([select Id, AcctSeed__Active__c, Name, Site__c, Project__c 
					from AcctSeed__Accounting_Variable__c where Id in :tcv2Ids and AcctSeed__Type__c = 'Time Card Variable 2']);
		
		Set<Id> sIds = new Set<Id>();
		for (AcctSeed__Accounting_Variable__c tcv2 :tcv2Map.values()) {
			if (tcv2.Site__c != null) {
				sIds.add(tcv2.Site__c);
			}
		}
		
		Map<Id, Site__c> siteMap = new Map<Id, Site__c>([select Id, Name, Project__c from Site__c where Id in :sIds]);
		
		for (AcctSeed__Time_Card_Line__c tcl :trigger.new) {
			if (tcl.AcctSeed__Project__c == null) {
				if (tcl.AcctSeed__Time_Card_Variable_2__c != null) {
					tcl.addError('Project field must have a value.');
				}
			} else {
				if (tcl.AcctSeed__Time_Card_Variable_2__c == null) {
					tcl.Site__c = null;
				} else {
					if (tcv2Map.containsKey(tcl.AcctSeed__Time_Card_Variable_2__c)) {
						if (siteMap.containsKey(tcv2Map.get(tcl.AcctSeed__Time_Card_Variable_2__c).Site__c)) {
							if (tcl.AcctSeed__Project__c != siteMap.get(tcv2Map.get(tcl.AcctSeed__Time_Card_Variable_2__c).Site__c).Project__c) {
								tcl.addError('Site ' + siteMap.get(tcv2Map.get(tcl.AcctSeed__Time_Card_Variable_2__c).Site__c).Name + ' must be related to the Project of the Time Card Line.');
							} else {
								tcl.Site__c = tcv2Map.get(tcl.AcctSeed__Time_Card_Variable_2__c).Site__c;
							}
						} else {
							tcl.addError('Site ' + tcv2Map.get(tcl.AcctSeed__Time_Card_Variable_2__c).Name + ' cannot be used on a Time Card Line.');
						}
					}
				}
			}
		}
	}
		
	/*
	Set<Id> pIds = new Set<Id>();
	Set<Id> tcv2Ids = new Set<Id>();
	
	for (AcctSeed__Time_Card_Line__c tcl :trigger.new) {
		if (tcl.AcctSeed__Project__c != null) {
			pIds.add(tcl.AcctSeed__Project__c);
			if (tcl.AcctSeed__Time_Card_Variable_2__c != null) {
				if (trigger.isInsert || tcl.AcctSeed__Project__c != trigger.oldMap.get(tcl.Id).AcctSeed__Project__c || 
						tcl.AcctSeed__Time_Card_Variable_2__c != trigger.oldMap.get(tcl.Id).AcctSeed__Time_Card_Variable_2__c) {
					tcv2Ids.add(tcl.AcctSeed__Time_Card_Variable_2__c);
				}
			}
		}
	}
		
	if (!tcv2Ids.isEmpty()) {	
		Map<Id, AcctSeed__Accounting_Variable__c> tcv2Map;
		tcv2Map = new Map<Id, AcctSeed__Accounting_Variable__c>([select Id, AcctSeed__Active__c, Name, AcctSeed__Type__c 
					from AcctSeed__Accounting_Variable__c where Id in :tcv2Ids and AcctSeed__Type__c = 'Time Card Variable 2']);
		Set<String> siteNames = new Set<String>();
		for (AcctSeed__Accounting_Variable__c tcv2 :tcv2Map.values()) {
			siteNames.add(tcv2.Name);
		}
		
		List<Site__c> siteList = new List<Site__c>();
		siteList = [select Id, Name, Project__c from Site__c where Project__c in :pIds and Name in :siteNames];
		
		Boolean siteFound;
		for (AcctSeed__Time_Card_Line__c tcl :trigger.new) {
			if (tcl.AcctSeed__Project__c == null) {
				if (tcl.AcctSeed__Time_Card_Variable_2__c != null) {
					tcl.addError('Project field must have a value.');
				}
			} else {
				if (tcv2Map.containsKey(tcl.AcctSeed__Time_Card_Variable_2__c)) {
					siteFound = false;
					for (Site__c s :siteList) {
						if (tcl.AcctSeed__Project__c == s.Project__c && tcv2Map.get(tcl.AcctSeed__Time_Card_Variable_2__c).Name == s.Name) {
							siteFound = true;
							tcl.Site__c = s.Id;
						}
					}
					if (!siteFound) {
						tcl.addError('Site must be related to the Project.');
					}
				}
			}
		}
	}
	*/
}