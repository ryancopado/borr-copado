trigger CreatePurchaseOrder on Service_Construction_Requisition__c (After Insert, BEFORE Update) {


    List<Service_Construction_Requisition__c > Insertreqs = new List<Service_Construction_Requisition__c >();
    List<Service_Construction_Requisition__c > Updatereqs = new List<Service_Construction_Requisition__c >();
 
   
    
    if (Trigger.isUpdate) {
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            
            
            String newStatus = Trigger.new[i].Status__c;
            String oldStatus = Trigger.old[i].Status__c;
           
            Boolean isServiceVisit = Trigger.new[i].Service_Visit__c == null ? false : true;
            
            if( justChangedTo ('Approved', newStatus , oldStatus) && Trigger.Old[i].Service_Purchase_Order__c==null  ) {
            								
                    Updatereqs.add(Trigger.new[i]);
                    
            } 
                     
        }
    
    }
    
    if (Trigger.isInsert) {
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            String newStatus = Trigger.new[i].Status__c;
            Boolean isServiceVisit = Trigger.new[i].Service_Visit__c == null ? false : true;
            if( newStatus   =='Approved'  &&
                Trigger.new[i].Service_PO__c == null ) {
                    Insertreqs.add(Trigger.new[i]);
            } 
        }
    }
    
 
   
    List<ID> ListOfPurchaseOrderIDs=new List<ID>();
 
        
        if (Trigger.isInsert==true) 
            if(Insertreqs.size() > 0)
                CreateServicePO.addserPO(Insertreqs,false);
                
        if (Trigger.isInsert==false) 
            if(Updatereqs.size() > 0)        
                CreateServicePO.addserPO(Updatereqs ,true);
             else{
                     for (Service_Construction_Requisition__c ServiceConstructionRequisition:Trigger.new) {
                         if(ServiceConstructionRequisition.Service_Purchase_Order__c !=null)
                           ListOfPurchaseOrderIDs.add(ServiceConstructionRequisition.Service_Purchase_Order__c);
                       } 
                       
                     Map<id,Service_PO__c> MapOfServicePurchaseOrders=new Map<id,Service_PO__c>();
                     List<Service_Construction_Requisition__c> ListOfServiceConsReq=[Select id,Product__c,Product__r.ProductCode,Cost__c
                                                                 From Service_Construction_Requisition__c  where id in :Trigger.newMap.keyset()];
                     For(Service_PO__c ServicePurchaseOrder:
                                                 [Select Service_Construction_Requisition__c,ID,SCR_Item_Code__c,SCR_Product__c,SCR_Unit_Cost__c   FROM Service_PO__c
                                                 Where id in :ListOfPurchaseOrderIDs])
                       {
                         MapOfServicePurchaseOrders.Put(ServicePurchaseOrder.Service_Construction_Requisition__c,ServicePurchaseOrder);
                       }
                       
                     For(Service_Construction_Requisition__c ServiceConstructionRequisition:ListOfServiceConsReq) {
                           Service_PO__c ServicePurchaseOrder=MapOfServicePurchaseOrders.Get(ServiceConstructionRequisition.id);
                           if (ServicePurchaseOrder!=null){
                                   if (ServicePurchaseOrder.SCR_Product__c==null){
                                               ServicePurchaseOrder.SCR_Product__c = ServiceConstructionRequisition.Product__c;
                                               ServicePurchaseOrder.SCR_Item_Code__c = ServiceConstructionRequisition.Product__r.ProductCode;
                                           }
                                    if (ServicePurchaseOrder.SCR_Unit_Cost__c==null){
                                               ServicePurchaseOrder.SCR_Unit_Cost__c= ServiceConstructionRequisition.Cost__c;
                                           }
                               }
                       } 
                       Update MapOfServicePurchaseOrders.Values();
                }         
     

    
    Boolean justChangedTo (String compareValue, String newValue, String oldValue) {
      
        if (newValue == compareValue && oldValue != compareValue) {
            return true;
        }
        return false; 
    }
    

}