trigger AE_CashDisbursement on AcctSeed__Cash_Disbursement__c (before insert, before update) {
	
/*
  for(AcctSeed__Cash_Disbursement__c cd : (List<AcctSeed__Cash_Disbursement__c>)Trigger.new)
  {
    Boolean setAchOk = False;
    if(cd.AcctSeed__Vendor__c != null)
    {
      Account act = [SELECT Id FROM Account WHERE Id = :cd.AcctSeed__Vendor__c];
      setAchOk = AE_checkForACH('Account__c', act.Id);
    }
    if(cd.AcctSeed__Contact__c != null)
    {
      Contact cnt = [SELECT Id FROM Contact WHERE Id = :cd.AcctSeed__Contact__c];
      setAchOk = AE_checkForACH('Contact__c', cnt.Id);
    }
    if(cd.AcctSeed__Employee__c != null)
    {
      User usr = [SELECT Id FROM User WHERE Id = :cd.AcctSeed__Employee__c];
      setAchOk = AE_checkForACH('User__c', usr.Id);
    }
    if(setAchOk == True)
    {
      // the cd record is upsert(ed) after this code executes.
      cd.ACH_OK_RW__c = True;
    }
    else
    {
      cd.ACH_OK_RW__c = False;
    }
  }

  private Boolean AE_checkForACH(String payeeName, String objId)
  {
    Boolean result = false;
    String sql = 'SELECT Id,Name,Approval_Status__c FROM AS_ACH__c WHERE ' + payeeName + ' = \'' + objId + '\'';
    List<AS_ACH__c> achs = Database.query(sql);
    System.debug('AS: CDT achs is `' + achs + '\'');
    System.debug('AS: CDT achs.size() is `' + achs.size() + '\'');
    if(achs.size() == 1 && achs[0].Approval_Status__c == 'Approved') // should be only 1 approved ACH for any given payee
    {
      result = True;
    }
    return(result);
  }
*/
	
	/*
	 *	Trigger re-write to bulk-ify it - 2017-01-12.
	 *
	 */
	
	Set<Id> aIds = new Set<Id>();
	Set<Id> cIds = new Set<Id>();
	Set<Id> uIds = new Set<Id>();
	for (AcctSeed__Cash_Disbursement__c cd :trigger.new) {
		if (cd.AcctSeed__Vendor__c != null) {
			aIds.add(cd.AcctSeed__Vendor__c);
		}
		if (cd.AcctSeed__Contact__c != null) {
			cIds.add(cd.AcctSeed__Contact__c);
		}
		if (cd.AcctSeed__Employee__c != null) {
			uIds.add(cd.AcctSeed__Employee__c);
		}
	}
	
	Map<Id, List<AS_ACH__c>> accountToAchMap = new Map<Id, List<AS_ACH__c>>();
	Map<Id, List<AS_ACH__c>> contactToAchMap = new Map<Id, List<AS_ACH__c>>();
	Map<Id, List<AS_ACH__c>> userToAchMap = new Map<Id, List<AS_ACH__c>>();
	if (!aIds.isEmpty() || !cIds.isEmpty() || !uIds.isEmpty()) {
		List<AS_ACH__c> achList = new List<AS_ACH__c>();
		achList = [select Id, Name, Approval_Status__c, Account__c, Contact__c, User__c 
				from AS_ACH__c where Approval_Status__c = 'Approved' and (Account__c in :aIds or Contact__c in :cIds or User__c in :uIds)];
		
		if (!achList.isEmpty()) {
			
			for (AS_ACH__c ach :achList) {
				if (ach.Account__c != null) {
					if (!accountToAchMap.containsKey(ach.Account__c)) {
						accountToAchMap.put(ach.Account__c, new List<AS_ACH__c>());
					}
					accountToAchMap.get(ach.Account__c).add(ach);
				}
				
				if (ach.Contact__c != null) {
					if (!contactToAchMap.containsKey(ach.Contact__c)) {
						contactToAchMap.put(ach.Contact__c, new List<AS_ACH__c>());
					}
					contactToAchMap.get(ach.Contact__c).add(ach);
				}
				
				if (ach.User__c != null) {
					if (!userToAchMap.containsKey(ach.User__c)) {
						userToAchMap.put(ach.User__c, new List<AS_ACH__c>());
					}
					userToAchMap.get(ach.User__c).add(ach);
				}
			}
		}
	}
			
	Boolean setAchOk;
	for (AcctSeed__Cash_Disbursement__c cd :trigger.new) {
		setAchOk = false;
		if (accountToAchMap.containsKey(cd.AcctSeed__Vendor__c)) {
			if (accountToAchMap.get(cd.AcctSeed__Vendor__c).size() == 1) {
				setAchOk = true;
			}
		}
		
		if (contactToAchMap.containsKey(cd.AcctSeed__Contact__c)) {
			if (contactToAchMap.get(cd.AcctSeed__Contact__c).size() == 1) {
				setAchOk = true;
			}
		}
		
		if (userToAchMap.containsKey(cd.AcctSeed__Employee__c)) {
			if (userToAchMap.get(cd.AcctSeed__Employee__c).size() == 1) {
				setAchOk = true;
			}
		}
		
		cd.ACH_OK_RW__c = setAchOk;
	}
}