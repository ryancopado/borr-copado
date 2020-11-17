public with sharing class CreateServicePO {
      
    /***** Begin Service Purchase Order *****/
    public static void addserPO(Service_Construction_Requisition__c[] reqs,boolean IsUpdate){

        system.debug('Test--');
        List<Id> ListOfServiceVisitIds = new List<Id>();
        List<Id> ccId = new List<Id>();         
        List<Id> accId = new List<Id>();
        Map<Id, Id> reqSV = new Map<Id, Id>();
        Map<Id, Id> ccReq = new Map<Id, Id>();
        Map<Id, SV__c> svMap = new Map<Id, SV__c>();
        Map<Id, Cost_Code__c> ccMap = new Map<Id, Cost_Code__c>();                        
        Map<Id, Account> accMap = new Map<Id, Account>();
        
        
        Map<id,Service_PO__c> MapOfServicePurchaseOrder=new Map<id,Service_PO__c>();
        
        //Query BLIs from ConReqs, add BLIs to reqID list, put Req Id and BLI Id into conBli
        Service_Construction_Requisition__c[] req = [SELECT Id, Service_Visit__c, Cost_Code__c
                                , Ship_To_Account__c FROM Service_Construction_Requisition__c WHERE Id in :reqs];
        for (Integer i = 0; i <req.size(); i++) {
            ListOfServiceVisitIds.add(req[i].Service_Visit__c);
            reqSV.put(req[i].Id, req[i].Service_Visit__c);
            ccId.add(req[i].Cost_Code__c);
            ccReq.put(req[i].Cost_Code__c, req[i].Id);
            accId.add(req[i].Ship_To_Account__c);
        }
        SV__c[] svs = [SELECT Id, Cost__c, Name, Contract__c FROM SV__c WHERE Id in :ListOfServiceVisitIds];
        for (Integer i = 0; i <svs.size(); i++) {
            svMap.put(svs[i].Id, svs[i]);
        }
        Cost_Code__c[] ccs = [SELECT Id, Number__c, Category__c FROM Cost_Code__c WHERE Id in :ccId];
        for (Integer i = 0; i <ccs.size(); i++) {
            ccMap.put(ccReq.get(ccs[i].Id), ccs[i]);
        }
        Account[] accs = [SELECT Id, Name, ShippingStreet, ShippingState, ShippingCity, ShippingPostalCode FROM Account WHERE Id in :accId];
        for (Integer i = 0; i <accs.size(); i++) {
            accMap.put(accs[i].Id, accs[i]);
        }
        
        List<SV__c> updatesv = new List<SV__c>();   //List of SVs to be updated         
        
        //Begin to Create POs - includes removing Req Amount from Pending PO and adding to Approved PO (PO_Total__c)
        for (Service_Construction_Requisition__c ServiceConstructionRequisition:reqs){
            //if (r.RecordTypeId == Utilities.getRecordType('Minor Component Requisition').Id) {
            String ShipingAddress;
             if (accMap.size()>0 && ServiceConstructionRequisition.Ship_To_Account__c!=null)
                    ShipingAddress = accMap.get(ServiceConstructionRequisition.Ship_To_Account__c).ShippingStreet + '\n' + accMap.get(ServiceConstructionRequisition.Ship_To_Account__c).ShippingCity + ', ' 
                                        + accMap.get(ServiceConstructionRequisition.Ship_To_Account__c).ShippingState + ' ' + accMap.get(ServiceConstructionRequisition.Ship_To_Account__c).ShippingPostalCode;
                Service_PO__c ServicePurchaseOrder = new Service_PO__c(
                    SCR_Vendor_Account__c = ServiceConstructionRequisition.Vendor_Account__c,
                    SCR_Vendor_Contact__c = ServiceConstructionRequisition.Vendor_Contact__c,
                    SCR_Ship_To__c = ServiceConstructionRequisition.Ship_To_Account__c,
                    SCR_Ship_Address__c =ShipingAddress,
                    SCR_Date__c = ServiceConstructionRequisition.Date_Needed__c,
                    SCR_Quantity__c = ServiceConstructionRequisition.Quantity__c,
                    SCR_Unit_Price__c = ServiceConstructionRequisition.Cost__c,
                    //OwnerId = ServiceConstructionRequisition.Service_Visit__r.Contract__r.OwnerId,
                    SCR_Requested_By__c = ServiceConstructionRequisition.Service_Visit__r.Contract__r.Account.Ownership ,
                    SCR_Product__c = ServiceConstructionRequisition.Product__c,                    
                    SCR_Item_Code__c = ServiceConstructionRequisition.Product__r.ProductCode,
                    SCR_Description__c = ServiceConstructionRequisition.Product__r.Description,
                    SCR_Tax_Rate__c = ServiceConstructionRequisition.Tax_Rate__c,
                    //SCR_Shipping__c = ServiceConstructionRequisition.Shipping__c,
                    SCR_Requisition_Number__c = ServiceConstructionRequisition.Name,
                    Service_Construction_Requisition__c=ServiceConstructionRequisition.Id,
                    SCR_Unit_Cost__c=ServiceConstructionRequisition.Cost__c,
                    SCR_Status__c='New',
                    SCR_Project_Name__c = svMap.get(reqSV.get(ServiceConstructionRequisition.Id)).Name,
                    SCR_Cost_Code_Cat__c = ccMap.get(ServiceConstructionRequisition.Id).Number__c + ' ' +ccMap.get(ServiceConstructionRequisition.Id).Category__c);
                     
                    MapOfServicePurchaseOrder.Put(ServiceConstructionRequisition.id,ServicePurchaseOrder);
                    
                //insert ServicePurchaseOrder;
               
            
        }
            Insert MapOfServicePurchaseOrder.Values();
            
            List<id> ListOfServicePurchaseOrderIds =new List<id>();
            
            for (Service_PO__c ServicePurchaseOrder:MapOfServicePurchaseOrder.Values()){
                ListOfServicePurchaseOrderIds.add(ServicePurchaseOrder.ID);
            }
            
            Map<id,Service_PO__c> MapOfServicePurchaseOrders =new Map<id,Service_PO__c>([Select id,Name from Service_PO__c Where id in :ListOfServicePurchaseOrderIds ]);
            Map<id,Service_Construction_Requisition__c > MapOfService_Construction_Requisition =new Map<id,Service_Construction_Requisition__c >
            ([Select id,Name from Service_Construction_Requisition__c Where id in :reqs]);
            
         for (Service_Construction_Requisition__c ServiceConstructionRequisition:reqs){
            
            Service_PO__c ServicePurchaseOrder =MapOfServicePurchaseOrders.get(MapOfServicePurchaseOrder.get(ServiceConstructionRequisition.id).id);
            
            Service_Construction_Requisition__c TempServiceConstructionRequisition = MapOfService_Construction_Requisition .get(ServiceConstructionRequisition.id);
            
            if (IsUpdate==true){
                 ServiceConstructionRequisition.Service_PO__c = ServicePurchaseOrder.Name;
                 ServiceConstructionRequisition.Service_Purchase_Order__c = ServicePurchaseOrder.id;
             }
             else{
                 TempServiceConstructionRequisition.Service_PO__c = ServicePurchaseOrder.Name;
                 TempServiceConstructionRequisition.Service_Purchase_Order__c = ServicePurchaseOrder.id;           
             }
             
             System.debug(ServiceConstructionRequisition.Service_PO__c);
             
                if(svMap.get(reqSV.get(ServiceConstructionRequisition.Id)).Cost__c == null) {
                    svMap.get(reqSV.get(ServiceConstructionRequisition.Id)).Cost__c = 0;
                }
                //Add Req Total to PO_Total
                //svMap.get(reqSV.get(r.Id)).Cost__c += r.Total_Cost_Tax__c;
                
                //Add updated BLIs to updatebli to be mass updated below
                updatesv.add(svMap.get(reqSV.get(ServiceConstructionRequisition.Id)));                           
            //}
            //Subcontractor
            
            //Major Component
         }
         
         if (IsUpdate==false){
             Update MapOfService_Construction_Requisition.values();
         }
        
        if (updatesv.size() > 0){
            update updatesv;
        } 
    }
    /***** End Service Purchase Order *****/ 
    
      
}