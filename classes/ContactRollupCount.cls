global class ContactRollupCount implements Database.Batchable<sObject>
{

    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id FROM Opportunity';
        system.debug('----'+query);
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Opportunity> scope)
    {
        Set<id> ids= new Set<Id>();
        for ( Opportunity opp: scope)
        {
            ids.add(opp.id);
        }
        system.debug('----'+scope.size());
        List<opportunity> opplist=new List<opportunity>();
        List<opportunity> oppupdatelist=new List<opportunity>();
        oppList=[select id,(select id from Opportunitycontactroles) from opportunity where ID in :Ids];
        system.debug('----'+oppList.size());
        for ( Opportunity opp: opplist)
        {
           if(opp.Opportunitycontactroles.size()>0){ 
               opp.Contact_Roles_Created__c= opp.Opportunitycontactroles.size();
               oppupdatelist.add(opp);
               system.debug('----'+opp);
           }
        }
        if(oppupdatelist!=null && oppupdatelist.size()>0){
            update oppupdatelist;
            system.debug('@@@@@'+oppupdatelist.size());
        }
    }  
    global void finish(Database.BatchableContext BC)
    {
    }
}