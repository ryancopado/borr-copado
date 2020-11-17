trigger retainer on Retainer__c (before delete, before update) {

  /*  //If a Retainer record is already on an Invoice, can not update or delete it.
    for (Integer i=0; i<Trigger.size; i++) {
        if (Trigger.isDelete) {
            if (Trigger.old[i].Invoice__c != null) {
                    Trigger.old[i].addError(' You cannot delete a Retainer that is on an Invoice.');
                }
        }
        if (Trigger.isUpdate) {
            if (Trigger.new[i].Invoice__c != null && Trigger.old[i].Invoice__c != null) {
                    Trigger.new[i].addError(' You cannot update a Retainer that is on an Invoice.');
                }
        }
    }
    */
}