/*
Atuhor: Madan(Forcebrain Developer)
Date: Sept 6, 2017
Description: This class basically used to ConReqGroup Trigger Handler, so it retains all Util methods
*/
public without sharing class ConReqGroupHandler {
    
    public static void createPOfromCRG(Boolean isUpdate, 
                                    Boolean isInsert, 
                                    List<Con_Req_Group__c> newList, 
                                    Map<Id,Con_Req_Group__c> oldMap, 
                                    Map<Id,Con_Req_Group__c> newMap) {
        Map<Id,AcctSeedERP__Purchase_Order__c> mapCRGIdToPO = new map<Id,AcctSeedERP__Purchase_Order__c>();
        Id serviceRTId = Schema.SObjectType.Con_Req_Group__c.getRecordTypeInfosByName().get('Service Visit').getRecordTypeId();
        for(Con_Req_Group__c crg:newList) {
        
        system.debug('Entering Loop');
        system.debug('Record Id' +crg.RecordTypeId);
        system.debug('service Id' +serviceRTId);
        system.debug('status' +crg.Status__c);
        //system.debug('old status +oldMap.get(crg.Id).Status__c);
        
            if(crg.RecordTypeId == serviceRTId && crg.Status__c == 'Approved' && 
                    (isInsert || (isUpdate && crg.Status__c != oldMap.get(crg.Id).Status__c))) {
                    system.debug('Entering condition');
                mapCRGIdToPO.put(crg.Id,createPO(crg));
            }
        
        }
        
        // Create Map of CRG Id to List of POL
        Map<Id,List<AcctSeedERP__Purchase_Order_Line__c>> mapCRGIdToPOLs = new map<Id,List<AcctSeedERP__Purchase_Order_Line__c>>();
        List<AcctSeedERP__Purchase_Order_Line__c> insertPOLs = new List<AcctSeedERP__Purchase_Order_Line__c>();
        if(mapCRGIdToPO.keySet().size() > 0) {
            insert mapCRGIdToPO.values();
            System.debug('==================mapCRGIdToPO.values(): ' + mapCRGIdToPO.values());
            
            List<AcctSeedERP__Sales_Order_Line__c> lstSOL = [Select Id, AcctSeedERP__Product__c, Additional_Notes__c, AcctSeedERP__Quantity_Ordered__c, Unit_Cost__c, Freight__c, 
                                                        Requested_Delivery_Date__c, AcctSeedERP__Project_Task__c, AcctSeedERP__Project__c, Name, Ship_to_Account__c, 
                                                        Con_Req_Group__c, Construction_Req__c,AcctSeedERP__Purchase_Order_Line__c 
                                                        From AcctSeedERP__Sales_Order_Line__c Where Con_Req_Group__c IN:mapCRGIdToPO.keySet()];
            for(AcctSeedERP__Sales_Order_Line__c sol:lstSOL) {
                if(!mapCRGIdToPOLs.containsKey(sol.Con_Req_Group__c)) {
                    mapCRGIdToPOLs.put(sol.Con_Req_Group__c,new List<AcctSeedERP__Purchase_Order_Line__c>());
                }
                
                AcctSeedERP__Purchase_Order_Line__c pol = createPOL(sol, mapCRGIdToPO.get(sol.Con_Req_Group__c).Id);
                insertPOLs.add(pol);
                mapCRGIdToPOLs.get(sol.Con_Req_Group__c).add(pol);
            }
            
            if(insertPOLs.size() > 0) {
                insert insertPOLs;
                System.debug('==================insertPOLs11: ' + insertPOLs);
                
                for(Integer i=0;i<insertPOLs.size();i++) {
                    lstSOL[i].AcctSeedERP__Purchase_Order_Line__c = insertPOLs[i].Id;
                }
                update lstSOL;
                System.debug('==================lstSOL22: ' + lstSOL);
            }
            
            
            System.debug('==================insertPOLs: ' + insertPOLs);
        }
    }
    
    private static AcctSeedERP__Purchase_Order__c createPO(Con_Req_Group__c crg) {
        AcctSeedERP__Purchase_Order__c po = new AcctSeedERP__Purchase_Order__c();
        
        po.AcctSeedERP__Vendor__c = crg.Vendor__c;
        po.AcctSeedERP__Vendor_Contact__c = crg.Vendor_Contact__c;
        
        po.AcctSeedERP__Shipping_Company__c = crg.Ship_to_Account__c;
        po.Con_Req_Creator_ID__c = crg.CreatedById;
        po.Con_Req_Group__c = crg.Id;
        po.Case__c= crg.Case__c;
        po.AcctSeedERP__Shipping_Street__c=crg.Ship_To_Street__c;
        po.AcctSeedERP__Shipping_City__c=crg.Ship_To_City__c;
        po.AcctSeedERP__Shipping_State__c=crg.Ship_To_State__c;
        po.AcctSeedERP__Shipping_Postal_Code__c=crg.Ship_To_Zip__c;
        po.Quote__c=crg.Quote__c;
        /**po.Shipping_Method__c= crg.Shipping_Method__c;
        po.Delivery_Notes__c= crg.Delivery_Notes__c;
        po.Scope__c= crg.Scope__c;
        po.Quote_Reference__c= crg.Quote_Reference__c;
        po.Project_Detail__c= crg.Project_Detail__c;
        po.Case__c= crg.Case__c;
        po.Service_Contract__c= crg.Service_Contract__c;
        po.Special_Notes__c= crg.Special_Notes__c;
        po.Project__c= crg.Project_Name__c;
        po.Service_Visit__c=crg.ServiceVisit__c;**///added by Divya due to deployment error and confirmed by Emily 
        po.OwnerId=crg.OwnerId;//Added by Divya for story W-000738
        
        return po;
    }
    
    private static AcctSeedERP__Purchase_Order_Line__c createPOL(AcctSeedERP__Sales_Order_Line__c sol, Id poId) {
        AcctSeedERP__Purchase_Order_Line__c pol = new AcctSeedERP__Purchase_Order_Line__c();
        
        pol.AcctSeedERP__Product__c = sol.AcctSeedERP__Product__c;
        pol.Additional_Notes__c = sol.Additional_Notes__c;
        pol.AcctSeedERP__Quantity__c = sol.AcctSeedERP__Quantity_Ordered__c;
        
        pol.Unit_Cost__c = sol.Unit_Cost__c;
        pol.Freight__c = sol.Freight__c;
        pol.Requested_Delivery_Date__c = sol.Requested_Delivery_Date__c;
        
        pol.AcctSeedERP__Project_Task__c = sol.AcctSeedERP__Project_Task__c;
        pol.AcctSeedERP__Project__c = sol.AcctSeedERP__Project__c;
        pol.Construction_Req__c = sol.Construction_Req__c;

        pol.Ship_to_Account__c = sol.Ship_to_Account__c;
        pol.AcctSeedERP__Unit_Price__c = 1;
        pol.AcctSeedERP__Purchase_Order__c = poId;
        
        return pol;
    }
}