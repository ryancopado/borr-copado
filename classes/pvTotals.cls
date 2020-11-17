public with sharing class pvTotals {
    public static void toInvoiceELI(ELI__c[] t){
        List<Id> tPro = new List<Id>();
        for(Integer i = 0; i<t.size(); i++){
            tPro.add(t[i].Project__c);
        }
        Map<Id, SFDC_Project__c> tePro = new Map<Id, SFDC_Project__c>();
        SFDC_Project__c[] p = [select Billing_Status_Feasibility__c, PV_Billing_Status_Design__c, PV_Billing_Status_Procurement__c, 
                                Cost_To_Customer_Procurement__c, Cost_To_Customer_Feasibility__c, Cost_To_Customer_Design__c, 
                                Cost_To_Borrego_Procurement__c, Cost_To_Borrego_Feasibility__c, Cost_To_Borrego_Design__c,
                                Total_To_Invoice_Feasibility__c, Total_To_Invoice_Design__c, Total_To_Invoice_Procurement__c,
                                Not_To_Exceed_Feas__c, Fixed_Cost_Feasibility__c
                                from SFDC_Project__c where Id in :tPro];
        for(Integer i = 0; i<p.size(); i++){
            tePro.put(p[i].Id, p[i]);
        }
        Map<Id, SFDC_Project__c> upPro = new Map<Id, SFDC_Project__c>();                           
        for(Integer m = 0; m<t.size(); m++){
            Decimal fTotal = 0;     Decimal fTotali = 0;
            Decimal dTotal = 0;     Decimal dTotali = 0;
            Decimal pTotal = 0;     Decimal pTotali = 0;
            //Feasibility
            if(tePro.get(t[m].Project__c).Billing_Status_Feasibility__c != 'Completed') {
                //If Chargeback, add to fTotal which adds to Total to Invoice
                if(t[m].Chargeback__c == true){
                    fTotal += t[m].Approved_Amount__c;
                } else {
                    //Add non-chargeback items to fTotali which adds to Cost To Borrego
                    fTotali += t[m].Approved_Amount__c;
                }
                /*
                //Add all to fTotali which adds to Cost to Borrego
                fTotali += t[m].Approved_Amount__c;
                */
            } else if(tePro.get(t[m].Project__c).PV_Billing_Status_Design__c != 'Completed') {
                if(t[m].Chargeback__c == true){
                    dTotal += t[m].Approved_Amount__c;
                } 
                dTotali += t[m].Approved_Amount__c;
            } else if(tePro.get(t[m].Project__c).PV_Billing_Status_Procurement__c != 'Completed') {
                if(t[m].Chargeback__c == true){
                    pTotal += t[m].Approved_Amount__c;
                } 
                pTotali += t[m].Approved_Amount__c;
            }
            
            //Deal with potential null fields
            if(tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c == null) {
                tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c = 0;
            }
            if(tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c == null) {
                tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c = 0;
            }
            if(tePro.get(t[m].Project__c).Not_To_Exceed_Feas__c == null) {
                tePro.get(t[m].Project__c).Not_To_Exceed_Feas__c = 0;
            }
            
            //If Fixed Cost project, determine how much of this ELI might have to go to Cost To Borrego
            //given Not To Exceed value (this happens during invoice save for non-Fixed Cost projects)
            if (fTotal != 0) {
                if (tePro.get(t[m].Project__c).Fixed_Cost_Feasibility__c) {
                    if (fTotal + tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c > tePro.get(t[m].Project__c).Not_To_Exceed_Feas__c) {
                        if (tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c > tePro.get(t[m].Project__c).Not_To_Exceed_Feas__c) {
                            //We were over Not To Exceed before this ELI, add full amount to Cost To Borrego
                            tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c += fTotal;
                        } else {
                            //This ELI puts us over Not To Exceed, add the overage portion to Cost To Borrego
                            tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c += ((fTotal + tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c) - tePro.get(t[m].Project__c).Not_To_Exceed_Feas__c);
                        }
                    }
                }
                tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c += fTotal;
            }
            tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c += fTotali;
/*            
            if(fTotal != 0) {
                if(tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c == null) {
                    tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c = 0;
                }
                tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c += fTotal;               
            }
            if(fTotali != 0) {
                if(tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c = 0;
                }
                tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c += fTotali;
            }
*/
            if(dTotal != 0) {
                if(tePro.get(t[m].Project__c).Total_To_Invoice_Design__c == null) {
                    tePro.get(t[m].Project__c).Total_To_Invoice_Design__c = 0;
                }
                tePro.get(t[m].Project__c).Total_To_Invoice_Design__c += dTotal;                        
            }
            if(dTotali != 0) {
                if(tePro.get(t[m].Project__c).Cost_To_Borrego_Design__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Borrego_Design__c = 0;
                }
                tePro.get(t[m].Project__c).Cost_To_Borrego_Design__c += dTotali;
            }
            if(pTotal != 0) {
                if(tePro.get(t[m].Project__c).Total_To_Invoice_Procurement__c == null) {
                    tePro.get(t[m].Project__c).Total_To_Invoice_Procurement__c = 0;
                }
                tePro.get(t[m].Project__c).Total_To_Invoice_Procurement__c += pTotal;   
            }
            if(pTotali != 0) {
                if(tePro.get(t[m].Project__c).Cost_To_Borrego_Procurement__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Borrego_Procurement__c = 0;
                }
                tePro.get(t[m].Project__c).Cost_To_Borrego_Procurement__c += pTotali;
            }
            upPro.put(tePro.get(t[m].Project__c).Id, tePro.get(t[m].Project__c));
        }
                
        if(upPro.size() > 0) {
            update upPro.values();
        }
    }
    public static void toInvoiceTE(Time_Entry__c[] t, Integer act){
        List<Id> tPro = new List<Id>();
        for(Integer i = 0; i<t.size(); i++){
            tPro.add(t[i].Project__c);
        }
        Map<Id, SFDC_Project__c> tePro = new Map<Id, SFDC_Project__c>();
        SFDC_Project__c[] p = [select Billing_Status_Feasibility__c, PV_Billing_Status_Design__c, PV_Billing_Status_Procurement__c, 
                                Cost_To_Customer_Procurement__c, Cost_To_Customer_Feasibility__c, Cost_To_Customer_Design__c, 
                                Cost_To_Borrego_Procurement__c, Cost_To_Borrego_Feasibility__c, Cost_To_Borrego_Design__c,
                                Total_To_Invoice_Feasibility__c, Total_To_Invoice_Design__c, Total_To_Invoice_Procurement__c
                                from SFDC_Project__c where Id in :tPro];
        for(Integer i = 0; i<p.size(); i++){
            tePro.put(p[i].Id, p[i]);
        }
        Map<Id, SFDC_Project__c> upPro = new Map<Id, SFDC_Project__c>();                        
        for(Integer m = 0; m<t.size(); m++){
            Decimal fTotal = 0;     Decimal fTotali = 0;
            Decimal dTotal = 0;     Decimal dTotali = 0;
            Decimal pTotal = 0;     Decimal pTotali = 0;
            
            if(act == 0){   
                if(tePro.get(t[m].Project__c).Billing_Status_Feasibility__c != 'Completed') {
                    fTotal += t[m].Total_Cost_Project_Calc__c;
                    fTotali += t[m].Total_Cost_Internal_Calc__c;
                } else if(tePro.get(t[m].Project__c).PV_Billing_Status_Design__c != 'Completed') {
                    dTotal += t[m].Total_Cost_Project_Calc__c;
                    dTotali += t[m].Total_Cost_Internal__c;
                } else if(tePro.get(t[m].Project__c).PV_Billing_Status_Procurement__c != 'Completed') {
                    pTotal += t[m].Total_Cost_Project_Calc__c;
                    pTotali += t[m].Total_Cost_Internal__c;
                }
            } else if(act == 1){
                if(t[m].Stage__c == 'Feasibility') {
                    fTotal += t[m].Cost_Change_Project__c;
                    fTotali += t[m].Cost_Change_Internal__c;
                } else if(t[m].Stage__c == 'Design') {
                    dTotal += t[m].Cost_Change_Project__c;
                    dTotali += t[m].Cost_Change_Internal__c;
                } else if(t[m].Stage__c == 'Procurement') {
                    pTotal += t[m].Cost_Change_Project__c;
                    pTotali += t[m].Cost_Change_Internal__c;
                }
            } else if(act == 2){
                if(t[m].Stage__c == 'Feasibility') {
                    if (t[m].Total_Cost_Project_Calc__c == null) {
                        fTotal -= t[m].Total_Cost_Project__c;
                    } else {
                        fTotal -= t[m].Total_Cost_Project_Calc__c;
                    }
                    if (t[m].Total_Cost_Internal_Calc__c == null) {
                        fTotali -= t[m].Total_Cost_Internal__c;
                    } else {
                        fTotali -= t[m].Total_Cost_Internal_Calc__c;
                    }
                } else if(t[m].Stage__c == 'Design') {
                    dTotal -= t[m].Total_Cost_Project_Calc__c;
                    dTotali -= t[m].Total_Cost_Internal__c;
                } else if(t[m].Stage__c == 'Procurement') {
                    pTotal -= t[m].Total_Cost_Project_Calc__c;
                    pTotali -= t[m].Total_Cost_Internal__c;
                }
            }
            if(fTotal != 0 || fTotali != 0) {
                if(tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c == null) {
                    tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c = 0;
                }
                if(tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c = 0;
                }
                tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c += fTotal;
                tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c += fTotali;       
            }
            if(dTotal != 0) {
                if(tePro.get(t[m].Project__c).Total_To_Invoice_Design__c == null) {
                    tePro.get(t[m].Project__c).Total_To_Invoice_Design__c = 0;
                }
                if(tePro.get(t[m].Project__c).Cost_To_Borrego_Design__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Borrego_Design__c = 0;
                } 
                tePro.get(t[m].Project__c).Total_To_Invoice_Design__c += dTotal;
                tePro.get(t[m].Project__c).Cost_To_Borrego_Design__c += dTotali;                    
            }
            if(pTotal != 0) {
                if(tePro.get(t[m].Project__c).Total_To_Invoice_Procurement__c == null) {
                    tePro.get(t[m].Project__c).Total_To_Invoice_Procurement__c = 0;
                }
                if(tePro.get(t[m].Project__c).Cost_To_Borrego_Procurement__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Borrego_Procurement__c = 0;
                }
                tePro.get(t[m].Project__c).Total_To_Invoice_Procurement__c += pTotal;   
                tePro.get(t[m].Project__c).Cost_To_Borrego_Procurement__c += pTotali;
            }
            upPro.put(tePro.get(t[m].Project__c).Id, tePro.get(t[m].Project__c));
        }
        if(upPro.size() > 0) {
            update upPro.values();
        }
    }
    
    public static void setRatesTE(Time_Entry__c[] t) {
        
        Decimal rate = 0;
        Decimal rate1 = 0;
        Decimal rate2 = 0;
        Decimal rate3 = 0;
        
        //Get the Team Member record for each Time Entry record
        List<Id> tTM = new List<Id>();
        for(Integer i = 0; i<t.size(); i++) {
            tTM.add(t[i].Team_Member__c);
        }
        Map<Id, Team_Member__c> teTM = new Map<Id, Team_Member__c>();
        Team_Member__c[] tm = [select Rate_Project__c, Rate1_Project__c, Rate2_Project__c, Rate3_Project__c, 
                                Rate_Effective_Date_Project__c, Rate1_Effective_Date_Project__c,
                                Rate2_Effective_Date_Project__c, Rate3_Effective_Date_Project__c,
/*
                                Rate_Internal__c, Rate1_Internal__c, Rate2_Internal__c, Rate3_Internal__c, 
                                Rate_Effective_Date_Internal__c, Rate1_Effective_Date_Internal__c,
                                Rate2_Effective_Date_Internal__c, Rate3_Effective_Date_Internal__c
*/
                                User__c from Team_Member__c where Id in :tTM];
        List<Id> uId = new List<Id>();
        for(Integer i = 0; i<tm.size(); i++) {
            teTM.put(tm[i].Id, tm[i]);
            uId.add(tm[i].User__c);
        }
        
        //Get the User record for each Time Entry-->Team Member record
        Map<Id, User> teU = new Map<Id, User>();
        User[] u = [select Rate__c, Rate1__c, Rate2__c, Rate3__c, Rate_Effective_Date__c,
                        Rate1_Effective_Date__c, Rate2_Effective_Date__c, Rate3_Effective_Date__c
                        from User where Id in :uId];
        for (Integer i=0; i<u.size(); i++) {
            teU.put(u[i].Id, u[i]);
        }
                                
        for(Integer m = 0; m<t.size(); m++) {
            
            t[m].Force_Recalc__c = false;
            
            //Can only recalculate Time Entries that are not already on an invoice
            if (t[m].Invoice__c == null) {
            
                //Deal with potential null values in the Rate (Project) fields
                rate = teTM.get(t[m].Team_Member__c).Rate_Project__c;
                rate1 = teTM.get(t[m].Team_Member__c).Rate1_Project__c;
                rate2 = teTM.get(t[m].Team_Member__c).Rate2_Project__c;
                rate3 = teTM.get(t[m].Team_Member__c).Rate3_Project__c;
                if (rate == null) {
                    rate = 0;
                }
                if (rate1 == null) {
                    rate1 = rate;
                }
                if (rate2 == null) {
                    rate2 = rate1;
                }
                if (rate3 == null) {
                    rate3 = rate2;
                }
                
                //Calculate the Time Entry Rate (Project) field based on Start Date field and
                //Team Member Rate Effective Date (Project) field
                if ((teTM.get(t[m].Team_Member__c).Rate_Effective_Date_Project__c == null) ||
                    (t[m].Start_Date__c == null) ||
                    (t[m].Start_Date__c >= teTM.get(t[m].Team_Member__c).Rate_Effective_Date_Project__c)) {
                    t[m].Rate_Project_Calc__c = rate;
                } else {
                    if ((teTM.get(t[m].Team_Member__c).Rate1_Effective_Date_Project__c == null) ||
                        ((t[m].Start_Date__c >= teTM.get(t[m].Team_Member__c).Rate1_Effective_Date_Project__c) &&
                         (t[m].Start_Date__c < teTM.get(t[m].Team_Member__c).Rate_Effective_Date_Project__c))) {
                        t[m].Rate_Project_Calc__c = rate1;
                    } else {
                        if ((teTM.get(t[m].Team_Member__c).Rate2_Effective_Date_Project__c == null) ||
                            ((t[m].Start_Date__c >= teTM.get(t[m].Team_Member__c).Rate2_Effective_Date_Project__c) &&
                             (t[m].Start_Date__c < teTM.get(t[m].Team_Member__c).Rate1_Effective_Date_Project__c))) {
                            t[m].Rate_Project_Calc__c = rate2;
                        } else {
                            if ((teTM.get(t[m].Team_Member__c).Rate3_Effective_Date_Project__c == null) ||
                                ((t[m].Start_Date__c >= teTM.get(t[m].Team_Member__c).Rate3_Effective_Date_Project__c) &&
                                 (t[m].Start_Date__c < teTM.get(t[m].Team_Member__c).Rate2_Effective_Date_Project__c))) {
                                t[m].Rate_Project_Calc__c = rate3;
                            } else {
                                t[m].Rate_Project_Calc__c = rate;
                            }
                        }
                    }
                }
                //Calculate new Total Cost (Project)
                t[m].Total_Cost_Project_Calc__c = t[m].Rate_Project_Calc__c * t[m].Hours__c;
                
                //Deal with potential null values in the Rate fields
                rate = teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate__c;
                rate1 = teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate1__c;
                rate2 = teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate2__c;
                rate3 = teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate3__c;
                if (rate == null) {
                    rate = 0;
                }
                if (rate1 == null) {
                    rate1 = rate;
                }
                if (rate2 == null) {
                    rate2 = rate1;
                }
                if (rate3 == null) {
                    rate3 = rate2;
                }
                
                //Calculate the Time Entry Rate (Internal) field based on Start Date field and
                //Team Member Rate Effective Date (Internal) field
                if ((teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate_Effective_Date__c == null) ||
                    (t[m].Start_Date__c == null) ||
                    (t[m].Start_Date__c >= teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate_Effective_Date__c)) {
                    t[m].Rate_Internal_Calc__c = rate;
                } else {
                    if ((teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate1_Effective_Date__c == null) ||
                        ((t[m].Start_Date__c >= teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate1_Effective_Date__c) &&
                         (t[m].Start_Date__c < teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate_Effective_Date__c))) {
                        t[m].Rate_Internal_Calc__c = rate1;
                    } else {
                        if ((teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate2_Effective_Date__c == null) ||
                            ((t[m].Start_Date__c >= teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate2_Effective_Date__c) &&
                             (t[m].Start_Date__c < teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate1_Effective_Date__c))) {
                            t[m].Rate_Internal_Calc__c = rate2;
                        } else {
                            if ((teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate3_Effective_Date__c == null) ||
                                ((t[m].Start_Date__c >= teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate3_Effective_Date__c) &&
                                 (t[m].Start_Date__c < teU.get(teTM.get(t[m].Team_Member__c).User__c).Rate2_Effective_Date__c))) {
                                t[m].Rate_Internal_Calc__c = rate3;
                            } else {
                                t[m].Rate_Internal_Calc__c = rate;
                            }
                        }
                    }
                }
                //Calculate new Total Cost (Internal)
                t[m].Total_Cost_Internal_Calc__c = t[m].Rate_Internal_Calc__c * t[m].Hours__c;
            }
        }
    }
    
    public static void toInvoicePC(PCost__c[] t, Integer act){
        List<Id> tPro = new List<Id>();
        for(Integer i = 0; i<t.size(); i++){
            tPro.add(t[i].Project__c);
        }
        Map<Id, SFDC_Project__c> tePro = new Map<Id, SFDC_Project__c>();
        SFDC_Project__c[] p = [select Billing_Status_Feasibility__c, PV_Billing_Status_Design__c, PV_Billing_Status_Procurement__c,
                                Cost_To_Borrego_Procurement__c, Cost_To_Borrego_Feasibility__c, Cost_To_Borrego_Design__c,
                                Cost_To_Customer_Procurement__c, Cost_To_Customer_Feasibility__c, Cost_To_Customer_Design__c,  
                                Total_To_Invoice_Feasibility__c, Total_To_Invoice_Design__c, Total_To_Invoice_Procurement__c
                                from SFDC_Project__c where Id in :tPro];
        for(Integer i = 0; i<p.size(); i++){
            tePro.put(p[i].Id, p[i]);
        }
        Map<Id, SFDC_Project__c> upPro = new Map<Id, SFDC_Project__c>();                        
        for(Integer m = 0; m<t.size(); m++){
            Decimal fTotali = 0;     Decimal fTotalb = 0;    /* Decimal fTotalc = 0; */      
            Decimal dTotal = 0;     Decimal dTotalb = 0;
            Decimal pTotal = 0;     Decimal pTotalb = 0;
            if(act == 0){   
                if(tePro.get(t[m].Project__c).Billing_Status_Feasibility__c != 'Completed') {
                    if(t[m].Chargeback_To_Customer__c == true){
                        fTotali += t[m].Amount__c;
                        if (t[m].Cost_to_Borrego__c != null) {
                            fTotalb += t[m].Cost_to_Borrego__c;
                        }
                    } else {
                        fTotalb += t[m].Amount__c;
                    }
                } else if(tePro.get(t[m].Project__c).PV_Billing_Status_Design__c != 'Completed') {
                    if(t[m].Chargeback_To_Customer__c == true){
                        dTotalb += t[m].Amount__c;
                    } else {
                        dTotal +=t[m].Amount__c;
                    }
                } else if(tePro.get(t[m].Project__c).PV_Billing_Status_Procurement__c != 'Completed') {
                    if(t[m].Chargeback_To_Customer__c == true){
                        pTotalb += t[m].Amount__c;
                    } else {
                        pTotal +=t[m].Amount__c;
                    }
                }
            } else if(act == 1){
                if(t[m].Stage__c == 'Feasibility') {
                    if(t[m].Chargeback_To_Customer__c == true){
                        fTotali += t[m].Cost_Change__c;
                        fTotalb += t[m].Cost_to_Borrego_Change__c;
                    } else {
                        fTotalb += t[m].Cost_Change__c;
                    }
                } else if(t[m].Stage__c == 'Design') {
                    if(t[m].Chargeback_To_Customer__c == true){
                        dTotalb += t[m].Cost_Change__c;
                    } else {
                        dTotal += t[m].Cost_Change__c;
                    }
                } else if(t[m].Stage__c == 'Procurement') {
                    if(t[m].Chargeback_To_Customer__c == true){
                        pTotalb += t[m].Cost_Change__c;
                    } else {
                        pTotal += t[m].Cost_Change__c;
                    }
                }   
            } else if(act == 2){
                if(t[m].Stage__c == 'Feasibility') {
                    if(t[m].Chargeback_To_Customer__c == true){
                        fTotali -= t[m].Amount__c;
                        if (t[m].Cost_to_Borrego__c != null) {
                            fTotalb -= t[m].Cost_to_Borrego__c;
                        }
                    } else {
                        fTotalb -= t[m].Amount__c;
                    }
                } else if(t[m].Stage__c == 'Design') {
                    if(t[m].Chargeback_To_Customer__c == true){
                        dTotalb -= t[m].Amount__c;
                    } else {
                        dTotal -= t[m].Amount__c;
                    }
                } else if(t[m].Stage__c == 'Procurement') {
                    if(t[m].Chargeback_To_Customer__c == true){
                        pTotalb -= t[m].Amount__c;
                    } else {
                        pTotal -= t[m].Amount__c;
                    }
                }
            }
/*
            if(fTotalc != 0) {
                if(tePro.get(t[m].Project__c).Cost_To_Customer_Feasibility__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Customer_Feasibility__c = 0;
                }
                tePro.get(t[m].Project__c).Cost_To_Customer_Feasibility__c += fTotalc;               
            }
*/ 
            if(fTotali != 0) {
                if(tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c == null) {
                    tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c = 0;
                }
                tePro.get(t[m].Project__c).Total_To_Invoice_Feasibility__c += fTotali;               
            }
            if(fTotalb != 0) {
                if(tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c = 0;
                }
                tePro.get(t[m].Project__c).Cost_To_Borrego_Feasibility__c += fTotalb;               
            }                
            if(dTotal != 0) {
                if(tePro.get(t[m].Project__c).Cost_To_Customer_Design__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Customer_Design__c = 0;
                }
                tePro.get(t[m].Project__c).Cost_To_Customer_Design__c += dTotal;
            } 
            if(dTotalb != 0) {
                if(tePro.get(t[m].Project__c).Total_To_Invoice_Design__c == null) {
                    tePro.get(t[m].Project__c).Total_To_Invoice_Design__c = 0;
                }
                if(tePro.get(t[m].Project__c).Cost_To_Borrego_Design__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Borrego_Design__c = 0;
                }
                tePro.get(t[m].Project__c).Total_To_Invoice_Design__c += dTotalb;   
                tePro.get(t[m].Project__c).Cost_To_Borrego_Design__c += dTotalb;    
            }
            if(pTotal != 0) {
                if(tePro.get(t[m].Project__c).Cost_To_Customer_Procurement__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Customer_Procurement__c = 0;
                }
                tePro.get(t[m].Project__c).Cost_To_Customer_Procurement__c += pTotal;                       
            }
            if(pTotalb != 0) {
                if(tePro.get(t[m].Project__c).Total_To_Invoice_Procurement__c == null) {
                    tePro.get(t[m].Project__c).Total_To_Invoice_Procurement__c = 0;
                }
                if(tePro.get(t[m].Project__c).Cost_To_Borrego_Procurement__c == null) {
                    tePro.get(t[m].Project__c).Cost_To_Borrego_Procurement__c = 0;
                }
                tePro.get(t[m].Project__c).Total_To_Invoice_Procurement__c += pTotalb;
                tePro.get(t[m].Project__c).Cost_To_Borrego_Procurement__c += pTotalb;                       
            }
            upPro.put(tePro.get(t[m].Project__c).Id, tePro.get(t[m].Project__c));
        }
        if(upPro.size() > 0) {
            update upPro.values();
        }
    }
    public static void approved(Invoices__c[] i){
        //Need to remove ELI  and PC from Cost to Borrego
        List<Id> invID = new List<Id>();
        List<Id> invP = new List<Id>();
        for(Integer m = 0; m<i.size(); m++){
            invID.add(i[m].Id);
            invP.add(i[m].Project__c);
        }
        Map<Id, SFDC_Project__c> inPro = new Map<Id, SFDC_Project__c>();
/*
        SFDC_Project__c[] p = [select Id, Cost_To_Customer_Procurement__c, Cost_To_Customer_Feasibility__c, Cost_To_Customer_Design__c
                                from SFDC_Project__c where Id in :invP];
*/
        SFDC_Project__c[] p = [select Id, Cost_To_Customer_Procurement__c, Cost_To_Customer_Feasibility__c, Cost_To_Customer_Design__c, Cost_To_Borrego_Feasibility__c, Retainer_Amount_Left_Feasibility__c
                                from SFDC_Project__c where Id in :invP];

        for(Integer m = 0; m<p.size(); m++){
            inPro.put(p[m].Id, p[m]);
        }
        Map<Id, SFDC_Project__c> upPro = new Map<Id, SFDC_Project__c>();
        for(Integer m = 0; m<i.size(); m++) {
            if(i[m].Stage__c == 'Feasibility') {
                if(inPro.get(i[m].Project__c).Cost_To_Customer_Feasibility__c == null) {
                    inPro.get(i[m].Project__c).Cost_To_Customer_Feasibility__c = 0;
                }
                inPro.get(i[m].Project__c).Cost_To_Customer_Feasibility__c += i[m].Cost_To_Customer__c;
                
                //If there were costs that were not able to be included on the invoice
                //due to reaching the Not To Exceed value, add them to Cost To Borrego
                if(inPro.get(i[m].Project__c).Cost_To_Borrego_Feasibility__c == null) {
                    inPro.get(i[m].Project__c).Cost_To_Borrego_Feasibility__c = 0;
                }
                inPro.get(i[m].Project__c).Cost_To_Borrego_Feasibility__c += i[m].Cost_To_Borrego_Additional__c;
                
                //Update the amount of Retainer left
                if(inPro.get(i[m].Project__c).Retainer_Amount_Left_Feasibility__c == null) {
                    inPro.get(i[m].Project__c).Retainer_Amount_Left_Feasibility__c = 0;
                }
                inPro.get(i[m].Project__c).Retainer_Amount_Left_Feasibility__c += i[m].Retainer_Amount__c;
                inPro.get(i[m].Project__c).Retainer_Amount_Left_Feasibility__c -= i[m].Retainer_Amount_Used__c;
                
            } else if(i[m].Stage__c == 'Design') {
                if(inPro.get(i[m].Project__c).Cost_To_Customer_Design__c == null) {
                    inPro.get(i[m].Project__c).Cost_To_Customer_Design__c = 0;
                }
                inPro.get(i[m].Project__c).Cost_To_Customer_Design__c += i[m].Total_Charges__c;
            } else if(i[m].Stage__c == 'Procurement') {
                if(inPro.get(i[m].Project__c).Cost_To_Customer_Procurement__c == null) {
                    inPro.get(i[m].Project__c).Cost_To_Customer_Procurement__c = 0;
                }
                inPro.get(i[m].Project__c).Cost_To_Customer_Procurement__c += i[m].Total_Charges__c;
            }
            upPro.put(inPro.get(i[m].Project__c).Id, inPro.get(i[m].Project__c));
        }
        if(upPro.size() > 0) {
            update upPro.values();
        }       
    }
    public static void invoiced(Invoices__c[] i){
        //Need to remove ELI  and PC from Cost to Borrego
        List<Id> invID = new List<Id>();
        List<Id> invP = new List<Id>();
        for(Integer m = 0; m<i.size(); m++){
            invID.add(i[m].Id);
            invP.add(i[m].Project__c);
        }
        Map<Id, SFDC_Project__c> inPro = new Map<Id, SFDC_Project__c>();
        SFDC_Project__c[] p = [select Id, Total_Invoiced_Feasibility__c, Total_Invoiced_Design__c, Total_Invoiced_Procurement__c,
                                Cost_To_Borrego_Procurement__c, Cost_To_Borrego_Feasibility__c, Cost_To_Borrego_Design__c,
                                Total_To_Invoice_Feasibility__c, Total_To_Invoice_Design__c, Total_To_Invoice_Procurement__c 
                                from SFDC_Project__c where Id in :invP];
        for(Integer m = 0; m<p.size(); m++){
            inPro.put(p[m].Id, p[m]);
        }
        /*
        Decimal Total = 0;              
    //  Decimal Totalb = 0;
                                
        PCost__c[] pc = [select Amount__c, Stage__c from PCost__c where Invoice__c in :invID];
        for(Integer m = 0; m<pc.size(); m++){
            Total += pc[m].Amount__c;
    //      Totalb += pc[m].Amount__c;
        }
        ELI__c[] ex = [select Approved_Amount__c, Stage__c from ELI__c where Invoice__c in :invID];
        for(Integer m = 0; m<ex.size(); m++){
            Total += ex[m].Approved_Amount__c;
    //      Totalb += ex[m].Approved_Amount__c;
        }
        Time_Entry__c[] te = [select Total_Cost_Project__c, Stage__c from Time_Entry__c where Invoice__c in :invID];
        for(Integer m = 0; m<te.size(); m++){
            Total += te[m].Total_Cost_Project__c;
        }
        */
        Map<Id, SFDC_Project__c> upPro = new Map<Id, SFDC_Project__c>();
        for(Integer m = 0; m<i.size(); m++) {
/* Nothing to do in Feasibility anymore        
            if(i[m].Stage__c == 'Feasibility') {
                if(inPro.get(i[m].Project__c).Total_Invoiced_Feasibility__c == null) {
                    inPro.get(i[m].Project__c).Total_Invoiced_Feasibility__c = 0;
                }
                inPro.get(i[m].Project__c).Total_Invoiced_Feasibility__c += Total;
                
                if(inPro.get(i[m].Project__c).Total_To_Invoice_Feasibility__c >= Total){ 
                    inPro.get(i[m].Project__c).Total_To_Invoice_Feasibility__c -= Total;
                } else {
                    inPro.get(i[m].Project__c).Total_To_Invoice_Feasibility__c = 0;
                }
                inPro.get(i[m].Project__c).Cost_To_Borrego_Feasibility__c -= i[m].Total_Charges__c;
            }
*/            
            if(i[m].Stage__c == 'Design') {
            /*  if(inPro.get(i[m].Project__c).Total_Invoiced_Design__c == null) {
                    inPro.get(i[m].Project__c).Total_Invoiced_Design__c = 0;
                }
                inPro.get(i[m].Project__c).Total_Invoiced_Design__c += Total;
                
                if(inPro.get(i[m].Project__c).Total_To_Invoice_Design__c >= Total){ 
                    inPro.get(i[m].Project__c).Total_To_Invoice_Design__c -= Total;
                } else {
                    inPro.get(i[m].Project__c).Total_To_Invoice_Design__c = 0;
                } */
                inPro.get(i[m].Project__c).Cost_To_Borrego_Design__c -= i[m].Total_Charges__c;
            }
            if(i[m].Stage__c == 'Procurement') {
            /*  if(inPro.get(i[m].Project__c).Total_Invoiced_Procurement__c == null) {
                    inPro.get(i[m].Project__c).Total_Invoiced_Procurement__c = 0;
                }
                inPro.get(i[m].Project__c).Total_Invoiced_Procurement__c += Total;
                
                if(inPro.get(i[m].Project__c).Total_To_Invoice_Procurement__c >= Total){ 
                    inPro.get(i[m].Project__c).Total_To_Invoice_Procurement__c -= Total;
                } else {
                    inPro.get(i[m].Project__c).Total_To_Invoice_Procurement__c = 0;
                } */
                inPro.get(i[m].Project__c).Cost_To_Borrego_Procurement__c -= i[m].Total_Charges__c;         
            }
            upPro.put(inPro.get(i[m].Project__c).Id, inPro.get(i[m].Project__c));
        }
        if(upPro.size() > 0) {
            update upPro.values();
        }       
    }
    
    public static testmethod void totalTest() {
        
        AcctSeed__Project__c p2 = ProjectTest.setupTestProj();
        SFDC_Project__c p = ProjectTestOld.setupTestProj();
        p.Project_Type__c = 'PV Direct'; 
        p.Cost_To_Customer_Design__c = null;    
        p.Cost_To_Customer_Feasibility__c = null;   
        p.Cost_To_Customer_Procurement__c = null;   
        p.Billing_Status_Feasibility__c = 'New';
        p.Total_To_Invoice_Design__c = null;
        p.Total_To_Invoice_Feasibility__c = null;
        p.Total_To_Invoice_Procurement__c = null;
        update p;

        Cost_Code__c[] costcode = new Cost_Code__c[0];
        costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
        costcode.add(new Cost_Code__c(Name = 'Test02', Number__c = '80367', Category__c = 'M'));
        costcode.add(new Cost_Code__c(Name = 'Test03', Number__c = '80377', Category__c = 'O'));
        insert costcode;
    
        Budget__c budget = new Budget__c(Project__c = p.Id);  insert budget; 
        Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id,  
                                                            Pending_PO_Total__c = 0.0, PO_Total__c = 12); insert bli;
        
        Invoices__c[] inv = new Invoices__c[0];
        inv.add(new Invoices__c(Project__c = p.Id, Date__c = System.today(),
                                    Total_Charges__c = 745.89, Stage__c = 'Feasibility'));
        inv.add(new Invoices__c(Project__c = p.Id, Date__c = System.today(),
                                    Total_Charges__c = 745.89, Stage__c = 'Design')); 
        inv.add(new Invoices__c(Project__c = p.Id, Date__c = System.today(),
                                    Total_Charges__c = 745.89, Stage__c = 'Procurement'));                                                       
        insert inv;                                                 
        RecordType projE = [select Id from RecordType where Name = 'Project Expense'];
        ER__c er = new ER__c(User__c = p.OwnerId, Month_Ending__c = System.today()); insert er;
        Test.startTest();
        ELI__c[] eli = new ELI__c[3];
        eli[0]=new ELI__c(Expense_Header__c = er.Id, Cost_Code__c = costcode[0].Id,
                            Manager_Approval__c = true, RecordTypeId = projE.Id, Approved_Amount__c = 150.85, 
                            Stage__c = 'Feasibility', Chargeback__c = true, Invoice__c = inv[0].Id, PV_Direct__c = true, 
                            Cost_Miles__c = 258.75, Project__c = p.Id);
        eli[1]=new ELI__c(Expense_Header__c = er.Id, Cost_Code__c = costcode[0].Id, 
                            Manager_Approval__c = true, RecordTypeId = projE.Id, Approved_Amount__c = 258.75, 
                            Cost_Miles__c = 258.75, Stage__c = 'Design', Chargeback__c = true, 
                            Invoice__c = inv[0].Id, Project__c = p.Id);
        eli[2]=new ELI__c(Expense_Header__c = er.Id, Expenditure_Type__c = 'Dues', Cost_Code__c = costcode[0].Id,  
                            Stage__c = 'Procurement', Manager_Approval__c = true, Approved_Amount__c = 258.75, 
                            Cost_Miles__c = 258.75, Chargeback__c = true, Invoice__c = inv[0].Id, Project__c = p.Id);                              
        insert eli; 

        Team_Member__c tm = new Team_Member__c(Project__c = p.Id, User__c = p.OwnerId, Rate_Project__c = 35.67); 
        insert tm;
        Time_Entry__c[] te = new Time_Entry__c[3];
        //te.add(new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id, Invoice__c = inv[0].Id,
        te[0]=new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id,
                                                Hours__c = 5, Stage__c = 'Feasibility');
        //te.add(new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id, Invoice__c = inv[0].Id,
        te[1]=new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id,
                                                Hours__c = 5, Stage__c = 'Design');
        //te.add(new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id, Invoice__c = inv[0].Id,
        te[2]=new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id,
                                                Hours__c = 5, Stage__c = 'Procurement');                                                                                
        insert te;
        //insert te[0];
        te[0].Hours__c = 7; update te[0];
        PCost__c[] pc = new PCost__c[3];
        pc[0]=new PCost__c(Project__c = p.Id, Vendor_Account__c = p.Account__c, Amount__c = 768.98,
                                    Stage__c = 'Feasibility', Invoice__c = inv[0].Id, Chargeback_To_Customer__c = true); 
        pc[1]=new PCost__c(Project__c = p.Id, Vendor_Account__c = p.Account__c, Amount__c = 900.98,
                                    Stage__c = 'Design', Invoice__c = inv[0].Id, Chargeback_To_Customer__c = true);
        pc[2]=new PCost__c(Project__c = p.Id, Vendor_Account__c = p.Account__c, Amount__c = 567.98,
                                    Stage__c = 'Procurement', Invoice__c = inv[0].Id, Chargeback_To_Customer__c = true);                           
        insert pc;
        pc[0].Amount__c = 900.65;  
        
        //Test out rate changes
        tm.Rate_Project__c += 5;
        update tm;
        User u = [select Rate__c from User where Id = :tm.User__c];
        if (u.Rate__c == null) {
            u.Rate__c = 42.35;
        } else {
            u.Rate__c += 5;
        }
        update u;
        
        er.Status__c = 'Approved'; update er;
        er.Status__c = 'New'; update er;
        
        //p.Billing_Status_Feasibility__c = 'Completed';
        update p;
        
        //insert eli[1];
        //insert te[1];
        
        //p.PV_Billing_Status_Design__c = 'Completed';
        update p;        
       // insert eli[2];
        //insert te[2];
        
        te[0].Invoice__c = inv[0].Id;
        te[1].Invoice__c = inv[0].Id;
        te[2].Invoice__c = inv[0].Id;
        update te;
        
        //er.Status__c = 'Approved'; update er;
