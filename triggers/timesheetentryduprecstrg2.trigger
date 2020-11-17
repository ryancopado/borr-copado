trigger timesheetentryduprecstrg2 on TimeSheetEntry (before insert,before update) {
    
    /* This trigger is to flag duplicate records 
* in the Time Sheet Entry object 
* if the start time entered is same within the same day time frame . */
    
    /*this is the second trigger since the first logic was checking for only start time. */
    
   TimeSheetEntry  timeentry = Trigger.new[0];
    TimeSheetEntry  timeentrylist =new TimeSheetEntry();
    
    string result;
     List<TimeSheetEntry> timeentrylist1 = new List<TimeSheetEntry>();
    datetime cmpstartdate = timeentry.StartTime.date();
    datetime cmpenddate = timeentry.endTime.date();
    time cmpstarttime = timeentry.StartTime.time();
    time cmpendtime = timeentry.endTime.time();
    
    if (trigger.Isinsert){
      timeentrylist1 = [select id,starttime ,endtime from TimeSheetEntry where timesheetId =: timeentry.TimeSheetId ];   
    }
    if (trigger.isupdate){
        timeentrylist1 = [select id,starttime ,endtime from TimeSheetEntry where timesheetId =: timeentry.TimeSheetId and id!= :timeentry.id ];   
        
    }
   
    system.debug('the size'+timeentrylist1.size());
    system.debug('the list'+timeentrylist1);
    boolean four;
    boolean one;
    boolean two;
    boolean three;
    
    for (TimeSheetEntry tse : timeentrylist1){
        system.debug('this is the for loop--->');
    
        
        datetime getstartdate =  tse.StartTime.date();
        datetime getenddate = tse.EndTime.date();
        system.debug('get date1--> ' +getstartdate );
        system.debug('get cmpstart--> ' +cmpstartdate );
        system.debug('get date2--> ' +getenddate );
        system.debug('get cmpenddate--> ' +cmpenddate );
        
        boolean samedate1  = getstartdate.isSameDay(cmpstartdate);
        boolean samedate2  = getenddate.issameday(cmpenddate); 
        
        if (samedate1 ==true || samedate2 == true ) {
            
            datetime getstarttime = tse.StartTime;
            integer gethr = getstarttime.hour();
            integer getmin = getstarttime.minute();
            integer getsec = getstarttime.second();
            integer getmsec = getstarttime.millisecond(); 
            
            datetime getendtime = tse.EndTime;
            integer gethr1 = getendtime.hour();
            integer getmin1 = getendtime.minute();
            integer getsec1 = getendtime.second();
            integer getmsec1 = getendtime.millisecond(); 
            
            time time_1  = time.newInstance(gethr, getmin, 0, 0) ;
            time time_2  = time.newInstance(gethr1, getmin1, 0, 0) ;
            
            
            system.debug('this is start time-->' +time_1 );
            system.debug('this is compare sttime-->' +cmpstarttime );
            system.debug('this is endtime time-->' +time_2 );
            system.debug('this is compare endtime-->' +cmpendtime );
            
                    
            one = ( time_1 >= cmpstarttime && time_1 < cmpendtime );
            two = (time_2 > cmpstarttime && time_2 <= cmpendtime);
                     
            system.debug('boolen value------>' + one); // || four == true|| two == true|| three == true || four == true
            system.debug('boolean value-->' +two);
            
            if (one==true   || two ==true ){
                
                system.debug('the main time is equal--->');
                result='update';
                break;
            }
            
        } 
        
        
    }
    if(trigger.Isinsert){  
        if (result =='update'){
            
            system.debug('this is the id' +timeentry.Id);
            
            timeentry.Duplicate_Value__c = 'alert';
            
            
        }   
    }
    
    if(trigger.isupdate){
        
        if (Trigger.oldmap.get(timeentry.id).starttime != timeentry.StartTime || Trigger.oldmap.get(timeentry.id).endtime != timeentry.endtime ) {
            
            system.debug('this is the update trigger');
            system.debug('boolen value------>' + one); 
            system.debug('boolean value-->' +two);
                       
            if (one==true  || two ==true ){
              
                timeentry.Duplicate_Value__c = 'alert';
                
                
            }
            
            else {
                system.debug('this is update else condition');
                timeentry.Duplicate_Value__c = '';
               
            }
            
            
        } 
    }
}