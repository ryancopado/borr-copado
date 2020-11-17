@isTest
private class testWhitePagesPro {
	
	/*
	 *	Test methods for Lead_WhitePagesProCtlExt.cls, Lead_SingleWhitePagesProCtlExt.cls, Account_WhitePagesProCtlExt.cls and WhitePagesPro.cls
	 */
	
	// Set up test data
	@testSetup static void wppTestData() {
		Lead testLead = new Lead(
			FirstName = 'Billy',
			LastName = 'Bob',
			Street = '562 Lombard Street',
			City = 'San Francisco',
			State = 'CA',
			PostalCode = '94133',
			Company = 'BillyBob Inc.',
			Phone = null
		);
		insert testLead;
        
        Account testAccount = new Account(
            Name = 'testAccount',
            Type = 'Customers',
            Industry = 'Other',
            Job_Type__c = 'Public',
            Branch__c = 'Nor Cal',
            Phone = '555-555-5555',
            BillingStreet = '564 Lombard Street',
            BillingCity = 'San Francisco',
            BillingState = 'CA',
            BillingPostalCode = '94133',
            BillingCountry = 'USA'
        );
        insert testAccount;
	}
	
	// Test the lead Find Person API functionality
	static testMethod void wppTest1() {
		Lead testLead = [select Id, Name, FirstName, LastName, Street, City, State, PostalCode, Company, Phone from Lead];
		system.assertEquals('Billy', testLead.FirstName);
		system.assertEquals(null, testLead.Phone);
		
		// Test with no leads selected
		Test.setCurrentPage(Page.Lead_FindPerson);
		List<Lead> selLead = new List<Lead>();
		ApexPages.StandardSetController stdSetLead = new ApexPages.StandardSetController(selLead);
		stdSetLead.setSelected(selLead);
		Lead_WhitePagesProCtlExt ctlLead = new Lead_WhitePagesProCtlExt(stdSetLead);
		
		// Test with selected leads
		selLead.add(testLead);
		stdSetLead.setSelected(selLead);
		ctlLead = new Lead_WhitePagesProCtlExt(stdSetLead);
		
		ctlLead.findPerson();
		testLead = [select Id, Name, FirstName, LastName, Street, City, State, PostalCode, Company, Phone from Lead];
		system.assertNotEquals(null, testLead.Phone);
	}
	
	// Test the lead Reverse Address API functionality
	static testMethod void wppTest2() {
		Lead testLead = [select Id, Name, FirstName, LastName, Street, City, State, PostalCode, Company, Phone from Lead];
		system.assertEquals('Billy', testLead.FirstName);
		system.assertEquals(null, testLead.Phone);
		
		// Test with one lead selected
		Test.setCurrentPage(Page.Lead_ReverseAddress);
		List<Lead> selLead = new List<Lead>();
		selLead.add(testLead);
		ApexPages.StandardSetController stdSetLead = new ApexPages.StandardSetController(selLead);
		stdSetLead.setSelected(selLead);
		Lead_WhitePagesProCtlExt ctlLead = new Lead_WhitePagesProCtlExt(stdSetLead);
		
		ctlLead.reverseAddress();
		testLead = [select Id, Name, FirstName, LastName, Street, City, State, PostalCode, Company, Phone from Lead];
		system.assertNotEquals(null, testLead.Phone);
	}
	
	// Test the single lead Reverse Address lookup
	static testMethod void wppTest3() {
		Lead testLead = [select Id, Name, FirstName, LastName, Street, City, State, PostalCode, Company, Phone from Lead];
		system.assertEquals('Billy', testLead.FirstName);
		system.assertEquals(null, testLead.Phone);
		
		ApexPages.StandardController std = new ApexPages.StandardController(testLead);
		Lead_SingleWhitePagesProCtlExt ctl = new Lead_SingleWhitePagesProCtlExt(std);
		
		PageReference pr = ctl.reverseAddress();
		List<Lead_SingleWhitePagesProCtlExt.LeadPerson_Class> persons = ctl.getpersons();
		system.assert(persons.size() > 0);
		pr = ctl.saveSelection();
		persons[0].selected = true;
		pr = ctl.getselectedPersons();
		pr = ctl.saveSelection();
		
		Lead_SingleWhitePagesProCtlExt.LeadPerson_Class personConstructor  = new Lead_SingleWhitePagesProCtlExt.LeadPerson_Class();
	}
	
	// Test the account Reverse Address API functionality
    static testMethod void wppTest4() {
        Account testAccount = [select Id, Name, Phone from Account];
        system.assertEquals('555-555-5555', testAccount.Phone);
        
        // Test with no accounts selected
        Test.setCurrentPage(Page.Account_ReverseAddress);
        List<Account> selAccount = new List<Account>();
        ApexPages.StandardSetController stdSetAccount = new ApexPages.StandardSetController(selAccount);
        stdSetAccount.setSelected(selAccount);
        Account_WhitePagesProCtlExt ctAccount = new Account_WhitePagesProCtlExt(stdSetAccount);
        
        // Test with one account selected
        selAccount.add(testAccount);
        stdSetAccount = new ApexPages.StandardSetController(selAccount);
        stdSetAccount.setSelected(selAccount);
        Account_WhitePagesProCtlExt ctlAccount = new Account_WhitePagesProCtlExt(stdSetAccount);
        
        ctlAccount.reverseAddress();
        testAccount = [select Id, Name, Phone, Updated_with_WhitePages__c from Account];
        system.assertNotEquals('555-555-5555', testAccount.Phone);
        system.assertEquals(system.today(), testAccount.Updated_with_WhitePages__c.date());
    }
	
