trigger CashReceiptRollUp on AcctSeed__Cash_Receipt__c (after delete, after insert, after undelete, after update) {
  
  // Rollup all Cash Receipts associated with Line Items (Project Tasks) that have Posting Status = Posted
  list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsProjectTask = new list<RollupSummaryUtility.fieldDefinition> {
  new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'Roll_Up_Cash_Receipts__c')
  };
  
  list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsAll = new list<RollupSummaryUtility.fieldDefinition> {
  new RollUpSummaryUtility.fieldDefinition('SUM', 'AcctSeed__Amount__c', 'RollupCashReceipts__c')
  };
  
  if(trigger.isInsert || trigger.isUpdate || trigger.isUnDelete){

    list<AcctSeed__Cash_Receipt__c> records = new list<AcctSeed__Cash_Receipt__c> ();
    if(trigger.isUpdate){
        for(integer i=0;i<trigger.new.size();i++){

            if ( (trigger.new[i].get('AcctSeed__Amount__c') != trigger.old[i].get('AcctSeed__Amount__c')) ||
            	 (trigger.new[i].AcctSeed__Credit_GL_Account__c != trigger.old[i].AcctSeed__Credit_GL_Account__c) ||
            	 (trigger.new[i].AcctSeed__Status__c != trigger.old[i].AcctSeed__Status__c) ) {
				records.add(trigger.new[i]);
			}

        }
    } else {
        records.addAll(trigger.new);
    }

    if (!records.isEmpty()) {
        
		//Query filter for GL Account
		List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
		glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
		String glaFilter = '';
		if (glaList.size() > 0) {
			glaFilter += ' and (AcctSeed__Credit_GL_Account__c = \'' + glaList[0].Id + '\'';
			for (Integer i=1; i<glaList.size(); i++) {
				glaFilter += ' or AcctSeed__Credit_GL_Account__c = \'' + glaList[i].Id + '\'';
			}
			glaFilter += ')';
		}
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, records, 'AcctSeed__Cash_Receipt__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter);
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsProjectTask, records, 'AcctSeed__Cash_Receipt__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter + ' and AcctSeed__Status__c = \'Posted\' ');
    }
  }
  
	if (trigger.isDelete) {
    
		//Query filter for GL Account
		List<AcctSeed__GL_Account__c> glaList = new List<AcctSeed__GL_Account__c>();
		glaList = [select Id from AcctSeed__GL_Account__c where Name like '36%'];
		String glaFilter = '';
		if (glaList.size() > 0) {
			glaFilter += ' and (AcctSeed__Credit_GL_Account__c = \'' + glaList[0].Id + '\'';
			for (Integer i=1; i<glaList.size(); i++) {
				glaFilter += ' or AcctSeed__Credit_GL_Account__c = \'' + glaList[i].Id + '\'';
			}
			glaFilter += ')';
		}
    
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsAll, trigger.old, 'AcctSeed__Cash_Receipt__c', 'AcctSeed__Project__c', 'AcctSeed__Project__c', glaFilter);
		RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsProjectTask, trigger.old, 'AcctSeed__Cash_Receipt__c', 'AcctSeed__Project_Task__c', 'AcctSeed__Project_Task__c', glaFilter + ' and AcctSeed__Status__c = \'Posted\' ');
	}
}