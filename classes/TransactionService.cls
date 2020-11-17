public class TransactionService {
    
    /*
     *  Service methods for TransactionTrigger_BS.trigger
     *
     */
    
    // Set various fields on Transaction records from related records
    // - before insert, before update
    public static void relatedRecordFields(List<AcctSeed__Transaction__c> newList, Map<Id, AcctSeed__Transaction__c> oldMap, Boolean isInsert) {
        Set<Id> aplIds = new Set<Id>();
        Set<Id> projIds = new Set<Id>();
        Set<Id> accIds = new Set<Id>();
        Set<Id> jelIds = new Set<Id>();
        Set<Id> bilIds = new Set<Id>();
        system.debug('this is newlist--->'  +newlist);
       
        for (AcctSeed__Transaction__c t :newList) {
         system.debug('this is bill id start-->' +t.AcctSeed__Billing_Line__c);
        if (t.AcctSeed__Journal_Entry_Line__c != null) {
           /*     if (isInsert) {
                    jelIds.add(t.AcctSeed__Journal_Entry_Line__c);
                } else {
                    if (t.AcctSeed__Journal_Entry_Line__c != oldMap.get(t.Id).AcctSeed__Journal_Entry_Line__c) {
                        jelIds.add(t.AcctSeed__Journal_Entry_Line__c);
                    }
                } */
             jelIds.add(t.AcctSeed__Journal_Entry_Line__c);
            }
            system.debug('jelids look-->' +jelids);
            if (t.AcctSeed__Billing_Line__c!= null) {
          /*      if (isInsert) {
                    bilIds.add(t.AcctSeed__Billing_Line__c);
                } else {
                    if (t.AcctSeed__Billing_Line__c!= oldMap.get(t.Id).AcctSeed__Billing_Line__c) {
                        bilIds.add(t.AcctSeed__Billing_Line__c);
                    }
                } */
              bilIds.add(t.AcctSeed__Billing_Line__c);  
            }
            system.debug('this is bill id-->' +bilIds);
            if (t.AcctSeed__Account_Payable_Line__c != null) {
                if (isInsert) {
                    aplIds.add(t.AcctSeed__Account_Payable_Line__c);
                } else {
                    if (t.AcctSeed__Account_Payable_Line__c != oldMap.get(t.Id).AcctSeed__Account_Payable_Line__c) {
                        aplIds.add(t.AcctSeed__Account_Payable_Line__c);
                    }
                }
            }
            
            if (t.AcctSeed__Project__c != null) {
                if (isInsert) {
                    projIds.add(t.AcctSeed__Project__c);
                } else {
                    if (t.AcctSeed__Project__c != oldMap.get(t.Id).AcctSeed__Project__c) {
                        projIds.add(t.AcctSeed__Project__c);
                    }
                }
            }
            
            if (t.AcctSeed__Account__c != null) {
                if (isInsert) {
                    accIds.add(t.AcctSeed__Account__c);
                } else {
                    if (t.AcctSeed__Account__c != oldMap.get(t.Id).AcctSeed__Account__c) {
                        accIds.add(t.AcctSeed__Account__c);
                    }
                }
            }
        }
        
        Map<Id, AcctSeed__Project__c> projMap;
        if (!projIds.isEmpty()) {
            projMap = new Map<Id, AcctSeed__Project__c>([select Id, O_M_Manager__c from AcctSeed__Project__c where Id in :projIds]);
        } else {
            projMap = new Map<Id, AcctSeed__Project__c>();
        }
        
        Map<Id, Account> accMap;
        if (!accIds.isEmpty()) {
            accMap = new Map<Id, Account>([select Id, ParentId from Account where Id in :accIds]);
        } else {
            accMap = new Map<Id, Account>();
        }
        
        Map<Id, AcctSeed__Account_Payable_Line__c> aplMap;
        Map<Id, AcctSeedERP__Purchase_Order_Line__c> polMap;
        Map<Id, AcctSeedERP__Sales_Order_Line__c> solMap;
        Map<Id, SV__c> svMap;
        Map<Id, Workorder> WoMap;
        Map<Id, Case> caseMap;
        Map<Id, AcctSeed__Journal_Entry_Line__c> jelmap;
        Map<Id, AcctSeed__Billing_Line__c> bilmap;
         if (!bilIds.isEmpty()) {
            bilmap= new Map<Id, AcctSeed__Billing_Line__c>([select Id, Case__c,WorkOrder__c  from AcctSeed__Billing_Line__c where Id in :bilIds]);
            Set<Id> caseids1= new Set<Id>();
            Set<Id> workorderids1= new Set<Id>();
            for (AcctSeed__Billing_Line__c bil :bilmap.values()) {
                if (bil.Case__c != null) {
                    caseids1.add(bil.Case__c );
                }
                if (bil.WorkOrder__c!= null) {
                    workorderids1.add(bil.WorkOrder__c);
                }
            }
            }
            else
            {
            aplMap = new Map<Id, AcctSeed__Account_Payable_Line__c>();
            polMap = new Map<Id, AcctSeedERP__Purchase_Order_Line__c>();
            solMap = new Map<Id, AcctSeedERP__Sales_Order_Line__c>();
            svMap = new Map<Id, SV__c>();
            WoMap = new Map<Id, WorkOrder>();
            caseMap = new Map<Id, Case>();
                if (test.isRunningTest()){
                    jelmap=new Map<Id,AcctSeed__Journal_Entry_Line__c>();
                }
            //
            }
            system.debug('this is bilmap-->' +bilmap );
        
        if (!jelIds.isEmpty()) {
            jelmap = new Map<Id, AcctSeed__Journal_Entry_Line__c>([select Id, Case__c,WorkOrder__c from AcctSeed__Journal_Entry_Line__c where Id in :jelIds]);
            Set<Id> caseids= new Set<Id>();
            Set<Id> workorderids= new Set<Id>();
            for (AcctSeed__Journal_Entry_Line__c jel :jelMap.values()) {
                if (jel.Case__c != null) {
                    caseids.add(jel.Case__c );
                }
                if (jel.WorkOrder__c!= null) {
                    workorderids.add(jel.WorkOrder__c);
                }
            }
            }else{
            aplMap = new Map<Id, AcctSeed__Account_Payable_Line__c>();
            polMap = new Map<Id, AcctSeedERP__Purchase_Order_Line__c>();
            solMap = new Map<Id, AcctSeedERP__Sales_Order_Line__c>();
            svMap = new Map<Id, SV__c>();
            WoMap = new Map<Id, WorkOrder>();
            caseMap = new Map<Id, Case>();
                if (test.isRunningTest()){
                    bilmap=new Map<Id,AcctSeed__Billing_Line__c>();
                }
            //bilmap=new Map<Id,AcctSeed__Billing_Line__c>();
        }
        
            
        if (!aplIds.isEmpty()) {
            aplMap = new Map<Id, AcctSeed__Account_Payable_Line__c>([select Id, AcctSeedERP__Purchase_Order_Line__c from AcctSeed__Account_Payable_Line__c where Id in :aplIds]);
            Set<Id> polIds = new Set<Id>();
            for (AcctSeed__Account_Payable_Line__c apl :aplMap.values()) {
                if (apl.AcctSeedERP__Purchase_Order_Line__c != null) {
                    polIds.add(apl.AcctSeedERP__Purchase_Order_Line__c);
                }
            }
            
            if (!polIds.isEmpty()) {
                polMap = new Map<Id, AcctSeedERP__Purchase_Order_Line__c>([select Id, Construction_Req__c from AcctSeedERP__Purchase_Order_Line__c where Id in :polIds]);
                Set<Id> solIds = new Set<Id>();
                for (AcctSeedERP__Purchase_Order_Line__c pol :polMap.values()) {
                    if (pol.Construction_Req__c != null) {
                        solIds.add(pol.Construction_Req__c);
                    }
                }
                
                if (!solIds.isEmpty()) {
                    solMap = new Map<Id, AcctSeedERP__Sales_Order_Line__c>([select Id, Service_Visit__c,WorkOrder__c from AcctSeedERP__Sales_Order_Line__c where Id in :solIds]);
                    Set<Id> svIds = new Set<Id>();
                    Set<Id> woIds = new Set<Id>();
                    for (AcctSeedERP__Sales_Order_Line__c sol :solMap.values()) {
                        if (sol.Service_Visit__c != null) {
                            svIds.add(sol.Service_Visit__c);
                        }
                        
                        if (sol.WorkOrder__c !=null){
                             woIds.add(sol.WorkOrder__c);
                        }
                    }
                    
                    if (!svIds.isEmpty()) {
                        svMap = new Map<Id, SV__c>([select Id, Case__c, Contract__c from SV__c where Id in :svIds]);
                        Set<Id> cIds = new Set<Id>();
                        for (SV__c sv :svMap.values()) {
                            if (sv.Case__c != null) {
                                cIds.add(sv.Case__c);
                            }
                        }
                        
                        if (!cIds.isEmpty()) {
                            caseMap = new Map<Id, Case>([select Id, Status, ClosedDate from Case where Id in :cIds]);
                        } else {
                            caseMap = new Map<Id, Case>();
                        }
                    }
                    /// Adding the logic for Workorder to add in transaction (MG 6/20/2019)//// 
                    
                    if (!woIds.isEmpty()) {
                        woMap = new Map<Id, WorkOrder>([select Id, CaseId, Contract__c from WorkOrder where Id in :woIds]);
                        Set<Id> cIds = new Set<Id>();
                        for (WorkOrder wo :woMap.values()) {
                            if (wo.CaseId != null) {
                                cIds.add(wo.CaseId);
                            }
                        }
                        
                        if (!cIds.isEmpty()) {
                            caseMap = new Map<Id, Case>([select Id, Status, ClosedDate from Case where Id in :cIds]);
                        } else {
                            caseMap = new Map<Id, Case>();
                        }
                    }
                 ///////   
                     else {
                        svMap = new Map<Id, SV__c>();
                        WoMap = new Map<Id, WorkOrder>();
                        caseMap = new Map<Id, Case>();
                    }
                } else {
                    solMap = new Map<Id, AcctSeedERP__Sales_Order_Line__c>();
                    svMap = new Map<Id, SV__c>();
                    WoMap = new Map<Id, WorkOrder>();
                    caseMap = new Map<Id, Case>();
                }
            } else {
                polMap = new Map<Id, AcctSeedERP__Purchase_Order_Line__c>();
                solMap = new Map<Id, AcctSeedERP__Sales_Order_Line__c>();
                svMap = new Map<Id, SV__c>();
                WoMap = new Map<Id, WorkOrder>();
                caseMap = new Map<Id, Case>();
            }
        } else {
            aplMap = new Map<Id, AcctSeed__Account_Payable_Line__c>();
            polMap = new Map<Id, AcctSeedERP__Purchase_Order_Line__c>();
            solMap = new Map<Id, AcctSeedERP__Sales_Order_Line__c>();
            svMap = new Map<Id, SV__c>();
            WoMap = new Map<Id, WorkOrder>();
            caseMap = new Map<Id, Case>();
        }
        
        
        
        // Update all of the new/changed values
        for (AcctSeed__Transaction__c t :newList) {
        system.debug('entering loop1');
            
            if (projMap.containsKey(t.AcctSeed__Project__c)) {
                t.O_M_Mgr__c = projMap.get(t.AcctSeed__Project__c).O_M_Manager__c;
            }
            
            if (accMap.containsKey(t.AcctSeed__Account__c)) {
                t.Parent_Account__c = accMap.get(t.AcctSeed__Account__c).ParentId;
            }
            system.debug('entering loop2' +t.AcctSeed__Journal_Entry_Line__c);
            
            if(t.AcctSeed__Journal_Entry_Line__c!=null)
            {
            
            
                        
             if (jelMap.containsKey(t.AcctSeed__Journal_Entry_Line__c)) {
                        t.Case__c = jelMap.get(t.AcctSeed__Journal_Entry_Line__c).Case__c;
                        t.WorkOrder__c=jelMap.get(t.AcctSeed__Journal_Entry_Line__c).WorkOrder__c;
                        }
                        }
                        
                        SYSTEM.DEBUG('THIS IS CASE' +t.Case__c);
                        SYSTEM.DEBUG('THIS IS WO' + t.WorkOrder__c);
                        
                        
                        system.debug('entering loop3' +t.AcctSeed__Billing_Line__c);
                        system.debug('entering loop4' +bilMap);
                        
                        
                       if(t.AcctSeed__Billing_Line__c!=null)
                       {
                           system.debug(bilMap.containsKey(t.AcctSeed__Billing_Line__c));
                   if (bilMap.containsKey(t.AcctSeed__Billing_Line__c)) {
                        system.debug('entering loop');
                        t.Case__c = bilMap.get(t.AcctSeed__Billing_Line__c).Case__c;
                        system.debug('case' +t.Case__c);
                        t.WorkOrder__c=bilMap.get(t.AcctSeed__Billing_Line__c).WorkOrder__c  ;
                        }
                       }
                       
                        SYSTEM.DEBUG('THIS IS CASE' +t.Case__c);
                        SYSTEM.DEBUG('THIS IS WO' + t.WorkOrder__c);
                        
            
            if (aplMap.containsKey(t.AcctSeed__Account_Payable_Line__c)) {
                t.POL__c = aplMap.get(t.AcctSeed__Account_Payable_Line__c).AcctSeedERP__Purchase_Order_Line__c;
                
                if (polMap.containsKey(t.POL__c)) {
                    t.SOL__c = polMap.get(t.POL__c).Construction_Req__c;
                    
                    if (solMap.containsKey(t.SOL__c)) {
                        t.SV__c = solMap.get(t.SOL__c).Service_Visit__c;
                        t.WorkOrder__c = solMap.get(t.SOL__c).WorkOrder__c;
                        
                        
                        
                    /*    if (bilMap.containsKey(t.AcctSeed__Billing_Line__c)) {
                        system.debug('entering loop');
                        t.Case__c = bilMap.get(t.AcctSeed__Billing_Line__c).Case__c;
                        system.debug('case' +t.Case__c);
                        t.WorkOrder__c=bilMap.get(t.AcctSeed__Billing_Line__c).Work_Order__c ;
                        } */
               /*         if (svMap.containsKey(t.SV__c)) {
                            t.Case__c = svMap.get(t.SV__c).Case__c;
                            t.Contract__c = svMap.get(t.SV__c).Contract__c;
                            
                            if (caseMap.containsKey(t.Case__c)) {
                                t.Case_Status__c = caseMap.get(t.Case__c).Status;
                                t.Case_Closed_Date__c = caseMap.get(t.Case__c).ClosedDate;
                            }
                        }   Commenting line since no SV and throwing null exceptions */
                        
                        ///updatin Logic to add Work order and related case and Contract (MG 6/20/2019)
                        
                        if (woMap.containsKey(t.WorkOrder__c )) {
                            t.Case__c = WoMap.get(t.WorkOrder__c ).CaseId;
                            t.Contract__c = WoMap.get(t.WorkOrder__c ).Contract__c;
                            
                            if (caseMap.containsKey(t.Case__c)) {
                                t.Case_Status__c = caseMap.get(t.Case__c).Status;
                                t.Case_Closed_Date__c = caseMap.get(t.Case__c).ClosedDate;
                            }
                            }
                       
                        
                        
                        
                        ////
                        
                    }
                    
                    
                }
            }
            
            // If any of the lookup fields are null, set the dependent fields null
            if (t.AcctSeed__Project__c == null) {
                t.O_M_Mgr__c = null;
            }
            
            if (t.AcctSeed__Account__c == null) {
                t.Parent_Account__c = null;
            }
            
            if (t.AcctSeed__Account_Payable_Line__c == null) {
                t.POL__c = null;
                t.SOL__c = null;
                t.SV__c = null;
               // t.workorder__c=null;
               // t.Case__c = null;
                t.Case_Status__c = '';
                t.Case_Closed_Date__c = null;
                t.Contract__c = null;
            } else {
                if (t.POL__c == null) {
                    t.SOL__c = null;
                    t.SV__c = null;
                 //   t.workorder__c=null;
                 //   t.Case__c = null;
                    t.Case_Status__c = '';
                    t.Case_Closed_Date__c = null;
                    t.Contract__c = null;
                } else {
                    if (t.SOL__c == null) {
                        t.SV__c = null;
                     //   t.workorder__c=null;
                      //  t.Case__c = null;
                        t.Case_Status__c = '';
                        t.Case_Closed_Date__c = null;
                        t.Contract__c = null;
                    } else {
                        if (t.SV__c == null) {
                       //     t.Case__c = null;
                              t.Case_Status__c = '';
                              t.Case_Closed_Date__c = null;
                              t.Contract__c = null;
                        } else {
                            if (t.Case__c == null) {
                                t.Case_Status__c = '';
                                t.Case_Closed_Date__c = null;
                            }
                        }
                    }
                }
            }
        }
    }
}