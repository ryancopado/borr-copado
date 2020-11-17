public class createInvoice {
    
    ApexPages.StandardController stdController;
    private final Invoices__c inv;  
    
    public createInvoice(ApexPages.StandardController stdController) {
        this.inv = (Invoices__c)stdController.getRecord(); 
        this.stdController = stdController;
    }
    private ELI__c[] eli;
    private Time_Entry__c[] te;
    private PCost__c[] pc;
    private Retainer__c[] r;
    private Fixed_Cost__c[] fc;
    
    String[] selected = new String[]{};
    public void setSelected(String[] selected) { this.selected = selected; }
    public String[] getSelected() { return selected; }
    
    public List<SelectOption> getLines() {
        Map<Id, String> cName = new Map<Id, String>();
        Cost_Code__c[] codes = [select Name from Cost_Code__c];
        for (Integer i = 0; i<codes.size(); i++){
            cName.put(codes[i].Id, codes[i].Name);
        }
        List<SelectOption> options = new List<SelectOption>();
        SFDC_Project__c p = [select Fixed_Cost_Feasibility__c from SFDC_Project__c where Id = :inv.Project__c];
        if (p.Fixed_Cost_Feasibility__c) {
            
            //Fixed Cost project - we only invoice Fixed Cost records
            fc = [select Id, Invoice__c, Amount__c, Invoice_Description__c, Stage__c
                    from Fixed_Cost__c where Invoice__c = null and Project__c = :inv.Project__c];
            for (Integer i=0; i<fc.size(); i++) {
                options.add(new SelectOption(fc[i].Id, 'Fixed Cost:  ' + fc[i].Invoice_Description__c + ' -- $' + fc[i].Amount__c + ' -- ' + fc[i].Stage__c));
            }
            
        } else {
            
            //Non-Fixed Cost project
            r = [select Id, Invoice__c, Amount__c, Stage__c from Retainer__c where 
                        Invoice__c = null and Project__c = :inv.Project__c];
            for (Integer i = 0; i <r.size(); i++) {
                options.add(new SelectOption(r[i].Id, 'Retainer: ' + '$' + r[i].Amount__c + ' -- ' + ' ' + r[i].Stage__c)); 
            }         
            eli = [select Id, Invoice__c, Approved_Amount__c, Date__c, Stage__c, Cost_Code__c from ELI__c where 
                        Chargeback__c = true and Manager_Approval__c = true and Invoice__c = null and Project__c = :inv.Project__c];
            for (Integer i = 0; i <eli.size(); i++) {
                options.add(new SelectOption(eli[i].Id, 'Expense Line: '+eli[i].Date__c.month()+'/'+eli[i].Date__c.day()+'/'+eli[i].Date__c.year() 
                        + ' -- ' + cName.get(eli[i].Cost_Code__c)+ ' -- ' +' $' +  eli[i].Approved_Amount__c + ' -- ' + ' ' + eli[i].Stage__c)); 
            }
            te = [select Id, Invoice__c, Total_Cost_Project_Calc__c, Date__c, Stage__c, Task__c from Time_Entry__c where Invoice__c = null 
                    and Project__c = :inv.Project__c and Date__c != null];
            for (Integer i = 0; i <te.size(); i++) {
                options.add(new SelectOption(te[i].Id, 'Time Entry: '+te[i].Date__c.month()+'/'+te[i].Date__c.day()+'/'+te[i].Date__c.year() 
                        + ' -- ' + te[i].Task__c + ' -- ' +' $' +  te[i].Total_Cost_Project_Calc__c + ' -- ' + ' ' + te[i].Stage__c)); 
            }
            pc = [select Id, Invoice__c, Amount__c, Date__c, Stage__c, Cost_Code__c from PCost__c where 
                        Chargeback_To_Customer__c = true and Invoice__c = null and Project__c = :inv.Project__c];
            for (Integer i = 0; i <pc.size(); i++) {
                options.add(new SelectOption(pc[i].Id, 'Project Cost: ' +pc[i].Date__c.month()+'/'+pc[i].Date__c.day()+'/'+pc[i].Date__c.year() 
                        + ' -- ' + cName.get(pc[i].Cost_Code__c) + ' -- ' + ' $' +pc[i].Amount__c + ' -- ' + ' ' + pc[i].Stage__c)); 
            }
        }
        
        if(ApexPages.currentPage().getParameters().get('id') != null){
            
            if (p.Fixed_Cost_Feasibility__c) {
                
                //Fixed Cost project - we only invoice Fixed Cost records
                fc = [select Id, Invoice__c, Amount__c, Invoice_Description__c, Stage__c
                        from Fixed_Cost__c where Invoice__c = :inv.Id and Project__c = :inv.Project__c];
                for (Integer i=0; i<fc.size(); i++) {
                    options.add(new SelectOption(fc[i].Id, 'Fixed Cost:  ' + fc[i].Invoice_Description__c + ' -- $' + fc[i].Amount__c + ' -- ' +
                            fc[i].Stage__c + ' -- Previously Selected'));
                }
                
            } else {
                
                //Non-Fixed Cost Project
                r = [select Id, Invoice__c, Amount__c, Stage__c from Retainer__c where 
                        Invoice__c = :inv.Id and Project__c = :inv.Project__c];
                for (Integer i = 0; i <r.size(); i++) {
                    options.add(new SelectOption(r[i].Id, 'Retainer: ' + '$' + r[i].Amount__c + ' -- ' + ' ' + r[i].Stage__c +
                            ' -- Previously Selected'));             
                }
                eli = [select Id, Invoice__c, Approved_Amount__c, Date__c, Stage__c, Cost_Code__c from ELI__c where 
                        Chargeback__c = true and Manager_Approval__c = true and Invoice__c = :inv.Id and Project__c = :inv.Project__c];
                for (Integer i = 0; i <eli.size(); i++) {
                    options.add(new SelectOption(eli[i].Id, 'Expense Line: '+eli[i].Date__c.month()+'/'+eli[i].Date__c.day()+'/'+eli[i].Date__c.year() 
                            + ' -- ' + cName.get(eli[i].Cost_Code__c)+ ' -- ' +' $' +  eli[i].Approved_Amount__c + ' -- ' + ' ' + eli[i].Stage__c +
                            ' -- Previously Selected'));             
                }
                te = [select Id, Invoice__c, Total_Cost_Project_Calc__c, Date__c, Stage__c, Task__c from Time_Entry__c where Invoice__c = :inv.Id 
                        and Project__c = :inv.Project__c and Date__c != null];
                for (Integer i = 0; i <te.size(); i++) {
                    options.add(new SelectOption(te[i].Id, 'Time Entry: '+te[i].Date__c.month()+'/'+te[i].Date__c.day()+'/'+te[i].Date__c.year() 
                            + ' -- ' + te[i].Task__c + ' -- ' +' $' +  te[i].Total_Cost_Project_Calc__c + ' -- ' + ' ' + te[i].Stage__c +
                            ' -- Previously Selected'));             
                }
                pc = [select Id, Invoice__c, Amount__c, Date__c, Stage__c, Cost_Code__c from PCost__c where 
                            Chargeback_To_Customer__c = true and Invoice__c = :inv.Id and Project__c = :inv.Project__c];
                for (Integer i = 0; i <pc.size(); i++) {
                    options.add(new SelectOption(pc[i].Id, 'Project Cost: ' +pc[i].Date__c.month()+'/'+pc[i].Date__c.day()+'/'+pc[i].Date__c.year() 
                            + ' -- ' + cName.get(pc[i].Cost_Code__c) + ' -- ' + ' $' +pc[i].Amount__c + ' -- ' + ' ' + pc[i].Stage__c +
                            ' -- Previously Selected'));            
                }
            }
        }
        if (options.size() == 0){
            options.add(new SelectOption('', 'There are no outstanding items to invoice.'));  
        }                                
        return options;
    }
    private SFDC_Project__c p;
    private SFDC_Project__c getP(){
        p = [select Id, Not_To_Exceed_Feas__c, Not_To_Exceed_Design__c, Not_To_Exceed_Procurement__c,
                Cost_To_Customer_Feasibility__c, Cost_To_Customer_Design__c, Cost_To_Customer_Procurement__c,
                Total_Invoiced_Feasibility__c, Total_Invoiced_Design__c, Total_Invoiced_Procurement__c,
                Retainer_Amount_Left_Feasibility__c, Fixed_Cost_Feasibility__c 
                from SFDC_Project__c where Id = :inv.Project__c];
        if(p.Not_To_Exceed_Feas__c == null) {
            p.Not_To_Exceed_Feas__c = 0;
        }
/*        
        if(p.Not_To_Exceed_Design__c == null) {
            p.Not_To_Exceed_Design__c = 0;
        }
        if(p.Not_To_Exceed_Procurement__c == null) {
            p.Not_To_Exceed_Procurement__c = 0;
        }
*/        
        if(p.Cost_To_Customer_Feasibility__c == null) {
            p.Cost_To_Customer_Feasibility__c = 0;
        }
/*        
        if(p.Cost_To_Customer_Design__c == null) {
            p.Cost_To_Customer_Design__c = 0;
        }
        if(p.Cost_To_Customer_Procurement__c == null) {
            p.Cost_To_Customer_Procurement__c = 0;
        }
*/        
        if(p.Total_Invoiced_Feasibility__c == null) {
            p.Total_Invoiced_Feasibility__c = 0;
        }
/*        
        if(p.Total_Invoiced_Design__c == null) {
            p.Total_Invoiced_Design__c = 0;
        }
        if(p.Total_Invoiced_Procurement__c == null) {
            p.Total_Invoiced_Procurement__c = 0;
        }
*/        
        if(p.Retainer_Amount_Left_Feasibility__c == null) {
            p.Retainer_Amount_Left_Feasibility__c = 0;
        }       
        return p;                               
    }
    public PageReference save() {
        if (selected.size() == 0) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select at least one line to invoice.'));
            return null;
        } else { 
            Decimal hours = 0;
            Decimal cost = 0;
            Decimal ctba = 0;  //cost to borrego additional
            Decimal ral = 0;  //retainer amount selected for this invoice
            Decimal othercosts = 0;  //non retainer costs
            
            String feas;
            String des;
            String proc;

            Fixed_Cost__c[] fc = [select Id, Invoice__c, Amount__c, Stage__c from Fixed_Cost__c where Id in :selected];
            for(Integer i = 0; i<fc.size(); i++){
                if(fc[i].Stage__c == 'Feasibility'){
                    feas = 'true';
                }
                if(fc[i].Stage__c == 'Design'){
                    des = 'true';
                }
                if(fc[i].Stage__c == 'Procurement'){
                    proc = 'true';
                }
            }

            Retainer__c[] r = [select Id, Invoice__c, Amount__c, Stage__c from Retainer__c where Id in :selected];
            for(Integer i = 0; i<r.size(); i++){
                if(r[i].Stage__c == 'Feasibility'){
                    feas = 'true';
                }
                if(r[i].Stage__c == 'Design'){
                    des = 'true';
                }
                if(r[i].Stage__c == 'Procurement'){
                    proc = 'true';
                }
            }             
/*
            ELI__c[] elis = [select Id, Invoice__c, Approved_Amount__c, Stage__c from ELI__c where Id in :selected];
*/
            ELI__c[] elis = [select Id, Invoice__c, Approved_Amount__c, Stage__c, Amount_On_Invoice__c from ELI__c where Id in :selected];
            for(Integer i = 0; i<elis.size(); i++){
                if(elis[i].Stage__c == 'Feasibility'){
                    feas = 'true';
                }
                if(elis[i].Stage__c == 'Design'){
                    des = 'true';
                }
                if(elis[i].Stage__c == 'Procurement'){
                    proc = 'true';
                }
            }   
/*
            Time_Entry__c[] tes = [select Id, Invoice__c, Hours__c, Total_Cost_Project__c, Stage__c from Time_Entry__c where Id in :selected];
*/
            Time_Entry__c[] tes = [select Id, Invoice__c, Hours__c, Total_Cost_Project_Calc__c, Stage__c, Amount_On_Invoice__c from Time_Entry__c where Id in :selected];
            for(Integer i = 0; i<tes.size(); i++){
                if(tes[i].Stage__c == 'Feasibility'){
                    feas = 'true';
                }
                if(tes[i].Stage__c == 'Design'){
                    des = 'true';
                }
                if(tes[i].Stage__c == 'Procurement'){
                    proc = 'true';
                }
            }   
/*
            PCost__c[] pcs = [select Id, Invoice__c, Amount__c, Stage__c from PCost__c where Id in :selected];
*/
            PCost__c[] pcs = [select Id, Invoice__c, Amount__c, Stage__c, Amount_On_Invoice__c from PCost__c where Id in :selected];
            for(Integer i = 0; i<pcs.size(); i++){
                if(pcs[i].Stage__c == 'Feasibility'){
                    feas = 'true';
                }
                if(pcs[i].Stage__c == 'Design'){
                    des = 'true';
                }
                if(pcs[i].Stage__c == 'Procurement'){
                    proc = 'true';
                }
            }
            if(feas == 'true' && des == 'true' || feas == 'true' && proc == 'true' || des == 'true' && proc == 'true') {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'All lines must be from the same stage.'));
                return null;
            } else {
                SFDC_Project__c p = getP();
                
                // Verify that there are no other invoices in process on this project at this time
                Invoices__c[] pInv = [select Id, Status__c from Invoices__c where Project__c = :p.Id];
                for (Integer i=0; i<pInv.size(); i++) {
                    if ((pInv[i].Id != inv.Id) && (pInv[i].Status__c == 'New' || pInv[i].Status__c == 'Submitted')) {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot have more than one unapproved invoice at a time.'));
                        return null;
                    }
                }

                String stage;
                if(r.size() > 0) {
                    for(Integer i=0; i<r.size(); i++) {
                        ral += r[i].Amount__c;
                    }
                    stage = r[0].Stage__c; 
                } 
                if(fc.size() > 0){
                    for(Integer i=0; i<fc.size(); i++){
                        //Determine how much of this Fixed Cost can go on invoice
                        if ((p.Not_To_Exceed_Feas__c > 0) && (cost + fc[i].Amount__c + p.Cost_To_Customer_Feasibility__c > p.Not_To_Exceed_feas__c)) {
                            //If Fixed Cost would put us over Not To Exceed
                            if (cost + p.Cost_To_Customer_Feasibility__c > p.Not_To_Exceed_Feas__c) {
                                //If we were already over Not To Exceed, Fixed Cost can not be added to invoice
                                fc[i].Amount_On_Invoice__c = 0;
                            } else {
                                //Only a portion of Fixed Cost can go on invoice
                                fc[i].Amount_On_Invoice__c = fc[i].Amount__c - ((cost + fc[i].Amount__c + p.Cost_To_Customer_Feasibility__c) - p.Not_To_Exceed_Feas__c);
                            }
                        } else {
                            //Total Fixed Cost will go on invoice
                            fc[i].Amount_On_Invoice__c = fc[i].Amount__c;
                        }                    
                        cost += fc[i].Amount__c;
                    }
                    stage = fc[0].Stage__c;
                }
                if(elis.size() > 0){
                    for(Integer i=0; i<elis.size(); i++){
                        //Determine how much of this ELI can go on invoice and how much goes to Cost To Borrego
                        if ((p.Not_To_Exceed_Feas__c > 0) && (cost + elis[i].Approved_Amount__c + p.Cost_To_Customer_Feasibility__c > p.Not_To_Exceed_feas__c)) {
                            //If ELI Amount would put us over Not To Exceed
                            if (cost + p.Cost_To_Customer_Feasibility__c > p.Not_To_Exceed_Feas__c) {
                                //If we were already over Not To Exceed, full ELI amount goes to Cost To Borrego
                                ctba += elis[i].Approved_Amount__c;
                                elis[i].Amount_On_Invoice__c = 0;
                            } else {
                                //Portion of ELI amount goes to Cost To Borrego
                                ctba += (cost + elis[i].Approved_Amount__c + p.Cost_To_Customer_Feasibility__c) - p.Not_To_Exceed_Feas__c;
                                elis[i].Amount_On_Invoice__c = elis[i].Approved_Amount__c - ((cost + elis[i].Approved_Amount__c + p.Cost_To_Customer_Feasibility__c) - p.Not_To_Exceed_Feas__c);
                            }
                        } else {
                            //Total ELI amount will go on invoice
                            elis[i].Amount_On_Invoice__c = elis[i].Approved_Amount__c;
                        }    
                        cost += elis[i].Approved_Amount__c;
                    }
/*                    
                    for(Integer i=0; i<elis.size(); i++){
                        cost += elis[i].Approved_Amount__c;
                    }
*/                    

                    stage = elis[0].Stage__c; 
                }
                if(tes.size() > 0){
                    for(Integer i=0; i<tes.size(); i++){
                        //Determine how much of this TE amount can go on invoice
                        if ((p.Not_To_Exceed_Feas__c > 0) && (cost + tes[i].Total_Cost_Project_Calc__c + p.Cost_To_Customer_Feasibility__c > p.Not_To_Exceed_feas__c)) {
                            //If TE Amount would put us over Not To Exceed
                            if (cost + p.Cost_To_Customer_Feasibility__c > p.Not_To_Exceed_Feas__c) {
                                //If we were already over Not To Exceed, TE amount can not be added to invoice
                                tes[i].Amount_On_Invoice__c = 0;
                            } else {
                                //Only a portion of TE amount can go on invoice
                                tes[i].Amount_On_Invoice__c = tes[i].Total_Cost_Project_Calc__c - ((cost + tes[i].Total_Cost_Project_Calc__c + p.Cost_To_Customer_Feasibility__c) - p.Not_To_Exceed_Feas__c);
                            }
                        } else {
                            //Total TE amount will go on invoice
                            tes[i].Amount_On_Invoice__c = tes[i].Total_Cost_Project_Calc__c;
                        }    
                        hours += tes[i].Hours__c;
                        cost += tes[i].Total_Cost_Project_Calc__c;
                    }
/*
                    for(Integer i=0; i<tes.size(); i++){
                        hours += tes[i].Hours__c;
                        cost += tes[i].Total_Cost_Project__c;
                    }
*/                    
                    stage = tes[0].Stage__c;
                }
                if(pcs.size() > 0){
                    for(Integer i=0; i<pcs.size(); i++){
                        //Determine how much of this PC amount can go on invoice
                        if ((p.Not_To_Exceed_Feas__c > 0) && (cost + pcs[i].Amount__c + p.Cost_To_Customer_Feasibility__c > p.Not_To_Exceed_feas__c)) {
                            //If PC Amount would put us over Not To Exceed
                            if (cost + p.Cost_To_Customer_Feasibility__c > p.Not_To_Exceed_Feas__c) {
                                //If we were already over Not To Exceed, PC amount can not be added to invoice
                                pcs[i].Amount_On_Invoice__c = 0;
                            } else {
                                //Only a portion of PC amount can go on invoice
                                pcs[i].Amount_On_Invoice__c = pcs[i].Amount__c - ((cost + pcs[i].Amount__c + p.Cost_To_Customer_Feasibility__c) - p.Not_To_Exceed_Feas__c);
                            }
                        } else {
                            //Total PC amount will go on invoice
                            pcs[i].Amount_On_Invoice__c = pcs[i].Amount__c;
                        }                    
                        cost += pcs[i].Amount__c;
                    }
/*
                    for(Integer i=0; i<pcs.size(); i++){
                        cost += pcs[i].Amount__c;
                    }
*/
                    stage = pcs[0].Stage__c;
                }
                inv.Total_Hours__c = hours;
                inv.Cost_To_Borrego_Additional__c = ctba;

                if (stage == 'Feasibility') {
                    //Determine Total Cost Invoice
                    if (ral == 0) {
                        //No Retainer is on this invoice
                        inv.Total_Cost_Invoice__c = cost;
                    } else {
                        //There is a Retainer selected for this invoice
                        if (cost <= ral) {
                            inv.Total_Cost_Invoice__c = ral;
                        } else {
                            inv.Total_Cost_Invoice__c = cost;
                        }
                    }
                    
                    //Determine amount of Retainer used on this invoice
                    othercosts = cost;
                    inv.Retainer_Amount_Used__c = 0;
                    inv.Retainer_Amount__c = ral;
                    inv.Retainer_Available__c = ral + p.Retainer_Amount_Left_Feasibility__c;
                    inv.Cost_To_Customer__c = cost;
                    if (ral > 0) {
                        //There is Retainer costs on this invoice
                        if (cost <= 0) {
                            //Retainer is the only thing on this invoice
                            cost = ral;
                            inv.Cost_To_Customer__c = 0;
                        } else {
                            //This invoice has both Retainer and other costs on it
                            if (cost > ral + p.Retainer_Amount_Left_Feasibility__c) {
                                inv.Retainer_Amount_Used__c = ral + p.Retainer_Amount_Left_Feasibility__c;
                            } else {
                                inv.Retainer_Amount_Used__c = cost;
                                cost = ral;
                            }
                        }
                    } else {
                        //No Retainer cost on this invoice
                        ral = p.Retainer_Amount_Left_Feasibility__c;
                        if (cost <= ral) {
                            inv.Retainer_Amount_Used__c = cost;
                            cost = 0;
                        } else {
                            cost -= ral;
                            inv.Retainer_Amount_Used__c = ral;
                        }
                    }
                    
                    //Determine Total Charges on invoice considering Not To Exceed
                    inv.Total_Charges__c = cost;
                    if (p.Not_To_Exceed_Feas__c > 0 && (othercosts+p.Cost_To_Customer_Feasibility__c) > p.Not_To_Exceed_Feas__c) {
                        Double finalCost = p.Not_To_Exceed_Feas__c - p.Cost_To_Customer_Feasibility__c - inv.Retainer_Amount_Used__c;
                        if(finalCost > 0){
                            inv.Total_Charges__c = finalCost;
                            inv.Cost_To_Customer__c = finalCost;
                        } else {
                            inv.Total_Charges__c = 0;
                            inv.Cost_To_Customer__c = 0;
                        }
                    } 
                }      
              
/*               
                if(stage == 'Feasibility' && p.Not_To_Exceed_Feas__c > 0 && (cost+p.Cost_To_Customer_Feasibility__c) > p.Not_To_Exceed_Feas__c) {
                    Double finalCost = p.Not_To_Exceed_Feas__c - p.Cost_To_Customer_Feasibility__c;
                    if(finalCost > 0){
                        inv.Total_Charges__c = finalCost;
                        inv.Total_Cost_Invoice__c = cost;
                    } else {
                        inv.Total_Charges__c = 0;
                        inv.Total_Cost_Invoice__c = cost;
                    }
                  
                } else if(stage == 'Design' && (cost+p.Cost_To_Customer_Design__c) > p.Not_To_Exceed_Design__c) {
                    Double finalCostd = p.Not_To_Exceed_Design__c - p.Cost_To_Customer_Design__c;
                    if(finalCostd > 0){
                        inv.Total_Charges__c = finalCostd;
                        inv.Total_Cost_Invoice__c = cost;
                    } else {
                        inv.Total_Charges__c = 0;
                        inv.Total_Cost_Invoice__c = cost;
                    }
                } else if(stage == 'Procurement' && (cost+p.Cost_To_Customer_Procurement__c) > p.Not_To_Exceed_Procurement__c) {
                    Double finalCostp = p.Not_To_Exceed_Feas__c - p.Cost_To_Customer_Procurement__c;
                    if(finalCostp > 0){
                        inv.Total_Charges__c = finalCostp;
                        inv.Total_Cost_Invoice__c = cost;
                    } else {
                        inv.Total_Charges__c = 0;
                        inv.Total_Cost_Invoice__c = cost;
                    }
                } else {
                    inv.Total_Charges__c = cost;
                    inv.Total_Cost_Invoice__c = cost;
                }
*/                
                inv.Stage__c = stage;
                if(ApexPages.currentPage().getParameters().get('id') == null){
                    insert inv;
                } else {
                    update inv;
                }
                List<Fixed_Cost__c> upFC = new List<Fixed_Cost__c>();
                for(Integer i=0; i<fc.size(); i++){
                    fc[i].Invoice__c = inv.Id;
                    upFC.add(fc[i]);
                }
                List<Retainer__c> upR = new List<Retainer__c>();
                if(r.size() > 0){
                    for(Integer i=0; i<r.size(); i++){
                        r[i].Invoice__c = inv.Id;
                        upR.add(r[i]);
                    }
                }
                List<ELI__c> upELI = new List<ELI__c>();
                if(elis.size() > 0){
                    for(Integer i=0; i<elis.size(); i++){
                        elis[i].Invoice__c = inv.Id;
                        upELI.add(elis[i]);
                    }
                }
                List<Time_Entry__c> upTE = new List<Time_Entry__c>();
                if(tes.size() > 0){
                    for(Integer i=0; i<tes.size(); i++){
                        tes[i].Invoice__c = inv.Id;
                        upTE.add(tes[i]);
                    }
                }
                List<PCost__c> upPC = new List<PCost__c>();
                if(pcs.size() > 0){
                    for(Integer i=0; i<pcs.size(); i++){
                        pcs[i].Invoice__c = inv.Id;
                        upPC.add(pcs[i]);
                    }
                }
                if(upFC.size() > 0){
                    update upFC;
                }
                if(upR.size() > 0){
                    update upR;
                }
                if(upELI.size() > 0){
                    update upELI;
                }
                if(upTE.size() > 0){
                    update upTE;
                }
                if(upPC.size() > 0){
                    update upPC;
                }
                if(ApexPages.currentPage().getParameters().get('id') != null){
/*
                    ELI__c[] oldEli = [select Id, Invoice__c, Approved_Amount__c from ELI__c where Invoice__c = :inv.Id and Id not in :selected];
                    Time_Entry__c[] oldTe = [select Id, Invoice__c, Hours__c, Total_Cost_Project__c from Time_Entry__c 
                                                where Invoice__c = :inv.Id and Id not in :selected];
                    PCost__c[] oldPc = [select Id, Invoice__c, Amount__c from PCost__c where Invoice__c = :inv.Id and Id not in :selected];
*/
                    Fixed_Cost__c[] oldFC = [select Id, Invoice__c, Amount__c from Fixed_Cost__c where Invoice__c = :inv.Id and Id not in :selected];
                    Retainer__c[] oldR = [select Id, Invoice__c, Amount__c from Retainer__c where Invoice__c = :inv.Id and Id not in :selected];
                    ELI__c[] oldEli = [select Id, Invoice__c, Approved_Amount__c, Amount_On_Invoice__c from ELI__c where Invoice__c = :inv.Id and Id not in :selected];
                    Time_Entry__c[] oldTe = [select Id, Invoice__c, Hours__c, Total_Cost_Project_Calc__c, Amount_On_Invoice__c from Time_Entry__c 
                                                where Invoice__c = :inv.Id and Id not in :selected];
                    PCost__c[] oldPc = [select Id, Invoice__c, Amount__c, Amount_On_Invoice__c from PCost__c where Invoice__c = :inv.Id and Id not in :selected];
                
                    if(oldFC.size() > 0){
                        for(Integer i = 0; i<oldFC.size(); i++){
                            oldFC[i].Invoice__c = null;
                        }
                        update oldFC;
                    }
                    if(oldR.size() > 0){
                        for(Integer i = 0; i<oldR.size(); i++){
                            oldR[i].Invoice__c = null;
                        }
                        update oldR;
                    }
                    if(oldEli.size() > 0){
                        for(Integer i = 0; i<oldEli.size(); i++){
                            oldEli[i].Invoice__c = null;
                            oldEli[i].Amount_On_Invoice__c = 0;
                        }
                        update oldEli;
                    }
                    if(oldTe.size() > 0){
                        for(Integer i = 0; i<oldTe.size(); i++){
                            oldTe[i].Invoice__c = null;
                            oldTe[i].Amount_On_Invoice__c = 0;
                        }
                        update oldTe;
                    }
                    if(oldPc.size() > 0){
                        for(Integer i = 0; i<oldPc.size(); i++){
                            oldPc[i].Invoice__c = null;
                            oldPc[i].Amount_On_Invoice__c = 0;
                        }
                        update oldPc;
                    }
                } 
            }
            
            PageReference newcontact = new PageReference('/' + inv.Id);
            newcontact.setRedirect(true);
            return newcontact;
        }
    }
    
    
