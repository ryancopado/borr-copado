public class BillingLineService {
    
    /*
     *  Service methods for BillingLineTrigger.trigger.
     *
     */
    
    // Keep the new and old Project Task look up fields up to date
    // - before insert, before update
    public static void blsProjectTask(List<AcctSeed__Billing_Line__c> newList, Map<Id, AcctSeed__Billing_Line__c> oldMap, Boolean isInsert) {
        
        if (isInsert) {
            
            for (AcctSeed__Billing_Line__c bl :newList) {
                if (bl.AcctSeed__Project_Task__c != null) {
                    bl.Project_Task__c = bl.AcctSeed__Project_Task__c;
                } else {
                    if (bl.Project_Task__c != null ) {
                        bl.AcctSeed__Project_Task__c = bl.Project_Task__c;
                    }
                }
            }
            
        } else {
            
            for (AcctSeed__Billing_Line__c bl :newList) {
                if (bl.AcctSeed__Project_Task__c != oldMap.get(bl.Id).AcctSeed__Project_Task__c) {
                    bl.Project_Task__c = bl.AcctSeed__Project_Task__c;
                } else {
                    if (bl.Project_Task__c != oldMap.get(bl.Id).Project_Task__c) {
                        bl.AcctSeed__Project_Task__c = bl.Project_Task__c;
                    }
                }
            }
        }
    }
    
    // Set Taxable based upon the value of the Tax Category field and the Tax Group record referenced by the related Billing record.
    // - before insert, before update
    public static void blsTaxable(List<AcctSeed__Billing_Line__c> newList, Map<Id, AcctSeed__Billing_Line__c> oldMap, Boolean isInsert) {
        Set<Id> bIds = new Set<Id>();
        Map<Id, AcctSeed__Billing_Line__c> billingLineMap = new Map<Id, AcctSeed__Billing_Line__c>();
        
        if (isInsert) {
            
            for (AcctSeed__Billing_Line__c bl :newList) {
                bIds.add(bl.AcctSeed__Billing__c);
                billingLineMap.put(bl.Id, bl);
            }
            
        } else {
            
            for (AcctSeed__Billing_Line__c bl :newList) {
                if (bl.Category__c != oldMap.get(bl.Id).Category__c) {
                    if (String.isBlank(bl.Category__c)) {
                        bl.Taxable__c = false;
                    } else {
                        bIds.add(bl.AcctSeed__Billing__c);
                        billingLineMap.put(bl.Id, bl);
                    }
                }
            }
        }
        
        // Set the Taxable field based upon Tax Category and the Tax Group record of he Billing record
        if (!bIds.isEmpty()) {
            Map<Id, AcctSeed__Billing__c> billingMap = new Map<Id, AcctSeed__Billing__c>([select Id, Tax_Group__c from AcctSeed__Billing__c where Id in :bIds]);
            
            Set<Id> tgIds = new Set<Id>();
            for (AcctSeed__Billing__c b :billingMap.values()) {
                if (b.Tax_Group__c != null) {
                    tgIds.add(b.Tax_Group__c);
                }
            }
            
            if (!tgIds.isEmpty()) {
                
                // Read in all of the fields of the Tax Group records
                Map<String, Schema.SObjectField> fMap;
                List<string> selectFields;
                fMap = Schema.getGlobalDescribe().get('Tax_Group__c').getDescribe().Fields.getMap();
                selectFields = new List<string>();
                for (Schema.SObjectField ft : fMap.values()) {
                    Schema.DescribeFieldResult fd = ft.getDescribe();
                    selectFields.add(fd.getName());
                }
                
                String selects = '';
                for (String s :selectFields) {
                    selects += s + ',';
                }
                if (selects.endsWith(',')) {
                    selects = selects.substring(0,selects.lastIndexOf(','));
                }
                
                String taxGroupIds = '(';
                for (Id i :tgIds) {
                    taxGroupIds += '\'' + i + '\',';
                }
                taxGroupIds = taxGroupIds.removeEnd(',');
                taxGroupIds += ')';
                
                List<Tax_Group__c> tgList = new List<Tax_Group__c>();
                tgList = (List<Tax_Group__c>)Database.query('SELECT ' + selects + ' FROM Tax_Group__c WHERE Id IN ' + taxGroupIds);
                Map<Id, Tax_Group__c> tgMap = new Map<Id, Tax_Group__c>();
                for (Tax_Group__c tg :tgList) {
                    tgMap.put(tg.Id, tg);
                }
                
                // Set Taxable based on value of the field on the Tax Group record with the same label as the value 
                // of the Tax Category field. The Tax Group record is referenced on the Billing record
                String tgField;
                for (AcctSeed__Billing_Line__c bl :billingLineMap.values()) {
                    bl.Taxable__c = false;
                    if (String.isNotBlank(bl.Category__c)) {
                        tgField = '';
                        for (Schema.SObjectField ft : fMap.values()) {
                            Schema.DescribeFieldResult fd = ft.getDescribe();
                            if (fd.getLabel() == bl.Category__c) {
                            tgField = fd.getName();
                            }
                        }
                        
                        if (String.isNotBlank(tgField)) {
                            if (tgMap.containsKey(billingMap.get(bl.AcctSeed__Billing__c).Tax_Group__c)) {
                                if (tgMap.get(billingMap.get(bl.AcctSeed__Billing__c).Tax_Group__c).get(tgField) == 'Taxed') {
                                    bl.Taxable__c = true;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Set field Case__c from the related Service Visit record if there is one.
    // - before insert, before update
    public static void blsCase(List<AcctSeed__Billing_Line__c> newList, Map<Id, AcctSeed__Billing_Line__c> oldMap, Boolean isInsert) {
        Set<Id> svIds = new Set<Id>();
        
        if (isInsert) {
            
            for (AcctSeed__Billing_Line__c bl :newList) {
                if (bl.Service_Visit__c != null) {
                    svIds.add(bl.Service_Visit__c);
                }
            }
            
        } else {
            
            for (AcctSeed__Billing_Line__c bl :newList) {
                if (bl.Service_Visit__c != oldMap.get(bl.Id).Service_Visit__c) {
                    if (bl.Service_Visit__c == null) {
                        bl.Case__c = null;
                    } else {
                        svIds.add(bl.Service_Visit__c);
                    }
                }
            }
        }
        
        if (!svIds.isEmpty()) {
            Map<Id, SV__c> svMap = new Map<Id, SV__c>([select Id, Case__c from SV__c where Id in :svIds]);
            for (AcctSeed__Billing_Line__c bl :newList) {
                if (svMap.containsKey(bl.Service_Visit__c)) {
                    bl.Case__c = svMap.get(bl.Service_Visit__c).Case__c;
                }
            }
        }
    }
    
     /*This is logic to update team and ops division from project on the billing line item 
            for o&m billing only during insert operation 
     
      Added on 2/18/2020 MG

   */
    
        public static void blsproj(List<AcctSeed__Billing_Line__c> newList, Map<Id, AcctSeed__Billing_Line__c> oldMap, Boolean isInsert) {
        Set<Id> glvIds = new Set<Id>();
        Set<Id> setBillingId = new Set<Id>();
            
     if (isInsert) {
          
            for (AcctSeed__Billing_Line__c bl :newList) {
                  system.debug('this is project -->' +bl.AcctSeed__Project__c );
                if (bl.AcctSeed__Project__c != null) {
                  //  system.debug('this is glvids-->' +bl.AcctSeed__Project__r.Sales_Segment__c);
                    glvIds.add(bl.AcctSeed__Project__c);
                    setBillingId.add(bl.AcctSeed__Billing__c);
                }
            }
            system.debug('this is salessegment-->' +glvIds);
         system.debug('this is billing id-->' +setBillingId);
     } 
            
    Map<Id,AcctSeed__Billing__c> mapBilling = new Map<Id,AcctSeed__Billing__c>(
                                                    [Select Id,AcctSeed__Billing_Format__c,AcctSeed__Billing_Format__r.Name
                                                        From AcctSeed__Billing__c Where Id IN:setBillingId]
       
                                                );
           //string bformat = mapBilling.get(newList.AcctSeed__Billing__c);
    //   AcctSeed__Billing__c billingObj = mapBilling.get(newList.AcctSeed__Billing__c);
           
            // Check if Billing Format is 'O&M' 
                       
    
        if (!glvIds.isEmpty()) {
            Map<Id, AcctSeed__Project__c> glMap = new Map<Id, AcctSeed__Project__c>([Select Id,Ops_Division__c,sales_segment__c,Branch__c
                                                        From AcctSeed__Project__c Where Id IN:glvIds]);
            for (AcctSeed__Billing_Line__c bl :newList) {
        AcctSeed__Billing__c billingObj = mapBilling.get(bl.AcctSeed__Billing__c);
                 if(billingObj.AcctSeed__Billing_Format__c != null && 
                    (billingObj.AcctSeed__Billing_Format__r.Name == 'O&M' || billingObj.AcctSeed__Billing_Format__r.Name=='O&M Service')){
                        
                     if (glMap.containsKey(bl.AcctSeed__Project__c)) {
                     system.debug('this is final' +glmap.get(bl.AcctSeed__Project__c).Ops_Division__c);
                      bl.AcctSeed__GL_Account_Variable_3__c = glmap.get(bl.AcctSeed__Project__c).Ops_Division__c;
                     bl.AcctSeed__GL_Account_Variable_2__c = glmap.get(bl.AcctSeed__Project__c).sales_segment__c;
                         
                }
                        
                    }
                
                   
           
              
            }
        }
    }
    
    ///
    
    // Set field Billing_Status__c on related cases that are closed
    // - after delete, after insert, after undelete, after update
    public static void blsCaseBillingStatus(List<AcctSeed__Billing_Line__c> newList, Map<Id, AcctSeed__Billing_Line__c> oldMap, Boolean isDelete, Boolean isInsert, Boolean isUndelete, Boolean isUpdate) {
        Set<Id> cIds = new Set<Id>();
        
        if (isDelete) {
            for (AcctSeed__Billing_Line__c bl :oldMap.values()) {
                if (bl.Case__c != null) {
                    cIds.add(bl.Case__c);
                }
            }
        }
        
        if (isInsert || isUndelete) {
            for (AcctSeed__Billing_Line__c bl :newList) {
                if (bl.Case__c != null) {
                    cIds.add(bl.Case__c);
                }
            }
        }
        
        if (isUpdate) {
            for (AcctSeed__Billing_Line__c bl :newList) {
                if (bl.Case__c != oldMap.get(bl.Id).Case__c) {
                    if (bl.Case__c != null) {
                        cIds.add(bl.Case__c);
                    }
                    if (oldMap.get(bl.Id).Case__c != null) {
                        cIds.add(oldMap.get(bl.Id).Case__c);
                    }
                }
                if (bl.AcctSeed__Billing__c != oldMap.get(bl.Id).AcctSeed__Billing__c) {
                    if (bl.Case__c != null) {
                        cIds.add(bl.Case__c);
                    }
                }
            }
        }
        
        if (!cIds.isEmpty()) {
            CaseService.billingStatus(cIds);
        }
    }
    
    /*
    Author: Madan
    Date: Aug 23, 2017
    Description: Prepopulate fields on Billing Line
    */
    public static void populateFields(List<AcctSeed__Billing_Line__c> triggerNEW) {
        Set<Id> setBillingId = new Set<Id>();
        Set<Id> setRevenueGLAccountId = new Set<Id>();
        set<id> setprojectid = new set<id>();
        
        // Create Set of Billing Id[Parent] and Revenue GLA Account id
        for(AcctSeed__Billing_Line__c lineItem:triggerNEW) {
            setBillingId.add(lineItem.AcctSeed__Billing__c);
            setprojectid.add(lineitem.AcctSeed__Project__c);
            if(lineItem.AcctSeed__Revenue_GL_Account__c != null) {
                setRevenueGLAccountId.add(lineItem.AcctSeed__Revenue_GL_Account__c);
            }
        }
        
        // Create map of Billing Records by Id
        Map<Id,AcctSeed__Billing__c> mapBilling = new Map<Id,AcctSeed__Billing__c>(
                                                    [Select Id,AcctSeed__Billing_Format__c,AcctSeed__Billing_Format__r.Name,
                                                            Service_Contract__r.ASProject__c, Service_Contract__r.Branch__c 
                                                        From AcctSeed__Billing__c Where Id IN:setBillingId]
                                                );
        
        // Create map of Rev GL Account Records by Id
        Map<Id,AcctSeed__GL_Account__c> mapRevGLAccount = new Map<Id,AcctSeed__GL_Account__c>(
                                                    [Select Id,Name 
                                                        From AcctSeed__GL_Account__c Where Id IN:setRevenueGLAccountId]
                                                );
                                                
          //create map of project records 
          system.debug('this is setbillidid-->'  +setprojectid);
           Map<Id,AcctSeed__Project__c> mapproject = new Map<Id,AcctSeed__Project__c>(
                                                    [Select Id,Ops_Division__c
                                                        From AcctSeed__Project__c Where Id IN:setBillingId]
                                                );                                      
                                                
        
        // Create Map by Branch Name to Branch record
        Map<String,AcctSeed__Accounting_Variable__c> mapBranchByName = new Map<String,AcctSeed__Accounting_Variable__c>();
        for(AcctSeed__Accounting_Variable__c branch:[Select Id,Name,AcctSeed__Type__c From AcctSeed__Accounting_Variable__c 
                                                            Where AcctSeed__Type__c='GL Account Variable 1']) {
            mapBranchByName.put(branch.name,branch);
            if(branch.Name == 'Mid-Atlantic') {
               mapBranchByName.put('Mid Atlantic',branch);
            }
        }
                                    
        Id corporateBranchId, omSalesSegmentId, omOpsDivisionId;
        
        // set Corporate Branch Id in Variable which will get used later
        if(mapBranchByName.containsKey('Corporate')) {
            corporateBranchId = mapBranchByName.get('Corporate').Id;
        }
        
        // set O&M Sales Segment and O&M Ops Division id from Accounting Variable records[Filter by name and Type]
        for(AcctSeed__Accounting_Variable__c accVariable:[Select Id,Name,AcctSeed__Type__c From AcctSeed__Accounting_Variable__c 
                                                        Where Name='O&M']) {
            if(accVariable.Name == 'O&M' && accVariable.AcctSeed__Type__c=='GL Account Variable 2') {
             //   omSalesSegmentId = accVariable.Id;
            } else if(accVariable.Name == 'O&M' && accVariable.AcctSeed__Type__c=='GL Account Variable 3') {
             //   omOpsDivisionId = accVariable.Id;
            }
        }
        
        for(AcctSeed__Billing_Line__c lineItem:triggerNEW) {
            AcctSeed__Billing__c billingObj = mapBilling.get(lineItem.AcctSeed__Billing__c);
           
            // Check if Billing Format is 'O&M' AND Revenue GL Account is not null
            if(billingObj.AcctSeed__Billing_Format__c != null && 
                    (billingObj.AcctSeed__Billing_Format__r.Name == 'O&M' || billingObj.AcctSeed__Billing_Format__r.Name=='O&M Service') && 
                    lineItem.AcctSeed__Revenue_GL_Account__c != null) {
                AcctSeed__GL_Account__c revGLAccountObj = mapRevGLAccount.get(lineItem.AcctSeed__Revenue_GL_Account__c);
                String revGLAccountName = revGLAccountObj.Name; 
                
                if(revGLAccountName.startsWith('1213')) { // IF Revenue GL Account Name starts with 1213
                    lineItem.AcctSeed__GL_Account_Variable_1__c = corporateBranchId;
               //     lineItem.AcctSeed__GL_Account_Variable_2__c = null;
             //       lineItem.AcctSeed__GL_Account_Variable_3__c = null;
                    if(billingObj.Service_Contract__c != null) {
                        lineItem.AcctSeed__Project__c = billingObj.Service_Contract__r.ASProject__c;
                    } else {
                        lineItem.AcctSeed__Project__c = null;
                    }
                    
                } 
                // IF Revenue GL Account Name starts with 3702 OR 3102
                else if(revGLAccountName.startsWith('3702') || revGLAccountName.startsWith('3102')) {
                 //   lineItem.AcctSeed__GL_Account_Variable_2__c = omSalesSegmentId;
              //      lineItem.AcctSeed__GL_Account_Variable_3__c = omOpsDivisionId;
                    if(billingObj.Service_Contract__c != null &&
                            billingObj.Service_Contract__r.Branch__c != null && 
                            mapBranchByName.containsKey(billingObj.Service_Contract__r.Branch__c)) {
                        lineItem.AcctSeed__GL_Account_Variable_1__c = mapBranchByName.get(billingObj.Service_Contract__r.Branch__c).Id;
                    }
                    if(billingObj.Service_Contract__c != null) {
                        lineItem.AcctSeed__Project__c = billingObj.Service_Contract__r.ASProject__c;
                    } else {
                        lineItem.AcctSeed__Project__c = null;
                    }
                }
                
            }
        }
    }
}