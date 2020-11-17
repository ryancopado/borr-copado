public class pvFieldsUpdate {
    
    ApexPages.StandardController stdController;
    private final SFDC_Project__c proj;  
    
    public pvFieldsUpdate(ApexPages.StandardController stdController) {
        this.proj = (SFDC_Project__c)stdController.getRecord(); 
        this.stdController = stdController;
    }
    
    public PageReference pvFieldsUpdate() {
        
        pv_FieldsUpdate(proj);
        PageReference newcontact = new PageReference('/' + proj.Id);
        newcontact.setRedirect(true);
        return newcontact;
    }
    
    public static void pv_FieldsUpdate(SFDC_Project__c p) {
        
        // Get the Project fields we are interested in
        p = [select Id, Not_To_Exceed_Feas__c, Total_To_Invoice_Feasibility__c, Cost_To_Borrego_Feasibility__c,
                Cost_To_Customer_Feasibility__c, Fixed_Cost_Feasibility__c, Retainer_Amount_Left_Feasibility__c
                from SFDC_Project__c where Id = :p.Id];
        
        // Zero out the calculated Project fields
        p.Total_To_Invoice_Feasibility__c = 0;
        p.Cost_To_Borrego_Feasibility__c = 0;
        p.Cost_To_Customer_Feasibility__c = 0;
        p.Retainer_Amount_Left_Feasibility__c = 0;
        if (p.Not_To_Exceed_Feas__c == null) {
            p.Not_To_Exceed_Feas__c = 0;
        }
        
        Fixed_Cost__c[] fc;
        Retainer__c[] r;
        if (p.Fixed_Cost_Feasibility__c) {
            //Get the Fixed Cost items for this Project
            fc = [select Id, Project__c, Invoice__c, Amount__c, Stage__c from Fixed_Cost__c where Project__c = :p.Id];
        } else {        
            //Get the Retainer items for this Project
            r = [select Id, Project__c, Invoice__c, Amount__c, Stage__c from Retainer__c where Project__c = :p.Id];
        }
        
        // Get the Expense Line Items for this Project and calculate
        // Project Total To Invoice and Cost To Borrego
        ELI__c[] elis = [select Id, Project__c, Chargeback__c, Approved_Amount__c, Amount_On_Invoice__c, Invoice__c from ELI__c where Project__c = :p.Id];      
        for (Integer i=0; i<elis.size(); i++) {
            elis[i].Amount_On_Invoice__c = 0;
            if (elis[i].Chargeback__c == true) {
                p.Total_To_Invoice_Feasibility__c += elis[i].Approved_Amount__c;
            } else {
                p.Cost_To_Borrego_Feasibility__c += elis[i].Approved_Amount__c;
            }
        }
        
        //Calculate additional Cost To Borrego for ELI items on Fixed Cost projects.  Note - unfortunately
        //this does not match what may have happened on the real project because it does not simulate the
        //order in which all cost items were entered on the project.
        if (p.Fixed_Cost_Feasibility__c) {
            if (p.Total_To_Invoice_Feasibility__c > p.Not_To_Exceed_Feas__c) {
                p.Cost_To_Borrego_Feasibility__c += p.Total_To_Invoice_Feasibility__c - p.Not_To_Exceed_Feas__c;
            }
        }
            
        // Get the Time Entries for this Project and calculate
        // Project Total To Invoice and Cost To Borrego
        Time_Entry__c[] tes = [select Id, Project__c, Invoice__c, Hours__c, Total_Cost_Project_Calc__c, Total_Cost_Internal_Calc__c, Amount_On_Invoice__c from Time_Entry__c where Project__c = :p.Id];             
        for (Integer i=0; i<tes.size(); i++) {
            tes[i].Amount_On_Invoice__c = 0;
            p.Total_To_Invoice_Feasibility__c += tes[i].Total_Cost_Project_Calc__c;
            p.Cost_To_Borrego_Feasibility__c += tes[i].Total_Cost_Internal_Calc__c;
        }
    
        // Get the Project Costs for this Project and calculate
        // Project Total To Invoice and Cost To Borrego
        PCost__c[] pcs = [select Id, Project__c, Chargeback_to_Customer__c, Invoice__c, Amount__c, Cost_to_Borrego__c, Amount_On_Invoice__c from PCost__c where Project__c = :p.Id];              
        for(Integer i = 0; i<pcs.size(); i++){
            pcs[i].Amount_On_Invoice__c = 0;
            if (pcs[i].Chargeback_to_Customer__c == true) {
                p.Total_To_Invoice_Feasibility__c += pcs[i].Amount__c;
                if (pcs[i].Cost_to_Borrego__c != null) {
                    p.Cost_To_Borrego_Feasibility__c += pcs[i].Cost_to_Borrego__c;
                }
            } else {
                p.Cost_To_Borrego_Feasibility__c += pcs[i].Amount__c;
            }
        }
      
        // Get each of the Invoices ordered by Id (ascending) for this
        // Project and calculate Amount On Invoice field for each cost
        // item and Invoice fields Total Hours, Cost To Borrego Additional,
        // Total Charges and Cost To Customer
        Invoices__c[] inv = [select Id, Project__c, Status__c, Total_Hours__c, Cost_To_Borrego_Additional__c,
                Total_Charges__c, Total_Cost_Invoice__c, Cost_To_Customer__c, Retainer_Amount__c,
                Retainer_Amount_Used__c, Retainer_Available__c
                from Invoices__c where Project__c = :p.Id order by Id];
        
        for (Integer m=0; m<inv.size(); m++) {
            Decimal hours = 0;
            Decimal cost = 0;
            Decimal othercosts = 0;
            Double finalCost = 0;
            Decimal ctba = 0;
            Decimal ral = 0; 
                    
            if (p.Fixed_Cost_Feasibility__c) {
                
                //Process the Fixed Cost items on this Invoice
                for(Integer i=0; i<fc.size(); i++) {
                    if (fc[i].Invoice__c == inv[m].Id) {
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
                }
                
            } else {
            
                //Add up the Retainer Items on this invoice
                for(Integer i=0; i<r.size(); i++) {
                    if (r[i].Invoice__c == inv[m].Id) {
                        ral += r[i].Amount__c;
                    }
                }
                
                // Process the Expense Line items on this Invoice 1st
                for(Integer i=0; i<elis.size(); i++){               
                    if (elis[i].Invoice__c == inv[m].Id) {
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
                }
                
                // Process the Time Entry items on this Invoice 2nd
                for(Integer i=0; i<tes.size(); i++){
                    if (tes[i].Invoice__c == inv[m].Id) {
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
                }
                
                // Process the Project Cost items on this Invoice last
                for(Integer i=0; i<pcs.size(); i++){
                    if (pcs[i].Invoice__c == inv[m].Id) {
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
                }
            }
            
            // Determine Invoice field Total Charges, Total Cost Invoice, Total Hours, Cost To Customer,
            // and Cost To Borrego Additional
            inv[m].Total_Hours__c = hours;
            inv[m].Cost_To_Borrego_Additional__c = ctba;

            //Determine Total Cost Invoice
            if (ral == 0) {
                //No Retainer is on this invoice
                inv[m].Total_Cost_Invoice__c = cost;
            } else {
                //There is a Retainer selected for this invoice
                if (cost <= ral) {
                    inv[m].Total_Cost_Invoice__c = ral;
                } else {
                    inv[m].Total_Cost_Invoice__c = cost;
                }
            }

            //Determine amount of Retainer used on this invoice
            othercosts = cost;
            inv[m].Retainer_Amount_Used__c = 0;
            inv[m].Retainer_Amount__c = ral;
            inv[m].Retainer_Available__c = ral + p.Retainer_Amount_Left_Feasibility__c;
            inv[m].Cost_To_Customer__c = cost;
            if (ral > 0) {
                //There is Retainer costs on this invoice
                if (cost <= 0) {
                    //Retainer is the only thing on this invoice
                    cost = ral;
                    inv[m].Cost_To_Customer__c = 0;
                } else {
                    //This invoice has both Retainer and other costs on it
                    if (cost > ral + p.Retainer_Amount_Left_Feasibility__c) {
                        inv[m].Retainer_Amount_Used__c = ral + p.Retainer_Amount_Left_Feasibility__c;
                    } else {
                        inv[m].Retainer_Amount_Used__c = cost;
                        cost = ral;
                    }
                }
            } else {
                //No Retainer cost on this invoice
                ral = p.Retainer_Amount_Left_Feasibility__c;
                if (cost <= ral) {
                    inv[m].Retainer_Amount_Used__c = cost;
                    cost = 0;
                } else {
                    cost -= ral;
                    inv[m].Retainer_Amount_Used__c = ral;
                }
            }

            //Determine Total Charges on invoice considering Not To Exceed
            inv[m].Total_Charges__c = cost;
            if (p.Not_To_Exceed_Feas__c > 0 && (othercosts+p.Cost_To_Customer_Feasibility__c) > p.Not_To_Exceed_Feas__c) {
                finalCost = p.Not_To_Exceed_Feas__c - p.Cost_To_Customer_Feasibility__c - inv[m].Retainer_Amount_Used__c;
                if(finalCost > 0){
                    inv[m].Total_Charges__c = finalCost;
                    inv[m].Cost_To_Customer__c = finalCost;
                } else {
                    inv[m].Total_Charges__c = 0;
                    inv[m].Cost_To_Customer__c = 0;
                }
            }
            
            // Update the Project fields Cost To Customer and Cost To Borrego for
            // all approved invoices
            if (inv[m].Status__c == 'Approved' || inv[m].Status__c == 'Submitted to Customer' || inv[m].Status__c == 'Paid') {
                p.Cost_to_Customer_Feasibility__c += inv[m].Cost_To_Customer__c;
                p.Cost_To_Borrego_Feasibility__c += inv[m].Cost_To_Borrego_Additional__c;
                p.Retainer_Amount_Left_Feasibility__c += inv[m].Retainer_Amount__c;
                p.Retainer_Amount_Left_Feasibility__c -= inv[m].Retainer_Amount_Used__c;
            }           
        }
        
        // Now update the changed records
        Decimal updateProject = 0;
        if (p.Fixed_Cost_Feasibility__c) {
            if (fc.size() > 0) {
                update fc;
                updateProject = 1;
            }
        }
        if (elis.size() > 0) {
            update elis;
            updateProject = 1;
        }
        if (tes.size() > 0) {
            update tes;
            updateProject = 1;
        }
        if (pcs.size() > 0) {
            update pcs;
            updateProject = 1;
        }
        if (inv.size() > 0) {
            update inv;
            updateProject = 1;
        }
        if (updateProject == 1) {
            update p;
        }   
    }

     static testmethod void pvFieldsUpdateTest1() {
        
        AcctSeed__Project__c p = ProjectTest.setupTestProj();
        SFDC_Project__c p2 = ProjectTestOld.setupTestProj();
        p2.Project_Type__c = 'PV Direct';     
        p2.Cost_To_Customer_Feasibility__c = null;      
        p2.Billing_Status_Feasibility__c = 'New';
        p2.Total_To_Invoice_Feasibility__c = null;
        update p2;
        

        Cost_Code__c[] costcode = new Cost_Code__c[0];
        costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
        costcode.add(new Cost_Code__c(Name = 'Test02', Number__c = '80367', Category__c = 'M'));
        costcode.add(new Cost_Code__c(Name = 'Test03', Number__c = '80377', Category__c = 'O'));
        insert costcode;
    
        Budget__c budget = new Budget__c(Project__c = p2.Id);
        insert budget; 
        Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id,  
                                                            Pending_PO_Total__c = 0.0, PO_Total__c = 12);
        insert bli;
        
        Invoices__c[] inv = new Invoices__c[0];
        inv.add(new Invoices__c(project__c = p2.Id, Date__c = System.today(),
                                    Total_Charges__c = 745.89, Stage__c = 'Feasibility'));
        insert inv;
                                                         
        RecordType projE = [select Id from RecordType where Name = 'Project Expense'];
        ER__c er = new ER__c(User__c = p.OwnerId, Month_Ending__c = System.today());
        insert er;
        Test.startTest();
        ELI__c[] eli = new ELI__c[0];
        eli.add(new ELI__c(Expense_Header__c = er.Id, Cost_Code__c = costcode[0].Id,
                            Manager_Approval__c = true, RecordTypeId = projE.Id, Approved_Amount__c = 150.85, 
                            Stage__c = 'Feasibility', Chargeback__c = true, Invoice__c = inv[0].Id, PV_Direct__c = true, 
                            Cost_Miles__c = 258.75, Project__c = p2.Id));
        insert eli[0]; 

        Team_Member__c tm = new Team_Member__c(Project__c = p2.Id, User__c = p.OwnerId, Rate_Project__c = 35.67); 
        insert tm;
        Time_Entry__c[] te = new Time_Entry__c[0];
        te.add(new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p2.Id,
                                                Hours__c = 5, Stage__c = 'Feasibility'));                                                                     
        insert te[0];
        te[0].Invoice__c = inv[0].Id;
        update te[0];

        PCost__c[] pc = new PCost__c[0];
        pc.add(new PCost__c(Project__c = p2.Id, Vendor_Account__c = p.AcctSeed__Account__c, Amount__c = 768.98,
                                    Stage__c = 'Feasibility', Invoice__c = inv[0].Id, Chargeback_To_Customer__c = true));
        insert pc[0];
        
        Retainer__c[] r = new Retainer__c[0];
        r.add(new Retainer__c(Project__c = p2.Id, Amount__c = 400.00,
                                    Stage__c = 'Feasibility', Invoice__c = inv[0].Id));
        insert r[0];
        
        er.Status__c = 'Approved';
        update er;
      
        inv[0].Status__c = 'Approved';
        update inv;
        
        //p.Not_To_Exceed_Feas__c = 900;
        update p;
        
        p2.Not_To_Exceed_Feas__c = 900;
        update p2;
        
        pvFieldsUpdate.pv_FieldsUpdate(p2);
        
        Test.stopTest();
    }
    
    static testmethod void pvFieldsUpdateTest2() {
       
        AcctSeed__Project__c p2 = ProjectTest.setupTestProj();
        SFDC_Project__c p = ProjectTestOld.setupTestProj();
        p.Project_Type__c = 'PV Direct';     
        p.Cost_To_Customer_Feasibility__c = null;      
        p.Billing_Status_Feasibility__c = 'New';
        p.Total_To_Invoice_Feasibility__c = null;
        p.Fixed_Cost_Feasibility__c = true;
        p.Not_To_Exceed_Feas__c = 800;
        update p;

        Cost_Code__c[] costcode = new Cost_Code__c[0];
        costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
        costcode.add(new Cost_Code__c(Name = 'Test02', Number__c = '80367', Category__c = 'M'));
        costcode.add(new Cost_Code__c(Name = 'Test03', Number__c = '80377', Category__c = 'O'));
        insert costcode;
    
        Budget__c budget = new Budget__c(Project__c = p.Id);
        insert budget; 
        Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id,  
                                                            Pending_PO_Total__c = 0.0, PO_Total__c = 12);
        insert bli;
        
        Invoices__c[] inv = new Invoices__c[0];
        inv.add(new Invoices__c(Project__c = p.Id, Date__c = System.today(),
                                    Total_Charges__c = 745.89, Stage__c = 'Feasibility'));
        insert inv;
                                                         
        RecordType projE = [select Id from RecordType where Name = 'Project Expense'];
        ER__c er = new ER__c(User__c = p.OwnerId, Month_Ending__c = System.today());
        insert er;
        Test.startTest();
        ELI__c[] eli = new ELI__c[0];
        eli.add(new ELI__c(Expense_Header__c = er.Id, Cost_Code__c = costcode[0].Id,
                            Manager_Approval__c = true, RecordTypeId = projE.Id, Approved_Amount__c = 150.85, 
                            Stage__c = 'Feasibility', Chargeback__c = false, PV_Direct__c = true, 
                            Cost_Miles__c = 258.75, Project__c = p.Id));
        insert eli[0]; 

        Team_Member__c tm = new Team_Member__c(Project__c = p.Id, User__c = p.OwnerId, Rate_Project__c = 35.67); 
        insert tm;
        Time_Entry__c[] te = new Time_Entry__c[0];
        te.add(new Time_Entry__c(Team_Member__c = tm.Id, Project__c = p.Id,
                                                Hours__c = 5, Stage__c = 'Feasibility'));                                                                     
        insert te[0];

        PCost__c[] pc = new PCost__c[0];
        pc.add(new PCost__c(Project__c = p.Id, Vendor_Account__c = p.Account__c, Amount__c = 768.98,
                                    Stage__c = 'Feasibility', Chargeback_To_Customer__c = true));
        insert pc[0];
        
        Fixed_Cost__c[] fc = new Fixed_Cost__c[0];
        fc.add(new Fixed_Cost__c(Project__c = p.Id, Amount__c = 800.00,
                                    Stage__c = 'Feasibility', Invoice__c = inv[0].Id));
        insert fc[0];
        
        er.Status__c = 'Approved';
        update er;
      
        inv[0].Status__c = 'Approved';
        update inv;

        pvFieldsUpdate.pv_FieldsUpdate(p);
        
        Test.stopTest();
    }
}