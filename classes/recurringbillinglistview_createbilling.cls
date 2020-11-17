public with sharing class recurringbillinglistview_createbilling
{
      
      private ApexPages.StandardSetController stdSetrec;
      private ApexPages.StandardController controller {get; set;}
       private AcctSeed__Recurring_Billing__c RB {get;set;}
       public Id RBId{set; get;}
       public String RBName{set; get;}
       public String RBSC{set; get;}
       //public  Date nextbillingdate;
       
      
      private String listViewFilterId1;
      private String recurringId;
      public  String eachRecord1id{get;set;}
      public List<AcctSeed__Recurring_Billing__c> lstRBQuery{get;set;}
      
      public List <AcctSeed__Billing__c > createbilling;
      public List <AcctSeed__Billing_Line__c> createbillingline;
      public List<AcctSeed__Recurring_Billing_Line__c> lstRBLQuery{get;set;}
      public List<AcctSeed__Recurring_Billing__c> toCreateBill1;
      Public Id BillingId;
      private final AcctSeed__Recurring_Billing__c rbs;
      
      public List<wrapperRecuringBilling> recurringBillingList {get; set;}
      public class wrapperRecuringBilling
      {
        public AcctSeed__Recurring_Billing__c bill {get; set;}
        public AcctSeed__Recurring_Billing_Line__c billLine {get; set;}
        public Boolean selected {get; set;}
        public wrapperRecuringBilling(AcctSeed__Recurring_Billing__c b,AcctSeed__Recurring_Billing_Line__c bl) 
            {
                bill = b;
                billLine=bl;
                selected = false;
            }
      } 
      public recurringbillinglistview_createbilling(ApexPages.StandardController controller) 
      {
          this.controller = controller;
          this.RB= (AcctSeed__Recurring_Billing__c )controller.getRecord();
          system.debug('RBS' +rbs);
      }
      
      public PageReference processSelected() {
      
       toCreateBill1 = new List <AcctSeed__Recurring_Billing__c>();
       AcctSeed__Recurring_Billing__c toCreateBill = new AcctSeed__Recurring_Billing__c();
       
      toCreateBill1 =[SELECT AcctSeed__Next_Billing_Date__c from AcctSeed__Recurring_Billing__c where Id=:this.RBId];
      //if(toCreateBill1 .size()>0)
      //{
      toCreateBill=toCreateBill1.get(0);
      Date nextbillingdate=toCreateBill.AcctSeed__Next_Billing_Date__c;
      //}
      system.debug('NBD' +nextbillingdate);
      
      toCreateBill.AcctSeed__Customer__c=this.RBName;
      //system.debug('Customer' +toCreateBill.AcctSeed__Customer__c);
      toCreateBill.id=this.RBId;
      //system.debug('ID' +toCreateBill.id);
      toCreateBill.Service_Contract__c=this.RBSC;
      
          createBilling(toCreateBill.AcctSeed__Customer__c,toCreateBill.id,toCreateBill.Service_Contract__c,nextbillingdate); 
          //system.debug('Billing Record id' +createBilling);   
      //}
          BillingId=createbilling.get(0).id;
          system.debug('Billing Id' +createbilling.get(0).id);
          PageReference pg = null;
          //PageReference pg;
          //pg = new PageReference('/'+BillingId+'?isdtp=vw');
          pg = new PageReference('/'+BillingId);
          system.debug('Page reference'+ pg);    
          pg.setRedirect(true); 
          return pg;
     }
     
     
     public recurringbillinglistview_createbilling(ApexPages.StandardSetController stdSetrec)
     {
        this.stdSetrec= stdSetrec;
        system.debug('recurringbillinglistview_createbilling method');
        List<AcctSeed__Recurring_Billing__c>selectedRecurringBilling= stdSetrec.getSelected();
        system.debug('List'+stdSetrec.getSelected());
        system.debug('List size'+selectedRecurringBilling.size());
        recurringBillingList = new List<wrapperRecuringBilling> ();
        lstRBQuery=new List<AcctSeed__Recurring_Billing__c>();
        lstRBLQuery=new List<AcctSeed__Recurring_Billing_Line__c>();
        lstRBQuery=[select Name,AcctSeed__Next_Billing_Date__c,AcctSeed__Customer__c,Service_Contract__c,id from AcctSeed__Recurring_Billing__c where id in :selectedRecurringBilling]; 
        lstRBLQuery=[select AcctSeed__Quantity__c,AcctSeed__Total__c,AcctSeed__Rate__c,id from AcctSeed__Recurring_Billing_Line__c where AcctSeed__Recurring_Billing__c in :selectedRecurringBilling];     
        for(integer i=0;i<lstRBQuery.size();i++) 
        {        
            if(i<lstRBLQuery.size()){
                recurringBillingList.add(new wrapperRecuringBilling(lstRBQuery[i],lstRBLQuery[i]));
            }
            else{                
                recurringBillingList.add(new wrapperRecuringBilling(lstRBQuery[i],new AcctSeed__Recurring_Billing_Line__c()));
            }   
        }        
    }
                    
   public void createbilling(Id customerId, Id recurringbillingId, Id servicecontractId,Date nextBillDate) 
     {
          createbilling= new List <AcctSeed__Billing__c>(); 
          createbillingline=new List<AcctSeed__Billing_Line__c >();
          List<AcctSeed__Recurring_Billing_Line__c>RecLineTax =new List<AcctSeed__Recurring_Billing_Line__c>();
         
         
         AcctSeed__Billing__c bill = new AcctSeed__Billing__c();
         
         AcctSeed__Recurring_Billing__c recbill= new AcctSeed__Recurring_Billing__c(); 
         system.debug('RBID' +recurringbillingId);
         
         recbill = [SELECT BillingDaysinCurrentEscalator__c,BillingDaysinPreviousEscalator__c,Name,AcctSeed__Next_Billing_Date__c,BillingDaysin__c from AcctSeed__Recurring_Billing__c where id=:recurringbillingId];
         system.debug('Billing Days'+  recbill.BillingDaysinCurrentEscalator__c);
         system.debug('Prev Billing Days'+  recbill.BillingDaysinPreviousEscalator__c);
         system.debug('Billing Days in'+  recbill.BillingDaysin__c );
         
         Contract con=new Contract();
         con = [SELECT EscalatorYearofContract__c,Payment_due_days__c,ASProject__c FROM Contract where id=:servicecontractId];
         
         
         
         bill.AcctSeed__Billing_Format__c='a1U34000003y3Ql';
         bill.AcctSeed__Proprietary_Billing_Number__c=String.Valueof(recbill.Name) + ('-') + String.ValueOf(recbill.AcctSeed__Next_Billing_Date__c) ;
         bill.AcctSeed__Customer__c=customerId;     
         bill.Service_Contract__c=servicecontractId;
         bill.AcctSeed__Recurring_Billing__c=recurringbillingId;
         
         integer daysToAdd = 0;
         if(con.Payment_due_days__c!=null)
         {
             daysToAdd = integer.ValueOf(con.Payment_due_days__c);
         }       
         bill.AcctSeed__Date__c=nextBillDate;
         bill.AcctSeed__Due_Date2__c = bill.AcctSeed__Date__c.addDays(daysToAdd);
         system.debug('Next Due date'+bill.AcctSeed__Due_Date2__c);
       
          createbilling.add(bill);
          insert createbilling;
          //AcctSeed__Billing__c bi1=[select Name from AcctSeed__Billing__c where id=:createbilling];
          //system.debug('Billing Name' +bi1.Name);
          //bill.Application_Number__c=bi1.Name;
          //update createbilling;
          //system.debug('Create Billing ' +createbilling);
          
          
          
          AcctSeed__Billing_Line__c recbillingline= new AcctSeed__Billing_Line__c();
          recbillingline.AcctSeed__Revenue_GL_Account__c='a1m80000000p2kE';
          recbillingline.AcctSeed__Date__c=System.today();
          recbillingline.AcctSeed__Project__c=con.ASProject__c;
          recbillingline.AcctSeed__GL_Account_Variable_1__c='a1O80000005KqHT';
         
          recbillingline.AcctSeed__Hours_Units__c=100;
          AcctSeed__Billing__c bi=[select Name,AcctSeed__Proprietary_Billing_Number__c from AcctSeed__Billing__c where id=:createbilling];
          recbillingline.AcctSeed__Billing__c=bi.id;
          system.debug('Escalator curr value' +con.EscalatorYearofContract__c);
          
           recbillingline.AcctSeed__Rate__c=1;
          
           recbillingline.Description__c = bi.AcctSeed__Proprietary_Billing_Number__c;
            AcctSeed__Recurring_Billing_Line__c RBLineTax=new AcctSeed__Recurring_Billing_Line__c();
             
            RecLineTax =  [SELECT Tax_Category__c FROM AcctSeed__Recurring_Billing_Line__c where  AcctSeed__Recurring_Billing__c=:recurringbillingId];
           if(RecLineTax.size()>0)
           {
           recbillingline.Category__c = RBLineTax.Tax_Category__c;
           }
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
          }
          recbillingline.AcctSeed__Rate__c=calcprevvalue+calcnextvalue+calccurrvalue;
          system.debug('prev'+calcprevvalue+ ' Curr' +calccurrvalue + ' next' +calcnextvalue+ ' total' +recbillingline.AcctSeed__Rate__c);
          
          createbillingline.add(recbillingline);
          insert createbillingline;
          
         

          
    }
         
}