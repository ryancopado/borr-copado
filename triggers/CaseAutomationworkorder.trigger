trigger CaseAutomationworkorder on WorkOrder (after update) {
    Workorder wo=Trigger.new[0];
    List<workorder>workorderrecords=new List<workorder>();
    if(Trigger.oldmap.get(wo.id).Status != Trigger.newmap.get(wo.id).Status && Trigger.newmap.get(wo.id).Status == 'Completed')
    {
        //workorderrecords=[select id,CaseId,status from workorder where CaseId=:wo.CaseId and Status='Completed'and id=:wo.id]; and ];
         //if(workorderrecords.size()>0) 
        //{
             //workorder newWO=new workorder();
            //newWO=workorderrecords.get(0);
            
            case caseupdate=new case();
            caseupdate.id=wo.CaseId;
            caseupdate.status='Ops Review';
            update caseupdate;
            
            
       // }
        
        }
    }