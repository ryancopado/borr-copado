trigger changeNTE on SFDC_Project__c (before update) {
    
   if(approveELI.IsRecursiveUpdate==null) approveELI.IsRecursiveUpdate=false;
    
    if(approveELI.IsRecursiveUpdate==false){
    
            // Get all the invoice records for the project records with changed NTE
            List<Id> pId = new List<Id>();
            Map<Id, SFDC_Project__c> pNTE = new Map<Id, SFDC_Project__c>();
            for(Integer i = 0; i<Trigger.new.size(); i++) {
                if (Trigger.new[i].Not_To_Exceed_Feas__c != Trigger.old[i].Not_To_Exceed_Feas__c) {
                    pId.add(Trigger.new[i].Id);
                    pNTE.put(Trigger.new[i].Id, Trigger.new[i]);
                }
                
                //While we are at it, check if project is changing from/to Fixed Cost
                if (Trigger.new[i].Fixed_Cost_Feasibility__c != Trigger.old[i].Fixed_Cost_Feasibility__c) {
                    if ( (Trigger.new[i].Total_To_Invoice_Feasibility__c != null && Trigger.new[i].Total_To_Invoice_Feasibility__c != 0) ||
                         (Trigger.new[i].Cost_To_Borrego_Feasibility__c != null && Trigger.new[i].Cost_To_Borrego_Feasibility__c != 0) ||
                         (Trigger.new[i].Total_Retainer_Feasibility__c != 0) ||
                         (Trigger.new[i].Total_Fixed_Cost_Feasibility__c != 0) ) {
                        Trigger.new[i].addError(' You cannot change Fixed Cost once a project is underway.');
                    }
                }
            }
            
            if (pId.size() > 0) {
                Invoices__c[] inv = [select Id, Project__c, Status__c from Invoices__c where Project__c in :pId];
            
                // Only allow NTE to change if no invoice is in process
                for (Integer m=0; m<inv.size(); m++) {
                    if (inv[m].Status__c == 'New' || inv[m].Status__c == 'Submitted') {
                        pNTE.get(inv[m].Project__c).addError(' You cannot change Not To Exceed when there are unapproved invoices.');
                    }
                }
            }
    
    }
}