	// Execute the rest of the WhitePagesPro JSON data structure
	static testMethod void wppTest5() {
		WhitePagesPro.WPP_Error_Class err = new WhitePagesPro.WPP_Error_Class();
		err.message = 'test';
		err.name = 'test';
		
		WhitePagesPro.WPP_LatLong_Class ll = new WhitePagesPro.WPP_LatLong_Class();
		ll.latitude = 'test';
		ll.longitude = 'test';
		ll.accuracy = 'test';
		
		WhitePagesPro.WPP_Phone_Class p = new WhitePagesPro.WPP_Phone_Class();
		p.id = 'test';
		p.phone_number = 'test';
		
		WhitePagesPro.WPP_AssociatedPeople_Class ap = new WhitePagesPro.WPP_AssociatedPeople_Class();
		ap.id = 'test';
		ap.name = 'test';
		ap.relation = 'test';
		
		WhitePagesPro.WPP_Address_Class add = new WhitePagesPro.WPP_Address_Class();
		add.id = 'test';
		add.location_type = 'test';
		add.street_line_1 = 'test';
		add.street_line_2 = 'test';
		add.city = 'test';
		add.postal_code = 'test';
		add.zip4 = 'test';
		add.state_code = 'test';
		add.country_code = 'test';
		add.is_active = 'test';
		add.delivery_point = 'test';
		add.link_to_person_start_date = 'test';
		add.link_to_person_end_date = 'test';
		
		WhitePagesPro.WPP_FP_Person_Class per = new WhitePagesPro.WPP_FP_Person_Class();
		per.id = 'test';
		per.name = 'test';
		per.firstname = 'test';
		per.middlename = 'test';
		per.lastname = 'test';
		per.age_range = 'test';
		per.gender = 'test';
		per.type = 'test';
		per.link_to_address_start_date = 'test';
		
		WhitePagesPro.WPP_FP_FindPerson_Class fp = new WhitePagesPro.WPP_FP_FindPerson_Class();
		fp.count_person = 'test';
		
		WhitePagesPro.WPP_FP_Response_Class fp_resp = new WhitePagesPro.WPP_FP_Response_Class();
		fp_resp.result = 'test';
		
		WhitePagesPro.WPP_RA_Person_Class ra_per = new WhitePagesPro.WPP_RA_Person_Class();
		ra_per.id = 'test';
		ra_per.name = 'test';
		ra_per.firstname = 'test';
		ra_per.middlename = 'test';
		ra_per.lastname = 'test';
		ra_per.age_range = 'test';
		ra_per.gender = 'test';
		ra_per.type = 'test';
		ra_per.link_to_address_start_date = 'test';

		WhitePagesPro.WPP_RA_AssociatedAddress_Class ra_aAdd = new WhitePagesPro.WPP_RA_AssociatedAddress_Class();
		ra_aAdd.id = 'test';
		ra_aAdd.is_valid = 'test';
		ra_aAdd.street_line_1 = 'test';
		ra_aAdd.street_line_2 = 'test';
		ra_aAdd.city = 'test';
		ra_aAdd.postal_code = 'test';
		ra_aAdd.zip4 = 'test';
		ra_aAdd.state_code = 'test';
		ra_aAdd.country_code = 'test';
		ra_aAdd.is_active = 'test';
		ra_aAdd.is_commercial = 'test';
		ra_aAdd.is_forwarder = 'test';
		ra_aAdd.delivery_point = 'test';
		ra_aAdd.last_sale_date = 'test';
		ra_aAdd.total_value = 'test';
		
		WhitePagesPro.WPP_RA_ReverseAddress_Class ra_revAdd = new WhitePagesPro.WPP_RA_ReverseAddress_Class();
		ra_revAdd.id = 'test';
		ra_revAdd.is_valid = 'test';
		ra_revAdd.street_line_1 = 'test';
		ra_revAdd.street_line_2 = 'test';
		ra_revAdd.city = 'test';
		ra_revAdd.postal_code = 'test';
		ra_revAdd.zip4 = 'test';
		ra_revAdd.state_code = 'test';
		ra_revAdd.country_code = 'test';
		ra_revAdd.is_active = 'test';
		ra_revAdd.is_commercial = 'test';
		ra_revAdd.is_forwarder = 'test';
		ra_revAdd.delivery_point = 'test';
		ra_revAdd.last_sale_date = 'test';
		ra_revAdd.total_value = 'test';
		
		WhitePagesPro.WPP_RA_Response_Class ra_resp = new WhitePagesPro.WPP_RA_Response_Class();
		ra_resp.result = 'test';
	}
}