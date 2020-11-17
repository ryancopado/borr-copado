public with sharing class createPBEntry {
    public static void addEntry(Product2[] prod) {
        Pricebook2 pb = [select Id from Pricebook2 where IsStandard = true];
        Map<Id, PricebookEntry> pbEntry = new Map<Id, PricebookEntry>();    
        for(Product2 p:prod){
            Double cost = 0;
            if(p.Cost__c != null){
                cost = p.Cost__c;
            }
            PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pb.Id,
                                                    Product2Id = p.Id,
                                                    UnitPrice = cost,
                                                    IsActive = p.IsActive);
            pbEntry.put(p.Id, pbe);                                         
        }
        if(pbEntry.size() > 0){
            insert pbEntry.values();
        }       
    }
    public static void upEntry(Product2[] prod) {
        List<Id> prodID = new List<Id>();
        for(Product2 p:prod){
            prodID.add(p.Id);
        }
        Map<Id, PricebookEntry> pbEntry = new Map<Id, PricebookEntry>();
        PricebookEntry[] pbe = [select Id, UnitPrice, isActive, Product2Id from PricebookEntry where Product2Id in :prodID];
        for(Integer i = 0; i<pbe.size(); i++){
            pbEntry.put(pbe[i].Product2Id, pbe[i]);
        }
        if(pbEntry.size() > 0){
            for(Product2 p:prod){
                if(p.Cost__c != null){
                    pbEntry.get(p.Id).UnitPrice = p.Cost__c;
                } else {
                    pbEntry.get(p.Id).UnitPrice = 0;
                }                           
            }
            update pbEntry.values();
        } else {
            addEntry(prod);
        }       
    }
    public static testmethod void testProd(){
        Product2 pr0 = new Product2(Name = 'Test test', Cost__c = 12.00, Status__c = 'Standard'); insert pr0;
        Product2 pr1 = new Product2(Name = 'Test test', Cost__c = null, Status__c = 'Standard'); insert pr1;
        //PricebookEntry pbe = [select Id from PricebookEntry where Product2Id = :pr1.Id];
        //delete pbe;
        
        Pricebook2 StdPB = [select Id from Pricebook2 where IsStandard = true];
        PricebookEntry EntryMake = new PricebookEntry(
        	Product2Id = pr0.Id,
        	Pricebook2Id = StdPB.Id,
        	UnitPrice = pr0.Cost__c,
        	IsActive = true
        );
        insert EntryMake;
        
        User bh = [select Id from User where Name = 'Bradley Hibberd'];
        System.runAs(bh){
            pr1.Cost__c = 15.00; pr1.Reason_for_modification__c = 'test 1'; update pr1;
            Product2 pr2 = pr0.clone();
            pr0.Cost__c = 15.00; pr0.Reason_for_modification__c = 'test 2'; update pr0;
            pr0.Cost__c = null; pr0.Reason_for_modification__c = 'test 3'; update pr0;
        }
    }
}