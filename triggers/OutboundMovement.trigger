trigger OutboundMovement on AcctSeedERP__Outbound_Inventory_Movement__c (before insert , before update,after insert) {
  // populate record according to selected site , project, POL.
   
    
    AcctSeedERP__Outbound_Inventory_Movement__c  OutboundList = Trigger.new[0];
    List<AcctSeed__Journal_Entry__c> NewJE= new List<AcctSeed__Journal_Entry__c>();
    List<AcctSeed__Journal_Entry_Line__c> NewJEL = new List<AcctSeed__Journal_Entry_Line__c>();
    List<AcctSeed__Journal_Entry_Line__c> NewJEL1 = new List<AcctSeed__Journal_Entry_Line__c>();
     
     
    site__c siteList = new site__c();
    AcctSeed__Project__c PrjList = new AcctSeed__Project__c();
    AcctSeedERP__Purchase_Order_Line__c PolList = new AcctSeedERP__Purchase_Order_Line__c();
         
   
    if (trigger.isbefore) {
    
    
    if (OutboundList.site__c != null) {
    
    if (OutboundList.Tax_Jurisdiction__c == null) {
        
        siteList =[select Id,Tax_Group__c from site__c where  id =:OutboundList.site__c];
        OutboundList.Tax_Jurisdiction__c =siteList.Tax_Group__c;}
     
     else{OutboundList.Tax_Jurisdiction__c = OutboundList.Tax_Jurisdiction__c;}
   
    }
    
    if (OutboundList.AcctSeedERP__Project__c != null) {
    PrjList  =[select Id,name,Branch__c,Ops_Division__c,Sales_Segment__c,Default_Expense_GL_Account__c from AcctSeed__Project__c where  id =:OutboundList.AcctSeedERP__Project__c];
     List<AcctSeed__Accounting_Variable__c>branchid=new List<AcctSeed__Accounting_Variable__c>();
              
         branchid=[select id,Name from AcctSeed__Accounting_Variable__c where Name=:PrjList.Branch__c];//added by DK on 2/25/2020 for branch change in project and accounting variable object.
         if(branchid.size()>0)
         {
         system.debug('entering if' +branchid);
          AcctSeed__Accounting_Variable__c branchrecords= new AcctSeed__Accounting_Variable__c();
          branchrecords=branchid.get(0);
          OutboundList.AcctSeedERP__GL_Account_Variable_1__c =branchrecords.Id; 
          OutboundList.Branch__c= branchrecords.Id ; 
          }
    
           /*  IF (PrjList.Branch__c == 'Boston') 
           {
            OutboundList.Branch__c = 'a1O80000005KqHEEA0';
           }
           IF (PrjList.Branch__c == 'San Diego') 
           {
            OutboundList.Branch__c = 'a1O80000005KqH4EAK';
           }
           IF (PrjList.Branch__c == 'Mid Atlantic') 
           {
            OutboundList.Branch__c = 'a1O80000005KqHJEA0';
           }
           IF (PrjList.Branch__c == 'Southeast') 
           {
            OutboundList.Branch__c = 'a1O34000009yiDwEAI';
           }
           IF (PrjList.Branch__c == 'Oakland') 
           {
            OutboundList.Branch__c = 'a1O80000005KqH9EAK';
           }
           IF (PrjList.Branch__c == 'Berkeley') 
           {
            OutboundList.Branch__c = 'a1O80000005KqH9EAK';
           }
           IF (PrjList.Branch__c == 'Midwest') 
           {
            OutboundList.Branch__c = 'a1O3400000ALkJDEA1';
           }*/
   
            OutboundList.AcctSeedERP__GL_Account_Variable_2__c=PrjList.Sales_Segment__c;
            OutboundList.AcctSeedERP__GL_Account_Variable_3__c=PrjList.Ops_Division__c;
        if (!test.isRunningTest()){
             Outboundlist.AcctSeedERP__Debit_GL_Account__c = Prjlist.Default_Expense_GL_Account__c;
        }
           
 }
    
    if (OutboundList.Purchase_Order_Line__c != null) {
    
    PolList  =[select Id,AcctSeedERP__Purchase_Order__c,Unit_Cost__c from AcctSeedERP__Purchase_Order_Line__c  where id=:OutboundList.Purchase_Order_Line__c];
    
        OutboundList.AcctSeedERP__Unit_Cost__c=PolList.Unit_Cost__c;
        OutboundList.Purchase_Order__c=PolList.AcctSeedERP__Purchase_Order__c;  
    
    }
    
    
    //isInsert
    
    
    
 }  
 if (trigger.isUpdate) {
 
 if ( OutboundList.AcctSeedERP__Type__c !='Inventory Transfer'  &&  OutboundList.AcctSeedERP__Type__c != 'Non-Accounting') {
 if( Trigger.oldmap.get(OutboundList.id).Value_of_Sales_Tax__c != OutboundList.Value_of_Sales_Tax__c) {
    
     system.debug('The value of Tax' +OutboundList.Value_of_Sales_Tax__c);
     AcctSeed__Journal_Entry_Line__c updateJELine = new AcctSeed__Journal_Entry_Line__c();
     
     
     list <AcctSeed__Journal_Entry_Line__c> newtaxvalue =[select  id, AcctSeed__Debit__c from AcctSeed__Journal_Entry_Line__c  where Outbound_Inventory_Movement__c = :OutboundList.id  and AcctSeed__Debit__c != null limit  1 ];
    
    
    updateJELine  =newtaxvalue.get(0);
    
    updateJELine .AcctSeed__Debit__c = OutboundList.Value_of_Sales_Tax__c;
    
    update updateJELine ;
    }
    
    if( Trigger.oldmap.get(OutboundList.id).Value_of_Sales_Tax__c != OutboundList.Value_of_Sales_Tax__c) {
    
    system.debug('The value of Tax' +OutboundList.Value_of_Sales_Tax__c);
    AcctSeed__Journal_Entry_Line__c updateJELine1 = new AcctSeed__Journal_Entry_Line__c();
    
    list <AcctSeed__Journal_Entry_Line__c> newtaxvalue1 =[select  id,AcctSeed__Credit__c from AcctSeed__Journal_Entry_Line__c  where Outbound_Inventory_Movement__c = :OutboundList.id  and AcctSeed__credit__c != null limit 1 ];
   
    updateJELine1  =newtaxvalue1.get(0);
  
    updateJELine1 .AcctSeed__Credit__c = OutboundList.Value_of_Sales_Tax__c;
    
    update updateJELine1 ;
    
    }
   
   }
    
 } 
 
  if (trigger.isAfter)
    {
     if ( OutboundList.AcctSeedERP__Type__c !='Inventory Transfer'  &&  OutboundList.AcctSeedERP__Type__c != 'Non-Accounting') {
   system.debug('this is AFTER trigger');
   AcctSeedERP__Outbound_Inventory_Movement__c  Outboundname = [select Name from AcctSeedERP__Outbound_Inventory_Movement__c where id = :OutboundList.id] ;
   AcctSeed__Journal_Entry__c JournalEntry = new AcctSeed__Journal_Entry__c();
  
   
   
   JournalEntry.Name =  Outboundname.name;
   JournalEntry.Outbound_Inventory_Movement__c = Outboundname.id;
   JournalEntry.AcctSeed__Journal_Date__c = system.today();
   JournalEntry.AcctSeed__Status__c = 'Approved';
   
   NewJE.add(JournalEntry);
   insert NewJE;
   
  // list <AcctSeed__Transaction__c> TransLine = new list<AcctSeed__Transaction__c >();
  // TransLine = [select AcctSeedERP__Outbound_Inventory_Movement__c,AcctSeed__Amount__c,AcctSeed__Account__c,AcctSeed__GL_Account__c,AcctSeed__Project__c,AcctSeed__Project_Task__c,AcctSeed__GL_Account_Variable_1__c,AcctSeed__GL_Account_Variable_2__c,AcctSeed__GL_Account_Variable_3__c from AcctSeed__Transaction__c where AcctSeedERP__Outbound_Inventory_Movement__c  = :OutboundList.id];
  
 /* 
  for(AcctSeed__Transaction__c tl:TransLine )
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
    system.debug('account'  + tl.AcctSeed__GL_Account__c);
    JELine.AcctSeed__GL_Account__c = tl.AcctSeed__GL_Account__c;
    JELine.Outbound_Inventory_Movement__c = tl.AcctSeedERP__Outbound_Inventory_Movement__c;
    JELine.AcctSeed__Project__c = tl.AcctSeed__Project__c;
    JELine.AcctSeed__Project_Task__c = tl.AcctSeed__Project_Task__c;
    JELine.AcctSeed__GL_Account_Variable_1__c = tl.AcctSeed__GL_Account_Variable_1__c;
    JELine.AcctSeed__GL_Account_Variable_2__c = tl.AcctSeed__GL_Account_Variable_2__c;
    JELine.AcctSeed__GL_Account_Variable_3__c = tl.AcctSeed__GL_Account_Variable_3__c;
    
    NewJEL.add(JELine);
   }
    insert NewJEL; 
    */
    
    
    
   AcctSeedERP__Outbound_Inventory_Movement__c outboundvalues=new AcctSeedERP__Outbound_Inventory_Movement__c();
   list <AcctSeedERP__Outbound_Inventory_Movement__c> lstoutbound  = [select id,Name,branch__c,Value_of_Sales_Tax__c,AcctSeedERP__Credit_GL_Account__c,AcctSeedERP__Debit_GL_Account__c,AcctSeedERP__Project__c,AcctSeedERP__Project_Task__c,AcctSeedERP__GL_Account_Variable_1__c,AcctSeedERP__GL_Account_Variable_2__c,AcctSeedERP__GL_Account_Variable_3__c  from AcctSeedERP__Outbound_Inventory_Movement__c where id = :OutboundList.id];
  
  
  outboundvalues=lstoutbound.get(0);
  
  AcctSeed__Journal_Entry_Line__c JELine = new AcctSeed__Journal_Entry_Line__c();
  
  JELine.AcctSeed__Journal_Entry__c = JournalEntry.id;
  JELine.AcctSeed__Credit__c = outboundvalues.Value_of_Sales_Tax__c;
  JELine.AcctSeed__GL_Account__c = outboundvalues.AcctSeedERP__Credit_GL_Account__c;
  JELine.Outbound_Inventory_Movement__c = outboundvalues.id;
  JELine.AcctSeed__Project__c = outboundvalues.AcctSeedERP__Project__c;
  JELine.AcctSeed__Project_Task__c = outboundvalues.AcctSeedERP__Project_Task__c;
  JELine.AcctSeed__GL_Account_Variable_1__c = outboundvalues.branch__c;//outboundvalues.AcctSeedERP__GL_Account_Variable_1__c;
  JELine.AcctSeed__GL_Account_Variable_2__c = outboundvalues.AcctSeedERP__GL_Account_Variable_2__c;
  JELine.AcctSeed__GL_Account_Variable_3__c = outboundvalues.AcctSeedERP__GL_Account_Variable_3__c;
  JELine.Description__c ='Outbound Tax adjustment';
  
   NewJEL.add(JELine);
   insert NewJEL; 
   
  AcctSeed__Journal_Entry_Line__c JELine1 = new AcctSeed__Journal_Entry_Line__c();
  JELine1.AcctSeed__Journal_Entry__c = JournalEntry.id;
  JELine1.AcctSeed__Debit__c=outboundvalues.Value_of_Sales_Tax__c;
  JELine1.AcctSeed__GL_Account__c = outboundvalues.AcctSeedERP__Debit_GL_Account__c;
  JELine1.Outbound_Inventory_Movement__c = outboundvalues.id;
  JELine1.AcctSeed__Project__c = outboundvalues.AcctSeedERP__Project__c;
  JELine1.AcctSeed__Project_Task__c = outboundvalues.AcctSeedERP__Project_Task__c;
  JELine1.AcctSeed__GL_Account_Variable_1__c = outboundvalues.branch__c;//outboundvalues.AcctSeedERP__GL_Account_Variable_1__c;
  JELine1.AcctSeed__GL_Account_Variable_2__c = outboundvalues.AcctSeedERP__GL_Account_Variable_2__c;
  JELine1.AcctSeed__GL_Account_Variable_3__c = outboundvalues.AcctSeedERP__GL_Account_Variable_3__c;
  JELine1.Description__c ='Outbound Tax adjustment';
  
  NewJEL1.add(JELine1);     
  insert NewJEL1; 
    
    }
 
 }   

}