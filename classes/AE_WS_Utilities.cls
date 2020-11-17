global with sharing class AE_WS_Utilities
{
    public static String AS_achId = null;
    public static String AS_payeeId = null;
    public static List<AcctSeed__Cash_Disbursement__c> cds;
    public static List<AcctSeed__AP_Disbursement__c> apdsList;
    public static Map<String,AS_ACH__c> achMap;
    public static Map<Id,AcctSeed__Cash_Disbursement__c> cdsMap;
    private static JSONGenerator achResult = JSON.createGenerator(true);
    private static String AE_DbgMsg = 'AS: WSU ';
    private static System.LoggingLevel AE_Ll = LoggingLevel.WARN;

     webservice static String sendACH(String cdIds, String cdbId)
     {
        String errorMessage = null;
        List<AcctSeed__AP_Disbursement__c> allApds;
        Boolean errorExists = false;
        
        try
        {
          System.debug('AS: AE_WS cdIds is `' + cdIds + '\'');
          System.debug('AS: AE_WS cdbId is `' + cdbId + '\'');
          System.debug('AS: AE_WS achResult is `' + achResult + '\'');
          achResult.writeStartObject();
          if(String.isEmpty(cdIds))           
          {
              achResult.writeStringField('fatal','no Cash Disbursement(s) specified.');
              errorExists = true;
          }       
          if(String.isEmpty(cdbId))           
          {
              achResult.writeStringField('fatal', 'Cash Disbursement Batch not specified.');
              errorExists = true;
          }       
          if(errorExists == false)
          {
            String validCdIds;
            allApds = getApdValues(cdIds);
            validCdIds = validateCds();
            System.debug('AS: AE_WS validCdIds is `' + validCdIds + '\'');
            if(String.isEmpty(validCdIds) == false)
            {
              AS_ACH.sendACH(validCdIds);
            }
          }
        }
        catch(Exception exc)
        {
          System.debug('AS: AE_WS exception is `' + exc + '\'');
          achResult.writeStringField('exception', exc.getMessage());
          errorExists = true;
        }
        achResult.writeEndObject();
        System.debug('AS: AE_WS achResult is `' + achResult + '\'');
        System.debug('AS: AE_WS achResult.getAsString() is `' + achResult.getAsString() + '\'');
        return(achResult.getAsString());
        // JSONGenerator trial = JSON.createGenerator(true);
        // trial.writeStartObject();
        // trial.writeStringField('first','a result');
        // trial.writeStringField('second','another result');
        // trial.writeStringField('third','hello result');
        // trial.writeEndObject();
        // return(trial.getAsString());
     }

     public static Boolean checkBankingDetails(AcctSeed__Cash_Disbursement__c cd)
     {
       Boolean errorExists = false;
       String payeeName = cd.AcctSeed__Payee__c;
       if(String.isEmpty(payeeName))           
       {
          achResult.writeStringField(cd.Name, 'must have an associated payee');
          errorExists = true;
       }
       return(errorExists);
     }

    private static Boolean checkAchState(AcctSeed__Cash_Disbursement__c cd)
    {
      Boolean errorExists = false;
      System.debug('AS: AE_WS cd is `' + cd + '\'');
      if(cd.ACH_Payment_Date_RW__c != null)
      {
        achResult.writeStringField(cd.Name, 'Was paid on `' + cd.ACH_Payment_Date_RW__c + '\'');
        errorExists = true;
      }
      else
      { // go ahead and try to pay
        if(cd.ACH_OK_RW__c != True)
        {
          achResult.writeStringField(cd.Name, 'ACH has not been approved');
          errorExists = true;
        }
        if(cd.AcctSeed__Type__c != 'Electronic')
        {
          achResult.writeStringField(cd.Name, 'Type should be `Electronic\'');
          errorExists = true;
        }
        if(cd.AcctSeed__Status__c != 'Posted')
        {
          achResult.writeStringField(cd.Name, 'Posting Status should be `Posted\'');
          errorExists = true;
        }
        if(cd.AcctSeed__Payment_Status__c != 'Paid')
        {
          achResult.writeStringField(cd.Name, '\nPayment Status should be `Paid\'');
          errorExists = true;
        }
      }
      return(errorExists);
    }

    public static List<AcctSeed__AP_Disbursement__c> getApdValues(String cdIds)
    {
      List<AcctSeed__AP_Disbursement__c> apds;
      String[] cdString;
      cdString = cdIds.split(',',-1);
      System.debug('AS: AE_WS cdString is `' + cdString + '\'');
      cdsMap = new Map<Id,AcctSeed__Cash_Disbursement__c>(
      [SELECT Id,Name,AcctSeed__Payee__c,
           AcctSeed__Vendor__c,AcctSeed__Contact__c,AcctSeed__Employee__c,
           AcctSeed__Amount__c,
           AcctSeed__Payment_Status__c,AcctSeed__Status__c,
           AcctSeed__Type__c,
           ACH_Payment_Date_RW__c,
           ACH_OK_RW__c
           FROM AcctSeed__Cash_Disbursement__c WHERE Id in :cdString
           ]);
      System.debug('AS: AE_WS cdsMap.values() is `' + cdsMap.values() + '\'');

      apds = [SELECT Id,AcctSeed__Payee_Reference__c,
           AcctSeed__Paid_Amount__c, AcctSeed__Cash_Disbursement__c
           FROM AcctSeed__AP_Disbursement__c
           WHERE AcctSeed__Cash_Disbursement__c in :cdString];
      System.debug(' AE_WS apds is `' + apds + '\'');

      List<String> achList = new List<String>();
      for(AcctSeed__Cash_Disbursement__c cd : cdsMap.values())
      {
        achList.add(cd.AcctSeed__Vendor__c);
      }
      achMap = new Map<String,AS_ACH__c>();
      for(AS_ACH__c ach : [SELECT Account__c,Contact__c,User__c,
          BankRoutingNumber__c,BankAccountNumber__c,TransactionCode__c
          FROM AS_ACH__c WHERE Account__c in :achList
          ])
      {
        achMap.put(ach.Account__c,ach);
      }
      System.debug('AS: AE_WS achMap.values() is `' + achMap.values() + '\'');
      System.debug('AS: AE_WS achMap.keySet() is `' + achMap.keySet() + '\'');
      return(apds);
    }

    private static String validateCds()
    {
      String result = '';
      Boolean errorExists;
      for(AcctSeed__Cash_Disbursement__c cd : cdsMap.values())
      {
        errorExists = false;
        // does the payee have the banking details
        errorExists = checkBankingDetails(cd);
        if(errorExists == false)
        {
          // is the cd in the right state
          errorExists = checkAchState(cd);
          if(errorExists == false)
          {
            result += cd.Id + ',';
          }
        }
      }
      return(result.removeEnd(','));
    }
    /*
    webservice static String addAch(String objName, String payeeId)
    {
      String result = 'no associated ACH';
      String objSym = objName + '__c';

      Schema.SobjectType convertType = Schema.getGlobalDescribe().get(objName);
      Sobject objType = convertType.newSobject();
      System.debug('AS: WS objType is `' + objType + '\'');
      String sql = 'SELECT ' + objSym + ' FROM AS_ACH__c WHERE ' + objSym + ' = \'' + payeeId + '\'';
      List<Sobject> achs = Database.query(sql);
      System.debug('AS: WS achs is `' + achs + '\'');
      if(achs.size() == 0)
      {
        AS_ACH__c ach = new AS_ACH__c();
        ach.put(objSym, payeeId);
        insert ach;
        result = ach.Id;
      }
      else // take the first ach, should only be one
      {
        result = achs[0].Id;
      }
      return(result);
    }
    */

}