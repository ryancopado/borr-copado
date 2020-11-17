trigger trgConstructionPO on Con_PO__c (Before Update) {
  
        Map<Id,Decimal> MapOfDistributionLineItemTotal=new Map<Id,Decimal>();  
               
               FOR(SObject Sobj:[Select  Construction_Purchase_Order1__c ,Sum(Distribution_Line_Total__c) Sum from Invoice_Distribution_Line__c 
                        Group by  Construction_Purchase_Order1__c having  Construction_Purchase_Order1__c in :Trigger.New]  ){
               
                   MapOfDistributionLineItemTotal.Put((Id)Sobj.Get('Construction_Purchase_Order1__c'),(Decimal)Sobj.Get('Sum'));
               
               }
 
 
                for(Con_PO__c ConstructionPO :Trigger.New){
                       
                          
                        Decimal Total=(Decimal) MapOfDistributionLineItemTotal.get(ConstructionPO.id);
                        
                        if (Total==null)
                            Total=0;
                       
                        ConstructionPO.Distribution_Line_Total__c =Total;
                           
                      
                              
                    }
     
     }