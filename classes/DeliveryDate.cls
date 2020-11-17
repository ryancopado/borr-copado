public with sharing class DeliveryDate {
	
	public static void resetDeliveryDateReminder() {
		
		//Reset the Opportunity drop down that reminds the owner to
		//update the delivery dates for Racking, Module, and Inverters.
		//We only do this for Opportunity records that have associated Project records.
		
		//Get all the Opportunity and Project records we are interested in
		SFDC_Project__c[] pro = [select Id, Opportunity__c from SFDC_Project__c
				where Opportunity__c !=:null and Project_Type__c =:'Turnkey System' and
				(SFDC_Project_Status__c =:'Pre-Contract' or SFDC_Project_Status__c =:'New' or
				SFDC_Project_Status__c =:'Design' or SFDC_Project_Status__c =:'Construction') and
				(SFDC_Project_Stage__c =:null or SFDC_Project_Stage__c =:'Budget Locked' or
				SFDC_Project_Stage__c =:'Subcontractors Selected' or SFDC_Project_Stage__c =:'In Progress') and
				(Racking_Status__c =:'Product Defined' or Modules_Status__c =:'Product Defined' or Inverter_Status__c =:'Product Defined')];
		
		List<Id> oppId = new List<Id>();
		for (Integer i=0; i<pro.size(); i++) {
			oppId.add(pro[i].Opportunity__c);
		}
		
		Opportunity[] o = [select Id, Delivery_Date_Updated__c, Module_Delivery_Date_Updated__c,
				Inverter_Delivery_Date_Updated__c, Racking_Delivery_Date_Updated__c
				from Opportunity where Id in :oppId and Type =:'Turnkey System' and
				(StageName =:'Contract Negotiations' or StageName =:'Contract Signed')];
		
		List<Opportunity> upOpp = new List<Opportunity>();
		for (Integer i=0; i<o.size(); i++) {				
			if ( (o[i].Module_Delivery_Date_Updated__c == false) ||
				 (o[i].Inverter_Delivery_Date_Updated__c == false) ||
				 (o[i].Racking_Delivery_Date_Updated__c == false) ) {
				o[i].Delivery_Date_Updated__c = 'No';
			}
			o[i].Module_Delivery_Date_Updated__c = false;
			o[i].Inverter_Delivery_Date_Updated__c = false;
			o[i].Racking_Delivery_Date_Updated__c = false;
			upOpp.add(o[i]);
		}
		
		if (upOpp.size() > 0) {
			update upOpp;
		}
	}
	
	static testMethod void testDeliveryDate() {
		resetDeliveryDateReminder();
	}
}