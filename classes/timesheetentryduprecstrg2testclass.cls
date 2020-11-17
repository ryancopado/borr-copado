@isTest(seealldata=true)
public class timesheetentryduprecstrg2testclass {
    
    static testMethod void timesheetentry() {
        
        
        ServiceResource sr = [select id from serviceresource where IsActive=true limit 1];
        system.debug('this is list-->' +sr);
        
        Date myDate = date.today();
        date endofday = mydate.toStartOfWeek()+6;
        date startofday = mydate.tostartofweek() ;
        datetime starttime = datetime.now();
        datetime endtime =datetime.now();    
        datetime changeEt = endtime.addHours(1);
        timesheet ts = new timesheet(StartDate = startofday,
                                     enddate = endofday,ServiceResourceid = sr.Id,status = 'New'
                                    );
        system.debug('str date-->' +ts.StartDate);
        system.debug('end date-->' +ts.EndDate);
        insert ts;
        
        
        
        timesheetentry tse = new timesheetentry(timesheetid = ts.id,starttime=starttime ,endtime= changeEt);
        insert tse;
        
        timesheetentry tse1 = new  timesheetentry(timesheetid = ts.id, starttime = starttime.addminutes(30), endtime = changeEt.addMinutes(2));
        insert tse1;
        
    }
    
}