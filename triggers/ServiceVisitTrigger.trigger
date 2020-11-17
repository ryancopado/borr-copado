trigger ServiceVisitTrigger on SV__c (after delete, after insert, after undelete, after update, before insert, before update) {
    
    /*
    if (trigger.isBefore) {
        
        if (trigger.isInsert) {
            ServiceVisitService.populateFields(trigger.new, null, trigger.isInsert);
        }
        
        if (trigger.isUpdate) {
            ServiceVisitService.populateFields(trigger.new, trigger.oldMap, trigger.isInsert);
        }
    }
    
    if (trigger.isAfter) {
        
        if (trigger.isDelete) {
            ServiceVisitService.caseBillingStatus(null, trigger.oldMap, trigger.isDelete, trigger.isInsert, trigger.isUndelete);
        }
        
        if (trigger.isInsert) {
            ServiceVisitService.caseBillingStatus(trigger.new, null, trigger.isDelete, trigger.isInsert, trigger.isUndelete);
        }
        
        if (trigger.isUndelete) {
            ServiceVisitService.caseBillingStatus(trigger.new, null, trigger.isDelete, trigger.isInsert, trigger.isUndelete);
        }
        
        if (trigger.isUpdate) {
            //ServiceVisitService.caseBillingStatus(trigger.new, trigger.oldMap, trigger.isDelete, trigger.isInsert, trigger.isUndelete, trigger.isUpdate);
            ServiceVisitService.svAfterUpdate(trigger.new, trigger.oldMap);
        }
    }
    */
}