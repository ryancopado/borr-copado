trigger WorkOrderTrigger on WorkOrder (before insert, before update, after delete, after insert, after undelete, after update) {
    
    if (trigger.isBefore) {
        
        if (trigger.isInsert) {
            WorkOrderService.determineBilling(trigger.new, null, trigger.isInsert);
        }
        
        if (trigger.isUpdate) {
            WorkOrderService.determineBilling(trigger.new, trigger.oldMap, trigger.isInsert);
        }
    }
    
    if (trigger.isAfter) {
        
        if (trigger.isDelete) {
            WorkOrderService.caseBillingStatus(trigger.new, trigger.oldMap, trigger.isDelete, trigger.isInsert, trigger.isUndelete, trigger.isUpdate);
        }
        
        if (trigger.isInsert) {
            WorkOrderService.caseBillingStatus(trigger.new, null, trigger.isDelete, trigger.isInsert, trigger.isUndelete, trigger.isUpdate);
        }
        
        if (trigger.isUndelete) {
            WorkOrderService.caseBillingStatus(trigger.new, null, trigger.isDelete, trigger.isInsert, trigger.isUndelete, trigger.isUpdate);
        }
        
        if (trigger.isUpdate) {
            WorkOrderService.caseBillingStatus(trigger.new, trigger.oldMap, trigger.isDelete, trigger.isInsert, trigger.isUndelete, trigger.isUpdate);
        }
    }
}