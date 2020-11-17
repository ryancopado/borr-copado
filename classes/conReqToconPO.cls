public with sharing class conReqToconPO {

    /*
     * toConPO
     * Pull over the Construction Requisition record type Subcontractor fields
     * Retention Held and Retention Percent to the associated Construction
     * Purchase Order record.
     *
     * Add up the Amount Requested field from each Construction Requisition
     * record of type Subcontractor Change Order associated with a Construction
     * Purchase Order record and put it in the Change Order Total field.
     *
     */
   /*  public static void toConPO(Con_Req__c[] cr, Integer act) {
        
        // Get the Construction Purchase Order Ids.
        List<Id> cpoId = new List<Id>();
        for (Integer i=0; i<cr.size(); i++) {
            cpoId.add(cr[i].Purchase_Order__c);
        }
        
        // Get all the Construction Purchase Order records that may need to
        // be updated.
        Map<Id, Con_PO__c> conPO = new Map<Id, Con_PO__c>();
        Con_PO__c[] cpo = [select Change_Order_Total__c, Retention_Held__c, Retention_Percent__c
                from Con_PO__c where Id in :cpoId];
        for (Integer i=0; i<cpo.size(); i++) {
            conPO.put(cpo[i].Id, cpo[i]);
        }
        
        Map<Id, Con_PO__c> upconPO = new Map<Id, Con_PO__c>();
        
        If(conPO!=null)
            for (Integer i=0; i<cr.size(); i++) {
                
                if (cr[i].Record_Type_Name__c == 'Subcontractor Requisition') {
                    // Pull over Retention Held and Retention Percent fields from the
                    // Construction Requisition to the Construction Purchase Order.
                    if (act == 2 || cr[i].Status__c == 'Recalled') {
                        // Reset Construction Purchase Order fields to null because
                        // of recalled approval or because Construction Requisition is
                        // about to be deleted.
                        if(conPO.ContainsKey(cr[i].Purchase_Order__c)){
                            conPO.get(cr[i].Purchase_Order__c).Retention_Held__c = null;
                            conPO.get(cr[i].Purchase_Order__c).Retention_Percent__c = null;
                        }
                    } else {
                        // Trigger is after insert or after update.
                        if(conPO.ContainsKey(cr[i].Purchase_Order__c)){
                            conPO.get(cr[i].Purchase_Order__c).Retention_Held__c = cr[i].Retention_Held__c;
                            conPO.get(cr[i].Purchase_Order__c).Retention_Percent__c = cr[i].Retention_Percent__c;
                         }
                    }
                     if(conPO.ContainsKey(cr[i].Purchase_Order__c)){
                        upconPO.put(conPO.get(cr[i].Purchase_Order__c).Id, conPO.get(cr[i].Purchase_Order__c));
                      }
                } 
            
            // Add in the new or changed Amount Requested to the Change Order Total field of 
            // the Construction Purchase Order field
            if (cr[i].Record_Type_Name__c == 'Subcontractor Change Order') {
                Decimal coTotal = 0;
                if (act == 0) {
                    coTotal = cr[i].Amount_Requested__c;
                }
                if (act == 1) {
                    coTotal = cr[i].Amount_Requested_Change__c;
                }
                if (act == 2) {
                    coTotal = 0 - cr[i].Amount_Requested__c;
                }
                if (coTotal != 0) {
                    if (conPO.get(cr[i].Purchase_Order__c).Change_Order_Total__c == null) {
                        conPO.get(cr[i].Purchase_Order__c).Change_Order_Total__c = 0;
                    }
                    conPO.get(cr[i].Purchase_Order__c).Change_Order_Total__c += coTotal;
                    upconPO.put(conPO.get(cr[i].Purchase_Order__c).Id, conPO.get(cr[i].Purchase_Order__c));
                }
            }
        }
        
        // Update changed Construction Purchase Order records
        if (upconPO.size() > 0) {
            update upconPO.values();
        }*/
     } 
     
    /* @isTest
     static void runTest() {
        ProjectTest.FieldUpdate();  
     } 
} */