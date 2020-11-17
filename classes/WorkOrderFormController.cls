public class WorkOrderFormController {
    
    // Methods to create a Work Order Form pdf from a Service Visit record and send it as an email attachment.
    
    ApexPages.StandardController stdController;
    public String email_subject { get; set; }
    public String email_body { get; set; }
    public SV__c serviceVisit { get; set; }
    public Account svAccount { get; set; }
    public Contact svContact { get; set; }
    public Case svCase { get; set; }
    public AcctSeed__Project__c svProject {get; set;}
    public Boolean showPreview { get; set; }
    public Boolean noEmailRecipients { get; set; }
    public List<SelectOption> allUsers { get; set; }
    public String userEmailAddresses {get; set;}
    public String contactEmailAddresses {get; set;}
    List<User> userList = new List<User>();
    Map<Id, User> userMap = new Map<Id, User>();
    List<Attachment> attList = new List<Attachment>();
    String[] selectedToUsers = new String[]{};
    List<Id> attSelected;
    Boolean workorderTest = false;
    
    private final SV__c sVisit;

    // Create a constructor that populates the Service Visit, Account, Contact, Case, and Attachments
    public WorkOrderFormController(ApexPages.StandardController stdController) {
        this.sVisit = (SV__c)stdController.getRecord(); 
        
        showPreview = false;
        noEmailRecipients = false;
        serviceVisit = new SV__c();
        serviceVisit = [select Id, Name, CreatedBy.Email, Account__c, Visit_Date__c, Notes__c, Case__c, Contacts__c, 
                Work_Order_Date_Sent__c, Work_Order_Sent_To__c, attachmentIdSelected__c, userIdEmailSelected__c, 
                otherEmailSelected__c, PO__c, Private_Notes__c, Project__c 
                from SV__c where Id =: this.sVisit.Id];

        serviceVisit.Contacts__c = null;
        userEmailAddresses = serviceVisit.CreatedBy.Email;
        contactEmailAddresses = null;
        svAccount = new Account();
        List<Contact> conList = new List<Contact>();
        svCase = new Case();
        svContact = new Contact();
        if (serviceVisit.Account__c != null) {
            svAccount = [select Id, Name, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode 
                        from Account where Id =: serviceVisit.Account__c];
            conList = [select Id, Name, AccountId, Contact_Type__c, Phone, Email, MobilePhone 
                        from Contact where AccountId =: serviceVisit.Account__c];
            for (Contact c :conList) {
                if (c.Contact_Type__c != null && c.Contact_Type__c.contains('Service Contact')) {
                    svContact = c;
                }
            }
        }
        
        if (serviceVisit.Case__c != null) {
            svCase = [select Id, CaseNumber, Subject from Case where Id =: serviceVisit.Case__c];
        }
        
        svProject = new AcctSeed__Project__c();
        if (serviceVisit.Project__c != null) {
            svProject = [select Id, Name, Site_Address__c, Site_City__c, Site_State__c, Site_Zip__c 
                    from AcctSeed__Project__c where Id = :serviceVisit.Project__c];
        }
        
        email_subject = 'Borrego Solar Systems Case #: ' + svCase.CaseNumber + ' ' + svCase.Subject;
        email_body = 'Work order for Service Visit #: ' + serviceVisit.Name + ' at Account: ' + svAccount.Name + 
                ' along with other relevant documents (if any) are attached.' +
                '\n\nRegards,\nBorrego Solar Systems, Inc.\n';

        // Build the list of Users that can be selected as email recipients
        allUsers = new List<SelectOption>();
        userList = [select Id, Name, Email from User where isActive=true and UserType='Standard' order by name]; 
        for (User u : userList) {
            allUsers.add(new SelectOption(u.Id, u.Name));
            userMap.put(u.Id, u);
        }
        
        // Get the list of available Attachments that can be selected to be included
        attList = [select Id, Name, Description from Attachment where ParentId = :serviceVisit.Id and IsPrivate = false order by Name asc];
    }
    
    // Set the list of users and other email addresses already selected if there are any.  This would happen 
    // if the user has already selected email addresses and then previewed the work order PDF and then 
    // returned to the email selection page.  Do the same thing for selected Attachments.
    public void initEmailAddresses() {

        contactEmailAddresses = serviceVisit.otherEmailSelected__c;
        if (serviceVisit.userIdEmailSelected__c != null) {
            String userIds = serviceVisit.userIdEmailSelected__c;
            List<String> uIds = new List<String>();
            while(userIds != null && userIds.length() > 0) {
                if (userIds.contains(';')) {
                    uIds.add(userIds.substringBefore(';'));
                    userIds = userIds.removeStart(userIds.substringBefore(';') + ';');
                } else {
                    uIds.add(userIds);
                    userIds = userIds.removeStart(userIds);
                }
            }
            setselectedToUsers(uIds);
            for (String s : uIds) {
                if (userMap.containsKey(s)) {
                    userEmailAddresses += ';' + userMap.get(s).Email;
                }
            }
        }
        
        // Initialize the list of Attachments selected so far
        attSelected = new List<Id>();
        if (serviceVisit.attachmentIdSelected__c != null) {
            String attIds = serviceVisit.attachmentIdSelected__c;
            while(attIds != null && attIds.length() > 0) {
                if (attIds.contains(';')) {
                    attSelected.add(attIds.substringBefore(';'));
                    attIds = attIds.removeStart(attIds.substringBefore(';') + ';');
                } else {
                    attSelected.add(attIds);
                    attIds = attIds.removeStart(attIds);
                }
            }
        }
        
        serviceVisit.userIdEmailSelected__c = null;
        serviceVisit.otherEmailSelected__c = null;
        serviceVisit.attachmentIdSelected__c = null;
        update serviceVisit;
    }
    
    // Selected Users for Email "To"
    public String[] getselectedToUsers() {
        return selectedToUsers;
    }
            
    public void setselectedToUsers(String[] users) {
        selectedToUsers = users;
    }
    
    public List<String> getemailTo() {
        List<String> toList = new List<String>();
        Contact toContact = new Contact();
        
        noEmailRecipients = false;
        //userEmailAddresses = null;
        userEmailAddresses = serviceVisit.CreatedBy.Email;  // Always include createdby email address of Service Visit record
        serviceVisit.userIdEmailSelected__c = '';
        for (Integer i=0; i<selectedToUsers.size(); i++) {
            if (i+1 == selectedToUsers.size()) {
                serviceVisit.userIdEmailSelected__c += selectedToUsers[i];
            } else {
                serviceVisit.userIdEmailSelected__c += selectedToUsers[i] + ';';
            }
            toList.add(userMap.get(selectedToUsers[i]).Email);
            if (userEmailAddresses == null) {
                userEmailAddresses = userMap.get(selectedToUsers[i]).Email;
            } else {
                userEmailAddresses += ';' + userMap.get(selectedToUsers[i]).Email;
            }
        }
        
        if (serviceVisit.Contacts__c != null) {
            toContact = [select Id, Name, Email from Contact where Id =: serviceVisit.Contacts__c];
            toList.add(toContact.Email);
            if (contactEmailAddresses == null || contactEmailAddresses == '') {
                contactEmailAddresses = toContact.Email;
            } else {
                contactEmailAddresses += ';' + toContact.Email;
            }
            serviceVisit.Contacts__c = null;
        }
        
        return toList;
    }
    
    public PageReference selectEmailRecipients() {
        List<String> toList = new List<String>();
        
        toList = getemailTo();
        return null;
    }
    
    // Reformat the selected Construction Requisition (Sales Order Line) and return it
    public String getsolString () {
        String sol = '';
        AcctSeedERP__Sales_Order_Line__c conreq = new AcctSeedERP__Sales_Order_Line__c();
        if (serviceVisit.PO__c != null) {
            conreq = [select Id, Name from AcctSeedERP__Sales_Order_Line__c where Id =: serviceVisit.PO__c];
            sol = 'SOL' + conreq.Name.removeStart('SalesOrderLine-0000');
        }
        return sol;
    }
    
    public workOrderWrapper getWorkOrderInfo() {
        workOrderWrapper woWrapper = new workOrderWrapper(serviceVisit, svAccount, svContact, svCase, svProject);
        return woWrapper;
    }
    
    public class workOrderWrapper {
        public SV__c woSV {get; set;}
        public String woSVNotes {get; set;}
        public Account woAcc {get; set;}
        public Contact woCon {get; set;}
        public Case woCase {get; set;}
        public AcctSeed__Project__c woProj {get; set;}
        public workOrderWrapper(SV__c sv, Account acc, Contact cn, Case cs, AcctSeed__Project__c pr) {
            woSV = sv;
            woAcc = acc;
            woCon = cn;
            woCase = cs;
            woProj = pr;
            woSVNotes = Utilities.limitWordLength(sv.Notes__c, 50);
        }
    }
    
    // Preview the work order pdf
    public PageReference previewWorkOrder() {
        showPreview = true;
        serviceVisit.otherEmailSelected__c = contactEmailAddresses;
        update serviceVisit;  // save information so that it will reappear upon return from preview
        return null;
    }
    
    // Get the list of available attachments to choose from
    List<attSelectWrapper> availableAtt = new List<attSelectWrapper>();
    List<attSelectWrapper> selectedAtt = new List<attSelectWrapper>();
    
    public List<attSelectWrapper> getAttachments() {
        
        // If the list of attachments to choose from is empty, create it
        if (availableAtt.isEmpty()) {
            for (Attachment a :attList) {
                availableAtt.add(new attSelectWrapper(a));
            }
            
            // Initialize with current selections
            for (attSelectWrapper attSW :availableAtt) {
                for (Id attId :attSelected) {
                    if (attSW.att.Id == attId) {
                        attSW.selected = true;
                    }
                }
            }
            PageReference pr = getSelected();
        }
        return availableAtt;
    }
    
    // Record current user selection of attachments
    public PageReference getSelected () {
        
        serviceVisit.attachmentIdSelected__c = '';
        selectedAtt.clear();
        for (attSelectWrapper attsw :availableAtt) {
            if (attsw.selected) {
                selectedAtt.add(attsw);
            }
        }
        for (Integer i=0; i<selectedAtt.size(); i++) {
            if (i+1 == selectedAtt.size()) {
                serviceVisit.attachmentIdSelected__c += selectedAtt[i].att.Id;
            } else {
                serviceVisit.attachmentIdSelected__c += selectedAtt[i].att.Id + ';';
            }
        }
        return null;
    }
/*    
    // Return list of attachment selected so far - used on the page for debug purposes
    public List<attSelectWrapper> getselectedATTWs() {
        if (selectedAtt.isEmpty()) {
            return null;
        } else {
            return selectedAtt;
        }
    }
*/    
    // Send the Work Order From PDF as an attachment to an email.
    public PageReference sendWorkOrder() {
        PageReference returnPage;
        List<String> toAddresses = new List<String>();
        List<Id> attIds = new List<Id>();
        List<Attachment> attToInclude = new List<Attachment>();
        
        // First save the selected Construction Requisition
        update serviceVisit;
        
        // Create the list of email recipients
        serviceVisit.Work_Order_Sent_To__c = '';
        if (userEmailAddresses != null && userEmailAddresses != '') {
            toAddresses.addAll(userEmailAddresses.split(';', 0));
            serviceVisit.Work_Order_Sent_To__c += userEmailAddresses;
        }
        if (contactEmailAddresses != null && contactEmailAddresses != '') {
            toAddresses.addAll(contactEmailAddresses.split(';', 0));
            serviceVisit.Work_Order_Sent_To__c += '; ' + contactEmailAddresses;
        }
        
        // Can only send email if we have some email recipients
        if (!toAddresses.isEmpty()) {
        
            // Define the email
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 

            // Reference the attachment page and pass in the Service Visit record Id
            if (!workorderTest) {
                PageReference pdf =  Page.WorkOrderFormPDF;
                pdf.getParameters().put('id', (String)serviceVisit.Id); 
                pdf.setRedirect(true);
            
                // Take the PDF content
                Blob b = pdf.getContent();
                
                // Create the Work Order Form email attachment
                Messaging.EmailFileAttachment[] efaList = new Messaging.EmailFileAttachment[selectedAtt.size()+1];
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName('WorkOrderForm.pdf');
                efa.setBody(b);
                efaList[0] = efa;
                
                // Include the user selected attachments if any
                if (!selectedAtt.isEmpty()) {
                    for (attSelectWrapper attSW :selectedAtt) {
                        attIds.add(attSW.att.Id);
                    }
                    attToInclude = [select Id, Name, Body, Description from Attachment where Id in :attIds];
                
                    for (Integer i=0; i<attToInclude.size(); i++) {
                        efa = new Messaging.EmailFileAttachment();
                        efa.setFileName(attToInclude[i].Name);
                        efa.setBody(attToInclude[i].Body);
                        efaList[i+1] = efa;
                    }
                }
                email.setFileAttachments(efaList);
            }
            
            // Sets the paramaters of the email
            email.setSubject(email_subject);
            email.setToAddresses(toAddresses);
            email.setPlainTextBody(email_body);
            
            // Sends the email
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            
            // Record the date the email was sent and email addresses it was sent to (set above)
            serviceVisit.Work_Order_Date_Sent__c = system.now();
            serviceVisit.otherEmailSelected__c = null;
            serviceVisit.userIdEmailSelected__c = null;
            serviceVisit.attachmentIdSelected__c = null;
            serviceVisit.PO__c = null;
            update serviceVisit;
            
            returnPage = new PageReference('/' + serviceVisit.Id);
        } else {
            noEmailRecipients = true;
            returnPage = null;
        }
        return returnPage;
    }
    
    // Cancel the work order
    public PageReference cancelWorkOrder() {
        if (serviceVisit.otherEmailSelected__c != null || serviceVisit.userIdEmailSelected__c != null || 
                    serviceVisit.attachmentIdSelected__c != null || serviceVisit.PO__c != null) {
            serviceVisit.otherEmailSelected__c = null;
            serviceVisit.userIdEmailSelected__c = null;
            serviceVisit.attachmentIdSelected__c = null;
            serviceVisit.PO__c = null;
            update serviceVisit;
        }
        PageReference returnPage = new PageReference('/' + serviceVisit.Id);
        return returnPage;
    }
    
    public static testMethod void testWorkOrderForm() {
    
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    

        PageReference pr;
        
        // Create all the test data
        Account testAccount = new Account(
            Name = 'Test test',
            Branch__c = 'San Diego',
            ShippingStreet = '123 Main Street',
            ShippingCity = 'San Francisco',
            ShippingState = 'California',
            ShippingPostalCode = '94107');
        insert testAccount;
        Contact testContact = new Contact(
            LastName = 'testContact',
            Title = 'CEO',
            AccountId = testAccount.Id,
            Phone = '123-456-7890',
            Email = 'testContact@test.com.training',
            //Service_Contact__c = true,
            Contact_Type__c = 'Service Contact',
            MobilePhone = '456-789-0123');
        insert testContact;
        Case testCase = new Case(
            Subject = 'This is a test case for testing a work order form',
            Description = 'This is the description field',
            AccountId = testAccount.Id,
            ContactId = testContact.Id,
            Branch__c = 'San Diego',
            Origin = 'Web',
            Component__c = 'Inverter',
            Reason = 'System Down',
            Production_Effected__c = 'Yes',
            Days_Inverter_Down__c = 1,
            O_M_Issue_Tracking__c = 'Reactive');
        insert testCase;
        Opportunity testOpportunity = new Opportunity(
            Name = 'testOpportunity',
            AccountId = testAccount.Id,
            Description = 'This is the project description field',
            StageName = 'Prospecting',
            Financing__c = 'Cash',
            Project_Likelihood__c = '50%',
            CloseDate = system.today(),
            Service_Contract_Included__c = 'Yes');
        insert testOpportunity;
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(
            Name = 'testProject',
            AcctSeed__Opportunity__c = testOpportunity.Id,
            Branch__c = 'San Diego',
            Site_Address__c = '123 Main Street',
            Site_City__c = 'San Francisco',
            Site_State__c = 'California',
            Site_Zip__c = '94107');
        insert testProject;
        Contract testContract = new Contract(
            AccountId = testAccount.Id,
            Contract_Amount__c = 10000,
            ContractTerm = 12,
            Service_Contract_Start_Date__c = system.today(),
            EndDate = system.today(),
            Description = 'This is the description field',
            ASProject__c = testProject.Id);
        insert testContract;
        SV__c testServiceVisit = new SV__c(
            Account__c = testAccount.Id,
            Visit_Date__c = system.today(),
            Notes__c = 'This is the notes field',
            Case__c = testCase.Id,
            Visit_Reason__c = 'Scheduled Site Inspection',
            Performed_By__c = 'Borrego',
            userIdEmailSelected__c = system.UserInfo.getUserId(),
            otherEmailSelected__c = 'testtest@test.com.training',
            Contract__c = testContract.Id);
        insert testServiceVisit;
        
        //Instantiate a new controller
        ApexPages.StandardController std = new ApexPages.StandardController(testServiceVisit);
        WorkOrderFormController ctl = new WorkOrderFormController(std);
        
        // Run the tests
        ctl.initEmailAddresses();
        ctl.workorderTest = true;
        ctl.serviceVisit.Contacts__c = testContact.Id;
        List<String> userEmail = new List<String>();
        userEmail.add(system.UserInfo.getUserId());
        ctl.setselectedToUsers(userEmail);
        List<String> selectedUsers = new List<String>();
        selectedUsers = ctl.getselectedToUsers();
        system.assertEquals(selectedUsers, userEmail);
        pr = ctl.selectEmailRecipients();
        SV__c sv = [select Id, Name, CreatedBy.Email from SV__c where Id =: testServiceVisit.Id];
        system.assertEquals(ctl.userEmailAddresses, sv.CreatedBy.Email + ';' + system.UserInfo.getUserEmail());
        system.assertEquals(ctl.contactEmailAddresses, 'testtest@test.com.training;testcontact@test.com.training');
        workOrderWrapper wow = ctl.getWorkOrderInfo();
        system.assertEquals(wow.woSV.Id, testServiceVisit.Id);
        pr = ctl.previewWorkOrder();
        system.assertEquals(pr, null);
        pr = ctl.cancelWorkOrder();
        system.assertNotEquals(pr, null);
        pr = ctl.sendWorkOrder();
        system.assertNotEquals(pr, null);
        ctl.getsolString();
        ctl.getSelected();
        ctl.getAttachments();
    }
}