public class WebToLeadWithAttachment {
	
	ApexPages.StandardController stdController;
    private final Lead newlead;
	
	// Page parameters
	public string first_name {get; set;}
	public string last_name {get; set;}
	string phone = '';
	string email = '';
	string city = '';
	string state = '';
	string branch = '';
	string applying_for = '';
	string salary_range = '';
	transient string cover_letter = '';
	transient string resume = '';
	string hear_about = '';
	string company = '';
	string record_type = '';
	string file_name = '';
	transient string file_data = '';
	transient string file_content = '';
	public string requisition {get; set;}
	
	public WebToLeadWithAttachment(ApexPages.StandardController stdController) {
        
        this.newlead = (Lead)stdController.getRecord();
        this.stdController = stdController;
        
        // Initialize parameters that have to go back
        first_name = '';
        last_name = '';
        requisition = '';
        
        //system.debug('*****WebToLeadWithAttachment constructor called');
        
        // Get all of the page parameters
        first_name = ApexPages.currentPage().getParameters().get('first_name');
        last_name = ApexPages.currentPage().getParameters().get('last_name');
        phone = ApexPages.currentPage().getParameters().get('phone');
        email = ApexPages.currentPage().getParameters().get('email');
        city = ApexPages.currentPage().getParameters().get('city');
        state = ApexPages.currentPage().getParameters().get('state');
        branch = ApexPages.currentPage().getParameters().get('branch');
        applying_for = ApexPages.currentPage().getParameters().get('applying_for');
        salary_range = ApexPages.currentPage().getParameters().get('salary_range');
        cover_letter = ApexPages.currentPage().getParameters().get('cover_letter');
        resume = ApexPages.currentPage().getParameters().get('resume');
        hear_about = ApexPages.currentPage().getParameters().get('hear_about');
        company = ApexPages.currentPage().getParameters().get('company');
        record_type = ApexPages.currentPage().getParameters().get('record_type');
        file_name = ApexPages.currentPage().getParameters().get('file_name');
        file_data = ApexPages.currentPage().getParameters().get('file_data');
        file_content = ApexPages.currentPage().getParameters().get('file_content');
        requisition = ApexPages.currentPage().getParameters().get('requisition');
	}

	public Boolean isError {get; set;}
	public String errorMsg {get; set;}
	
	public void webtolead() {
		
		Lead newld = new Lead();
		RecordType rt = new RecordType();
		
		//system.debug('*****webtolead method called');
		//system.debug('*****record_type' + record_type);
		
		isError = FALSE;
		if (last_name == NULL || company == NULL || branch == NULL) {
			isError = TRUE;
			errorMsg = 'Last Name, Company, and Branch cannot be blank.';
		} else {
			// Create a new lead record using the data in the page parameters
			if (record_type != NULL) {
				rt = [SELECT Id, Name FROM RecordType WHERE Id =: record_type];
			} else {
				rt = [SELECT Id, Name FROM RecordType WHERE Name =: 'Employment Applicant'];
			}
			
			// Lead minimum required fields
			newld.RecordTypeId = rt.Id;
			newld.LastName = last_name;
			newld.Branch__c = branch;
			newld.Company = company;
			
			// Other Lead fields
			newld.FirstName = first_name;
			newld.Phone = phone;
			newld.Email = email;
			newld.City = city;
			newld.State = state;
			newld.Job_Applying_For__c = applying_for;
			newld.Salary_Range__c = salary_range;
			newld.Cover_Letter__c = cover_letter;
			newld.Resume__c = resume;
			newld.Where_did_you_hear_about_us__c = hear_about;
			newld.LeadSource = 'www.borregosolar.com';
			newld.Job_Requisition__c = requisition;
			
			Savepoint sp = Database.setSavepoint();
			try {
				// Enable use of assignment rules and auto response rules
				Database.DMLOptions dmlOpts = new Database.DMLOptions();
				dmlOpts.assignmentRuleHeader.useDefaultRule = true; 
				dmlOpts.emailHeader.triggerAutoResponseEmail = true; 
				dmlOpts.emailHeader.triggerUserEmail = true;  
				newld.setOptions(dmlOpts); 
				insert newld;
			
				// Check to see if there is an attachment
				Attachment att = new Attachment();
				if (!(file_name == NULL || file_name == '' || file_content == NULL || file_content == '')) {

					//system.debug('*****file_name = ' + file_name);
					//system.debug('*****parameter file_name = ' + ApexPages.currentPage().getParameters().get('file_name'));
					//system.debug('*****file_data = ' + file_data);
					//system.debug('*****parameter file_content = ' + ApexPages.currentPage().getParameters().get('file_content'));
					//system.debug('*****parameter file_content length = ' + ApexPages.currentPage().getParameters().get('file_content').length());

					att.Name = file_name;
					//att.Body =  EncodingUtil.base64Decode(ApexPages.currentPage().getParameters().get('file_content'));
					att.Body =  EncodingUtil.base64Decode(file_content);
					att.ParentId = newld.Id;
					insert att;
				}
			} catch (Exception e) {
				Database.rollback(sp);
				isError = TRUE;
				errorMsg = 'System exception, employment application not submitted. Error = ' + e;
				System.debug(Logginglevel.ERROR, 'Failed to create lead and/or attachment. Error = ' + e);
			}
		}
	}
	
	@isTest(seeAllData=true)
	public static void WebToLeadWithAttachmentTest() {
		
		RecordType rt = [SELECT Id, Name FROM RecordType WHERE Name =: 'Employment Applicant'];
				
		// Add the parameters to the page to be tested
		ApexPages.currentPage().getParameters().put('first_name', 'WTLA firstname');
		ApexPages.currentPage().getParameters().put('last_name', 'WTLA lastname');
		ApexPages.currentPage().getParameters().put('company', 'WTLA Borrego Solar');
		ApexPages.currentPage().getParameters().put('branch', 'WTLA Park City');
		ApexPages.currentPage().getParameters().put('record_type', rt.Id);
		
				
		//Instantiate a new controller to test the page
		Lead testLead = new Lead();
		ApexPages.StandardController std = new ApexPages.StandardController(testLead);
		WebToLeadWithAttachment ctl = new WebToLeadWithAttachment(std);
		ctl.webtolead();
	}
}