/*        
        inv[0].Status__c = 'Paid'; update inv[0];
        inv[0].Status__c = 'Approved'; update inv[0];
        inv[1].Status__c = 'Paid'; update inv[1];
        inv[1].Status__c = 'Approved'; update inv[1];
        inv[2].Status__c = 'Paid'; update inv[2];
        inv[2].Status__c = 'Approved'; update inv[2];
*/        
      /*  inv[0].Status__c = 'Approved';
        inv[1].Status__c = 'Approved';
        inv[2].Status__c = 'Approved';
        update inv;
        
        inv[0].Status__c = 'Paid';
        inv[1].Status__c = 'Paid';
        inv[2].Status__c = 'Paid';
        update inv;        
        
        p.Not_To_Exceed_Feas__c = 900;
        update p;
        pvFieldsUpdate.pv_FieldsUpdate(p);
        
        delete te;
        delete pc;*/
          
        Test.stopTest();
    }
    
public static testmethod void NewtotalTest() {
       
        AcctSeed__Project__c p2 = ProjectTest.setupTestProj();
        SFDC_Project__c p = ProjectTestOld.setupTestProj();
        p.Project_Type__c = 'PV Direct'; 
        p.Cost_To_Customer_Design__c = null;    
        p.Cost_To_Customer_Feasibility__c = null;   
        p.Cost_To_Customer_Procurement__c = null;   
        p.Billing_Status_Feasibility__c = 'New';
        p.Total_To_Invoice_Design__c = null;
        p.Total_To_Invoice_Feasibility__c = null;
        p.Total_To_Invoice_Procurement__c = null;
        update p;

        Cost_Code__c[] costcode = new Cost_Code__c[0];
        costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
        costcode.add(new Cost_Code__c(Name = 'Test02', Number__c = '80367', Category__c = 'M'));
        costcode.add(new Cost_Code__c(Name = 'Test03', Number__c = '80377', Category__c = 'O'));
        insert costcode;
    
        Budget__c budget = new Budget__c(Project__c = p.Id);  insert budget; 
        Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id,  
                                                            Pending_PO_Total__c = 0.0, PO_Total__c = 12); insert bli;
        
        Invoices__c[] inv = new Invoices__c[0];
        inv.add(new Invoices__c(Project__c = p.Id, Date__c = System.today(),
                                    Total_Charges__c = 745.89, Stage__c = 'Feasibility'));
        inv.add(new Invoices__c(Project__c = p.Id, Date__c = System.today(),
                                    Total_Charges__c = 745.89, Stage__c = 'Design')); 
        inv.add(new Invoices__c(Project__c = p.Id, Date__c = System.today(),
                                    Total_Charges__c = 745.89, Stage__c = 'Procurement'));                                                       
        insert inv;                                                 
        RecordType projE = [select Id from RecordType where Name = 'Project Expense'];
        ER__c er = new ER__c(User__c = p.OwnerId, Month_Ending__c = System.today()); insert er;
         Test.startTest();
        ELI__c[] eli = new ELI__c[3];
        eli[0]=new ELI__c(Expense_Header__c = er.Id, Cost_Code__c = costcode[0].Id,
                            Manager_Approval__c = true, RecordTypeId = projE.Id, Approved_Amount__c = 150.85, 
                            Stage__c = 'Feasibility', Chargeback__c = true, Invoice__c = inv[0].Id, PV_Direct__c = true, 
                            Cost_Miles__c = 258.75, Project__c = p.Id);
        eli[1]=new ELI__c(Expense_Header__c = er.Id, Cost_Code__c = costcode[0].Id, 
                            Manager_Approval__c = true, RecordTypeId = projE.Id, Approved_Amount__c = 258.75, 
                            Cost_Miles__c = 258.75, Stage__c = 'Design', Chargeback__c = true, 
                            Invoice__c = inv[0].Id, Project__c = p.Id);
        eli[2]=new ELI__c(Expense_Header__c = er.Id, Expenditure_Type__c = 'Dues',   Cost_Code__c = costcode[0].Id, 
                            Stage__c = 'Procurement', Manager_Approval__c = true, Approved_Amount__c = 258.75, 
                            Cost_Miles__c = 258.75, Chargeback__c = true, Invoice__c = inv[0].Id, Project__c = p.Id);                              
        insert eli; 

        Team_Member__c tm = new Team_Member__c(Project__c = p.Id, User__c = p.OwnerId, Rate_Project__c = 35.67); 
        insert tm;
        Time_Entry__c[] te = new Time_Entry__c[3];
        //te.add(new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id, Invoice__c = inv[0].Id,
        te[0]=new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id,
                                                Hours__c = 5, Stage__c = 'Feasibility');
        //te.add(new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id, Invoice__c = inv[0].Id,
        te[1]=new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id,
                                                Hours__c = 5, Stage__c = 'Design');
        //te.add(new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id, Invoice__c = inv[0].Id,
        te[2]=new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id,
                                                Hours__c = 5, Stage__c = 'Procurement');                                                                                
        insert te;
        
        PCost__c[] pc = new PCost__c[3];
        pc[0]=new PCost__c(Project__c = p.Id, Vendor_Account__c = p.Account__c, Amount__c = 768.98,
                                    Stage__c = 'Feasibility', Invoice__c = inv[0].Id, Chargeback_To_Customer__c = true); 
        pc[1]=new PCost__c(Project__c = p.Id, Vendor_Account__c = p.Account__c, Amount__c = 900.98,
                                    Stage__c = 'Design', Invoice__c = inv[0].Id, Chargeback_To_Customer__c = true);
        pc[2]=new PCost__c(Project__c = p.Id, Vendor_Account__c = p.Account__c, Amount__c = 567.98,
                                    Stage__c = 'Procurement', Invoice__c = inv[0].Id, Chargeback_To_Customer__c = true);                           
        insert pc;
        pc[0].Amount__c = 900.65;  
        
        //Test out rate changes
        tm.Rate_Project__c += 5;
       
                  
        
        
        
        
      
        
    inv[0].Status__c = 'Approved';
        inv[1].Status__c = 'Approved';
        inv[2].Status__c = 'Approved';
        update inv;
        
        inv[0].Status__c = 'Paid';
        inv[1].Status__c = 'Paid';
        inv[2].Status__c = 'Paid';
        update inv;        
        
        //p.Not_To_Exceed_Feas__c = 900;
        update p;
        //pvFieldsUpdate.pv_FieldsUpdate(p);
        
        delete te;
        delete pc; 
          
        Test.stopTest();
    }
}