public class sendCustomerSatisfactionEmail {
    
    ApexPages.StandardController stdController;
    private final Customer_Satisfaction__c customer_satisfaction;  
    
    public sendCustomerSatisfactionEmail(ApexPages.StandardController stdController) {
        this.customer_satisfaction = (Customer_Satisfaction__c)stdController.getRecord(); 
        this.stdController = stdController;
    }
    
	public String subject { get; set; }
	public String body { get; set; }
	public String htmlbody { get; set; }
	public String to;
	public Boolean optout;
	public String emailtype = '';
	public Customer_Satisfaction__c custsat;	
	public Contact contact;
	
	public void setCustSat() {
		custsat = [select Id, Contact__c, Status__c, ASProject__c from Customer_Satisfaction__c where Id =:customer_satisfaction.Id];
	}
	
	public void setContact() {
		contact = [select Id, Email, FirstName, HasOptedOutOfEmail from Contact where Id =:customer_satisfaction.Contact__c];
	}
	public void setSubjectBody() {
		EmailTemplate[] etemp;
		if (emailtype == 'Thank You') {
			etemp = [select Id, Name, Subject, Body, HtmlValue from EmailTemplate where Name =:emailtype];
			subject = etemp[0].Subject;
			body = contact.FirstName + etemp[0].Body;
			htmlbody = '<span style="font-family: Calibri, Verdana, Arial, Helvetica, sans-serif; font-size: 11pt;">';
			htmlbody += contact.FirstName + etemp[0].HtmlValue + '</span>';
		} else {
			AcctSeed__Project__c pro = [select Id, Name from AcctSeed__Project__c where Id =:custsat.ASProject__c];
			etemp = [select Id, Name, Subject, Body, HtmlValue from EmailTemplate where Name like 'Follow Up%'];
			subject = pro.Name + ' ' + etemp[0].Subject;
			
			Map<String, EmailTemplate> etMap = new Map<String, EmailTemplate>();
			for (Integer i=0; i<etemp.size(); i++) {
				etMap.put(etemp[i].Name, etemp[i]);
			}
			body = 'Dear ' + contact.FirstName + etMap.get('Follow Up 1').Body;
			body += ' ' + pro.Name + ' ' + etMap.get('Follow Up 2').Body;
			body += ' ' + pro.Name + ' ' + etMap.get('Follow Up 3').Body;
			htmlbody = '<span style="font-family: Calibri, Verdana, Arial, Helvetica, sans-serif; font-size: 11pt;">';
			htmlbody += 'Dear ' + contact.FirstName + etMap.get('Follow Up 1').HtmlValue;
			htmlbody += ' ' + pro.Name + ' ' + etMap.get('Follow Up 2').HtmlValue;
			htmlbody += ' ' + pro.Name + ' ' + etMap.get('Follow Up 3').HtmlValue + '</span>';
		}
		//System.debug(Logginglevel.ERROR, 'Name= ' + etemp[0].Name  );
		//System.debug(Logginglevel.ERROR, 'Subject= ' + etemp[0].Subject  );
		//System.debug(Logginglevel.ERROR, 'Body= ' + etemp[0].Body  );
		//System.debug(Logginglevel.ERROR, 'HtmlBody= ' + etemp[0].HtmlValue  );
	}	
	public void thankYou() {
		emailtype = 'Thank You';
		setCustSat();
		setContact();
		setSubjectBody();
	}
	public void followUp() {
		emailtype = 'Follow Up';
		setCustSat();
		setContact();
		setSubjectBody();
	}
	
	public String getTo() {
		to = contact.Email;
		return(to);
	}
	
	public Boolean getOptout() {
		optout = contact.HasOptedOutOfEmail;
		return(optout);
	}
	
	public PageReference send() {
		// Define the email
		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 

		//System.debug(Logginglevel.ERROR, 'HtmlBody= ' + htmlbody  );
		// Sets the paramaters of the email
		email.setSubject( subject );
		email.setTargetObjectId(customer_satisfaction.Contact__c);
		email.setPlainTextBody( body );
		email.setHtmlBody( htmlbody );
    
		// Sends the email
		Messaging.SendEmailResult [] r = 
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
		
		if (emailtype == 'Follow Up') {
			customer_satisfaction.Status__c = 'Follow Up Sent';
		} else {
			customer_satisfaction.Status__c = 'Completed';
		}
		update(customer_satisfaction);
		
		PageReference newcontact = new PageReference('/' + customer_satisfaction.Id);
		newcontact.setRedirect(true);
		return newcontact;
	}
	
	static testMethod void testCustSatEmail() {
		
		//Create all the objects we need
    	Account AccMake = new Account(Name = 'Knight - 2456', Type = 'Customers', Job_Type__c = 'Commercial',
    				Branch__c = 'Berkeley', ShippingCity = 'San Francisco');
    	insert AccMake;
    	Contact ConMake = new Contact(Email='bob@emailtest.com', FirstName='Bob', LastName='Jones', HasOptedOutOfEmail=false, AccountId=AccMake.Id);
    	insert ConMake;   
    	Opportunity OppMake = new Opportunity(Name = 'Knight - 2456', AccountId = AccMake.Id,
    				Type = 'Turnkey System', CloseDate = System.today(), StageName = 'Contract Signed',
    				ForeCastCategoryName = 'Pipeline',
    				Last_Date_Called__c = System.today(),
    				Rating__c = 'Hot',
    				Financing__c = 'Cash',
    				Approximate_Install_Date__c = System.today(),
    				Job_Type__c = 'Commercial',
    				Service_Contract_Included__c = 'Yes',
    				Amount = 10000000,
    				Installation_Obstacles__c = 'Customer_Schedule',
    				Additional_Charges__c = 'Permit',
    				Utility_Company__c = 'SCE',
    				Expected_Rebate__c = 5000,
    				Project_Cost__c = 5000000,
    				Prevailing_Wage__c = 'Yes',
    				Tax_Exemption__c = 'Exempt',
    				Inverter_Delivery_Date__c = System.today(),
    				Module_Delivery_Date__c = System.today(),
    				RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId(),
    				Racking_Delivery_Date__c = System.today());
		insert OppMake;
		AcctSeed__Project__c project = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = OppMake.Id, AcctSeed__Account__c = AccMake.Id, SFDC_Project_Stage__c = 'Sales', 
                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                    Job_Number__c = '000-000'); 
		insert project;
		Customer_Satisfaction__c customer_satisfaction = new Customer_Satisfaction__c(Contact__c=ConMake.Id, ASProject__c=project.Id);
		insert customer_satisfaction;
		//Test New Page
        PageReference pageRef = Page.CustFollowUp;
        Test.setCurrentPage(pageRef);
               
        //Set Page Parameters
        ApexPages.StandardController con = new ApexPages.StandardController(customer_satisfaction);

        ApexPages.currentPage().getParameters().put('id', customer_satisfaction.Id); 
        sendCustomerSatisfactionEmail ext = new sendCustomerSatisfactionEmail(con);
        
        //Call all methods on New page
        ext.thankYou();
		ext.followUp();
		String to = ext.getTo();
		Boolean optout = ext.getOptOut();
          
		PageReference result = ext.send();
	}
}