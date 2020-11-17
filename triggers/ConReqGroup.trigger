trigger ConReqGroup on Con_Req_Group__c (after update, before delete, before insert, before update) {
    
    /*
     *  Before delete
     *      - only allow delete if the record is not locked
     *
     *  Before insert and before update
     *      - set the Project PM field to the Project Manager field of the associated Site (Ship to Site), however if
     *        the Project Manager field is blank, set the Project PM field to the owner of the Project.
     *      - set the Ship To address fields from the related Site record
     *      - if before update, make sure the Sales Order field is not changed
     *
     *  After update
     *      - copy the "group" fields to the associated Sales Order Line records
     */
     
    
    if (trigger.isBefore) {
        Set<Id> pIds = new Set<Id>();
        Set<Id> sIds = new Set<Id>();
        if (trigger.isDelete) {
            for (Con_Req_Group__c crg :trigger.old) {
                if (crg.IsLocked__c) {
                    crg.addError('Record is locked - cannot delete a locked record.');
                }
            }
        } else {
            for (Con_Req_Group__c crg :trigger.new) {
                if (trigger.isUpdate) {
                    // Don't allow a change to the Sales Order field
                    if (crg.Sales_Order__c != trigger.oldMap.get(crg.Id).Sales_Order__c) {
                        crg.Sales_Order__c.addError('Field is not writeable.');
                    }
                    
                    if (crg.Project__c != null && crg.Project__c != trigger.oldMap.get(crg.Id).Project__c) {
                        pIds.add(crg.Project__c);
                    }
                    
                    if (crg.Ship_To_Site__c != null && crg.Ship_To_Site__c != trigger.oldMap.get(crg.Id).Ship_To_Site__c) {
                        sIds.add(crg.Ship_To_Site__c);
                    }
                } else {
                    if (crg.Project__c != null) {
                        pIds.add(crg.Project__c);
                    }
                    if (crg.Ship_To_Site__c != null) {
                        sIds.add(crg.Ship_To_Site__c);
                    }
                }
            }
                        
            Map<Id, Site__c> sMap = null;
            if (!sIds.isEmpty()) {
                sMap = new Map<Id, Site__c>([select Id, Site_Address__c, Site_City__c, Site_State__c, Site_Zip__c, Project_Manager__c from Site__c where Id in :sIds]);
            }
            
            Map<Id, AcctSeed__Project__c> pMap = null;
            if (!pIds.isEmpty()) {
                pMap = new Map<Id, AcctSeed__Project__c>([select Id, OwnerId from AcctSeed__Project__c where Id in :pIds]);
            }
            
            for (Con_Req_Group__c crg :trigger.new) {
                
                if (sMap != null && sMap.containsKey(crg.Ship_To_Site__c)) {
                    crg.Ship_To_Street__c = sMap.get(crg.Ship_To_Site__c).Site_Address__c;
                    crg.Ship_To_City__c = sMap.get(crg.Ship_To_Site__c).Site_City__c;
                    crg.Ship_To_State__c = sMap.get(crg.Ship_To_Site__c).Site_State__c;
                    crg.Ship_To_Zip__c = sMap.get(crg.Ship_To_Site__c).Site_Zip__c;
                    
                    if (sMap.get(crg.Ship_to_Site__c).Project_Manager__c != null) {
                        crg.Project_PM__c = sMap.get(crg.Ship_to_Site__c).Project_Manager__c;
                    } else {
                        if (pMap != null && pMap.containsKey(crg.Project__c)) {
                            crg.Project_PM__c = pMap.get(crg.Project__c).OwnerId;
                        } else {
                            crg.Project_PM__c = null;
                        }
                    }
                }
            }
        }
    }
    
    if (trigger.isAfter) {
        List<Id> crgIds = new List<Id>();
        for (Con_Req_Group__c crg :trigger.new) {
            if ( (crg.Project__c != trigger.oldMap.get(crg.Id).Project__c) || 
                 (crg.Project_PM__c != trigger.oldMap.get(crg.Id).Project_PM__c) || 
                 (crg.Ship_to_Account__c != trigger.oldMap.get(crg.Id).Ship_to_Account__c) || 
                 (crg.Status__c != trigger.oldMap.get(crg.Id).Status__c) || 
                 (crg.Vendor__c != trigger.oldMap.get(crg.Id).Vendor__c) || 
                 (crg.Vendor_Contact__c != trigger.oldMap.get(crg.Id).Vendor_Contact__c) || 
                 (crg.Requested_Delivery_Date__c != trigger.oldMap.get(crg.Id).Requested_Delivery_Date__c)|| (crg.Ship_To_Street__c != trigger.oldMap.get(crg.Id).Ship_To_Street__c)||
                  (crg.Ship_To_State__c != trigger.oldMap.get(crg.Id).Ship_To_State__c)|| (crg.Ship_To_Zip__c!= trigger.oldMap.get(crg.Id).Ship_To_Zip__c)||(crg.Ship_To_City__c!= trigger.oldMap.get(crg.Id).Ship_To_City__c)||(crg.Quote__c!= trigger.oldMap.get(crg.Id).Quote__c)) {
                crgIds.add(crg.Id);
            }
        }
        
        if (!crgIds.isEmpty()) {
            List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c> ();
            solList = [select Id, AcctSeedERP__Project__c, Project_PM__c, AcctSeedERP__Sales_Order__c, 
                        Ship_to_Account__c, Status__c, Vendor__c, Vendor_Contact__c, 
                        Requested_Delivery_Date__c, Con_Req_Group__c 
                        from AcctSeedERP__Sales_Order_Line__c where Con_Req_Group__c in :crgIds];
            
            for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
                sol.AcctSeedERP__Project__c = trigger.newMap.get(sol.Con_Req_Group__c).Project__c;
                sol.Project_PM__c = trigger.newMap.get(sol.Con_Req_Group__c).Project_PM__c;
                sol.Ship_to_Account__c = trigger.newMap.get(sol.Con_Req_Group__c).Ship_to_Account__c;
                sol.Status__c = trigger.newMap.get(sol.Con_Req_Group__c).Status__c;
                sol.Vendor__c = trigger.newMap.get(sol.Con_Req_Group__c).Vendor__c;
                sol.Vendor_Contact__c = trigger.newMap.get(sol.Con_Req_Group__c).Vendor_Contact__c;
                sol.Requested_Delivery_Date__c = trigger.newMap.get(sol.Con_Req_Group__c).Requested_Delivery_Date__c;
            }
            
            if (!solList.isEmpty()) {
                update solList;
            }
        }
        
        // Added By Madan - Sept 6(Create PO and POI when Service RT CRG get Approved)
        ConReqGroupHandler.createPOfromCRG(trigger.isUpdate, 
                                            trigger.isInsert, 
                                            trigger.new, 
                                            trigger.oldMap, 
                                            trigger.newMap);
    }
}