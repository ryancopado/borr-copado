@isTest(seeAllData=true)
private class testCashDisbursementCtlExt {
  
  /*
   *  Test methods for class file CaseDisbursementCtlExt
   *
   */
  
  static testMethod void testCDCtlExt1() {
    
    // Create the test data we need
    TestDataSuite.initialize();
    
    TestDataSuite.contacts[0].Contact_Type__c = 'Billing Contact';
    TestDataSuite.contacts[0].Email = 'testCDCtlExt1=borregosolar.com@example.com';
    update TestDataSuite.contacts[0];
    
    TestDataSuite.cashDisbursements[0].OK_To_Email__c = true;
    update TestDataSuite.cashDisbursements[0];
    
    // Test the CashDisbursement controller extension
    List<AcctSeed__Cash_Disbursement__c> cdList = new List<AcctSeed__Cash_Disbursement__c>();
    cdList.add(TestDataSuite.cashDisbursements[0]);
    ApexPages.StandardSetController setCon = new ApexPages.StandardSetController(cdList);
    setcon.setSelected(cdList);
    CashDisbursementCtlExt ext = new CashDisbursementCtlExt(setcon);

    ext.sendACHEmail();
  }
  }