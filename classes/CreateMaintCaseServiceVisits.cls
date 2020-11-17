public class CreateMaintCaseServiceVisits implements Queueable {
    
    private Id caseId;
    private Id contractId;
    
    public CreateMaintCaseServiceVisits(Id csId, Id cnId) {
        this.caseId = csId;
        this.contractId = cnId;
    }
    
    public void execute(QueueableContext context) {
        
        // Determine how many Service Visits need to be created
        Map<String, MaintenanceCaseServiceVisits__c> maintCaseSVs = MaintenanceCaseServiceVisits__c.getAll();
        Map<String, Schema.RecordTypeInfo> rtAssetMap = Schema.SObjectType.Asset.getRecordTypeInfosByName();
        Map<Id, Asset> assetMap = new Map<Id, Asset>([select Id, Name, Component_Type__c, Contract__c from Asset where Contract__c = :contractId and RecordTypeId = :rtAssetMap.get('Operations Asset').getRecordTypeId() and Component_Type__c in :maintCaseSVs.keySet()]);
        Contract svContract = [select Id, Type__c, PM_Notes__c from Contract where Id = :contractId];
        List<SV__c> svList = new List<SV__c>();
        svList = [select Id, Name, Asset__c, Case__c, Contract__c from SV__c where Case__c = :caseId and Contract__c = :contractId and Asset__c in :assetMap.keySet()];
        Map<Id, SV__c> assetSVMap = new Map<Id, SV__c>();
        for (SV__c sv :svList) {
            assetSVMap.put(sv.Asset__c, sv);
        }
        
        system.debug('***** CreateMaintCaseServiceVisits assetSVMap.size = ' + assetSVMap.size() + ' assetMap.size = ' + assetMap.size());
        
        // Create a set of Service Visit records - the number in each set is small to avoid system limits
        if (assetSVMap.size() < assetMap.size()) {
            Map<String, Schema.RecordTypeInfo> rtSVMap = Schema.SObjectType.SV__c.getRecordTypeInfosByName();
            List<SV__c> svNewList = new List<SV__c>();
            Case svCase = [select Id, AccountId, Project__c, Service_Date__c from Case where Id = :caseId];
            String Notes;
            Integer numSV = 0;
            for (Asset a :assetMap.values()) {
                if (!assetSVMap.containsKey(a.Id)) {
                    Notes = (maintCaseSVs.get(a.Component_Type__c).Service_Visit_Record_Type__c == 'PM-Site Grounds') ? Notes = svContract.PM_Notes__c : '';
                    
                    svNewList.add(new SV__c(
                        Account__c = svCase.AccountId,
                        Asset__c = a.Id,
                        Case__c = svCase.Id,
                        Contract__c = svContract.Id,
                        Notes__c = Notes,
                        Contract_Type__c = svContract.Type__c,
                        Project__c = svCase.Project__c,
                        RecordTypeId = rtSVMap.get(maintCaseSVs.get(a.Component_Type__c).Service_Visit_Record_Type__c).getRecordTypeId(),
                        Technician__c = maintCaseSVs.get(a.Component_Type__c).Default_Technician_Id__c,
                        Visit_Date__c = svCase.Service_Date__c)
                    );
                    
                    numSV++;
                    if (numSV >= 50) {
                        break;
                    }
                }
            }
            
            // Write out the new Service Visit records and queue the job to create the next set of Service Visit records
            Id jobId = null;
            if (!svNewList.isEmpty()) {
                insert svNewList;
                if (!Test.isRunningTest()) {
                    CreateMaintCaseServiceVisits createSVJob = new CreateMaintCaseServiceVisits(caseId, contractId);
                    jobId = System.enqueueJob(createSVJob);
                }
            }
            
            system.debug('***** CreateMaintCaseServiceVisits svNewList.size = ' + svNewList.size() + ' next jobId = ' + jobId);
        }
    }
}