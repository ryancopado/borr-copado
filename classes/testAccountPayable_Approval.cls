/**
 * This class contains unit tests for validating the behavior of
 * AccountPayable_Approval.cls.
 */

@isTest(seeAllData=true)
private class testAccountPayable_Approval {

    public static AcctSeed__Account_Payable__c initTestData() {
    	
    	// Create all of the data we will need for the unit tests
		List<Account> accounts = new List<Account>();
		accounts.add(
			new Account(
				Name = 'adfg Acc1',
				RecordTypeId = '012800000007h2p',
				AcctSeed__Accounting_Active__c = true,
				AcctSeed__Accounting_Type__c = 'Customer and Vendor',
				ShippingCity = 'San Francisco',
				AcctSeed__Credit_Card_Vendor__c = true
			)
		);
		accounts.add(
			new Account(
				Name = 'vblo Acc2',
				RecordTypeId = '012300000000Yip',
				Type = 'Business',
				Job_Type__c = 'Commercial',
				Branch__c = 'Berkeley',
				ShippingStreet = 'x',
				ShippingCity = 'x',
				ShippingState = 'x',
				ShippingPostalCode = 'x',
				AcctSeed__Accounting_Type__c = 'Customer'
			)
		);
		insert accounts;
		
		List<Opportunity> opp = new List<Opportunity>();
		opp.add(
			new Opportunity(
				Approximate_Install_Date__c = system.today(),
				Name = 'Test Opportunity',
				RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId(),
				Job_Type__c = 'PV Direct',                                 
				Accountid = accounts[1].Id,
				StageName = 'Project Awarded',
				Last_Date_Called__c = system.today(),
				Module_Delivery_Date__c = system.today(),
				Inverter_Delivery_Date__c = system.today(),
				Racking_Delivery_Date__c = system.today(),
				CloseDate = system.today(),
				Type = 'Turnkey System',
				Proposal_Submitted_Date__c = system.today(),
				Proposed_System_Size__c = 10000,
				Expected_Rebate__c = 0,
				Utility_Rate__c = 'N/A',
				Prevailing_Wage__c = 'No', 
				Original_Contract_System_Size__c = 1000,
				Amount = 1000,
				Financing__c = 'Cash'
			)
		);
		insert opp;
		
		List<AcctSeed__Project__c> project = new List<AcctSeed__Project__c>();
		project.add(
			new AcctSeed__Project__c(
				AcctSeed__Opportunity__c = opp[0].Id,
				Name = 'Test Project'
			)
		);
		insert project;
		
		List<AcctSeed__GL_Account__c> glAccounts = new List<AcctSeed__GL_Account__c>();
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '3600-Cost of revenue - installation - test',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense'
            )
        );
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '3604-Unassigned COGS - test',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense'
            )
        );
        insert glAccounts;
        
        List<Product2> products = new List<Product2>();
        products.add(
            new Product2(
                Name = 'Other Subcontractor - test',
                AcctSeed__Inventory_GL_Account__c = glAccounts[1].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[1].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[1].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
                AcctSeed__Inventory_Product__c = true,
                AcctSeed__Unit_Cost__c = 1,
                Status__c = 'Approved For Sale'
            )
        );
        insert products;
        
        List<Tax_Rate__c> taxRates = new List<Tax_Rate__c>();
        taxRates.add(
            new Tax_Rate__c(
                Tax_Rate__c = 7
            )
        );  
        insert taxRates;
        
        List<AcctSeedERP__Purchase_Order__c> purchaseOrders = new List<AcctSeedERP__Purchase_Order__c>();
        purchaseOrders.add(
            new AcctSeedERP__Purchase_Order__c(
               AcctSeedERP__Vendor__c = accounts[0].Id,
               AcctSeedERP__Status__c = 'Open',
               AcctSeedERP__Type__c = 'Non-Material'
            )
        );
        insert purchaseOrders;
        
        List<AcctSeedERP__Purchase_Order_Line__c> purchaseOrderLines = new List<AcctSeedERP__Purchase_Order_Line__c>();
        purchaseOrderLines.add(
            new AcctSeedERP__Purchase_Order_Line__c(
               AcctSeedERP__Purchase_Order__c = purchaseOrders[0].Id,
               AcctSeedERP__Product__c = products[0].Id,
               AcctSeedERP__Quantity__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Unit_Cost__c = 4,
               Freight__c = 10,
               Sales_Tax_Rate_Table__c = taxRates[0].Id
            )        
        );
        insert purchaseOrderLines;
        
        List<Addresses__c> addrs = new List<Addresses__c>();
        addrs.add(new Addresses__c(
        	Name = 'test addr',
        	Account__c = accounts[0].Id,
        	Street_Address__c = '123 Main Street',
        	City__c = 'San Francisco',
        	State__c = 'California',
        	Zip_Code__c = '94107')
        );
        insert addrs;
        
        List<AcctSeed__Account_Payable__c> apInvoices = new List<AcctSeed__Account_Payable__c>();
        apInvoices.add(
        	new AcctSeed__Account_Payable__c(
        		Approval_Status__c = 'New',
        		Invoice_Amount__c = 7000,
        		Final_Invoice__c = false,
        		AcctSeed__Payment_Status__c = 'Unpaid',
        		Purchase_Order__c = purchaseOrders[0].Id,
        		AcctSeed__Vendor__c = accounts[0].Id,
        		AcctSeed__Date__c = system.today(),
        		AcctSeed__Due_Date__c = system.today(),
        		AcctSeed__Payee_Reference__c = 'test',
        		Invoice_Type__c = 'Other',
        		Remit_to__c = addrs[0].Id
        	)
        );
        insert apInvoices;
        
        List<AcctSeed__Account_Payable_Line__c> apLines = new List<AcctSeed__Account_Payable_Line__c>();
        apLines.add(
        	new AcctSeed__Account_Payable_Line__c(
        		AcctSeed__Account_Payable__c = apInvoices[0].Id,
        		AcctSeed__Amount__c = 7000,
        		AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
        		AcctSeed__Product__c = products[0].Id,
        		AcctSeedERP__Purchase_Order_Line__c = purchaseOrderLines[0].Id,
        		AcctSeed__Quantity__c = 1
        	)
        );
        insert apLines;
        
        return apInvoices[0];
    }
    
    public static AccountPayable_ApprovalCTL initAccountPayable_ApprovalProc() {
		
		// Initialize the basic data set
		AcctSeed__Account_Payable__c apInvoice = initTestData();
		
		// Initialize the approval process for Account Payable
		ApexPages.currentPage().getParameters().put('apId', apInvoice.Id);
		Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
		req1.setComments('Submitting request for approval.');
		req1.setObjectId(apInvoice.Id);
		req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
		Approval.ProcessResult result = Approval.process(req1);
		
		system.debug('***** AP Invoice Approval.ProcessResult = ' + result);
		
		List<Id> newWorkItemIds = result.getNewWorkitemIds();
		if (newWorkItemIds != null && newWorkItemIds.size() > 0) {
			ApexPages.currentPage().getParameters().put('id',newWorkItemIds.get(0));
		}
		
		AccountPayable_ApprovalCTL proc = new AccountPayable_ApprovalCTL();
		return proc;
	}
	
	static testMethod void testAPInvoiceCase1() {
     	
		AccountPayable_ApprovalCTL proc = initAccountPayable_ApprovalProc();
        Test.startTest();
        proc.cancel();
        Test.stopTest();
	}
	
	static testMethod void testAPInvoiceCase2() {
		
		AccountPayable_ApprovalCTL proc = initAccountPayable_ApprovalProc();
        Test.startTest();
        proc.reject();
        Test.stopTest();
	}
	
	static testMethod void testAPInvoiceCase3() {
		AcctSeed__Account_Payable__c apInvoice;
		
		AccountPayable_ApprovalCTL proc = initAccountPayable_ApprovalProc();
        Test.startTest();
        proc.approve();
        apInvoice = [select Id, Final_Invoice__c from AcctSeed__Account_Payable__c apInvoice where Id = :proc.apRecord.Id];
        system.assertEquals(false, apInvoice.Final_Invoice__c);
        Test.stopTest();
	}
	
	static testMethod void testAPInvoiceCase4() {
		AcctSeed__Account_Payable__c apInvoice;
		
		AccountPayable_ApprovalCTL proc = initAccountPayable_ApprovalProc();
        Test.startTest();
        proc.apRecord.Final_Invoice__c = true;
        proc.approve();
        apInvoice = [select Id, Final_Invoice__c from AcctSeed__Account_Payable__c apInvoice where Id = :proc.apRecord.Id];
        system.assertEquals(true, apInvoice.Final_Invoice__c);
        Test.stopTest();
        
	}
}