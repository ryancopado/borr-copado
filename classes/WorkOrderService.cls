public class WorkOrderService {
    
    /*
     *  Service methods for Work Order triggers.
     */
    
    // Determine if a "completed" Work Order is billable or not billable. A "completed" Work Order is:
    //  - Related Work Type record with Name = "Reactive"
    //  - Travel_Start_Time__c and Work_End_Time__c both have a value and "Work_End_Time__c is greater than "Travel_Start_Time__c
    //
    // - before insert, before update
    public static void determineBilling(List<WorkOrder> newList, Map<Id, WorkOrder> oldMap, Boolean isInsert) {
        Map<Id, WorkOrder> woMap = new Map<Id, WorkOrder>();
        Set<Id> cIds = new Set<Id>();
        Set<String> BillingEligibleWorkTypes = new Set<String>{'Reactive'};
        
        for (WorkOrder wo :newList) {
            if (wo.Work_End_Time__c != null) {
                if (wo.Travel_Start_Time__c == null || wo.Travel_Start_Time__c >= wo.Work_End_Time__c) {
                    wo.addError('Work End Time must be greater than Travel Start Time.');
                } else {
                    if (wo.Contract__c != null && BillingEligibleWorkTypes.contains(wo.Work_Type_Name__c)) {
                        if (isInsert || (!isInsert && wo.Work_End_Time__c != oldMap.get(wo.Id).Work_End_Time__c)) {
                            woMap.put(wo.Id, wo);
                            cIds.add(wo.Contract__c);
                        }
                    }
                }
            }
        }
        
        if (!woMap.isEmpty()) {
            
            // We have one or more "completed" Work Order records, determine billability based upon what is allowed in the contract
            // Get the related contract data we need to determine billing status
            Map<Id, Contract> cMap = new Map<Id, Contract>([select Id, Current_Year_Contract_Start__c, Current_Year_Contract_End__c, CY_Completed_Reactive_Visits__c, of_Reactive_Service_Visits_annually__c 
                    from Contract where Id in :cIds]);
            
            // Get the previously completed Work Order records
            Map<Id, WorkOrder> woPreviousMap = new Map<Id, WorkOrder>([select Id, Billable__c, Contract__c, Travel_Start_Time__c, Work_End_Time__c, Work_Type_Name__c 
                    from WorkOrder where 
                    Contract__c in :cIds and Work_Type_Name__c in :BillingEligibleWorkTypes and (not Id in :woMap.keySet()) and 
                    Travel_Start_Time__c != null and Work_End_Time__c != null and Work_End_Time__c > :system.today().addYears(-2)]);
            
            // Count the number of previously completed work order records per contract
            Map<Id, List<WorkOrder>> completedContractWoMap = new Map<Id, List<WorkOrder>>();
            Contract cntrct;
            Date completedDate;
            for (WorkOrder wo :woPreviousMap.values()) {
                cntrct = cMap.get(wo.Contract__c);
                completedDate = wo.Work_End_Time__c.date();
                if (completedDate >= cntrct.Current_Year_Contract_Start__c && completedDate <= cntrct.Current_Year_Contract_End__c) {
                    if (!completedContractWoMap.containsKey(wo.Contract__c)) {
                        completedContractWoMap.put(wo.Contract__c, new List<WorkOrder>());
                    }
                    completedContractWoMap.get(wo.Contract__c).add(wo);
                }
            }
            
            // Set the Billable field for each of the newly completed work orders and record the total number of completed work orders per contract
            Map<Id, Contract> cUpMap = new Map<Id, Contract>();
            for (WorkOrder wo :woMap.values()) {
                cntrct = cMap.get(wo.Contract__c);
                completedDate = wo.Work_End_Time__c.date();
                if (completedDate >= cntrct.Current_Year_Contract_Start__c && completedDate <= cntrct.Current_Year_Contract_End__c) {
                    if (!completedContractWoMap.containsKey(wo.Contract__c)) {
                        completedContractWoMap.put(wo.Contract__c, new List<WorkOrder>());
                    }
                    completedContractWoMap.get(wo.Contract__c).add(wo);
                    cntrct.CY_Completed_Reactive_Visits__c = completedContractWoMap.get(wo.Contract__c).size();
                    cUpMap.put(cntrct.Id, cntrct);
                    wo.Billable__c = (cntrct.CY_Completed_Reactive_Visits__c > cntrct.of_Reactive_Service_Visits_annually__c) ? 'Yes' : 'No';
                }
            }
            
            if (!cUpMap.isEmpty()) {
                update cUpMap.values();
            }
        }
    }
    
    // Set field Billing_Status__c on related cases that are closed
    // - after delete, after insert, after undelete, after update
    public static void caseBillingStatus(List<WorkOrder> newList, Map<Id, WorkOrder> oldMap, Boolean isDelete, Boolean isInsert, Boolean isUndelete, Boolean isUpdate) {
        Set<Id> cIds = new Set<Id>();
        
        if (isDelete) {
            for (WorkOrder wo :oldMap.values()) {
                if (wo.CaseId != null) {
                    cIds.add(wo.CaseId);
                }
            }
        }
        
        if (isInsert || isUndelete) {
            for (WorkOrder wo :newList) {
                if (wo.CaseId != null) {
                    cIds.add(wo.CaseId);
                }
            }
        }
        
        if (isUpdate) {
            for (WorkOrder wo :newList) {
                if (wo.Billable__c != oldMap.get(wo.Id).Billable__c) {
                    if (wo.CaseId != null) {
                        cIds.add(wo.CaseId);
                    }
                }
                if (wo.CaseId != oldMap.get(wo.Id).CaseId) {
                    if (wo.CaseId != null) {
                        cIds.add(wo.CaseId);
                    }
                    if (oldMap.get(wo.Id).CaseId != null) {
                        cIds.add(oldMap.get(wo.Id).CaseId);
                    }
                }
            }
        }
        
        if (!cIds.isEmpty()) {
            CaseService.billingStatus(cIds);
        }
    }
}