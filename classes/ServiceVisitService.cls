public class ServiceVisitService {
    
    /*
     *  Service methods for ServiceVisitTrigger.trigger
     *
     */
    
    /*
    // Populate various Service Visit fields
    // - before insert, before update
    public static void populateFields(List<SV__c> newList, Map<Id, SV__c> oldMap, Boolean isInsert) {
        Set<Id> caseIds = new Set<Id>();
        Map<String, Schema.RecordTypeInfo> rtNameMap = Schema.SObjectType.SV__c.getRecordTypeInfosByName();
        
        for (SV__c sv :newList) {
            
            if (sv.RecordTypeId == rtNameMap.get('Admin Service Visit').getRecordTypeId()) {
                if (isInsert) {
                    sv.Billing_Field__c = 'Not Billable';
                }
                if (sv.SiteArrivalTime__c != null) {
                    sv.Visit_Date__c = Date.valueOf(sv.SiteArrivalTime__c);
                    sv.WorkStarted__c = sv.SiteArrivalTime__c;
                }
            }
            
            if (isInsert) {
                
                if (sv.Case__c != null && sv.Project__c == null) {
                    caseIds.add(sv.Case__c);
                }
            }
        }
        
        if (!caseIds.isEmpty()) {
            Map<Id, Case> caseMap = new Map<Id, Case>([select Id, Project__c from Case where Id in :caseIds]);
            for (SV__c sv :newList) {
                if (caseMap.containsKey(sv.Case__c)) {
                    sv.Project__c = caseMap.get(sv.Case__c).Project__c;
                }
            }
        }
    }
    
    // Set field Billing_Status__c on related cases that are closed
    // - after delete, after insert, after undelete
    public static void caseBillingStatus(List<SV__c> newList, Map<Id, SV__c> oldMap, Boolean isDelete, Boolean isInsert, Boolean isUndelete) {
        Set<Id> cIds = new Set<Id>();
        
        if (isDelete) {
            for (SV__c sv :oldMap.values()) {
                if (sv.Case__c != null) {
                    cIds.add(sv.Case__c);
                }
            }
        }
        
        if (isInsert || isUndelete) {
            for (SV__c sv :newList) {
                if (sv.Case__c != null) {
                    cIds.add(sv.Case__c);
                }
            }
        }
        
        if (!cIds.isEmpty()) {
            CaseService.billingStatus(cIds);
        }
    }
    
    // All after update processing performed by trigger ServiceVisitTrigger.trigger
    // - after update
    public static void svAfterUpdate(List<SV__c> newList, Map<Id, SV__c> oldMap) {
        Set<Id> cIds = new Set<Id>();
        Set<Id> svIds = new Set<Id>();
        
        for (SV__c sv :newList) {
            
            // Collect all of the related case Ids that need to have field Billing_Status__c set
            if (sv.Billing_Field__c != oldMap.get(sv.Id).Billing_Field__c) {
                if (sv.Case__c != null) {
                    cIds.add(sv.Case__c);
                }
            }
            if (sv.Case__c != oldMap.get(sv.Id).Case__c) {
                if (sv.Case__c != null) {
                    cIds.add(sv.Case__c);
                }
                if (oldMap.get(sv.Id).Case__c != null) {
                    cIds.add(oldMap.get(sv.Id).Case__c);
                }
            }
            
            // Collect all the service visit Ids where related pending work records need to be updated
            if (sv.Completed__c && oldmap.get(sv.Id).Completed__c != sv.Completed__c) {
                svIds.add(sv.Id);            
            }
        }
        
        // Update Billing_Status__c field of related case records
        if (!cIds.isEmpty()) {
            CaseService.billingStatus(cIds);
        }
        
        // Update Status__c field of related pending work records
        if (!svIds.isEmpty()) {
            List<Pending_Work__c> pwlist = new List<Pending_Work__c>();
            pwList = [select Id, Status__c from Pending_Work__c where Associated_Service_Visit_to_Close__c in :svIds];
            for (Pending_Work__c pw :pwList) {
                pw.Status__c = 'Closed';
            }
            if (!pwList.isEmpty()) {
                update pwList;
            }
        }
    }
    */
}