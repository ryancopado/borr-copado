global class CalculateBillingLineRate
{
   webservice static String CalculateRate(Id customerId, Id recurringbillingId, Id servicecontractId,Id billingrecordId)
   {
         AcctSeed__Recurring_Billing__c recbill1= new AcctSeed__Recurring_Billing__c();
         //AcctSeed__Billing_Line__c recbillingline1= new AcctSeed__Billing_Line__c();
         Contract cont=new Contract(); 
         AcctSeed__Billing_Line__c recbillingline1=[select id from AcctSeed__Billing_Line__c where AcctSeed__Billing__c=:billingrecordId and AcctSeed__Revenue_GL_Account__c='a1m80000000p2kE'];
         
         recbill1 = [SELECT Name,AcctSeed__Next_Billing_Date__c, BillingDaysinCurrentEscalator__c,BillingDaysinPreviousEscalator__c,BillingDaysin__c from AcctSeed__Recurring_Billing__c where id=:recurringbillingId];
         system.debug('Billing Days'+  recbill1.BillingDaysinCurrentEscalator__c);
         system.debug('Prev Billing Days'+  recbill1.BillingDaysinPreviousEscalator__c);
         system.debug('Billing Days in'+  recbill1.BillingDaysin__c );
         cont= [SELECT EscalatorYearofContract__c,Payment_due_days__c FROM Contract where id=:servicecontractId];
         decimal escalator = cont.EscalatorYearofContract__c;
          decimal precontr=escalator - 1;
          decimal nextcontr=escalator + 1;
          
          Service_Contract_Escalator__c serescpre = new Service_Contract_Escalator__c ();
          
          Service_Contract_Escalator__c serescnext = new Service_Contract_Escalator__c ();
          Service_Contract_Escalator__c seresc = new Service_Contract_Escalator__c ();
          
          List<Service_Contract_Escalator__c> liCurr = new List<Service_Contract_Escalator__c>();
          List<Service_Contract_Escalator__c> liNext = new List<Service_Contract_Escalator__c>();
          List<Service_Contract_Escalator__c> liPrev = new List<Service_Contract_Escalator__c>();
            
          liPrev=[select Contract_Value_Per_Day__c from Service_Contract_Escalator__c where Year__c=:precontr and Service_Contract__c=:servicecontractId];
          liNext=[select Contract_Value_Per_Day__c from Service_Contract_Escalator__c where Year__c=:nextcontr and Service_Contract__c=:servicecontractId];
          liCurr=[select Contract_Value_Per_Day__c from Service_Contract_Escalator__c where Year__c=:escalator and Service_Contract__c=:servicecontractId];
          
          decimal calcprevvalue = 0;
          decimal calcnextvalue =0;
          decimal calccurrvalue=0;
          if(liPrev.size() > 0){
              serescpre = liPrev[0];
              system.debug('value per day prev' +serescpre.Contract_Value_Per_Day__c);
              calcprevvalue=serescpre.Contract_Value_Per_Day__c  *  recbill1.BillingDaysinPreviousEscalator__c; 
          }
          if(liNext.size() > 0){
              serescnext= liNext[0];
              system.debug('value per day next' +serescnext.Contract_Value_Per_Day__c);
              calcnextvalue = serescnext.Contract_Value_Per_Day__c * recbill1.BillingDaysin__c;
          }
          if(liCurr.size() > 0)
          {
              seresc= liCurr[0];
              system.debug('value per day current' +seresc.Contract_Value_Per_Day__c);
              calccurrvalue= seresc.Contract_Value_Per_Day__c * recbill1.BillingDaysinCurrentEscalator__c;
          }
          recbillingline1.AcctSeed__Rate__c=calcprevvalue+calcnextvalue+calccurrvalue;
          system.debug('prev'+calcprevvalue+ ' Curr' +calccurrvalue + ' next' +calcnextvalue+ ' total' +recbillingline1.AcctSeed__Rate__c);
          //recbillingline1.AcctSeed__Hours_Units__c=50;
          
          update recbillingline1;
          return 'BillingLine Rate has been updated';
          }
         
          
          }