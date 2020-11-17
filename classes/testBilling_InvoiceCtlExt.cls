@isTest(seealldata=true)
private class testBilling_InvoiceCtlExt {
	
	/*
	 *	Test methods for Billing_InvoiceCtlExt.cls
	 *
	 */
	
	// Create test data
	static void biTestData() {
		Account acc = new Account(Name = 'billybob - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
					Project_End_Date__c = null, ShippingStreet = 'Main Street', ShippingCity = 'San Francisco');
		insert acc;
		
		Contact con = new Contact(FirstName = 'Billy', LastName = 'Bob', AccountId = acc.Id);
		insert con;
		
		AcctSeed__Project__c proj = new AcctSeed__Project__c(Name = 'billybob - 2456', AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
					Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
					Job_Number__c = '000-000');
		insert proj;
		
		Contract cntrct = new Contract(AccountId = acc.Id, Contract_Number__c = '123', ASProject__c = proj.Id);
		insert cntrct;
		
		ContractContactRole ccr = new ContractContactRole(ContactId = con.Id, ContractId = cntrct.Id, Role = 'O&M Billing Contact');
		insert ccr;
		
		AcctSeed__GL_Account__c testGLAccount = new AcctSeed__GL_Account__c(AcctSeed__Type__c = 'Expense', Name = 'Test GL Account');
        insert testGLAccount;
		
		AcctSeed__Billing_Format__c billingF = new AcctSeed__Billing_Format__c(AcctSeed__Default_Email_Template__c = 'Billing_Email_Template', AcctSeed__Visualforce_PDF_Page__c = 'Billing_InvoicePDF');
		insert billingF;
		
		AcctSeed__Accounting_Period__c acctingPeriod = [Select Id, AcctSeed__Start_Date__c, AcctSeed__End_Date__c, Name, AcctSeed__Status__c 
                                                        	From AcctSeed__Accounting_Period__c WHERE Name='2020-12' LIMIT 1];
        
        //acctingPeriod = new AcctSeed__Accounting_Period__c(Name = '2016-01',AcctSeed__Start_Date__c = date.today().addYears(5), AcctSeed__End_Date__c = date.today().addYears(5).addMonths(3), AcctSeed__Status__c = 'Open');
        //insert acctingPeriod;
		
		AcctSeed__Billing__c billing = new AcctSeed__Billing__c(AcctSeed__Date__c = date.today(), AcctSeed__Customer__c = acc.Id, Period_To__c = Date.today(), AcctSeed__Accounting_Period__c = acctingPeriod.Id, AcctSeed__Billing_Format__c = billingF.Id, retainage__c = 10, Service_Contract__c = cntrct.Id);
        insert billing;
        
		AcctSeed__Billing_Line__c billingLine = new AcctSeed__Billing_Line__c(AcctSeed__Billing__c = billing.Id, AcctSeed__Hours_Units__c = 1, AcctSeed__Rate__c = 10.0, AcctSeed__Project__c = proj.Id, AcctSeed__Revenue_GL_Account__c = testGLAccount.Id);
		insert billingLine;
	}
	
	static testMethod void biTest1() {
		biTestData();
        
		List<AcctSeed__Billing__c> billingList = new List<AcctSeed__Billing__c>();
		billingList = [select Id from AcctSeed__Billing__c ORDER By CreatedDate DESC limit 1];
		system.assertEquals(1, billingList.size());
		
		ApexPages.StandardController std = new ApexPages.StandardController(billingList[0]);
		Billing_InvoiceCtlExt ctl = new Billing_InvoiceCtlExt(std);
	}
}