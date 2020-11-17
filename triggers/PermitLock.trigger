trigger PermitLock on Permit_PJ__c (before update, before delete) {
    if(Trigger.isDelete) {
        for (Integer i = 0; i <Trigger.old.size(); i++) {
            if(Trigger.old[i].IsRejected__c == true) {
                Trigger.old[i].addError(' This record cannot be deleted.');
            }
        }
    }  
    if(Trigger.isUpdate) {
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            if(Trigger.old[i].IsRejected__c == true && Trigger.new[i].IsRejected__c == true) {
                Trigger.new[i].addError(' This record cannot be edited.');
            }
        } 
    }
}