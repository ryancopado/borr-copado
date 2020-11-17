trigger psdUpdate on PSD__c (before update, after update) { 
    
    if(Trigger.isUpdate) {
        
        if (Trigger.isBefore) {
            List<PSD__c> statChange = new List<PSD__c>();
            List<Id> conId = new List<Id>();
            for (Integer i=0; i<Trigger.new.size(); i++) {
                conId.add(Trigger.new[i].Contact__c);
            }
            Contact[] con = [select Id, Email, AccountId from Contact where Id in:conId];
            Map<Id, Contact> conMap = new Map<Id, Contact>();
            for (Integer i=0; i<con.size(); i++) {
                conMap.put(con[i].Id, con[i]);
            }
            for (Integer i = 0; i <Trigger.new.size(); i++) {
                
                if(Trigger.new[i].Status__c != Trigger.old[i].Status__c) {
                    
                    if ( (Trigger.old[i].Status__c == 'New') &&
                         (Trigger.new[i].Status__c =='Submitted') && (Trigger.new[i].Proposal_Level_Needed__c == 'L1') ) {
                        if (conMap.get(Trigger.new[i].Contact__c).Email == null) {
                            Trigger.new[i].addError(' Contact must have a valid email address.');
                        } else {
                            Trigger.new[i].Design_Partner__c = conMap.get(Trigger.new[i].Contact__c).AccountId;
                            statChange.add(Trigger.new[i]);
                        }
                    } else {
                        statChange.add(Trigger.new[i]);
                    }
                }
            }
            if(statChange.size() > 0) {
                psdUpdate.addStatusDate(statChange);
            }
        }
        
        if (Trigger.isAfter) {
            List<PSD__c> submitPSD = new List<PSD__c>();
            for (Integer i = 0; i <Trigger.new.size(); i++) {       
                if ( (Trigger.old[i].Status__c == 'New') &&
                     (Trigger.new[i].Status__c =='Submitted') && (Trigger.new[i].Proposal_Level_Needed__c == 'L1') ) {
                    submitPSD.add(Trigger.new[i]);
                }
            }
            if (submitPSD.size() >0) {
                psdUpdate.emailPreSalesDesign(submitPSD);
            }
        }
    }
/*
    if(Trigger.isDelete) {
        User SD = [select Id from User where Name = 'Jennifer Knight'];
        for (Integer i = 0; i <Trigger.old.size(); i++) {
        if(Trigger.old[i].Status__c != 'New')
            NoRoleEmail.addNoRoleEmail(SD.Id,'Pre-Sales Design Request Recalled', Trigger.old[i].Id, false);
            Trigger.old[i].addError('You cannot delete a Pre-Sales Desgin request once it has been submitted.\nAn email has been send to the SD requesting he close out the request.');
        }
    }
*/
}