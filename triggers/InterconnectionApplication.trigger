trigger InterconnectionApplication on Interconnection_Application__c (after insert, after update, before insert, before update) {
    
    /*
     *  Before Insert and Update
     *      - Set Expected ISA Date
     *      - Set Next Milestone Date
     *
     *  Before Insert
     *      - Set field 'Assigned Apps Engineer' to the value in the related Opportunity field 'Assigned Apps Engineer'.
     *
     *  After Insert
     *      - Set the Interconnection Status field of the related Site record to the value of the Status field
     *
     *  After Update
     *      - If Status field has been set to 'Permission To Operate', set the 'PTO Date' field on the related Site record.
     *      - Set the Interconnection Status field of the related Site record to the value of the Status field
     *
     */
    
    if (trigger.isBefore) {
        Set<Id> pIds = new Set<Id>();
        Date baseDate = null;
        String baseDateField = '';
        Decimal additionalDays = 0;
        Decimal offsetDays = 0;
        Boolean calculateISA = false;
        String isaMapKey;
        String nmdMapKey;
        Map<String, Expected_ISA_Date__c> isaMap = Expected_ISA_Date__c.getAll();
        Map<String, Next_Milestone_Date__c> nextMilestoneDateMap = Next_Milestone_Date__c.getAll();
        
        Map<String, Next_Milestone_Date__c> nmdMap = new Map<String, Next_Milestone_Date__c>();
        for (Next_Milestone_Date__c nmd :nextMilestoneDateMap.values()) {
            nmdMapKey = '';
            if (String.isNotBlank(nmd.Status__c)) {
                nmdMapKey += nmd.Status__c;
            }
            if (String.isNotBlank(nmd.Application_Type__c)) {
                nmdMapKey += nmd.Application_Type__c;
            }
            nmdMap.put(nmdMapKey, nmd);
        }
        
        for (Interconnection_Application__c ia :trigger.new) {
            
            // Determine if we need to set the Expected ISA Date
            calculateISA = false;
            if (!ia.Override_Expected_ISA_Date__c) {
                if (ia.Executed_ISA__c == null) {
                    if (String.isNotBlank(ia.Application_Type__c) && String.isNotBlank(ia.Status__c)) {
                        
                        isaMapKey = ia.Application_Type__c.substring(0, 4) + '-' + ia.Status__c;
                        if (isaMapKey.length() > 35) {
                            isaMapKey = isaMapKey.substring(0, 35);
                        }
                        
                        if (isaMap.containsKey(isaMapKey)) {
                            baseDateField = isaMap.get(isaMapKey).Base_Date_Field__c;
                            if (trigger.isInsert) {
                                calculateISA = true;
                            } else {
                                if ( ia.Application_Type__c != trigger.oldMap.get(ia.Id).Application_Type__c || 
                                     ia.Status__c != trigger.oldMap.get(ia.Id).Status__c || ia.Recalculate__c || 
                                     ia.Override_Expected_ISA_Date__c != trigger.oldMap.get(ia.Id).Override_Expected_ISA_Date__c || 
                                     Date.valueOf(ia.get(baseDateField)) != Date.valueOf(trigger.oldMap.get(ia.Id).get(baseDateField)) ) {
                                    calculateISA = true;
                                }
                            }
                        }
                    } else {
                        ia.Expected_ISA_Date__c = null;
                    }
                } else {
                    ia.Expected_ISA_Date__c = null;
                }
            }
            
            if (calculateISA) {
                if (isaMap.get(isaMapKey).Detailed_Study__c) {
                    if (ia.Detailed_Study__c != 'Yes') {
                        calculateISA = false;
                    }
                }
            }
            
            // Calculate the new Expected ISA Date
            if (calculateISA) {
                additionalDays = 0;
                if (ia.Additional_Days__c != null) {
                    additionalDays = ia.Additional_Days__c;
                }
                
                offsetDays = isaMap.get(isaMapKey).Offset_Days__c;
                baseDate = Date.valueOf(ia.get(baseDateField));
                
                if (ia.Application_Type__c == isaMap.get(isaMapKey).Application_Type__c) {
                    if (ia.Status__c == isaMap.get(isaMapKey).Status__c) {
                        if (baseDate == null) {
                            ia.Expected_ISA_Date__c = null;
                        } else {
                            if (isaMap.get(isaMapKey).Use_Today__c) {
                                baseDate = system.today();
                            }
                            ia.Expected_ISA_Date__c = baseDate.addDays(Integer.valueOf(offsetDays + additionalDays));
                        }
                    }
                }
            }
            
            // Calculate the Next Milestone Date
            nmdMapKey = '';
            if (String.isNotBlank(ia.Status__c)) {
                nmdMapKey += ia.Status__c;
            }
            if (nmdMapKey != 'Application Requested' && String.isNotBlank(ia.Application_Type__c)) {
                nmdMapKey += ia.Application_Type__c;
            }
            
            if (nmdMap.containsKey(nmdMapKey)) {
                additionalDays = 0;
                if (ia.Additional_Days__c != null) {
                    additionalDays = ia.Additional_Days__c;
                }
                
                offsetDays = nmdMap.get(nmdMapKey).Offset_Days__c;
                baseDate = Date.valueOf(ia.get(nmdMap.get(nmdMapKey).Base_Date_Field__c));
                if (baseDate != null) {
                    ia.Next_Milestone_Date_New__c = baseDate.addDays(Integer.valueOf(offsetDays + additionalDays));
                } else {
                    ia.Next_Milestone_Date_New__c = null;
                }
            } else {
                ia.Next_Milestone_Date_New__c = null;
            }
            
            if (trigger.isInsert && ia.ASProject__c != null) {
                pIds.add(ia.ASProject__c);
            }
        }
        
        if (!pIds.isEmpty()) {
            Map<Id, AcctSeed__Project__c> pMap = new Map<Id, AcctSeed__Project__c>([select Id, AcctSeed__Opportunity__r.Assigned_Apps_Engineer__c from AcctSeed__Project__c where Id in :pIds]);
            for (Interconnection_Application__c ia :trigger.new) {
                if (pMap.containsKey(ia.ASProject__c)) {
                    ia.Assigned_Apps_Engineer__c = pMap.get(ia.ASProject__c).AcctSeed__Opportunity__r.Assigned_Apps_Engineer__c;
                }
            }
        }
    }
    
    if (trigger.isAfter) {
       // Map<String, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Interconnection_Application__c.getRecordTypeInfosByName();
        Set<Id> sIds = new Set<Id>();
        for (Interconnection_Application__c ia :trigger.new) {
            
            if (ia.Site__c != null) {
                if (trigger.isInsert) {
                    sIds.add(ia.Site__c);
                }
                if (trigger.isUpdate) {
                    if (ia.Status__c != trigger.oldMap.get(ia.Id).Status__c) {
                        sIds.add(ia.Site__c);
                    }
                }
            }
        }
        
        if (!sIds.isEmpty()) {
            Map<Id, Site__c> sMap = new Map<Id, Site__c>([select Id, Interconnection_Status__c, New_Comments_on_Schedule__c, PTO_Date__c from Site__c where Id in :sIds]);
            for (Interconnection_Application__c ia :trigger.new) {
                if (sMap.containsKey(ia.Site__c)) {
                    sMap.get(ia.Site__c).Interconnection_Status__c = ia.Status__c;
                    
                    if (trigger.isUpdate) {
                        if (ia.Status__c == 'Permission To Operate' && trigger.oldMap.get(ia.Id).Status__c != 'Permission To Operate') {
                            sMap.get(ia.Site__c).PTO_Date__c = system.today();
                            sMap.get(ia.Site__c).New_Comments_on_Schedule__c = String.valueOf(system.today()) + ': Interconnection Status set to Permission To Operate - PTO Date set.';
                        }
                    }
                }
            }
            update sMap.values();
        }
    }
}
//&& (ia.RecordTypeId == rtMap.get('All Applications').getRecordTypeId())) || (ia.Site__c != null && (ia.RecordTypeId == rtMap.get('CA-Fast Track').getRecordTypeId())))