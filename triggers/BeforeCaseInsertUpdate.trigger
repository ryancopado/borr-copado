trigger BeforeCaseInsertUpdate on Case (after insert, after update, before insert, before update) {
    
    /*
     *  Before
     *      - Set various fields on the Case from the related Contract record.
     *
     *  Before insert
     *      - Throw error if a user without Role = "O&M Warranty Project Manager" or without having ModifyAllData permission
     *      trys to create a case with record type "Warranty"
     *      - Set field Alert ID
     *      - Set the Site ID field from information in the Description field for PowerTrack and Draker email-to-case
     *      records and match it to a Project.
     *
     *  After insert
     *      - Automatically create Service Visit records if the case just inserted is of record type Maintenance Case.
     *      NOTE: this only executes if there is only one case being created.
     *
     *  After update
     *      - If ServiceContract_Case__c or Service_Visit__c on the Case has changed, update the 
     *      related Service Visit records.
     *      - If the Status field or the ClosedDate field on a Case has changed, update the related Transaction record.
     *      - For closed cases, set field Billing_Status__c based upon the related Billing Line and Service Visit records
     *
     */
    
    Map<Id, Schema.RecordTypeInfo> rtCaseMap = Schema.SObjectType.Case.getRecordTypeInfosById();
    
    if (trigger.isBefore) {
        //Set<Id> pIds = new Set<Id>();
        //Set<Id> cnIds = new Set<Id>();
        Set<String> siteIds = new Set<String>();
        String siteId;
        String dasDeviceId;
        String alertId;
        String alertURL;
        String alsoenergyWebEmail = 'powertrack@alsoenergy.com';
        String drakerenergyWebEmail = 'no-reply@drakerenergy.com';
        //String alsoenergyWebEmail = 'etam@borregosolar.com';      // for testing purposes
        
        String roleName = '';
        Set<Id> madIds = new Set<Id>();
        if (trigger.isInsert) {
            List<UserRole> urList = new List<UserRole>();
            urList = [select Id, Name from UserRole where Id = :UserInfo.getUserRoleId()];
            roleName = (urList.isEmpty()) ? '' : urList[0].Name;
            
            List<PermissionSet> psList = [select Id, Name, (select AssigneeId from Assignments) from PermissionSet where PermissionsModifyAllData = true];
            for (PermissionSet ps :psList) {
                if (ps.Assignments != null) {
                    for (PermissionSetAssignment psa :ps.Assignments) {
                        madIds.add(psa.AssigneeId);
                    }
                }
            }
        }
        
        for (Case c :trigger.new) {
            /*
            if (c.Project__c != null) {
                if (trigger.isInsert) {
                    pIds.add(c.Project__c);
                    c.ServiceContract_Case__c = null;
                }
                if (trigger.isUpdate && (c.ServiceContract_Case__c == null || c.Project__c != trigger.oldMap.get(c.Id).Project__c)) {
                    pIds.add(c.Project__c);
                    c.ServiceContract_Case__c = null;
                }
            }
            
            if (c.ServiceContract_Case__c != null) {
                if (trigger.isInsert || c.ServiceContract_Case__c != trigger.oldMap.get(c.Id).ServiceContract_Case__c) {
                    cnIds.add(c.ServiceContract_Case__c);
                }
            }
            */
            
            // Set fields Alert ID and Site ID
            if (trigger.isInsert) {
                if (c.SuppliedEmail == alsoenergyWebEmail) {
                    
                    if (String.isNotBlank(c.Subject)) {
                        c.Alert_ID__c = c.Subject.substringAfterLast('-');
                    }
                    
                    if (String.isNotBlank(c.Description)) {
                        siteId = c.Description.substringBetween('Site [ ', ' ]');
                        if (String.isNotBlank(siteId) && siteId.length() <= 10) {
                            c.Site_ID__c = siteId;
                            siteIds.add(siteId);
                        }
                        dasDeviceId = c.Description.substringBetween('Hardware [ ', ' ]');
                        if (String.isNotBlank(dasDeviceId) && dasDeviceId.length() <= 255) {
                            c.DASDeviceID__c = dasDeviceId;
                        }
                    }
                }
                
                if (c.SuppliedEmail == drakerenergyWebEmail) {
                    
                    if (String.isNotBlank(c.Description)) {
                        alertURL = c.Description.substringAfter('/alarms/logs/');
                        alertId = '';
                        for (Integer i=0; i<alertURL.length() && alertURL.substring(0, i+1).isNumeric(); i++) {
                            alertId = alertURL.substring(0, i+1);
                        }
                        if (String.isNotBlank(alertId) && alertId.length() <= 200) {
                            c.Alert_ID__c = alertId;
                        }
                        
                        siteId = c.Description.substringBetween('http://solarems.net/projects/','-');
                        if (String.isNotBlank(siteId) && siteId.length() <= 10) {
                            c.Site_ID__c = siteId;
                            siteIds.add(siteId);
                        }
                    }
                }
                
                if (rtCaseMap.containsKey(c.RecordTypeId) && rtCaseMap.get(c.RecordTypeId).getName() == 'Warranty') {
                    if (roleName != 'O&M Warranty Project Manager' && !madIds.contains(UserInfo.getUserId())) {
                        c.addError('Please contact your O&M administrator. Only the Warranty Manager can create this type of case.');
                    }
                }
            }
        }
        
        // Set the Account and Project field based upon the Site ID
        if (!siteIds.isEmpty()) {
            Map<String, AcctSeed__Project__c> pMap = new Map<String, AcctSeed__Project__c>();
            List<AcctSeed__Project__c> pList = new List<AcctSeed__Project__c>();
            pList = [select Id, AcctSeed__Account__c, DAS_Platform_Site_ID__c from AcctSeed__Project__c where DAS_Platform_Site_ID__c in :siteIds];
            if (!pList.isEmpty()) {
                for (AcctSeed__Project__c p :pList) {
                    pMap.put(p.DAS_Platform_Site_ID__c, p);
                }
                for (Case c :trigger.new) {
                    if (pMap.containsKey(c.Site_ID__c) && pMap.get(c.Site_ID__c).AcctSeed__Account__c != null) {
                        c.AccountId = pMap.get(c.Site_ID__c).AcctSeed__Account__c;
                        c.Project__c = pMap.get(c.Site_ID__c).Id;
                    }
                }
            }
        }
        
        /*
        Map<Id, Contract> cnMap = new Map<Id, Contract>();
        if (!pIds.isEmpty()) {
            
            // Get all the contracts associated with the projects that are either Paid or Warranty
            Map<String, Schema.RecordTypeInfo> rtNameMap = Schema.SObjectType.Contract.getRecordTypeInfosByName();
            Map<Id, Schema.RecordTypeInfo> rtIdMap = Schema.SObjectType.Contract.getRecordTypeInfosById();
            List<Contract> contractList = new List<Contract>();
            contractList = [select Id, RecordTypeId, ASProject__c, Branch__c 
                    from Contract where ASProject__c in :pIds and 
                    (RecordTypeId = :rtNameMap.get('Paid').getRecordTypeId() or 
                    RecordTypeId = :rtNameMap.get('Warranty').getRecordTypeId()) order by CreatedDate desc];
            
            // Create a map of one active contract per project - choose the most recent Paid contract, if none
            // exist then choose the most recent Warranty contract
            Map<Id, Contract> pConMap = new Map<Id, Contract>();
            for (Contract cn :contractList) {
                if (pConMap.containsKey(cn.ASProject__c)) {
                    if ( (rtIdMap.get(pConMap.get(cn.ASProject__c).RecordTypeId).getName() != 'Paid') && 
                         (rtIdMap.get(cn.RecordTypeId).getName() == 'Paid') ) {
                        pConMap.put(cn.ASProject__c, cn);
                    }
                } else {
                    pConMap.put(cn.ASProject__c, cn);
                }
            }
            
            // Assign a contract to each case
            for (Case c :trigger.new) {
                if (c.Project__c != null) {
                    if (pConMap.containsKey(c.Project__c)) {
                        c.ServiceContract_Case__c = pConMap.get(c.Project__c).Id;
                        cnMap.put(c.ServiceContract_Case__c, pConMap.get(c.Project__c));
                    }
                }   
            }
        }
        
        // Get the rest of the changed contracts
        List<Contract> cnList = new List<Contract>();
        if (!cnIds.isEmpty()) {
            cnList = [select Id, RecordTypeId, ASProject__c, Branch__c from Contract where Id in :cnIds];
            for (Contract cn :cnList) {
                cnMap.put(cn.Id, cn);
            }
        }
        
        // Set the branch field and/or throw an error on each case that has a Project if there is no contract assigned
        for (Case c :trigger.new) {
            if (c.ServiceContract_Case__c == null) {
                if (c.Project__c != null && trigger.isUpdate) {
                    c.ServiceContract_Case__c.addError('No active Paid or Warranty service contract found. Each case must have a project with at least one active Paid or Warranty service contract.');
                }
            } else {
                if (cnMap.containsKey(c.ServiceContract_Case__c)) {
                    c.Branch__c = cnMap.get(c.ServiceContract_Case__c).Branch__c;
                }
            }
        }
        */
        
        // Set various fields on the Case records from their related Contract records
        CaseService.caseContractFields(trigger.new, trigger.oldMap, trigger.isInsert);
        
        /*
        // Set the Labor Billing field
        if (trigger.isUpdate) {
            CaseService.laborBillingCaseContract(trigger.new, trigger.oldMap);
        }
        */
    }
    
    if (trigger.isAfter) {
        
        if (trigger.isInsert) {
            
            List<Case> maintCases = new List<Case>();
            //Set<Id> cntrctIds = new Set<Id>();
            for (Case c :trigger.new) {
                if (rtCaseMap.containsKey(c.RecordTypeId) && rtCaseMap.get(c.RecordTypeId).getName() == 'Maintenance Case' && c.ServiceContract_Case__c != null) {
                    maintCases.add(c);
                }
                
                /*
                if (rtCaseMap.containsKey(c.RecordTypeId) && rtCaseMap.get(c.RecordTypeId).getName() == 'Maintenance Case') {
                    maintCases.add(c);
                    if (c.ServiceContract_Case__c != null) {
                        cntrctIds.add(c.ServiceContract_Case__c);
                    }
                }
                */
            }
            
            /*
            // Create Service Visit records for the Maintenance Case if there is only one being inserted
            if (maintCases.size() == 1) {
                CreateMaintCaseServiceVisits createSVJob = new CreateMaintCaseServiceVisits(maintCases[0].Id, maintCases[0].ServiceContract_Case__c);
                Id jobId = System.enqueueJob(createSVJob);
                
                system.debug('***** BeforeCaseInsertUpdate create SV jobId = ' + jobId);
            }
            */
            
            /*
            if (!maintCases.isEmpty()) {
                Map<Id, Contract> svContracts = new Map<Id, Contract>();
                List<Asset> assets = new List<Asset>();
                Map<String, Schema.RecordTypeInfo> rtAssetMap = Schema.SObjectType.Asset.getRecordTypeInfosByName();
                if (!cntrctIds.isEmpty()) {
                    svContracts = new Map<Id, Contract>([select Id, Type__c, PM_Notes__c from Contract where Id in :cntrctIds]);
                    assets = [select Id, Name, Component_Type__c, Contract__c from Asset where Contract__c in :cntrctIds and RecordTypeId = :rtAssetMap.get('Operations Asset').getRecordTypeId()];
                }
                
                Map<Id, List<Asset>> cntrctAssets = new Map<Id, List<Asset>>();
                for (Asset a :assets) {
                    if (!cntrctAssets.containsKey(a.Contract__c)) {
                        cntrctAssets.put(a.Contract__c, new List<Asset>());
                    }
                    cntrctAssets.get(a.Contract__c).add(a);
                }
                
                // Create the Service Visit records
                Map<String, MaintenanceCaseServiceVisits__c> maintCaseSVs = MaintenanceCaseServiceVisits__c.getAll();
                Map<String, Schema.RecordTypeInfo> rtSVMap = Schema.SObjectType.SV__c.getRecordTypeInfosByName();
                List<SV__c> serviceVisits = new List<SV__c>();
                String Notes;
                String cType;
                for (Case c :maintCases) {
                    
                    // Create one Service Visit for each Asset related to the Contract
                    if (cntrctAssets.containsKey(c.ServiceContract_Case__c)) {
                        
                        for (Asset a :cntrctAssets.get(c.ServiceContract_Case__c)) {
                            Notes = '';
                            cType = '';
                            if (maintCaseSVs.containsKey(a.Component_Type__c) && rtSVMap.containsKey(maintCaseSVs.get(a.Component_Type__c).Service_Visit_Record_Type__c)) {
                                
                                if (svContracts.containsKey(c.ServiceContract_Case__c)) {
                                    cType = svContracts.get(c.ServiceContract_Case__c).Type__c;
                                    if (maintCaseSVs.get(a.Component_Type__c).Service_Visit_Record_Type__c == 'PM-Site Grounds') {
                                        Notes = svContracts.get(c.ServiceContract_Case__c).PM_Notes__c;
                                    }
                                }
                                
                                serviceVisits.add(new SV__c(
                                    Account__c = c.AccountId,
                                    Asset__c = a.Id,
                                    Case__c = c.Id,
                                    Contract__c = c.ServiceContract_Case__c,
                                    Notes__c = Notes,
                                    Contract_Type__c = cType,
                                    Project__c = c.Project__c,
                                    RecordTypeId = rtSVMap.get(maintCaseSVs.get(a.Component_Type__c).Service_Visit_Record_Type__c).getRecordTypeId(),
                                    Technician__c = maintCaseSVs.get(a.Component_Type__c).Default_Technician_Id__c,
                                    Visit_Date__c = c.Service_Date__c)
                                );
                            }
                        }
                    }
                }
                
                if (!serviceVisits.isEmpty()) {
                    insert serviceVisits;
                }
            }
            */
        }
        
        if (trigger.isUpdate) {
            
            // Update related Service Visit records if certain Case fields have changed
            // Find cases that have Transaction records that need to be updated
            Set<Id> conIds = new Set<Id>();
            Set<Id> sdIds = new Set<Id>();
            Set<Id> rstIds = new Set<Id>();
            Set<Id> transactionCaseIds = new Set<Id>();
            for (Case c :trigger.new) {
                if (c.ServiceContract_Case__c != trigger.oldMap.get(c.Id).ServiceContract_Case__c && c.ServiceContract_Case__c != null) {
                    conIds.add(c.Id);
                }
                if (c.Service_Date__c != trigger.oldMap.get(c.Id).Service_Date__c) {
                    sdIds.add(c.Id);
                }
                if (c.Reactive_Service_Type__c != trigger.oldMap.get(c.Id).Reactive_Service_Type__c && rtCaseMap.containsKey(c.RecordTypeId) && rtCaseMap.get(c.RecordTypeId).getName() == 'Maintenance Case') {
                    rstIds.add(c.Id);
                }
                
                if (c.Status != trigger.oldMap.get(c.Id).Status || c.ClosedDate != trigger.oldMap.get(c.Id).ClosedDate) {
                    transactionCaseIds.add(c.Id);
                }
            }
            
            // Update related Service Visit records
            List<SV__c> svList = new List<SV__c>();
            if (!conIds.isEmpty() || !sdIds.isEmpty() || !rstIds.isEmpty()) {
                svList = [select Id, Case__c, Contract__c, Reactive_Service_Type__c, Visit_Date__c from SV__c where Case__c in :conIds or Case__c in :sdIds or Case__c in :rstIds];
            }
            
            for (SV__c sv :svList) {
                if (conIds.contains(sv.Case__c)) {
                    sv.Contract__c = trigger.newMap.get(sv.Case__c).ServiceContract_Case__c;
                }
                
                if (sdIds.contains(sv.Case__c)) {
                    sv.Visit_Date__c = trigger.newMap.get(sv.Case__c).Service_Date__c;
                }
                
                if (rstIds.contains(sv.Case__c)) {
                    sv.Reactive_Service_Type__c = trigger.newMap.get(sv.Case__c).Reactive_Service_Type__c;
                }
            }
            
            if (!svList.isEmpty()) {
                update(svList);
            }
            
            // Update related Transaction records with the latest case Status and ClosedDate
            List<AcctSeed__Transaction__c> tranList = new List<AcctSeed__Transaction__c>();
            if (!transactionCaseIds.isEmpty()) {
                tranList = [select Id, Case__c, Case_Status__c, Case_Closed_Date__c from AcctSeed__Transaction__c where Case__c in :transactionCaseIds];
            }
            
            for (AcctSeed__Transaction__c t :tranList) {
                t.Case_Status__c = trigger.newMap.get(t.Case__c).Status;
                t.Case_Closed_Date__c = trigger.newMap.get(t.Case__c).ClosedDate;
            }
            
            if (!tranList.isEmpty()) {
                update tranList;
            }
            
            /*
            // Find cases that should be closed based upon the Alert ID and Transaction records that need to be updated
            Set<String> alertIds = new Set<String>();
            Set<Id> accIds = new Set<Id>();
            Set<Id> transactionCaseIds = new Set<Id>();
            cIds.clear();
            for (Case c :trigger.new) {
                if (c.Status == 'Closed' && trigger.oldMap.get(c.Id).Status != 'Closed') {
                    if (String.isNotBlank(c.Alert_ID__c) && c.Subject.contains('Resolved')) {
                        alertIds.add(c.Alert_ID__c);
                        cIds.add(c.Id);
                        if (c.AccountId != null) {
                            accIds.add(c.AccountId);
                        }
                    }
                }
                
                if (c.Status != trigger.oldMap.get(c.Id).Status || c.ClosedDate != trigger.oldMap.get(c.Id).ClosedDate) {
                    transactionCaseIds.add(c.Id);
                }
            }
            
            // Update related Transaction records with the latest case Status and ClosedDate
            if (!transactionCaseIds.isEmpty()) {
                List<AcctSeed__Transaction__c> tranList = new List<AcctSeed__Transaction__c>();
                tranList = [select Id, Case__c, Case_Status__c, Case_Closed_Date__c from AcctSeed__Transaction__c where Case__c in :transactionCaseIds];
                
                for (AcctSeed__Transaction__c t :tranList) {
                    if (trigger.newMap.containsKey(t.Case__c)) {
                        t.Case_Status__c = trigger.newMap.get(t.Case__c).Status;
                        t.Case_Closed_Date__c = trigger.newMap.get(t.Case__c).ClosedDate;
                    }
                }
                
                if (!tranList.isEmpty()) {
                    update tranList;
                }
            }
            
            // Close those cases that have the same Alert ID as cases that have already been closed
            if (!alertIds.isEmpty() && !accIds.isEmpty()) {
                List<Case> closeList = new List<Case>();
                List<Case> caseList = new List<Case>();
                caseList = [select Id, Status, Number_of_Service_Visits__c from Case where  
                        (not Id in :cIds) and 
                        (AccountId in :accIds) and 
                        (Alert_ID__c in :alertIds) and 
                        (IsClosed = false) and 
                        (LatestVisitCommentDate__c = null) and 
                        (Reason = '' or Reason = null)];
                
                for (Case c :caseList) {
                    if (c.Number_of_Service_Visits__c == null || c.Number_of_Service_Visits__c == 0) {
                        c.Status = 'Closed - Issue Resolved Automatically';
                        closeList.add(c);
                    }
                }
                
                if (!closeList.isEmpty()) {
                    update closeList;
                }
            }
            */
            
            // Set the Billing_Status__c field on closed cases
            CaseService.caseBillingStatus(trigger.new, trigger.oldMap);
            
            /*
            // Set Billing_Field__c on related Service Visit records
            CaseService.serviceVisitLaborBilling(trigger.newMap, trigger.oldMap);
            */
        }
    }
}