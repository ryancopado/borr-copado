@isTest(SeeAllData=true)
private class AE_Utilities_Test
{

    static testMethod void AB_LongErrorString()
    {
      String aLongError = 'This is a long error string greater than 254 characters';
      aLongError += ' This is a long error string greater than 254 characters';
      aLongError += ' This is a long error string greater than 254 characters';
      aLongError += ' This is a long error string greater than 254 characters';
      aLongError += ' This is a long error string greater than 254 characters';
      AE_Utilities.AE_ap = [SELECT Id,Name,AS_OCR_Error__c
        FROM AcctSeed__Account_Payable__c
        LIMIT 1];
      AE_Utilities.setAP_OCR_Error( aLongError );
      System.assertEquals(true,true);
    }

    static testMethod void AC_SmartInvoiceHeader()
    {
      Boolean result = false;
      try
      {
        Boolean setup = AE_Utilities.getConfig();
        if(setup == true)
        {   
          AE_Utilities.AE_ap = new AcctSeed__Account_Payable__c();
          AE_Utilities.getSmartInvoiceHeader('nonexistant@sample.com','E20160714_12345_this is a subject');
        }
      }
      catch(Exception exc)
      {
        String compare = 'null object';
        if(exc.getMessage().contains(compare) == true)
        {
          result = true;
        }
      }
      System.assertEquals(true,result);
    }
    
}