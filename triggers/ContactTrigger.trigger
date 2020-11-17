trigger ContactTrigger on Contact (after insert, after undelete, after update) {
    
           ContactTriggerHandler.createContactRole(trigger.New, trigger.oldMap, trigger.isUpdate, trigger.isInsert, trigger.isUndelete);
    
}