public class VendorPOwPOLNotification {
    
    public Id poId {get; set;}
    
    private AcctSeedERP__Purchase_Order__c poRecord;
    private List<AcctSeedERP__Purchase_Order_Line__c> poLines;
    
    public VendorPOwPOLNotification() {
        
        // The poId comes to the page via the visualforce email template (Vendor_PO_w_POL_Notification)
        poRecord = null;
        poLines = null;
    }
    
    public AcctSeedERP__Purchase_Order__c getPurchaseOrder() {
        if (poRecord == null) {
            poRecord = new AcctSeedERP__Purchase_Order__c();
            poRecord = [select Id, Name, PO_Total__c, AcctSeedERP__Shipping_Company__c, AcctSeedERP__Shipping_Street__c, AcctSeedERP__Shipping_City__c, AcctSeedERP__Shipping_State__c,AcctSeedERP__Shipping_Postal_Code__c   from AcctSeedERP__Purchase_Order__c  where Id = :poId ];
            }
          return poRecord;
    }
    
    public List<AcctSeedERP__Purchase_Order_Line__c> getPOLines() {
        if (poLines == null) {
            poLines = new List<AcctSeedERP__Purchase_Order_Line__c>();
            poLines = [select Id, Name, AcctSeedERP__Project__r.Name, POLine_Total__c, AcctSeedERP__Project_Task__r.Name 
                    from AcctSeedERP__Purchase_Order_Line__c where AcctSeedERP__Purchase_Order__c = :poId ];
        }
        return poLines;
    }
}