trigger ContentLinkConreqgroup1 on ContentDocumentLink (after delete, after insert,before insert) {

    
    system.debug('Look HERE This is the trigger for uploading files');
    // Record that an attachment as been made to Conreq and Requsition form.
    //This Trigger is used to count the number of files attached in three objects con req,sales order line and case.
     
    Schema.SObjectType token;
    Schema.DescribeSObjectResult dr;
    List<Id> solIds = new List<Id>();
    List<Id> PrIds = new List<Id>();
    List<Id> csIds= new List<Id>();
    List<Id> chkIds = new List<Id>();
    List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
    List<AcctSeedERP__Sales_Order_Line__c> solUpdate = new List<AcctSeedERP__Sales_Order_Line__c>();
    List<Id> crgIds = new List<Id>();
    List<Con_Req_Group__c> crgList = new List<Con_Req_Group__c>();
    List<Con_Req_Group__c> crgUpdate = new List<Con_Req_Group__c>();
    List<SFDC_Purchase_Requisition__c> PrList = new List<SFDC_Purchase_Requisition__c>();
    List<SFDC_Purchase_Requisition__c> PrUpdate = new List<SFDC_Purchase_Requisition__c>();
    List<Checklist__c> chklstUpdate = new List<Checklist__c>();
    List<Case> csList=new List<Case>();
    List<Case> csUpdate=new List<Case>();
    List<ContentDocumentLink> contentList;
    List<ContentDocumentLink> contentList1;
     List<Attachment> attList;
    Map<Id, Attachment> attMap;
    Map<ID, ContentDocumentLink> contentMap;
    
     if (trigger.isInsert) {
    
        // Find all the Attachments associated with a Con Req Group/Requisition form
        for (ContentDocumentLink content : trigger.new) {
        
            token = content.LinkedEntityId.getSObjectType();
            dr = token.getDescribe();
            system.debug('Look Here for OBJECT' +dr.getName() );
                        
            if (dr.getName() == 'SFDC_Purchase_Requisition__c') {
                PrIds.add(content.LinkedEntityId);
            }
            
            if (dr.getName() == 'Con_Req_Group__c') {
                crgIds.add(content.LinkedEntityId);
            }
            if (dr.getName() == 'Case') {
                csIds.add(content.LinkedEntityId);
            }
            
        }
        
          if (!PrIds.isEmpty()) {
            
            // Get the list of associated Requisition form records
            PrList = [select Id, Number_of_Attachments__c from SFDC_Purchase_Requisition__c where Id in: PrIds];
            for (SFDC_Purchase_Requisition__c Pr: PrList) {
                if (Pr.Number_of_Attachments__c!= 1) {
                    Pr.Number_of_Attachments__c = 1;
                    PrUpdate.add(Pr);
                }
            }
            if (!PrUpdate.isEmpty()) {
                update PrUpdate;
            }
        }
        
        if (!crgIds.isEmpty()) {
            
            // Get the list of associated  Con Req Group records
            crgList = [select Id, isAttachment__c from Con_Req_Group__c where Id in: crgIds];
            for (Con_Req_Group__c crg : crgList) {
                if (crg.isAttachment__c != true) {
                    crg.isAttachment__c = true;
                    crgUpdate.add(crg);
                }
            }
            if (!crgUpdate.isEmpty()) {
                update crgUpdate;
            }
        }
        
        if (!csIds.isEmpty()) {
            
            // Get the list of associated  Con Req Group records
            csList= [select Id, Number_of_Attachments__c from Case where Id in: csIds];
            for (Case ca: csList) {
                if (ca.Number_of_Attachments__c != 1) {
                    ca.Number_of_Attachments__c = 1;
                    csUpdate.add(ca);
                }
            }
            if (!csUpdate.isEmpty()) {
                update csUpdate;
            }
        }
        
       
         
    }
   
 ////// this is code starting for file sharing settings in checklist object
 
/*if(trigger.isbefore){
 system.debug('this is after trigger');
 
  for (ContentDocumentLink content : trigger.new) {
         if (dr.getName() == 'Checklist__c'){
                chkIds.add(content.LinkedEntityId); 
               }
            

 if (!chkIds.isEmpty()) {
           contentList = new List<ContentDocumentLink>();
           contentList1 = new List<ContentDocumentLink>();
           contentList = [SELECT ContentDocumentId, LinkedEntityId, Visibility, ShareType FROM ContentDocumentLink where LinkedEntityId in: chkIds];
           for (ContentDocumentLink cntlink :contentList ){
           
               cntlink.ShareType = 'C';
               contentList1.add(cntlink);
                
           
           }
           
           /*if(!contentList1 .isEmpty()) {
             //update contentList1 ;
               //insert contentList1 ;
           
           }
         
         }
 
 
 }
 }*/
 
 //////////////   
     if (trigger.isDelete) {
     
     system.debug('this is the delete trigger');
        
        // Find all the Attachments associated with a Requisition form and/or a Con Req Group
        for (ContentDocumentLink content : trigger.old) {
            token = content.LinkedEntityId.getSObjectType();
            dr = token.getDescribe();
        
            if (dr.getName() == 'SFDC_Purchase_Requisition__c') {
                PrIds.add(content.LinkedEntityId);
            }
            if (dr.getName() == 'Con_Req_Group__c') {
                crgIds.add(content.LinkedEntityId);
            }
            if (dr.getName() == 'Case') {
                csIds.add(content.LinkedEntityId);
            }
        }
     
     
      if (!PrIds.isEmpty()) {
            
            // Get the list of associated requsition form records and their list of remaining attachments 
            contentList = new List<ContentDocumentLink>();
            PrList = [select Id, Number_of_Attachments__c from SFDC_Purchase_Requisition__c where Id in: PrIds];
            contentList = [select ContentDocumentID, LinkedEntityId from ContentDocumentLink where LinkedEntityId in: PrIds];
            contentMap = new Map<ID, ContentDocumentLink>();
            if (!contentList.isEmpty()) {
                for (ContentDocumentLink content : contentList) {
                    if (!contentMap.containsKey(content.LinkedEntityId)) {
                        contentMap.put(content.LinkedEntityId, content);
                    }
                }
            }
            
       /*    attList = [select Id, ParentId from Attachment where ParentId in: PrIds];
             attMap = new Map<Id, Attachment>();
             if (!attList.isEmpty()) {
                for (Attachment att : attList) {
                    if (!attMap.containsKey(att.ParentId)) {
                        attMap.put(att.ParentId, att);
                    }
                }
            } */
        
         // Set the attachment flag false if no more attachments on each associate Sales Order Line
            for (SFDC_Purchase_Requisition__c Pr: PrList) {
                if (!contentMap.containsKey(Pr.Id)) //&& !attMap.containsKey(Pr.Id)) 
                {
                    Pr.Number_of_Attachments__c = 0;        // Sales Order Line has no more attachments
                    PrUpdate.add(Pr);
                }
                
            }
            if (!PrUpdate.isEmpty()) {
                update PrUpdate;
            }
        }  
      
       if (!crgIds.isEmpty()) {
            
            // Get the list of associated Con Req Group records and their list of remaining attachments 
            contentList = new List<ContentDocumentLink>();
            crgList = [select Id, isAttachment__c from Con_Req_Group__c where Id in: crgIds];
            contentList = [select ContentDocumentID, LinkedEntityId from ContentDocumentLink where LinkedEntityId in: crgIds];
            contentMap = new Map<Id, ContentDocumentLink>();
            if (!contentList.isEmpty()) {
                for (ContentDocumentLink content: contentList) {
                    if (!contentMap.containsKey(content.LinkedEntityId )) {
                        contentMap.put(content.LinkedEntityId, content);
                    }
                }
            }
            
            // Set the attachment flag false if no more attachments on each associated Con Req Group
            for (Con_Req_Group__c crg : crgList) {
                if (!contentMap.containsKey(crg.Id)) {
                    crg.isAttachment__c = false;        // Con Req Group has no more attachments
                    crgUpdate.add(crg);
                }
            }
            if (!crgUpdate.isEmpty()) {
                update crgUpdate;
            }
        }
        
      /*  if (!csIds.isEmpty()) {
            
            // Get the list of associated Con Req Group records and their list of remaining attachments 
            contentList = new List<ContentDocumentLink>();
            csList= [select Id, Number_of_Attachments__c from case where Id in: csIds];
            contentList = [select ContentDocumentID, LinkedEntityId from ContentDocumentLink where LinkedEntityId in: csIds];
            contentMap = new Map<Id, ContentDocumentLink>();
            if (!contentList.isEmpty()) {
                for (ContentDocumentLink content: contentList) {
                    if (!contentMap.containsKey(content.LinkedEntityId )) {
                        contentMap.put(content.LinkedEntityId, content);
                    }
                }
            }
            
            // Set the attachment flag false if no more attachments on each associated Con Req Group
            for (Case ca : csList) {
                if (!contentMap.containsKey(ca.Id)) {
                    ca.Number_of_Attachments__c= 0; // Case has no more attachments
                  system.debug('number of attachments' +ca.Number_of_Attachments__c);
                    csUpdate.add(ca);
                }
            }
            if (!csUpdate.isEmpty()) {
                update csUpdate;
            }
        }*/
        
        
    }
    
    
}