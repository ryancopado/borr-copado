trigger UpdateSalesorderNumber on AcctSeedERP__Sales_Order__c (after insert) {
    
    AcctSeedERP__Sales_Order__c  so = Trigger.new[0];
    
      list<AcctSeedERP__Sales_Order__c> listsovalue = new list<AcctSeedERP__Sales_Order__c>();
    
      listsovalue =[SELECT Id,Project__c FROM AcctSeedERP__Sales_Order__c where Project__c =:so.Project__c];
    AcctSeed__Project__c proj=new AcctSeed__Project__c();
    AcctSeedERP__Sales_Order__c salesorder=new AcctSeedERP__Sales_Order__c();
    salesorder=listsovalue.get(0);
    proj.Sales_order_Id__c=salesorder.id;
    proj.id=salesorder.Project__c;
    update proj;

    
    

}