public class contractReq {
    private List<Con_Req__c> reqs = new List<Con_Req__c>();
    private List<Id> svId = new List<Id>();
    private Contract cntract; 
    public contractReq(ApexPages.StandardController controller) {
        this.cntract= (Contract)controller.getRecord();
    }
    public List<Con_Req__c> getReqs() {
        SV__c[] svs = [select Id from SV__c where Contract__c = :cntract.Id];
        for (Integer m = 0; m <svs.size(); m++) {
        	svId.add(svs[m].Id);
        }
        reqs = [select Id, Name, Status__c, Total_Cost_Tax__c, Project_PM__c, Service_Visit__c, RecordTypeId from Con_Req__c where Service_Visit__c in :svId];    
        if(reqs.size() > 0) {
        	return reqs;
        } else {
        	return null;
        }
    }
    public static testMethod void contractTest(){
    
    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
    								 Project_End_Date__c = null, ShippingCity = 'Park City'); insert acc;
 	Contract c = new Contract(AccountId = acc.Id); insert c;
 	SV__c sv = new SV__c(Contract__c = c.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;
    Con_Req__c req = new Con_Req__c(Service_Visit__c = sv.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Unit_Price__c = 30); insert req;
    
    PageReference pageRef = Page.contractReq;
	    Test.setCurrentPage(pageRef);
	    
	    //Set Page Parameters
	    ApexPages.StandardController con = new ApexPages.StandardController(new Contract());
	    contractReq ext = new contractReq(con);
	    
	    ApexPages.currentPage().getParameters().put('id', c.Id);
	    ext = new contractReq(con);  
	    //Call all methods on New page 
			ext.getReqs();  
    }
}