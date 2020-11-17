trigger projCost on PCost__c (after insert, before update, after update, before delete) {
    if(Trigger.isInsert){
        List<PCost__c> newPC = new List<PCost__c>();
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            newPC.add(Trigger.new[i]); 
        }
        if(newPC.size() > 0){
            pvTotals.toInvoicePC(newPC, 0);
        }
    }
    if(Trigger.isUpdate){
        List<PCost__c> newPC = new List<PCost__c>();
        for (Integer i = 0; i <Trigger.new.size(); i++) {
        	
            if(Trigger.isBefore){
                Trigger.new[i].Cost_Change__c = Trigger.new[i].Amount__c - Trigger.old[i].Amount__c;
                if (Trigger.new[i].Cost_to_Borrego__c == null && Trigger.old[i].Cost_to_Borrego__c == null) {
                	Trigger.new[i].Cost_to_Borrego_Change__c = 0;
                }
                if (Trigger.new[i].Cost_to_Borrego__c == null && Trigger.old[i].Cost_to_Borrego__c != null) {
                	Trigger.new[i].Cost_to_Borrego_Change__c = 0 - Trigger.old[i].Cost_to_Borrego__c;
                }
                if (Trigger.new[i].Cost_to_Borrego__c != null && Trigger.old[i].Cost_to_Borrego__c == null) {
                	Trigger.new[i].Cost_to_Borrego_Change__c = Trigger.new[i].Cost_to_Borrego__c;
                }
                if (Trigger.new[i].Cost_to_Borrego__c != null && Trigger.old[i].Cost_to_Borrego__c != null) {
                	Trigger.new[i].Cost_to_Borrego_Change__c = Trigger.new[i].Cost_to_Borrego__c - Trigger.old[i].Cost_to_Borrego__c;
                }
            }
            if(Trigger.isAfter && (Trigger.new[i].Amount__c != Trigger.old[i].Amount__c || Trigger.new[i].Cost_to_Borrego__c != Trigger.old[i].Cost_to_Borrego__c)){
                newPC.add(Trigger.new[i]);
            }
           
/*
            if(Trigger.new[i].Amount__c != Trigger.old[i].Amount__c){
                if(Trigger.isBefore){
                    Trigger.new[i].Cost_Change__c = Trigger.new[i].Amount__c - Trigger.old[i].Amount__c;
                }
                if(Trigger.isAfter){
                    newPC.add(Trigger.new[i]);
                }
            }
*/          
        }
        if(newPC.size() > 0){
            pvTotals.toInvoicePC(newPC, 1);
        }
    }
    if(Trigger.isDelete){
        List<PCost__c> newPC = new List<PCost__c>();
        for (Integer i = 0; i <Trigger.old.size(); i++) {
            newPC.add(Trigger.old[i]); 
        }
        if(newPC.size() > 0){
            pvTotals.toInvoicePC(newPC, 2);
        }
    }
}