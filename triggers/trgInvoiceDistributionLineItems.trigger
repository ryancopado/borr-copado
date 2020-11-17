trigger trgInvoiceDistributionLineItems on Invoice_Distribution_Line__c (after delete, after insert, after undelete, 
after update) { 
 
        List<Con_PO__c> ListOfPO;  
        
        Set<Id> SetOfPOIds=new Set<Id>();
                       
                if (Trigger.isDelete==True)    
                    for(Invoice_Distribution_Line__c InvoiceDistributionLineItem :Trigger.Old)
                    {
                        SetOfPOIds.add(InvoiceDistributionLineItem.Construction_Purchase_Order1__c);
                    }
                else
                    for(Invoice_Distribution_Line__c InvoiceDistributionLineItem :Trigger.new)
                    {
                        SetOfPOIds.add(InvoiceDistributionLineItem.Construction_Purchase_Order1__c);
                    }

        ListOfPO= [Select ID, Distribution_Line_Total__c,Freight_Company__c from Con_PO__c   where id in :SetOfPOIds];



        Map<id,List<Con_Req__c>> MapOfProjectWiseConstructionReq=new Map<id,List<Con_Req__c>>();
    
        For(Con_Req__C ConstructionReq:[Select Budget_Line_Item__c, Budget_Line_Item__r.Cost_Code__c
                            , Budget_Line_Item__r.Cost_Code_Name__c, Budget_Line_Item__r.Id, Id
                            , Purchase_Order__c, Purchase_Order__r.Id from Con_Req__c
                            Where Purchase_Order__c in :SetOfPOIds
                            Order by Purchase_Order__c , CreatedDate desc]){
    
            List<Con_Req__c> ListOfConstructionReq;
            
            If(MapOfProjectWiseConstructionReq.ContainsKey(ConstructionReq.Purchase_Order__c))
                    ListOfConstructionReq=MapOfProjectWiseConstructionReq.Get(ConstructionReq.Purchase_Order__c);
            Else{
                    ListOfConstructionReq=new List<Con_Req__C>();
                    MapOfProjectWiseConstructionReq.Put(ConstructionReq.Purchase_Order__c,ListOfConstructionReq);
                    }
            
            
            If (ListOfConstructionReq.size()==0)
                ListOfConstructionReq.Add(ConstructionReq);
    
    
            System.debug('***'+ListOfConstructionReq);
        }        

  
        Map<Id,Decimal> MapOfDistributionLineItemTotal=new Map<Id,Decimal>();  
               
               FOR(SObject Sobj:[Select  Construction_Purchase_Order1__c ,Sum(Distribution_Line_Total__c) Sum from Invoice_Distribution_Line__c 
                        Group by  Construction_Purchase_Order1__c having  Construction_Purchase_Order1__c in :SetOfPOIds]  ){
               
                   MapOfDistributionLineItemTotal.Put((Id)Sobj.Get('Construction_Purchase_Order1__c'),(Decimal)Sobj.Get('Sum'));
               
               }
 
 
                for(Con_PO__c ConstructionPO :ListOfPO){
                       
                          
                        Decimal Total=(Decimal) MapOfDistributionLineItemTotal.get(ConstructionPO.id);
                        
                        if (Total==null)
                            Total=0;
                       
                        ConstructionPO.Distribution_Line_Total__c =Total;
                           
                      ConstructionPO.Freight_Company__c ='test';
                              
                    }
           
               Update ListOfPO;
               
               if (Trigger.IsInsert){
               
               
                   List<Invoice_Distribution_Line__c > ListOfInvoiceDistributionLine =[Select   Description__c, Id, POInvoice__c, 
                       POInvoice__r.Description__c, Construction_Purchase_Order1__r.Cost_Code_Cat__c from Invoice_Distribution_Line__c Where id in :Trigger.New];
                       
                    If(ListOfInvoiceDistributionLine !=null && ListOfInvoiceDistributionLine.size()>0){
                    
                        for(Invoice_Distribution_Line__c InvoiceDistributionLine:ListOfInvoiceDistributionLine ){
                        
                            InvoiceDistributionLine.Description__c=InvoiceDistributionLine.POInvoice__r.Description__c ;
                            
                            String CostCode,Category;
                            
                            If (InvoiceDistributionLine.Construction_Purchase_Order1__c!=null){
                                if (InvoiceDistributionLine.Construction_Purchase_Order1__r.Cost_Code_Cat__c!=null && InvoiceDistributionLine.Construction_Purchase_Order1__r.Cost_Code_Cat__c!=''){
                                        CostCode=InvoiceDistributionLine.Construction_Purchase_Order1__r.Cost_Code_Cat__c;
                                        CostCode=CostCode.Split(' ')[0];
                                        
                                        Category=InvoiceDistributionLine.Construction_Purchase_Order1__r.Cost_Code_Cat__c;
                                        if (Category.Split(' ').size()>1)
                                            Category=Category.Split(' ')[1];
                                        else
                                            Category='';
                                    }
                                    
                                        List<Con_Req__c> ListOfConstructionReq;
                
                                        If(MapOfProjectWiseConstructionReq.ContainsKey(InvoiceDistributionLine.Construction_Purchase_Order1__c))
                                            ListOfConstructionReq=MapOfProjectWiseConstructionReq.Get(InvoiceDistributionLine.Construction_Purchase_Order1__c);
                                        
                                        If (ListOfConstructionReq!=null && ListOfConstructionReq.size()>0)
                                             InvoiceDistributionLine.New_CostCode__C=ListOfConstructionReq[0].Budget_Line_Item__r.Cost_Code_Name__c;
                                    
                                 InvoiceDistributionLine.New_Cost_Code_No__c =   CostCode;
                                 InvoiceDistributionLine.New_Category__c=   Category;
                            }
                        }
                        
                        If (ListOfInvoiceDistributionLine !=null)
                            Update ListOfInvoiceDistributionLine ;
                    
                    }
                   
               
               
               }

}