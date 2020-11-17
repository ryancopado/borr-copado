public with sharing class Projectbookedcontroller {
     @AuraEnabled
 /*  public static Opportunity getOpportuniy(Id OppId){
    return [SELECT Name, Id,StageName,Type FROM Opportunity  WHERE Id = :OppId ];
    
    }
} */
    
     public  static string OppUpdate(Id OppId) 
    {
       String resultMap; 
       String rtId;
       String rtCaptiveOnSite;
       Integer errnum=0;
       String errmsg ='';
            
    Opportunity oppvalues=new Opportunity ();
    List<Opportunity> opp = [Select Id, Approximate_Install_Date__c,Won_Loss_Explanation__c,Type,Utility_Company__c,Prevailing_Wage__c,Tax_Exemption__c,Financing__c,Amount,RecordTypeId,StageName FROM Opportunity Where Id =: OppId ];
 
           oppvalues=opp.get(0);
           Date apprxdate=oppvalues.Approximate_Install_Date__c;
           String TYPE=oppvalues.Type;
           String UTIL=oppvalues.Utility_Company__c;
           String PREVWAGE=oppvalues.Prevailing_Wage__c;
           String EXEMPT=oppvalues.Tax_Exemption__c;
           Decimal TOTALPRICE=oppvalues.Amount;
           rtId=oppvalues.RecordTypeId; 
           rtCaptiveOnSite='012340000007kaK';
           String WONLOSS = oppvalues.Won_Loss_Explanation__c;
           String FINSOURCE=oppvalues.Financing__c;

          
           if(TYPE != 'Service') {
            errmsg='Please Enter the Value For \n'; 
           if (TOTALPRICE == null)
           {     
               apprxdate = null;
               errnum++ ; 
               errmsg += 'Amount\n';
               } 
            if (TYPE == null){errnum++; errmsg += 'Type\n';} 
      if (WONLOSS== null){errnum++; errmsg += 'Won/Loss Explanation\n';} 
      if (EXEMPT == null){errnum++; errmsg += 'Tax Exemption Status';}    
               
           }   
   
                   system.debug('ERNUM VALUE' +errnum);
                   if (errnum==0) {
                       
                       
                    system.debug('record ID' +rtId.substring(0,15));
                    system.debug('FinSource' +FINSOURCE);
                    if (rtId.substring(0,15) == rtCaptiveOnSite) {                        
          if( FINSOURCE == 'PPA'|| FINSOURCE == 'PPA – Borrego' || FINSOURCE == 'PPA - 3rd Party')  {                           
            oppvalues.StageName = 'Project Booked'; 
          } else { 
            oppvalues.StageName = 'Contract Signed'; 
            } 
          } else { 
          oppvalues.StageName = 'Project Booked'; 
              }  
                          
            
                       try {
                           update oppvalues;
                           errmsg= ('Opportunity Updated to ' +oppvalues.StageName);
                           resultMap=errmsg;
                       }
                       catch(Exception e) {
                           resultMap=  e.getMessage(); 
                       }
                 
               } 
           
            else {
                
                    resultMap= errmsg ;
                                   
                      
                  }    
        
      
                  system.debug('LOOK HERE'  +resultMap);
                  return resultMap;   
    
           }
           }