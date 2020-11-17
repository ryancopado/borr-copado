trigger CreateRecurringBilling on Contract (after update) 
{
List<AcctSeed__Recurring_Billing__c> RecurringBilling = new List<AcctSeed__Recurring_Billing__c>();
List<AcctSeed__Recurring_Billing_Line__c>RecurringBillingLine = new List<AcctSeed__Recurring_Billing_Line__c>();
//List<AcctSeed__Billing_Format__c> BillingFormat=new List<AcctSeed__Billing_Format__c>();    
for (Contract cr : Trigger.new) {
if(Trigger.oldmap.get(cr.id).Contract_Status__c != Trigger.newmap.get(cr.id).Contract_Status__c && Trigger.newmap.get(cr.id).Contract_Status__c == 'Active' && cr.Type__c=='O&M')

//if (cr.Contract_Status__c == 'Active') 
{
    AcctSeed__Recurring_Billing__c createrb = new AcctSeed__Recurring_Billing__c();
    AcctSeed__Recurring_Billing_Line__c createrbl = new AcctSeed__Recurring_Billing_Line__c();
    createrb.Name=cr.Recurring_Billing_Name__c;       
    createrb.AcctSeed__Customer__c=cr.AccountId;    
    createrb.Billing_Format__c='a1U34000003y3Ql' ;
    createrb.Service_Contract__c=cr.id;
    createrb.AcctSeed__Status__c='Active';
    createrb.AcctSeed__Billing_Frequency__c=cr.Payment_Options__c;
    createrb.AcctSeed__Last_Billing_Date__c=cr.Service_Contract_Start_Date__c; 
    date servicebillingdate= cr.Service_Contract_Start_Date__c;
    Integer year = servicebillingdate.year();
    Integer month = servicebillingdate.month();
    Integer day = servicebillingdate.day();
    if(cr.Payment_Options__c=='Semi-Annual in Arrears')
    {
        if(month>=1 && month<=6)
        {
           createrb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 06, 30);
         } 
        else
        {
            createrb.AcctSeed__Next_Billing_Date__c=Date.newInstance(year, 12, 31);
         }
       }
         else
         {  
            createrb.AcctSeed__Next_Billing_Date__c=cr.Calculate_Next_Billing_Date__c;
         }
    RecurringBilling.add(createrb);
    insert RecurringBilling;
    
    createrbl.AcctSeed__Recurring_Billing__c =createrb.id;
    createrbl.AcctSeed__Date__c=System.today();
    createrbl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2kE';
    createrbl.AcctSeed__GL_Account_Variable_1__c='a1O80000005KqHT';
    createrbl.AcctSeed__Project__c=cr.ASProject__c;
    string projectid=createrbl.AcctSeed__Project__c;
   AcctSeed__Project_Task__c projecttask=[select id from AcctSeed__Project_Task__c where AcctSeed__Project__c=:projectid and Name='Paid Service-OM'];
    createrbl.AcctSeed__Project_Task__c=projecttask.id;
    createrbl.AcctSeed__Quantity__c=1;
    If(cr.Payment_Options__c=='Lump Sum')
    {
       createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c;
    }
    Else If(cr.Payment_Options__c=='Annual-Jan to Dec in Advance')
    {
        createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c;
    }
    Else If(cr.Payment_Options__c=='Mid Semi-Annual')
    {
        createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c/2;
    }
    Else If(cr.Payment_Options__c=='Monthly in Advance')
     {
       createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c/12;
      }
    Else If(cr.Payment_Options__c=='Quarterly in Advance')
    {
      createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c/4;
    }
   Else If(cr.Payment_Options__c=='Quarterly in Advance Equal Installments')
    {
       createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c/4; 
    }
    Else If(cr.Payment_Options__c=='Quarterly in Arrears')
    {
       createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c/4; 
    }
    Else If(cr.Payment_Options__c=='Quarterly in Arrears Equal Installments')
    {
       createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c/4; 
    }
    Else If(cr.Payment_Options__c=='Semi-Annual in Advance')
    {
       createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c/2; 
    }
    Else If(cr.Payment_Options__c=='Annual - Jan to Dec in Advance')
    {
    createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c; 
    }
    Else
    
    {
       createrbl.AcctSeed__Rate__c=cr.Contract_Amount__c/2; 
    }
    
    RecurringBillingLine.add(createrbl);
    }
    //insert RecurringBilling;
    insert RecurringBillingLine;
    }
    }