global class createfollowupbatchclass implements Database.Batchable<sObject>  {
    global Id currentId ;
    global Id workrecordid;

    global Database.QueryLocator start(Database.BatchableContext BC)
    {
         return Database.getQueryLocator('select id,Checklist__c,WorkOrderId,AssetId from workorderlineitem where WorkOrderId  =:workrecordid and Status!= \'Completed\' ');
       
    }
    global Void execute(Database.BatchableContext BC, List<workorderlineitem> workorderlinelist)
    {
        
         List<workorderlineitem>wolinelist=new List<workorderlineitem>();
        
        List<workorderlineitem> newrec = new List<workorderlineitem>();
        //wolinelist = [select id,Checklist__c,WorkOrderId,AssetId from workorderlineitem where WorkOrderId  =:currentId and status!='Completed'];
        Integer listsize=workorderlinelist.size();
         try 
        {
            
             for(integer i=0;i<listsize;i++)
        {
              workorderlineitem WOlinerec=new workorderlineitem ();
              workorderlineitem newWOline = new workorderlineitem();
            wolinerec.clear();
            WOlinerec=workorderlinelist.get(i);
            system.debug('WO LIST' +WOlinerec);
           newwoline.WorkOrderId = currentId;
            newwoline.Status ='New';
            newwoline.Checklist__c = wolinerec.Checklist__c;
            //newwoline.Checklist_Record_Type__c = wolinerec.Checklist_Record_Type__c;
            // newwoline.Checklist_Record_Type_Name__c = wolinerec.Checklist_Record_Type_Name__c;
            // newwoline.Asset_Type__c = wolinerec.Asset_Type__c;   
            //newwoline.Asset_Fault__c = wolinerec.Asset_Fault__c;
            newwoline.assetId = wolinerec.AssetId;
            newrec.add(newwoline);
           
        }
        system.debug('this is before');
        insert newrec;
         system.debug('WOL Records'  +newrec);
             
        /*List<serviceappointment>sapptlist=new List<serviceappointment>();
        serviceappointment sapprec=new serviceappointment ();
        serviceappointment getsrapp  = new serviceappointment();
        sapptlist=[select parentrecordId,EarliestStartTime,duedate,SchedEndTime,AssignedResource__c,SchedStartTime from serviceappointment where ParentRecordId=:currentId and parentRecordtype='WorkOrder'];
        ID   getid = currentId;
        if (sapptlist.size() >0){
             getsrapp = sapptlist.get(0);
       
       
        sapprec.ParentRecordId = getid;
        sapprec.EarliestStartTime = getsrapp.EarliestStartTime;
        sapprec.DueDate = getsrapp.duedate;
       // sapprec.AssignedResource__c = getsrapp.AssignedResource__c;
        sapprec.SchedStartTime = getsrapp.SchedStartTime;
        sapprec.SchedEndTime = getsrapp.SchedEndTime;
        sapprec.Status = 'None';
        insert sapprec;
        }
         system.debug('SA Records'  +sapprec);*/
             
             
        }  
         catch(Exception e) {
            System.debug('Error occured during execution.'+e);
        }

}
     global void finish(Database.BatchableContext BC) 
    {
        // execute any post-processing operations
    }
}