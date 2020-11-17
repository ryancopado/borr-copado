@isTest
Public class    CaseClosureFormtest {

    @isTest static void testMethod1()
  
   {
   
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
        
        
    //    insert ledgers;
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
     //    RecordType ContentRT = [select Id FROM RecordType WHERE name='Standard Work/SOP'];
         
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
        cdl.ContentDocumentId = documents[0].Id;//'0691F00000093uLQAQ';//
        cdl.shareType = 'V';
        insert cdl; 
      //  delete cdl;
      
           ApexPages.StandardController std = new ApexPages.StandardController(testCase);
        CaseClosureFormController ctl = new CaseClosureFormController(std);
        
        
        // Run the tests
        ctl.initEmailAddresses();
        //ctl.ccfTest = true;
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

   
   
   }


}