trigger dupCode on Budget_Line_Item__c (before insert) {
	
	// Query all Line Items on Budget, put Cost Codes in List.
	List<Id> codes = new List<Id>();
/*	Budget_Line_Item__c[] budg = [select Budget__c, Cost_Code__c from Budget_Line_Item__c where Budget__c = :Trigger.new[0].Budget__c];
	for (Integer i = 0; i <budg.size(); i++) {
        codes.add(budg[i].Cost_Code__c);     
    }  */
    for (Integer i = 0; i <Trigger.new.size(); i++) {
    	codes.clear();
    	Budget_Line_Item__c[] budg = [select Budget__c, Cost_Code__c from Budget_Line_Item__c where Budget__c = :Trigger.new[i].Budget__c];
    	for (Integer k = 0; k <budg.size(); k++) {
        	codes.add(budg[k].Cost_Code__c);     
    	} 
    	for (Integer m = 0; m <codes.size(); m++) {	
	    	if (Trigger.new[i].Cost_Code__c == codes[m]) {
	    		Trigger.new[i].addError('There is already a Budget Line Item with this Cost Code. Please try a different Code or update the other Line Item.');
	    	}
    	}
    } 
} 
/*
Need to create a map of budget Id and list of CCs with that budget.
Need to get Budget and CC together through BLI ... map?
Make list of budgets - query through list and add CCs to new list (reset list at each loop)
if (trigger.new[i].Cost_Code__c == map.get(trigger.new.[i].Budget__c))

List<Id> budgets = new List<Id>();
Map<Id, Id> budgCode = new Map<Id, Id>();
Map<Id, List<Id>> budgList = new Map<Id, List<Id>>();

for (Integer i = 0; i <budgets.size(); i++) {
    	codes.clear();
    	for (Integer m = 0; m <budgCode.size(); m++) {
    		codes.add(budgCode.get(budgets[i]));
    	}
    	budgList.put(budgets[i], codes);  	
    } 
*/