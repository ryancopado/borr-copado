trigger oppDeliveryDate on Opportunity (before insert, before update) {
	
	//Set the Delivery Date Updated field to 'Yes' if the Module Deliver Date,
	//Inverter Deliver Date, or Racking Delivery Date fields have been changed.
	if (Trigger.isInsert) {
		for (Integer i=0; i<Trigger.new.size(); i++) {
			if (Trigger.new[i].Module_Delivery_Date__c != null) {
				Trigger.new[i].Module_Delivery_Date_Updated__c = true;
				Trigger.new[i].Delivery_Date_Updated__c = 'Yes';
			}
			if (Trigger.new[i].Inverter_Delivery_Date__c != null) {
				Trigger.new[i].Inverter_Delivery_Date_Updated__c = true;
				Trigger.new[i].Delivery_Date_Updated__c = 'Yes';
			}
			if (Trigger.new[i].Racking_Delivery_Date__c != null) {
				Trigger.new[i].Racking_Delivery_Date_Updated__c = true;
				Trigger.new[i].Delivery_Date_Updated__c = 'Yes';
			}
		}
	}
	
	if (Trigger.isUpdate) {
		for (Integer i=0; i<Trigger.new.size(); i++) {
			if (Trigger.new[i].Module_Delivery_Date__c != Trigger.old[i].Module_Delivery_Date__c) {
				Trigger.new[i].Module_Delivery_Date_Updated__c = true;
				Trigger.new[i].Delivery_Date_Updated__c = 'Yes';
			}
			if (Trigger.new[i].Inverter_Delivery_Date__c != Trigger.old[i].Inverter_Delivery_Date__c) {
				Trigger.new[i].Inverter_Delivery_Date_Updated__c = true;
				Trigger.new[i].Delivery_Date_Updated__c = 'Yes';
			}
			if (Trigger.new[i].Racking_Delivery_Date__c != Trigger.old[i].Racking_Delivery_Date__c) {
				 Trigger.new[i].Racking_Delivery_Date_Updated__c = true;
				 Trigger.new[i].Delivery_Date_Updated__c = 'Yes';
			}
		}
	}
}