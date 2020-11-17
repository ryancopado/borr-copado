trigger UpdateBillingdates on AcctSeed__Billing__c (after update)  
{ 
    AcctSeed__Recurring_Billing__c rb =new AcctSeed__Recurring_Billing__c();
    Contract sercon= new Contract();
    AcctSeed__Billing__c ab = Trigger.new[0];
      
     //for (AcctSeed__Billing__c ab : Trigger.new)      
            //{
            if(ab.AcctSeed__Recurring_Billing__c!=null)
            {
           if( Trigger.oldmap.get(ab.id).AcctSeed__Status__c != Trigger.newmap.get(ab.id).AcctSeed__Status__c && Trigger.newmap.get(ab.id).AcctSeed__Status__c == 'Posted') 
            //if(ab.AcctSeed__Status__c=='Posted')
                {
                String recuringbillingid= ab.AcctSeed__Recurring_Billing__c; 
                system.debug( 'recuring billing id' +recuringbillingid);                              
                rb=[SELECT Service_Contract__c from AcctSeed__Recurring_Billing__c where id=:recuringbillingid];                    
                String contractid=rb.Service_Contract__c;
                system.debug( 'contract id' +contractid);
                
                List<AggregateResult> LastBillingdate=[SELECT MAX(AcctSeed__Date__c)AccountSeedDate from AcctSeed__Billing__c where Service_Contract__c=:contractid and AcctSeed__Status__c='Posted' Group By AcctSeed__Status__c];                    
                List<AcctSeed__Recurring_Billing__c> recurbill=[SELECT AcctSeed__Billing_Frequency__c,AcctSeed__Last_Billing_Date__c,AcctSeed__Next_Billing_Date__c from AcctSeed__Recurring_Billing__c where Service_Contract__c=:contractid];                    
                rb = recurbill.get(0);
                //String strdate =String.valueOf(LastBillingdate[0].get('AccountSeedDate'));
                rb.AcctSeed__Last_Billing_Date__c= Date.valueOf(LastBillingdate[0].get('AccountSeedDate'));
                //recurbill.add(rb);
                system.debug('last billing date' + rb.AcctSeed__Last_Billing_Date__c);
                date accountbillingdate= rb.AcctSeed__Last_Billing_Date__c;
                Integer year = accountbillingdate.year();
                Integer month = accountbillingdate.month();
                Integer day = accountbillingdate.day();
                system.debug('year' + year);
                system.debug('month' + month);
                system.debug('day' + day);
                system.debug('Anniversary in Advance' + rb.AcctSeed__Billing_Frequency__c);
               
                if(rb.AcctSeed__Billing_Frequency__c =='Quarterly in Advance Equal Installments' || rb.AcctSeed__Billing_Frequency__c =='Quarterly in Arrears'|| rb.AcctSeed__Billing_Frequency__c =='Quarterly in Advance' || rb.AcctSeed__Billing_Frequency__c =='Quarterly in Arrears Equal Installments' || rb.AcctSeed__Billing_Frequency__c =='Arrears Per % of visits completed ')
                    {
                        if(month<=3) 
                        {
                            if(month==3 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 03, 31);
                            }
                        }
                        else if (month > 3 && month<=6)
                        {
                            if(month==6 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                                system.debug('next billing date ' + rb.AcctSeed__Next_Billing_Date__c);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }        
                        }
                        else if (month > 6 && month<=9)
                        {
                            if(month==9 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                            }
                        }
                        else
                        {
                            if(month==12 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year+1, 3, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                        }
                    }
                    ////////
                   /* if(rb.AcctSeed__Billing_Frequency__c =='Quarterly in Advance')
                    {
                        if(month<=3) 
                        {
                            if(month==3 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 03, 31);
                            }
                        }
                        else if (month > 3 && month<=6)
                        {
                            if(month==6 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }        
                        }
                        else if (month > 6 && month<=9)
                        {
                            if(month==9 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                            }
                        }
                        else
                        {
                            if(month==12 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year+1, 3, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                        }
                    }*/
                    /////////////////
                
                /*if(rb.AcctSeed__Billing_Frequency__c =='Quarterly in Arrears')
                    {
                        if(month<=3) 
                        {
                            if(month==3 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 03, 31);
                            }
                        }
                        else if (month > 3 && month<=6)
                        {
                            if(month==6 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }        
                        }
                        else if (month > 6 && month<=9)
                        {
                            if(month==9 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                            }
                        }
                        else
                        {
                            if(month==12 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year+1, 3, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                        }
                    }*/
                    //////////////////////
                 /* else if (rb.AcctSeed__Billing_Frequency__c =='Annual')                    
                    {
                            if(month!=12 && day !=31)
                            {
                                 rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                             }
                             else
                             { 
                                rb.AcctSeed__Next_Billing_Date__c=rb.AcctSeed__Last_Billing_Date__c.addDays(364);
                              }     
                    }*/
                    else if (rb.AcctSeed__Billing_Frequency__c =='Lump Sum'||rb.AcctSeed__Billing_Frequency__c =='Annual in Arrears')                    
                    {
                        system.debug('Anniversary in Advance' + rb.AcctSeed__Billing_Frequency__c);
                        Integer Remainder = Math.Mod(year,4);

                        if(Remainder==0)
                        {
                            rb.AcctSeed__Next_Billing_Date__c=rb.AcctSeed__Last_Billing_Date__c.addDays(365);
                            system.debug('Next Billing Date' + rb.AcctSeed__Next_Billing_Date__c);
                        }
                        else
                        {
                            rb.AcctSeed__Next_Billing_Date__c=rb.AcctSeed__Last_Billing_Date__c.addDays(364);
                            //system.debug('Next Billing Date1' + rb.AcctSeed__Next_Billing_Date__c);
                        }   
                    }
                    /*else if (rb.AcctSeed__Billing_Frequency__c =='Annual in Arrears')                    
                    {
                        integer Remainder = Math.Mod(year,4);
                        if(Remainder==0)
                        {
                            rb.AcctSeed__Next_Billing_Date__c=rb.AcctSeed__Last_Billing_Date__c.addDays(365);
                        }
                        else
                        {
                            rb.AcctSeed__Next_Billing_Date__c=rb.AcctSeed__Last_Billing_Date__c.addDays(364);
                        }   
                    }*/
                    else if (rb.AcctSeed__Billing_Frequency__c =='Monthly in Arrears' || rb.AcctSeed__Billing_Frequency__c =='Monthly in advance') 
                    {
                  
                            rb.AcctSeed__Next_Billing_Date__c=rb.AcctSeed__Last_Billing_Date__c.addDays(30);
                     }
                    /* else if (rb.AcctSeed__Billing_Frequency__c =='Monthly in advance') 
                    {
                  
                            rb.AcctSeed__Next_Billing_Date__c=rb.AcctSeed__Last_Billing_Date__c.addDays(30);
                     } */
                     /////////////////////////////
                    /* else if(rb.AcctSeed__Billing_Frequency__c =='Quarterly in Arrears Equal Installments')
                    {
                        if(month<=3) 
                        {
                            if(month==3 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 03, 31);
                            }
                        }
                        else if (month > 3 && month<=6)
                        {
                            if(month==6 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }        
                        }
                        else if (month > 6 && month<=9)
                        {
                            if(month==9 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                            }
                        }
                        else
                        {
                            if(month==12 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year+1, 3, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                        }
                    }*/
                    //////////////////
                   else if(rb.AcctSeed__Billing_Frequency__c =='Annual in Advance')
                    {    
                         if(month==12 && day ==31)
                         {
                             rb.AcctSeed__Next_Billing_Date__c=rb.AcctSeed__Last_Billing_Date__c.addDays(364);
                          }
                          else
                          {
                              rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                           }
                      } 
                    else if(rb.AcctSeed__Billing_Frequency__c =='Anniversary Semi-Annual in Arrears')
                        {
                        rb.AcctSeed__Next_Billing_Date__c=rb.AcctSeed__Last_Billing_Date__c.addMonths(06);
                        }
                     else if(rb.AcctSeed__Billing_Frequency__c =='Long Term')
                     {
                         rb.AcctSeed__Next_Billing_Date__c=sercon.EndDate;
                      }
                      //////////////////////
                     /*else  if(rb.AcctSeed__Billing_Frequency__c =='Arrears Per % of visits completed ')
                    {
                        if(month<=3) 
                        {
                            if(month==3 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 03, 31);
                            }
                        }
                        else if (month > 3 && month<=6)
                        {
                            if(month==6 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                            }        
                        }
                        else if (month > 6 && month<=9)
                        {
                            if(month==9 && day ==30)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 09, 30);
                            }
                        }
                        else
                        {
                            if(month==12 && day ==31)
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year+1, 3, 31);
                            }
                            else
                            {
                                rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                            }
                        }
                    }*/
                    //////////////////
                   else if(rb.AcctSeed__Billing_Frequency__c=='Mid Semi-Annual')
                    {
                        if(month==1 || month==2)
                        {
                            rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 03, 31);
                         }
                         else
                         {
                            rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 07, 30); 
                         }
                     } 
                     
                            
                    
                    
                      
                    else                     
                    {
                       if(month >= 1 && month<=5)
                       {
                       rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
                       }
                       else
                       {
                       rb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
                       }
                    }
            
                }
         //}
          try {
          update rb;
      }
      
      catch (system.DmlException e) {
       system.debug (e);
      }
      }
      
 }