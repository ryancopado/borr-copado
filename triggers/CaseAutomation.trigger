trigger CaseAutomation on ServiceAppointment (after update,After insert) {
    
   ServiceAppointment sa=Trigger.new[0];
    List<serviceappointment> SArecords=new List<serviceappointment>();
   
   if  (Trigger.isUpdate) {
   
     if(Trigger.oldmap.get(sa.id).Status != Trigger.newmap.get(sa.id).Status && Trigger.newmap.get(sa.id).Status == 'Scheduled')
    {
        
    
    
       SArecords=[select id,Case__c,ParentRecordId from serviceappointment where id=:sa.id and (ParentRecordStatusCategory ='New'OR ParentRecordStatusCategory ='In progress')];
       if(SArecords.size()>0)
       {
           serviceappointment SA=new serviceappointment();
           SA=SArecords.get(0);
           case updatecase=new case();
           updatecase.id=SA.Case__c;
           updatecase.status='Scheduled';
           update updatecase;
       }
    }
    
     if(Trigger.oldmap.get(sa.id).Status != Trigger.newmap.get(sa.id).Status && Trigger.newmap.get(sa.id).Status == 'None')
    {
        
    
    
       SArecords=[select id,Case__c,ParentRecordId from serviceappointment where id=:sa.id and (ParentRecordStatusCategory ='New'OR ParentRecordStatusCategory ='In progress')];
       if(SArecords.size()>0)
       {
           serviceappointment SA=new serviceappointment();
           SA=SArecords.get(0);
           case updatecase=new case();
           updatecase.id=SA.Case__c;
           updatecase.status='Ready to Schedule';
           update updatecase;
       }
       
    }
   
   
   }
    if(Trigger.isInsert){
       //
       
         system.debug('this is sa id' +sa.id);
   List<workorder> getwolist = new List<workorder>();
       system.debug('look here id-->' +sa.ParentRecordid);
       workorder getmpid = new workorder();
       getmpid =[select MaintenancePlanid from workorder where id=: sa.ParentRecordId];
       
      system.debug('this is maintenance id' +getmpid.MaintenancePlanid);
       if (getmpid.MaintenancePlanid != null) {
            getwolist = [select id,Caseid,Project__c from workorder where MaintenancePlanid=:getmpid.MaintenancePlanid];
         workorder getwovalues = new workorder();
       if (getwolist.size()>0){  
           getwovalues  = getwolist.get(0);
       }
        List<Id> getspid = new List<Id>();

        for(workorder sarec : getwolist){
        getspid.add(sarec.id);
        }
       List<Serviceappointment> sappid =new list<serviceappointment>();
       List<Serviceappointment> finalsapprec =new list<serviceappointment>();
       sappid =[select id,parentrecordid from serviceappointment where parentrecordid IN :getspid];
      
       for (serviceappointment sarecupdate : sappid){
           workorder getworec = new workorder();
           getworec = [select caseid,project__c,id from workorder where id = :sarecupdate.ParentRecordId ];
            serviceappointment saupdate=new serviceappointment();
           system.debug('look here 2-->' +sarecupdate.id);
           
          saupdate.id =  sarecupdate.Id;
          saupdate.case__c = getworec.Caseid;
          saupdate.Project__c = getworec.Project__c;
          saupdate.Work_Order__c = getworec.id;
           finalsapprec.add(saupdate);
       }
       if (!finalsapprec.isEmpty()){
         system.debug('update final ' +finalsapprec);
           update finalsapprec;
       }
           
       }  
           
         
           
       } 
    
         
        
    }