public class NotifyPB3 {
	
     @AuraEnabled
    
 public  static string ConComitteeUpdate(Id ccsId) 
 {
     string resultmap;
     Contract_Committee_Submittal__c Concommit = new Contract_Committee_Submittal__c();
     List<Contract_Committee_Submittal__c> conlist = [select ID,Date_PB3_Team_Notified__c,Notify_PB3_Approval_Team__c ,Execution_Version_of_Lease__c,Lease_Extraction_Form__c,Wetlands_Delineation__c,GIS_LIDAR_survey__c,Skeletal_survey__c,Title_Report_its_Legal_Review__c from Contract_Committee_Submittal__c where Id =:ccsId] ;
     //
     Concommit = conlist.get(0);
     
if(Concommit.Execution_Version_of_Lease__c == null || Concommit.Lease_Extraction_Form__c == null || Concommit.Wetlands_Delineation__c == null || Concommit.GIS_LIDAR_survey__c == null || Concommit.Skeletal_survey__c == null || Concommit.Title_Report_its_Legal_Review__c == null ) 
{
    resultmap = ('Before notifying PB3 Approval Team, Execution version of Lease, Lease Extraction Form, and all Initial Site Discovery Items (except NHESP Letter) must be filled out');
    
    
}else{
    
    		try {
                
                          
                           Date d = system.Today() ;
                           String mydate =  d.format() ;
                         //  string mydate = string.valueof(date.today(),'MM/DD/YYYY');
                        Concommit.Date_PB3_Team_Notified__c = mydate;
                        Concommit.Notify_PB3_Approval_Team__c = true;
              				//  system.debug(system.Today());
                              system.debug(d);
                			  system.debug(concommit);
                           update Concommit;
                          // errmsg= ('Opportunity Updated to ' +oppvalues.StageName);
                           resultmap = 'Notified Pb3 Team';
                       }
                       catch(Exception e) {
                           resultMap=  e.getMessage(); 
                       }
    
}
     return resultmap;
 }   
   
    
}