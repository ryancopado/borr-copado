/* Auther: Madan(Forcebrain Developer)
/* Date: Sept 18, 2017
/* Description: To increase code coverage of Billing Line Trigger and Handler class
*/
@isTest (SeeAllData = true) 
private class TestBillingLineTrigger {

    static testMethod void myUnitTest() {
        //Initialize all required objects
        TestAllProjectRollUpTriggers.initalizeBaseObjects(); 
        
        //Create a new project task
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Labor_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask; 
        
        Test.StartTest();   
                
        //Create a new Billing Line on the Project Task
        AcctSeed__Billing_Line__c billingLine = new AcctSeed__Billing_Line__c(AcctSeed__Billing__c = TestAllProjectRollUpTriggers.testBilling.Id, AcctSeed__Hours_Units__c = 1, AcctSeed__Rate__c = 10.0, AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Project_Task__c = projectTask.Id);

        insert billingLine;
        
        //Create an Account Payable Line on the Project Task
        AcctSeed__Account_Payable_Line__c accountPayableLine = new AcctSeed__Account_Payable_Line__c(AcctSeed__Date__c = date.today(), AcctSeed__Account_Payable__c = TestAllProjectRollUpTriggers.testAccountsPayable.Id, AcctSeed__Amount__c = 100.00, AcctSeed__Expense_GL_Account__c = TestAllProjectRollUpTriggers.testGLAccount.Id, AcctSeed__Project__c = TestAllProjectRollUpTriggers.testProject.Id, AcctSeed__Project_Task__c = projectTask.Id);
        insert accountPayableLine;
        
        //accountPayableLine.AcctSeed__Amount__c = 200;
        //update accountPayableLine;
        
        delete accountPayableLine;
        
        Tax_Group__c taxgroup = new Tax_Group__c();
        taxgroup.name = 'Test';
        insert taxgroup;
        
        // Added By Madan - Sept 18, 2017(To Increase main class code coverage)
        TestAllProjectRollUpTriggers.testBilling.Tax_Group__c = taxgroup.Id;
        
        AcctSeed__Billing_Format__c billpdf = new AcctSeed__Billing_Format__c();
        billpdf.Name = 'O&M';
        billpdf.AcctSeed__Default_Email_Template__c = ' Billing_Approved ';
        billpdf.AcctSeed__Visualforce_PDF_Page__c = 'ProjectBillingPDF';
        insert billpdf;
        
        TestAllProjectRollUpTriggers.testBilling.AcctSeed__Billing_Format__c = billpdf.Id;
        update TestAllProjectRollUpTriggers.testBilling;
        
        Account acc = new Account(Name = 'asvAccount');
        insert acc;
        
        Contract cntrct = new Contract(Name = 'asvContract', AccountId = acc.Id, Type__c = 'O&M');
        insert cntrct;
        
        SV__c sv = new SV__c(Account__c = acc.Id, Contract__c = cntrct.Id);
        insert sv;
        
        billingLine.Category__c = 'Labor - Internal'; //'Labor';
        billingLine.Service_Visit__c = sv.Id;
        update billingLine;

        delete billingLine;
        
        Test.stopTest();
    }
}