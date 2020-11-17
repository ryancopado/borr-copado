trigger RHX_DMAPP_DM_Qualifier_Answer on DMAPP__DM_Qualifier_Answer__c
    (after delete, after insert, after undelete, after update, before delete) {
    
     Type rollClass = System.Type.forName('rh2', 'ParentUtil');
     if(rollClass != null) {
        rh2.ParentUtil pu = (rh2.ParentUtil) rollClass.newInstance();
        if (trigger.isAfter) {
            pu.performTriggerRollups(trigger.oldMap, trigger.newMap, new String[]{'DMAPP__DM_Qualifier_Answer__c'}, null);
        }
    }
    
}