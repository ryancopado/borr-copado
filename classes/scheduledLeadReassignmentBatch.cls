global class scheduledLeadReassignmentBatch implements Schedulable {
	global void execute(SchedulableContext SC) {
		launchLeadReassignmentBatch.launchLeadReassignment();
	}
}