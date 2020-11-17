/*
* Author: Madan (Forcebrain Developer)
* Date: Sept 7, 2017
* Description: Handler class of AP Line object trigger
*/
public Class AccountPayableLineHandler {
    public static void populateFields(List<AcctSeed__Account_Payable_Line__c> listNew) {
        Set<Id> setExpGLAccId = new Set<Id>();
        Set<Id> setPOLId = new Set<Id>();
        for(AcctSeed__Account_Payable_Line__c apl:listNew) {
            if(apl.AcctSeed__Expense_GL_Account__c != null) {
                setExpGLAccId.add(apl.AcctSeed__Expense_GL_Account__c);
            }
            
            if(apl.AcctSeedERP__Purchase_Order_Line__c != null) {
                setPOLId.add(apl.AcctSeedERP__Purchase_Order_Line__c);
            }
        }
        
        // Create Map of GL Account by Id
        Map<Id,AcctSeed__GL_Account__c> mapGLAccount = new Map<Id,AcctSeed__GL_Account__c>();
        if(setExpGLAccId.size() > 0) {
            mapGLAccount = new Map<Id,AcctSeed__GL_Account__c>(
                                        [Select Id,Name From AcctSeed__GL_Account__c 
                                            Where ID IN:setExpGLAccId]);
        }
        
        // Create Map of POL by Id
        Map<Id,AcctSeedERP__Purchase_Order_Line__c> mapPOL = new Map<Id,AcctSeedERP__Purchase_Order_Line__c>();
        if(setPOLId.size() > 0) {
            mapPOL = new Map<Id,AcctSeedERP__Purchase_Order_Line__c>(
                                        [Select Id, AcctSeedERP__Project__c, AcctSeedERP__Project__r.Service_Contract_Branch__c 
                                            From AcctSeedERP__Purchase_Order_Line__c 
                                            Where ID IN:setPOLId]);
        }
        
        
        // Create Map by Branch Name to Branch record
        Map<String,AcctSeed__Accounting_Variable__c> mapBranchByName = new Map<String,AcctSeed__Accounting_Variable__c>();
        for(AcctSeed__Accounting_Variable__c branch:[Select Id,Name,AcctSeed__Type__c From AcctSeed__Accounting_Variable__c 
                                                            Where AcctSeed__Type__c='GL Account Variable 1']) {
            mapBranchByName.put(branch.name,branch);
            if(branch.Name == 'Mid-Atlantic') {
                mapBranchByName.put('Mid Atlantic',branch);
            }
        }
        
        // set O&M Sales Segment and O&M Ops Division id from Accounting Variable records[Filter by name and Type]
        Id omSalesSegmentId, omOpsDivisionId;
        for(AcctSeed__Accounting_Variable__c accVariable:[Select Id,Name,AcctSeed__Type__c From AcctSeed__Accounting_Variable__c 
                                                        Where Name='O&M']) {
            if(accVariable.Name == 'O&M' && accVariable.AcctSeed__Type__c=='GL Account Variable 2') {
                omSalesSegmentId = accVariable.Id;
            } else if(accVariable.Name == 'O&M' && accVariable.AcctSeed__Type__c=='GL Account Variable 3') {
                omOpsDivisionId = accVariable.Id;
            }
        }
        
        for(AcctSeed__Account_Payable_Line__c apl:listNew) {
            if(apl.AcctSeed__Expense_GL_Account__c != null) {
                // If Starts with 1213
                if(mapGLAccount.get(apl.AcctSeed__Expense_GL_Account__c).Name.startsWith('1213')) {
                    // Set Branch lookup to Corporate Branch
                    apl.AcctSeed__GL_Account_Variable_1__c = mapBranchByName.get('Corporate').Id;
                    apl.AcctSeed__GL_Account_Variable_2__c = null;
                    apl.AcctSeed__GL_Account_Variable_3__c = null;
                    
                    /* Commented On client Request(Madan) - Sept 11, 2017
                    if(apl.AcctSeedERP__Purchase_Order_Line__c != null && 
                            mapPOL.containsKey(apl.AcctSeedERP__Purchase_Order_Line__c)) {
                        apl.AcctSeed__Project__c = mapPOL.get(apl.AcctSeedERP__Purchase_Order_Line__c).AcctSeedERP__Project__c;
                    } else {
                        apl.AcctSeed__Project__c = null;
                    }
                    */
                } else if(mapGLAccount.get(apl.AcctSeed__Expense_GL_Account__c).Name.startsWith('3700') ||
                            mapGLAccount.get(apl.AcctSeed__Expense_GL_Account__c).Name.startsWith('4300') || 
                            mapGLAccount.get(apl.AcctSeed__Expense_GL_Account__c).Name.startsWith('4301')) {
                    apl.AcctSeed__GL_Account_Variable_2__c = omSalesSegmentId;
                    apl.AcctSeed__GL_Account_Variable_3__c = omOpsDivisionId;
                    
                    /* Commented On client Request(Madan) - Sept 11, 2017
                    // Project Mapping
                    if(apl.AcctSeedERP__Purchase_Order_Line__c != null && 
                            mapPOL.containsKey(apl.AcctSeedERP__Purchase_Order_Line__c)) {
                        apl.AcctSeed__Project__c = mapPOL.get(apl.AcctSeedERP__Purchase_Order_Line__c).AcctSeedERP__Project__c;
                    } else {
                        apl.AcctSeed__Project__c = null;
                    }
                    */
                    
                    // Branch Mapping(Set Branch(GL Account Variable 1 on APL from APL => Project => Service Contract Branch))
                    if(apl.AcctSeedERP__Purchase_Order_Line__c != null && 
                            mapPOL.containsKey(apl.AcctSeedERP__Purchase_Order_Line__c) &&
                            apl.AcctSeed__Project__c != null &&
                            mapPOL.get(apl.AcctSeedERP__Purchase_Order_Line__c).AcctSeedERP__Project__r.Service_Contract_Branch__c != null
                            ) {
                        String branchName = mapPOL.get(apl.AcctSeedERP__Purchase_Order_Line__c).AcctSeedERP__Project__r.Service_Contract_Branch__c;
                        //System.debug('================branchName: ' + branchName);
                        if(mapBranchByName.containsKey(branchName)) {
                            apl.AcctSeed__GL_Account_Variable_1__c = mapBranchByName.get(branchName).Id;
                            apl.AcctSeed__Project_Task__c = null;
                            //System.debug('=============BRANCH SET:');
                        } else {
                            apl.AcctSeed__GL_Account_Variable_1__c = null;
                        }
                    } else {
                        apl.AcctSeed__GL_Account_Variable_1__c = null;
                    }
                }
            }
        }
    }
}