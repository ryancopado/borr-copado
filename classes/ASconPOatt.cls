public class ASconPOatt {
    
    private List<Attachment> att = new List<Attachment>();
    private List<Id> reqId = new List<Id>();
    private AcctSeedERP__Purchase_Order_Line__c po; 
    private List<ContentDocumentLink> files = new List<ContentDocumentLink>();
    
    public ASconPOatt(ApexPages.StandardController controller) {
        this.po = (AcctSeedERP__Purchase_Order_Line__c)controller.getRecord();
    }
    
    public List<Attachment> getAtts() {
      system.debug('Entering the method' );
        
        // Get all the construction requistion attachments associated with the purchase order line. If the construction
        // requisition is part of a group, get the attachments from the group, if not get the attachments from the 
        // construction requistion
        List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
        solList = [select Id, Con_Req_Group__c from AcctSeedERP__Sales_Order_Line__c where AcctSeedERP__Purchase_Order_Line__c = :po.Id];
        for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
            if (sol.Con_Req_Group__c != null) {
                reqId.add(sol.Con_Req_Group__c);
            } else {
                reqId.add(sol.Id);
            }
            
            system.debug('Req Id' +sol.Con_Req_Group__c);
        }
        
        att = [select Id, Name, OwnerId, CreatedDate from Attachment where ParentId in :reqId];    
        if (att.size() > 0) {
            return att;
        } else {
            return null;
        }
    }
    
    public List<ContentDocumentLink> getFiles() {
        
        // Get all the construction requistion attachments associated with the purchase order line. If the construction
        // requisition is part of a group, get the attachments from the group, if not get the attachments from the 
        // construction requistion
        List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
        solList = [select Id, Con_Req_Group__c from AcctSeedERP__Sales_Order_Line__c where AcctSeedERP__Purchase_Order_Line__c = :po.Id];
        if(solList.size()>0)
        {
        system.debug('salesorderlist' +solList); 
        for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
            if (sol.Con_Req_Group__c != null) {
                reqId.add(sol.Con_Req_Group__c);
            } else {
                reqId.add(sol.Id);
            }
        }
        system.debug('req id ' +reqId); 
       
        files  = [select ContentDocumentID, LinkedEntityId,ContentDocument.title,ContentDocument.OwnerId,ContentDocument.CreatedDate from ContentDocumentLink where LinkedEntityId in :reqId];    
       // if (files.size() > 0) {
            return files;
        //} 
        }
        
        
        else {
            return null;
        }
        
    }
}