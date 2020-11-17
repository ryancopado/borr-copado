public class ProjectService {

  
    
    /*
     *  Service class for the Project object trigger ProjectTrigger.trigger.
     *
     */
    
    /*
    // Create a Sales Order and Site records related to the new Project.
    // - after insert, after update
    public static void createRelatedRecords(List<AcctSeed__Project__c> newList, Map<Id, AcctSeed__Project__c> oldMap, Boolean isInsert) {
        
        ///*
         //*    Create a Sales Order and Site records related to the Project.  If this is
         //*    the first Project created for an Opportunity, associate all Sites connected to
         //*    the Opportunity to the Project, otherwise simply create one Site for the new
         //*    Project.
         //*
         //*    If the Project is of record type O&M Project do not create Site records.
         //*
         //
        
        Set<Id> oppIds = new Set<Id>();
        Map<Id, AcctSeed__Project__c> pSiteMap = new Map<Id, AcctSeed__Project__c>();
        Map<Id, AcctSeed__Project__c> pSOMap = new Map<Id, AcctSeed__Project__c>();
        List<Site__c> siteUpList = new List<Site__c>();
        List<AcctSeedERP__Sales_Order__c> soCreate = new List<AcctSeedERP__Sales_Order__c>();
        Map<Id,Schema.RecordTypeInfo> rtMapById = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosById();
        
        for (AcctSeed__Project__c p :newList) {
            
            // Only create Sites for Projects with an Opportunity and only create Sales Orders for Projects 
            // with an Opportunity and an Account on insert
            if (isInsert) {
                if (p.AcctSeed__Opportunity__c != null) {
                    if (p.AcctSeed__Account__c != null) {
                        pSOMap.put(p.Id, p);
                    }
                    
                    if (rtMapById.containsKey(p.RecordTypeId) && rtMapById.get(p.RecordTypeId).getName() != 'O&M Project') {
                        pSiteMap.put(p.Id, p);
                        oppIds.add(p.AcctSeed__Opportunity__c);
                    }
                }
            }
            
            // On update, only create Sales Order and Site records for Projects if they weren't already created
            // during insert. We attempt to determine that by looking for the transition on the Opportunity and 
            // Account lookups from null to non-null.
            if (!isInsert) {
                if (p.AcctSeed__Opportunity__c != null) {
                    if (p.AcctSeed__Account__c != null) {
                        if (oldMap.get(p.Id).AcctSeed__Opportunity__c == null || oldMap.get(p.Id).AcctSeed__Account__c == null) {
                            pSOMap.put(p.Id, p);
                        }
                    }
                    
                    if (oldMap.get(p.Id).AcctSeed__Opportunity__c == null) {
                        if (rtMapById.containsKey(p.RecordTypeId) && rtMapById.get(p.RecordTypeId).getName() != 'O&M Project') {
                            pSiteMap.put(p.Id, p);
                            oppIds.add(p.AcctSeed__Opportunity__c);
                        }
                    }
                }
            }
        }
        
        // Determine if we need to create new Site records or simply relate the Site records from the Opportunity to the Project
        if (!oppIds.isEmpty()) {
            List<Site__c> siteList = new List<Site__c>();
            siteList = [select Id, Opportunity__c, Project__c from Site__c where Opportunity__c in :oppIds or Project__c in :pSiteMap.keySet()];
            for (Site__c s :siteList) {
                if (pSiteMap.containsKey(s.Project__c)) {
                    pSiteMap.remove(s.Project__c);
                    oppIds.remove(s.Opportunity__c);
                }
            }
            
            ///************************
            //pSiteMap only contains trigger Projects that do not have Sites associated with them
            //************************
            
            // Count up the number of Projects per Opportunity and number of Sites per Opportunity
            if (!pSiteMap.isEmpty()) {
                List<AcctSeed__Project__c> pList = new List<AcctSeed__Project__c>();
                Map<Id, Integer> oppProjMap = new Map<Id, Integer>();
                Map<Id, Integer> oppSiteMap = new Map<Id, Integer>();
                pList = [select Id, AcctSeed__Opportunity__c from AcctSeed__Project__c where AcctSeed__Opportunity__c in :oppIds];
                for (AcctSeed__Project__c p :pList) {
                    if (oppProjMap.containsKey(p.AcctSeed__Opportunity__c)) {
                        oppProjMap.put(p.AcctSeed__Opportunity__c, oppProjMap.get(p.AcctSeed__Opportunity__c) + 1);
                    } else {
                        oppProjMap.put(p.AcctSeed__Opportunity__c, 1);
                    }
                }
                for (Site__c s :siteList) {
                    if (s.Opportunity__c != null) {
                        if (oppSiteMap.containsKey(s.Opportunity__c)) {
                            oppSiteMap.put(s.Opportunity__c, oppSiteMap.get(s.Opportunity__c) + 1);
                        } else {
                            oppSiteMap.put(s.Opportunity__c, 1);
                        }
                    }
                }
            
                ///*
                //system.debug('*****Project_CreateRelatedRecords oppProjMap.size = ' + oppProjMap.size() + ' oppSiteMap.size = ' + oppSiteMap.size());
                //for (Id i :oppProjMap.keySet()) {
                    //system.debug('*****Project_CreateRelatedRecords oppProjMap Id = ' + i + ' number of projects = ' + oppProjMap.get(i));
                //}
                //for (Id i :oppSiteMap.keySet()) {
                    //system.debug('*****Project_CreateRelatedRecords oppSiteMap Id = ' + i + ' number of projects = ' + oppSiteMap.get(i));
                //}
                //
                
                for (AcctSeed__Project__c p :pSiteMap.values()) {
                    // If this is the first Project created for an Opportunity, associate all Sites 
                    // connected to the Opportunity to the Project, otherwise simply create one Site for the new Project.
                    if (oppProjMap.containsKey(p.AcctSeed__Opportunity__c) && oppProjMap.get(p.AcctSeed__Opportunity__c) == 1 &&
                        oppSiteMap.containsKey(p.AcctSeed__Opportunity__c)) {
                        for (Site__c s :siteList) {
                            if (s.Opportunity__c == p.AcctSeed__Opportunity__c) {
                                s.Project__c = p.Id;
                                siteUpList.add(s);
                            }
                        }
                    } else {
                        // Either this is not the first Project for the Opportunity or there are no Sites associated
                        // with the Opportunity - create a Site record for each Project
                        siteUpList.add(new Site__c(
                            Project__c = p.Id,
                            Opportunity__c = p.AcctSeed__Opportunity__c,
                            Name = p.Name.left(71) + ' - Site 1')
                        );
                    }
                }
            }
        }
        
        // Create a Sales Order for each Project if it doesn't already have one
        if (!pSOMap.isEmpty()) {
            List<AcctSeedERP__Sales_Order__c> soList = new List<AcctSeedERP__Sales_Order__c>();
            Map<Id, AcctSeedERP__Sales_Order__c> soMap = new Map<Id, AcctSeedERP__Sales_Order__c>();
            soList = [select Id, Project__c from AcctSeedERP__Sales_Order__c where Project__c in: pSOMap.keySet()];
            for (AcctSeedERP__Sales_Order__c so : soList) {
                if (!soMap.containsKey(so.Project__c)) {
                    soMap.put(so.Project__c, so);
                }
            }
            
            // Create a Sales Order record for each Project without one
            for (AcctSeed__Project__c p : pSOMap.values()) {
                if (!soMap.containsKey(p.Id)) {
                    soCreate.add(new AcctSeedERP__Sales_Order__c(
                        Project__c = p.Id,
                        AcctSeedERP__Opportunity__c = p.AcctSeed__Opportunity__c,
                        AcctSeedERP__Customer__c = p.AcctSeed__Account__c)
                    );
                }
            }
        }
        
        if (!soCreate.isEmpty()) {
            insert soCreate;
        }
        
        ///*
        //Integer newSites = 0;
        //Integer updatedSites = 0;
        //for (Site__c s :siteUpList) {
            //if (s.Id == null) {
                //newSites++;
            //} else {
                //updatedSites++;
            //}
        //}
        //system.debug('*****Project_CreateRelatedRecords newSites = ' + newSites + ' updatedSites = ' + updatedSites + ' total Sites = ' + siteUpList.size());
        //
        
        if (!siteUpList.isEmpty()) {
            upsert siteUpList;
        }
    }
    */
    
    /*
    // Populate fields on an O&M Project from an EPC Site
    // - before insert, before update
    public static void OMProjectFromSite(List<AcctSeed__Project__c> newList, Map<Id, AcctSeed__Project__c> oldMap, Boolean isInsert) {
        Set<Id> sIds = new Set<Id>();
        Map<Id, Schema.RecordTypeInfo> rtByIdMap = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosById();
        Map<String, EPCSiteToOMProject__c> fieldMap = EPCSiteToOMProject__c.getAll();
        List<AcctSeed__Project__c> projectList = new List<AcctSeed__Project__c>();
        
        for (AcctSeed__Project__c p :newList) {
            if (rtByIdMap.containsKey(p.RecordTypeId) && rtByIdMap.get(p.RecordTypeId).getName() == 'O&M Project') {
                if (p.EPC_Site__c != null) {
                    if (isInsert || p.EPC_Site__c != oldMap.get(p.Id).EPC_Site__c) {
                        sIds.add(p.EPC_Site__c);
                    }
                    projectList.add(p);
                }
            }
        }
        
        // If field EPC Site is set, make sure none of the fields to be copied from Site have been set/changed
        //Boolean isFieldError;
        //for (AcctSeed__Project__c p :projectList) {
            //for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
                //isFieldError = false;
                //if (isInsert) {
                    //if (p.get(spfm.Project_Field__c) != null) {
                        //isFieldError = true;
                    //}
                //} else {
                    //if (p.get(spfm.Project_Field__c) != oldMap.get(p.Id).get(spfm.Project_Field__c)) {
                        //isFieldError = true;
                    //}
                //}
                //if (isFieldError) {
                    //p.addError('Attempt to set one or more EPC Site fields. These fields are not writeable here. Please update the corresponding field on the related EPC Site instead. For more information, contact your system administrator.');
                    //sIds.remove(p.EPC_Site__c);
                    //break;
                //}
            //}
        //}
        
        // Get the data from the Site records
        Map<Id, Site__c> siteMap;
        if (!sIds.isEmpty()) {
            String siteQuery = 'SELECT Id, ';
            for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
                siteQuery += spfm.Site_Field__c + ', ';
            }
            siteQuery = siteQuery.removeEnd(', ');
            siteQuery += ' FROM Site__c WHERE Id IN: sIds';
            siteMap = new Map<Id, Site__c>((List<Site__c>)Database.query(siteQuery));
        } else {
            siteMap = new Map<Id, Site__c>();
        }
        
        // Populate the Project records with data from the Site records
        for (AcctSeed__Project__c p :newList) {
            if (rtByIdMap.containsKey(p.RecordTypeId) && rtByIdMap.get(p.RecordTypeId).getName() == 'O&M Project') {
                
                if (siteMap.containsKey(p.EPC_Site__c)) {
                    // Copy data from Site to Project
                    for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
                        p.put(spfm.Project_Field__c, siteMap.get(p.EPC_Site__c).get(spfm.Site_Field__c));
                    }
                    
                } else {
                    
                    if (!isInsert && p.EPC_Site__c == null && oldMap.get(p.Id).EPC_Site__c != null) {
                        // Clear out the fields on the Project
                        for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
                            p.put(spfm.Project_Field__c, null);
                        }
                    }
                }
            }
        }
    }
    */
    
    /*
    // Populate O&M Project fields from the associated Contract record
    // - before insert, before update
    public static void OMProjectFromContract(List<AcctSeed__Project__c> newList, Map<Id, AcctSeed__Project__c> oldMap, Boolean isInsert) {
        Set<Id> cIds = new Set<Id>();
        Map<Id, Schema.RecordTypeInfo> rtByIdMap = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosById();
        Map<String, ContractToOMProject__c> fieldMap = ContractToOMProject__c.getAll();
        
        for (AcctSeed__Project__c p :newList) {
            if (rtByIdMap.containsKey(p.RecordTypeId) && rtByIdMap.get(p.RecordTypeId).getName() == 'O&M Project') {
                if (p.Contract__c != null) {
                    if (isInsert || p.Contract__c != oldMap.get(p.Id).Contract__c) {
                        cIds.add(p.Contract__c);
                    }
                }
            }
        }
        
        // Get the data from the Contract records
        Map<Id, Contract> contractMap;
        if (!cIds.isEmpty()) {
            String contractQuery = 'SELECT Id, ';
            for (ContractToOMProject__c cpfm :fieldMap.values()) {
                contractQuery += cpfm.Contract_Field__c + ', ';
            }
            contractQuery = contractQuery.removeEnd(', ');
            contractQuery += ' FROM Contract WHERE Id IN: cIds';
            contractMap = new Map<Id, Contract>((List<Contract>)Database.query(contractQuery));
        } else {
            contractMap = new Map<Id, Contract>();
        }
        
        // Populate the Project records with data from the Contract records
        for (AcctSeed__Project__c p :newList) {
            if (rtByIdMap.containsKey(p.RecordTypeId) && rtByIdMap.get(p.RecordTypeId).getName() == 'O&M Project') {
                
                if (contractMap.containsKey(p.Contract__c)) {
                    // Copy data from Contract to Project
                    for (ContractToOMProject__c cpfm :fieldMap.values()) {
                        p.put(cpfm.Project_Field__c, contractMap.get(p.Contract__c).get(cpfm.Contract_Field__c));
                    }
                    
                } else {
                    
                    if (!isInsert && p.Contract__c == null && oldMap.get(p.Id).Contract__c != null) {
                        // Clear out the fields on the Project
                        for (ContractToOMProject__c cpfm :fieldMap.values()) {
                            p.put(cpfm.Project_Field__c, null);
                        }
                    }
                }
            }
        }
    }
    */
    
    // Update related Asset records based upon changes to the Project
    // - after update
    // Project field changes: Contract__c, AcctSeed__Account__c
    public static void ProjectToAsset(Map<Id, AcctSeed__Project__c> newMap, Map<Id, AcctSeed__Project__c> oldMap) {
        Set<Id> pIds = new Set<Id>();
        
        for (AcctSeed__Project__c p :newMap.values()) {
            if (p.Contract__c != oldMap.get(p.Id).Contract__c) {
                pIds.add(p.Id);
            }
            if (p.AcctSeed__Account__c != oldMap.get(p.Id).AcctSeed__Account__c) {
                pIds.add(p.Id);
            }
            
            if (!pIds.isEmpty()) {
                Map<String, Schema.RecordTypeInfo> rtByNameMap = Schema.SObjectType.Asset.getRecordTypeInfosByName();
                List<Asset> assetList = new List<Asset>();
                assetList = [select Id, RecordTypeId, AccountId, Contract__c, Project__c from Asset where Project__c in :pIds and RecordTypeId = :rtbyNameMap.get('Operations Asset').getRecordTypeId()];
                
                for (Asset a :assetList) {
                    if (newMap.containsKey(a.Project__c)) {
                        a.AccountId = newMap.get(a.Project__c).AcctSeed__Account__c;
                        a.Contract__c = newMap.get(a.Project__c).Contract__c;
                    }
                }
                
                if (!assetList.isEmpty()) {
                    update assetList;
                }
            }
        }
    }
    
    /*
    // Populate a new Project record with data
    // - before insert, before update
    public static void createProjects(List<AcctSeed__Project__c> newList, Map<Id, AcctSeed__Project__c> oldMap, Boolean isInsert) {
        
        List<AcctSeed__Project__c> newProjects = new List<AcctSeed__Project__c>();
        if (isInsert) {
            
            for (AcctSeed__Project__c p :newList) {
                if (p.AcctSeed__Opportunity__c != null) {
                    newProjects.add(p);
                }
            }
            
        } else {
            
            // Workaround for the AcctSeed problem where opportunity is not set on creation
            for (AcctSeed__Project__c p :newList) {
                if (p.AcctSeed__Opportunity__c != null && oldMap.get(p.Id).AcctSeed__Opportunity__c == null) {
                    if (String.isBlank(p.Job_Number__c)) {
                        newProjects.add(p);
                    }
                }
            }
        }
        
        if (!newProjects.isEmpty()) {
            ProjectCreate.createprojects(newProjects);
        }
    }
    */
    
    /*
    // Set the Job Number for a Project
    // - before update
    public static void jobNumber(List<AcctSeed__Project__c> newList, Map<Id, AcctSeed__Project__c> oldMap) {
        List<AcctSeed__Project__c> upProj = new List<AcctSeed__Project__c>();
        
        for (AcctSeed__Project__c p :newList) {
            
            // Added By Madan - July 31(Added extra condition with SalesSegment field Changed)
            if ((p.Branch__c != oldMap.get(p.Id).Branch__c && p.Branch__c != null) || 
                    p.Sales_Segment__c != oldMap.get(p.Id).Sales_Segment__c) {
                upProj.add(p);
            }
        }
        
        if (!upProj.isEmpty()) {
            ProjectCreate.upNum(upProj);
        }
    }
    */
    
    // Create a Service Contract (Warranty) for the Project if one does not already exist
    // - after insert, after update
    public static void createServiceContract(List<AcctSeed__Project__c> newList, Map<Id, AcctSeed__Project__c> oldMap, Boolean isInsert) {
        Set<Id> pIds = new Set<Id>();
        
        for (AcctSeed__Project__c p :newList) {
            if (p.Overall_Project_Status__c == 'Design') {
                if (isInsert) {
                    pIds.add(p.Id);
                } else {
                    if (oldMap.get(p.Id).Overall_Project_Status__c != 'Design') {
                        pIds.add(p.Id);
                    }
                }
            }
        }
        
        if (!pIds.isEmpty()) {
            Id rtWarrantyId = Schema.SObjectType.Contract.getRecordTypeInfosByName().get('Warranty').getRecordTypeId();
            List<Contract> newContracts = new List<Contract>();
            List<Contract> existingContracts = new List<Contract>();
            Map<Id, Contract> cMap = new Map<Id, Contract>();
            
            existingContracts = [select Id, ASProject__c from Contract where ASProject__c in :pIds and RecordTypeId = :rtWarrantyId];
            for (Contract c :existingContracts) {
                cMap.put(c.ASProject__c, c);
            }
            
            for (AcctSeed__Project__c p :newList) {
                if (pIds.contains(p.Id) && !cMap.containsKey(p.Id)) {
                    newContracts.add(new Contract(
                        AccountId = p.AcctSeed__Account__c,
                        StartDate = system.now().date(),
                        ContractTerm = 12,
                        Service_Schedule_months__c = 6,
                        Contract_Amount__c = 0,
                        RecordTypeId = rtWarrantyId,
                        ASProject__c = p.Id)
                    );
                }
            }
            
            if (!newContracts.isEmpty()) {
                insert newContracts;
            }
        }
    }
    
    /*
    // If the PM Lock field has changed, cause the remaining available budget to be rolled-up from 
    // construction requesition records (Sales Order Line) related to the project to the parent con req group record.
    // - after update
    public static void pmLockChange(List<AcctSeed__Project__c> newList, Map<Id, AcctSeed__Project__c> oldMap) {
        Set<Id> pIds = new Set<Id>();
        
        for (AcctSeed__Project__c p :newList) {
            if (p.PM_Lock__c != oldMap.get(p.Id).PM_Lock__c) {
                pIds.add(p.Id);
            }
        }
        
        if (!pIds.isEmpty()) {
            List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
            List<AcctSeedERP__Sales_Order_Line__c> solUpList = new List<AcctSeedERP__Sales_Order_Line__c>();
            solList = [select Id, Project_PM__c, AcctSeedERP__Project__c, Con_Req_Group__c, RollUp_Remaining_Available_Budget__c  
                    from AcctSeedERP__Sales_Order_Line__c where  AcctSeedERP__Project__c in: pIds];
            
            for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
                if (sol.Con_Req_Group__c != null) {
                    sol.RollUp_Remaining_Available_Budget__c = !sol.RollUp_Remaining_Available_Budget__c;
                    solUpList.add(sol);
                }
            }
            
            if (!solUpList.isEmpty()) {
                update solUpList;
            }
        }
    }
    */
    
    // Handles all before insert and before update trigger operations - all of it in one method to minimize processing time
    // - before insert, before update
    public static void projectBefore(List<AcctSeed__Project__c> newList, Map<Id, AcctSeed__Project__c> oldMap, Boolean isInsert) {
       system.debug('this is Projectbefore-->');
       
        List<AcctSeed__Project__c> newProjects = new List<AcctSeed__Project__c>();
        List<AcctSeed__Project__c> upProj = new List<AcctSeed__Project__c>();
        
        Set<Id> sIds = new Set<Id>();
        Map<Id, Schema.RecordTypeInfo> rtByIdMap = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosById();
        List<AcctSeed__Project__c> epcSiteCopy = new List<AcctSeed__Project__c>();
        List<AcctSeed__Project__c> epcSiteClear = new List<AcctSeed__Project__c>();
        
        system.debug('this is newproject-->' +newProjects );
        system.debug('this is recordtype-->' +rtByIdMap );
        
        
        for (AcctSeed__Project__c p :newList) {
            
                //system.debug('this is recordtypeid-->' +p.RecordTypeid);
               // system.debug('this is recordtypename-->' +p.RecordType.name);
               // system.debug('this is salessegment-->' +p.sales_segment__c);
            
            if (isInsert) {
            
            system.debug('this is  insert starting-->'  +newlist);
                
                if (p.AcctSeed__Opportunity__c != null) {
                               
                   newProjects.add(p);
                }
                if (p.name == 'Development Project Template_Cloned' && p.sales_segment__c == null){
                system.debug('this is the developement business unit');
                p.sales_segment__c ='a1O2H00000D2ii9';  //this is developement id//'a1O5500000CTyAJ'
             //   newProjects.add(p);
                }
                if (p.name =='EPC Project Template_Cloned' && p.sales_segment__c==null){
                p.sales_segment__c ='a1O2H00000D2iiE'; //this is epc id//'a1O5500000CTyA4'
              //  newProjects.add(p);
                }
                
                if (p.EPC_Site__c != null) {
                    if (rtByIdMap.containsKey(p.RecordTypeId) && rtByIdMap.get(p.RecordTypeId).getName() == 'O&M Project') {
                        sIds.add(p.EPC_Site__c);
                        epcSiteCopy.add(p);
                    }
                }
            }
            
            if (!isInsert) {
                
                
                // Workaround for the AcctSeed problem where opportunity is not set on creation
                if (p.AcctSeed__Opportunity__c != null && oldMap.get(p.Id).AcctSeed__Opportunity__c == null) {
                    if (String.isBlank(p.Job_Number__c)) {
                        newProjects.add(p);
                    }
                }
                
                if ((p.Sales_Segment__c != oldMap.get(p.Id).Sales_Segment__c)||(p.Ops_Division__c != oldMap.get(p.id).Ops_Division__c)) {
                    upProj.add(p);
                }
                
                if (p.Previous_DM_dollars__c != oldMap.get(p.Id).Previous_DM_dollars__c) {
                    p.Roll_Up_Budget_Line_Items__c = p.AcctSeed__Budgeted_Amount__c;
                }
                
                if (p.Margin_Change_Explanation__c != oldMap.get(p.Id).Margin_Change_Explanation__c) {
                    p.Comments_on_Budget__c = String.valueOf(system.today()) + ' ' + (UserInfo.getFirstName().substring(0, 1) + UserInfo.getLastName().subString(0, 1)).toLowerCase() + ': ' + p.Margin_Change_Explanation__c + '\n\n' + p.Comments_on_Budget__c;
                }
                
                if (p.Total_Indirects_Budgeted__c != oldMap.get(p.Id).Total_Indirects_Budgeted__c) {
                    p.Budgets_Total__c = p.Total_Indirects_Budgeted__c;
                }
                
                if (p.EPC_Site__c != oldMap.get(p.Id).EPC_Site__c) {
                    if (rtByIdMap.containsKey(p.RecordTypeId) && rtByIdMap.get(p.RecordTypeId).getName() == 'O&M Project') {
                        if (p.EPC_Site__c != null) {
                            sIds.add(p.EPC_Site__c);
                            epcSiteCopy.add(p);
                        } else {
                            epcSiteClear.add(p);
                        }
                    }
                }
            }
        }
        
        // Populate a new Project record with data
        if (!newProjects.isEmpty()) {
        system.debug('this is newproject popoulate-->' +newProjects);
            ProjectCreate.createprojects(newProjects);
        }
        
        // Populate fields on an O&M Project from an EPC Site
        if (!epcSiteCopy.isEmpty() || !epcSiteClear.isEmpty()) {
            Map<String, EPCSiteToOMProject__c> fieldMap = EPCSiteToOMProject__c.getAll();
            
            // Copy data from Site to Project
            if (!sIds.isEmpty()) {
                String siteQuery = 'SELECT Id, ';
                for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
                    siteQuery += spfm.Site_Field__c + ', ';
                }
                siteQuery = siteQuery.removeEnd(', ');
                siteQuery += ' FROM Site__c WHERE Id IN: sIds';
                Map<Id, Site__c> siteMap = new Map<Id, Site__c>((List<Site__c>)Database.query(siteQuery));
                
                for (AcctSeed__Project__c p :epcSiteCopy) {
                    if (siteMap.containsKey(p.EPC_Site__c)) {
                        for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
                            p.put(spfm.Project_Field__c, siteMap.get(p.EPC_Site__c).get(spfm.Site_Field__c));
                        }
                    }
                }
            }
            
            // Clear Site data from Project
            for (AcctSeed__Project__c p :epcSiteClear) {
                for (EPCSiteToOMProject__c spfm :fieldMap.values()) {
                    p.put(spfm.Project_Field__c, null);
                }
            }
        }
        
        // Set the Job Number for a Project
        if (!upProj.isEmpty()) {
        system.debug('this is for jobnumber-->' +upproj);
            ProjectCreate.upNum(upProj);
        }
    }
    
    // Handles all after insert and after update trigger operations - all of it in one method to minimize processing time
    // - after insert, after update
    public static void projectAfter(Map<Id, AcctSeed__Project__c> newMap, Map<Id, AcctSeed__Project__c> oldMap, Boolean isInsert) {
        Set<Id> pKickOffIds = new Set<Id>();
        Set<Id> oppIds = new Set<Id>();
        Map<Id, AcctSeed__Project__c> pSiteMap = new Map<Id, AcctSeed__Project__c>();
        Map<Id, AcctSeed__Project__c> pSOMap = new Map<Id, AcctSeed__Project__c>();
        Map<Id,Schema.RecordTypeInfo> rtMapById = Schema.SObjectType.AcctSeed__Project__c.getRecordTypeInfosById();
        List<ProjectPartner__c> subCompList = new List<ProjectPartner__c>();
        Id subCompAccountId = '00130000009oCRn';    // Account record: Borrego Solar Systems, Inc.
        Id subCompContactId = '0033000000DtJsa';    // Contact record: Borrego South
        //system.debug('This is old map' +oldMap.values());
        system.debug('This is project and opp ids' +newMap.values());
       //system.debug('This is Opportunity Id' +p.AcctSeed__Opportunity__c);
       
        for (AcctSeed__Project__c p :newMap.values()) {
        system.debug('This is for loop');
            
            // Processing that happens for both after insert and after update
            
            
            // Processing that happens only for after insert
            if (isInsert) {
            system.debug('This is developer insert');
                
                // Only create Sites for Projects with an Opportunity and only create Sales Orders for Projects 
                // with an Opportunity and an Account on insert
                if (p.AcctSeed__Opportunity__c != null) {
                    if (p.AcctSeed__Account__c != null) {
                        pSOMap.put(p.Id, p);
                    }
                    
                    if (rtMapById.containsKey(p.RecordTypeId) && rtMapById.get(p.RecordTypeId).getName() != 'O&M Project') {
                        pSiteMap.put(p.Id, p);
                        oppIds.add(p.AcctSeed__Opportunity__c);
                    }
                }
                
                // Create a Subcontractor Compliance record for each new Project
                subCompList.add(new ProjectPartner__c(ASProject__c = p.Id, AccountId__c = subCompAccountId, Primary_Contact__c = subCompContactId));
            }
            
            system.debug('This is opp id' +p.AcctSeed__Opportunity__c);
            
             
            
            
            // Processing that happens only for after update
            if (!isInsert) {
                if (p.Project_Kickoff_Date__c != oldMap.get(p.Id).Project_Kickoff_Date__c) {
                    pKickOffIds.add(p.Id);
                }
                
                // On update, only create Sales Order and Site records for Projects if they weren't already created
                // during insert. We attempt to determine that by looking for the transition on the Opportunity and 
                // Account lookups from null to non-null.
                if (p.AcctSeed__Opportunity__c != null) {
                    if (p.AcctSeed__Account__c != null) {
                        if (oldMap.get(p.Id).AcctSeed__Opportunity__c == null || oldMap.get(p.Id).AcctSeed__Account__c == null) {
                            pSOMap.put(p.Id, p);
                        }
                    }
                    
                    if (oldMap.get(p.Id).AcctSeed__Opportunity__c == null) {
                        if (rtMapById.containsKey(p.RecordTypeId) && rtMapById.get(p.RecordTypeId).getName() != 'O&M Project') {
                            pSiteMap.put(p.Id, p);
                            oppIds.add(p.AcctSeed__Opportunity__c);
                        }
                    }
                }
            }
        }
        
        Map<Id, Site__c> siteUpMap = new Map<Id, Site__c>();
        List<Site__c> siteUpList = new List<Site__c>();
        system.debug('This is opportunity Ids' +oppIds);
        if (!pKickOffIds.isEmpty() || !oppIds.isEmpty()) {
            Map<Id, Site__c> siteMap = new Map<Id, Site__c>([select Id, Opportunity__c, Project__c, Project_Kickoff_Date_editable__c 
                    from Site__c where Opportunity__c in :oppIds or Project__c in :pSiteMap.keySet() or Project__c in :pKickOffIds]);
            
            for (Site__c s :siteMap.values()) {
                if (pKickOffIds.contains(s.Project__c) && s.Project_Kickoff_Date_editable__c == null) {
                    s.Project_Kickoff_Date_editable__c = newMap.get(s.Project__c).Project_Kickoff_Date__c;
                    siteUpMap.put(s.Id, s);
                }
                
                // Toss out those Projects that already have a related Site
                if (pSiteMap.containsKey(s.Project__c)) {
                    pSiteMap.remove(s.Project__c);
                    oppIds.remove(s.Opportunity__c);
                }
            }
            
            // Count up the number of Projects per Opportunity and number of Sites per Opportunity
            if (!pSiteMap.isEmpty()) {
                List<AcctSeed__Project__c> pList = new List<AcctSeed__Project__c>();
                Map<Id, Integer> oppProjMap = new Map<Id, Integer>();
                Map<Id, Integer> oppSiteMap = new Map<Id, Integer>();
                pList = [select Id, AcctSeed__Opportunity__c from AcctSeed__Project__c where AcctSeed__Opportunity__c in :oppIds];
                for (AcctSeed__Project__c p :pList) {
                    if (oppProjMap.containsKey(p.AcctSeed__Opportunity__c)) {
                        oppProjMap.put(p.AcctSeed__Opportunity__c, oppProjMap.get(p.AcctSeed__Opportunity__c) + 1);
                    } else {
                        oppProjMap.put(p.AcctSeed__Opportunity__c, 1);
                    }
                }
                system.debug('This is projmap values' +oppProjMap);
                system.debug('Opportunity' +oppIds);
               //these changes are for populating  
                for (AcctSeed__Project__c p :newMap.values()) {
                system.debug('Entering for');
                
                
                 
                
                 
             List<Request_for_Information_RFI__c> issuerecords=new List<Request_for_Information_RFI__c>();
             List<Request_for_Information_RFI__c> listfinal=new List<Request_for_Information_RFI__c>();
       
        issuerecords=[select id,ASProject__c from Request_for_Information_RFI__c where Opportunity__c=:oppIds];
        for(Request_for_Information_RFI__c issuetrackerec :issuerecords)
        {
        
        
        
        system.debug('entering if condition');
        Request_for_Information_RFI__c records=new Request_for_Information_RFI__c();
        records=issuerecords.get(0);
        
        records.ASProject__c=p.Id;
        records.id=records.id;
        system.debug('Updated value' +records);
        listfinal.add(records);
        
        
        
        
        }
        if (!listfinal.isEmpty()){
         
           update listfinal;
       }
                
                
                }
                for (Site__c s :siteMap.values()) {
                    if (s.Opportunity__c != null) {
                        if (oppSiteMap.containsKey(s.Opportunity__c)) {
                            oppSiteMap.put(s.Opportunity__c, oppSiteMap.get(s.Opportunity__c) + 1);
                        } else {
                            oppSiteMap.put(s.Opportunity__c, 1);
                        }
                    }
                }
                
                for (AcctSeed__Project__c p :pSiteMap.values()) {
                    // If this is the first Project created for an Opportunity, associate all Sites 
                    // connected to the Opportunity to the Project, otherwise simply create one Site for the new Project.
                    if (oppProjMap.containsKey(p.AcctSeed__Opportunity__c) && oppProjMap.get(p.AcctSeed__Opportunity__c) == 1 &&
                        oppSiteMap.containsKey(p.AcctSeed__Opportunity__c)) {
                        for (Site__c s :siteMap.values()) {
                            if (s.Opportunity__c == p.AcctSeed__Opportunity__c) {
                                s.Project__c = p.Id;
                                siteUpMap.put(s.Id, s);
                            }
                        }
                    } else {
                        // Either this is not the first Project for the Opportunity or there are no Sites associated
                        // with the Opportunity - create a Site record for each Project
                        siteUpList.add(new Site__c(
                            Project__c = p.Id,
                            Opportunity__c = p.AcctSeed__Opportunity__c,
                            Name = p.Name.left(71) + ' - Site 1')
                        );
                    }
                }
            }
        }
              
   /*   List<AcctSeed__Ledger__c> ledgers = new List<AcctSeed__Ledger__c>();

        ledgers.add(
            new AcctSeed__Ledger__c(
                Name = 'MainCompany',
                AcctSeed__Type__c = 'Transactional',
                AcctSeed__Billing_Activity_Statement_Format__c='a1U34000003y3Ql',
                AcctSeed__Billing_Outstanding_Statement_Format__c='a1U80000000COOs',
                AcctSeed__Default_Bank_Account__c= 'a1m80000000p2lF',
                AcctSeed__Default_Billing_Format__c='a1U80000000AbRO',
                AcctSeed__Default_Purchase_Order_Format__c='a1U80000000COQ8',
                AcctSeed__Default_Packing_Slip_Format__c='a1U34000004Abf2' 
                
            )
        );
        
        insert ledgers; */

        
        // Create a Sales Order for each Project if it doesn't already have one
        List<AcctSeedERP__Sales_Order__c> soCreate = new List<AcctSeedERP__Sales_Order__c>();
        if (!pSOMap.isEmpty()) {
            List<AcctSeedERP__Sales_Order__c> soList = new List<AcctSeedERP__Sales_Order__c>();
            Map<Id, AcctSeedERP__Sales_Order__c> soMap = new Map<Id, AcctSeedERP__Sales_Order__c>();
            soList = [select Id, Project__c,AcctSeedERP__Ledger__c from AcctSeedERP__Sales_Order__c where Project__c in: pSOMap.keySet()];
            for (AcctSeedERP__Sales_Order__c so : soList) {
                if (!soMap.containsKey(so.Project__c)) {
                    soMap.put(so.Project__c, so);
                }
            }
            
            Id ledgerId = [SELECT Id From AcctSeed__Ledger__c WHERE AcctSeed__Type__c = 'Transactional' LIMIT 1].Id;
            
            for (AcctSeed__Project__c p : pSOMap.values()) {
                if (!soMap.containsKey(p.Id)) {
                    soCreate.add(new AcctSeedERP__Sales_Order__c(
                        Project__c = p.Id,
                        AcctSeedERP__Opportunity__c = p.AcctSeed__Opportunity__c,
                        AcctSeedERP__Customer__c = p.AcctSeed__Account__c,
                        AcctSeedERP__Ledger__c=ledgerId)
                        );
                        
                    
                }
            }
        }
        //AcctSeedERP__Ledger__c=ledgers[0].Id) //'a1q80000000CqAeAAK'
        
        // Write out new/updated records
      if (!soCreate.isEmpty()) {
      
      if(!Test.isRunningTest()){
            insert soCreate;
            }
        } 
        
        
        
        siteUpList.addAll(siteUpMap.values());
        if (!siteUpList.isEmpty()) {
            upsert siteUpList;
        }
        
        if (!subCompList.isEmpty()) {
            insert subCompList;
        }
    }
}