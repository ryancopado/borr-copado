global class MB_ContentVersionScript implements Database.Batchable<sObject>, Database.Stateful{

    global String debugString = '';
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id FROM Checklist__c WHERE (Work_Order_Line_Item__r.WorkOrder.Case.status !=\'Completed\' AND Work_Order_Line_Item__r.WorkOrder.Case.status !=\'Closed\' AND Work_Order_Line_Item__r.WorkOrder.Case.status !=\'Active\' AND Work_Order_Line_Item__r.WorkOrder.Case.status != \'Closed - Issue Resolved Automatically\')AND (Work_Order_Line_Item__r.WorkOrder.Case.RecordTypeId =\'01234000000BnNjAAK\' OR Work_Order_Line_Item__r.WorkOrder.Case.RecordTypeId =\'012340000007kUMAAY\' OR Work_Order_Line_Item__r.WorkOrder.Case.RecordTypeId =\'012340000007kUHAAY\')'
        );
    }
    
    global void execute(Database.BatchableContext bc, List<Checklist__c> scope){
        Set<id> checkListIds = new Set<id>();
        for(Checklist__c  c:scope)
        {
            checkListIds.add(c.id);
        }
        
        Map<Id,Id> ContentDocumentIds = new Map<Id,Id>();
        for(ContentDocumentLink cdl:[Select id,ContentDocumentID,LinkedEntityId from ContentDocumentLink where LinkedEntityID IN: checkListIds])
        {
            ContentDocumentIds.put(cdl.ContentDocumentId,cdl.LinkedEntityId);
            debugString += cdl.id +'|'+cdl.ContentDocumentId+'|'+cdl.LinkedEntityId + '<br/>';
        }
        
        //for(ContentVersion cv:[Select id, Field_Image_URL__c,ContentDocumentId from ContentVersion where ContentDocumentID IN:ContentDocumentIds.keyset() AND Field_Image_URL__c!=null limit 200 ])
        /*
        ContentVersion[] cvs = [Select id,ContentDocumentId from ContentVersion where ContentDocumentID IN:ContentDocumentIds.keyset() AND IsLatest=true];

        Set<id> alreadyShared = new Set<id>();
        for(ContentDistribution cd:[SELECT ContentDocumentId, ContentVersionId, Id FROM ContentDistribution where ContentVersionId IN:cvs AND Name='PublicShare']){
            alreadyShared.add(cd.id);
        }
        system.debug('alreadyShared '+ alreadyShared);
        List<ContentDistribution> newCDList = new List<ContentDistribution>();
        for(ContentVersion cv:cvs){
           if(!alreadyShared.contains(cv.id)){
               ContentDistribution cdl = new ContentDistribution();
               cdl.ContentVersionId = cv.id;
               cdl.Name = 'PublicShare';
               newCDList.add(cdl) ;
            }
        }
        insert newCDList;


        for(ContentDistribution cd:[SELECT ContentDocumentId, DistributionPublicUrl,ContentDownloadUrl, Id FROM ContentDistribution where ContentDocumentId IN:ContentDocumentIds.keyset()])
        {
            //system.debug(cv.id +'|'+'|'+ContentDocumentIds.get(cv.ContentDocumentId)+'|'+cv.Field_Image_URL__c);
            //debugString += cv.id +'|'+ContentDocumentIds.get(cv.ContentDocumentId)+'|'+cv.Field_Image_URL__c + '<br/>';
            //debugString += cd.id +'|'+ContentDocumentIds.get(cd.ContentDocumentId)+'|'+cd.DistributionPublicUrl + '<br/>';
            debugString += cd.id +'|'+cd.ContentDocumentId+'|'+cd.DistributionPublicUrl + '<br/>';
        }
        */

    }    
    
    global void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'meagan.brumbelow@rackspace.com'}; 
        mail.setToAddresses(toAddresses);
        
        // Specify the name used as the display name.
        mail.setSenderDisplayName('MCB/Rackspace Checklist Debug');
        
        // Specify the subject line for your email address.
        mail.setSubject('Debug Results ' + system.now());
        mail.setBccSender(false);
        
        // Optionally append the salesforce.com email signature to the email.
        // The email address of the user executing the Apex Code will be used.
        mail.setUseSignature(false);
        
        // Specify the text content of the email.
        mail.setHtmlBody(debugString);
		system.debug(debugString);
        // Send the email you have created.
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }    

}