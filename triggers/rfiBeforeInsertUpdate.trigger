trigger rfiBeforeInsertUpdate on Request_for_Information_RFI__c (before insert, before update) {
    
    //sets PM ids on rfis
    List<Id> projectIds = new List<Id> {};
    Map<Id, Request_for_Information_RFI__c> rfisById = new Map<Id, Request_for_Information_RFI__c> ();
    
    for (Integer i = 0 ; i< Trigger.New.size() ; i++ ) {

        try {
            if ( Trigger.new[i].ASProject__c != null ||  Trigger.new[i].ASProject__c != ''){
                projectIds.add( Trigger.new[i].ASProject__c);
                rfisById.put(Trigger.new[i].Id, Trigger.new[i]);
            }
        }catch (Exception e){
            System.debug(logginglevel.ERROR,'rfi reference error= '+ e);
            continue;
        }
        
    }
    
    if ( rfisById.size()>0){
        system.debug('      \\\\\\\\\\\\ ' + projectIds);
        system.debug('  \\\\\\\\\\\\ ' + rfisById);
        
        rfiHandler.setPM(projectIds,rfisById,false);
    }
    
}