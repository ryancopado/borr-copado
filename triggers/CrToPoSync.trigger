trigger CrToPoSync on AcctSeedERP__Sales_Order_Line__c (after update) {

    List<String> polIds = new List<String>();
    List<String> poIds = new List<String>();
    
    
    Map<String,AcctSeedERP__Sales_Order_Line__c> soPoMap = new Map<String,AcctSeedERP__Sales_Order_Line__c>();
    Map<String,AcctSeedERP__Sales_Order_Line__c> soPolMap = new Map<String,AcctSeedERP__Sales_Order_Line__c>();
    
    List<AcctSeedERP__Sales_Order_Line__c> asSol = [select Ship_to_Account__c,Ship_to_Account__r.Phone, Ship_to_Account__r.ShippingStreet, Ship_to_Account__r.ShippingState, Ship_to_Account__r.ShippingPostalCode, Ship_to_Account__r.ShippingCountry, Ship_to_Account__r.ShippingCity, Vendor_Contact__c,Ship_to_Account__r.Name,AcctSeedERP__Purchase_Order_Line__c,AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Purchase_Order__c from  AcctSeedERP__Sales_Order_Line__c where id in:trigger.newMap.keySet()];
    
    
    
    
    
    for(integer i=0;i<asSol.size();i++){
        if(asSol[i].AcctSeedERP__Purchase_Order_Line__c != null && trigger.old[i].AcctSeedERP__Purchase_Order_Line__c == null){
            poIds.add(asSol[i].AcctSeedERP__Purchase_Order_Line__c);
            polIds.add(asSol[i].AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Purchase_Order__c);
            
            soPolMap.put(asSol[i].AcctSeedERP__Purchase_Order_Line__c,asSol[i]);
            soPoMap.put(asSol[i].AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Purchase_Order__c,asSol[i]);
            
        }
    }


    List<AcctSeedERP__Purchase_Order_Line__c> POLines = [select Ship_to_Account__c from AcctSeedERP__Purchase_Order_Line__c where id in:poIds];
    
    List<AcctSeedERP__Purchase_Order__c> POs = [select AcctSeedERP__Vendor_Contact__c, AcctSeedERP__Shipping_Company__c from AcctSeedERP__Purchase_Order__c where id in:polIds];



    for(AcctSeedERP__Purchase_Order_Line__c POLine:POLines){
        POLine.Ship_to_Account__c = soPolMap.get(POLine.Id).Ship_to_Account__c;
    }


    for(AcctSeedERP__Purchase_Order__c PO:POs){
        PO.AcctSeedERP__Vendor_Contact__c = soPoMap.get(PO.Id).Vendor_Contact__c;
        if(soPoMap.get(PO.Id).Ship_to_Account__c != null){
           // PO.AcctSeedERP__Shipping_Company__c = soPoMap.get(PO.Id).Ship_to_Account__r.Id;
            
            PO.Ship_To_Telephone__c  = soPoMap.get(PO.Id).Ship_to_Account__r.Phone;
            
            //commented the below fields on 3/3/2020 since the shipping address we are currently using from Quote by DK .
            
            
            //PO.AcctSeedERP__Shipping_Country__c = soPoMap.get(PO.Id).Ship_to_Account__r.ShippingCountry;
            //PO.AcctSeedERP__Shipping_Postal_Code__c= soPoMap.get(PO.Id).Ship_to_Account__r.ShippingPostalCode;
            //PO.AcctSeedERP__Shipping_State__c= soPoMap.get(PO.Id).Ship_to_Account__r.ShippingState;
            //PO.AcctSeedERP__Shipping_Street__c= soPoMap.get(PO.Id).Ship_to_Account__r.ShippingStreet;
           // PO.AcctSeedERP__Shipping_City__c= soPoMap.get(PO.Id).Ship_to_Account__r.ShippingCity;
            
        }
    }
    
    update POLines;
    update POs;
    
    
    
    List<String> accountIds = new  List<String>();
    for(AcctSeedERP__Sales_Order_Line__c so : Trigger.new) {
        if(so.Vendor__c != null) {
            accountIds.add(so.Vendor__c);
        }
        
    }
    
    // Create a map of existing Project Partner records so that we don't create duplicate records
    List<Id> pIds = new List<Id>();
    for (AcctSeedERP__Sales_Order_Line__c sol :trigger.new) {
        if (sol.AcctSeedERP__Project__c != null) {
            pIds.add(sol.AcctSeedERP__Project__c);
        }
    }
    
    /*
    List<ProjectPartner__c> ppList = new List<ProjectPartner__c>();
    ppList = [select Id, AccountId__c, ASProject__c from ProjectPartner__c where ASProject__c in :pIds];
    Map<Id, Set<Id>> pToPpMap = new Map<Id, Set<Id>>();
    for (Id pId :pIds) {
        for (ProjectPartner__c pp :ppList) {
            if (pId == pp.ASProject__c) {
                if (!pToPpMap.containsKey(pId)) {
                    pToPpMap.put(pId, new Set<Id>());
                }
                pToPpMap.get(pId).add(pp.AccountId__c);
            }
        }
    }
    
    Map<Id,Schema.RecordTypeInfo> rtMap = Schema.SObjectType.AcctSeedERP__Sales_Order_Line__c.getRecordTypeInfosById();
    
    Map<Id,Account> Accounts  =new Map<Id,Account> ([select id,type from Account where id in:accountIds and type != null and recordType.Name like '%Vendor%'] );
    
    List<ProjectPartner__c> newPP = new List<ProjectPartner__c>();
    
    for(integer i=0;i<trigger.new.size();i++){
        
        String newStatus = Trigger.new[i].Status__c;

        String oldStatus = '';
    
        if(trigger.isUpdate){
            oldStatus = Trigger.old[i].Status__c;
        }
        
        if (justChangedTo ('Approved', newStatus , oldStatus) && Accounts.containsKey(Trigger.new[i].Vendor__c)) {
        
            if (rtMap.get(trigger.new[i].RecordTypeId).getName() == 'Subcontractor') {
                if (!pToPpMap.containsKey(trigger.new[i].AcctSeedERP__Project__c) || !pToPPMap.get(trigger.new[i].AcctSeedERP__Project__c).contains(trigger.new[i].Vendor__c)) {
                    ProjectPartner__c projPar = new ProjectPartner__c(ASProject__c = Trigger.new[i].AcctSeedERP__Project__c,
                                                        AccountId__c = Trigger.new[i].Vendor__c,
                                                        Primary_Contact__c = Trigger.new[i].Vendor_Contact__c,
                                                        Role__c = Accounts.get(Trigger.new[i].Vendor__c).Type);
                    newPP.add(projPar);  
                }                                               
            }     
        }                                              
    }
    if (!newPP.isEmpty()) {
        insert newPP;
    }
    */
    
    Boolean justChangedTo (String compareValue, String newValue, String oldValue) {
        if (newValue == compareValue && oldValue != compareValue) {
            return true;
        }
        return false;
    }    
}