//******************printInvoice classes**********************//
    
    public class myTime {
        private String name;
        private String task;
        private Decimal rate;
        private Decimal hours;
        private Decimal total;
     
        public String getName() { return name; }
        public String getRate() {
            String tRate = '';
            if(rate != null) { 
                tRate = rate.setScale(2).toPlainString();
            } 
            return tRate; 
        }
        public String getHours() {
            String tHours = '';
            if(hours != null) {  
                tHours = hours.setScale(2).toPlainString();
            } 
            return tHours; 
        }
        public String getTask() { return task; }
        public String getTotal() {
            String tTotal = '';
            if(total != null) {  
                tTotal = total.setScale(2).toPlainString();
            } 
            return tTotal; 
        }
    }

    private Map<String, myTime> times = new Map<String, myTime>();  
    public List<myTime> getTime() {
        List<Time_Entry__c> te = [select te.Total_Cost_Project_Calc__c, te.Rate_Project_Calc__c,te.Hours__c, te.Team_Member__c,
                                    te.Task__c from Time_Entry__c te where te.Invoice__c = :inv.Id];
        List<Id> teMem = new List<Id>();
        for(Integer i = 0; i<te.size(); i++){ 
            teMem.add(te[i].Team_Member__c);
        }                            
        Team_Member__c[] tm = [select User__c, Role__c from Team_Member__c where Id in :teMem];
        Map<Id, Team_Member__c> emps = new Map<Id, Team_Member__c>();
        List<Id> use = new List<Id>();
        for(Integer i = 0; i<tm.size(); i++){
            emps.put(tm[i].Id, tm[i]);
            use.add(tm[i].User__c);
        }                          
        User[] emp = [select Name from User where Id in :use];                                         
        Map<Id, String> empName = new Map<Id, String>();
        for(Integer i = 0; i<emp.size(); i++){
            empName.put(emp[i].Id, emp[i].Name);
        }
        for (Time_Entry__c t : te) {
            if(times.get(t.Team_Member__c) == null) {
                myTime eX = new myTime(); 
                eX.total = t.Total_Cost_Project_Calc__c;
                eX.rate = t.Rate_Project_Calc__c;
                eX.name = empName.get(emps.get(t.Team_Member__c).User__c);
                eX.hours = t.Hours__c;
                eX.task = emps.get(t.Team_Member__c).Role__c;
                times.put(t.Team_Member__c, eX); 
            } else {
                times.get(t.Team_Member__c).hours += t.Hours__c;
                times.get(t.Team_Member__c).total += t.Total_Cost_Project_Calc__c;
            } 
        }
        return new List<myTime>(times.values());
    }
    private Decimal expense;
    public void getExpenses() {
        expense = 0;
        ELI__c[] ex = [select Id, Approved_Amount__c from ELI__c where Invoice__c = :inv.Id];
        for(Integer i = 0; i<ex.size(); i++){
            expense += ex[i].Approved_Amount__c;
        }
 //     return total.divide(1,2, System.RoundingMode.HALF_UP);
    }
    public String getExpense() {
        getExpenses();
        String exString = expense.setScale(2).toPlainString();
        return exString;
    }
    public String getNTE() {
        SFDC_Project__c p = getP();
        if(inv.Stage__c == 'Feasibility'){
            return string.valueOf(p.Not_To_Exceed_Feas__c);
        } else if(inv.Stage__c == 'Design'){
            return string.valueOf(p.Not_To_Exceed_Design__c);
        } else if(inv.Stage__c == 'Procurement'){
            return string.valueOf(p.Not_To_Exceed_Procurement__c);
        } else {
            return null;
        }
    }
    public String getPInv() {
        if(inv.Stage__c == 'Feasibility'){
            return string.valueOf(p.Total_Invoiced_Feasibility__c);
        } else if(inv.Stage__c == 'Design'){
            return string.valueOf(p.Total_Invoiced_Design__c);
        } else if(inv.Stage__c == 'Procurement'){
            return string.valueOf(p.Total_Invoiced_Procurement__c);
        } else {
            return null;
        }
    }
    public class myCost {
        private String vendor;
        private String note;
        private Decimal amount;
     
        public String getVendor() { return vendor; }
        public String getNote() { return note; }
        public String getAmount() {
            String tAmount = '';
            if(amount != null) { 
                tAmount = amount.setScale(2).toPlainString();        
            }
            return tAmount;     
        }
    }

    private Map<String, myCost> costs = new Map<String, myCost>();  
    public List<myCost> getCosts() {
        List<Id> pAcc = new List<Id>();
        Map<Id, String> acc = new Map<Id, String>();
        PCost__c[] proCo = [select Id, Amount__c, Vendor_Account__c, Notes__c from PCost__c 
                                where Invoice__c = :inv.Id];
        for(Integer i = 0; i<proCo.size(); i++){
            pAcc.add(proCo[i].Vendor_Account__c);
        }
        Account[] a = [select Name from Account where Id in :pAcc];
        for(Integer i = 0; i<a.size(); i++){
            acc.put(a[i].Id, a[i].Name);
        }
                                
        for (PCost__c p : proCo) {
            myCost eX = new myCost(); 
            eX.vendor = acc.get(p.Vendor_Account__c);
            eX.note = p.Notes__c;
            eX.amount = p.Amount__c;
            costs.put(p.Id, eX);  
        }
        return new List<myCost>(costs.values());
    }
     
    public class myFixedCost {
        private String fixednote;
        private Decimal fixedamount;
     
        public String getFixedNote() {
            String tNote = '';
            if (fixednote != null) {
                tNote = fixednote;
            }
            return tNote;
        }
        public String getFixedAmount() {
            String tAmount = '';
            if(fixedamount != null) { 
                tAmount = fixedamount.setScale(2).toPlainString();        
            }
            return tAmount;     
        }
    }

    private Map<String, myFixedCost> fixedcosts = new Map<String, myFixedCost>();  
    public List<myFixedCost> getFixedCosts() {
        
        Fixed_Cost__c[] FC = [select Id, Amount__c, Invoice_Description__c from Fixed_Cost__c 
                                where Invoice__c = :inv.Id];
                                
        for (Fixed_Cost__c f : FC) {
            myFixedCost eX = new myFixedCost(); 
            eX.fixednote = f.Invoice_Description__c;
            eX.fixedamount = f.Amount__c;
            fixedcosts.put(f.Id, eX);  
        }
        return new List<myFixedCost>(fixedcosts.values());
    }
    
    public Boolean getFixedCost() {
        SFDC_Project__c prj = [select Fixed_Cost_Feasibility__c from SFDC_Project__c where Id = :inv.Project__c];
        return prj.Fixed_Cost_Feasibility__c;
    }
      
    private String street;
    private String otherAdd;
    public String getAddress() {
        SFDC_Project__c p = [select Account__c from SFDC_Project__c where Id = :inv.Project__c];
        Account acc = [select Name, BillingStreet, BillingCity, BillingState, BillingPostalCode from Account
                        where Id = :p.Account__c];
        otherAdd = acc.BillingCity+', '+acc.BillingState+' '+acc.BillingPostalCode;
        return acc.BillingStreet;   
    }
    public String getOther() {
        return otherAdd;
    }
    public static testmethod void invoiceTest() {       
       	SFDC_Project__c p = ProjectTestOld.setupTestProj();
        Team_Member__c tm = new Team_Member__c(Project__c = p.Id, User__c = p.OwnerId); insert tm;
        Invoices__c inv = new Invoices__c(Project__c = p.Id); insert inv;
        PCost__c pc = new PCost__c(Project__c = p.Id, Date__c = System.today(), Invoice__c = inv.Id,
                                    Vendor_Account__c = p.Account__c, Amount__c = 100.65); insert pc;
        Time_Entry__c te = new Time_Entry__c(Project__c = p.Id, Team_Member__c = tm.Id, Hours__c = 10.50,
                                                Date__c = System.today());
        insert te;
        te.Invoice__c = inv.Id;
        update te;
        Retainer__c r = new Retainer__c(Project__c = p.Id, Invoice__c = null, Amount__c = 500); insert r;
        List<Id> selected = new List<Id>();
        List<Id> selected1 = new List<Id>();
        selected.add(pc.Id);
        selected.add(te.Id);
        selected.add(r.Id);
        
        
        //p.Billing_Status_Feasibility__c = 'Completed';
        //p.Cost_To_Customer_Feasibility__c = null;
        //p.Not_To_Exceed_Feas__c = null;
        //p.Total_Invoiced_Feasibility__c = null;
        //p.Retainer_Amount_Left_Feasibility__c = null; 
        update p;
        PCost__c pc2 = new PCost__c(Project__c = p.Id, Chargeback_To_Customer__c = true, Date__c = System.today(), 
                                    Vendor_Account__c = p.Account__c, Amount__c = 100.65, Invoice__c = inv.Id); 
        insert pc2;
        
   //     selected.add(pc2.Id);                                                                          
        //Test New Page
        PageReference pageRef = Page.createInvoice;
        Test.setCurrentPage(pageRef);
               
        //Set Page Parameters
        ApexPages.StandardController con = new ApexPages.StandardController(inv);
  //      createInvoice ext = new createInvoice(con);

        ApexPages.currentPage().getParameters().put('id', inv.Id); 
        createInvoice ext = new createInvoice(con);
        //Call all methods on New page 
          ext.getAddress();
          ext.getCosts();
          ext.getExpense();
          ext.getExpenses();
          ext.getNTE();
          ext.getOther();
          ext.getPInv();
          ext.getSelected();
          ext.getTime();
          ext.setSelected(selected1);
          ext.setSelected(selected);
          ext.getLines();
          ext.getP();
          
          myTime ext2 = new myTime();
          ext2.getHours();
          ext2.getName();
          ext2.getRate();
          ext2.getTask();
          ext2.getTotal();
          
          myCost ext3 = new myCost();
          ext3.getVendor();
          ext3.getNote();
          ext3.getAmount();
          
          PageReference result = ext.save();                  
    } 
    
    public static testmethod void invoiceTest1() {  
        //Test Fixed Cost project     
        SFDC_Project__c p = ProjectTestOld.setupTestProj();
        p.Fixed_Cost_Feasibility__c = true;
        p.Not_To_Exceed_Feas__c = 5000;
        update p;
        Fixed_Cost__c fc = new Fixed_Cost__c(Project__c = p.Id, Amount__c = 5000, Invoice_Description__c = 'Test Description');
        insert fc;
        Team_Member__c tm = new Team_Member__c(Project__c = p.Id, User__c = p.OwnerId); insert tm;
        Invoices__c inv = new Invoices__c(Project__c = p.Id); insert inv;
        PCost__c pc = new PCost__c(Project__c = p.Id, Date__c = System.today(), Invoice__c = inv.Id,
                                    Vendor_Account__c = p.Account__c, Amount__c = 100.65); insert pc;
        Time_Entry__c te = new Time_Entry__c(Project__c = p.Id, Team_Member__c = tm.Id, Hours__c = 10.50,
                                                Date__c = System.today());
        insert te;
        fc.Invoice__c = inv.Id;
        update fc;
        List<Id> selected = new List<Id>();
        selected.add(fc.Id);
               
        //Test New Page
        PageReference pageRef = Page.createInvoice;
        Test.setCurrentPage(pageRef);
               
        //Set Page Parameters
        ApexPages.StandardController con = new ApexPages.StandardController(inv);
  //      createInvoice ext = new createInvoice(con);

        ApexPages.currentPage().getParameters().put('id', inv.Id); 
        createInvoice ext = new createInvoice(con);
        
        //Call all methods on New page for Fixed Cost
        ext.getFixedCosts();
        ext.setSelected(selected);
        ext.getLines();
        ext.getP(); 
        myFixedCost ext4 = new myFixedCost();
        ext4.getFixedNote();
        ext4.getFixedAmount();
          
        PageReference result = ext.save();                  
    }
}