global class POButton {
    Webservice static String createPO(Id[] reqIds) {

        SFDC_Purchase_Order__c pOrder = new SFDC_Purchase_Order__c();
        insert pOrder;
        
        SFDC_Purchase_Requisition__c[] req = ([select Id, Purchase_Order__c from SFDC_Purchase_Requisition__c where Id in :reqIds]);
        for (Integer i = 0; i <req.size(); i++) {
            req[i].Purchase_Order__c = pOrder.Id;
        }
        update req;
        return pOrder.Id;
    }
}