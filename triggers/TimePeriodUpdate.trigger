trigger TimePeriodUpdate on SV__c (before Insert, before update) {
    /*
    SV__c objSV = Trigger.new[0];
    if (objSV.Work_Ended__c !=null)
    {
        system.debug('Start Trigger'); 
        AcctSeed__Time_Card_Period__c objTimeCardPeriod = new AcctSeed__Time_Card_Period__c();
        Integer days = 0;
        DateTime endDt = objSV.Work_Ended__c;
        system.debug('End date from sv'+endDt);                 
        String day = endDt.format('EEE');
        system.debug('day from console'+day); 
        if(day=='SUN')
        {
            days=6;
        }
         else if(day=='MON')
        {
            days=5;
        }
        else if(day=='TUE')
        {
            days=4;
        }
        else if(day=='WED')
        {
            days=3;
        }
        else if(day=='THU')
        {
            days=2;
        }
        else if(day=='FRI')
        {
            days=1;
        }
        else
        {
            days=0;
        }
        DateTime workEndDateTime = endDt.addDays(days);
        Date endDate = date.newinstance(workEndDateTime.year(), workEndDateTime.month(), workEndDateTime.day()); 
        system.debug('Work end date before conversion' + workEndDateTime);    
        List<AcctSeed__Time_Card_Period__c> listrPeriod = [SELECT name from AcctSeed__Time_Card_Period__c where AcctSeed__End_Date__c = :endDate];
        
        system.debug('Work end date before update' +endDate);
        system.debug('Time period before update' + listrPeriod[0].name);
        objSV.Time_Card_Period__c = listrPeriod[0].id;
        system.debug('Time period' + objSV.Time_Card_Period__c);
        String user=objSV.Technician__c;
        system.debug('Technician' + objSV.Technician__c);

        if(user!=null && objSV.Non_Exempt_Time_Card__c==null)
        {
            List<Contact>listuser=[select SF_User_Record__c from contact where id=:user];
            if(listuser.size()>0)
            {
                system.debug('listuser' + listuser[0].SF_User_Record__c);
                List<Non_Exempt_Time__c> listnonexemptperiod=[SELECT id,name,Employee_Name__c,Time_Card_Week__c from Non_Exempt_Time__c where Time_Card_Week__c=:objSV.Time_Card_Period__c and Employee_Name__c=:listuser[0].SF_User_Record__c];
                if(listnonexemptperiod.size()>0)
                    {
                
                        objSV.Non_Exempt_Time_Card__c=listnonexemptperiod[0].id;
                        system.debug('Non_Exempt_Time_Card__c is ='+objSV.Non_Exempt_Time_Card__c);
                    }    
            }        
      
       }
      //update objSV;
    }
    */
}