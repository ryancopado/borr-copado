global class scheduledDeliveryDate implements Schedulable {
	global void execute(SchedulableContext SC) {
		DeliveryDate.resetDeliveryDateReminder();
	}
}