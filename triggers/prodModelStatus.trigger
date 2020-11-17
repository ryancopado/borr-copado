trigger prodModelStatus on Con_Req__c (after update) {

    //If a Change Order has just been approved, set the Status field of the 
    //associated Production Modeling record appropriately.

    RecordType subchange = Utilities.getRecordType('Subcontractor Change Order');
    List<Id> pmId = new List<Id>();
    List<Id> oppId = new List<Id>();
    List<Production_Modeling__c> pmUpdate = new List<Production_Modeling__c>();
    for (Integer i=0; i<Trigger.size; i++) {
        if ( (Trigger.new[i].RecordTypeId == subchange.Id) &&
             (Trigger.new[i].Status__c == 'Approved' && Trigger.old[i].Status__c != 'Approved') ) {
            if (Trigger.new[i].Production_Modeling__c != null) {
                pmId.add(Trigger.new[i].Production_Modeling__c);
            }
        }
    }
    
    if (pmId.size() > 0) {
        
        //Get all the Production Modeling records that will have Status set to 'Current Approved'
        Production_Modeling__c[] pmCA = [select Id, Opportunity__c, Status__c
                from Production_Modeling__c where Id in:pmId];
        for (Integer i=0; i<pmCA.size(); i++) {
            oppId.add(pmCA[i].Opportunity__c);
        }
        
        //Get all the Production Modeling records that may have to change Status from
        //'Current Approved' to 'Previously Approved'
        Production_Modeling__c[] pmPA = [select Id, Opportunity__c, Status__c
                from Production_Modeling__c where Opportunity__c in:oppId and Id not in:pmId];
        
        for (Integer i=0; i<pmPA.size(); i++) {
            if (pmPA[i].Status__c == 'Current Approved') {
                pmPA[i].Status__c = 'Previously Approved';
                pmUpdate.add(pmPA[i]);
            }
        }
        for (Integer i=0; i<pmCA.size(); i++) {
            pmCA[i].Status__c = 'Current Approved';
            pmUpdate.add(pmCA[i]);
        }
        
        if (pmUpdate.size() > 0) {
            update pmUpdate;
        }
    }
    
}