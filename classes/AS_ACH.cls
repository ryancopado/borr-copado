global with sharing class AS_ACH
{
    private static String endpointURL;
    private static String achKey;
    private static String AE_DbgMsg = 'AS: A ';
    private static String statusMessage;
    private static Integer statusCode;
    // private static String cookies;

    @future(callout=true)
    public static void sendACH(String cdsString)
    {
        Boolean errorExists;
        JSONGenerator result;
        AcctSeed__AP_Disbursement__c[] apds;

        System.debug(AE_DbgMsg + 'cdsString is `' + cdsString + '\'');
        AS_ACHConfig__c achConfig = [SELECT CompanyDiscretionaryData__c, CompanyEntryDescription__c, CompanyIdentification__c,
                        CompanyName__c, ImmediateDestinationName__c, ImmediateDestination__c, ImmediateOriginName__c,
                        ImmediateOrigin__c, StandardEntryClassCode__c FROM AS_ACHConfig__c LIMIT 1];
        AE_SmartConfiguration__c config = [SELECT Customer__c,DocumentType__c,ACH_Key__c,ACH_URL__c
          FROM AE_SmartConfiguration__c
          LIMIT 1];
        apds = AE_WS_Utilities.getApdValues(cdsString);
        endpointURL = config.ACH_URL__c;
        achKey = config.ACH_Key__c;
        HttpRequest reqData = new HttpRequest();
        // Http http = new Http();      
        // reqData.setHeader('Content-Type','application/x-www-form-urlencoded');
        reqData.setHeader('Content-Type','application/json');
        // reqData.setHeader('Connection','keep-alive');
        // reqData.setHeader('Content-Length','0');
        // reqData.setHeader('Cookie', cookies);
        reqData.setTimeout(60000); // 60,000 millisecs
        reqData.setEndpoint(endpointURL);
        // String targetString = 'key='+ EncodingUtil.URLENCODE(achKey,'UTF-8');
        result = JSON.createGenerator(true);

        result.writeStartObject();
        result.writeStringField('key', achKey);
        result.writeFieldName('achData');
        result.writeStartArray();
        for(AcctSeed__AP_Disbursement__c apd : apds)
        {
          AcctSeed__Cash_Disbursement__c cd 
            = AE_WS_Utilities.cdsMap.get(apd.AcctSeed__Cash_Disbursement__c);
          System.debug(AE_DbgMsg + 'cd is `' + cd + '\'');
          AS_ACH__c ach = AE_WS_Utilities.achMap.get(cd.AcctSeed__Vendor__c);
          System.debug(AE_DbgMsg + 'ach is `' + ach + '\'');
          result.writeStartObject();
          result.writeStringField('cdReferenceNumber', apd.Id);
          result.writeStringField('immediateOriginName', achConfig.immediateOriginName__c);
          result.writeStringField('companyName', achConfig.CompanyName__c);
          result.writeStringField('companyDiscData', achConfig.CompanyDiscretionaryData__c);
          result.writeStringField('standardEntryClassCode', achConfig.StandardEntryClassCode__c);
          result.writeStringField('companyEntryDescription', achConfig.CompanyEntryDescription__c);
          result.writeStringField('transactionCode', ach.TransactionCode__c);
          result.writeStringField('dfiRoutingNumber', ach.BankRoutingNumber__c);
          result.writeStringField('dfiAccountNumber', ach.BankAccountNumber__c);
          // use Paid Amount from AP Disbursement
          Integer amount = Integer.valueOf(apd.AcctSeed__Paid_Amount__c * 100);
          String amountString = String.valueOf(amount);
          result.writeStringField('amountCents', amountString);
          result.writeStringField('individualIdentificationNumber',cd.AcctSeed__Payee__c);
          result.writeStringField('individualName',apd.AcctSeed__Payee_Reference__c);
          result.writeEndObject();
        }
        result.writeEndArray();
        System.debug(AE_DbgMsg + 'result is `' + result.getAsString() + '\'');
        reqData.setBody(result.getAsString());   
        reqData.setMethod('POST');    
        HTTPResponse res;
        res = new Http().send(reqData);
        statusMessage = res.getStatus();
        System.debug(AE_DbgMsg + 'statusMessage is `' + statusMessage + '\'');
        statusCode = res.getStatusCode();
        System.debug(AE_DbgMsg + 'statusCode is `' + statusCode + '\'');
        if(statusCode == 200)
        { for(AcctSeed__Cash_Disbursement__c cd : AE_WS_Utilities.cdsMap.values())
          {
            cd.ACH_Payment_Date_RW__c = System.now().format(); // stores local time in database
            update cd;
          }
        }
    }

/*    
    private static void getAuthToken()
    {
        HttpRequest reqData = new HttpRequest();
        Http http = new Http();
        reqData.setMethod('HEAD');
        reqData.setTimeout(20000);
        reqData.setEndpoint(endpointURL);
        try
        {
            HTTPResponse res = http.send(reqData);
            cookies = res.getHeader('Set-Cookie');
            // System.debug(AE_DbgMsg + 'cookies is `' + cookies + '\'');
            statusMessage = res.getBody(); 
            // System.debug(AE_DbgMsg + 'statusMessage is `' + statusMessage + '\'');
        }
        catch(Exception exp)
        {
            System.debug(AE_DbgMsg + 'exception ' + exp);
        }
    }
*/
}