global class BatchResourceWeeklyTimesheets implements Database.Batchable<sObject> , Schedulable
{
	/* David Berman, ReattionEdge, 21 June 2019
	 * Scheduled job to create a timesheet for every active
	 * Service Resource on a Sunday,  to run from Sunday
	 * to Saturday.
	 * 
	 * Runs at 2am on Sundays
	 */
 	
    global Database.QueryLocator start(Database.BatchableContext BC) 
	{
        String query = 'SELECT Id, Name FROM ServiceResource WHERE isActive = true ORDER BY Name ';
        query += Test.isRunningTest() ? ' LIMIT 1' : '';
        
        return Database.getQueryLocator(query);
    }
    
    
    global void execute(Database.BatchableContext BC, List<ServiceResource> scope) 
	{
        Integer iNumRecords = scope.size();
        Integer j = 0;
        List<Timesheet> listTimesheets = new List<Timesheet>();
        
        Date dtToday = SYSTEM.TODAY();
        Date dtSunday = dtToday.toStartOfWeek();
        Date dtStartOfWeek = dtSunday == dtToday ? dtSunday : dtSunday.addDays(7);
		Date dtEndOfWeek = dtStartOfWeek.addDays( 6 );
        
        while(j < iNumRecords)
        {
            Timesheet ts = new Timesheet();
            ts.Status = 'New';
            ts.ServiceResourceId = scope[j].Id;
            ts.StartDate = dtStartOfWeek;
            ts.EndDate = dtEndOfWeek;
            
            try{ insert ts;}catch(Exception ex){ SYSTEM.DEBUG('+++++ resource / error: ' + scope[j].Name + ' -- ' + ex.getMessage());}
            
            j += 1;
        }
     
    }
    
    
    global void execute(SchedulableContext sc) 
	{  

	    BatchResourceWeeklyTimesheets batch = new BatchResourceWeeklyTimesheets();
	    Database.executeBatch(batch);

	    //remove from scheduled job list
	    try{System.abortJob( sc.getTriggerID() );}catch(Exception e){}
	}
    

	global void finish(Database.BatchableContext BC) 
	{
        Date dtToday = SYSTEM.TODAY();
        Date dtSunday = dtToday.toStartOfWeek();
        Date dtNextRun = dtSunday.addDays(7);
        Integer iDay = dtNextRun.day();
        Integer iMonth = dtNextRun.month();
        Integer iYear = dtNextRun.year();
        
        // Schedule next run
		Datetime sysTime = System.now();
	    
	    String chron_exp = '' + sysTime.second() + ' ' + 0 + ' ' + 2 + ' ' + iDay + ' ' + iMonth + ' ? ' + iYear;
	    if(!Test.isRunningTest())	
	    {
	    	try{System.schedule('Timesheet run for active Service Resources', chron_exp, this);}catch(Exception ex){}
	    }
    }
}