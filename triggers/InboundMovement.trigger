trigger InboundMovement on AcctSeedERP__Inbound_Inventory_Movement__c (before insert, before update,After insert) {

   // populate record according to selected site , project, POL.
   
    List<AcctSeed__Journal_Entry__c> NewJE= new List<AcctSeed__Journal_Entry__c>();
    List<AcctSeed__Journal_Entry_Line__c> NewJEL = new List<AcctSeed__Journal_Entry_Line__c>();
    List<AcctSeed__Journal_Entry_Line__c> NewJEL1 = new List<AcctSeed__Journal_Entry_Line__c>();
    AcctSeedERP__Inbound_Inventory_Movement__c  InboundList = Trigger.new[0];
    site__c siteList = new site__c();
    AcctSeed__Project__c PrjList = new AcctSeed__Project__c();
    AcctSeedERP__Purchase_Order_Line__c PolList = new AcctSeedERP__Purchase_Order_Line__c();
    string getbranchid;
    if (trigger.isbefore) {
        system.debug('this is before trigger');
    if  (InboundList.site__c != null) {
    
          siteList =[select Id,name,Tax_Group__c from site__c where  id =:InboundList.site__c];
    
                  if (InboundList.Tax_Jurisdiction__c == null) {
                  
                      InboundList.Tax_Jurisdiction__c =siteList.Tax_Group__c;}
                      
                 else   {
                 
                      InboundList.Tax_Jurisdiction__c =InboundList.Tax_Jurisdiction__c;
                        }
  
      } 
   
   
   if  (InboundList.AcctSeedERP__Project__c != null) {
   
         PrjList  =[select Id,name,Branch__c,Ops_Division__c,Sales_Segment__c,Default_Expense_GL_Account__c from AcctSeed__Project__c where  id =:InboundList.AcctSeedERP__Project__c];
         
         List<AcctSeed__Accounting_Variable__c>branchid=new List<AcctSeed__Accounting_Variable__c>();
              
         branchid=[select id,Name from AcctSeed__Accounting_Variable__c where Name=:PrjList.Branch__c and AcctSeed__Type__c  = 'GL Account Variable 1'];//added by DK on 2/25/2020 for branch change in project and accounting variable object.
         if(branchid.size()>0)
         {
         system.debug('entering if' +branchid);
          AcctSeed__Accounting_Variable__c branchrecords= new AcctSeed__Accounting_Variable__c();
          branchrecords=branchid.get(0);
           InboundList.Branch__c= branchrecords.Id ; 
           inboundlist.AcctSeedERP__GL_Account_Variable_1__c =branchrecords.Id; 
      //system.debug('get branch-->' +branchrecords.Id);
     // getbranchid = branchrecords.Id ;
          }
        
  /* IF (PrjList.Branch__c == 'Boston') 
   {
   
    InboundList.Branch__c = 'a1O80000005KqHEEA0';
   }
   
   IF (PrjList.Branch__c == 'San Diego') 
   {
   
    InboundList.Branch__c = 'a1O80000005KqH4EAK';
   }
   
   IF (PrjList.Branch__c == 'Mid Atlantic') 
   {
   
    InboundList.Branch__c = 'a1O80000005KqHJEA0';
   }
   
   IF (PrjList.Branch__c == 'Southeast') 
   {
   
    InboundList.Branch__c = 'a1O34000009yiDwEAI';
   }
   
   IF (PrjList.Branch__c == 'Oakland') 
   {
   
    InboundList.Branch__c = 'a1O80000005KqH9EAK';
   }
   
   IF (PrjList.Branch__c == 'Berkeley') 
   {
   
    InboundList.Branch__c = 'a1O80000005KqH9EAK';
   }
   
   IF (PrjList.Branch__c == 'Midwest') 
   {
   
    InboundList.Branch__c = 'a1O3400000ALkJDEA1';
   }*/
   
       if (!test.isRunningTest()){
         inboundlist.AcctSeedERP__Credit_GL_Account__c =PrjList.Default_Expense_GL_Account__c ;  
       }
    
    
    InboundList.AcctSeedERP__GL_Account_Variable_2__c=PrjList.Sales_Segment__c;
    InboundList.AcctSeedERP__GL_Account_Variable_3__c=PrjList.Ops_Division__c; 
         
         
 }
 
 
    if  (InboundList.Purchase_Order_Line__c != null) {
    PolList  =[select Id,AcctSeedERP__Purchase_Order__c,Unit_Cost__c from AcctSeedERP__Purchase_Order_Line__c  where id=:InboundList.Purchase_Order_Line__c];
    
    InboundList.AcctSeedERP__Unit_Cost__c=PolList.Unit_Cost__c;
    InboundList.Purchase_Order_AcctSeed__c=PolList.AcctSeedERP__Purchase_Order__c;
    }
        
}  

if (trigger.isUpdate) {
 
 if ( InboundList.AcctSeedERP__Type__c !='Inventory Transfer'  &&  InboundList.AcctSeedERP__Type__c != 'Non-Accounting') {
 
 if( Trigger.oldmap.get(InboundList.id).Value_of_Sales_Tax__c != InboundList.Value_of_Sales_Tax__c) {
    
     system.debug('The value of Tax' +InboundList.Value_of_Sales_Tax__c);
     AcctSeed__Journal_Entry_Line__c updateJELine = new AcctSeed__Journal_Entry_Line__c();
     
     
     list <AcctSeed__Journal_Entry_Line__c> newtaxvalue =[select  id, AcctSeed__Debit__c from AcctSeed__Journal_Entry_Line__c  where Inbound_Inventory_Movement__c = :InboundList.id  and AcctSeed__Debit__c != null limit  1 ];
    
    
    updateJELine  =newtaxvalue.get(0);
    
    updateJELine .AcctSeed__Debit__c = InboundList.Value_of_Sales_Tax__c;
    
    update updateJELine ;
    }
    
    if( Trigger.oldmap.get(InboundList.id).Value_of_Sales_Tax__c != InboundList.Value_of_Sales_Tax__c) {
    
    system.debug('The value of Tax' +InboundList.Value_of_Sales_Tax__c);
    AcctSeed__Journal_Entry_Line__c updateJELine1 = new AcctSeed__Journal_Entry_Line__c();
    
    list <AcctSeed__Journal_Entry_Line__c> newtaxvalue1 =[select  id,AcctSeed__Credit__c from AcctSeed__Journal_Entry_Line__c  where Inbound_Inventory_Movement__c = :InboundList.id  and AcctSeed__credit__c != null limit 1 ];
   
    updateJELine1  =newtaxvalue1.get(0);
  
    updateJELine1 .AcctSeed__Credit__c = InboundList.Value_of_Sales_Tax__c;
    
    update updateJELine1 ;
    
    }
    }
 } 



   if (trigger.isAfter)
    {
  /*   system.debug('this is update brach');
    AcctSeedERP__Inbound_Inventory_Movement__c updatebranch = new AcctSeedERP__Inbound_Inventory_Movement__c();
    updatebranch.id = inboundlist.id;
    updatebranch.AcctSeedERP__GL_Account_Variable_1__c  = 'a1O2H00000D2irG';// getbranchid ;
    system.debug('look here' +updatebranch );
   // update updatebranch; */
    
   system.debug('this is AFTER trigger');
  if ( InboundList.AcctSeedERP__Type__c !='Inventory Transfer'  &&  InboundList.AcctSeedERP__Type__c != 'Non-Accounting') {
   AcctSeedERP__Inbound_Inventory_Movement__c  Inboundname = [select id,Name from AcctSeedERP__Inbound_Inventory_Movement__c where id = :InboundList.id] ;
   AcctSeed__Journal_Entry__c JournalEntry = new AcctSeed__Journal_Entry__c();
  
   
   
   JournalEntry.Name =  Inboundname.name;
   JournalEntry.Inbound_Inventory_Movement__c = Inboundname.id;
   JournalEntry.AcctSeed__Journal_Date__c = system.today();
   JournalEntry.AcctSeed__Status__c = 'Approved';
   
   NewJE.add(JournalEntry);
   insert NewJE;
   
 //  list <AcctSeed__Transaction__c> TransLine = new list<AcctSeed__Transaction__c >();
 //  list <AcctSeedERP__Inbound_Inventory_Movement__c> lstinbound = new list <AcctSeedERP__Inbound_Inventory_Movement__c>();
 //  TransLine = [select AcctSeedERP__Inbound_Inventory_Movement__c,AcctSeed__Amount__c,AcctSeed__Account__c,AcctSeed__GL_Account__c,AcctSeed__Project__c,AcctSeed__Project_Task__c,AcctSeed__GL_Account_Variable_1__c,AcctSeed__GL_Account_Variable_2__c,AcctSeed__GL_Account_Variable_3__c from AcctSeed__Transaction__c where AcctSeedERP__Inbound_Inventory_Movement__c = :InboundList.id];
 
   AcctSeedERP__Inbound_Inventory_Movement__c  inboundvalues=new AcctSeedERP__Inbound_Inventory_Movement__c ();
   list <AcctSeedERP__Inbound_Inventory_Movement__c> lstinbound  = [select id,Name,Branch__c,Value_of_Sales_Tax__c,AcctSeedERP__Credit_GL_Account__c,AcctSeedERP__Debit_GL_Account__c,AcctSeedERP__Project__c,AcctSeedERP__Project_Task__c,AcctSeedERP__GL_Account_Variable_1__c,AcctSeedERP__GL_Account_Variable_2__c,AcctSeedERP__GL_Account_Variable_3__c  from AcctSeedERP__Inbound_Inventory_Movement__c where id = :InboundList.id];
  
  
  inboundvalues=lstinbound.get(0);
  
  AcctSeed__Journal_Entry_Line__c JELine = new AcctSeed__Journal_Entry_Line__c();
  
  JELine.AcctSeed__Journal_Entry__c = JournalEntry.id;
  JELine.AcctSeed__Credit__c = inboundvalues.Value_of_Sales_Tax__c;
  JELine.AcctSeed__GL_Account__c = inboundvalues.AcctSeedERP__Credit_GL_Account__c;
  JELine.Inbound_Inventory_Movement__c = inboundvalues.id;
  JELine.AcctSeed__Project__c = inboundvalues.AcctSeedERP__Project__c;
  JELine.AcctSeed__Project_Task__c = inboundvalues.AcctSeedERP__Project_Task__c;
  JELine.AcctSeed__GL_Account_Variable_1__c = inboundvalues.Branch__c;   //inboundvalues.AcctSeedERP__GL_Account_Variable_1__c;
  JELine.AcctSeed__GL_Account_Variable_2__c = inboundvalues.AcctSeedERP__GL_Account_Variable_2__c;
  JELine.AcctSeed__GL_Account_Variable_3__c = inboundvalues.AcctSeedERP__GL_Account_Variable_3__c;
  JELine.Description__c ='Inbound Tax adjustment';
  
  NewJEL.add(JELine);
   insert NewJEL; 
   
  AcctSeed__Journal_Entry_Line__c JELine1 = new AcctSeed__Journal_Entry_Line__c();
  JELine1.AcctSeed__Journal_Entry__c = JournalEntry.id;
  JELine1.AcctSeed__Debit__c=inboundvalues.Value_of_Sales_Tax__c;
  JELine1.AcctSeed__GL_Account__c = inboundvalues.AcctSeedERP__Debit_GL_Account__c;
  JELine1.Inbound_Inventory_Movement__c = inboundvalues.id;
  JELine1.AcctSeed__Project__c = inboundvalues.AcctSeedERP__Project__c;
  JELine1.AcctSeed__Project_Task__c = inboundvalues.AcctSeedERP__Project_Task__c;
  JELine1.AcctSeed__GL_Account_Variable_1__c = inboundvalues.Branch__c;//inboundvalues.AcctSeedERP__GL_Account_Variable_1__c;
  JELine1.AcctSeed__GL_Account_Variable_2__c = inboundvalues.AcctSeedERP__GL_Account_Variable_2__c;
  JELine1.AcctSeed__GL_Account_Variable_3__c = inboundvalues.AcctSeedERP__GL_Account_Variable_3__c;
  JELine1.Description__c ='Inbound Tax adjustment';
  
  NewJEL1.add(JELine1);     
  insert NewJEL1; 
   
 /* for(AcctSeed__Transaction__c tl:TransLine )
  {
  AcctSeed__Journal_Entry_Line__c JELine = new AcctSeed__Journal_Entry_Line__c();
    JELine.AcctSeed__Journal_Entry__c = JournalEntry.id;
    if (tl.AcctSeed__Amount__c>0) {
    JELine.AcctSeed__Credit__c=tl.AcctSeed__Amount__c;
    }
    else
    {
    JELine.AcctSeed__Debit__c=tl.AcctSeed__Amount__c;
    }
    
    JELine.AcctSeed__GL_Account__c = tl.AcctSeed__GL_Account__c;
    JELine.Inbound_Inventory_Movement__c = tl.AcctSeedERP__Inbound_Inventory_Movement__c;
    JELine.AcctSeed__Project__c = tl.AcctSeed__Project__c;
    JELine.AcctSeed__Project_Task__c = tl.AcctSeed__Project_Task__c;
    JELine.AcctSeed__GL_Account_Variable_1__c = tl.AcctSeed__GL_Account_Variable_1__c;
    JELine.AcctSeed__GL_Account_Variable_2__c = tl.AcctSeed__GL_Account_Variable_2__c;
    JELine.AcctSeed__GL_Account_Variable_3__c = tl.AcctSeed__GL_Account_Variable_3__c;
    
    NewJEL.add(JELine);
   }*/
   
   }
    
 }
    
   
    
    
}