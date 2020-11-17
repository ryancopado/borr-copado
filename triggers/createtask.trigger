trigger createtask on Account (after update) {
    Account ac=Trigger.new[0];
    Task newtask=new Task();
    Opportunity newopp=new Opportunity();
    List<Task> taskList = new List<Task>();
         if(Trigger.oldmap.get(ac.id).Procurement_Phase__c != Trigger.newmap.get(ac.id).Procurement_Phase__c && (Trigger.newmap.get(ac.id).Procurement_Phase__c == 'b. Investigating' || Trigger.newmap.get(ac.id).Procurement_Phase__c == 'c. Procuring') )
        //if(ac.Procurement_Phase__c=='b. Investigating' || ac.Procurement_Phase__c=='c. Procuring')
        {
            List<Opportunity> OppList=new List<Opportunity>();
            OppList=[select id,SalesOps_Qualified__c,Ownerid from opportunity where AccountId=:ac.id and SalesOps_Qualified__c=true];
             if(OppList.size()>0 )
            {
                Integer size = OppList.size();
                for(integer i=0;i<size;i++)
            {
                newopp=OppList.get(i);
                newtask=new Task();
                newtask.OwnerId=newopp.Ownerid;
                
                newtask.RecordTypeId='012300000009EHrAAM';
               
                
                if(ac.Procurement_Phase__c=='b. Investigating')
                {
                newtask.Subject='Marketing Qualified Opp:Submit Budgetary Proposal';
                date todaydate=system.today();
                newtask.ActivityDate=todaydate.adddays(30);
                }
                else
                {
                 newtask.Subject='Marketing Qualified Opp:  Submit Full Proposal';
                 date todaydate=system.today();
                 newtask.ActivityDate=todaydate.adddays(60);
  
                }
                
                newtask.Description='Please Submit Proposoal and change stage to Prosposal Submitted';
                
                
                newtask.Activity_Type_NEW__c='other';
                newtask.WhatId=newopp.id;
                taskList.add(newtask);
                
                
            }
                insert taskList;
                
        }
        }


}