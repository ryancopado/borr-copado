trigger trgNoOpdateOppLineItems on OpportunityLineItem (Before insert,Before delete,Before update) {
    
       if(Trigger.IsInsert || Trigger.IsUpdate)          
                   For(OpportunityLineItem OLI: Trigger.NEW){
                        if (OLI.Quantity>0){
                            OLI.Project_Watts_Workflow__c=OLI.Project_Watts__c;
                        }
                    } 
                    
    
    
      If(approveELI.IsOpportunityLineItemUpdating==Null)
        approveELI.IsOpportunityLineItemUpdating=False;

    If(approveELI.IsOpportunityLineItemUpdating==False) {
    
            Map<Id,Opportunity> MapOfOpportunity=new  Map<Id,Opportunity>();
            List<Id> ListOfOpportunityIds=new List<Id>();
            id id1 = userinfo.getProfileId();
            Profile Pr=[select Name from profile where id = :id1]; 
                      
         system.debug('----------------'+Pr.Name);
               
                
                    if(Trigger.IsInsert || Trigger.IsUpdate)
                        For(OpportunityLineItem OLI: Trigger.NEW){
                              ListOfOpportunityIds.add(OLI.OpportunityId);
                        } 
                    else
                        For(OpportunityLineItem OLI: Trigger.Old){
                              ListOfOpportunityIds.add(OLI.OpportunityId);
                        } 
                    
                    MapOfOpportunity=New Map<Id,Opportunity>([Select Id,StageName From Opportunity where id in :ListOfOpportunityIds]);
             
            If(Trigger.IsInsert==true){
                 For(OpportunityLineItem OLI: Trigger.NEW){
                        Opportunity Opp=MapOfOpportunity.Get(OLI.OpportunityId);
                             If (Opp.StageName =='Contract Signed' && (Pr.Name!='System Administrator'&& Pr.Name != 'Sys Admin w/o HR')){
                                 OLI.addError('Record is locked');
                             }
                    } 
             }            
        
             If(Trigger.IsDelete==true){
                 For(OpportunityLineItem OLI: Trigger.Old){
                        Opportunity Opp=MapOfOpportunity.Get(OLI.OpportunityId);
                             If (Opp.StageName =='Contract Signed' && (Pr.Name != 'System Administrator' && Pr.Name != 'Sys Admin w/o HR')){
                                 OLI.addError('Record is locked');
                             }
                    } 
             }        
        
            If(Trigger.IsUpdate==true){
                  
                    
                    
                  
                    List<Schema.SObjectField> fields=new List<Schema.SObjectField>();
                    for (Schema.SObjectField f : OpportunityLineItem.SObjectType.getDescribe().fields.getMap().values()) {
                                    if (f.getDescribe().isUpdateable()  ==true && F.getDescribe().getName()!='Project_Watts' && 
                                            F.getDescribe().getName()!='Project_Watts_Workflow' && 
                                            f.getDescribe().getType() != DisplayType.ID && 
                                            f.getDescribe().getType() != DisplayType.Reference) {
                                        try {
                                             fields.add(f);
                                                 system.debug('1111111111'+  F.getDescribe().getName());
                                        } catch (System.SObjectException x) {
                                            // Do nothing - just means that the field was not selected in the select list
                                        }
                                    }
                                }
                
                  
                    
                    For(OpportunityLineItem OLI: Trigger.NEW){
                        Opportunity Opp=MapOfOpportunity.Get(OLI.OpportunityId);
                             If (Opp.StageName =='Contract Signed' && (Pr.Name != 'System Administrator' && Pr.Name != 'Sys Admin w/o HR')){
                                   OLI.addError('Record is locked');
                                 OpportunityLineItem OldOLI=Trigger.OldMap.Get(OLI.Id);
                                 For (Schema.SObjectField F:fields ){
                                     if (OldOLI!=null && OldOLI.Get(F.getDescribe().getName())!=null)
                                         OLI.Put(F.getDescribe().getName(), OldOLI.get(F.getDescribe().getName()));
                                 }
                             }
                    } 
                  
            }
    }    
}