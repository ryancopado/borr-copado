@isTest
Public class ContentLinkConreqgroup1test {

  @isTest static void testMethod1()
  
   {

   Con_Req_Group__c crgList = new Con_Req_Group__c();
     
        crgList.Project__c  = 'a1t34000002v45k';
        crgList.Sales_Order__c = 'a2C340000002yu9';
        crgList.Vendor__c = '0018000000xpgUZ';
        crgList.Vendor_Contact__c ='00334000022UtU4';
        crgList.Ship_to_Account__c = '0018000000xpgUZ';
        crgList.Ship_To_Site__c = 'a6934000000ND94';
        crgList.Requested_Delivery_Date__c = system.today();

 insert crglist;
 
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
        cdl.LinkedEntityId = crglist.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        delete cdl;
  
  
  }
   @isTest static void testMethod2()
   {
    SFDC_Purchase_Requisition__c reqlist = new SFDC_Purchase_Requisition__c();
       //  reqlist.RecordTypeId = [select Id FROM RecordType WHERE name='DocuSign Request']; 
         reqlist.ProjectAS__c = 'a1t34000002v45k';
         reqlist.Date_Needed__c = system.today();
         reqlist.BriefDescriptionofDocument__c = 'test';
         reqlist.External_Recipients_and_Order__c = 'test';
         reqlist.Pages_where_signature_is_required__c = 'test';
         reqlist.InternalRecipientsandOrder__c = 'test';
         
         insert reqlist;
         
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
        cdl.LinkedEntityId = reqlist.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        delete cdl;
  
   }
   
   @isTest static void testMethod3()
   {
    
    Case caselist= new Case();
    caselist.AccountId='0018000000xpgUZ';
    caselist.Project__c='a1t340000034Qdj';
    caselist.Status='Active';  
    caselist.Priority='Medium';
    caselist.Origin='Email';
    caselist.Case_Start_Date__c=date.newInstance(2018, 07, 01);
    caselist.Reason='System Down';
    
    insert caselist;
    
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
        cdl.LinkedEntityId = caselist.id;
        cdl.ContentDocumentId = documents[0].Id;
        cdl.shareType = 'V';
        insert cdl;
        //delete cdl;
  
}
}