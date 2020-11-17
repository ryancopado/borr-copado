public class PricingToolApproval_ApprovalCTL {
	
	// Controller for the approval process approval page for object Pricing Tool Approval
	
	public Pricing_Tool_Approval__c ptaRecord {get; set;}
	public String Comment {get; set;}
	public Boolean isDOApproval {get; set;}
	Id ptaRecordId;
	ProcessInstanceWorkItem PIWI;
    List<ProcessInstanceWorkItem> workItemList = new List<ProcessInstanceWorkItem>();
    Id targetId;
    
    public PricingToolApproval_ApprovalCTL() {
    	
    	List<User> userActor = new List<User>();
    	
    	// Get the Pricing Tool Approval record and current approval process work item
    	ptaRecordId = ApexPages.currentPage().getParameters().get('ptaId');
    	ptaRecord = [select Id, Name, Applications_Engineer__c, Status__c, Pricing_Differences__c, Opportunity__r.AccountId 
    				from Pricing_Tool_Approval__c where Id =: ptaRecordId];
    	workItemList = [select Id, ProcessInstance.TargetObjectId, ProcessInstanceId, OriginalActorId, ActorId 
					from ProcessInstanceWorkitem where Id =: ApexPages.currentPage().getParameters().get('id')];
        
		isDOApproval = false;
		if (!workItemList.isEmpty()) {
            PIWI = workItemList[0];
            targetId = PIWI.ProcessInstance.TargetObjectId;
			userActor = [select Id, Name, Profile.Name from User where Id =: PIWI.ActorId];
			
			// Set approver type flag
			if (userActor[0].Profile.Name == 'Borrego-Dir of Ops') {
				isDOApproval = true;
			}
        }
    }
        
	public Pagereference cancel() {
		return goBack();
	}

	private Pagereference goBack() {
		Pagereference pr = new Pagereference('/' + targetId);
		pr.SetRedirect(true);
		return pr;
	}
	
	public PageReference reject() {
		Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
		objReq.setAction('Reject');
		objReq.setComments(Comment);
		objReq.setWorkitemId(PIWI.Id);
		objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
		Approval.ProcessResult result2 =  Approval.process(objReq);               
		return goBack();
	}
    
    public PageReference approve() {           
		doApprove();       
		return goBack();
	}
	
	public PageReference preliminaryApproval() {
		doApprove();
		if (ptaRecord != null) {
			ptaRecord.Status__c ='Preliminary Approval';
		}
		update ptaRecord;
		sendAEMail();
		return goBack();
	}
	
	public PageReference finalApproval() {
		
		doApprove();
		if (ptaRecord != null) {
			ptaRecord.Status__c ='Final Approval';
		}
		update ptaRecord;
		ptaRecord = [select Id, Name, Applications_Engineer__c, Status__c, Pricing_Differences__c, Opportunity__r.AccountId 
						from Pricing_Tool_Approval__c where Id =: ptaRecordId];
		if (ptaRecord.Pricing_Differences__c >= 1 || ptaRecord.Pricing_Differences__c <= -1) {
			sendAEMail();
		}
		return goBack();
	}
	
	public void doApprove() {
		Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
		objReq.setAction('Approve');
		objReq.setComments(Comment);
		objReq.setWorkitemId(PIWI.ID);
		objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
		Approval.ProcessResult result2 =  Approval.process(objReq);   
	}
	
	private void sendAEMail() {
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		List<User> appEngineer = new List<User>();
		List<String> emailTo = new List<String>();
		List<Contact> conList = new List<Contact>();
		List<Contact> conTempList = new List<Contact>();
		Id conId;
		
		// Send an email alert to the AE listed on the Pricing Tool Approval record
		try {
			system.debug('*****pta Application Engineer = ' + ptaRecord.Applications_Engineer__c);
			if (ptaRecord.Applications_Engineer__c != null) {
				appEngineer = [select Id, Name, IsActive, Email from User where Name =: ptaRecord.Applications_Engineer__c limit 1];
				if (!appEngineer.isEmpty()) {
					system.debug('*****User AE Name/Email = ' + appEngineer[0].Name + '/' + appEngineer[0].Email);
					
					// Get or create Contact record with AE email address so that we can use the email template
					conList = [select Id, Name, Email from Contact where Email =: appEngineer[0].Email];
					if (conList.isEmpty()) {
						// Create temporary Contact record with AE email address
						Contact con = new Contact();
						con.LastName = appEngineer[0].Name;
						con.Email = appEngineer[0].Email;
						con.AccountId = ptaRecord.Opportunity__r.AccountId;
						con.Title = 'Borrego Solar Application Engineer';
						con.Phone = '555-555-5555';
						conTempList.add(con);
						insert conTempList;
						conId = conTempList[0].Id;
					} else {
						conId = conList[0].Id;
					}
					
					mail.setTargetObjectId(conId);
					emailTo.add(appEngineer[0].Email);
					mail.setToAddresses(emailTo);
					mail.setwhatid(ptaRecord.Id);
					EmailTemplate etemplate = [select Id, Name, Subject, Body from EmailTemplate where Name =: 'Pricing Tool Approval - Prod Model'];
					mail.setTemplateId(etemplate.Id);
					mail.setSaveAsActivity(false);
					
					Messaging.sendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
					if (results.size() > 0) {
						for (Messaging.sendEmailResult result : results) {
							if (!result.isSuccess()) {
								Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, result.getErrors().get(0).getMessage()));
							}
						}
					}
				}
			}
		} catch (exception ex) {
			Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, 'Could not send email - exception = ' + ex));
		}
		if (!conTempList.isEmpty()) {
			delete conTempList;
		}
	}
}