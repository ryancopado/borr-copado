public class MapExpenseLineToAccountPayableLine {
	
	public static void mapExpenseFieldsToAccountPayable(Map<Id,AcctSeed__Expense_Line__c> oldLines, Map<Id,AcctSeed__Expense_Line__c> newLines) {
		List<AcctSeed__Account_Payable_Line__c> apLineUpdate = new List<AcctSeed__Account_Payable_Line__c>();
		Map<String,AcctSeed__Accounting_Variable__c> accountVar1Map = new Map<String,AcctSeed__Accounting_Variable__c>();
		
		for (AcctSeed__Expense_Line__c newLine : [Select Id, AcctSeed__Expense_Report__c, AcctSeed__Expense_Report__r.ReportBranch__c
													From AcctSeed__Expense_Line__c Where Id In :newLines.keySet()]) {
				accountVar1Map.put(newLine.AcctSeed__Expense_Report__r.ReportBranch__c,null);											
		}
		
		for (AcctSeed__Accounting_Variable__c glAccountVar : [Select Id, Name From AcctSeed__Accounting_Variable__c Where Name In :accountVar1Map.keySet() And AcctSeed__Type__c = 'GL Account Variable 1'])	{
			accountVar1Map.put(glAccountVar.Name, glAccountVar);	
		}
		
		for (AcctSeed__Expense_Line__c newLine : [Select Id, AcctSeed__Account_Payable_Line__c, AcctSeed__Internal_Comment__c, AcctSeed__Expense_Report__r.ReportBranch__c, AcctSeed__Account_Payable_Line__r.AcctSeed__Account_Payable__r.AcctSeed__Status__c
															From AcctSeed__Expense_Line__c Where Id In :newLines.keySet()]) {
																
			AcctSeed__Expense_Line__c oldLine = oldLines.get(newLine.Id);
																
			if (oldLine.AcctSeed__Account_Payable_Line__c == null && newLine.AcctSeed__Account_Payable_Line__c != null && newLine.AcctSeed__Account_Payable_Line__r.AcctSeed__Account_Payable__r.AcctSeed__Status__c != 'Posted') {
				newLine.AcctSeed__Account_Payable_Line__r.Description__c = newLine.AcctSeed__Internal_Comment__c;
				newLine.AcctSeed__Account_Payable_Line__r.AcctSeed__GL_Account_Variable_1__c = accountVar1Map.get(newLine.AcctSeed__Expense_Report__r.ReportBranch__c) != null ? accountVar1Map.get(newLine.AcctSeed__Expense_Report__r.ReportBranch__c).Id : null;
				apLineUpdate.add(newLine.AcctSeed__Account_Payable_Line__r);
			}
		}
		
		update apLineUpdate;
	}
	
	@isTest(seeAllData=true)
	public static void testMapExpenseFieldsToAccountPayable() {
		TestDataSuite.initialize();
		Integer i = 0;
		
		Map<Id,AcctSeed__Expense_Report__c> expenseReports = new Map<Id,AcctSeed__Expense_Report__c>();
		
		for (AcctSeed__Expense_Line__c el : [Select Id, AcctSeed__Internal_Comment__c, AcctSeed__Expense_Report__r.Id From AcctSeed__Expense_Line__c Where Id In :TestDataSuite.expenses]) {		
			el.AcctSeed__Internal_Comment__c = 'Test' + i;
			//el.AcctSeed__Expense_Report__r.ReportBranch__c = 'Sales';
			el.AcctSeed__Account_Payable_Line__c = TestDataSuite.accountPayableLines[i].Id;
			
			if (!expenseReports.containsKey(el.AcctSeed__Expense_Report__r.Id))
				expenseReports.put(el.AcctSeed__Expense_Report__r.Id,el.AcctSeed__Expense_Report__r);
			i++;
		}
		
		update expenseReports.values();
		update TestDataSuite.expenses;
		
		i = 0;
		 
		for (AcctSeed__Account_Payable_Line__c apLine : [Select Id, Description__c, AcctSeed__GL_Account_Variable_1__r.Name, (Select Id, AcctSeed__Expense_Report__r.ReportBranch__c From AcctSeed__Expenses__r) From AcctSeed__Account_Payable_Line__c Where Id In :TestDataSuite.accountPayableLines]) {
			
			if (apLine.AcctSeed__Expenses__r != null && !apLine.AcctSeed__Expenses__r.isEmpty()) {
				System.assertEquals(apLine.AcctSeed__Expenses__r[0].AcctSeed__Expense_Report__r.ReportBranch__c, apLine.AcctSeed__GL_Account_Variable_1__r.Name);
				System.assertEquals('Test' + i, apLine.Description__c);
			}	
			i++;
		}
	}
}