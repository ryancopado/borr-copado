trigger conReqBeforeDelete on Con_Req__c (before delete) {

    /*//This entire trigger is used to figure out if the total of pending and approved requests is bigger than the budget on the budget line item.

    RecordType co = Utilities.getRecordType('Change Order');
    RecordType co_sub = Utilities.getRecordType('Subcontractor Change Order');

    //RecordType change = [select Id from RecordType where Name = 'Change Order'];
    //RecordType subchange = [select Id from RecordType where Name = 'Subcontractor Change Order'];

    Set<Id> bliIds = new Set<Id> {};
    Set<Id> conreqIds = new Set<Id> {};

    //build a list of line items so we can use it in the query below
    for ( Con_Req__c currentConReq : Trigger.old ) {
        if (currentConReq.Budget_Line_Item__c != null) {
            bliIds.add(currentConReq.Budget_Line_Item__c);
            conreqIds.add(currentConReq.Id);
        }
    }
    
    if (bliIds.size() > 0) {
        //get a map of BLIs
        Map <Id, Budget_Line_Item__c> lineItemsMap = new Map <Id, Budget_Line_Item__c>([
                                                                SELECT Id, Name, Project_Job_Number__c, Parent_Budget_Locked__c, 
                                                                    Sales_Budget__c, Active_Budget__c, PM_Initial_Projection__c , Pending_Request_Amount__c
                                                                FROM Budget_Line_Item__c
                                                                WHERE Id IN :bliIds ]);
                                                            
        List <Budget_Line_Item__c> lineItemsList = lineItemsMap.values();

        //reset this field - we are going to use it to keep a running total in the last loop
        for ( Budget_Line_Item__c tempLineItem : lineItemsList) {
            tempLineItem.Pending_Request_Amount__c = 0 ;
            System.debug(Logginglevel.ERROR, 'Line Item Name= ' + tempLineItem.Id );
        }
    
    
        System.debug(logginglevel.ERROR,'bli map= '+ lineItemsMap);

        // and a map of all siblings related to the trigger records                                                         
        List <Con_Req__c> allSiblingRequests = new List <Con_Req__c>{};
        allSiblingRequests =    [SELECT Amount_Requested__c, Id , Budget_Line_Item__c, Total_Cost_Tax__c
                                FROM Con_Req__c
                                WHERE Budget_Line_Item__c IN :bliIds 
                                        AND Id NOT IN :conreqIds
                                        AND Status__c != 'X - Rejected' 
                                        AND Status__c != 'Recalled' 
                                        AND RecordTypeId != :co.Id 
                                        AND RecordTypeId != :co_sub.Id ];
    

        System.debug(Logginglevel.ERROR, 'Number of siblings=' + allSiblingRequests.size() );
        Decimal amount = 0;

        //sum up all the amount requested values                        
        for (Integer i=0; i< allSiblingRequests.size(); i++ ) {
    
            Id bliId = allSiblingRequests[i].Budget_Line_Item__c;
            amount = 0;
    
            try {
                amount = allSiblingRequests[i].Total_Cost_Tax__c;
                if (amount == null)
                    amount = 0;
            }catch (Exception e){
                amount = 0;
            }


            Budget_Line_Item__c tempLineItem = lineItemsMap.get(bliId);
            tempLineItem.Pending_Request_Amount__c += amount;
        }

        //this is a before trigger, but it won't update any line items - so we do it manually.
        update lineItemsMap.values();
    }*/
}