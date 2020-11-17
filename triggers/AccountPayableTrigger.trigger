trigger AccountPayableTrigger on AcctSeed__Account_Payable__c (before update) {
if(trigger.isBefore){
        if(trigger.isUpdate){
            AccountPayableTriggerHandler.validateApprovalReason(trigger.new,trigger.oldmap);
        }
    }
}