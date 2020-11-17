trigger APLineBeforeInsert on AcctSeed__Account_Payable_Line__c (before insert) {

    List<String> projectIDs = new List<String>();
    List<Id> apIds = new List<Id>();
    List<AcctSeed__Account_Payable__c> apList = new List<AcctSeed__Account_Payable__c>();
    Map<Id, AcctSeed__Account_Payable__c> apMap = new Map<Id, AcctSeed__Account_Payable__c>();
    
    for (AcctSeed__Account_Payable_Line__c apl : trigger.new) {
        if (apl.AcctSeed__Project__c != NULL) {
            projectIDs.add(apl.AcctSeed__Project__c);
        }
        apIds.add(apl.AcctSeed__Account_Payable__c);
    }
    
    Map<Id, AcctSeed__Project__c> projects = new Map<Id, AcctSeed__Project__c> ( [select Id, Default_Expense_GL_Account__c, Branch__c from  AcctSeed__Project__c where id in: projectIDs and (Default_Expense_GL_Account__c!= null or Branch__c != '')]);

    for (AcctSeed__Account_Payable_Line__c apl : trigger.new) {
    	if (apl.AcctSeed__Project__c != NULL && projects.containsKey(apl.AcctSeed__Project__c)) {
    		if (projects.get(apl.AcctSeed__Project__c).Default_Expense_GL_Account__c != NULL) {
                apl.AcctSeed__Expense_GL_Account__c = projects.get(apl.AcctSeed__Project__c).Default_Expense_GL_Account__c;
            }
        }
    }
    
    // Map the Project records Branch__c field to the Branch__c and GL_Account_Variable_1__c fields of the AP Line records
    APLineUtilities.aplSetBranch(projects, trigger.new); 
    
    // Copy the Description__c field of the associated Account Payable record to the Description__c field of the Account Payable Line records
    if (apIds.size() > 0) {
    	apList = [SELECT Id, Description__c FROM AcctSeed__Account_Payable__c WHERE Id IN: apIds];
    	for (AcctSeed__Account_Payable__c ap : apList) {
    		apMap.put(ap.Id, ap);
    	}
    	for (AcctSeed__Account_Payable_Line__c apl : trigger.new) {
    		apl.Description__c = apMap.get(apl.AcctSeed__Account_Payable__c).Description__c;
    	}
    }
}