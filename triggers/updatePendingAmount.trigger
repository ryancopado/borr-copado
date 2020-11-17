trigger updatePendingAmount on Con_Req__c (after insert,after update) {
     If(approveELI.IsRecursiveUpdate==Null)
        approveELI.IsRecursiveUpdate=False;
system.debug('*****approveELI.IsRecursiveUpdate'+approveELI.IsRecursiveUpdate);
    //If(approveELI.IsRecursiveUpdate==False){
        
        
            List<RecordType> rts = [select id from RecordType where Name = 'Customer Change Order' and SobjectType = 'con_req__c'];
            
            String CustomerRtId = '';
            
            if(!rts.isEmpty()){
                CustomerRtId=rts[0].id;
            }
            
        
            Map<Id,Con_Req__c> MapOfConReq=new Map<Id,Con_Req__c>(
                                [Select status__c, ASProject__c, Current_Change_Order_Subtotal__c ,
                                Final_Change_Order_Amount__c ,ASProject__r.AcctSeed__Opportunity__c,recordtypeid
                                    from Con_Req__c 
                                    where id = :Trigger.new]);
        
         
            List<Id> ListOfOpportunityIds=new List<Id>();  
        
            for (Con_Req__c ConReq:MapOfConReq.Values()){
                ListOfOpportunityIds.Add(ConReq.ASProject__r.AcctSeed__Opportunity__c);
            }
            
           
            
            Map<id,Opportunity> MapOfOpportunity=new Map<id,Opportunity>
                        ([Select Pending_CO_Amount__c 
                            from Opportunity 
                            where id in :ListOfOpportunityIds]);
        
            for(Opportunity Opp:MapOfOpportunity.Values()){
                opp.Pending_CO_Amount__c = null;
            }
        
            for(id CurId:MapOfConReq.KeySet()){
                Con_Req__c CR =MapOfConReq.Get(CurId) ;
                if(CR.Status__c == 'Borrego Approved' && CustomerRtId == CR.recordTypeId){
                    Opportunity opp;
                    opp = MapOfOpportunity.Get(CR.ASProject__r.AcctSeed__Opportunity__c);
                    if(opp != null && CR!=null && CR.Current_Change_Order_Subtotal__c != null){
                        opp.Pending_CO_Amount__c = CR.Current_Change_Order_Subtotal__c; 
                    }
                }    
            }
            approveELI.IsRecursiveUpdate=true;
            Update MapOfOpportunity.Values();
            approveELI.IsRecursiveUpdate=False;
            
            
          
   // } 

}