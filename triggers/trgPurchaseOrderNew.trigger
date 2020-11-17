trigger trgPurchaseOrderNew on Service_PO__c (before insert, before update) {


   Tax_Group__c TaxGroup;
   Map<ID,Id> MapOfProjectID=NEW Map<ID,Id>();
   
   List<id> ListOfServiceReq=new List<id>();
    for (Service_PO__C ServicePO:Trigger.new) {
        ListOfServiceReq.add(ServicePO.Service_Construction_Requisition__c);
    }
   
    List<Service_Construction_Requisition__c> ListOfServiceRequistion;
    
    
    ListOfServiceRequistion=[Select ID,Service_Visit__r.Contract__r.Project__r.Opportunity__R.Tax_Group__c
                                   FROM Service_Construction_Requisition__c
                                   Where id IN :ListOfServiceReq];
   
    for (Service_Construction_Requisition__c ServiceReq:ListOfServiceRequistion) {
            
                if (ServiceReq.Service_Visit__c!=null){
                    if (ServiceReq.Service_Visit__r.Contract__c!=null){
                        if (ServiceReq.Service_Visit__r.Contract__r.Project__c!=null){
                            if (ServiceReq.Service_Visit__r.Contract__r.Project__r.Opportunity__C!=null){                         
                                if (ServiceReq.Service_Visit__r.Contract__r.Project__r.Opportunity__C!=null){                            
                                    MapOfProjectID.PUT(ServiceReq.id,ServiceReq.Service_Visit__r.Contract__r.Project__r.Opportunity__R.Tax_Group__c);
                                }
                            }
                         }
                     }
                 }
                    
        }
        
        
         for (Integer i = 0; i <Trigger.new.size(); i++) {
            ID GroupID=MapOfProjectID.GET(Trigger.new[i].Service_Construction_Requisition__c);
             
                
            if(GroupID!=null)             
                Trigger.new[i].Tax_Group__c=GroupID;
            
        }
        
      
}