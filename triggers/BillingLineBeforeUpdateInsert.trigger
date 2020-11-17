trigger BillingLineBeforeUpdateInsert on AcctSeed__Billing_Line__c (before insert, before update) {
	
	/*
	 *	Before insert
	 *		- Keep the new and old Project Task look up fields up to date
	 *		- Set Taxable based upon the value of the Tax Category field and the Tax Group record
	 *		referenced by the related Billing record.
	 *		- Set field Case__c from the related Service Visit record if there is one.
	 *
	 *	Before update
	 *		- Keep the new adn old Project Task look up fields up to date
	 *		- Set Taxable based upon the value of the Tax Category field and the Tax Group record
	 *		referenced by the related Billing record.
	 *		- Set field Case__c from the related Service Visit record if there is one.
	 */
	
	/*
	Set<Id> svIds = new Set<Id>();
	Set<Id> bIds = new Set<Id>();
	Map<Id, AcctSeed__Billing_Line__c> billingLineMap = new Map<Id, AcctSeed__Billing_Line__c>();
	if (trigger.isInsert) {
		
		for (AcctSeed__Billing_Line__c bl :trigger.new) {
			
			if (bl.AcctSeed__Project_Task__c != null) {
				bl.Project_Task__c = bl.AcctSeed__Project_Task__c;
			} else {
				if (bl.Project_Task__c != null ) {
					bl.AcctSeed__Project_Task__c = bl.Project_Task__c;
				}
			}
			
			bIds.add(bl.AcctSeed__Billing__c);
			billingLineMap.put(bl.Id, bl);
			
			if (bl.Service_Visit__c != null) {
				svIds.add(bl.Service_Visit__c);
			}
		}
	}
	
	if (trigger.isUpdate) {
		for (AcctSeed__Billing_Line__c bl :trigger.new) {
			
			if (bl.AcctSeed__Project_Task__c != trigger.oldMap.get(bl.Id).AcctSeed__Project_Task__c) {
				bl.Project_Task__c = bl.AcctSeed__Project_Task__c;
			} else {
				if (bl.Project_Task__c != trigger.oldMap.get(bl.Id).Project_Task__c) {
					bl.AcctSeed__Project_Task__c = bl.Project_Task__c;
				}
			}
			
			if (bl.Category__c != trigger.oldMap.get(bl.Id).Category__c) {
				if (String.isBlank(bl.Category__c)) {
					bl.Taxable__c = false;
				} else {
					bIds.add(bl.AcctSeed__Billing__c);
					billingLineMap.put(bl.Id, bl);
				}
			}
			
			if (bl.Service_Visit__c != trigger.oldMap.get(bl.Id).Service_Visit__c) {
				if (bl.Service_Visit__c == null) {
					bl.Case__c = null;
				} else {
					svIds.add(bl.Service_Visit__c);
				}
			}
		}
	}
	
	// Set the Taxable field based upon Tax Category and the Tax Group record of he Billing record
	if (!bIds.isEmpty()) {
		Map<Id, AcctSeed__Billing__c> billingMap = new Map<Id, AcctSeed__Billing__c>([select Id, Tax_Group__c from AcctSeed__Billing__c where Id in :bIds]);
		
		Set<Id> tgIds = new Set<Id>();
		for (AcctSeed__Billing__c b :billingMap.values()) {
			if (b.Tax_Group__c != null) {
				tgIds.add(b.Tax_Group__c);
			}
		}
		
		if (!tgIds.isEmpty()) {
			
			// Read in all of the fields of the Tax Group records
			Map<String, Schema.SObjectField> fMap;
			List<string> selectFields;
			fMap = Schema.getGlobalDescribe().get('Tax_Group__c').getDescribe().Fields.getMap();
			selectFields = new List<string>();
			for (Schema.SObjectField ft : fMap.values()) {
				Schema.DescribeFieldResult fd = ft.getDescribe();
				selectFields.add(fd.getName());
			}
			
			String selects = '';
			for (String s :selectFields) {
				selects += s + ',';
			}
			if (selects.endsWith(',')) {
				selects = selects.substring(0,selects.lastIndexOf(','));
			}
			
			String taxGroupIds = '(';
			for (Id i :tgIds) {
				taxGroupIds += '\'' + i + '\',';
			}
			taxGroupIds = taxGroupIds.removeEnd(',');
			taxGroupIds += ')';
			
			List<Tax_Group__c> tgList = new List<Tax_Group__c>();
			tgList = (List<Tax_Group__c>)Database.query('SELECT ' + selects + ' FROM Tax_Group__c WHERE Id IN ' + taxGroupIds);
			Map<Id, Tax_Group__c> tgMap = new Map<Id, Tax_Group__c>();
			for (Tax_Group__c tg :tgList) {
				tgMap.put(tg.Id, tg);
			}
			
			// Set Taxable based on value of the field on the Tax Group record with the same label as the value 
			// of the Tax Category field. The Tax Group record is referenced on the Billing record
			String tgField;
			for (AcctSeed__Billing_Line__c bl :billingLineMap.values()) {
				bl.Taxable__c = false;
				if (String.isNotBlank(bl.Category__c)) {
					tgField = '';
					for (Schema.SObjectField ft : fMap.values()) {
						Schema.DescribeFieldResult fd = ft.getDescribe();
						if (fd.getLabel() == bl.Category__c) {
							tgField = fd.getName();
						}
					}
					
					if (String.isNotBlank(tgField)) {
						if (tgMap.containsKey(billingMap.get(bl.AcctSeed__Billing__c).Tax_Group__c)) {
							if (tgMap.get(billingMap.get(bl.AcctSeed__Billing__c).Tax_Group__c).get(tgField) == 'Taxed') {
								bl.Taxable__c = true;
							}
						}
					}
				}
			}
		}
	}
	
	// Set the Case__c field to the case lookup field on the related Service Visit
	if (!svIds.isEmpty()) {
		Map<Id, SV__c> svMap = new Map<Id, SV__c>([select Id, Case__c from SV__c where Id in :svIds]);
		for (AcctSeed__Billing_Line__c bl :trigger.new) {
			if (svMap.containsKey(bl.Service_Visit__c)) {
				bl.Case__c = svMap.get(bl.Service_Visit__c).Case__c;
			}
		}
	}
	*/
	
	/*
    for(Integer i = 0; i < trigger.new.size(); i++){
        AcctSeed__Billing_Line__c bLineNew = trigger.new[i];
        if( trigger.isInsert ) {
            if(bLineNew.AcctSeed__Project_Task__c != null){
                bLineNew.Project_Task__c = bLineNew.AcctSeed__Project_Task__c;
            } else if ( bLineNew.Project_Task__c != null ) {
                bLineNew.AcctSeed__Project_Task__c = bLineNew.Project_Task__c;
            }
        } else if ( trigger.isUpdate ) {
            AcctSeed__Billing_Line__c bLineOld = trigger.old[i];
            if( bLineNew.AcctSeed__Project_Task__c != bLineOld.AcctSeed__Project_Task__c ) {
                bLineNew.Project_Task__c = bLineNew.AcctSeed__Project_Task__c;
            } else if( bLineNew.Project_Task__c != bLineOld.Project_Task__c ) {
                bLineNew.AcctSeed__Project_Task__c = bLineNew.Project_Task__c;
            }
        }
    }
	*/
}