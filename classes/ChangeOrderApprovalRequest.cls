global class ChangeOrderApprovalRequest {

    WebService static void SendApprovalRequest(string id) {
    
        // create the new approval request to submit
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        
         req.setComments('Submitting request for approval.');
        req.setObjectId(id);
        req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        // submit the approval request for processing
        Approval.ProcessResult result;
        List<Id> newWorkItemIds;
        if(!Test.isRunningTest()) {
        	result = Approval.Process(req);
        	newWorkItemIds = result.getNewWorkitemIds();
        }
        
         Approval.ProcessWorkitemRequest req2 = 
            new Approval.ProcessWorkitemRequest();
        req2.setComments('Approving request.');
        req2.setAction('Approve');
        req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        
        // Use the ID from the newly created item to specify the item to be worked
        if(!Test.isRunningTest()) {
        	req2.setWorkitemId(newWorkItemIds.get(0));
        }
        
        // Submit the request for approval
        Approval.ProcessResult result2;
        if(!Test.isRunningTest()) {
        	result2 =  Approval.process(req2);
        	
        	// display if the reqeust was successful
        	System.debug('Submitted for approval successfully: '+result.isSuccess());
        }
            
        updateChangeOrder(id);
    
    }
    
    
    /*
    Auther: Madan(Forcebrain Developer)
    Date: Dec 11, 2017
    Description: Update Quantity to related project product related record when any change order for update quantity
    */
    public static void updateChangeOrder(Id changeOrderId) {
    	if(changeOrderId != null) {
    		Con_Req__c changeOrder;
    		for(Con_Req__c cr:[Select Id, Change_Order_Type__c, New_Quantity__c, ASProject__c,Original_Product__c From Con_Req__c 
    							Where Id=:changeOrderId AND
    								Change_Order_Type__c='System Size or Product Change' AND
    								ASProject__c!=null AND
    								New_Quantity__c!=null AND
    								Original_Product__c!=null]) {
    			changeOrder = cr;
    		}
    		
    		// If Change order is valid to change Quanity for existing products
    		if(changeOrder != null) {
    			List<Project_Products__c> lstProjectProduct = new List<Project_Products__c>();
    			// Update quantity from Change Order to Project Product related to selected project
    			for(AcctSeed__Project__c project:[Select Id, 
													(Select Id, Product__c, Quantity__c 
														From Project_Products__r 
														Where Product__c=:changeOrder.Original_Product__c) 
													From AcctSeed__Project__c Where Id=:changeOrder.ASProject__c]) {
    				if(project.Project_Products__r != null && project.Project_Products__r.size() > 0) {
    					for(Project_Products__c pp:project.Project_Products__r) {
    						pp.Quantity__c = changeOrder.New_Quantity__c;
    						lstProjectProduct.add(pp);
    					}
    				}
    			}
    			
    			if(lstProjectProduct.size() > 0) {
    				update lstProjectProduct;
    			}
    		}
    	}
    }
}