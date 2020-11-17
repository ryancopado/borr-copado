global class UpdateLaborfieldBatch implements Database.Batchable<sObject>
{

    global Database.QueryLocator start(Database.BatchableContext BC)
    {
         //DateTime dT = System.today();
        // system.debug('Date Time' +dT);     
        //Date endDate = date.newinstance(dT.year(), dT.month(), dT.day());      
       
        
        String query = 'SELECT Id,  EndDate,Year_of_Contract__c FROM Contract WHERE Contract_Status__c= \'ACTIVE\' AND RecordType.Name=\'Paid\' AND (LastModifiedDate=TODAY)';
         system.debug('Query Size' +query);         
        return Database.getQueryLocator(query);
              
    } 
     global void execute(Database.BatchableContext BC, List<Contract> Contracts)
    {
        system.debug('No of contracts fetched for renewal = '+Contracts.size());
       // try 
        //{
            for(Contract c :Contracts)
            {
             contract conrecords=new contract();
              conrecords=[select id,ContractTermYears__c,Contract_Amount__c,Escalator__c,Solar_Electrician_1__c,Labor_Escalator__c,Solar_Electrician_1_OT__c,Solar_Electrician_2__c,Solar_Electrician_2_OT__c,Regional_Manager__c,Solar_Engineer__c,Solar_Engineer_OT__c from Contract where id=:c.id];
               List <Service_Contract_Escalator__c> serconesc = new List <Service_Contract_Escalator__c>(); 
                decimal currValue = 0; 
             decimal currsolarvalue=0;
             decimal currsolarotvalue=0;
             decimal currsolarvalue2=0;
             decimal currsolarot2value=0;
             decimal currregionalrate=0;
             decimal currsolarengineerrate=0;
             decimal currsolarengineerrateot=0;
             decimal solarrate;
             decimal solarrateot;
             decimal solarrate21;
             decimal solarrateot2;
             decimal regionalratefinal;
             decimal solarengineerratefinal;
             decimal solarengineerrateotfinal;
             decimal laborrate;
             decimal contractEscalator;
             if(conrecords.Solar_Electrician_1__c==null)
             {
             solarrate=0.00;
             }
             else
             {
                solarrate=conrecords.Solar_Electrician_1__c;
               }
               //system.debug(' this is solar rate ' +solarrate); 
               if(conrecords.Solar_Electrician_1_OT__c==null)
             {
             solarrateot=0.00;
             }
             else
             {
               solarrateot=conrecords.Solar_Electrician_1_OT__c; 
               }
             
             Decimal solarelecrate1;
              Decimal solarelecrate1ot; 
               if(conrecords.Solar_Electrician_2__c==null)
             {
             solarrate21=0.00;
             }
             else
             {
               solarrate21=conrecords.Solar_Electrician_2__c;
               }
             
              
               //system.debug(' this is solar rate2 ' +solarrate21); 
               if(conrecords.Solar_Electrician_2_OT__c==null)
             {
             solarrateot2=0.00;
             }
             else
             {
               solarrateot2=conrecords.Solar_Electrician_2_OT__c;
               }
                if(conrecords.Regional_Manager__c==null)
             {
             regionalratefinal=0.00;
             }
             else
             {
               regionalratefinal=conrecords.Regional_Manager__c;
               }
              
              
              //system.debug('This is regional rate' +regionalratefinal); 
              if(conrecords.Solar_Engineer__c==null)
             {
             solarengineerratefinal=0.00;
             }
             else
             {
               solarengineerratefinal=conrecords.Solar_Engineer__c ; 
               }
               if(conrecords.Solar_Engineer_OT__c==null)
             {
             solarengineerrateotfinal=0.00;
             }
             else
             {
                solarengineerrateotfinal=conrecords.Solar_Engineer_OT__c ; 
               }
               if(conrecords.Labor_Escalator__c==null)
             {
             laborrate=0.00;
             }
             else
             {
                laborrate=conrecords.Labor_Escalator__c; 
               }
              if(conrecords.Escalator__c==null)
             {
             contractEscalator=0.00;
             }
             else
             {
                contractEscalator=conrecords.Escalator__c;
               }
             
               decimal contractAmount=conrecords.Contract_Amount__c ;
               
               
             List<Service_Contract_Escalator__c> escalatorecords=[select id,CurrentYearContractValue__c,PriorYearContractValue__c,Solar_Electrician_1_Rate1__c,Labor_Escalator__c,Current_Year_Solar_Electrician_1_OT_Ra__c,Prior_Year_Solar_Electrician_1_OT_Rate__c,Prior_Year_Solar_Electrician_2_Rate__c,Current_Year__c ,Prior_Year__c,Current_Year1__c,Current_Year_Solar_Electrician_2_OT_Ra__c,Prior_Year1__c,Prior_Year12__c,Current_Year12__c,Prior_Year_Solar_Engineer_OT_Rate__c,Current_Year_Solar_Engineer_OT_Rate__c from Service_Contract_Escalator__c where Service_Contract__c=:c.id];
             Integer listsize=escalatorecords.size();
             
             system.debug('List Size' +escalatorecords.size());
             //for(Service_Contract_Escalator__c con:escalatorecords)
            for(integer i=0;i<listsize;i++)
              {
              system.debug('Look' +i);
              
               
                     Service_Contract_Escalator__c con = new Service_Contract_Escalator__c();
                     con=escalatorecords.get(i);
                     system.debug('this is contract' +con);
                      //system.debug('AMOUNT contractAmount =' +contractAmount );
                      //con.Service_Contract__c=contractId;
                      //integer year = i+1;
                      //con.Year__c=year;
                      //string Query='select id from Service_Contract_Escalator__c WHERE Service_Contract__c=:contractId and Year__c=:year';
                      if(i==0)
                             {   
                             
                             
                                  con.CurrentYearContractValue__c=contractAmount ;
                                  con.PriorYearContractValue__c=contractAmount ;
                                  currValue    =  contractAmount ;
                                  con.Solar_Electrician_1_Rate1__c=solarrate;
                                  con.Current_Year_Solar_Electrician_1_Rate__c =solarrate;
                                  currsolarvalue=solarrate;
                                  con.Labor_Escalator__c=laborrate;
                                  con.Current_Year_Solar_Electrician_1_OT_Ra__c=solarrateot ;
                                  con.Prior_Year_Solar_Electrician_1_OT_Rate__c=solarrateot ;
                                  currsolarotvalue=solarrateot ;
                                  con.Prior_Year_Solar_Electrician_2_Rate__c=solarrate21 ;
                                  con.Current_Year__c=solarrate21 ;
                                  currsolarvalue2=solarrate21;
                                  system.debug('This is currsolar' +currsolarvalue2);
                                  con.Prior_Year__c=solarrateot2 ;
                                  con.Current_Year_Solar_Electrician_2_OT_Ra__c=solarrateot2;
                                  currsolarot2value=solarrateot2;
                                  con.Prior_Year1__c=regionalratefinal ;
                                  con.Current_Year1__c=regionalratefinal;
                                  currregionalrate=regionalratefinal;
                                  
                                  system.debug('This is regional rate' +currregionalrate);
                                  con.Prior_Year12__c=solarengineerratefinal ;
                                  con.Current_Year12__c=solarengineerratefinal ;
                                  currsolarengineerrate=solarengineerratefinal ;
                                  con.Prior_Year_Solar_Engineer_OT_Rate__c=solarengineerrateotfinal ;
                                  con.Current_Year_Solar_Engineer_OT_Rate__c=solarengineerrateotfinal ;
                                  currsolarengineerrateot=solarengineerrateotfinal;
                                  
                                  //con.Solar_Electrician_1_Rate__c=solarrate*(laborrate/100);
                                  
                                  //system.debug('currValue =' +currValue);
                                  //system.debug('con.Service_Contract_Amount__c =' +contractAmount);
                                  //List <Service_Contract_Escalator__c> existList=Database.query(Query);
                                  //if(!existList.isEmpty())
                                  //{
                                      serconesc.add(con);                             
                                 // }
                              }
                      else
                              {
                                  con.PriorYearContractValue__c=currValue;
                                  con.Solar_Electrician_1_Rate1__c=currsolarvalue;
                                  con.Prior_Year_Solar_Electrician_1_OT_Rate__c=currsolarotvalue;
                                  con.Prior_Year_Solar_Electrician_2_Rate__c=currsolarvalue2;
                                  con.Prior_Year__c=currsolarot2value;
                                  con.Prior_Year1__c=currregionalrate;
                                  con.Prior_Year12__c=currsolarengineerrate;
                                  con.Prior_Year_Solar_Engineer_OT_Rate__c=currsolarengineerrateot;
                                  con.Labor_Escalator__c=laborrate;
                                  
                                  solarelecrate1=currsolarvalue*(laborrate/100);
                                 
                                 
                                   solarelecrate1ot=currsolarotvalue*(laborrate/100);
                                  
                                  Decimal solarelecrate2=currsolarvalue2*(laborrate/100);
                                  Decimal solarelecrate2ot=currsolarot2value*(laborrate/100);
                                  Decimal regionalratefinal1=currregionalrate*(laborrate/100);
                                  Decimal solarengineerratefinal1=currsolarengineerrate*(laborrate/100);
                                  decimal solarengineerratefinalot=currsolarengineerrateot*(laborrate/100);
                                  
                                  con.Current_Year_Solar_Electrician_1_Rate__c =con.Solar_Electrician_1_Rate1__c+solarelecrate1;
                                  
                                  con.Current_Year_Solar_Electrician_1_OT_Ra__c=con.Prior_Year_Solar_Electrician_1_OT_Rate__c+solarelecrate1ot;
                                  
                                  con.Current_Year__c=con.Prior_Year_Solar_Electrician_2_Rate__c+solarelecrate2;
                                  con.Current_Year_Solar_Electrician_2_OT_Ra__c=con.Prior_Year__c+solarelecrate2ot;
                                  con.Current_Year1__c=con.Prior_Year1__c+regionalratefinal1;
                                  con.Current_Year12__c=con.Prior_Year12__c+solarengineerratefinal1;
                                  con.Current_Year_Solar_Engineer_OT_Rate__c=con.Prior_Year_Solar_Engineer_OT_Rate__c+solarengineerratefinalot;
                                 
                                  //system.debug('con.PriorYearContractValue__c =' +con.PriorYearContractValue__c);
                                  con.CurrentYearContractValue__c=con.PriorYearContractValue__c + con.PriorYearContractValue__c*(contractEscalator/ 100) ;//+con.Current_Year_Solar_Electrician_1_Rate__c+con.Current_Year_Solar_Electrician_1_OT_Ra__c+con.Current_Year__c+con.Current_Year_Solar_Electrician_2_OT_Ra__c+con.Current_Year1__c+con.Current_Year12__c+con.Current_Year_Solar_Engineer_OT_Rate__c
                                  currValue=con.CurrentYearContractValue__c;
                                  
                                  currsolarvalue=con.Current_Year_Solar_Electrician_1_Rate__c;
                                  currsolarotvalue=con.Current_Year_Solar_Electrician_1_OT_Ra__c;
                                  currsolarvalue2=con.Current_Year__c;
                                  currsolarot2value=con.Current_Year_Solar_Electrician_2_OT_Ra__c;
                                  currregionalrate=con.Current_Year1__c;
                                  currsolarengineerrate=con.Current_Year12__c;
                                  currsolarengineerrateot=con.Current_Year_Solar_Engineer_OT_Rate__c; 
                                 // List <Service_Contract_Escalator__c> existList=Database.query(Query);
                                  //if(!existList.isEmpty())
                                 // {
                                     serconesc.add(con);
                                  //}
                              }
                }
                system.debug('Final Update' +escalatorecords);
                
                
                    update serconesc ;  
              }
             // } 
              //catch(Exception e) {
            //System.debug('Error occured during execution.'+e);
        
   // }
    }
    global void finish(Database.BatchableContext BC) 
    {
        // execute any post-processing operations
    }
}