public class CaseService {
    
    /*
     *  Service methods for case triggers.
     */
    
    // For closed cases, set field Billing_Status__c based upon the related Billing Line, Service Visit, and
    // Sales Order Line records.
    // - after update
    public static void caseBillingStatus(List<Case> newList, Map<Id, Case> oldMap) {
        Set<Id> cIds = new Set<Id>();
        
        // Create list of case Ids that have just been closed
        for (Case c :newList) {
            if (c.IsClosed && !oldMap.get(c.Id).IsClosed) {
                cIds.add(c.Id);
            }
        }
        
        if (!cIds.isEmpty()) {
            billingStatus(cIds);
        }
    }
    
    // Set field Billing_Status__c based upon the related Billing Line, Service Visit, and Sales Order Line records.
    // The parameter cIds should be the Ids of closed case records.
    // This method is called from triggers on the Case, Billing, Billing Line, Work Order, and Sales Order Line objects.
    @future
    public static void billingStatus(Set<Id> cIds) {
    
    
        
        Map<Id, Case> caseCloseMap = new Map<Id, Case>([select Id, Billing_Status__c, ServiceContract_Case__c from Case where Id in :cIds and IsClosed = true]);
        String contractid;
        system.debug('this is billstatus-->' +caseCloseMap.values() );
        if (!caseCloseMap.isEmpty()) {
            
            // Get related Billing Line and Service Visit records
            List<AcctSeed__Billing_Line__c> blList = new List<AcctSeed__Billing_Line__c>();
            blList = [select Id, AcctSeed__Parent_Status__c, Case__c from AcctSeed__Billing_Line__c where Case__c in :caseCloseMap.keySet()];
            
            /*
            Map<Id, SV__c> svMap = new Map<Id, SV__c>([select Id, Billing_Field__c, Case__c from SV__c where Case__c in :caseCloseMap.keySet()]);
            List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
            if (!svMap.isEmpty()) {
                solList = [select Id, Service_Visit__c, Tax_Category__c from AcctSeedERP__Sales_Order_Line__c where Service_Visit__c in :svMap.keySet()];
            }
            */
            
            Map<Id, WorkOrder> woMap = new Map<Id, WorkOrder>([select Id, CaseId, Billable__c from WorkOrder where CaseId in :caseCloseMap.keySet()]);
            List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
            if (!woMap.isEmpty()) {
                solList = [select Id, WorkOrder__c, Tax_Category__c from AcctSeedERP__Sales_Order_Line__c where WorkOrder__c in :woMap.keySet()];
            }
            
            // Create maps of the Billing Lines, Service Visits and Sales Order Lines per Case
            Map<Id, List<AcctSeed__Billing_Line__c>> cblMap = new Map<Id, List<AcctSeed__Billing_Line__c>>();
            //Map<Id, List<SV__c>> csvMap = new Map<Id, List<SV__c>>();
            Map<Id, List<WorkOrder>> cwoMap = new Map<Id, List<WorkOrder>>();
            Map<Id, List<AcctSeedERP__Sales_Order_Line__c>> csolMap = new Map<Id, List<AcctSeedERP__Sales_Order_Line__c>>();
            for (AcctSeed__Billing_Line__c bl :blList) {
                if (!cblMap.containsKey(bl.Case__c)) {
                    cblMap.put(bl.Case__c, new List<AcctSeed__Billing_Line__c>());
                }
                cblMap.get(bl.Case__c).add(bl);
            }
            
            /*
            for (SV__c sv :svMap.values()) {
                if (!csvMap.containsKey(sv.Case__c)) {
                    csvMap.put(sv.Case__c, new List<SV__c>());
                }
                csvMap.get(sv.Case__c).add(sv);
            }
            
            for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
                if (!csolMap.containsKey(svMap.get(sol.Service_Visit__c).Case__c)) {
                    csolMap.put(svMap.get(sol.Service_Visit__c).Case__c, new List<AcctSeedERP__Sales_Order_Line__c>());
                }
                csolMap.get(svMap.get(sol.Service_Visit__c).Case__c).add(sol);
            }
            */
            for (WorkOrder wo :woMap.values()) {
                if (!cwoMap.containsKey(wo.CaseId)) {
                    cwoMap.put(wo.CaseId, new List<WorkOrder>());
                }
                cwoMap.get(wo.CaseId).add(wo);
            }
            
            for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
                if (!csolMap.containsKey(woMap.get(sol.WorkOrder__c).CaseId)) {
                    csolMap.put(woMap.get(sol.WorkOrder__c).CaseId, new List<AcctSeedERP__Sales_Order_Line__c>());
                }
                csolMap.get(woMap.get(sol.WorkOrder__c).CaseId).add(sol);
            }
            
            // Set Billing_Status__c for each closed case
            String billingStatus = '';
            for (Case c :caseCloseMap.values()) {
                system.debug('enter for ' + c.Billing_Status__c );
                contractid=c.ServiceContract_Case__c;
                if (cblMap.containsKey(c.Id)) {
                    billingStatus = 'Complete';
                    for (AcctSeed__Billing_Line__c bl :cblMap.get(c.Id)) {
                        if (bl.AcctSeed__Parent_Status__c != 'Posted') {
                            billingStatus = 'In Process';
                            break;
                        }
                    }
                    c.Billing_Status__c = billingStatus;
                    
                } else {
                    
                    /*
                    billingStatus = 'Not Billable';
                    if (csvMap.containsKey(c.Id)) {
                        for (SV__c sv :csvMap.get(c.Id)) {
                            if (sv.Billing_Field__c != 'Not Billable') {
                                billingStatus = 'Needs to be Billed';
                                break;
                            }
                        }
                        
                        if (billingStatus != 'Needs to be Billed' && csolMap.containsKey(c.Id)) {
                            for (AcctSeedERP__Sales_Order_Line__c sol :csolMap.get(c.Id)) {
                                if (sol.Tax_Category__c == 'Parts/Material') {
                                    billingStatus = 'Needs to be Billed';
                                    break;
                                }
                            }
                        }
                    }
                    */
                    
                    billingStatus = 'Not Billable';
                    if (cwoMap.containsKey(c.Id)) {
                        for (WorkOrder wo :cwoMap.get(c.Id)) {
                            if (wo.Billable__c == 'Yes') {
                                billingStatus = 'Needs to be Billed';
                                break;
                            }
                        }
                        
                        if (billingStatus != 'Needs to be Billed' && csolMap.containsKey(c.Id)) {
                            for (AcctSeedERP__Sales_Order_Line__c sol :csolMap.get(c.Id)) {
                                if (sol.Tax_Category__c == 'Parts/Material') {
                                    billingStatus = 'Needs to be Billed';
                                    break;
                                }
                            }
                        }
                    }
                }
                
                c.Billing_Status__c = billingStatus;
                system.debug('final bill status-->' + c.Billing_Status__c );
            }
            system.debug('this is update value' +caseCloseMap.values());
            update caseCloseMap.values();
        }
        //for (Case c :caseCloseMap.values()) {
        
        
         list<AggregateResult> getrectypecount = new list<AggregateResult>();
                                 getrectypecount  = ([select count(Id)countno, RecordTypeId ,ServiceContract_Case__c 
                        from Case where  ServiceContract_Case__c=:contractid and (RecordTypeid = '01234000000BnNj' or Recordtypeid='01234000000BnNk') and Billing_status__c ='In Process' and
                        (Case_End_Date__c  > :system.today().addYears(-2)) group by recordtypeid,ServiceContract_Case__c ]);
                // or Date_Case_Completed__c > :system.today().addYears(-2) 
                system.debug('CASE LIST final-->' +getrectypecount );
                contract updateconfields = new contract();
                system.debug('size' +getrectypecount.size());
                if (getrectypecount.size()>0){
                for(integer i=0;i<getrectypecount.size() ;i++ ){
               string recid = (string)getrectypecount[i].get('RecordTypeId');
               system.debug('recid' +recid);
               if (recid =='01234000000BnNjAAK'){
               system.debug('this is landsccaping');
                updateconfields.CY_Completed_Landscaping_Visits_Not_Bi__c = (integer)getrectypecount[i].get('countno');
                
                }
                if(recid  =='01234000000BnNkAAK'){
                system.debug('this is mow wash');
                  updateconfields.CY_Completed_Module_Wash_Visits_Not_Bill__c= (integer)getrectypecount[i].get('countno');  

                
                }
                
                
                
                
                }
                updateconfields.id=(string)getrectypecount[0].get('ServiceContract_Case__c') ;
                system.debug('final update list' +updateconfields );
                update updateconfields ;
                //break;
               } 
              // }
    }
    
    // Set various fields on the Case record from fields on the related Contract record
    // - before insert, before update
    public static void caseContractFields(List<Case> newList, Map<Id, Case> oldMap, Boolean isInsert) {
        Set<Id> cnFieldIds = new Set<Id>();
        Map<Id, Case> cnFieldCases = new Map<Id, Case>();
        Set<Id> cnLaborBillingIds = new Set<Id>();
        Map<Id, Case> cnLaborBillingCases = new Map<Id, Case>();
        Map<Id, Contract> cntrctMap = new Map<Id, Contract>();
        Map<Id, Contract> cntrctUpMap = new Map<Id, Contract>();
        system.debug('case newlist' +newlist);
        
        for (Case c :newList) {
        system.debug('CASE STATUS' +c.Status);
        //            system.debug('CASE OLD STATUS' +oldMap.get(c.Id).Status);
        //    system.debug('ServiceContract' +c.ServiceContract_Case__c);
            if (c.ServiceContract_Case__c != null) {
            system.debug('insert' +isInsert);
                if (isInsert) {
                system.debug('first condition' );
                    cnFieldIds.add(c.ServiceContract_Case__c);
                    //cnFieldCases.put(c.Id, c);
                    cnLaborBillingIds.add(c.ServiceContract_Case__c);
                   //cnLaborBillingCases.put(c.Id, c);
                } else {
                    if (c.ServiceContract_Case__c != oldMap.get(c.Id).ServiceContract_Case__c) {
                    system.debug('second condition' );
                        cnFieldIds.add(c.ServiceContract_Case__c);
                        cnFieldCases.put(c.Id, c);
                        cnLaborBillingIds.add(c.ServiceContract_Case__c);
                        cnLaborBillingCases.put(c.Id, c);
                    } else {
                    
                        if (c.Status != oldMap.get(c.Id).Status) {
                        system.debug('third condition' );
                            cnLaborBillingIds.add(c.ServiceContract_Case__c);
                            cnLaborBillingCases.put(c.Id, c);
                        }
                    }
                }
            } else {
            system.debug('final condition' );
                c.Contract_Type__c = null;
                c.Branch__c = null;
                c.Labor_Billing__c = null;
            }
        }
      //  SYSTEM.DEBUG('CNFIELDS-->' +cnFieldIds);
      //   SYSTEM.DEBUG('cnLaborBillingIds-->' +cnLaborBillingIds);
        
        
        if (!cnFieldIds.isEmpty() || !cnLaborBillingIds.isEmpty()) {
        SYSTEM.DEBUG('IF CONDITIONED-->');
            cntrctMap = new Map<Id, Contract>([select Id, Branch__c, O_M_Package__c, Type__c, Current_Year_Contract_Start__c, Current_Year_Contract_End__c, 
                    Primary_PM_Visits_Number__c, Secondary_PM_Visits_Number__c, Landscaping_Visits_Number__c, Module_Washings_Number__c, CY_Completed_Landscaping_Visits_Not_Bi__c,
                    CY_Completed_Primary_PM_Visits__c, CY_Completed_Secondary_PM_Visits__c, CY_Completed_Landscaping_Visits__c, CY_Completed_Module_Wash_Visits__c 
                    from Contract where Id in :cnFieldIds or Id in :cnLaborBillingIds]);
            
            // Get the related data for contract prepaid service visits
            String key;
            Map<Id, Case> completedCaseMap = new Map<Id, Case>();
            Map<Id, Schema.RecordTypeInfo> rtIdMap = Schema.SObjectType.Case.getRecordTypeInfosById();
            Set<Id> rtIds = new Set<Id>();
            Map<String, CaseContractLaborBilling__mdt> cclbMap = new Map<String, CaseContractLaborBilling__mdt>();
            Map<Id, Map<String, List<Case>>> completedContractCaseMap = new Map<Id, Map<String, List<Case>>>();
            Map<Id, SBQQ__Quote__c> caseQuoteMap = new Map<Id, SBQQ__Quote__c>();
            if (!cnLaborBillingCases.isEmpty()) {
                List<CaseContractLaborBilling__mdt> cclbList = [select Id, MasterLabel, Completed_Date__c, Maintenance_Type__c, RecordType_Name__c, Status__c, Visits_Number__c, Completed_Visits__c from CaseContractLaborBilling__mdt];
                for (CaseContractLaborBilling__mdt cclb :cclbList) {
                    cclbMap.put(cclb.RecordType_Name__c + '-' + cclb.Maintenance_Type__c, cclb);
                }
                
                // Get the primary quote records related to the cases
                List<SBQQ__Quote__c> quoteList = [select Id, Case__c, SBQQ__Primary__c, SBQQ__Status__c from SBQQ__Quote__c where Case__c in :cnLaborBillingCases.keySet() and SBQQ__Primary__c = true and SBQQ__Status__c = 'Accepted'];
                for (SBQQ__Quote__c q :quoteList) {
                    caseQuoteMap.put(q.Case__c, q);
                }
                
                // Determine the subset of cases where Labor_Billing__c will be set based upon contract prepaid visits
                
                for (Case c :cnLaborBillingCases.values()) {
                system.debug('look here 2-->' +c);
                    if (rtIdMap.containsKey(c.RecordTypeId)) {
                        key = rtIdMap.get(c.RecordTypeId).getName() + '-' + c.Maintenance_Type__c;
                        if (cclbMap.containsKey(key)) {
                         system.debug('look here 3-->' +cclbMap.get(key).Status__c);
                         system.debug('lok here 4-->' +cclbMap.get(key).Completed_Date__c);
                            if (c.Status == cclbMap.get(key).Status__c && c.get(cclbMap.get(key).Completed_Date__c) == null) {
                                completedCaseMap.put(c.Id, c);
                                rtIds.add(c.RecordTypeId);
                            }
                        }
                    }
                }
                
                system.debug('RECORD TYPE' +rtIds);
                
                // Determine number of completed cases so far for contract prepaid visits
                // Get the cases already completed during the contract calendar year
                system.debug('this is recordtypeids-->' +rtIds );
                Map<Id, Case> completedPreviousCaseMap = new Map<Id, Case>([select Id, RecordTypeId,Recordtype.name,Billing_Status__c, Date_Case_Completed__c, Date_Maintenance_Completed__c, Maintenance_Type__c, ServiceContract_Case__c 
                        from Case where RecordTypeId in :rtIds and ServiceContract_Case__c in :cnLaborBillingIds and (not Id in :completedCaseMap.keySet()) and 
                        (Date_Maintenance_Completed__c > :system.today().addYears(-2) or Date_Case_Completed__c > :system.today().addYears(-2))]);
                system.debug('CASE LIST-->' +completedPreviousCaseMap.values() );
                // Create map of completed cases for the contract calendar year
                Contract cntrct;
                Date completedDate;
                for (Case c :completedPreviousCaseMap.values()) {
                    key = rtIdMap.get(c.RecordTypeId).getName() + '-' + c.Maintenance_Type__c;
                    if (cclbMap.containsKey(key)) {
                        if (!completedContractCaseMap.containsKey(c.ServiceContract_Case__c)) {
                            completedContractCaseMap.put(c.ServiceContract_Case__c, new Map<String, List<Case>>());
                            completedContractCaseMap.get(c.ServiceContract_Case__c).put(key, new List<Case>());
                        }
                        
                        cntrct = cntrctMap.get(c.ServiceContract_Case__c);
                        completedDate = (Date)(c.get(cclbMap.get(key).Completed_Date__c));
                        if (completedDate >= cntrct.Current_Year_Contract_Start__c && completedDate <= cntrct.Current_Year_Contract_End__c) {
                            if (completedContractCaseMap.get(c.ServiceContract_Case__c).containsKey(key)) {
                                completedContractCaseMap.get(c.ServiceContract_Case__c).get(key).add(c);
                            }
                        }
                    }
                }
                
                
                
                
                /////update the count for the not billed landscaping amd mow-wash  cases in service contract
                // 
               /* system.debug('this is recordtype.name' +RecordType.name);
               list<AggregateResult> getrectypecount = new list<AggregateResult>();
                                 getrectypecount  = ([select count(Id)countno, RecordTypeId ,ServiceContract_Case__c 
                        from Case where  ServiceContract_Case__c in :cnLaborBillingIds and (RecordTypeid = '01234000000BnNj' or Recordtypeid='01234000000BnNk') and Billing_status__c ='In Process' and
                        (Case_End_Date__c  > :system.today().addYears(-2)) and (not Id in :completedCaseMap.keySet()) group by recordtypeid,ServiceContract_Case__c ]);
                // or Date_Case_Completed__c > :system.today().addYears(-2) 
                system.debug('CASE LIST final-->' +getrectypecount );
                contract updateconfields = new contract();
                system.debug('size' +getrectypecount.size());
                if (getrectypecount.size()>0){
                for(integer i=0;i<getrectypecount.size() ;i++ ){
               string recid = (string)getrectypecount[i].get('RecordTypeId');
               system.debug('recid' +recid);
               if (recid =='01234000000BnNjAAK'){
               system.debug('this is landsccaping');
                updateconfields.CY_Completed_Landscaping_Visits_Not_Bi__c = (integer)getrectypecount[i].get('countno');
                
                }
                if(recid  =='01234000000BnNkAAK'){
                system.debug('this is mow wash');
                  updateconfields.CY_Completed_Module_Wash_Visits_Not_Bill__c= (integer)getrectypecount[i].get('countno');  

                
                }
                
                
                
                
                }
                updateconfields.id=(string)getrectypecount[0].get('ServiceContract_Case__c') ;
                system.debug('final update list' +updateconfields );
                update updateconfields ;
               } */
            }
            
            // Set the various fields on cases from contract data including Labor_Billing__c
            Set<String> closedStatuses = getCaseClosedStatuses();
            Integer visitsNumber;
            Integer completedVisits;
            for (Case c :newList) {
                
                // Set the fields other than Labor_Billing__c
                if (cntrctMap.containsKey(c.ServiceContract_Case__c)) {
                    c.Contract_Type__c = cntrctMap.get(c.ServiceContract_Case__c).Type__c;
                    c.Branch__c = cntrctMap.get(c.ServiceContract_Case__c).Branch__c;
                }
                
                /*
                if (cnFieldCases.containsKey(c.Id)) {
                    c.Contract_Type__c = cntrctMap.get(c.ServiceContract_Case__c).Type__c;
                    c.Branch__c = cntrctMap.get(c.ServiceContract_Case__c).Branch__c;
                }
                */
                
                // Set the Labor_Billing__c field
                if (cnLaborBillingCases.containsKey(c.Id)) {
                    
                    if (completedCaseMap.containsKey(c.Id)) {
                        
                        // Cases that are subject to contract prepaid visits
                        // Add the case to our completed contract case map, set the Labor_Billing__c field, and update the number of completed visits
                        key = rtIdMap.get(c.RecordTypeId).getName() + '-' + c.Maintenance_Type__c;
                        if (!completedContractCaseMap.containsKey(c.ServiceContract_Case__c)) {
                            completedContractCaseMap.put(c.ServiceContract_Case__c, new Map<String, List<Case>>());
                            completedContractCaseMap.get(c.ServiceContract_Case__c).put(key, new List<Case>());
                        }
                        if (completedContractCaseMap.get(c.ServiceContract_Case__c).containsKey(key)) {
                            completedContractCaseMap.get(c.ServiceContract_Case__c).get(key).add(c);
                            visitsNumber = Integer.valueOf((Decimal)(cntrctMap.get(c.ServiceContract_Case__c).get(cclbMap.get(key).Visits_Number__c)));
                            completedVisits = completedContractCaseMap.get(c.ServiceContract_Case__c).get(key).size();
                            c.Labor_Billing__c = (completedVisits > visitsNumber || caseQuoteMap.containsKey(c.Id)) ? 'Billable' : 'Not Billable';
                            c.put(cclbMap.get(key).Completed_Date__c, system.today());
                            cntrctMap.get(c.ServiceContract_Case__c).put(cclbMap.get(key).Completed_Visits__c, completedVisits);
                            cntrctUpMap.put(c.ServiceContract_Case__c, cntrctMap.get(c.ServiceContract_Case__c));
                        }
                        
                    } else {
                        
                        // Cases that are not subject to contract prepaid visits
                        if ( (isInsert) || (c.ServiceContract_Case__c != oldMap.get(c.Id).ServiceContract_Case__c) || 
                             (c.Status != oldMap.get(c.Id).Status && closedStatuses.contains(c.Status)) ) {
                            
                            if (caseQuoteMap.containsKey(c.Id)) {
                                
                                c.Labor_Billing__c = 'Billable';
                                
                            } else {
                                
                                if (cntrctMap.get(c.ServiceContract_Case__c).Type__c == 'O&M') {
                                    
                                    if (cntrctMap.get(c.ServiceContract_Case__c).O_M_Package__c == 'Preventative') {
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Additional Services') {
                                            if (!closedStatuses.contains(c.Status)) {
                                                c.Labor_Billing__c = null;
                                            }
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Performance Investigation') {
                                            c.Labor_Billing__c = 'Billable';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Warranty') {
                                            c.Labor_Billing__c = 'O&M Warranty';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Reactive') {
                                            c.Labor_Billing__c = 'Billable';
                                        }
                                    }
                                    
                                    if (cntrctMap.get(c.ServiceContract_Case__c).O_M_Package__c == 'Comprehensive') {
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Additional Services') {
                                            if (!closedStatuses.contains(c.Status)) {
                                                c.Labor_Billing__c = null;
                                            }
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Performance Investigation') {
                                            c.Labor_Billing__c = 'Not Billable';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Warranty') {
                                            c.Labor_Billing__c = 'O&M Warranty';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Reactive') {
                                            c.Labor_Billing__c = 'Not Billable';
                                        }
                                    }
                                    
                                    if (cntrctMap.get(c.ServiceContract_Case__c).O_M_Package__c == 'T&M') {
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Additional Services') {
                                            if (!closedStatuses.contains(c.Status)) {
                                                c.Labor_Billing__c = null;
                                            }
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Performance Investigation') {
                                            c.Labor_Billing__c = 'Billable';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Warranty') {
                                            c.Labor_Billing__c = 'O&M Warranty';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Reactive') {
                                            c.Labor_Billing__c = 'Billable';
                                        }
                                    }
                                }
                                
                                if (cntrctMap.get(c.ServiceContract_Case__c).Type__c == 'Warranty/Construction') {
                                    if (rtIdMap.get(c.RecordTypeId).getName() == 'Warranty') {
                                        c.Labor_Billing__c = 'EPC Warranty';
                                    }
                                    if (rtIdMap.get(c.RecordTypeId).getName() == 'Preoperational Commissioning') {
                                        c.Labor_Billing__c = 'Bill EPC';
                                    }
                                    if (rtIdMap.get(c.RecordTypeId).getName() == 'Operational Commissioning') {
                                        c.Labor_Billing__c = 'Bill EPC';
                                    }
                                    if (rtIdMap.get(c.RecordTypeId).getName() == 'Construction Closeout') {
                                        c.Labor_Billing__c = 'Bill EPC';
                                    }
                                }
                                
                                if (cntrctMap.get(c.ServiceContract_Case__c).Type__c == 'Project') {
                                    if (cntrctMap.get(c.ServiceContract_Case__c).O_M_Package__c == 'Fixed Price') {
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Project') {
                                            c.Labor_Billing__c = 'Billable - Fixed Price';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Warranty') {
                                            c.Labor_Billing__c = 'O&M Warranty';
                                        }
                                    }
                                    
                                    if (cntrctMap.get(c.ServiceContract_Case__c).O_M_Package__c == 'T&M') {
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Project') {
                                            c.Labor_Billing__c = 'Billable';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Warranty') {
                                            c.Labor_Billing__c = 'O&M Warranty';
                                        }
                                    }
                                }
                                
                                if (cntrctMap.get(c.ServiceContract_Case__c).Type__c == 'Special Projects') {
                                    if (cntrctMap.get(c.ServiceContract_Case__c).O_M_Package__c == 'Fixed Price') {
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Special Projects') {
                                            c.Labor_Billing__c = 'Billable - Fixed Price';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Warranty') {
                                            c.Labor_Billing__c = 'O&M Warranty';
                                        }
                                    }
                                    
                                    if (cntrctMap.get(c.ServiceContract_Case__c).O_M_Package__c == 'T&M') {
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Special Projects') {
                                            c.Labor_Billing__c = 'Billable';
                                        }
                                        if (rtIdMap.get(c.RecordTypeId).getName() == 'Warranty') {
                                            c.Labor_Billing__c = 'O&M Warranty';
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            if (!cntrctUpMap.isEmpty()) {
                update cntrctUpMap.values();
            }
        }
    }
    
    /*
    // Set field Billing_Field__c on related Service Visit records when certain cases are closed
    // - after update
    public static void serviceVisitLaborBilling(Map<Id, Case> newMap, Map<Id, Case> oldMap) {
        Map<Id, Schema.RecordTypeInfo> rtIdMap = Schema.SObjectType.Case.getRecordTypeInfosById();
        Set<String> closedStatuses = getCaseClosedStatuses();
        Set<Id> cIds = new Set<Id>();
        
        // Create set of case Ids that meet our criteria
        for (Case c :newMap.values()) {
            if (rtIdMap.containsKey(c.RecordTypeId) && c.Status != oldMap.get(c.Id).Status) {
                if (closedStatuses.contains(c.Status)) {
                    if (rtIdMap.get(c.RecordTypeId).getName() == 'Project' && c.Contract_Type__c != 'Project') {
                        cIds.add(c.Id);
                    } else if (rtIdMap.get(c.RecordTypeId).getName() == 'Landscaping') {
                        cIds.add(c.Id);
                    } else if (rtIdMap.get(c.RecordTypeId).getName() == 'Module Washing') {
                        cIds.add(c.Id);
                    }
                } else if (c.Status == 'Completed') {
                    if (rtIdMap.get(c.RecordTypeId).getName() == 'Maintenance Case') {
                        cIds.add(c.Id);
                    }
                }
            }
        }
        
        // Set field Billing_Field__c of related Service Visit records
        if (!cIds.isEmpty()) {
            List<SV__c> svList = new List<SV__c>();
            List<SV__c> svUpList = new List<SV__c>();
            svList = [select Id, Case__c, Billing_Field__c from SV__c where Case__c in :cIds];
            for (SV__c sv :svList) {
                if (newMap.containsKey(sv.Case__c)) {
                    sv.Billing_Field__c = newMap.get(sv.Case__c).Labor_Billing__c;
                    svUpList.add(sv);
                }
            }
            
            if (!svUpList.isEmpty()) {
                update svUpList;
            }
        }
    }
    */
    
    // Returns all of the closed Status values
    public static Set<String> getCaseClosedStatuses() {
        Set<String> closedStatuses = new Set<String>();
        for (CaseStatus cs: [select Id, IsClosed, MasterLabel from CaseStatus where IsClosed = true]) {
            closedStatuses.add(cs.MasterLabel);
        }
        
        return closedStatuses;
    }
    
    /*
    // Sets the Labor Billing field on completed cases based upon the number of service visits built into the contract
    // - before update
    public static void laborBillingCaseContract(List<Case> newList, Map<Id, Case> oldMap) {
        Set<Id> cntrctIds = new Set<Id>();
        Map<Id, Case> completedCaseMap = new Map<Id, Case>();
        Map<Id, Schema.RecordTypeInfo> rtIdMap = Schema.SObjectType.Case.getRecordTypeInfosById();
        //Map<String, Schema.RecordTypeInfo> rtNameMap = Schema.SObjectType.Case.getRecordTypeInfosByName();
        Set<Id> rtIds = new Set<Id>();
        
        List<CaseContractLaborBilling__mdt> cclbList = [select Id, MasterLabel, Completed_Date__c, Maintenance_Type__c, RecordType_Name__c, Status__c, Visits_Number__c from CaseContractLaborBilling__mdt];
        Map<String, CaseContractLaborBilling__mdt> cclbMap = new Map<String, CaseContractLaborBilling__mdt>();
        for (CaseContractLaborBilling__mdt cclb :cclbList) {
            cclbMap.put(cclb.RecordType_Name__c + '-' + cclb.Maintenance_Type__c, cclb);
        }
        
        // Determine the subset of cases that have just been completed
        String key;
        for (Case c :newList) {
            if (c.Status != oldMap.get(c.Id).Status && rtIdMap.containsKey(c.RecordTypeId) && c.ServiceContract_Case__c != null) {
                key = rtIdMap.get(c.RecordTypeId).getName() + '-' + c.Maintenance_Type__c;
                if (cclbMap.containsKey(key)) {
                    if (c.Status == cclbMap.get(key).Status__c && c.get(cclbMap.get(key).Completed_Date__c) == null) {
                        c.put(cclbMap.get(key).Completed_Date__c, system.today());
                        cntrctIds.add(c.ServiceContract_Case__c);
                        completedCaseMap.put(c.Id, c);
                        rtIds.add(c.RecordTypeId);
                    }
                }
            }
        }
        
        //system.debug('***** completedCaseMap.keySet = ' + completedCaseMap.keySet());
        
        if (!cntrctIds.isEmpty()) {
            
            // Get the contracts related to the cases that need to have the Labor Billing field set
            Map<Id, Contract> cntrctMap = new Map<Id, Contract>([select Id, Current_Year_Contract_Start__c, Current_Year_Contract_End__c, 
                    Primary_PM_Visits_Number__c, Secondary_PM_Visits_Number__c, Landscaping_Visits_Number__c, Module_Washings_Number__c 
                    from Contract where Id in :cntrctIds]);
            
            // Get the cases already completed during the contract calendar year
            Map<Id, Case> completedPreviousCaseMap = new Map<Id, Case>([select Id, RecordTypeId, Date_Case_Completed__c, Date_Maintenance_Completed__c, Maintenance_Type__c, ServiceContract_Case__c 
                    from Case where RecordTypeId in :rtIds and ServiceContract_Case__c in :cntrctMap.keySet() and (not Id in :completedCaseMap.keySet()) and 
                    (Date_Maintenance_Completed__c > :system.today().addYears(-2) or Date_Case_Completed__c > :system.today().addYears(-2))]);
            
            // Create map of completed cases for the contract calendar year, first add the case previously completed
            Map<Id, Map<String, List<Case>>> completedContractCaseMap = new Map<Id, Map<String, List<Case>>>();
            Contract cntrct;
            Date completedDate;
            for (Case c :completedPreviousCaseMap.values()) {
                key = rtIdMap.get(c.RecordTypeId).getName() + '-' + c.Maintenance_Type__c;
                if (cclbMap.containsKey(key)) {
                    if (!completedContractCaseMap.containsKey(c.ServiceContract_Case__c)) {
                        completedContractCaseMap.put(c.ServiceContract_Case__c, new Map<String, List<Case>>());
                        completedContractCaseMap.get(c.ServiceContract_Case__c).put(key, new List<Case>());
                    }
                    
                    cntrct = cntrctMap.get(c.ServiceContract_Case__c);
                    completedDate = (Date)(c.get(cclbMap.get(key).Completed_Date__c));
                    if (completedDate >= cntrct.Current_Year_Contract_Start__c && completedDate <= cntrct.Current_Year_Contract_End__c) {
                        if (completedContractCaseMap.get(c.ServiceContract_Case__c).containsKey(key)) {
                            completedContractCaseMap.get(c.ServiceContract_Case__c).get(key).add(c);
                        }
                    }
                }
            }
            
            // Now add the cases completed just now
            for (Case c :completedCaseMap.values()) {
                key = rtIdMap.get(c.RecordTypeId).getName() + '-' + c.Maintenance_Type__c;
                if (!completedContractCaseMap.containsKey(c.ServiceContract_Case__c)) {
                    completedContractCaseMap.put(c.ServiceContract_Case__c, new Map<String, List<Case>>());
                    completedContractCaseMap.get(c.ServiceContract_Case__c).put(key, new List<Case>());
                }
                if (completedContractCaseMap.get(c.ServiceContract_Case__c).containsKey(key)) {
                    completedContractCaseMap.get(c.ServiceContract_Case__c).get(key).add(c);
                }
            }
            
            //system.debug('***** completedContractCaseMap = ' + completedContractCaseMap);
            
            // Set the Labor Billing field appropriately
            Integer visitsNumber;
            for (Case c :completedCaseMap.values()) {
                key = rtIdMap.get(c.RecordTypeId).getName() + '-' + c.Maintenance_Type__c;
                if (completedContractCaseMap.containsKey(c.ServiceContract_Case__c) && completedContractCaseMap.get(c.ServiceContract_Case__c).containsKey(key)) {
                    visitsNumber = Integer.valueOf((Decimal)(cntrctMap.get(c.ServiceContract_Case__c).get(cclbMap.get(key).Visits_Number__c)));
                    
                    //system.debug('***** visitsNumber = ' + visitsNumber);
                    
                    if (completedContractCaseMap.get(c.ServiceContract_Case__c).get(key).size() > visitsNumber) {
                        c.Labor_Billing__c = 'Billable';
                    } else {
                        c.Labor_Billing__c = 'Not Billable';
                    }
                }
            }
        }
    }
    */
}