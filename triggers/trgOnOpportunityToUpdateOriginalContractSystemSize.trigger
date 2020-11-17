trigger trgOnOpportunityToUpdateOriginalContractSystemSize on Opportunity (Before Update) {

    if (approveELI.IsRecursiveUpdate==null)
        approveELI.IsRecursiveUpdate=False;

    If(approveELI.IsRecursiveUpdate==False){
    
        
              /*  Map<string,Decimal> MapOfOpportunityOriginalSysSize = New Map<string,Decimal>();
            
                For(Sobject sobj:[Select  OpportunityId, Sum(Project_Watts__c)  Sum
                                                from OpportunityLineItem 
                                                Where OpportunityId in : Trigger.new and PricebookEntry.Product2.Family='Solar Modules'
                                                Group by OpportunityId]){
                
                    MapOfOpportunityOriginalSysSize.Put((string)sobj.Get('OpportunityId'),(Decimal)sobj.Get('Sum'));
                }
            
                For(Opportunity Opp: Trigger.New){
                
                    If(Opp.StageName.toLowerCase()!='contract signed')
                        Opp.Original_Contract_System_Size__c=MapOfOpportunityOriginalSysSize.Get(Opp.Id);
                
                }
            
             
              
          
            
            Map<id,Decimal> MapOfChangeOrder= new Map<id,Decimal>();
            
            for (Con_Req__c ConReq :[Select Final_Change_Order_Amount__c,asproject__r.AcctSeed__Opportunity__r.Id FROM Con_Req__c where recordType.Name!='Subcontractor Change Order' and    Status__C='Approved By Customer' and  asproject__r.AcctSeed__Opportunity__r.Id in :Trigger.New]){
            
                if(MapOfChangeOrder.ContainsKey(ConReq.asproject__r.AcctSeed__Opportunity__r.Id)){
                    if (MapOfChangeOrder.Get(ConReq.asproject__r.AcctSeed__Opportunity__r.Id)==null)
                        MapOfChangeOrder.Put(ConReq.asproject__r.AcctSeed__Opportunity__r.Id,0);
                    else{            
                        Decimal CO=MapOfChangeOrder.Get(ConReq.asproject__r.AcctSeed__Opportunity__r.Id)+ConReq.Final_Change_Order_Amount__c;
                        //cost break down
                        
                        MapOfChangeOrder.Put(ConReq.asproject__r.AcctSeed__Opportunity__r.Id,CO);            
                    }                
                
                }
                else
                    MapOfChangeOrder.Put(ConReq.asproject__r.AcctSeed__Opportunity__r.Id,ConReq.Final_Change_Order_Amount__c);
           }
            
            For(Opportunity Opp:Trigger.New){
                If(MapOfChangeOrder.containsKey(Opp.Id))
                    Opp.Change_Orders__c=MapOfChangeOrder.Get(Opp.Id);
                Else
                    Opp.Change_Orders__c=0; 
                
            }*/
     }
}