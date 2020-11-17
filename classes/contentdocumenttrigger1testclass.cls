@isTest
public class contentdocumenttrigger1testclass {
    @isTest static void testMethod1()
  
   {
       //Profile p = [SELECT Id FROM Profile WHERE Name='O&M Manager'];
       User U = [select id from User where profile.Name='O&M Manager' and IsActive=true limit 1];
       system.debug('User' +U);
       System.runAs(U)
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
       }

}
}