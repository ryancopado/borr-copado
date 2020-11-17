global class ASRecallReq {
    webService static void ASRecallReq(Id[] reqId){
        AcctSeedERP__Sales_Order_Line__c requisition = [select Id, AcctSeedERP__Purchase_Order_Line__c,Status__c from AcctSeedERP__Sales_Order_Line__c where Id in :reqId];      
        List<AcctSeedERP__Purchase_Order_Line__c> ListOfConPO = [select Id,AcctSeedERP__Unit_Price__c from AcctSeedERP__Purchase_Order_Line__c where Id = :requisition.AcctSeedERP__Purchase_Order_Line__c];
        
        If(ListOfConPO!=null && ListOfConPO.size()>0){
            ListOfConPO[0].AcctSeedERP__Unit_Price__c = 0;    
            update ListOfConPO[0];
        }

        requisition.Status__c = 'Recalled'; 
        update requisition;
    }
    
    webService static String ASRecallReqNew(Id reqId) {
    	
    	// Attempt to recall an already approved Contstruction Requisition.  Only allow the recall to happen if the Construction Requisition has
    	// an associated Purchase Order Line whose Purchase Order has a Status field that is either Cancelled or Rejected.
    	AcctSeedERP__Sales_Order_Line__c conreq = new AcctSeedERP__Sales_Order_Line__c();
    	List<AcctSeedERP__Purchase_Order_Line__c> polList = new List<AcctSeedERP__Purchase_Order_Line__c>();
    	AcctSeedERP__Purchase_Order__c po = new AcctSeedERP__Purchase_Order__c();
    	
    	conreq = [SELECT Id, AcctSeedERP__Purchase_Order_Line__c, Status__c, Approval_Status__c FROM AcctSeedERP__Sales_Order_Line__c WHERE Id =: reqId];
    	if (conreq != NULL) {
    		if (conreq.AcctSeedERP__Purchase_Order_Line__c != NULL) {
    			polList = [SELECT Id, AcctSeedERP__Unit_Price__c, Construction_Req__c, AcctSeedERP__Purchase_Order__c FROM AcctSeedERP__Purchase_Order_Line__c 
    							WHERE Id =: conreq.AcctSeedERP__Purchase_Order_Line__c OR Construction_Req__c =: conreq.Id];
    			if (polList.size() > 0) {
    				po = [SELECT Id, AcctSeedERP__Status__c FROM AcctSeedERP__Purchase_Order__c WHERE Id =: polList[0].AcctSeedERP__Purchase_Order__c];
    				if (po.AcctSeedERP__Status__c == 'Cancelled' || po.AcctSeedERP__Status__c == 'Rejected') {
    					for(AcctSeedERP__Purchase_Order_Line__c pol : polList) {
    						pol.AcctSeedERP__Unit_Price__c = 0;
    					}
    					update polList;
    					conreq.Status__c = 'Recalled';
    					conreq.Approval_Status__c = 'Recalled';
    					update conreq;
    				} else {
    					// Error - can't recall a Construction Requisition associated with a PO that is not Cancelled or Rejected
    					return('POerror');
    				}
    			} else {
    				// Error - can't recall a Construction Requisition that does not have a Purchase Order Line
    				return('POLerror');
    			}
    		} else {
    			// Error - can't recall a Construction Requisition that does not have a Purchase Order Line
    			return('POLerror');
    		}
    	} else {
    		// Error - no Construction Requisition provided
    		return('ConReqError');
    	}
    	return('Success');
    }
}