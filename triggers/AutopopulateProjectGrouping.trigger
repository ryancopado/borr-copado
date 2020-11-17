trigger AutopopulateProjectGrouping on AcctSeed__Time_Card_Line__c (before insert ) 
{
        /*AcctSeed__Time_Card_Line__c timecardline= Trigger.new[0];
        //AcctSeed__Time_Card_Line__c timecardline=new AcctSeed__Time_Card_Line__c();
        AcctSeed__Time_Card__c  timecard=new AcctSeed__Time_Card__c();
        Site__c  site=new Site__c();
        List<Site__c> sitefields =new List<Site__c>();
        
        
        
        //string timecardid=String.valueOf(timecardline.AcctSeed__Time_Card__c.Id);
        //string siteid=timecardline.Site__r.Id;
        System.debug('Site id'+timecardline.Site__c);
        System.debug('timecard week'+timecardline.AcctSeed__Time_Card__c);
        sitefields=[select Project_Kickoff_Date__c, X50_Forecast_Release_Date__c, Opportunity_Record_Type__c, CD_Forecast_Release_Date__c, Handoff_Date__c, CD_IFC_Release_Date__c, Mobilization_Date__c from Site__c where id=:timecardline.Site__c];
        List<AcctSeed__Time_Card__c> timecardfields=[select AcctSeed__Week_Ending_Date__c from AcctSeed__Time_Card__c where id=:timecardline.AcctSeed__Time_Card__c];
        if((sitefields.size() >0)&&(timecardfields.size()>0))
        {
        site=sitefields.get(0);
        timecard=timecardfields.get(0);
        System.debug('Release Date : '+site.X50_Forecast_Release_Date__c );
        System.debug('Project Kickoff : '+site.Project_Kickoff_Date__c );
        System.debug('Oppertunity : '+site.Opportunity_Record_Type__c);
        System.debug('Weekendingdate : '+timecard.AcctSeed__Week_Ending_Date__c);
    
        //for(AcctSeed__Time_Card_Line__c timecardline : trigger.new)
            //{
        
        //if(timecardline.PG_Trigger__c==True)
        //{
        
        
        if(timecard.AcctSeed__Week_Ending_Date__c <=  site.X50_Forecast_Release_Date__c && timecard.AcctSeed__Week_Ending_Date__c >site.Project_Kickoff_Date__c && site.Opportunity_Record_Type__c== 'Captive/OnSite'||
           site.X50_Forecast_Release_Date__c==NULL && timecard.AcctSeed__Week_Ending_Date__c >  site.Project_Kickoff_Date__c && timecard.AcctSeed__Week_Ending_Date__c <= site.CD_Forecast_Release_Date__c && site.Opportunity_Record_Type__c == 'Captive/OnSite')
           {
                timecardline.Project_Grouping_Test__c='1: 50 Set Development';   
            }
        else if(timecard.AcctSeed__Week_Ending_Date__c<=site.Handoff_Date__c && timecard.AcctSeed__Week_Ending_Date__c >site.Project_Kickoff_Date__c && site.Opportunity_Record_Type__c== 'Development'||
            site.Handoff_Date__c==NULL && timecard.AcctSeed__Week_Ending_Date__c >  site.Project_Kickoff_Date__c  && timecard.AcctSeed__Week_Ending_Date__c <= site.CD_Forecast_Release_Date__c && site.Opportunity_Record_Type__c == 'Developmet')
          {
                timecardline.Project_Grouping_Test__c='1: 50 Set Development';   
            }  
        
        else if(timecard.AcctSeed__Week_Ending_Date__c <= site.Project_Kickoff_Date__c ||site.Project_Kickoff_Date__c==NULL)
            {
                timecardline.Project_Grouping_Test__c='0: Development';
             }
       
        else if((timecard.AcctSeed__Week_Ending_Date__c <=  site.CD_Forecast_Release_Date__c) && (site.Opportunity_Record_Type__c =='Development') && (timecard.AcctSeed__Week_Ending_Date__c > site.Handoff_Date__c))
           {
                timecardline.Project_Grouping_Test__c='2: CD IFR Set';   
            }
        else if((timecard.AcctSeed__Week_Ending_Date__c <=  site.CD_Forecast_Release_Date__c) && (site.Opportunity_Record_Type__c =='Captive/OnSite') && (timecard.AcctSeed__Week_Ending_Date__c > site.X50_Forecast_Release_Date__c ))
           {
               timecardline.Project_Grouping_Test__c='2: CD IFR Set';
            }
        else if((timecard.AcctSeed__Week_Ending_Date__c <= site.CD_IFC_Release_Date__c) && (timecard.AcctSeed__Week_Ending_Date__c > site.CD_Forecast_Release_Date__c ) || site.CD_IFC_Release_Date__c==NULL && (timecard.AcctSeed__Week_Ending_Date__c >= site.CD_Forecast_Release_Date__c) && (timecard.AcctSeed__Week_Ending_Date__c <=  site.Mobilization_Date__c))
           {
               timecardline.Project_Grouping_Test__c= '3: CD IFC Set';
            }
        else if((timecard.AcctSeed__Week_Ending_Date__c <=  site.Mobilization_Date__c) && (timecard.AcctSeed__Week_Ending_Date__c > site.CD_IFC_Release_Date__c))
           {
               timecardline.Project_Grouping_Test__c='4: Post CD Set';
            }
         else if(timecard.AcctSeed__Week_Ending_Date__c > site.Mobilization_Date__c)
            {
               timecardline.Project_Grouping_Test__c='5: CD Admin'; 
             } 
         else
             {
               timecardline.Project_Grouping_Test__c='';
              }
              System.debug('Project Grouping Test - '+timecardline.Project_Grouping_Test__c);
          }
    //}*/
    
    
    
     
     }