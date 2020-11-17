public with sharing class MyController {
    public string aid{set;get;}
    public string branchPickvalue{get; set;}
    public List<Site__c> projectList{get; set;}
    public List<ProjectDeadline__c> projectDeadlineList{get; set;}
    

    public MyController()
    {
       this.projectList= [select id,Active_Project_Portfolio_View__c, Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c  from Site__c where  (Overall_Project_Status__c not in('Dead','Complete', 'Completed', 'On Hold') AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND (Project__r.GroSolar__c='False' OR Project__r.GroSolar__c= NULL) AND Project__r.RecordType.Name!='O_M_Project' AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today ) AND  Final_Completion__c >Today) OR Active_Project_Portfolio_View__c = TRUE order by Site_Project_Name__c ]; 
       
       projectDeadlineList = [select id, Site__c,AtRisk__c,Project__c,RelatedMilestoneDate__c/*,DeadlineDescription__c*/,AssociatedMilestone__c,DeadlineDate__c from ProjectDeadline__c where Site__c in:projectList];
       for(integer i=0;i<this.projectList.size();i++)
            {
               Site__c objsite =  this.projectList.get(i);
               system.debug('Site Id'+objsite.id);
               system.debug('Size of portfolio'+projectDeadlineList.size());
               if (projectDeadlineList.size() > 0){
                   
                   for (integer j=0;j<projectDeadlineList.size();j++)
                   {
                       ProjectDeadline__c objProjectdeadline = projectDeadlineList.get(j);
                       if(objsite.id== objProjectdeadline.Site__c)
                       {                      
                            if(objProjectdeadline.AssociatedMilestone__c == 'Final Completion')                       
                                {
                                    objsite.Associated_Final_Completion__c ='Y';
                                    objsite.FCDeadlineid__c=objProjectdeadline.id;   
                                    if(objProjectdeadline.AtRisk__c=='AT RISK')
                                       {
                                           objsite.At_RiskFC__c='Y';
                                       }
                                       else
                                       {
                                           objsite.At_RiskFC__c='N';
                                       }
                                } 
                            else if(objProjectdeadline.AssociatedMilestone__c == 'Substantial Completion') 
                                {
                                    objsite.Associated__c='Y';
                                    objsite.SCDeadlineid__c=objProjectdeadline.id; 
                                    if(objProjectdeadline.AtRisk__c=='AT RISK')
                                       {
                                           objsite.At_Risk__c='Y';
                                       }
                                       else
                                       {
                                           objsite.At_Risk__c='N';
                                       }
                                } 
                            else if(objProjectdeadline.AssociatedMilestone__c == 'Mobilization Date')
                                {
                                    objsite.Associated_mobilization_date__c='Y';
                                    objsite.MDDeadlineid__c=objProjectdeadline.id; 
                                    if(objProjectdeadline.AtRisk__c=='AT RISK')
                                       {
                                           objsite.At_RiskMD__c='Y';
                                       }
                                       else
                                       {
                                           objsite.At_RiskMD__c='N';
                                       }
                                } 
                            else if(objProjectdeadline.AssociatedMilestone__c == 'PTO Date')
                                {
                                     objsite.Associated_PTO_date__c  ='Y';
                                     objsite.PTODeadlineid__c=objProjectdeadline.id; 
                                     if(objProjectdeadline.AtRisk__c=='AT RISK')
                                       {
                                           objsite.At_RiskPTO__c='Y';
                                       }
                                       else
                                       {
                                           objsite.At_RiskPTO__c='N';
                                       }
                                }
                            else if(objProjectdeadline.AssociatedMilestone__c == 'FNTP Date')
                                {
                                    objsite.Associated_FNTP__c='Y';
                                    objsite.FNTPDeadlineid__c=objProjectdeadline.id; 
                                    if(objProjectdeadline.AtRisk__c=='AT RISK')
                                       {
                                           objsite.At_RiskFNTP__c='Y';
                                       }
                                       else
                                       {
                                           objsite.At_RiskFNTP__c='N';
                                       }
                                }
                            else if(objProjectdeadline.AssociatedMilestone__c == 'Mechanical Completion') 
                            {
                                  objsite.Associated_Mechanical_completion_date__c ='Y';
                                  objsite.MCDeadlineid__c=objProjectdeadline.id; 
                                  if(objProjectdeadline.AtRisk__c=='AT RISK')
                                       {
                                           objsite.At_RiskMCD__c='Y';                                       
                                       }
                                       else
                                       {
                                           objsite.At_RiskMCD__c='N';
                                       }
                            }
                       }      
                   }
               }
    }
    }
    public PageReference getprojects() 
        {
        //this.projectList = [select Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c   from Site__c where 
        //Overall_Project_Status__c not in('Dead','Complete','Completed','On Hold') AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND (Project__r.GroSolar__c='False' OR Project__r.GroSolar__c= NULL) AND Project__r.RecordType.Name!='O_M_Project' AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today ) AND  Final_Completion__c >Today order by Site_Project_Name__c ]; 
         
        
        system.debug('GetRecord'+branchPickvalue);
        if(branchPickvalue=='All')
        {
           system.debug('In'+branchPickvalue);
           this.projectList= [select id,Active_Project_Portfolio_View__c, Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c  from Site__c where  (Overall_Project_Status__c not in('Dead','Complete', 'Completed', 'On Hold') AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND (Project__r.GroSolar__c='False' OR Project__r.GroSolar__c= NULL) AND Project__r.RecordType.Name!='O_M_Project' AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today ) AND  Final_Completion__c >Today) OR Active_Project_Portfolio_View__c = TRUE order by Site_Project_Name__c ]; 
        }
        else if(branchPickvalue=='West Coast')
        {
           system.debug('In'+branchPickvalue);
           this.projectList= [select id,Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c  from Site__c where (Overall_Project_Status__c not in('Dead','Complete', 'Completed', 'On Hold') AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND (Project__r.GroSolar__c='False' OR Project__r.GroSolar__c= NULL) AND Project__r.RecordType.Name!='O_M_Project'  AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today ) AND Final_Completion__c >Today AND Project_Team__c in ('EPC - West')) OR (Active_Project_Portfolio_View__c = TRUE AND Project_Team__c in ('EPC - West'))  order by Site_Project_Name__c]; 
        }
        else if(branchPickvalue=='East Coast')
        {
           system.debug('In'+branchPickvalue);
           this.projectList= [select id,Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c   from Site__c where (Overall_Project_Status__c not in('Dead','Complete', 'Completed', 'On Hold') AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND (Project__r.GroSolar__c='False' OR Project__r.GroSolar__c= NULL) AND Project__r.RecordType.Name!='O_M_Project' AND Final_Completion__c >Today AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today) AND Project_Team__c in('EPC - New England', 'EPC - Mid Atlantic', 'Dev - New York', 'Dev - New England')) OR (Active_Project_Portfolio_View__c = TRUE AND Project_Team__c in('EPC - New England', 'EPC - Mid Atlantic', 'Dev - New York', 'Dev - New England')) order by Site_Project_Name__c ]; 
        }
        else if(branchPickvalue=='Midwest')
        {
           system.debug('In'+branchPickvalue);
           this.projectList= [select id,Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c   from Site__c where (Overall_Project_Status__c not in('Dead','Complete', 'Completed', 'On Hold') AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND Project__r.GroSolar__c='False'AND Project__r.RecordType.Name!='O_M_Project' AND Final_Completion__c >Today AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today) AND Project_Team__c = 'EPC - Midwest') OR (Active_Project_Portfolio_View__c = TRUE AND Project_Team__c = 'EPC - Midwest') order by Site_Project_Name__c ]; 
        }
        else if(branchPickvalue=='Onsite')
        {
           system.debug('In'+branchPickvalue);
           this.projectList= [select id,Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c   from Site__c where (Overall_Project_Status__c not in('Dead','Complete', 'Completed', 'On Hold') AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND (Project__r.GroSolar__c='False' OR Project__r.GroSolar__c= NULL) AND Project__r.RecordType.Name!='O_M_Project' AND Final_Completion__c >Today AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today) AND Opportunity__r.Record_Type_Name__c='Captive/OnSite') OR (Active_Project_Portfolio_View__c = TRUE AND Opportunity__r.Record_Type_Name__c='Captive/OnSite') order by Site_Project_Name__c ]; 
        }
        else if(branchPickvalue=='Development')
        {
           system.debug('In'+branchPickvalue);
           this.projectList = [select id,Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c   from Site__c where (Overall_Project_Status__c not in('Dead','Complete', 'Completed', 'On Hold')  AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND (Project__r.GroSolar__c='False' OR Project__r.GroSolar__c= NULL) AND Project__r.RecordType.Name!='O_M_Project' AND Final_Completion__c >Today AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today) AND Opportunity__r.Record_Type_Name__c='Development') OR (Active_Project_Portfolio_View__c = TRUE AND Opportunity__r.Record_Type_Name__c='Development') order by Site_Project_Name__c]; 
        }
        else if(branchPickvalue=='In Construction')
        {
           system.debug('In'+branchPickvalue);
           this.projectList= [select id,Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c  from Site__c where (Overall_Project_Status__c not in('Dead','Complete', 'Completed', 'On Hold')  AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND (Project__r.GroSolar__c='False' OR Project__r.GroSolar__c= NULL) AND Project__r.RecordType.Name!='O_M_Project' AND Final_Completion__c >Today AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today) AND Overall_Project_Status__c='Construction') OR (Active_Project_Portfolio_View__c = TRUE AND Overall_Project_Status__c='Construction') order by Site_Project_Name__c ]; 
        }
        else
        {
           system.debug('In'+branchPickvalue);
           this.projectList= [select id,Site_Project_Name__c ,SiteContractValue__c,Project_Size_Watts_STC__c,Direct_Margin__c,FNTP_Date__c,Mobilization_Date__c,Substantial_Completion_Date__c,Substantial_Completion_NEW__c,PTO_Date__c,Final_Completion__c,ProductDeliveryDateUpdated__c,At_Risk__c,Associated_Milestone__c,Associated_FNTP__c,Associated_mobilization_date__c,Associated_PTO_date__c,Associated_Final_Completion__c,Associated_Mechanical_completion_date__c,Associated__c,FCDeadlineid__c,MDDeadlineid__c,SCDeadlineid__c,MCDeadlineid__c,PTODeadlineid__c,FNTPDeadlineid__c,At_RiskFNTP__c,At_RiskMD__c,At_RiskMCD__c,At_RiskPTO__c,At_RiskFC__c   from Site__c where (Overall_Project_Status__c not in('Dead','Complete', 'Completed', 'On Hold') AND Construction_Stage__c!='Completed'AND Construction_Stage__c!='Cust. Accept. Complete'AND (Project__r.GroSolar__c='False' OR Project__r.GroSolar__c= NULL) AND Project__r.RecordType.Name!='O_M_Project' AND Final_Completion__c >Today AND (Project_Kickoff_Date_editable__c <Today OR MarkettoOwnerDate__c <Today) AND Overall_Project_Status__c = 'Design') OR (Active_Project_Portfolio_View__c = TRUE AND Overall_Project_Status__c = 'Design') order by Site_Project_Name__c ]; 
        }
        for(integer i=0;i<this.projectList.size();i++)
            {
               Site__c objsite =  this.projectList.get(i);
               system.debug('Site Id'+objsite.id);  
               projectDeadlineList = [select id, Site__c,AtRisk__c,Project__c,RelatedMilestoneDate__c/*,DeadlineDescription__c*/,AssociatedMilestone__c,DeadlineDate__c from ProjectDeadline__c where Site__c=:objsite.id];
               system.debug('Size of portfolio'+projectDeadlineList.size());
               if (projectDeadlineList.size() > 0){
                   
                   for (integer j=0;j<projectDeadlineList.size();j++)
                   {
                       ProjectDeadline__c objProjectdeadline = projectDeadlineList.get(j);                       
                        if(objProjectdeadline.AssociatedMilestone__c == 'Final Completion')                       
                            {
                                objsite.Associated_Final_Completion__c ='Y';
                                objsite.FCDeadlineid__c=objProjectdeadline.id;   
                                if(objProjectdeadline.AtRisk__c=='AT RISK')
                                   {
                                       objsite.At_RiskFC__c='Y';
                                   }
                                   else
                                   {
                                       objsite.At_RiskFC__c='N';
                                   }
                            } 
                        else if(objProjectdeadline.AssociatedMilestone__c == 'Substantial Completion') 
                            {
                                objsite.Associated__c='Y';
                                objsite.SCDeadlineid__c=objProjectdeadline.id; 
                                if(objProjectdeadline.AtRisk__c=='AT RISK')
                                   {
                                       objsite.At_Risk__c='Y';
                                   }
                                   else
                                   {
                                       objsite.At_Risk__c='N';
                                   }
                            } 
                        else if(objProjectdeadline.AssociatedMilestone__c == 'Mobilization Date')
                            {
                                objsite.Associated_mobilization_date__c='Y';
                                objsite.MDDeadlineid__c=objProjectdeadline.id; 
                                if(objProjectdeadline.AtRisk__c=='AT RISK')
                                   {
                                       objsite.At_RiskMD__c='Y';
                                   }
                                   else
                                   {
                                       objsite.At_RiskMD__c='N';
                                   }
                            } 
                        else if(objProjectdeadline.AssociatedMilestone__c == 'PTO Date')
                            {
                                 objsite.Associated_PTO_date__c  ='Y';
                                 objsite.PTODeadlineid__c=objProjectdeadline.id; 
                                 if(objProjectdeadline.AtRisk__c=='AT RISK')
                                   {
                                       objsite.At_RiskPTO__c='Y';
                                   }
                                   else
                                   {
                                       objsite.At_RiskPTO__c='N';
                                   }
                            }
                        else if(objProjectdeadline.AssociatedMilestone__c == 'FNTP Date')
                            {
                                objsite.Associated_FNTP__c='Y';
                                objsite.FNTPDeadlineid__c=objProjectdeadline.id; 
                                if(objProjectdeadline.AtRisk__c=='AT RISK')
                                   {
                                       objsite.At_RiskFNTP__c='Y';
                                   }
                                   else
                                   {
                                       objsite.At_RiskFNTP__c='N';
                                   }
                            }
                        else if(objProjectdeadline.AssociatedMilestone__c == 'Mechanical Completion') 
                        {
                              objsite.Associated_Mechanical_completion_date__c ='Y';
                              objsite.MCDeadlineid__c=objProjectdeadline.id; 
                              if(objProjectdeadline.AtRisk__c=='AT RISK')
                                   {
                                       objsite.At_RiskMCD__c='Y';                                       
                                   }
                                   else
                                   {
                                       objsite.At_RiskMCD__c='N';
                                   }
                            }
                              
                   }
               }
            }
        return null; 
    }
    
        

 public pagereference method1()
    {
           
        pagereference pr = new PageReference('/' + aid);
        return pr;
      
     }
}