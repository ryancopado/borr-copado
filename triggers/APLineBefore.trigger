trigger APLineBefore on AcctSeed__Account_Payable_Line__c (before insert) {
	
	List<String> projectIDs = new List<String>();
	List<AcctSeed__Account_Payable_Line__c> aplList = new List<AcctSeed__Account_Payable_Line__c>();
    List<Id> apIds = new List<Id>();
    List<AcctSeed__Account_Payable__c> apList = new List<AcctSeed__Account_Payable__c>();
    Map<Id, AcctSeed__Account_Payable__c> apMap = new Map<Id, AcctSeed__Account_Payable__c>();
    List<Id> polIds = new List<Id>();
    List<Id> coIds = new List<Id>();
    
    for (AcctSeed__Account_Payable_Line__c apl : trigger.new) {
        if (apl.AcctSeed__Project__c != NULL) {
            projectIDs.add(apl.AcctSeed__Project__c);
        }
        
        // AP Lines may have a related Purchase Order Line or Change Order, but not both
        if (apl.AcctSeedERP__Purchase_Order_Line__c != null) {
        	polIds.add(apl.AcctSeedERP__Purchase_Order_Line__c);
        } else {
        	if (apl.Change_Order__c != null) {
        		coIds.add(apl.Change_Order__c);
        	}
        }
        
        if (!apl.Dataload__c) {
			aplList.add(apl);
        	apIds.add(apl.AcctSeed__Account_Payable__c);
        } else {
        	apl.Dataload__c = FALSE;
        }
    }
    
	Map<Id, AcctSeedERP__Purchase_Order_Line__c> polMap = new Map<Id, AcctSeedERP__Purchase_Order_Line__c>([select Id, AcctSeedERP__Project_Task__c from AcctSeedERP__Purchase_Order_Line__c where Id in: polIds]);
	Map<Id, Con_Req__c> coMap = new Map<Id, Con_Req__c>([select Id, Budget_Line_Item2__c from Con_Req__c where Id in: coIds]);
	
    //Map<Id, AcctSeed__Project__c> projects = new Map<Id, AcctSeed__Project__c> ( [select Id, Default_Expense_GL_Account__c, Branch__c from  AcctSeed__Project__c where id in: projectIDs and (Default_Expense_GL_Account__c!= null or Branch__c != '')]);
    Map<Id, AcctSeed__Project__c> projects = new Map<Id, AcctSeed__Project__c> ( [select Id, Default_Expense_GL_Account__c, Branch__c, Sales_Segment__c, Ops_Division__c from  AcctSeed__Project__c where id in: projectIDs]);

    for (AcctSeed__Account_Payable_Line__c apl : trigger.new) {
    	if (apl.AcctSeed__Project__c != NULL && projects.containsKey(apl.AcctSeed__Project__c)) {
    		if (projects.get(apl.AcctSeed__Project__c).Default_Expense_GL_Account__c != NULL) {
 				apl.AcctSeed__Expense_GL_Account__c = projects.get(apl.AcctSeed__Project__c).Default_Expense_GL_Account__c;
            }
            apl.AcctSeed__GL_Account_Variable_2__c = projects.get(apl.AcctSeed__Project__c).Sales_Segment__c;
            apl.AcctSeed__GL_Account_Variable_3__c = projects.get(apl.AcctSeed__Project__c).Ops_Division__c;
        }
        
        // Set the Line Item (AcctSeed__Project_Task__c) to either the Purchase Order Line record's value or the Change Order record's value
        if (apl.AcctSeedERP__Purchase_Order_Line__c != null && polMap.containsKey(apl.AcctSeedERP__Purchase_Order_Line__c)) {
        	apl.AcctSeed__Project_Task__c = polMap.get(apl.AcctSeedERP__Purchase_Order_Line__c).AcctSeedERP__Project_Task__c;
        }
        if (apl.Change_Order__c != null && coMap.containsKey(apl.Change_Order__c)) {
        	apl.AcctSeed__Project_Task__c = coMap.get(apl.Change_Order__c).Budget_Line_Item2__c;
        }
        
    }
   	
    // Copy the Description__c field of the associated Account Payable record to the Description__c field of the Account Payable Line records
	if (apIds.size() > 0) {
    	apList = [SELECT Id, Description__c FROM AcctSeed__Account_Payable__c WHERE Id IN: apIds];
    	for (AcctSeed__Account_Payable__c ap : apList) {
    		apMap.put(ap.Id, ap);
    	}
    	for (AcctSeed__Account_Payable_Line__c apl : aplList) {
    		if (apl.AcctSeed__Account_Payable__c != NULL && apMap.containsKey(apl.AcctSeed__Account_Payable__c)) {
    			apl.Description__c = apMap.get(apl.AcctSeed__Account_Payable__c).Description__c;
    		}
    	}
    }

	// Map the Project records Branch__c field to the Branch__c and GL_Account_Variable_1__c fields of the AP Line records
	if (projects.size() > 0 && aplList.size() > 0) {
		APLineUtilities.aplSetBranch(projects, aplList);
	}
}