@IsTest
private class MB_ContentVersionScriptTest {
    @IsTest
    static void testBehavior() {

        ASeedAccountingSettingsSetupTest.testDataSetup();
        Account acc = new Account(Name = 'nsvAccount');

        insert acc;
        Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = acc.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000,
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), Financing__c = 'Cash',
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert testOpportunity;
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Account__c = acc.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Branch__c = 'San Diego',PC_Code__c = 10);  // ,PC_Code__c = '10''
        insert testProject;
        Case testNewCase = new Case(AccountId=acc.id,Project__c= testProject.Id);
        insert testNewCase;
        WorkOrder testWorkOrder = new WorkOrder(CaseId=testNewCase.Id,WorkTypeId='08q2H0000008OIjQAM');
        insert testWorkOrder;
        system.debug('work order' +testWorkOrder);
        workorderlineitem testwolineitem = new workorderlineitem(WorkOrderId =testWorkOrder.Id);
        insert testwolineitem;
        Checklist__c checklst = new Checklist__c(Work_Order_Line_Item__c = testwolineitem.Id );
        insert checklst;

        //testwolineitem.Checklist__c=checklst.Id;
        //update testwolineitem;

        RecordType ContentRT = [select Id FROM RecordType WHERE name='Standard Work/SOP'];

        ContentVersion ContentDoc = new ContentVersion();
        ContentDoc.Title = 'My Doc';
        ContentDoc.Description ='test';
        ContentDoc.RecordTypeId = ContentRT.Id; //'01234000000GGcgAAG';
        ContentDoc.ContentUrl= 'test.com';
        Insert ContentDoc;

         List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
         //create ContentDocumentLink  record

         ContentDocumentLink cdl = New ContentDocumentLink();
         cdl.LinkedEntityId = checklst.id;
         cdl.ContentDocumentId = documents[0].Id;
         cdl.shareType = 'V';
         insert cdl;
        //     workorderlineitem testwolineitem = new workorderlineitem(Checklist__c =  );
        testwolineitem.Checklist__c = checklst.Id;
        update testwolineitem;

        Test.startTest();
        MB_ContentVersionScript c = new MB_ContentVersionScript();
        Database.executeBatch(c);
        Test.stopTest();


    }
}