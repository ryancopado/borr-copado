@isTest
Public class ServiceVisitContentLinktest {

 @isTest static void servicetestMethod() {
   
          SV__c servicevisit = new SV__c ();
               
          servicevisit.Visit_Date__c  = system.today();
          servicevisit.Technician__c ='0038000001hE49RAAS'; // [select id from contact where name like '%test' limit 1].id;
          servicevisit.Account__c = '0018000000xpgUZ';
          servicevisit.Contract__c = '80034000000VDhH';
          insert servicevisit;
          
   
   RecordType ContentRT = [select Id FROM RecordType WHERE name='Standard Work/SOP'];
    
    ContentVersion ContentDoc = new ContentVersion();
       ContentDoc.Title = 'My Doc';
       ContentDoc.Description ='test';
       ContentDoc.RecordTypeId = ContentRT.Id; //'01234000000GGcgAAG';
       ContentDoc.ContentUrl= 'test.com';
        Insert ContentDoc;
      
         List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        //create ContentDocumentLink  record 

        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = servicevisit.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        delete cdl;
   
   
   
   
   
   }

}