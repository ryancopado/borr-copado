trigger timeEntry on Time_Entry__c (before insert, after insert, after update, before update, before delete) {
    if(Trigger.isInsert) {
        List<Time_Entry__c> newTE = new List<Time_Entry__c>();
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            if (Trigger.new[i].Team_Member__c != null) {
            	newTE.add(Trigger.new[i]);
            }
        }
        if(newTE.size() > 0) {
        	if (Trigger.isBefore) {
        		pvTotals.setRatesTE(newTE);
        	}
            if (Trigger.isAfter) {
            	pvTotals.toInvoiceTE(newTE, 0);
            }
        }
    }
    if(Trigger.isUpdate) {
        List<Time_Entry__c> newTE = new List<Time_Entry__c>();
        
        if (Trigger.isBefore) {
        	for (Integer i=0; i<Trigger.new.size(); i++) {
        		if ((Trigger.new[i].Team_Member__c != null) && 
        		    (Trigger.new[i].Force_Recalc__c == true || Trigger.new[i].Start_Date__c != Trigger.old[i].Start_Date__c || Trigger.new[i].Hours__c != Trigger.old[i].Hours__c)) {
        			newTE.add(Trigger.new[i]);
        		}
        	}
        	if (newTE.size() > 0) {
        		pvTotals.setRatesTE(newTE);
        	}
        	for (Integer i=0; i<Trigger.new.size(); i++) {
        		
        		if (Trigger.old[i].Total_Cost_Project_Calc__c == null) {
        			Trigger.new[i].Cost_Change_Project__c = 0;
        		} else {
        			Trigger.new[i].Cost_Change_Project__c = Trigger.new[i].Total_Cost_Project_Calc__c - Trigger.old[i].Total_Cost_Project_Calc__c;
        		}
        		if (Trigger.old[i].Total_Cost_Internal_Calc__c == null) {
        			Trigger.new[i].Cost_Change_Internal__c = 0;
        		} else {
                	Trigger.new[i].Cost_Change_Internal__c = Trigger.new[i].Total_Cost_Internal_Calc__c - Trigger.old[i].Total_Cost_Internal_Calc__c;
        		}
        	}
        }
        
        If (Trigger.isAfter) {
        	for (Integer i=0; i<Trigger.new.size(); i++) {
        		if ((Trigger.new[i].Team_Member__c != null) &&
        		    (Trigger.new[i].Cost_Change_Project__c != 0 || Trigger.new[i].Cost_Change_Internal__c != 0)) {
        			newTE.add(Trigger.new[i]);
        		}
        	}
        	if(newTE.size() > 0){
            	pvTotals.toInvoiceTE(newTE, 1);
        	}
        }
    }
        
/*        
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            
            if(Trigger.isBefore){
                Trigger.new[i].Cost_Change_Project__c = Trigger.new[i].Total_Cost_Project__c - Trigger.old[i].Total_Cost_Project__c;
                Trigger.new[i].Cost_Change_Internal__c = Trigger.new[i].Total_Cost_Internal__c - Trigger.old[i].Total_Cost_Internal__c;
            }
            if(Trigger.isAfter && (Trigger.new[i].Total_Cost_Project__c != Trigger.old[i].Total_Cost_Project__c || Trigger.new[i].Total_Cost_Internal__c != Trigger.old[i].Total_Cost_Internal__c)){
                newTE.add(Trigger.new[i]);
            }
*/        
/*        
            if(Trigger.new[i].Total_Cost_Project__c != Trigger.old[i].Total_Cost_Project__c){
                if(Trigger.isBefore){
                    Trigger.new[i].Cost_Change_Project__c = Trigger.new[i].Total_Cost_Project__c - Trigger.old[i].Total_Cost_Project__c;
                    Trigger.new[i].Cost_Change_Internal__c = Trigger.new[i].Total_Cost_Internal__c - Trigger.old[i].Total_Cost_Internal__c;
                }
                if(Trigger.isAfter){
                    newTE.add(Trigger.new[i]);
                }
            }
*/
/*            
        }
        if(newTE.size() > 0){
            pvTotals.toInvoiceTE(newTE, 1);
        }
    }
*/    
    if(Trigger.isDelete) {
        List<Time_Entry__c> newTE = new List<Time_Entry__c>();
        for (Integer i = 0; i <Trigger.old.size(); i++) {
        	if (Trigger.old[i].Team_Member__c != null) {
        		newTE.add(Trigger.old[i]);
        	} 
        }
        if(newTE.size() > 0){
            pvTotals.toInvoiceTE(newTE, 2);
        }
    }
}