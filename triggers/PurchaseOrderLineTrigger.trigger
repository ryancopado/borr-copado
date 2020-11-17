trigger PurchaseOrderLineTrigger on AcctSeedERP__Purchase_Order_Line__c (after insert, after update) {
    if (trigger.IsAfter) {
        //List<AcctSeedERP__Purchase_Order_Line__c> 
        if (trigger.isUpdate) {
            list<Id> SOL = new List<Id>();
            for (AcctSeedERP__Purchase_Order_Line__c poLine : trigger.New) {
                if (Trigger.OldMap.get(poLine.id).PO_Status__c != Trigger.NewMap.get(poLine.id).PO_Status__c && Trigger.NewMap.get(poLine.id).PO_Status__c == 'Closed') {
                    //poLine.Sales_Order_Line__r.Quote_Line_Item___r.PO_Line_Status__c == 'Closed'; 
                    SOL.add(poLine.Construction_Req__c);
                }
            }
            List<AcctSeedERP__Sales_Order_Line__c> listSOL = [SELECT Id, Quote_Line_Item__r.PO_Line_Status__c FROM AcctSeedERP__Sales_Order_Line__c WHERE ID IN :SOL];
            for (AcctSeedERP__Sales_Order_Line__c sol_curr : listSOL) {
                sol_curr.Quote_Line_Item__r.PO_Line_Status__c = 'Closed';
            }
            update listSOL;
        }
    }
}