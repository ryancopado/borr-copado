trigger ConReqToConPO on Con_Req__c (before delete, after insert, before update, after update) {
        
    /*List<Con_Req__c> newCR = new List<Con_Req__c>();
    
    // Get Construction Requisition records we are interested in
    if (Trigger.isInsert) {
        for (Integer i=0; i<Trigger.new.size(); i++) {
            if (Trigger.new[i].Status__c == 'Approved' && (Trigger.new[i].Record_Type_Name__c == 'Subcontractor Requisition' || Trigger.new[i].Record_Type_Name__c == 'Subcontractor Change Order')) {
                newCR.add(Trigger.new[i]);
            }
        }
        if (newCR.size() > 0) {
            conReqToconPO.toConPO(newCR, 0);
        }
    }
    
    if (Trigger.isUpdate) {
        for (Integer i=0; i<Trigger.new.size(); i++) {
            if (Trigger.isBefore) {
                if (Trigger.new[i].Record_Type_Name__c == 'Subcontractor Change Order') {               
                    Trigger.new[i].Amount_Requested_Change__c = 0;
                    if (Trigger.new[i].Status__c == 'Approved') {
                        if (Trigger.old[i].Status__c != 'Approved') {
                            Trigger.new[i].Amount_Requested_Change__c = Trigger.new[i].Amount_Requested__c;
                        } else {
                            Trigger.new[i].Amount_Requested_Change__c = Trigger.new[i].Amount_Requested__c - Trigger.old[i].Amount_Requested__c;
                        }
                    }
                    if (Trigger.new[i].Status__c == 'Recalled' && Trigger.old[i].Status__c == 'Approved') {
                        Trigger.new[i].Amount_Requested_Change__c = 0 - Trigger.old[i].Amount_Requested__c;
                    }
                }
            } else {
                if (Trigger.new[i].Record_Type_Name__c == 'Subcontractor Change Order' && Trigger.new[i].Amount_Requested_Change__c != 0) {
                    newCR.add(Trigger.new[i]);
                }
                if (Trigger.new[i].Record_Type_Name__c == 'Subcontractor Requisition' && (Trigger.new[i].Status__c == 'Approved' || Trigger.new[i].Status__c == 'Recalled')) {
                    if ((Trigger.new[i].Status__c == 'Approved' && Trigger.old[i].Status__c != 'Approved') ||
                        (Trigger.new[i].Status__c == 'Recalled' && Trigger.old[i].Status__c != 'Recalled') ||
                        (Trigger.new[i].Retention_Held__c != Trigger.old[i].Retention_Held__c) ||
                        (Trigger.new[i].Retention_Percent__c != Trigger.old[i].Retention_Percent__c)) {
                        newCR.add(Trigger.new[i]);
                    }
                }
            }
        }
        if (newCR.size() > 0) {
            conReqToconPO.toConPO(newCR, 1);
        }
    }
    
    if (Trigger.isDelete) {
        for (Integer i=0; i<Trigger.old.size(); i++) {
            if (Trigger.old[i].Status__c == 'Approved' && (Trigger.old[i].Record_Type_Name__c == 'Subcontractor Requisition' || Trigger.old[i].Record_Type_Name__c == 'Subcontractor Change Order')) {
                newCR.add(Trigger.old[i]);
            }
        }
        if (newCR.size() > 0) {
            conReqToconPO.toConPO(newCR, 2);
        }
    }*/
}