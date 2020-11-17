trigger trgOpportunity on Opportunity (After Update) {
    If(approveELI.IsRecursiveUpdate==Null)
        approveELI.IsRecursiveUpdate=False;

    If(approveELI.IsRecursiveUpdate==False){
        List<PO_Invoice__c> ListOfPOInvoice=new List<PO_Invoice__c>();
     
        Map<string, SFDC_Project__C> MapOfProjectNames=new Map<string,SFDC_Project__C>();
        Map<ID, Opportunity> MapOfProjectIds=new Map<ID,Opportunity>();
            
        Map<Id,SFDC_Project__C> MapOfProjects=new Map<Id,SFDC_Project__C>
                ([Select Id,Name,Opportunity__c FROM SFDC_Project__C Where Opportunity__c in :Trigger.New]);
                
        for(SFDC_Project__C Project:MapOfProjects.Values()){
        
            MapOfProjectNames.Put(Project.Name,Project);
            MapOfProjectIds.Put(Project.id,Trigger.newMap.Get(Project.Opportunity__c ));
      
        }           
       
      /*  List<Con_Req__c> ListOfConReq=[Select Final_Change_Order_Amount__c,project__r.Opportunity__r.Id FROM Con_Req__c where Id in :MapOfProjectIds.keySet()];
        
        Decimal ChangeOrder=0;
        
        for (Con_Req__c ConReq :ListOfConReq){
        
            ChangeOrder +=ConReq.Final_Change_Order_Amount__c;
        
        }*/
        
    //system.debug('4444444444' +MapOfProjectIds.values());
    
        Map<Id,Invoice_Distribution_Line__c> MapOfInvoiceDistributionLine=new Map<Id,Invoice_Distribution_Line__c>
                ([Select Id,Name,POInvoice__c,Project__C  FROM Invoice_Distribution_Line__c Where Project__C in :MapOfProjectNames.KeySet()]);
    
        List<ID> ListOfPOInvoiceID=new List<ID>();
        
        for(Invoice_Distribution_Line__c InvoiceDistribution:MapOfInvoiceDistributionLine.Values()){
        
            ListOfPOInvoiceID.Add(InvoiceDistribution.POInvoice__c );
     
        }   
        
        Map<Id,PO_Invoice__c> MapOfPOInvoice=new Map<Id,PO_Invoice__c>
                ([Select ID,NAME,Opportunity_Tax_Group__c FROM PO_Invoice__c WHERE ID IN :ListOfPOInvoiceID]);
        
        
        FOR (Invoice_Distribution_Line__c InvoiceDistributionLine :MapOfInvoiceDistributionLine.VALUES()){
            SFDC_Project__C Project;
            PO_Invoice__c POInvoice;
            Opportunity Opportunity;
            
            
            If(InvoiceDistributionLine!=null)
            POInvoice=MapOfPOInvoice.GET(InvoiceDistributionLine.POInvoice__c);
            
      //      System.debug('11111' + POInvoice);
            If(InvoiceDistributionLine!=null)        
            Project=MapOfProjectNames.GET(InvoiceDistributionLine.Project__C  );
            
    //      System.debug('22222' + Project);
            If(Project!=null)        
            Opportunity = MapOfProjectIds.GET(Project.id);
        
     //       System.debug('33333' + Opportunity);
            If(Opportunity!=null)        
            POInvoice.Opportunity_Tax_Group__c=Opportunity.Tax_Group__c;
        }
        
          Update MapOfPOInvoice.VALUES();
   }
}