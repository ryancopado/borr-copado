@isTest
private class testVendorPOwPOLNotification {
    
    /*
     *  Test methods for class file VendorPOwPOLNotification.
     *
     */
     
    static testMethod void myUnitTest() {
        
        // Create test data
        AcctSeed__Billing_Format__c pdfFormat = new AcctSeed__Billing_Format__c(Name = 'Other2', AcctSeed__Default_Email_Template__c = 'Billing_Email_Template', AcctSeed__Visualforce_PDF_Page__c = 'Billing_InvoicePDF', AcctSeed__Type__c = 'Purchase Order');
        insert pdfFormat;
        
         List<AcctSeed__Ledger__c> ledgers = new List<AcctSeed__Ledger__c>();

        ledgers.add(
            new AcctSeed__Ledger__c(
                Name = 'Actual',
                AcctSeed__Type__c = 'Transactional',
                AcctSeed__Billing_Activity_Statement_Format__c='a1U34000003y3Ql',
                AcctSeed__Billing_Outstanding_Statement_Format__c='a1U80000000COOs',
                AcctSeed__Default_Bank_Account__c= 'a1m80000000p2ic',
                AcctSeed__Default_Billing_Format__c='a1U80000000AbRO',
                AcctSeed__Default_Purchase_Order_Format__c='a1U80000000COQ8',
                AcctSeed__Default_Packing_Slip_Format__c='a1U34000004Abf2'
                
            )
        );
        
        insert ledgers;
        
        AcctSeedERP__Purchase_Order__c po = new AcctSeedERP__Purchase_Order__c(AcctSeedERP__Purchase_Order_Format__c = pdfFormat.Id,AcctSeedERP__Ledger__c=ledgers[0].Id);
        insert po;
        
        // Test the class file
        VendorPOwPOLNotification ctl = new VendorPOwPOLNotification();
        ctl.poId = po.Id;
        AcctSeedERP__Purchase_Order__c ctlPO = ctl.getPurchaseOrder();
        List<AcctSeedERP__Purchase_Order_Line__c> ctlPOLines = ctl.getPOLines();
    }
}