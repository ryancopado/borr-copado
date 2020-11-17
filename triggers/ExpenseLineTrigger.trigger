trigger ExpenseLineTrigger on AcctSeed__Expense_Line__c (after update) {
	MapExpenseLineToAccountPayableLine.mapExpenseFieldsToAccountPayable(Trigger.oldMap, Trigger.newMap);
}