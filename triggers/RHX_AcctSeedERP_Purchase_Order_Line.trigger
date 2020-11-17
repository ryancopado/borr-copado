trigger RHX_AcctSeedERP_Purchase_Order_Line on AcctSeedERP__Purchase_Order_Line__c
    (after delete, after insert, after undelete, after update, before delete) {
    
     Type rollClass = System.Type.forName('rh2', 'ParentUtil');
     if(rollClass != null) {
        rh2.ParentUtil pu = (rh2.ParentUtil) rollClass.newInstance();
        if (trigger.isAfter) {
            pu.performTriggerRollups(trigger.oldMap, trigger.newMap, new String[]{'AcctSeedERP__Purchase_Order_Line__c'}, null);
        }
    }
    
}