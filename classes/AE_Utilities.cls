public class AE_Utilities
{
    private static String AE_invoiceImage;
    public static AE_SmartInvoiceHeader__c AE_header;
    public static AE_SmartInvoiceHeader__c AE_smh;
    public static Account AE_account;
    public static String InvoicePreamble = 'Sent for OCR ';
    public static AE_SmartConfiguration__c AE_config;
    public static String AE_TimeFormat = 'yyyy-MM-dd HH:mm:ss:SSS';
    public static Case AE_Case;
    private static String AE_DbgMsg = 'AS: U ';
    public static AcctSeed__Account_Payable__c AE_ap;
    public static Boolean configFound;
    public static Attachment AE_attachment;
    public static String AE_pdfMimeType = 'application/pdf';
    public static String AE_apFields;
    public static String invoiceTypeHeaderName = 'SmartInvoice';
    public static Integer xmlTypePOLineItems = 1;
    public static String invoiceTypePOInvoiceName = 'PO Invoice';
    public static Integer xmlTypeJobLineItems = 2;
    public static String invoiceTypeJobInvoiceName = 'Job Invoice';
    private static System.LoggingLevel logLvl = LoggingLevel.WARN;
    public static List<AcctSeed__Account_Payable_Line__c> AE_apLines = 
      new List<AcctSeed__Account_Payable_Line__c>();
    public static Boolean AE_PoLineItemFound = false;

    public static Boolean getConfig()
    {        
        String ruleSelect;
        configFound = false;
        try
        {
            ruleSelect = getAllFieldsSoql('AE_SmartConfiguration__c','','LIMIT 1');
            System.debug(logLvl, AE_DbgMsg + 'ruleSelect is `' + ruleSelect + '\'');      
            AE_config = (AE_SmartConfiguration__c)Database.query(ruleSelect);
            System.debug(logLvl, AE_DbgMsg + 'AE_config is `' + AE_config + '\'');
            configFound = true;
        }
        catch(Exception exc)
        {
            String message = 'No AE_SmartConfiguration found';
            message += '\nAE Exception is `' + exc.getMessage() + '\'';
            throw new AE_Exception(message);
        }
        return(configFound);
    }

    public static void setAP_OCR_Error(String error)
    {
        String OcrError;
        if(error.length() > 254)
        {
            OcrError = error.substring(0,254);
        }
        else
        {
            OcrError = error;
        }
        System.debug(logLvl, AE_DbgMsg + 'OcrError is `' + OcrError + '\'');
        AE_ap.AS_OCR_Error__c = OcrError;
        update AE_ap; // this may have been called from exception processing, so save the AP
    }


    public static void getSmartInvoiceHeader(String emailFrom,String emailSubject)
    { 
        Id vendorId;
        String locator;

        System.debug(logLvl, AE_DbgMsg + 'emailFrom is `' + emailFrom + '\'');
        AE_account = getAccountByEmail( emailFrom ); 
        try
        {
            locator = getApNumber();
            System.debug(logLvl, AE_DbgMsg + 'locator is `' + locator + '\'');
            System.debug(logLvl, AE_DbgMsg + 'AE_config is `' + AE_config + '\'');
            System.debug(logLvl, AE_DbgMsg + 'AE_account is `' + AE_account + '\'');
            AE_header = new AE_SmartInvoiceHeader__c(
                Currency__c = AE_config.Currency__c,
                InvoiceTotal__c = 0.0,
                Locale__c = AE_config.Locale__c,
                Locator__c = locator,
                TaxTotal__c = 0.0,
                AdditionalItem_Freight__c = 0.0,
                AdditionalItem_DrumCharge__c = 0.0,
                Terms__c = String.valueof(AE_account.AcctSeed__Account_Payable_Terms__c),
                VendorName__c = AE_account.Name,
                EmailSubject__c = emailSubject
            );
            insert AE_header;
        } 
        catch(AE_Exception exc) // for Exceptions thrown by AE_ functions called here
        { 
            throw exc;
        }
        catch(Exception exc) // for Exceptions thrown by Apex code in this function
        {
          String message = 'Problem creating InvoiceHeader for email `' + emailFrom + '\'';
          message += createErrorMessage(exc);
          System.debug(message);
          throw new AE_Exception(exc.getMessage());
        }
    }


    public static String getAllFieldsSoql(String obj, String whereClause, String limitClause)
    { // see http://christopheralunlewis.blogspot.com/2011/05/how-to-dynamically-clone-salesforce.html
        String sql = '';
        String fieldString = '';
        List<String> fieldList = new List<String>();
        // Get a map of field names for this object type.
        Map<String, Schema.SObjectField> fieldMap = 
            Schema.getGlobalDescribe().get(obj.toLowerCase()).getDescribe().fields.getMap();
        if (fieldMap != null)
        {
            // Loop through all fields.
            for (Schema.SObjectField f : fieldMap.values())
            {
                // Describe each field.
                Schema.DescribeFieldResult fd = f.getDescribe();
                // System.debug(logLvl, AE_DbgMsg + 'fd.getName is `' + fd.getName() + '\'');
                // System.debug(logLvl, AE_DbgMsg + 'fd.isCreateable is `' + fd.isCreateable() + '\'');
                // This is the API name. 
                fieldList.add(fd.getName());
            }
        }
        // Assemble field list.
        if (!fieldList.isEmpty())
        {
            for (string s : fieldList)
            {
                fieldString += s + ',';
            }
        }
        // Strip terminal comma.
        if (fieldString.endsWith(',')) 
            fieldString = fieldString.substring(0, fieldString.lastIndexOf(','));

        // Assemble SQL statement.
        sql = 'SELECT ' + fieldString + ' FROM ' + obj;
        // Append WHERE clause if present; if ORDER BY or LIMIT are needed,
        // append them to WHERE clause when calling this method.
        if (whereClause != null && whereClause != '') sql += ' WHERE ' + whereClause;
        if(limitClause != null && limitClause != '') sql += ' ' + limitClause;
        // System.debug(logLvl, AE_DbgMsg + 'sql is `' + sql + '\'');
        return sql;
    }

    private static Account selectAccountByEmail( String emailSearch )
    {
        List<Account> accts;
        Account result = null;
        // 2017-07-17:sdh: ignore the email, AcctSeed__Billing_Email__c has gone
        String sql = getAccountSelect() + getAccountFrom() + 'AND Name = \'' + AE_config.DefaultVendor__c + '\' LIMIT 1';
        System.debug(logLvl, AE_DbgMsg + 'sql is `' + sql + '\'');
        accts = (List<Account>)Database.query(sql);
        if(accts.size() > 0)
        {
            result = accts[0];
        }
        System.debug(logLvl, AE_DbgMsg + 'result is `' + result + '\'');
        return (result);
    }

    private static String getAccountFrom()
    {
        String result;
        // result = 'From Account WHERE recordtypeid in (Select Id From RecordType where Name = \'Supplier\')';
        // result = 'From Account where (type = \'vendor\' or AcctSeed__accounting_type__c = \'vendor\')'; // and (name like '%color%')
        result = 'From Account where AcctSeed__accounting_type__c = \'vendor\'';
        result += ' '; // to separate this select fragment from the following fragment
        return(result);
    }

    private static Account getAccountByEmail( String emailSearch )
    { 
        String emailDefault = AE_config.DefaultVendorEmail__c;
        System.debug(logLvl, AE_DbgMsg + 'emailSearch is `' + emailSearch + '\'');
        AE_account = selectAccountByEmail( emailSearch );
        if(AE_account == null)
        { // get dummy vendor to flag OCR search for vendor name
          System.debug(logLvl, AE_DbgMsg + 'emailDefault is `' + emailDefault + '\'');
          AE_account = selectAccountByEmail(emailDefault);
        }
        if(AE_account == null)
        {
          throw new AE_Exception('Can\'t find Account for `' + emailSearch + '\' nor `' + emailDefault + '\'');
        }
        return( AE_account );
    }

    public static Datetime getLocalDateTime()
    {      
        Datetime current = DateTime.now(); // returns date time value in GMT time zone.
        Date currDate = current.date();
        Time currTime = current.time();
        // This will return date time in my local time zone.
        Datetime local = datetime.newinstance(currDate,currTime);
        return( local );
    }


    public static String getApNumber()
    {
      String result;
      if(AE_ap != null)
      {
        result = AE_ap.Name.split('-',0)[1];
      }
      return(result);
    }
    public static String createErrorMessage(Exception exc)
    {
      String result = '\nStack trace is `' + exc.getStackTraceString() + '\'\n';
      return(result);
    }

  private static String getAccountSelect()
  {
    String result = 'Select Id,Name,AcctSeed__Account_Payable_Terms__c,';
    result += 'Default_Invoice_Type__c,AcctSeed__Default_Expense_GL_Account__c';
    result += ' '; // to separate this select fragment from the following fragment
    return(result);
  }

  public class AE_Exception extends Exception{}

}