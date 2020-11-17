global class migrate {

	webService static void calcTimeEntries(Id[] teId) {
		
		// Intended to be run only once just after going to production with the
		// ability to change Rate (Project) and Rate (Internal) on the Team Member and User
		// objects.
		//
		// Copy the current (now old) formula fields to the new calculation fields for all
		// existing Time Entry objects
		Time_Entry__c[] te = [select Rate_Internal__c, Rate_Project__c, Total_Cost_Internal__c, Total_Cost_Project__c,
									Rate_Internal_Calc__c, Rate_Project_Calc__c, Total_Cost_Internal_Calc__c, Total_Cost_Project_Calc__c
									from Time_Entry__c where Id in :teId];
		for (Integer i=0; i<te.size(); i++) {
			te[i].Rate_Internal_Calc__c = te[i].Rate_Internal__c;
			te[i].Rate_Project_Calc__c = te[i].Rate_Project__c;
			te[i].Total_Cost_Internal_Calc__c = te[i].Total_Cost_Internal__c;
			te[i].Total_Cost_Project_Calc__c = te[i].Total_Cost_Project__c;
		}
		update te;
	}
	
	webService static void oppDeliveryDate() {
		DeliveryDate.resetDeliveryDateReminder();
	}
	
	webService static void convertJobNum(Id[] pId) {
		//Convert Project Pre Contract job numbers (950) to non Pre Contract numbers
		SFDC_Project__c[] p = [select Id, Pre_Contract__c, SFDC_Project_Status__c, Job_Number__c, 
    								Project_Type__c,Branch__c, Number__c from SFDC_Project__c 
    								where Id in :pId];
    	ProjectCreate.convertToNewJobNum(p);
    	update(p);
	}
}