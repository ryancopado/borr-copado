public without sharing class NonExemptController
{

    private final Non_Exempt_Time__c cds;
    

    //public Non_Exempt_Time__c cds{get; set;}
    

     
    
 /*   public Non_Exempt_Time__c setcds(Non_Exempt_Time__c op)
    {
        //this.cds=op;
        
       return cds;
    } */
        
    public nonexemptcontroller(ApexPages.StandardController controller) 
    {
        cds=(Non_Exempt_Time__c)controller.getRecord();
        cds.Employee_Name__c = Userinfo.getuserId();
        system.debug('Employee Name'+cds.Employee_Name__c);
        Date d = System.Today(); 
        Date dold = d.toStartOfWeek() - 7;
        system.debug('start of week'+d.toStartofWeek());
        String LastWeek = dold.format();
        system.debug('Last week - '+LastWeek);
        Date dnew=date.parse(LastWeek);        
        system.debug('Date week - '+dnew);
        List<AcctSeed__Time_Card_Period__c> litimeperiod = [SELECT Id,Name FROM AcctSeed__Time_Card_Period__c where AcctSeed__Start_Date__c =:dnew];
        system.debug('time card -' +litimeperiod);
        if(litimeperiod.size()>0)
         {
         cds.Time_Card_Week__c=litimeperiod.get(0).Id;
         }
     }
    
    public PageReference Save()
    {
    
        Non_Exempt_Time__c cd = new Non_Exempt_Time__c();
        
        SV__c objSV = new SV__c();
        //String userid=String.valueOf().substring(0, 15);
        //Id empid = Id.valueOf(userid);
        cd.Employee_Name__c=cds.Employee_Name__c;
        system.debug('Emp Name - '+cd.Employee_Name__c);
        cd.Time_Card_Week__c=cds.Time_Card_Week__c;
        id nonexemptid=cd.Id; 
        system.debug('Time_Card_Week__c - ' +cd.Time_Card_Week__c);
       
        PageReference pg = null;
        List<Non_Exempt_Time__c>listnonexempt=[select id,Employee_Name__c,Time_Card_Week__c from Non_Exempt_Time__c where Employee_Name__c=:cd.Employee_Name__c and Time_Card_Week__c=:cd.Time_Card_Week__c];
        if(listnonexempt.size()>0)
         {
             system.debug('Time Card Size'+listnonexempt.size());
             ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nonexempt Time Card Already exist for the employee and Timecard week'));
             
             //pg.setRedirect(false); 
         } 
         else
         {
            List<SV__c> listitem = [Select id,Technician__c,Day_of_the_week__c,TravelWorkHours__c,SiteArrivalTime__c,WorkStarted__c,Work_Ended__c,PrevailingWageIncluded__c,NonActiveCategories__c from SV__c WHERE Technician__c in (select id from contact where  SF_User_Record__c=:cd.Employee_Name__c) and Time_Card_Period__c= :cd.Time_Card_Week__c];
            system.debug('Service vist records for timeperiod '+listitem);
            if(listitem.size() > 0)
            {
                system.debug('Service vist records for timeperiod '+listitem.size());
                for (integer i=0;i<listitem.size();i++)
                {  
                    objSV = listitem.get(i);       
                    system.debug('Day of the week --'+objSV.Day_of_the_week__c);
                    if(objSV.Day_of_the_week__c=='Sunday')
                        {
                        system.debug('Day of the week Sunday - '+objSV.TravelWorkHours__c);
                         
                            
                            if(objSV.NonActiveCategories__c=='Holiday')
                            {
                            if(cd.Sunday_Holiday_Total__c==null)
                            {
                               cd.Sunday_Holiday_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Sunday_Holiday_Total__c= cd.Sunday_Holiday_Total__c+objSV.TravelWorkHours__c;
                              }
                              }
                              if(objSV.NonActiveCategories__c=='sick' || objSV.NonActiveCategories__c=='vacation')
                              {
                              if(cd.Sunday_Vacation_Sick_Total__c==null)
                              {
                                cd.Sunday_Vacation_Sick_Total__c=objSV.TravelWorkHours__c;
                               }
                               else
                             { 
                              cd.Sunday_Vacation_Sick_Total__c= cd.Sunday_Vacation_Sick_Total__c+objSV.TravelWorkHours__c;
                              }
                              }
                              
                             else
                             {   
                            
                            if(cd.Sunday_Total_Hours_Worked__c==null)
                            {
                                cd.Sunday_Total_Hours_Worked__c=objSV.TravelWorkHours__c;
                            }
                            else
                            {
                                cd.Sunday_Total_Hours_Worked__c=cd.Sunday_Total_Hours_Worked__c+objSV.TravelWorkHours__c;
                            }
                            system.debug('Day of the week Sunday Total Hours- '+cd.Sunday_Total_Hours_Worked__c);
                            if(cd.Sunday_Start_Time__c==null)
                            {
                                AggregateResult[] minWorkStartTime=[Select MIN(SiteArrivalTime__c)minSiteArrival,MIN(WorkStarted__c)minStart from SV__c where Day_of_the_week__c='Sunday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                if(minWorkStartTime.size()>0)
                                {
                                    
                                    Datetime dt = (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    Datetime dt1 = (Datetime)minWorkStartTime[0].get('minStart');
                                    if (dt == null && dt1 !=null){
                                        cd.Sunday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');
                                    }
                                    else if (dt !=null && dt1 == null){
                                        cd.Sunday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else if (dt !=null && dt1 !=null && dt < dt1)
                                    {
                                        cd.Sunday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else 
                                    {
                                         cd.Sunday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');   
                                    }
                                    system.debug('Day of the week Sunday Start Time - '+cd.Sunday_Start_Time__c);
                                }
                             }
                             if(cd.Sunday_End_Time__c==null)
                             {
                                 AggregateResult[] maxWorkEndTime=[Select MAX(Work_Ended__c)maxEnd from SV__c where Day_of_the_week__c='Sunday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                 if(maxWorkEndTime.size()>0)
                                {
                                    cd.Sunday_End_Time__c=(Datetime)maxWorkEndTime[0].get('maxEnd');
                                    system.debug('Day of the week Sunday End Time - '+cd.Sunday_End_Time__c);
                                }
                             }              
                        }
                        }
                        
                        else if (objSV.Day_of_the_week__c=='Monday')
                        {
                            system.debug('Day of the week Monday Travel Hours- '+objSV.TravelWorkHours__c);
                            if(objSV.NonActiveCategories__c=='Holiday')
                            {
                            if(cd.Monday_Holiday_Total__c==null)
                            {
                               cd.Monday_Holiday_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Monday_Holiday_Total__c = cd.Monday_Holiday_Total__c+objSV.TravelWorkHours__c;
                              }
                              
                             }
                             if(objSV.NonActiveCategories__c=='Sick'||objSV.NonActiveCategories__c=='Vacation')
                            {
                            if(cd.Monday_Vacation_Sick_Total__c==null)
                            {
                               cd.Monday_Vacation_Sick_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Monday_Vacation_Sick_Total__c= cd.Monday_Vacation_Sick_Total__c+objSV.TravelWorkHours__c;
                              }
                              
                             }
                             else 
                             { 
                            
                            if(cd.Monday_Total_Hours_Worked__c==null)
                            {
                                cd.Monday_Total_Hours_Worked__c=objSV.TravelWorkHours__c;
                            }
                            else{
                                cd.Monday_Total_Hours_Worked__c=cd.Monday_Total_Hours_Worked__c+objSV.TravelWorkHours__c;
                            }
                            system.debug('Day of the week Monday Total Hours- '+cd.Monday_Total_Hours_Worked__c);
                            if(cd.Monday_Start_Time__c==null)
                            {
                                AggregateResult[] minWorkStartTime=[Select MIN(SiteArrivalTime__c)minSiteArrival,MIN(WorkStarted__c)minStart from SV__c where Day_of_the_week__c='Monday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                if(minWorkStartTime.size()>0)
                                {
                                    Datetime dt = (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    Datetime dt1 = (Datetime)minWorkStartTime[0].get('minStart');                               
                                    if (dt == null && dt1 !=null){
                                        cd.Monday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');
                                    }
                                    else if (dt !=null && dt1 == null){
                                        cd.Monday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else if (dt !=null && dt1 !=null && dt < dt1)
                                    {
                                        cd.Monday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else 
                                    {
                                         cd.Monday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');   
                                    }
                                    system.debug('Day of the week Monday Start Time- '+cd.Monday_Start_Time__c);
                                }
                             }
                             if(cd.Monday_End_Time__c==null)
                             {
                                 AggregateResult[] maxWorkEndTime=[Select MAX(Work_Ended__c)maxEnd from SV__c where Day_of_the_week__c='Monday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                 if(maxWorkEndTime.size()>0)
                                {
                                    
                                    cd.Monday_End_Time__c=(Datetime)maxWorkEndTime[0].get('maxEnd');
                                    system.debug('Day of the week Monday End Time- '+cd.Monday_End_Time__c);
                                }
                             } 
                        }
                        
                        }
                        else if (objSV.Day_of_the_week__c=='Tuesday')
                        {
                            system.debug('Day of the week Tuesday- '+objSV.TravelWorkHours__c);
                            if(objSV.NonActiveCategories__c=='Holiday')
                            {
                            if(cd.Tuesday_Holiday_Total__c==null)
                            {
                               cd.Tuesday_Holiday_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Tuesday_Holiday_Total__c = cd.Tuesday_Holiday_Total__c+objSV.TravelWorkHours__c;
                              }
                             
                             }
                             if(objSV.NonActiveCategories__c=='Sick'||objSV.NonActiveCategories__c=='Vacation')
                            {
                            if(cd.Tuesday_Vacation_Sick__c==null)
                            {
                               cd.Tuesday_Vacation_Sick__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Tuesday_Vacation_Sick__c= cd.Tuesday_Vacation_Sick__c+objSV.TravelWorkHours__c;
                              }
                              
                             }
                             else 
                             {
                            if(cd.Tuesday_Total_Hours_Worked__c==null)
                            {
                                cd.Tuesday_Total_Hours_Worked__c=objSV.TravelWorkHours__c;
                            }
                            else{
                                cd.Tuesday_Total_Hours_Worked__c=cd.Tuesday_Total_Hours_Worked__c+objSV.TravelWorkHours__c;
                            }
                            system.debug('Day of the week Tuesday Total Hours- '+cd.Tuesday_Total_Hours_Worked__c);
                            
                            if(cd.Tuesday_Start_Time__c==null)
                            {
                                AggregateResult[] minWorkStartTime=[Select MIN(SiteArrivalTime__c)minSiteArrival,MIN(WorkStarted__c)minStart from SV__c where Day_of_the_week__c='Tuesday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                if(minWorkStartTime.size()>0)
                                {
                                    Datetime dt = (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    Datetime dt1 = (Datetime)minWorkStartTime[0].get('minStart');
                                    system.debug('Day of the week Tuesday minSiteArrival '+dt);
                                    system.debug('Day of the week Tuesday minStart - '+dt1);
                                    if (dt == null && dt1 !=null){
                                        cd.Tuesday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');
                                    }
                                    else if (dt !=null && dt1 == null){
                                        cd.Tuesday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else if (dt !=null && dt1 !=null && dt < dt1)
                                    {
                                        cd.Tuesday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else 
                                    {
                                         cd.Tuesday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');   
                                    }
                                    
                                    system.debug('Day of the week Tuesday Start Time- '+cd.Tuesday_Start_Time__c);
                                }
                             }
                             if(cd.Tuesday_End_Time__c==null)
                             {
                                 AggregateResult[] maxWorkEndTime=[Select MAX(Work_Ended__c)maxEnd from SV__c where Day_of_the_week__c='Tuesday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                 if(maxWorkEndTime.size()>0)
                                {   
                                    cd.Tuesday_End_Time__c=(Datetime)maxWorkEndTime[0].get('maxEnd');
                                    system.debug('Day of the week Tuesday End Time- '+cd.Tuesday_End_Time__c);
                                }
                             }
                        }
                        }
                        else if (objSV.Day_of_the_week__c=='Wednesday')
                        {
                            system.debug('Day of the week Wednesday - '+objSV.TravelWorkHours__c); 
                            system.debug('Day of the week Wednesday- '+objSV.TravelWorkHours__c);
                            if(objSV.NonActiveCategories__c=='Holiday')
                            {
                            if(cd.Wednesday_Holiday_Total__c==null)
                            {
                               cd.Wednesday_Holiday_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Wednesday_Holiday_Total__c = cd.Wednesday_Holiday_Total__c+objSV.TravelWorkHours__c;
                              }
                              
                             }
                             if(objSV.NonActiveCategories__c=='Sick'||objSV.NonActiveCategories__c=='Vacation')
                            {
                            if(cd.Wednesday_Vacation_Sick_Total__c==null)
                            {
                               cd.Wednesday_Vacation_Sick_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Wednesday_Vacation_Sick_Total__c= cd.Wednesday_Vacation_Sick_Total__c+objSV.TravelWorkHours__c;
                              }
                              
                             }
                             else
                             {
                            if(cd.Wednesday_Total_Hours_Worked__c==null)
                            {
                                cd.Wednesday_Total_Hours_Worked__c=objSV.TravelWorkHours__c;
                            }
                            else{
                                cd.Wednesday_Total_Hours_Worked__c=cd.Wednesday_Total_Hours_Worked__c+objSV.TravelWorkHours__c;
                            }
                            system.debug('Day of the week Wednesday Total Hours- '+cd.Wednesday_Total_Hours_Worked__c);
                            
                            if(cd.Wednesday_Start_Time__c==null)
                            {
                                AggregateResult[] minWorkStartTime=[Select MIN(SiteArrivalTime__c)minSiteArrival,MIN(WorkStarted__c)minStart from SV__c where Day_of_the_week__c='Wednesday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                if(minWorkStartTime.size()>0)
                                {
                                    Datetime dt = (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    Datetime dt1 = (Datetime)minWorkStartTime[0].get('minStart');
                                    system.debug('Day of the week Wednesday minSiteArrival '+dt);
                                    system.debug('Day of the week Wednesday minStart - '+dt1);
                                    if (dt == null && dt1 !=null){
                                        cd.Wednesday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');
                                    }
                                    else if (dt !=null && dt1 == null){
                                        cd.Wednesday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else if (dt !=null && dt1 !=null && dt < dt1)
                                    {
                                        cd.Wednesday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else 
                                    {
                                         cd.Wednesday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');   
                                    }
                                    
                                    system.debug('Day of the week Wednesday Start Time- '+cd.Wednesday_Start_Time__c);
                                }
                             }
                             if(cd.Wednesday_End_Time__c==null)
                             {
                                 AggregateResult[] maxWorkEndTime=[Select MAX(Work_Ended__c)maxEnd from SV__c where Day_of_the_week__c='Wednesday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                 if(maxWorkEndTime.size()>0)
                                {   
                                    cd.Wednesday_End_Time__c=(Datetime)maxWorkEndTime[0].get('maxEnd');
                                    system.debug('Day of the week Wednesday End Time- '+cd.Wednesday_End_Time__c);
                                }
                             }
                        }
                        }
                        else if (objSV.Day_of_the_week__c=='Thursday')
                        {
                            system.debug('Day of the week Thursday - '+objSV.TravelWorkHours__c); 
                            system.debug('Day of the week Thursday- '+objSV.TravelWorkHours__c);
                            if(objSV.NonActiveCategories__c=='Holiday')
                            {
                            if(cd.Thursday_Holiday_Total__c==null)
                            {
                               cd.Thursday_Holiday_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Thursday_Holiday_Total__c = cd.Thursday_Holiday_Total__c+objSV.TravelWorkHours__c;
                              }
                               
                             }
                             if(objSV.NonActiveCategories__c=='Sick'||objSV.NonActiveCategories__c=='Vacation')
                            {
                            if(cd.Thursday_Vacation_Sick_Total__c==null)
                            {
                               cd.Thursday_Vacation_Sick_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Thursday_Vacation_Sick_Total__c= cd.Thursday_Vacation_Sick_Total__c+objSV.TravelWorkHours__c;
                              }
                              
                             }
                             else 
                             {
                            if(cd.Thursday_Total_Hours_Worked__c==null)
                            {
                                cd.Thursday_Total_Hours_Worked__c=objSV.TravelWorkHours__c;
                            }
                            else{
                                cd.Thursday_Total_Hours_Worked__c=cd.Thursday_Total_Hours_Worked__c+objSV.TravelWorkHours__c;
                            }
                            system.debug('Day of the week Thursday Total Hours- '+cd.Thursday_Total_Hours_Worked__c);
                            
                            if(cd.Thursday_Start_Time__c==null)
                            {
                                AggregateResult[] minWorkStartTime=[Select MIN(SiteArrivalTime__c)minSiteArrival,MIN(WorkStarted__c)minStart from SV__c where Day_of_the_week__c='Thursday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                if(minWorkStartTime.size()>0)
                                {
                                    Datetime dt = (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    Datetime dt1 = (Datetime)minWorkStartTime[0].get('minStart');
                                    system.debug('Day of the week Thursday minSiteArrival '+dt);
                                    system.debug('Day of the week Thursday minStart - '+dt1);
                                    if (dt == null && dt1 !=null){
                                        cd.Thursday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');
                                    }
                                    else if (dt !=null && dt1 == null){
                                        cd.Thursday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else if (dt !=null && dt1 !=null && dt < dt1)
                                    {
                                        cd.Thursday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else 
                                    {
                                         cd.Thursday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');   
                                    }
                                    
                                    system.debug('Day of the week Thursday Start Time- '+cd.Thursday_Start_Time__c);
                                }
                             }
                             if(cd.Thursday_End_Time__c==null)
                             {
                                 AggregateResult[] maxWorkEndTime=[Select MAX(Work_Ended__c)maxEnd from SV__c where Day_of_the_week__c='Thursday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                 if(maxWorkEndTime.size()>0)
                                {   
                                    cd.Thursday_End_Time__c=(Datetime)maxWorkEndTime[0].get('maxEnd');
                                    system.debug('Day of the week Thursday End Time- '+cd.Thursday_End_Time__c);
                                }
                             }
                        }
                        }
                        else if (objSV.Day_of_the_week__c=='Friday')
                        {
                            system.debug('Day of the week Friday - '+objSV.TravelWorkHours__c); 
                            system.debug('Day of the week Friday- '+objSV.TravelWorkHours__c);
                            if(objSV.NonActiveCategories__c=='Holiday')
                            {
                            if(cd.Friday_Holiday_Total__c==null)
                            {
                               cd.Friday_Holiday_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Friday_Holiday_Total__c = cd.Friday_Holiday_Total__c+objSV.TravelWorkHours__c;
                              }
                             
                             }
                             if(objSV.NonActiveCategories__c=='Sick'||objSV.NonActiveCategories__c=='Vacation')
                            {
                            if(cd.Friday_Vacation_Sick_Total__c==null)
                            {
                               cd.Friday_Vacation_Sick_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Friday_Vacation_Sick_Total__c= cd.Friday_Vacation_Sick_Total__c+objSV.TravelWorkHours__c;
                              }
                              
                             }
                             else
                             {
                            if(cd.Friday_Total_Hours_Worked__c==null)
                            {
                                cd.Friday_Total_Hours_Worked__c=objSV.TravelWorkHours__c;
                            }
                            else{
                                cd.Friday_Total_Hours_Worked__c=cd.Friday_Total_Hours_Worked__c+objSV.TravelWorkHours__c;
                            }
                            system.debug('Day of the week Friday Total Hours- '+cd.Friday_Total_Hours_Worked__c);
                            
                            if(cd.Friday_Start_Time__c==null)
                            {
                                AggregateResult[] minWorkStartTime=[Select MIN(SiteArrivalTime__c)minSiteArrival,MIN(WorkStarted__c)minStart from SV__c where Day_of_the_week__c='Friday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                if(minWorkStartTime.size()>0)
                                {
                                    Datetime dt = (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    Datetime dt1 = (Datetime)minWorkStartTime[0].get('minStart');
                                    system.debug('Day of the week Friday minSiteArrival '+dt);
                                    system.debug('Day of the week Friday minStart - '+dt1);
                                    if (dt == null && dt1 !=null){
                                        cd.Friday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');
                                    }
                                    else if (dt !=null && dt1 == null){
                                        cd.Friday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else if (dt !=null && dt1 !=null && dt < dt1)
                                    {
                                        cd.Friday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else 
                                    {
                                         cd.Friday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');   
                                    }
                                    
                                    system.debug('Day of the week Friday Start Time- '+cd.Friday_Start_Time__c);
                                }
                             }
                             if(cd.Friday_End_Time__c==null)
                             {
                                 AggregateResult[] maxWorkEndTime=[Select MAX(Work_Ended__c)maxEnd from SV__c where Day_of_the_week__c='Friday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                 if(maxWorkEndTime.size()>0)
                                {   
                                    cd.Friday_End_Time__c=(Datetime)maxWorkEndTime[0].get('maxEnd');
                                    system.debug('Day of the week Friday End Time- '+cd.Friday_End_Time__c);
                                }
                             }
                        }
                        }
                            else
                        {
                            system.debug('Day of the week Saturday - '+objSV.TravelWorkHours__c); 
                            system.debug('Day of the week Saturday- '+objSV.TravelWorkHours__c);
                            if(objSV.NonActiveCategories__c=='Holiday')
                            {
                            if(cd.Saturday_Holiday_Total__c==null)
                            {
                               cd.Saturday_Holiday_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Saturday_Holiday_Total__c = cd.Saturday_Holiday_Total__c+objSV.TravelWorkHours__c;
                              }
                              
                             }
                             if(objSV.NonActiveCategories__c=='Sick'||objSV.NonActiveCategories__c=='Vacation')
                            {
                            if(cd.Saturday_Vacation_Sick_Total__c==null)
                            {
                               cd.Saturday_Vacation_Sick_Total__c=objSV.TravelWorkHours__c;
                             }
                             else
                             { 
                              cd.Saturday_Vacation_Sick_Total__c= cd.Saturday_Vacation_Sick_Total__c+objSV.TravelWorkHours__c;
                              }
                              
                             }
                             else
                             {
                            if(cd.Saturday_Total_Hours_Worked__c==null)
                            {
                                cd.Saturday_Total_Hours_Worked__c=objSV.TravelWorkHours__c;
                            }
                            else{
                                cd.Saturday_Total_Hours_Worked__c=cd.Saturday_Total_Hours_Worked__c+objSV.TravelWorkHours__c;
                            }
                            system.debug('Day of the week Saturday Total Hours- '+cd.Saturday_Total_Hours_Worked__c);
                            
                            if(cd.Saturday_Start_Time__c==null)
                            {
                                AggregateResult[] minWorkStartTime=[Select MIN(SiteArrivalTime__c)minSiteArrival,MIN(WorkStarted__c)minStart from SV__c where Day_of_the_week__c='Saturday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                if(minWorkStartTime.size()>0)
                                {
                                    Datetime dt = (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    Datetime dt1 = (Datetime)minWorkStartTime[0].get('minStart');
                                    system.debug('Day of the week Saturday minSiteArrival '+dt);
                                    system.debug('Day of the week Saturday minStart - '+dt1);
                                    if (dt == null && dt1 !=null){
                                        cd.Saturday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');
                                    }
                                    else if (dt !=null && dt1 == null){
                                        cd.Saturday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else if (dt !=null && dt1 !=null && dt < dt1)
                                    {
                                        cd.Saturday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minSiteArrival');
                                    }
                                    else 
                                    {
                                         cd.Saturday_Start_Time__c= (Datetime)minWorkStartTime[0].get('minStart');   
                                    }
                                    
                                    system.debug('Day of the week Saturday Start Time- '+cd.Saturday_Start_Time__c);
                                }
                             }
                             if(cd.Saturday_End_Time__c==null)
                             {
                                 AggregateResult[] maxWorkEndTime=[Select MAX(Work_Ended__c)maxEnd from SV__c where Day_of_the_week__c='Saturday' and Technician__c=:objSV.Technician__c and Time_Card_Period__c= :cd.Time_Card_Week__c];
                                 if(maxWorkEndTime.size()>0)
                                {   
                                    cd.Saturday_End_Time__c=(Datetime)maxWorkEndTime[0].get('maxEnd');
                                    system.debug('Day of the week Saturday End Time- '+cd.Saturday_End_Time__c);
                                }
                             }
                        }
                        }
                     }
                 Insert cd;
                 nonexemptid=cd.Id;  
                 for (integer i=0;i<listitem.size();i++)
                     {
                        objSV=listitem[i];  
                        objSV.Non_Exempt_Time_Card__c=nonexemptid;
                        system.debug('Service vist non exempt time id' +objSV.Non_Exempt_Time_Card__c);
                                
                      }
                      update listitem;
            }
        if(nonexemptid==null)
            {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'There is no timecard for this the selected user.'));
            }
        else 
            {
        
                pg = new PageReference('/'+nonexemptid+'?isdtp=vw');
                pg.setRedirect(true); 
            } 
        }      
        system.debug('Page reference'+ pg);        
        return pg;
    }

}