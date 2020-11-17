public with sharing class ContactTriggerHandler {
    public static void createContactRole(List<Contact> triggerNew, Map<Id,Contact> oldMap, Boolean isUpdate, Boolean isInsert, Boolean isUndelete) {
    	Map<Id,List<Contact>> mapAccountIdtoContacts = new Map<Id,List<Contact>>();
    	Map<String,String> deleteContractRole = new Map<String,String>();
    	Set<String> setRemoveRoleKey = new Set<String>();
    	Set<Id> setRemoveForAccountId = new Set<Id>();
    	Set<Id> setRemoveForContactId = new Set<Id>();
    	
    	List<ContractContactRole> insertContactRoles = new List<ContractContactRole>();
    	
    	// Map are used when Type Changed on Contact and added few new Type 
    	Map<Id,List<ContractContactRole>> mapAccountIdToCCRole = new Map<Id,List<ContractContactRole>>();
    	Set<String> setValidContactType = new Set<String>{'O&M Billing Contact','O&M Service Billing Contact'};
    	for(Contact cont:triggerNew) {
    		if(isUpdate && oldMap.get(cont.Id).Contact_Type__c != cont.Contact_Type__c) {
    			Set<String> setNewContType = new Set<String>();
    			Set<String> setOldContType = new Set<String>();
    			
    			if(cont.Contact_Type__c != null) {
    				for(String contType:cont.Contact_Type__c.split(';')) {
    					if(setValidContactType.contains(contType)) {
    						setNewContType.add(contType);
    					}
    				}
    				//setNewContType.addAll(cont.Contact_Type__c.split(';'));
    			}
    			if(oldMap.get(cont.Id).Contact_Type__c != null) {
    				for(String contType:oldMap.get(cont.Id).Contact_Type__c.split(';')) {
    					if(setValidContactType.contains(contType)) {
    						setOldContType.add(contType);
    					}
    				}
    				//setOldContType.addAll();
    			}
    			
    			// Remove Contact Roles if Contact Type changed
    			if(setNewContType.size() > 0) {
    				setOldContType.removeAll(setNewContType);
    			}
    			System.debug('==============setOldContType: REMOVED FROM TYPE'+ setOldContType);
    			for(String strType:setOldContType) {
    				setRemoveForContactId.add(cont.id);
    				setRemoveForAccountId.add(cont.AccountId);
    				setRemoveRoleKey.add(cont.AccountId + '-' + cont.Id + '-' + strType);
    			}
    			
    			// Add new Contract Contact Role
    			setNewContType.clear();
    			setOldContType.clear();
    			if(cont.Contact_Type__c != null) {
    				for(String contType:cont.Contact_Type__c.split(';')) {
    					if(setValidContactType.contains(contType)) {
    						setNewContType.add(contType);
    					}
    				}
    				//setNewContType.addAll(cont.Contact_Type__c.split(';'));
    			}
    			if(oldMap.get(cont.Id).Contact_Type__c != null) {
    				for(String contType:oldMap.get(cont.Id).Contact_Type__c.split(';')) {
    					if(setValidContactType.contains(contType)) {
    						setOldContType.add(contType);
    					}
    				}
    				//setOldContType.addAll(oldMap.get(cont.Id).Contact_Type__c.split(';'));
    			}
    			
    			if(setOldContType.size() > 0) {
    				setNewContType.removeAll(setOldContType);
    			}
    			System.debug('==============setNewContType: ADDED NEW TYPE'+ setNewContType);
    			for(String strType:setNewContType) {
    				// Contract Id populated Later
    				ContractContactRole contRole = createContractContactRole(cont.Id,null,strType);
    				if(!mapAccountIdToCCRole.containsKey(cont.AccountId)) {
    					mapAccountIdToCCRole.put(cont.AccountId,new List<ContractContactRole>());
    				}
    				mapAccountIdToCCRole.get(cont.AccountId).add(contRole);
    			}
    			
    			// Write Create Contact Role Logic
    		} else if(isInsert || isUndelete) {
    			if(cont.AccountId != null && cont.Contact_Type__c != null) {
    				if(!mapAccountIdtoContacts.containsKey(cont.AccountId)) {
    					mapAccountIdtoContacts.put(cont.AccountId,new List<Contact>());
    				}
    				mapAccountIdtoContacts.get(cont.AccountId).add(cont);
    			}
    		}
    	}
    	
    	System.debug('==============mapAccountIdToCCRole'+mapAccountIdToCCRole);
    	// Remove Contact Role for Contract if Type removed from Contact Type
    	List<ContractContactRole> lstContractContRole = new List<ContractContactRole>();
    	
    	System.debug('==============setRemoveForAccountId'+setRemoveForAccountId);
    	System.debug('==============setRemoveForContactId'+setRemoveForContactId);
    	System.debug('==============setRemoveRoleKey'+setRemoveRoleKey);
    	for(ContractContactRole ccRole:[Select Id,ContactId,Contact.AccountId,Role From ContractContactRole 
    														Where Contact.AccountId IN:setRemoveForAccountId AND
    															ContactId IN:setRemoveForContactId]) {
    		String key = ccRole.Contact.AccountId + '-' + ccRole.ContactId + '-' + ccRole.Role;
    		System.debug('==============key'+key);
    		if(setRemoveRoleKey.contains(key)) {
    			lstContractContRole.add(ccRole);
    		}
    	}
    	System.debug('==============lstContractContRole DELETE CONTACT ROLE'+lstContractContRole);
    	if(lstContractContRole.size() > 0) {
    		delete lstContractContRole;
    	}
    	
    	System.debug('==============insertContactRoles BEFORE CREATE CONTACT ROLE'+insertContactRoles);
    	// Create CCRole on Contact Type Changed
    	if(mapAccountIdToCCRole.keySet().size() > 0) {
    		for(Account acc:[Select Id,(Select Id From Contracts) From Account Where Id IN:mapAccountIdToCCRole.keySet()]) {
    			for(Contract contractObj:acc.contracts) {
    				for(ContractContactRole ccRole:mapAccountIdToCCRole.get(acc.Id)) {
	    				ContractContactRole copyCCRole = new ContractContactRole();
	    				copyCCRole.ContractId = contractObj.Id;
	    				copyCCRole.Role = ccRole.Role;
	    				copyCCRole.ContactId = ccRole.ContactId;
	    				
	    				insertContactRoles.add(copyCCRole);
    				}
    			}
    		}
    	}
    	System.debug('==============insertContactRoles AFTER CREATE CONTACT ROLE'+insertContactRoles);
    	
    	if(mapAccountIdtoContacts.KeySet().size() > 0) {
	    	// Collect Associated Service Contracts for which we are going to create Contact Role
	    	Map<Id,List<Contract>> mapAccountIdToContracts = new Map<Id,List<Contract>>();
	    	for(Contract contractObj:[Select Id,AccountId From Contract Where AccountId In: mapAccountIdtoContacts.KeySet()]) {
	    		if(!mapAccountIdToContracts.containsKey(contractObj.AccountId)) {
	    			mapAccountIdToContracts.put(contractObj.AccountId,new List<Contract>());
	    		}
	    		mapAccountIdToContracts.get(contractObj.AccountId).add(contractObj);
	    	}
	    	
	    	// Create Contract Contact Role records
	    	// Iterate by Account
	    	System.debug('2222==============insertContactRoles BEFORE CREATE CONTACT ROLE'+lstContractContRole);
		    for(Id accId:mapAccountIdtoContacts.keySet()) {
		    	// Iterate by contacts of Account
		    	for(Contact cont:mapAccountIdtoContacts.get(accId)) {
		    		// Iterate Contracts by Account for Every Contacts
		    		if(mapAccountIdToContracts != null && mapAccountIdToContracts.containsKey(accId) && mapAccountIdToContracts.get(accId).size() > 0) {
			    		for(Contract contractObj:mapAccountIdToContracts.get(accId)) {
				    		// Create Contact Role for each selected Contact Type
				    		for(String contType:cont.Contact_Type__c.split(';')) {
				    			if(setValidContactType.contains(contType)) {
						    		ContractContactRole contRole = createContractContactRole(cont.Id,contractObj.Id,contType);
						    		insertContactRoles.add(contRole);
				    			}
				    		}
			    		}
		    		}
		    	}
		    }
		    System.debug('2222==============insertContactRoles AFTER CREATE CONTACT ROLE'+lstContractContRole);
    	}
    	if(insertContactRoles.size() > 0) {
	    	insert insertContactRoles;
	    }
    }
    
    private static ContractContactRole createContractContactRole(Id contId,Id contractId,String strRole) {
    	ContractContactRole contRole = new ContractContactRole();
		contRole.ContractId = contractId;
		contRole.ContactId = contId;
		contRole.IsPrimary = false;
		contRole.Role = strRole;
		
		return contRole;
    }
}