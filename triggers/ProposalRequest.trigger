trigger ProposalRequest on Proposal_Request__c (after update) {
	
	// If the Status field of a Proposal Request record has just changed 
	// and it has been set to either "Draft Posted", "Completed", or
	// "Review Session Ended", set the ProposalTaskWorkflow checkbox of all
	// Proposal Task records related to the Proposal Request record (but only one per responsible user).
	// The ProposalTaskWorkflow checkbox can be used to fire Proposal Task
	// workflow rules based upon the Status field changing of it's parent record.
	
	List<Id> prIds = new List<Id>();
	List<Proposal_Tasks__c> ptList = new List<Proposal_Tasks__c>();
	List<Proposal_Tasks__c> ptUpList = new List<Proposal_Tasks__c>();
	Map<Id, Proposal_Tasks__c> userPTMap = new Map<Id, Proposal_Tasks__c>();
	
	for (Proposal_Request__c pr :trigger.new) {
		if (pr.Status__c != trigger.oldMap.get(pr.Id).Status__c) {
			if (pr.Status__c == 'Draft Posted' || pr.Status__c == 'Completed' || pr.Status__c == 'Review Session Ended') {
				prIds.add(pr.Id);
			}
		}
	}
	
	if (!prIds.isEmpty()) {
		ptList = [select Id, Person_Responsible__c, Proposal_Request__c, ProposalTaskWorkflow__c from Proposal_Tasks__c where Proposal_Request__c in :prIds];
		
		// Get the State to Region Map
		Map<String, US_State_Region__c> stateRegion = new Map<String, US_State_Region__c>();
		stateRegion = US_State_Region__c.getAll();
		
		// Get the members of the Public Groups we are interested in
		Map<Id, Group> groupMap = new Map<Id, Group>([select Id, Name, Type from Group where Type = 'Regular' and (Name = 'Sales Project Review Team East' or Name = 'Sales Project Review Team West')]);
		List<GroupMember> groupUserList = new List<GroupMember>();
		groupUserList = [select Id, GroupId, UserOrGroupId from GroupMember where GroupId in :groupMap.keySet()];
		Map<Id, GroupMember> eastUserMap = new Map<Id, GroupMember>();
		Map<Id, GroupMember> westUserMap = new Map<Id, GroupMember>();
		for (GroupMember gm :groupUserList) {
			if (groupMap.containsKey(gm.GroupId)) {
				if (groupMap.get(gm.GroupId).Name == 'Sales Project Review Team East') {
					eastUserMap.put(gm.UserOrGroupId, gm);
				}
				if (groupMap.get(gm.GroupId).Name == 'Sales Project Review Team West') {
					westUserMap.put(gm.UserOrGroupId, gm);
				}
			}
		}
		
		// system.debug('*****Size of stateRegion = ' + stateRegion.size() + ' size of eastUserMap = ' + eastUserMap.size() + ' size of westUserMap = ' + westUserMap.size());

		// Set the ProposalTaskWorkflow flag for each Proposal Task record however if there are multiple Proposal
		// Task records per Proposal Request with the same user responsible, set the flag on only one of the records.
		// Also make sure that the flag is not set for a Proposal Task records that has a Person Responsible user that
		// is in one of the Public Groups.
		Boolean isGroupMember;
		for (Proposal_Request__c pr :trigger.new) {
			userPTMap.clear();
			for (Proposal_Tasks__c pt :ptList) {
				
				if (pt.Proposal_Request__c == pr.Id) {
					isGroupMember = false;
					if (pr.Project_State__c != null && stateRegion.containsKey(pr.Project_State__c)) {
						if (stateRegion.get(pr.Project_State__c).Region__c == 'East') {
							if (eastUserMap.containsKey(pt.Person_Responsible__c)) {
								isGroupMember = true;
							}
						}
						if (stateRegion.get(pr.Project_State__c).Region__c == 'West') {
							if (westUserMap.containsKey(pt.Person_Responsible__c)) {
								isGroupMember = true;
							}
						}
						if (pr.Opportunity__r.OwnerId == pt.Person_Responsible__c) {
							isGroupMember = true;
						}
					}
					
					if (!userPTMap.containsKey(pt.Person_Responsible__c) && !isGroupMember) {
						pt.ProposalTaskWorkflow__c = true;
						userPTMap.put(pt.Person_Responsible__c, pt);
					}
				}
			}
			if (!userPTMap.isEmpty()) {
				ptUpList.addAll(userPTMap.values());
			}
		}
		// system.debug('*****Number of Proposal Task records with flag set = ' + ptUpList.size());
		if (!ptUpList.isEmpty()) {
			update ptUpList;
		}
	}
}