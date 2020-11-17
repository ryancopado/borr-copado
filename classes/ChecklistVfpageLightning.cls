public class ChecklistVfpageLightning {

    @AuraEnabled
     public  static List<Checklist__c> getchklist(Id woId) 
    {
          system.debug('Checklist' +woId);
        
     List<Checklist__c>  ChkLstWO = new Checklist__c[]{};
         workorderlineitem WOChklist = new workorderlineitem(); 
         WOChklist = [select id , Checklist__c from workorderlineitem where id =:woId ];
      
        
      //  string ChkLstWO = wochklist.Checklist__c;
        
       ChkLstWO = [select id,RecordType.Name,RecordTypeId from Checklist__c where id= :WOChklist.Checklist__c];
   
         return ChkLstWO;
      }
      @AuraEnabled
    public  static List<ContentDocument> getFiles(Id woId1) 
        
       { 
           workorderlineitem WOChklist = new workorderlineitem(); 
         WOChklist = [select id , Checklist__c from workorderlineitem where id =:woId1 ];
        
        string ChkLstWO = wochklist.Checklist__c;
        
           list<ContentDocumentLink> getfileid=new list<ContentDocumentLink>();
           getfileid=[SELECT ContentDocumentid FROM ContentDocumentLink WHERE linkedentityid =:ChkLstWO];
           
           List<Id> cntid = new List<Id>();
          // string cntid = getfileid.ContentDocumentId;
           for(ContentDocumentLink idrec : getfileid){
                       cntid.add(idrec.ContentDocumentid);
                        }
           
           List<ContentDocument> contentfiles = new List<ContentDocument>();
           contentfiles = [SELECT Id,title  FROM ContentDocument WHERE id IN:cntid ];
           system.debug('Files' +contentfiles);
           return contentfiles;
           
       }
   /* @AuraEnabled
     public  static List<Pending_Work__c> getpendingwork(Id woId2) 
        
       { 
           system.debug('this is pendingwork');
           workorderlineitem WOChklist = new workorderlineitem(); 
         WOChklist = [select id , Checklist__c from workorderlineitem where id =:woId2 ];
        
        string ChkLstWO = wochklist.Checklist__c;
           List<Pending_Work__c> pendingwork=new List<Pending_Work__c>();
           pendingwork=[SELECT Id,Name  FROM Pending_Work__c WHERE Checklist__c =:ChkLstWO];
           system.debug('look here-->' +pendingwork);
           return pendingwork;
           
       }*/
    
    
      
}