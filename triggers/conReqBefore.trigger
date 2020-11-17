trigger conReqBefore on Con_Req__c (before insert, before update ) {


	Set<Id> projectIds = new Set<Id> {}; 
	for(Con_Req__c conReq:trigger.new){
		if(conReq.ASProject__c != null){
			projectIds.add(conReq.ASProject__c);
		}
	}


	Map<Id,AcctSeed__Project__c> projectsMap = new Map<Id,AcctSeed__Project__c>([select id,OwnerId from AcctSeed__Project__c where id in: projectIds]);


	

	for(Con_Req__c conReq:trigger.new){
		
		if(conReq.ASProject__c != null && projectsMap.containsKey(conReq.ASProject__c) ){
			conReq.Project_PM__c = projectsMap.get(conReq.ASProject__c).OwnerId;
		}
		
		
	}



  /*  if (Trigger.isUpdate==true && Trigger.New.size()==1){
    
        Con_Req__c ConReq=[Select ID,IsSubmitted__c,Vendor_Account__c,Vendor_Account__r.Type 
                            , Vendor_Account__r.RecordTypeId, Vendor_Account__r.RecordType.Name 
                            from Con_Req__c where id=:Trigger.new[0].ID];
        
        //if (ConReq.IsSubmitted__c==true && ConReq.Vendor_Account__r.Type !='Business'){
        //if (Trigger.New[0].IsSubmitted__c==true && ConReq.Vendor_Account__r.Type !='Business'){
        if (Trigger.New[0].IsSubmitted__c==true 
                    && ConReq.Vendor_Account__c!=null 
                    && ConReq.Vendor_Account__r.RecordTypeId !=null 
                    && ConReq.Vendor_Account__r.RecordType.Name !='Business'){  
                          
            //ConReq.IsSubmitted__c =false;
            //Update ConReq;
            Trigger.New[0].AddError('Subcontractor Vendor Accounts must be Type "Business"');
            
        }       
        else
            Trigger.New[0].IsSubmitted__c=false;
    }

    if (TestMethods.runConReqBeforeTrigger){
    
    RecordType co = Utilities.getRecordType('Change Order');
    RecordType co_sub = Utilities.getRecordType('Subcontractor Change Order');
    
    System.debug(Logginglevel.ERROR, 'Caspar trigger ');


    Set<Id> bliIds = new Set<Id> {}; 
    Set<Id> conreqIds = new Set<Id> {};

    //build a list of line items so we can use it in the query below
    for ( Con_Req__c currentConReq : Trigger.new ) {
        bliIds.add(currentConReq.Budget_Line_Item__c);
        conreqIds.add(currentConReq.Id);
    }
    //get a map of BLIs
    Map <Id, Budget_Line_Item__c> lineItemsMap = new Map <Id, Budget_Line_Item__c>([
                                                                SELECT Id, Name, Project_Job_Number__c, Parent_Budget_Locked__c, Approved_Sub_Change_Order_Amount__c,
                                                                    Sales_Budget__c, Active_Budget__c, PM_Initial_Projection__c , Pending_Request_Amount__c
                                                                FROM Budget_Line_Item__c
                                                                WHERE Id IN :bliIds ]);
                                                            
    List <Budget_Line_Item__c> lineItemsList = lineItemsMap.values();

    //reset this field - we are going to use it to keep a running total in the last loop
    for ( Budget_Line_Item__c tempLineItem : lineItemsList) {
        tempLineItem.Pending_Request_Amount__c = 0 ;
        tempLineItem.Approved_Sub_Change_Order_Amount__c = 0;
        System.debug(Logginglevel.ERROR, 'Line Item Name= ' + tempLineItem.Id );
    }
    
    System.debug(logginglevel.ERROR,'bli map= '+ lineItemsMap);

    // and a map of all siblings related to the trigger records 
    //sort the list by Id(name) ascending, so we can calc "prior change order amounts"                                                      
    List <Con_Req__c> siblingRequests = new List <Con_Req__c>{};

    siblingRequests =   [SELECT Amount_Requested__c, Id, Budget_Line_Item__c, Total_Cost_Tax__c, Name,Project_Manager_Budget_Check__c ,
                                Submit_Errors__c, RecordTypeId, Status__c, Purchase_Order__c , Cost_Code__c
                                FROM Con_Req__c
                                WHERE Budget_Line_Item__c IN :bliIds 
                                AND Id NOT IN :conreqIds
                                AND RecordTypeId != :co.Id
                                ORDER BY Name ASC
                                // 2009-12-28 jsmall@soliantconsulting.com temp limit test
                                //LIMIT 1];
                                ];
    
                                        

    

    for (Integer i = 0 ; i<Trigger.size ; i++) {
        if ( Trigger.new[i].RecordTypeId != co.Id){
            siblingRequests.add(Trigger.new[i]);
        }
    }

    
    Decimal amount = 0;
    Map<Id, Decimal> rollingTotalMap = new Map<Id, Decimal>();
    
    //sum up all the amount requested values for a bli                  
    for (Integer i=0; i< siblingRequests.size(); i++ ) {
        Con_Req__c currentRequest;
        Budget_Line_Item__c currentLineItem;
        try {
            currentRequest = siblingRequests[i];
            Id bliId = currentRequest.Budget_Line_Item__c;
            currentLineItem = lineItemsMap.get(bliId);
        }catch (Exception e){
            System.debug(Logginglevel.ERROR, 'CASPAR exception firing' + e);
            continue;
        }
        
        /*if (currentRequest.RecordTypeId == co.Id) {
            continue; 
        }
        
        System.debug(Logginglevel.ERROR, 'CASPAR current request= ' + currentRequest);
        
        if ((currentRequest.Status__c ==  'X - Rejected' || currentRequest.Status__c ==  'Recalled' ) && 
            currentRequest.RecordTypeId == co_sub.Id ) {

            if (currentLineItem.Approved_Sub_Change_Order_Amount__c >= currentRequest.Amount_Requested__c ){
                currentLineItem.Approved_Sub_Change_Order_Amount__c -= currentRequest.Amount_Requested__c;
            }
            System.debug(Logginglevel.ERROR, 'CASPAR rejection fired!. Approved amt is: ' +  currentLineItem.Approved_Sub_Change_Order_Amount__c);

            continue;
        }
        
        
        
        if (currentRequest.RecordTypeId == co_sub.Id) {
/*      
            if (Trigger.isInsert) {
                if (rollingTotalMap.containsKey(currentRequest.Budget_Line_Item__c)){
    
                    currentRequest.Prior_Sub_Change_Orders__c = rollingTotalMap.get(currentRequest.Budget_Line_Item__c);
                    
                    //update the total AFTER assigning - it represents the sum of PRIOR orders.
                    //note the coplexity here - it only occurs as we need to account for more than request
                    rollingTotalMap.put(currentRequest.Budget_Line_Item__c,currentRequest.Prior_Sub_Change_Orders__c + currentRequest.Amount_Requested__c );
                }
                else {
                    currentRequest.Prior_Sub_Change_Orders__c = 0;
                    rollingTotalMap.put(currentRequest.Budget_Line_Item__c,currentRequest.Amount_Requested__c );
                }
            }

            
            if ( currentRequest.Status__c ==  'Approved' ) {
                if ( currentLineItem.Approved_Sub_Change_Order_Amount__c == null){
                    currentLineItem.Approved_Sub_Change_Order_Amount__c = 0;
                }
                currentRequest.Prior_Sub_CO_Frozen__c = currentLineItem.Approved_Sub_Change_Order_Amount__c;
                currentLineItem.Approved_Sub_Change_Order_Amount__c += currentRequest.Amount_Requested__c;
                System.debug(Logginglevel.ERROR, 'CASPAR apprroval fired!. Approved amt is: ' +  currentLineItem.Approved_Sub_Change_Order_Amount__c);
            }
            
            continue;
        }

        //this section is for normal requests, not change orders

        try {
            amount = currentRequest.Total_Cost_Tax__c;
            if (amount == null){
                amount = 0;
            }
            if ( currentLineItem.Pending_Request_Amount__c == null) {
                currentLineItem.Pending_Request_Amount__c = 0;
            }
            if ( (currentRequest.Status__c != 'X - Rejected') && (currentRequest.Status__c !=  'Recalled') ) {
                currentLineItem.Pending_Request_Amount__c += amount;
            }   
        }catch (Exception e) {
            // do nothing
        }
        

    }
                                                        
                                                                                                            
    //we then loop and sum the Amount_Requested totals to see if they are bigger than the total budge for the line item.
    //if bigger, we add an error to the trigger and we are done.    
    //Budget_Line_Item__c currentLineItem;
    //Decimal totalBudget = 0.00;


    //this is a before trigger, but it won't update any line items - so we do it manually.
    update lineItemsMap.values();

    }*/
}