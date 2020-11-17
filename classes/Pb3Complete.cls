public class Pb3Complete {

      @AuraEnabled
    
 public  static string ConComitteeUpdate(Id ccsId) 
 {
     string resultmap;
     Contract_Committee_Submittal__c Concommit = new Contract_Committee_Submittal__c();
     List<Contract_Committee_Submittal__c> conlist = [select ID,Date_PB3_Complete__c ,PB3_Complete__c  ,Execution_Version_of_Lease__c,Pricing_Request_Approved__c from Contract_Committee_Submittal__c where Id =:ccsId] ;
     
     Concommit = conlist.get(0);
     
if(Concommit.Execution_Version_of_Lease__c == null  || Concommit.Pricing_Request_Approved__c =='No' ) 
{
    resultmap = ('Before marking PB3 Complete, Executed Lease must be filled out and the Pricing Request must be approved');
    
    
}else{
    
    		try {
                
                          
                           Date d = Date.Today() ;
                           String mydate =  d.format() ;
                           Concommit.Date_PB3_Complete__c  = mydate;
                           Concommit.PB3_Complete__c  = true;
                           update Concommit;
                           resultmap = 'Pb3 Complete';
                       }
                       catch(Exception e) {
                           resultMap=  e.getMessage(); 
                       }
    
}
     return resultmap;
    
}
      
    
}