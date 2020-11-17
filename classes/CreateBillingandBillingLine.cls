global class CreateBillingandBillingLine
{
     webservice static String createbilling(Id customerId, Id recurringbillingId, Id servicecontractId,String nextBillingDate) 
     {
     List <AcctSeed__Billing__c > createbilling= new List <AcctSeed__Billing__c>(); 
     List <AcctSeed__Billing_Line__c> createbillingline=new List<AcctSeed__Billing_Line__c >();
         system.debug('Date'+  nextBillingDate);
         //Date nextBillDate =  Date.valueOf(nextBillingDate.replace('/','-'));
         Date nextBillDate =  Date.parse(nextBillingDate);
         system.debug('Date typecaseted value'+  nextBillDate);
         
         AcctSeed__Billing__c bill = new AcctSeed__Billing__c();
         
         AcctSeed__Recurring_Billing__c recbill= new AcctSeed__Recurring_Billing__c(); 
         
         recbill = [SELECT Name,AcctSeed__Next_Billing_Date__c, BillingDaysinCurrentEscalator__c,BillingDaysinPreviousEscalator__c,BillingDaysin__c,CurrentPeriodStartDate__c,CurrentPeriodEndDate__c from AcctSeed__Recurring_Billing__c where id=:recurringbillingId];
         system.debug('Date' +recbill.CurrentPeriodStartDate__c);
         system.debug('Billing Days'+  recbill.BillingDaysinCurrentEscalator__c);
         system.debug('Prev Billing Days'+  recbill.BillingDaysinPreviousEscalator__c);
         system.debug('Billing Days in'+  recbill.BillingDaysin__c );
         
      Date d = recbill.CurrentPeriodStartDate__c;
      string dateStr = DateTime.newInstance(d.year(),d.month(),d.day()).format('MM/dd/yyyy');
         
      Date d1 = recbill.CurrentPeriodEndDate__c;
      string dateStr1 = DateTime.newInstance(d1.year(),d1.month(),d1.day()).format('MM/dd/yyyy');

         
         Contract con=new Contract();
         con = [SELECT EscalatorYearofContract__c,Payment_due_days__c,ASProject__c FROM Contract where id=:servicecontractId];
         
        
         
         bill.AcctSeed__Billing_Format__c='a1U34000003y3Ql';
         bill.AcctSeed__Customer__c=customerId;     
         bill.Service_Contract__c=servicecontractId;
         bill.AcctSeed__Recurring_Billing__c=recurringbillingId;
         bill.Application_Number__c=bill.Name;
         integer daysToAdd = 0;
         if(con.Payment_due_days__c!=null)
         {
             daysToAdd = integer.ValueOf(con.Payment_due_days__c);
         }       
         bill.AcctSeed__Date__c=nextBillDate;
         bill.AcctSeed__Due_Date2__c = bill.AcctSeed__Date__c.addDays(daysToAdd);
         system.debug('Next Due date'+bill.AcctSeed__Due_Date2__c);
         bill.AcctSeed__Proprietary_Billing_Number__c=String.Valueof(recbill.Name) +' ' +'Service' +' ' + String.ValueOf(dateStr) +' ' + ('-') + ' ' + String.ValueOf(dateStr1) ;
       
          createbilling.add(bill);
          insert createbilling;
          
          
          AcctSeed__Billing_Line__c recbillingline= new AcctSeed__Billing_Line__c();
         
          recbillingline.AcctSeed__Revenue_GL_Account__c='a1m80000000p2kE';
          recbillingline.AcctSeed__Date__c=System.today();
          recbillingline.AcctSeed__Project__c=con.ASProject__c;
          recbillingline.AcctSeed__GL_Account_Variable_1__c='a1O80000005KqHT';
          recbillingline.AcctSeed__Hours_Units__c=1;
          AcctSeed__Billing__c bi=[select Name,AcctSeed__Proprietary_Billing_Number__c from AcctSeed__Billing__c where id=:createbilling];
          recbillingline.AcctSeed__Billing__c=bi.id;
          recbillingline.Description__c = bi.AcctSeed__Proprietary_Billing_Number__c;
          system.debug('Escalator curr value' +con.EscalatorYearofContract__c);
          AcctSeed__Recurring_Billing_Line__c RecLineTax =  [SELECT Tax_Category__c FROM AcctSeed__Recurring_Billing_Line__c where  AcctSeed__Recurring_Billing__c=:recurringbillingId];
          recbillingline.Category__c = RecLineTax.Tax_Category__c;
          recbillingline.AcctSeed__Rate__c=1;
          string projectid1= string.valueOf(con.ASProject__c).substring(0,15);
          system.debug('Project Id' +projectid1);
          AcctSeed__Project_Task__c projecttask1=[select id from AcctSeed__Project_Task__c  where AcctSeed__Project__c=:projectid1 and Name='Paid Service-OM'];
          recbillingline.AcctSeed__Project_Task__c=projecttask1.id;
          decimal escalator = con.EscalatorYearofContract__c;
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
              calcprevvalue=serescpre.Contract_Value_Per_Day__c  *  recbill.BillingDaysinPreviousEscalator__c; 
          }
          if(liNext.size() > 0){
              serescnext= liNext[0];
              system.debug('value per day next' +serescnext.Contract_Value_Per_Day__c);
              calcnextvalue = serescnext.Contract_Value_Per_Day__c * recbill.BillingDaysin__c;
          }
          if(liCurr.size() > 0)
          {
              seresc= liCurr[0];
              system.debug('value per day current' +seresc.Contract_Value_Per_Day__c);
              calccurrvalue= seresc.Contract_Value_Per_Day__c * recbill.BillingDaysinCurrentEscalator__c;
              //calccurrvalue=0;
          }
          
          recbillingline.AcctSeed__Rate__c=calcprevvalue+calcnextvalue+calccurrvalue;
          system.debug('prev'+calcprevvalue+ ' Curr' +calccurrvalue + ' next' +calcnextvalue+ ' total' +recbillingline.AcctSeed__Rate__c);
          
          createbillingline.add(recbillingline);
          insert createbillingline; 
          return 'Billing and BillingLine Created';
              
         }
}