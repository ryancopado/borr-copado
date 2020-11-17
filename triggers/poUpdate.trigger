trigger poUpdate on Con_PO__c (before update, after update) {
    
    RecordType major = [select Id from RecordType where Name = 'Major Component PO'];
    RecordType sub = [select Id from RecordType where Name = 'Subcontractor PO'];
        
    if(Trigger.isBefore) {
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            if (Trigger.new[i].Total_Cost_Tax__c != Trigger.old[i].Total_Cost_Tax__c) {
                Trigger.new[i].Total_Cost_Change__c = Trigger.new[i].Total_Cost_Tax__c - Trigger.old[i].Total_Cost_Tax__c;
            }
            if(Trigger.new[i].Status__c == 'PM Approved' && Trigger.old[i].Status__c != 'PM Approved' && Trigger.new[i].RecordTypeId == major.Id){
                Con_PO__History[] h = [select Field, NewValue from Con_PO__History where ParentId = :Trigger.new[i].Id and Field = 'Status__c'];
                System.debug(h.size());
                Map<Id, String> badPO = new Map<Id, String>();
                for (Integer k = 0; k < h.size(); k++) {
                    if (h[k].NewValue == 'Approved by Aaron') {
                        badPO.put(Trigger.new[i].Id, 'okay');
                    }
                }
                System.debug(badPO.size());
                if (badPO.get(Trigger.new[i].Id) != 'okay') {
                    Trigger.new[i].addError('You cannot change the Status to PM Approved until Aaron has reviewed the PO.');
                } 
            }
            
            if ( (Trigger.new[i].Tax_Rate__c != Trigger.old[i].Tax_Rate__c) ||
                 (Trigger.new[i].Tax_Exemption__c != Trigger.old[i].Tax_Exemption__c) ) {
                //Set Tax Rate to zero if Tax Exemption is set to Exempt
                if (Trigger.new[i].Tax_Exemption__c == 'Exempt') {
                    Trigger.new[i].Tax_Rate__c = 0;
                }
                //Only Lynne Parker, Anita Orozco or a System Administrator are allowed to change the Tax Rate
                Profile[] sysadmin = [select Id from Profile where Name =:'System Administrator' or Name =:'Sys Admin w/o HR'];
                Id cuId = UserInfo.getUserId();
                User user = [select Id, Name, ProfileId from User where Id =:cuId];  
                System.debug(User);           
                if (user.Name != 'Lynne Parker' && user.Name!='Anita Orozco' && user.Name!='Saralyn Frieler') {
                    Boolean wronguser = true;
                    for (Integer k=0; k<sysadmin.size(); k++) {
                        if (user.ProfileId == sysadmin[k].Id) {
                            wronguser = false;
                        }
                    }
                    if (wronguser) {
                        Trigger.new[i].addError('Only Lynne Parker, Anita Orozco and Saralyn Frieler can change the Tax Exemption Status or Tax Rate of a Construction PO.');
                    }
                }
            }
        }
    }
    if(Trigger.isAfter) {
        //This map keeps track of IDs for POs whose Total Cost has changed.
        Map<Id, Con_PO__c> poUpdate = new Map<Id, Con_PO__c>();
        List<Con_PO__c> qtyUpdate = new List<Con_PO__c>();
    
        //Trigger.new is an array of POs containing the updated values. The loop runs through the list and adds any 
        //POs that have new values to the poUpdate map.
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            if (Trigger.new[i].Total_Cost_Tax__c != Trigger.old[i].Total_Cost_Tax__c) {
                poUpdate.put(Trigger.old[i].Id, Trigger.new[i]); 
            }
            if ((Trigger.new[i].Quantity__c != Trigger.old[i].Quantity__c) && Trigger.new[i].RecordTypeId == major.Id) {
                qtyUpdate.add(Trigger.new[i]); 
            } 
        }
        if(poUpdate.size() > 0){
            conPO.updatePrice(poUpdate);
        }
        if(qtyUpdate.size() > 0){
            conPO.upQTY(qtyUpdate);
        } 
    }
}