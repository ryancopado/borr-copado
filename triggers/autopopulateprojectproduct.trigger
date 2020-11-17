trigger autopopulateprojectproduct on AcctSeedERP__Sales_Order_Line__c (before insert) {
    AcctSeedERP__Sales_Order_Line__c salesorderline= Trigger.new[0];
    //AcctSeed__Project__c projects=new AcctSeed__Project__c();
    //List<AcctSeed__Project__c> projectid =new List<AcctSeed__Project__c>();
    //projectid=[select id from AcctSeed__Project__c where id]
    //List<Project_Products__c > projectproductList=new List<Project_Products__c >();
    
    List<Project_Products__c >projectproductList=[select Id, name,Quantity__c FROM Project_Products__c where Product__c =:salesorderline.AcctSeedERP__Product__c and Project__c=:salesorderline.AcctSeedERP__Project__c];
    if(projectproductList.size()>0)
    {
        salesorderline.Project_Product__c=projectproductList.get(0).id;
        }

}