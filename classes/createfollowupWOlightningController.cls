public class createfollowupWOlightningController {
@AuraEnabled
    
    public  static string Workordercreate(Id WOId) 
    {
      string result; 
        
        List<workorder>workorderlist=new List<workorder>();
        workorder workorderrecords=new workorder ();
        workorder newWo = new workorder();
        workorderlist=[select Owner.Name,ServiceTerritoryId,Street,city,state,country,PostalCode,Maintenance_Type__c,AccountId,CaseId,Billable__c,Priority,Address,StartDate,Project__c,FSL__Scheduling_Priority__c,Contract__c,Work_Start_Time__c,Work_End_Time__c,WorkTypeId,Subject,Travel_Start_Time__c,Description from workorder where Id=:WOId];
        workorderrecords=workorderlist.get(0);
        newWo.Status = 'New';
        newWo.Project__c = workorderrecords.Project__c;
        newWo.Contract__c = workorderrecords.Contract__c;
        newwo.CaseId = workorderrecords.CaseId;
        newWo.AccountId = Workorderrecords.AccountId;
        
        newwo.OwnerId = workorderrecords.OwnerId;
        newwo.Subject = workorderrecords.subject;
        newwo.Description = workorderrecords.Description;
        newwo.ServiceTerritoryId = workorderrecords.ServiceTerritoryId;
        newwo.WorkTypeId =workorderrecords.WorkTypeId;
        newwo.Billable__c = workorderrecords.Billable__c;
        newwo.Priority = workorderrecords.Priority;
        newwo.StartDate = workorderrecords.StartDate;
        newwo.Maintenance_Type__c = workorderrecords.Maintenance_Type__c;
        newwo.Street = workorderrecords.Street;
        newwo.City = workorderrecords.City;
        newwo.State = workorderrecords.state;
        newwo.Country =workorderrecords.country;
        newwo.PostalCode=workorderrecords.PostalCode;
              
       insert newWo;
        
        
         createfollowupbatchclass bat = new createfollowupbatchclass ();
          bat.currentId =  newWo.Id; 
        bat.workrecordid=WOId;
        database.executeBatch(bat,2) ;
         List<serviceappointment>sapptlist=new List<serviceappointment>();
        serviceappointment sapprec=new serviceappointment ();
        serviceappointment getsrapp  = new serviceappointment();
        sapptlist=[select parentrecordId,EarliestStartTime,duedate,SchedEndTime,AssignedResource__c,SchedStartTime,Case__c,project__c from serviceappointment where ParentRecordId=:WOId and parentRecordtype='WorkOrder'];
         if (sapptlist.size() >0){
             getsrapp = sapptlist.get(0);
         }
        if(newWo.WorkTypeId=='08q2H0000008OIjQAM'||newWo.WorkTypeId=='08q2H0000008OIeQAM'|| newWo.WorkTypeId=='08q2H0000008OIKQA2'||newWo.WorkTypeId=='08q2H0000008OIUQA2'||newWo.WorkTypeId=='08q2H0000008OIZQA2'||newWo.WorkTypeId=='08q2H0000008OIFQA2')
        {
            List<serviceappointment>servicelist=new List<serviceappointment>();
            servicelist=[select id from serviceappointment where ParentRecordid =:newWo.id];
            if(servicelist.size()>0)
            {
                
                serviceappointment updateSA=new serviceappointment();
                updateSA=servicelist.get(0);
                 updateSA.SchedStartTime = getsrapp.SchedStartTime;
                updateSA.SchedEndTime = getsrapp.SchedEndTime;
                updateSA.Case__c=newWo.CaseId;
                updateSA.Project__c=newWo.Project__c;
                update updateSA;
                
            }
            
        }
        
        
        /* List<workorderlineitem>wolinelist=new List<workorderlineitem>();
        List<workorderlineitem> newrec = new List<workorderlineitem>();
        
        wolinelist = [select id,Checklist__c,WorkOrderId,AssetId from workorderlineitem where WorkOrderId  =:WOId and status!='Completed'];
        Integer listsize=wolinelist.size();
        for(integer i=0;i<listsize;i++)
        {
            workorderlineitem WOlinerec=new workorderlineitem ();
            workorderlineitem newWOline = new workorderlineitem();
            wolinerec.clear();
            WOlinerec=wolinelist.get(i);
            system.debug('WO LIST' +WOlinerec);
            newwoline.WorkOrderId = newwo.Id;
            newwoline.Status ='New';
            newwoline.Checklist__c = wolinerec.Checklist__c;
            newwoline.assetId = wolinerec.AssetId;
            newrec.add(newwoline);
           
        }
        system.debug(newrec);
        insert newrec;*/
       
        
        
        else
        {
       
        ID   getid = newWo.Id;
        if (sapptlist.size() >0){
             getsrapp = sapptlist.get(0);
       
       
        sapprec.ParentRecordId = getid;
        sapprec.EarliestStartTime = getsrapp.EarliestStartTime;
        sapprec.DueDate = getsrapp.duedate;
        sapprec.SchedStartTime = getsrapp.SchedStartTime;
        sapprec.SchedEndTime = getsrapp.SchedEndTime;
        sapprec.Status = 'None';
        sapprec.Case__c = getsrapp.Case__c;  
        sapprec.Project__c=getsrapp.Project__c;  
        insert sapprec;
        
        }
        }
        system.debug('service app' +sapprec);
        
       
        String hostname =URL.getSalesforceBaseUrl().getHost();
        
        system.debug('Host' +hostname);
         result= 'https://' +hostname +'/' +newwo.id;
        
        system.debug('page'+result);
        
     
        
        
        
        return result;
    }
    
    @AuraEnabled
    
    public static List<workorder>  newserviceapp(Id WOId1) 
    {
        List<workorder>  newlist = new workorder[]{};
         
        newlist = [select WorkOrderNumber,Project__c,Caseid from workorder where id=:WOId1];
        
        
        return newlist;
    
    }
}