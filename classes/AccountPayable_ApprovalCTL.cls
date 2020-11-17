public with sharing class AccountPayable_ApprovalCTL {

	// Controller for the approval process approval page for object Account Payable
	
	public AcctSeed__Account_Payable__c apRecord {get; set;}
	public AcctSeedERP__Purchase_Order__c poRecord {get; set;}
	public String Comment {get; set;}
	public Boolean isPO {get; set;}
	Id apRecordId;
	ProcessInstanceWorkItem PIWI;
    List<ProcessInstanceWorkItem> workItemList = new List<ProcessInstanceWorkItem>();
    Id targetId;
    Boolean finalInvoice;
    
    public AccountPayable_ApprovalCTL() {
    	
    	// Get the Account Payable record and current approval process work item
    	apRecordId = ApexPages.currentPage().getParameters().get('apId');
    	apRecord = [select Id, Name, Owner.Name, AcctSeed__Vendor__c, Invoice_Amount__c, Final_Invoice__c, NTE_PO__c, Purchase_Order__c,AcctSeed__Type__c  
    				from AcctSeed__Account_Payable__c where Id = :apRecordId];
    	finalInvoice = apRecord.Final_Invoice__c;	// Current value of Final Invoice field - so we can later determine if the user has changed it
    	
    	if (apRecord.Purchase_Order__c != null) {
    		poRecord = [select Id, PO_Total__c, AP_Invoice_Line_Total_CO_POL__c from AcctSeedERP__Purchase_Order__c where Id = :apRecord.Purchase_Order__c];
    		isPO = true;
    	} else {
    		isPO = false;
    	}
    	workItemList = [select Id, ProcessInstance.TargetObjectId, ProcessInstanceId, OriginalActorId, ActorId 
					from ProcessInstanceWorkitem where Id = :ApexPages.currentPage().getParameters().get('id')];
        
		if (!workItemList.isEmpty()) {
            PIWI = workItemList[0];
            targetId = PIWI.ProcessInstance.TargetObjectId;
        }
    }
    
    private Pagereference goBack() {
		Pagereference pr = new Pagereference('/' + targetId);
		pr.SetRedirect(true);
		return pr;
	}
	
	public void doApprove() {
		Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
		objReq.setAction('Approve');
		objReq.setComments(Comment);
		objReq.setWorkitemId(PIWI.ID);
		objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
		Approval.ProcessResult result2 =  Approval.process(objReq);   
	}
        
	public Pagereference cancel() {
		return goBack();
	}
	
	public PageReference reject() {
		if(String.isEmpty(comment)) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please provide reject reason in Comments Box!'));
			
			return null;
		}
		
		Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
		objReq.setAction('Reject');
		objReq.setComments(Comment);
		objReq.setWorkitemId(PIWI.Id);
		objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
		Approval.ProcessResult result2 =  Approval.process(objReq);               
		return goBack();
	}
    
    public PageReference approve() {           
		
		// Update the AP Invoice if the Final Invoice field has changed
		if (finalInvoice != apRecord.Final_Invoice__c) {
			update apRecord;
		}
		doApprove();
		return goBack();
	}
}