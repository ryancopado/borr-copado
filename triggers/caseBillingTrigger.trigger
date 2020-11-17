trigger caseBillingTrigger on Case (after insert, after update) {
    List<id> acceptedCases = new list<Id>();
    //Id devRecordTypeId = Schema.SObjectType.case.getRecordTypeInfosByName().get('Reactive - Borrego Warranty').getRecordTypeId();
if(checkRecursive.runOnce())
{
    if (trigger.isInsert) {
        system.debug('this is insert-->');
        for (Case c : trigger.new) {
            if (c.status == 'Closed') {
                acceptedCases.add(c.id);
            }
        }
    } else if (trigger.isUpdate) {
        
        system.debug('this is update-->');
        for (Case c : trigger.new) {
            system.debug('old status value-->' +Trigger.oldMap.get(c.id).Status );
            system.debug('New status value-->' +Trigger.newMap.get(c.id).Status);
            if (Trigger.oldMap.get(c.id).Status != Trigger.newMap.get(c.id).Status && Trigger.NewMap.get(c.id).Status == 'Closed') {
              system.debug('this is if condition-->');
                acceptedCases.add(c.id);
            }
        }
    }
    
    system.debug('this is caseid -- >' +acceptedCases);
    if(!acceptedCases.isEmpty()){
        
         CaseTriggerHandler.acceptedCase(acceptedCases);
    }
}
}