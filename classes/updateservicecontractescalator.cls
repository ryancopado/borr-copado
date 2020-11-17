global class updateservicecontractescalator 
{
    webservice static String createEscalators(Id contractId,integer contractTerms, String Amount,decimal contractEscalator,String solarrate1,decimal laborrate, String solarotrate1,String solarrate2,String solarotrate2,String regionalmanagerrate,String solarengineerrate,String solarengineerotrate) 
        {
             List <Service_Contract_Escalator__c> serconesc = new List <Service_Contract_Escalator__c>(); 
             decimal solarrate; 
             decimal solarrateot;  
             Decimal solarelecrate1;
              Decimal solarelecrate1ot; 
              decimal solarrate21;
              decimal solarrateot2;
              decimal regionalratefinal; 
              decimal solarengineerratefinal ; 
              decimal solarengineerrateotfinal ;               
             String contractamountvalue = Amount.remove('$');
             String contractamountvalue1 = contractamountvalue .remove(',');
             decimal contractAmount = decimal.valueOf(contractamountvalue1);
             system.debug('SR' +solarotrate1);
             if(solarrate1=='')
             {
              String solarrate11='$0.00';
             system.debug('Enter Here' );
             String solarlaborrate=solarrate11.remove('$');
             String solarlaborrate1=solarlaborrate.remove(',');
             //system.debug('solar rate' + solarlaborrate1);
             
            
              solarrate =decimal.valueOf(solarlaborrate1);
             }
             else
             {
             String solarlaborrate=solarrate1.remove('$');
             String solarlaborrate1=solarlaborrate.remove(',');
             //system.debug('solar rate' + solarlaborrate1);
             
            
              solarrate =decimal.valueOf(solarlaborrate1);
              }
              
             if(solarotrate1=='')
             {
             String solarotrate11='$0.00';
             String solarlaborrateot=solarotrate11.remove('$');
             String solarlaborrate1ot=solarlaborrateot.remove(',');
             solarrateot =decimal.valueOf(solarlaborrate1ot);
             }
             else
             {
             String solarlaborrateot=solarotrate1.remove('$');
             String solarlaborrate1ot=solarlaborrateot.remove(',');
             solarrateot =decimal.valueOf(solarlaborrate1ot);
             }
             if(solarrate2=='')
             {
             String solarrate22='$0.00';
             
             String solarlaborrate2=solarrate22.remove('$');
             String solarlaborrate21=solarlaborrate2.remove(',');
             solarrate21 =decimal.valueOf(solarlaborrate21);
             }
             else
             {
             String solarlaborrate2=solarrate2.remove('$');
             String solarlaborrate21=solarlaborrate2.remove(',');
             solarrate21 =decimal.valueOf(solarlaborrate21);
             }
             if(solarotrate2=='')
             {
              String solarotrate22='$0.00';
             String solarlaborrateot2=solarotrate22.remove('$');
             String solarlaborrate2ot=solarlaborrateot2.remove(',');
            solarrateot2 =decimal.valueOf(solarlaborrate2ot);
             }
             else
             {
             String solarlaborrateot2=solarotrate2.remove('$');
             String solarlaborrate2ot=solarlaborrateot2.remove(',');
             solarrateot2 =decimal.valueOf(solarlaborrate2ot);
             }
             if(regionalmanagerrate=='')
             {
             String regionalmanagerrate1='$0.00';
             String regionalrate=regionalmanagerrate1.remove('$');
             String regionalrate1=regionalrate.remove(',');
             regionalratefinal =decimal.valueOf(regionalrate1);
             }
             else
             {
             String regionalrate=regionalmanagerrate.remove('$');
             String regionalrate1=regionalrate.remove(',');
             regionalratefinal =decimal.valueOf(regionalrate1);
             }
             if(solarengineerrate=='')
             {
             String solarengineerrate1='$0.00';
             String solarengineerrate12=solarengineerrate1.remove('$');
             String solarengineerrate123=solarengineerrate12.remove(',');
             solarengineerratefinal =decimal.valueOf(solarengineerrate123);
             }
             else
             {
             String solarengineerrate12=solarengineerrate.remove('$');
             String solarengineerrate123=solarengineerrate12.remove(',');
             solarengineerratefinal =decimal.valueOf(solarengineerrate123);
             
             }
             if(solarengineerotrate=='')
             {
             String solarengineerotrate1='$0.00';
             String solarengineerotrate12=solarengineerotrate1.remove('$');
             String solarengineerotrate123=solarengineerotrate12.remove(',');
             solarengineerrateotfinal =decimal.valueOf(solarengineerotrate123);
             }
             else 
             {
             String solarengineerotrate12=solarengineerotrate.remove('$');
             String solarengineerotrate123=solarengineerotrate12.remove(',');
             solarengineerrateotfinal =decimal.valueOf(solarengineerotrate123);
             }
             
             
             system.debug('contractAmount =' +contractAmount );
             decimal currValue = 0; 
             decimal currsolarvalue=0;
             decimal currsolarotvalue=0;
             decimal currsolarvalue2=0;
             decimal currsolarot2value=0;
             decimal currregionalrate=0;
             decimal currsolarengineerrate=0;
             decimal currsolarengineerrateot=0;
             List<Service_Contract_Escalator__c> escalatorecords=[select id,CurrentYearContractValue__c,PriorYearContractValue__c,Solar_Electrician_1_Rate1__c,Labor_Escalator__c,Current_Year_Solar_Electrician_1_OT_Ra__c,Prior_Year_Solar_Electrician_1_OT_Rate__c,Prior_Year_Solar_Electrician_2_Rate__c,Current_Year__c ,Prior_Year__c,Current_Year1__c,Current_Year_Solar_Electrician_2_OT_Ra__c,Prior_Year1__c,Prior_Year12__c,Current_Year12__c,Prior_Year_Solar_Engineer_OT_Rate__c,Current_Year_Solar_Engineer_OT_Rate__c from Service_Contract_Escalator__c where Service_Contract__c=:contractId];
             Integer listsize=escalatorecords.size();
             
             system.debug('List Size' +escalatorecords.size());
             //for(Service_Contract_Escalator__c con:escalatorecords)
            for(integer i=0;i<listsize;i++)
              {
              system.debug('Look' +i);
              
               
                     Service_Contract_Escalator__c con = new Service_Contract_Escalator__c();
                     con=escalatorecords.get(i);
                      system.debug('AMOUNT contractAmount =' +contractAmount );
                      //con.Service_Contract__c=contractId;
                      //integer year = i+1;
                      //con.Year__c=year;
                      //string Query='select id from Service_Contract_Escalator__c WHERE Service_Contract__c=:contractId and Year__c=:year';
                      if(i==0)
                             {   
                             
                             
                                  con.CurrentYearContractValue__c=contractAmount;
                                  con.PriorYearContractValue__c=contractAmount;
                                  currValue    =     contractAmount;
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
                                  con.Prior_Year__c=solarrateot2 ;
                                  con.Current_Year_Solar_Electrician_2_OT_Ra__c=solarrateot2;
                                  currsolarot2value=solarrateot2;
                                  con.Prior_Year1__c=regionalratefinal ;
                                  con.Current_Year1__c=regionalratefinal;
                                  currregionalrate=regionalratefinal;
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
                    system.debug('Final Update' +escalatorecords);
                    
                   
        
        return 'Service Contract Escalator Records Updated ';
                
}
}