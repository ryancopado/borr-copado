trigger createConPO on Con_Req__c (before update, after update) {


    RecordType change = Utilities.getRecordType('Change Order');
    RecordType subchange = Utilities.getRecordType('Subcontractor Change Order');
    
    List<Con_Req__c> change_reqs = new List<Con_Req__c>();

/* If(approveELI.IsRecursiveUpdate==Null)
        approveELI.IsRecursiveUpdate=False;

    If(approveELI.IsRecursiveUpdate==False){
  */  
    if (Trigger.isBefore) {
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            
            //set some base values
            String newStatus = Trigger.new[i].Status__c;
            String oldStatus = Trigger.old[i].Status__c;
            Boolean isChangeOrder = isChangeOrder( Trigger.new[i].RecordTypeId );
            //Boolean isServiceVisit = Trigger.new[i].Service_Visit__c == null ? false : true;
            
            if( justChangedTo ('Approved', newStatus , oldStatus) &&
                isChangeOrder){
                    
                change_reqs.add(Trigger.new[i]);
                
                AcctSeed__Project__c proj = [select Id, EC__c from AcctSeed__Project__c where Id = :Trigger.new[i].ASProject__c];
                //NoRoleEmail.addNoRoleEmail(proj.EC__c,'Change Order - Approved',Trigger.new[i].Id, false);
            }
        }
    }
    if (Trigger.isAfter) {
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            if( justChangedTo ('Sent for Signature', Trigger.new[i].Status__c , Trigger.old[i].Status__c) &&
                Trigger.new[i].RecordTypeId != subchange.Id) {
                submitApproval.submit(Trigger.new[i].Id, 'CO is signed by customer - please approve.');
            }
        }
    }
    
    if(change_reqs.size() > 0) {
        createConPO.updateCO(change_reqs);
    }
    
 // }
    
    Boolean justChangedTo (String compareValue, String newValue, String oldValue) {
        if (newValue == compareValue && oldValue != compareValue) {
            return true;
        }
        return false;
    }
    
    Boolean isChangeOrder ( Id recordTypeId ) {
       /* if (recordTypeId == change.Id || recordTypeId == subchange.Id){
            return true;
        }*/
        return true;
    }
    
    
}