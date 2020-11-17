public class conPOatt {
    private List<Attachment> att = new List<Attachment>();
    private List<Id> reqId = new List<Id>();
    private Con_PO__c po; 
    public conPOatt(ApexPages.StandardController controller) {
        this.po= (Con_PO__c)controller.getRecord();
    }
    public List<Attachment> getAtts() {
        Con_Req__c[] req = [select Id from Con_Req__c where Purchase_Order__c = :po.Id];
        for (Integer m = 0; m <req.size(); m++) {
            reqId.add(req[m].Id);
        }
        att = [select Id, Name, OwnerId, CreatedDate from Attachment where ParentId in :reqId];    
        if(att.size() > 0) {
            return att;
        } else {
            return null;
        }
    }
    public static testMethod void poTest(){
    
    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert acc;
    AcctSeed__Project__c p = ProjectTest.setupTestProj();
    Con_PO__c po = new Con_PO__c(); insert po;
//    Con_Req__c req = new Con_Req__c(Project__c = p.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Unit_Price__c = 30, 
//                                    Purchase_Order__c = po.Id); insert req;
    
    Con_Req__c req = new Con_Req__c(ASProject__c = p.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Unit_Price__c = 30); 
    insert req;
    
    PageReference pageRef = Page.poAtt;
        Test.setCurrentPage(pageRef);
        
        //Set Page Parameters
        ApexPages.StandardController con = new ApexPages.StandardController(new Con_PO__c());
        conPOatt ext = new conPOatt(con);
        
        ApexPages.currentPage().getParameters().put('id', po.Id);
        ext = new conPOatt(con);  
        //Call all methods on New page 
            ext.getAtts();  
    } 
}