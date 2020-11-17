public with sharing class CaseClosureFormController {
    
    // Methods to create a Case Closure Form pdf from a Case record and send it as an email attachment.
    
    public class SVWrapperClass {
        public SV__c serviceVisit {get; set;}
        public String visitComments {get; set;}
       
        
        public SVWrapperClass(SV__c sv, String vc) {
            this.serviceVisit = sv;
            this.visitComments = vc;
        }
    }
    
    ApexPages.StandardController stdController;
    public String email_subject { get; set; }
    public String email_body { get; set; }
    public List<SVWrapperClass> svWrapper {get; set;}
    //public List<SV__c> ccfServiceVisits { get; set; }
    public Case ccfCase { get; set; }
    public List<CaseComment> ccfCaseComments { get; set; }
    public Solution ccfSolution { get; set; }
    public String caseSubject {get; set;}
    public String caseManagerComments {get; set;}
    public Boolean showPreview { get; set; }
    public Boolean noEmailRecipients { get; set; }
    public List<SelectOption> allUsers { get; set; }
    public String userEmailAddresses {get; set;}
    public String contactEmailAddresses {get; set;}
    List<User> userList = new List<User>();
    Map<Id, User> userMap = new Map<Id, User>();
    List<Attachment> attList = new List<Attachment>();
    List<ContentDocumentLink> contentList = new list<ContentDocumentLink>();
    String[] selectedToUsers = new String[]{};
    List<Id> attSelected;
    // Map<ID, ContentDocumentLink> contentselected;
    List<Id> contentselected;
    Boolean ccfTest = false;
    
    public final Case ccf; //private

    // Constructor - populates the Case, Solution, Case Comments and Service Visits
    public CaseClosureFormController(ApexPages.StandardController stdController) {
        
        List<CaseSolution> ccfCaseSolutions;
        this.ccf = (Case)stdController.getRecord(); 
        
        showPreview = false;
        noEmailRecipients = false;
        
        // Get the Case, Solution, Case Comments and Service Visit records - data will be used to create the case closure form pdf
        ccfCase = new Case();
        
        /*
        ccfCase = [select Id, CaseNumber, OwnerId, Owner.Name, Owner.Email, Account.Name, Account.Logo_Document_Name__c, Branch__c, Status, Priority, Component__c, Reason, Production_Effected__c, 
                    Case_Start_Date__c, Case_End_Date__c, Turn_Around_Time__c, Days_Inverter_Down__c, Days_Tracker_Down__c, Supplier_Manufacturer_Service_Required__c,
                    //Supplier_Manufacturer_Parts_Required__c, Manufacturer_Ticket__c, Photo_1__c, Photo_2__c, Photo_3__c, Photo_4__c, Photo_5__c,
                    //Subject, Description, Case_Closure_Date_Sent__c, Case_Closure_Sent_To__c, Contacts__c, userIdEmailSelected__c, otherEmailSelected__c 
                    Supplier_Manufacturer_Parts_Required__c, Manufacturer_Ticket__c, Subject, Description, Case_Closure_Date_Sent__c, 
                    Case_Closure_Sent_To__c, Contacts__c, userIdEmailSelected__c, otherEmailSelected__c, attachmentIdSelected__c, 
                    Site__c, Site__r.Name, Project__c, Project__r.Name 
                    from Case where Id =: this.ccf.Id];
        */
                    
        ccfCase = [select Id, CaseNumber, AccountId, Account.Name, Account.Logo_Document_Name__c, 
                OwnerId, Owner.Name, Owner.Email, ServiceContract_Case__c, ServiceContract_Case__r.Branch__c, 
                Status, Priority, Case_Start_Date__c, Case_End_Date__c, Project__c, Project__r.Name, 
                CreatedById, CreatedBy.Name, Subject, Manager_Comments__c, 
                Case_Closure_Date_Sent__c, Case_Closure_Sent_To__c, 
                Contacts__c, userIdEmailSelected__c, otherEmailSelected__c, attachmentIdSelected__c 
                from Case where Id =: this.ccf.Id];
        
        caseSubject = Utilities.limitWordLength(ccfCase.Subject, 50);
        caseManagerComments = Utilities.limitWordLength(ccfCase.Manager_Comments__c, 50);
        
        Map<Id, SV__c> svMap = new Map<Id, SV__c>([select Id, Name, Case__c, Asset__c, Asset__r.Name, Visit_Date__c, Notes__c, 
                Technician__c, Technician__r.Name, Total_Work_Hours__c, Total_Travel_Time__c, Asset_Offline__c, Asset_Online__c, Private_Notes__c 
                from SV__c where Case__c =: ccfCase.Id]);
        
        List<Visit_Comments__c> vcList = new List<Visit_Comments__c>();
        vcList = [select Id, Name, Case__c, Service_Visit__c, Comment__c from Visit_Comments__c where Service_Visit__c in :svMap.keySet()];
        
        // Combine the visit comments for a single service visit and build the service visit wrapper list
        svWrapper = new List<SVWrapperClass>();
        String visitComments;
        String oneVisitComment;
        for (SV__c sv :svMap.values()) {
            
            visitComments = '';
            for (Visit_Comments__c vc :vcList) {
                oneVisitComment = '';
                if (vc.Service_Visit__c == sv.Id) {
                    if (String.isNotBlank(vc.Comment__c)) {
                        oneVisitComment = Utilities.limitWordLength(vc.Comment__c, 30);
                    }
                }
                
                if (String.isNotBlank(visitComments)) {
                    visitComments += ' ';
                }
                
                visitComments += oneVisitComment;
            }
            
            if (sv.Private_Notes__c) {
                sv.Notes__c = ' ';
            } else {
                sv.Notes__c = Utilities.limitWordLength(sv.Notes__c, 30);
            }
            
            svWrapper.add(new SVWrapperClass(sv, visitComments));
        }
        
        /*
        ccfCaseComments = new List<CaseComment>();
        ccfCaseComments = [select Id, IsPublished, ParentId, CommentBody, CreatedBy.Name, CreatedDate 
                    from CaseComment where IsPublished =: true and ParentId =: ccfCase.Id order by CreatedDate desc];
        for (CaseComment cc :ccfCaseComments) {
            cc.CommentBody = Utilities.limitWordLength(cc.CommentBody, 50);
        }
        ccfCaseSolutions = new List<CaseSolution>();
        ccfCaseSolutions = [select Id, CaseId, SolutionId from CaseSolution where CaseId =: ccfCase.Id];
        ccfSolution = new Solution();
        if (!ccfCaseSolutions.isEmpty()) {
            ccfSolution = [select Id, SolutionNote from Solution where Id =: ccfCaseSolutions[0].SolutionId];
            ccfSolution.SolutionNote = Utilities.limitWordLength(ccfSolution.SolutionNote, 50);
        }
        ccfServiceVisits = new List<SV__c>();
        ccfServiceVisits = [select Id, Name, Case__c, Visit_Reason__c, Visit_Date__c, Notes__c, Private_Notes__c, Performed_By__c from SV__c where Case__c =: ccfCase.Id];
        for (SV__c sv :ccfServiceVisits) {
            if (sv.Private_Notes__c) {
                sv.Notes__c = ' ';
            } else {
                sv.Notes__c = Utilities.limitWordLength(sv.Notes__c, 30);
            }
        }
        */
        
        contactEmailAddresses = null;
        userEmailAddresses = ccfCase.Owner.Email;
        
        String projectName = (ccfCase.Project__c == null) ? ' ' : ccfCase.Project__r.Name;
        email_subject = 'Borrego Solar Systems Project: ' + projectName + ', Case #: ' + ccfCase.CaseNumber + ', ' + ccfCase.Subject;
        if (email_subject.length() > 100) {
            email_subject = email_subject.substring(0, 100);
        }
        email_body = 'Service Report for Case #: ' + ccfCase.CaseNumber + 
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
        attList = [select Id, Name, Description from Attachment 
            where  IsPrivate = false and (ParentId = :ccfCase.Id or ParentId in :svMap.keySet()) order by Name asc]; //
        
        // Get the list of available files that can be selected to be included    
        contentList = [select ContentDocumentID, LinkedEntityId,ContentDocument.title from ContentDocumentLink where ShareType ='V' and (LinkedEntityId =:ccfCase.Id  or LinkedEntityId =:svMap.keySet()) order by ContentDocument.title asc];  
        system.debug('look here for Files' +contentList );
    }
    
    // Set the list of users and other email addresses already selected if there are any.  This would happen 
    // if the user has already selected email addresses and then previewed the case closure PDF and then 
    // returned to the email selection page.  Do the same thing for selected Attachments.
    public void initEmailAddresses() {

        contactEmailAddresses = ccfCase.otherEmailSelected__c;
        if (ccfCase.userIdEmailSelected__c != null) {
            String userIds = ccfCase.userIdEmailSelected__c;
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
        
        if (ccfCase.attachmentIdSelected__c != null) {
        system.debug('ATTACHMENT FIELD'  +ccfCase.attachmentIdSelected__c); 
            String attIds = ccfCase.attachmentIdSelected__c;
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
        
        system.debug('the first ids' +attSelected);
        contentselected = new List<Id>();
        if (ccfCase.attachmentIdSelected__c != null) {
        system.debug('files FIELD'  +ccfCase.attachmentIdSelected__c); 
            String filesIds = ccfCase.attachmentIdSelected__c;
            while(filesIds!= null && filesIds.length() > 0) {
                if (filesIds.contains(';')) {
                    contentselected.add(filesIds.substringBefore(';'));
                    filesIds= filesIds.removeStart(filesIds.substringBefore(';') + ';');
                } else {
                    contentselected.add(filesIds);
                    filesIds = filesIds.removeStart(filesIds);
                }
            }
        }
        
        
        ccfCase.userIdEmailSelected__c = null;
        ccfCase.otherEmailSelected__c = null;
        ccfCase.attachmentIdSelected__c = null;
        update ccfCase;
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
        userEmailAddresses = ccfCase.Owner.Email;   // Always include owner of case record
        ccfCase.userIdEmailSelected__c = '';
        for (Integer i=0; i<selectedToUsers.size(); i++) {
            if (i+1 == selectedToUsers.size()) {
                ccfCase.userIdEmailSelected__c += selectedToUsers[i];
            } else {
                ccfCase.userIdEmailSelected__c += selectedToUsers[i] + ';';
            }
            toList.add(userMap.get(selectedToUsers[i]).Email);
            if (userEmailAddresses == null) {
                userEmailAddresses = userMap.get(selectedToUsers[i]).Email;
            } else {
                userEmailAddresses += ';' + userMap.get(selectedToUsers[i]).Email;
            }
        }
    
        if (ccfCase.Contacts__c != null) {
            toContact = [select Id, Name, Email from Contact where Id =: ccfCase.Contacts__c];
            toList.add(toContact.Email);
            if (contactEmailAddresses == null || contactEmailAddresses == '') {
                contactEmailAddresses = toContact.Email;
            } else {
                contactEmailAddresses += ';' + toContact.Email;
            }
            ccfCase.Contacts__c = null;
        }
            
        return toList;
    }
    
    public PageReference selectEmailRecipients() {
        List<String> toList = new List<String>();
        
        toList = getemailTo();
        return null;
    }
    
    // Preview the case closure pdf
    public PageReference previewCaseClosure() {
        showPreview = true;
        ccfCase.otherEmailSelected__c = contactEmailAddresses;
        update ccfCase;  // save information so that it will reappear upon return from preview
        return null;
    }
    
    // Get the URL of the document logo to include in the case closure pdf
    public string getDocumentLogoUrl() {
        String instance;
        String strDocURL;
        String documentName = 'SF Logo';   //'Borrego Logo - Transparent';
        
        if (String.isNotBlank(ccfCase.Account.Logo_Document_Name__c)) {
            documentName = ccfCase.Account.Logo_Document_Name__c;
        }
        
        List<Document> lstDocument = [select Id, Name from Document where Name = :documentName limit 1];
        
        instance = URL.getSalesforceBaseUrl().getHost().substringBefore('.');
        system.debug('The URL instance' +instance );
        
      //  strDocURL = 'https://c.' + instance + '.content.force.com/servlet/servlet.FileDownload?file=';
      
      strDocURL = 'https://' + instance + '.content.force.com/servlet/servlet.FileDownload?file=';
        
        if (!Test.isRunningTest()) {
            strDocURL += lstDocument[0].Id;
        }
        system.debug('The Url' +strDocURL );
        return strDocUrl;
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
            system.debug('the available attachment' +availableAtt);
            for (attSelectWrapper attSW :availableAtt) {
            system.debug('the ATTSELECTED'  +attSelected);
                for (Id attId :attSelected) {
                        system.debug('this is the id for Attachment' +attSelected);
                    if (attSW.att.Id == attId) {
                    system.debug('this is the condition check'  +attSW.att.Id);
                        attSW.selected = true;
                    }
                } 
            }
            PageReference pr = getSelected();
        }
        return availableAtt;
    }
    //adding code for getting the files MG 01/03/2019
    // Get the list of available files to choose from
     List<fileSelectWrapper> availableFiles = new List<fileSelectWrapper>();
     List<fileSelectWrapper> selectFiles = new List<fileSelectWrapper>();
    
    public List<fileSelectWrapper> getFiles() {
        
        // If the list of files to choose from is empty, create it
        if (availableFiles.isEmpty()) {
            for (ContentDocumentLink  c :contentList) {
                availableFiles.add(new fileSelectWrapper(c));
            }
            
            // Initialize with current selections
            system.debug('the available file' +availableFiles);
          for (fileSelectWrapper fileSW :availableFiles) {
          system.debug('the CONTENTSELECTED'  +contentselected);
                for (Id contentId :contentselected) {
                    if (fileSW.files.Id == contentId) {
                        fileSW.selectfile = true;
                    }
                } 
            } 
            PageReference pr = getSelectedfiles();
        }
        return availableFiles;
    } 
    
    // Record current user selection of attachments
    public PageReference getSelected () {
        
        ccfCase.attachmentIdSelected__c = '';
        selectedAtt.clear();
        for (attSelectWrapper attsw :availableAtt) {
            if (attsw.selected) {
                selectedAtt.add(attsw);
            }
        }
        for (Integer i=0; i<selectedAtt.size(); i++) {
            if (i+1 == selectedAtt.size()) {
                ccfCase.attachmentIdSelected__c += selectedAtt[i].att.Id;
            } else {
                ccfCase.attachmentIdSelected__c += selectedAtt[i].att.Id + ';';
            }
        }
        system.debug('Attachment field' +ccfCase.attachmentIdSelected__c);
        return null;
    }
    
    
      // Record current user selection of files
    public PageReference getSelectedfiles() {
        system.debug(' the code enters here to check the file id ');
        ccfCase.attachmentIdSelected__c = '';
        selectFiles.clear();
        for (fileSelectWrapper fsw :availablefiles) {
            if (fsw.selectfile) {
                selectFiles.add(fsw);
            }
        }
        for (Integer i=0; i<selectFiles.size(); i++) {
            if (i+1 == selectFiles.size()) {
                ccfCase.attachmentIdSelected__c += selectFiles[i].files.Id;
            } else {
                ccfCase.attachmentIdSelected__c += selectFiles[i].files.Id + ';';
            }
        }
         system.debug('files field' +ccfCase.attachmentIdSelected__c);
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
    
    // Send the Case Closure From PDF as an attachment to an email.
    public PageReference sendCaseClosure() {
        PageReference returnPage;
        List<String> toAddresses = new List<String>();
        List<Id> attIds = new List<Id>();
        List<Id> fileIds = new List<Id>();
        List<Attachment> attToInclude = new List<Attachment>();
        List<ContentVersion> filesToInclude = new List<ContentVersion>();
        String projectName;
        
        // Create the list of email recipients
        ccfCase.Case_Closure_Sent_To__c = '';
        if (userEmailAddresses != null && userEmailAddresses != '') {
            toAddresses.addAll(userEmailAddresses.split(';', 0));
            ccfCase.Case_Closure_Sent_To__c += userEmailAddresses;
        }
        if (contactEmailAddresses != null && contactEmailAddresses != '') {
            toAddresses.addAll(contactEmailAddresses.split(';', 0));
            ccfCase.Case_Closure_Sent_To__c += '; ' + contactEmailAddresses;
        }
        
        // Can only send email if we have some email recipients
        if (!toAddresses.isEmpty()) {
        
            // Define the email
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            Messaging.SingleEmailMessage email1 = new Messaging.SingleEmailMessage();
           
         //  Messaging.SingleEmailMessage[] email = new Messaging.SingleEmailMessage();
         //  Messaging.SingleEmailMessage[] email1 = new Messaging.SingleEmailMessage();

            // Reference the attachment page and pass in the Service Visit record Id
            if (!ccfTest) {
                PageReference pdf =  Page.CaseClosureFormPDF;
                pdf.getParameters().put('id', (String)ccfCase.Id); 
                pdf.setRedirect(true);
            
                // Take the PDF content
                Blob b;
                if (Test.IsRunningTest())
                       {
                     b=Blob.valueOf('UNIT.TEST');
                         }
                       else
                      {
                     b = pdf.getContent();
                                 }
            //    Blob b = pdf.getContent();
                
                // Create the Work Order Form email attachment
                projectName = (ccfCase.Project__c == null) ? ' ' : ccfCase.Project__r.Name;
               // Messaging.EmailFileAttachment[] efaList = new Messaging.EmailFileAttachment[selectedAtt.size()+1];
               // Messaging.EmailFileAttachment[] efaList1 = new Messaging.EmailFileAttachment[selectFiles.size()+1];
               
                List<Messaging.Emailfileattachment> efaList = new List<Messaging.Emailfileattachment>();
               // List<Messaging.Emailfileattachment> efaList1 = new List<Messaging.Emailfileattachment>();
               
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName('CaseClosureForm - Project: ' + projectName + '.pdf');
                efa.setBody(b);
                efalist.add(efa);
                //efaList[0] = efa;
               // efalist1[0] = efa;
                
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
                        //efaList[i+1] = efa;
                        efalist.add(efa);
                    }
                }
                
                
                //Include the user selected files if any
                if (!selectFiles.isEmpty()) {
                    for (fileSelectWrapper fileSW :selectfiles) {
                    string pId = string.valueOf(fileSW.files.ContentDocumentID ).substring(0,15);
                        fileIds.add(pId);
                        pId = '';
                    }
                    system.debug('The main file id' +fileIds);
                    
                    filesToInclude = [ SELECT Id, Title, FileType,PathOnClient, VersionData, isLatest, ContentDocumentId FROM ContentVersion  WHERE isLatest = true AND ContentDocumentId  =  :fileIds];
                    system.debug('The selected file ' +filesToInclude );
                    if (filestoinclude.size()>0) {
                    for (Integer i=0; i<filesToInclude .size(); i++) {
                        efa = new Messaging.EmailFileAttachment();
                        efa.setFileName(filesToInclude[i].PathOnClient );
                        efa.setBody(filesToInclude[i].VersionData);
                        efalist.add(efa);
                      //  efaList1[i] = efa;
                    }
                  }  
                } 
                
              
                 email.setFileAttachments(efaList);
                 // email1.setFileAttachments(efaList1);
              //  email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa,efaList,efaList1});
            }
            
            // Sets the paramaters of the email
            email.setSubject(email_subject);
            email.setToAddresses(toAddresses);
            email.setPlainTextBody(email_body);
            
                       
            //email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            
            // Sends the email
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
           // Messaging.SendEmailResult [] r1 = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email1});
           
            // Record the date the email was sent and email addresses it was sent to (set above)
            ccfCase.Case_Closure_Date_Sent__c = system.now();
            ccfCase.otherEmailSelected__c = null;
            ccfCase.userIdEmailSelected__c = null;
            ccfCase.attachmentIdSelected__c = null;
            update ccfCase;
            
            returnPage = new PageReference('/' + ccfCase.Id);
        } else {
            noEmailRecipients = true;
            returnPage = null;
        }
        return returnPage;
    }
    
    // Cancel the case closure form
    public PageReference cancelCaseclosure() {
        if (ccfCase.otherEmailSelected__c != null || ccfCase.userIdEmailSelected__c != null || ccfCase.attachmentIdSelected__c != null) {
            ccfCase.otherEmailSelected__c = null;
            ccfCase.userIdEmailSelected__c = null;
            ccfCase.attachmentIdSelected__c = null;
            update ccfCase;
        }
        PageReference returnPage = new PageReference('/' + ccfCase.Id);
        return returnPage;
    }
    

 
   
 ///------
 
 
 /*   @isTest static void testCaseClosureForm() {//
        PageReference pr;
         
         ASeedAccountingSettingsSetupTest.testDataSetup(); 
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
            userIdEmailSelected__c = system.UserInfo.getUserId(),
            otherEmailSelected__c = 'testtest@test.com.training',
            O_M_Issue_Tracking__c = 'Reactive');
        insert testCase;
        List<CaseComment> testCaseComments = new List<CaseComment>();
        testCaseComments.add(new CaseComment(
            IsPublished = true,
            ParentId = testCase.Id,
            CommentBody = 'This is the comment body of 1st comment'));
        testCaseComments.add(new CaseComment(
            IsPublished = true,
            ParentId = testCase.Id,
            CommentBody = 'This is the comment bodyof 2nd comment'));
        insert testCaseComments;
        Solution testSolution = new Solution(
            IsPublished = true,
            SolutionName = 'Solution Title',
            SolutionNote = 'This is the actual Solution',
            Status = 'Reviewed');
        insert testSolution;
        CaseSolution testCaseSolution = new CaseSolution(
            CaseId = testCase.Id,
            SolutionId = testSolution.Id);
        insert testCaseSolution;
       AcctSeed__Ledger__c  ledgers = new AcctSeed__Ledger__c(

        
                AcctSeed__Type__c = 'Transactional',
                AcctSeed__Billing_Activity_Statement_Format__c='a1U34000003y3Ql',
                AcctSeed__Billing_Outstanding_Statement_Format__c='a1U80000000COOs',
                AcctSeed__Default_Bank_Account__c= 'a1m80000000p2ic',
                AcctSeed__Default_Billing_Format__c='a1U80000000AbRO',
                AcctSeed__Default_Purchase_Order_Format__c='a1U80000000COQ8',
                AcctSeed__Default_Packing_Slip_Format__c='a1U34000004Abf2'
                   );
        
        
        insert ledgers;
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
            Site_Zip__c = '94107',
            Default_Revenue_GL_Account__c='a1m80000000p2ke');
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
            Visit_Reason__c ='',// 'Scheduled Site Inspection',
            Performed_By__c = 'Borrego',
            Contract__c = testContract.Id);
        insert testServiceVisit;
         RecordType ContentRT = [select Id FROM RecordType WHERE name='Standard Work/SOP'];
         
          //Create Attachment for testing
        Attachment Attachment =new Attachment();
        Attachment.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        Attachment.body=bodyBlob;
        Attachment.parentId=testServiceVisit.id;
        insert Attachment ;
    
    ContentVersion ContentDoc = new ContentVersion();
      ContentDoc.Title='Header_Picture1';
      ContentDoc.PathOnClient='/' + ContentDoc.Title + '.jpg';
      Blob bodyBlob1=Blob.valueOf('Unit Test ContentVersion Body');
      ContentDoc.VersionData=bodyBlob1;
        //content.LinkedEntityId=sub.id;
      ContentDoc.origin = 'H';
    insert ContentDoc ;
    
    List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        //create ContentDocumentLink  record 

        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = testCase.Id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'I';
        insert cdl;
      //  delete cdl;

      
        List<Messaging.Sendemailresult> testEmailResults;
      
        
        //Instantiate a new controller
        ApexPages.StandardController std = new ApexPages.StandardController(testCase);
        CaseClosureFormController ctl = new CaseClosureFormController(std);
        
        
        // Run the tests
        ctl.initEmailAddresses();
        ctl.ccfTest = true;
        ctl.ccfCase.Contacts__c = testContact.Id;
        List<String> userEmail = new List<String>();
        userEmail.add(system.UserInfo.getUserId());
        ctl.setselectedToUsers(userEmail);
        List<String> selectedUsers = new List<String>();
        selectedUsers = ctl.getselectedToUsers();
        ctl.getSelected();
        
        ctl.getAttachments();
       // PageReference ref = page.ctl();
       Messaging.Singleemailmessage testEmail;
     //  testemail.SendingEmail();
        
        ctl.getSelectedfiles();
        ctl.getFiles();
        system.assertEquals(selectedUsers, userEmail);
        pr = ctl.selectEmailRecipients();
        Case cs = [select Id, CaseNumber, Owner.Email from Case where Id =: testCase.Id];
        system.assertEquals(null + ';' + ctl.userEmailAddresses, cs.Owner.Email + ';' + system.UserInfo.getUserEmail());
        system.assertEquals(ctl.contactEmailAddresses, 'testtest@test.com.training;testcontact@test.com.training');
        pr = ctl.previewCaseClosure();
        system.assertEquals(pr, null);
        pr = ctl.cancelCaseClosure();
        system.assertNotEquals(pr, null);
        pr = ctl.sendCaseClosure();
        system.assertNotEquals(pr, null);
        String docURL = ctl.getDocumentLogoUrl();
        
        
            

    }  */
    
    
     
}