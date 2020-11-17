@isTest(SeeAllData = true)
private class testASconPOatt {
    
    static testMethod void poTest() {
        
        AcctSeedERP__Sales_Order_Line__c[] sol = [select Id, AcctSeedERP__Purchase_Order_Line__c from AcctSeedERP__Sales_Order_Line__c where AcctSeedERP__Purchase_Order_Line__c != null];
        List<AcctSeedERP__Purchase_Order_Line__c> purchaseOrderLines = new List<AcctSeedERP__Purchase_Order_Line__c>();
        purchaseOrderLines = [select Id from AcctSeedERP__Purchase_Order_Line__c where Id = :sol[0].AcctSeedERP__Purchase_Order_Line__c];
        
        //Set Page Parameters
        ApexPages.StandardController con = new ApexPages.StandardController(purchaseOrderLines[0]);
        ASconPOatt ext = new ASconPOatt(con);
        
        //Call all methods on New page 
        ext.getAtts(); 
        ext.getFiles();
     }    
}