trigger ASProjectBeforeInsert on AcctSeed__Project__c (before insert,before update) {
/*

    List<String> theOwners = new List<String>();
    
    List<String> theOpportunities = new List<String>();


    for(integer i=0; i<trigger.new.size();i++){
        theOwners.add(trigger.new[i].ownerId);
        if(trigger.new[i].AcctSeed__Opportunity__c != null ){
            if(trigger.isUpdate && (trigger.old[i].AcctSeed__Opportunity__c == null || (trigger.old[i].AcctSeed__Opportunity__c != null && trigger.old[i].AcctSeed__Opportunity__c != trigger.new[i].AcctSeed__Opportunity__c))){
                theOpportunities.add(trigger.new[i].AcctSeed__Opportunity__c);
            }else if(trigger.isInsert){
                theOpportunities.add(trigger.new[i].AcctSeed__Opportunity__c);  
            }
        }
    }
    if(!theOpportunities.isEmpty()){
        Map<Id,User> theUsers = new Map<Id,User>([select id,Name from User where id In:theOwners ]);
    
        Map<Id,Opportunity> theopps = new Map<Id,Opportunity>([select id,OwnerID from Opportunity where id In:theOpportunities ]);
    
    
        for(AcctSeed__Project__c ASProject:trigger.new){
            String userName = theUsers.get(ASProject.ownerId).Name;
            if(userName.length() > 254){
                userName= userName.substring(254);
            }
            ASProject.owner_Name__c = userName;
            if(ASProject.AcctSeed__Opportunity__c != null){
                ASProject.EC__c = theopps.get(ASProject.AcctSeed__Opportunity__c).OwnerId;
                
                // Set the Owner field of the Project to the Owner of the associated Opportunity if Overall Project Status is "Pre-Contract"
                if (ASProject.Overall_Project_Status__c == 'Pre-Contract' && (trigger.isInsert || trigger.oldMap.get(ASProject.Id).AcctSeed__Opportunity__c == NULL)) {
                	ASProject.OwnerId = theopps.get(ASProject.AcctSeed__Opportunity__c).OwnerId;
                }
            }
        }   
    }

    // Set the "O&M Manager" field based upon the value in the "Branch" field.
    Map<String, Id> branchMap = new Map<String, Id>();
    List<User> OM_Mgrs = new List<User>();
    String support_branches;
    String branch;
    
    // Get the list of users that are O&M Managers
   	OM_Mgrs = [SELECT Id, Name, O_M_Support_Branches__c, IsActive FROM User WHERE O_M_Support_Branches__c !=: NULL AND IsActive =: TRUE];
    
   	// Build the branchMap - each O&M Manager may be responsible for one or more Branches.  The Branch names they are responsible for are listed
   	// in field O_M_Support_Branches__c which is a string of one or more Branch names separated by a semi-colon.
   	for (User u : OM_Mgrs) {
    	support_branches = u.O_M_Support_Branches__c;
    	while (support_branches.length() > 0) {
    		if (support_branches.indexOf(';', 0) != -1) {
    			branch = support_branches.substringBefore(';');
    			support_branches = support_branches.removeStart(branch);
    			support_branches = support_branches.removeStart(';');
    		} else {
    			branch = support_branches;
    			support_branches = support_branches.removeStart(branch);
    		}
    		// Only one user may be responsible for supporting a specific Branch
    		if (!branchMap.containsKey(branch)) {
    			branchMap.put(branch, u.Id);
    		}
    	}
   	}
    
    // Set the O&M Manager field on each Project according to the branchMap just built
    Map<Id,Schema.RecordTypeInfo> rtByIdMap = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosById();
    for (AcctSeed__Project__c p : trigger.new) {
    	if (rtByIdMap.containsKey(p.RecordTypeId) && rtByIdMap.get(p.RecordTypeId).getName() != 'O&M Project') {
    		if (p.Branch__c != NULL && branchMap.containsKey(p.Branch__c)) {
    			p.O_M_Manager__c = branchMap.get(p.Branch__c);
    		}
    	}
    }
*/
}