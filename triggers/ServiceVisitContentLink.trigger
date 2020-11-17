trigger ServiceVisitContentLink on ContentDocumentLink (before delete, after insert) {

   
    Schema.SObjectType token;
    Schema.SObjectType token1;
    Schema.DescribeSObjectResult dr;
    List<ContentDocumentLink> contentList;
    Map<ID, ContentDocumentLink> contentMap;
    List<SV__c> srvList = new List<SV__c>();
    List<SV__c> srvUpdate = new List<SV__c>();
    List<Id> srvIds = new List<Id>();
    List<Id> cdlIds = new List<Id>();
    String pId;
    
  if (trigger.isInsert) {
    
        // Find all the Attachments associated with a service visit 
        for (ContentDocumentLink content : trigger.new) {
        
            token = content.LinkedEntityId.getSObjectType();
            dr = token.getDescribe();
            system.debug('Look Here for OBJECT' +dr.getName() );
                        
            if (dr.getName() == 'SV__c') {
                srvIds.add(content.LinkedEntityId);
                cdlIds.add(content.ContentDocumentID);
                }
            
            }
            //update the photo file 1 & 2 with the contentdocument id
             if (!srvIds.isEmpty()) {
             
              srvList = [select Id,File_Photo1__c ,File_Photo2__c from SV__c where Id in: srvIds];
              contentList = [select ContentDocumentID from ContentDocumentLink where LinkedEntityId in: srvIds and ContentDocumentID in:cdlIds ];
              contentMap = new Map<ID, ContentDocumentLink>();
                   if (!contentList.isEmpty()) {
                        for (ContentDocumentLink content: contentList) { 
                        
                        pId = string.valueOf(content.ContentDocumentID ).substring(0,15);
                        system.debug('the ID LOOOOK' +pId );
                        SV__c servicevisit = new  SV__c();
                        servicevisit=srvlist.get(0);
                        
                        system.debug('the photo field' +servicevisit.file_photo1__c);
                        system.debug('the photo field' +servicevisit.File_Photo2__c);
                           if (servicevisit.File_Photo1__c == null && servicevisit.File_Photo2__c == null ) {
                        
                                  servicevisit.File_Photo2__c = pId ;
                                  servicevisit.File_Photo1__c = null;
                                  system.debug('the ID LOOOOK' +pId );
                                  system.debug('Entering First photo2' +servicevisit.File_Photo2__c);
                                  system.debug('Entering First photo1' +servicevisit.File_Photo1__c);
                                  srvUpdate.add(servicevisit);
                                  break;
                                }
                                if (servicevisit.File_Photo1__c == null && servicevisit.File_Photo2__c !=null ) {
                                 
                                  servicevisit.File_Photo1__c = pId ;
                                  system.debug('Entering second loop photo1');
                                 srvUpdate.add(servicevisit);
                                 break;
                                } 
                               if (servicevisit.File_Photo1__c != null && servicevisit.File_Photo2__c !=null ) {
                        
                                  servicevisit.File_Photo1__c = '';
                                  servicevisit.File_Photo1__c = pId ;
                                  system.debug('Entering third loop photo1');
                                  srvUpdate.add(servicevisit);
                                  break;
                                 }
                        }
                     
                               if (!srvUpdate.isEmpty()) {
                                     system.debug('data present if loop working'  +srvUpdate);
                                     update srvUpdate;
                                   }          
                   
                   }
              }
              
                  
              
         }   
           
                
     if (trigger.isDelete) {
     
     
     //find the all the file in the service visit
     for (ContentDocumentLink content : trigger.old) {
        
            token = content.LinkedEntityId.getSObjectType();
            dr = token.getDescribe();
            system.debug('Look Here for OBJECT' +dr.getName() );
                        
            if (dr.getName() == 'SV__c') {
                srvIds.add(content.LinkedEntityId);
                cdlIds.add(content.ContentDocumentID);
                system.debug('Look Here for ContentDocumentID' +cdlIds);
                
                }
            }
            
            if (!srvIds.isEmpty()) {
            
            //update the file photo 1 & 2 after deleting the files. 
            srvList = [select Id,File_Photo1__c ,File_Photo2__c from SV__c where Id in: srvIds];
            //contentList = new List<ContentDocumentLink>();
            
            contentList = [select ContentDocumentID, LinkedEntityId from ContentDocumentLink where LinkedEntityId in: srvIds and ContentDocumentID in:cdlIds ];
            contentMap = new Map<ID, ContentDocumentLink>();
            if (!contentList.isEmpty()) {
                for (ContentDocumentLink content : contentList) {
                
                       string pId = string.valueOf(content.ContentDocumentID ).substring(0,15);
                     system.debug('The delete CIL' +pId );
              for (SV__c svr: srvList ) {
                     system.debug('The delete photo id' +svr.File_Photo1__c);
                     system.debug('The delete photo id' +svr.File_Photo2__c);
             
                if (!contentMap.containsKey(svr.Id)) //&& !attMap.containsKey(Pr.Id)) 
                {
                    if (svr.File_Photo1__c == pId ){
                    svr.File_Photo1__c =' '; 
                   // svr.File_Photo2__c =' ';
                     srvUpdate.add(svr);}
                    
                    if (svr.File_Photo2__c == pId)
                    {
                      svr.File_Photo2__c =' ';
                    //  svr.File_Photo1__c =' ';
                      srvUpdate.add(svr);
                    }
                    
                }
                
            }
                    
         }
    }
        
          if (!srvUpdate.isEmpty()) {
                update srvUpdate;
            }
        } 
        
        srvList = [select Id,File_Photo1__c ,File_Photo2__c from SV__c where Id in: srvIds]; 
        SV__c servicevisit = new  SV__c();
        if (srvList.size() > 0) {
        servicevisit=srvlist.get(0);
        system.debug('The delete photo id loook' +servicevisit.File_Photo1__c);
        system.debug('The delete photo id loook' +servicevisit.File_Photo2__c);
        if (servicevisit.File_Photo2__c == null ) {
              //&& servicevisit.File_Photo2__c != null 
             servicevisit.File_Photo2__c = servicevisit.File_Photo1__c;
             servicevisit.File_Photo1__c =' ';
        
        } 
       
      
        update servicevisit;
        
         }
      
     }      
    
}