public class UserService {
	
	// Update User effective rates
	// - before update
	public static void changeRate(List<User> newList, Map<Id, User> oldMap) {
		
		for (User u :newList) {
			
			// If Rate is about to change, save current values
			if (u.Rate__c != oldMap.get(u.Id).Rate__c) {
				u.Rate3__c = oldMap.get(u.Id).Rate2__c;
				u.Rate2__c = oldMap.get(u.Id).Rate1__c;
				u.Rate1__c = oldMap.get(u.Id).Rate__c;
				u.Rate3_Effective_Date__c = oldMap.get(u.Id).Rate2_Effective_Date__c;
				u.Rate2_Effective_Date__c = oldMap.get(u.Id).Rate1_Effective_Date__c;
				u.Rate1_Effective_Date__c = oldMap.get(u.Id).Rate_Effective_Date__c;
			}
			
			// Take care of potential null fields
			if (u.Rate__c == null) {
				u.Rate__c = 0;
			}
			
			if (u.Rate1__c == null) {
				u.Rate1__c = u.Rate__c;
			}
			
			if (u.Rate2__c == null) {
				u.Rate2__c = u.Rate1__c;
			}
			
			if (u.Rate3__c == null) {
				u.Rate3__c = u.Rate2__c;
			}
		}
	}
	
	// Recalculate rates on user associated Time Entry records
	// - after update
	public static void recalculateTERates(List<User> newList, Map<Id, User> oldMap) {
		
		// Make a list of all User records with changed Rate or Rate Effective Date
		List<User> newU = new List<User>();
		for (User u :newList) {
			if (u.Rate__c != oldMap.get(u.Id).Rate__c || u.Rate_Effective_Date__c != oldMap.get(u.Id).Rate_Effective_Date__c) {
				newU.add(u);
			} 
		}
		
		// Recalculate rates on associated Time Entry records
		if(newU.size() > 0) {
			recalcTE.recalcInternalRates(newU);
		}
	}
	
	// Set fields on the User record for the Admin Service Visit records
	// - before insert, before update
	public static void asvFields(List<User> newList, Map<Id, User> oldMap, Boolean isInsert) {
		Set<Id> conIds = new Set<Id>();
		Set<Id> pIds = new Set<Id>();
		Set<Id> cntrctIds = new Set<Id>();
		
		Map<String, BranchToOpsDivision__c> bodMap = BranchToOpsDivision__c.getAll();
		for (User u :newList) {
			if (String.isNotBlank(u.Contact_Record_ID__c)) {
				if (isInsert) {
					conIds.add(u.Contact_Record_ID__c);
				} else {
					if (u.Contact_Record_ID__c != oldMap.get(u.Id).Contact_Record_ID__c) {
						conIds.add(u.Contact_Record_ID__c);
					}
				}
			} else {
				u.Contact_Record_ID__c = '';
				u.Contact_Record_Name__c = '';
			}
			
			if (String.isNotBlank(u.Branch__c) && bodMap.containsKey(u.Branch__c)) {
				
				if (String.isNotBlank(bodMap.get(u.Branch__c).ASV_Contract_Id__c)) {
					if (isInsert) {
						cntrctIds.add(bodMap.get(u.Branch__c).ASV_Contract_Id__c);
					} else {
						if (u.Branch__c != oldMap.get(u.Id).Branch__c) {
							cntrctIds.add(bodMap.get(u.Branch__c).ASV_Contract_Id__c);
						}
					}
				} else {
					u.ASV_Contract_Id__c = '';
					u.ASV_Contract_Number__c = '';
				}
				
				if (String.isNotBlank(bodMap.get(u.Branch__c).ASV_Project_Id__c)) {
					if (isInsert) {
						pIds.add(bodMap.get(u.Branch__c).ASV_Project_Id__c);
					} else {
						if (u.Branch__c != oldMap.get(u.Id).Branch__c) {
							pIds.add(bodMap.get(u.Branch__c).ASV_Project_Id__c);
						}
					}
				} else {
					u.ASV_Project_Id__c = '';
					u.ASV_Project_Name__c = '';
				}
				
			} else {
				u.ASV_Contract_Id__c = '';
				u.ASV_Contract_Number__c = '';
				u.ASV_Project_Id__c = '';
				u.ASV_Project_Name__c = '';
			}
		}
		
		Map<Id, Contact> conMap = new Map<Id, Contact>([select Id, Name from Contact where Id in :conIds]);
		Map<Id, Contract> cntrctMap = new Map<Id, Contract>([select Id, ContractNumber from Contract where Id in :cntrctIds]);
		Map<Id, AcctSeed__Project__c> pMap = new Map<Id, AcctSeed__Project__c>([select Id, Name from AcctSeed__Project__c where Id in :pIds]);
		
		for (User u :newList) {
			if (String.isNotBlank(u.contact_Record_ID__c) && conMap.containsKey(u.Contact_Record_ID__c)) {
				u.Contact_Record_Name__c = conMap.get(u.Contact_Record_ID__c).Name;
			}
			
			if (bodMap.containsKey(u.Branch__c)) {
				if (String.isNotBlank(bodMap.get(u.Branch__c).ASV_Contract_Id__c) && cntrctMap.containsKey(bodMap.get(u.Branch__c).ASV_Contract_Id__c)) {
					u.ASV_Contract_Id__c = bodMap.get(u.Branch__c).ASV_Contract_Id__c;
					u.ASV_Contract_Number__c = cntrctMap.get(u.ASV_Contract_Id__c).ContractNumber;
				}
				
				if (String.isNotBlank(bodMap.get(u.Branch__c).ASV_Project_Id__c) && pMap.containsKey(bodMap.get(u.Branch__c).ASV_Project_Id__c)) {
					u.ASV_Project_Id__c = bodMap.get(u.Branch__c).ASV_Project_Id__c;
					u.ASV_Project_Name__c = pMap.get(u.ASV_Project_Id__c).Name;
				}
			}
		}
	}
}