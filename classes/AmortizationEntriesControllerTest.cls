@isTest
private class AmortizationEntriesControllerTest {
    static testMethod void testIt() {
        Account acc = new Account();
        acc.Name = 'Test';
        insert acc;
        
        List<AcctSeed__GL_Account__c> glAccounts = new List<AcctSeed__GL_Account__c>();
        
        AcctSeed__GL_Account__c glAccount = new AcctSeed__GL_Account__c();
        glAccount.AcctSeed__Sub_Type_1__c = 'Liabilities';
        glAccount.AcctSeed__Type__c = 'Balance Sheet';
        glAccounts.add(glAccount);
        
        AcctSeed__GL_Account__c bankAcc = new AcctSeed__GL_Account__c();
        bankAcc.AcctSeed__Bank__c = true;
        glAccounts.add(bankAcc);
        
        AcctSeed__GL_Account__c debitAcc = new AcctSeed__GL_Account__c();
        debitAcc.Name = '2306';
        glAccounts.add(debitAcc);

        AcctSeed__GL_Account__c creditAcc = new AcctSeed__GL_Account__c();
        creditAcc.Name = '3100';
        glAccounts.add(creditAcc);

        insert glAccounts;
        
        AvaAcctSeed__CBAvaTaxSetting__c avaTax = new AvaAcctSeed__CBAvaTaxSetting__c();
        avaTax.AvaAcctSeed__GL_Account__c = glAccounts[0].Id;
        insert avaTax;
        
        List<AcctSeed__Billing_Format__c> billingFormats = new List<AcctSeed__Billing_Format__c>();
        AcctSeed__Billing_Format__c billingFormat = new AcctSeed__Billing_Format__c();
        billingFormat.AcctSeed__Type__c = 'Billing';
        billingFormat.AcctSeed__Visualforce_PDF_Page__c = 'MassSubmit';
        billingFormat.AcctSeed__Default_Email_Template__c = 'X10_Days_to_Deadline_Date';
        billingFormats.add(billingFormat);
        
        AcctSeed__Billing_Format__c billingFormat1 = new AcctSeed__Billing_Format__c();
        billingFormat1.AcctSeed__Type__c = 'Activity Statement';
        billingFormat1.AcctSeed__Visualforce_PDF_Page__c = 'MassSubmit';
        billingFormat1.AcctSeed__Default_Email_Template__c = 'X10_Days_to_Deadline_Date';
        billingFormats.add(billingFormat1);
        
        AcctSeed__Billing_Format__c billingFormat2 = new AcctSeed__Billing_Format__c();
        billingFormat2.AcctSeed__Type__c = 'Outstanding Statement';
        billingFormat2.AcctSeed__Visualforce_PDF_Page__c = 'MassSubmit';
        billingFormat2.AcctSeed__Default_Email_Template__c = 'X10_Days_to_Deadline_Date';
        billingFormats.add(billingFormat2);
        
        AcctSeed__Billing_Format__c billingFormat3 = new AcctSeed__Billing_Format__c();
        billingFormat3.AcctSeed__Type__c = 'Purchase Order';
        billingFormat3.AcctSeed__Visualforce_PDF_Page__c = 'MassSubmit';
        billingFormat3.AcctSeed__Default_Email_Template__c = 'X10_Days_to_Deadline_Date';
        billingFormats.add(billingFormat3);
        
        AcctSeed__Billing_Format__c billingFormat4 = new AcctSeed__Billing_Format__c();
        billingFormat4.AcctSeed__Type__c = 'Packing Slip';
        billingFormat4.AcctSeed__Visualforce_PDF_Page__c = 'MassSubmit';
        billingFormat4.AcctSeed__Default_Email_Template__c = 'X10_Days_to_Deadline_Date';
        billingFormats.add(billingFormat4);
        
        insert billingFormats;
        
        AcctSeed__Ledger__c ledger = new AcctSeed__Ledger__c();
        ledger.AcctSeed__Type__c = 'Transactional';
        ledger.AcctSeed__Billing_Activity_Statement_Format__c = billingFormats[1].Id;
        ledger.AcctSeed__Billing_Outstanding_Statement_Format__c = billingFormats[2].Id;
        ledger.AcctSeed__Default_Bank_Account__c = glAccounts[1].Id;
        ledger.AcctSeed__Default_Billing_Format__c = billingFormats[0].Id;
        ledger.AcctSeed__Default_Purchase_Order_Format__c = billingFormats[3].Id;
        ledger.AcctSeed__Default_Packing_Slip_Format__c = billingFormats[4].Id;
        insert ledger;
        
        AcctSeed__Accounting_Period__c period = new AcctSeed__Accounting_Period__c();
        period.AcctSeed__Status__c = 'Open';
        period.Name = '2019-06';
        period.AcctSeed__Start_Date__c = Date.today();
        period.AcctSeed__End_Date__c = Date.today().addDays(30);
        insert period;
        
        //AcctSeed__Recurring_Billing__c recurringBilling = new AcctSeed__Recurring_Billing__c();
        //insert recurringBilling;

        List<AcctSeed__Accounting_Variable__c> accVars = new List<AcctSeed__Accounting_Variable__c>();

        AcctSeed__Accounting_Variable__c accVar1 = new AcctSeed__Accounting_Variable__c();
        accVar1.Name = 'O&M';
        accVar1.AcctSeed__Type__c = 'GL Account Variable 1';
        accVars.add(accVar1);

        AcctSeed__Accounting_Variable__c accVar2 = new AcctSeed__Accounting_Variable__c();
        accVar2.Name = 'O&M';
        accVar2.AcctSeed__Type__c = 'GL Account Variable 2';
        accVars.add(accVar2);

        AcctSeed__Accounting_Variable__c accVar3 = new AcctSeed__Accounting_Variable__c();
        accVar3.Name = 'O&M';
        accVar3.AcctSeed__Type__c = 'GL Account Variable 3';
        accVars.add(accVar3);

        insert accVars;
        // AcctSeed__Project_Task__c

        AcctSeed__Billing__c billing = new AcctSeed__Billing__c();
        billing.AcctSeed__Ledger__c = ledger.Id;
        billing.AcctSeed__Accounting_Period__c = period.Id;
        billing.AcctSeed__Customer__c = acc.Id;
        billing.AcctSeed__Billing_Format__c = billingFormats[0].Id;
        insert billing;
        
        Test.startTest();
            Test.setCurrentPage(Page.AmortizationEntries);
            ApexPages.StandardController stdController = new ApexPages.StandardController(billing);
            AmortizationEntriesController ext = new AmortizationEntriesController(stdController);
            // ext.billing.User__c = UserInfo.getUserId();
            ext.submit();
            ext.back();
            // ext.billing.User__c = '0053400000BeTYZ';
            // ext.submit();
        Test.stopTest();
    }
}