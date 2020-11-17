trigger POTrigger on AcctSeedERP__Purchase_Order__c (after update) {
    Set<Id> Ids=new Set<Id>();
    
    
    
    for(AcctSeedERP__Purchase_Order__c po:Trigger.new){
        if(po.AcctSeedERP__Status__c =='Closed' && po.AcctSeedERP__Status__c != Trigger.Oldmap.get(po.Id).AcctSeedERP__Status__c )
        {
        if(po.Con_Req_Group__c!=null)
        {
        
        
        List<Con_Req_Group__c> conreq= new List<Con_Req_Group__c>();
        conreq=[select id,recordType.Name from Con_Req_Group__c where id=:po.Con_Req_Group__c and recordType.Name='Service Visit'];
        
       if(conreq.size()>0)
       {
       
        
        
            Ids.add(po.Case__c);
        }
    }
    }
    if(Ids !=null && ids.size()>0){
        POTriggerHandler.BillingLine(ids);
    }
}
}