public class ServicePO{
    private List<Attachment> Attachments= new List<Attachment>();
    private List<Id> reqId = new List<Id>();
    private Service_PO__c ServicePerchaseOrder; 
    public ServicePO(ApexPages.StandardController controller) {
        this.ServicePerchaseOrder= (Service_PO__c)controller.getRecord();
    }
    public List<Attachment> getAttachments() {
        Service_Construction_Requisition__c[] req = [select Id from Service_Construction_Requisition__c where Service_Purchase_Order__c= :ServicePerchaseOrder.Id];
        for (Integer m = 0; m <req.size(); m++) {
            reqId.add(req[m].Id);
        }
        Attachments= [select Id, Name, OwnerId, CreatedDate from Attachment where ParentId in :reqId];    
        if(Attachments.size() > 0) {
            return Attachments;
        } else {
            return null;
        }
    }
    
}