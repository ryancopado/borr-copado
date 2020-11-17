public with sharing class DailySiteReportCtlExt {
    
    /*
     *  Daily Site Reports controller extension. Creates new daily site report records, auto-filling fields and creating
     *  related Labor records based upon the most recently created Daily Site Report record related to the Project.
     *
     */
    
    public class Labor_Class {
        public Labor__c labor {get; set;}
        public List<SelectOption> subConAccOptions {get; set;}
        public String totalHours {get; set;} // this is commented before
        public Boolean addLabor {get; set;}
        private String selectedSubConAcc;
        private Integer index;
        private DailySiteReportCtlExt thisDailySiteReportCtlExt;
        
        public Labor_Class(Labor__c lab, List<SelectOption> scaOptions, Boolean addL, DailySiteReportCtlExt dsr) {
            this.labor = lab;
            this.subConAccOptions = scaOptions;
            this.totalHours = calculateLaborTotalHours(lab); // this is commented before
            this.addLabor = addL;
            
            this.selectedSubConAcc = null;
            if (this.subConAccOptions != null) {
                for (SelectOption so :this.subConAccOptions) {
                    if (so.getValue() != '--None--') {
                        if (this.labor.SubContractor_Number__c == so.getValue()) {
                            this.selectedSubConAcc = so.getValue();
                        }
                    }
                }
            }
            
            this.thisDailySiteReportCtlExt = dsr;
            this.index = dsr.lcIndex;
            dsr.lcIndex++;
        }
        
        public String getselectedSubConAcc() {
            return this.selectedSubConAcc;
        }
        
        public void setselectedSubConAcc(String scId) {
            this.selectedSubConAcc = scId;
        }
        
        public PageReference subConNumber() {
            if (this.selectedSubConAcc != '--None--') {
                this.labor.Subcontractor_Number__c = this.selectedSubConAcc;
            } else {
                this.labor.Subcontractor_Number__c = null;
            }
            
            return null;
        }
        
        public PageReference subContractorNameLabor() {
            
            this.selectedSubConAcc = null;
            if (this.labor.Subcontractor_Number__c != null) {
                if (this.subConAccOptions != null) {
                    for (SelectOption so :this.subConAccOptions) {
                        if (so.getValue() != '--None--') {
                            if (this.labor.SubContractor_Number__c == so.getValue()) {
                                this.selectedSubConAcc = so.getValue();
                            }
                        }
                    }
                }
            }
            
            return null;
        }
        
       // this is commented before
        public PageReference changeLaborTotalHours() {
            this.totalHours = calculateLaborTotalHours(this.labor);
            system.debug('calculated total hours'+this.totalHours);
            return null;
        }
        // this is commented before
        private String calculateLaborTotalHours(Labor__c lab) {
        system.debug (' Entering the calcualtion');
            String totHours = null;
            if (lab.Hours__c != null && lab.Number_of_Workers__c != null) {
                totHours = String.valueOf(lab.Hours__c * lab.Number_of_Workers__c);
            }
            return totHours;
        }
        
        
        public PageReference addLaborRow() {
            List<Labor_Class> tempList = new List<Labor_Class>();
            
            for (Labor_Class lc :this.thisDailySiteReportCtlExt.newDSR.laborList) {
                if (!lc.addLabor) {
                    tempList.add(lc);
                }
            }
            
            this.thisDailySiteReportCtlExt.lcIndex = tempList.size();
            tempList.add(new Labor_Class(new Labor__c(), this.thisDailySiteReportCtlExt.subConComplianceOptions, false, this.thisDailySiteReportCtlExt));
            tempList.add(new Labor_Class(new Labor__c(), null, true, this.thisDailySiteReportCtlExt));
            this.thisDailySiteReportCtlExt.newDSR.laborList.clear();
            this.thisDailySiteReportCtlExt.newDSR.laborList.addAll(tempList);
            return null;
        }
        
        // Remove labor row from the list and mark for deletion from database
        public PageReference removeLaborRow() {
            List<Labor_Class> tempList = new List<Labor_Class>();
            Integer listIndex = 0;
            
            // Mark for deletion from database
            if (this.labor.Id != null) {
                this.thisDailySiteReportCtlExt.delLaborList.add(this.labor);
            }
                
            // Remove Labor record from our list
            for (Labor_Class lc :this.thisDailySiteReportCtlExt.newDSR.laborList) {
                if (lc.index != this.index) {
                    lc.index = listIndex;
                    listIndex++;
                    tempList.add(lc);
                }
            }
            
            this.thisDailySiteReportCtlExt.lcIndex = tempList.size();
            this.thisDailySiteReportCtlExt.newDSR.laborList.clear();
            this.thisDailySiteReportCtlExt.newDSR.laborList.addAll(tempList);
            
            return null;
        }
    }
    
    public class KeyTasksLaborTracking_Class {
        public KeyTasksLaborTracking__c keyTasks {get; set;}
        //public String totalHours {get; set;}
        public Boolean addKeyTasks {get; set;}
        private Integer index;
        private DailySiteReportCtlExt thisDailySiteReportCtlExt;
        
        public KeyTasksLaborTracking_Class(KeyTasksLaborTracking__c ktlt, Boolean addKt, DailySiteReportCtlExt dsr) {
            this.keyTasks = ktlt;
            //this.totalHours = calculateKeyTasksTotalHours(ktlt);
            this.addKeyTasks = addKt;
            this.thisDailySiteReportCtlExt = dsr;
            this.index = dsr.ktIndex;
            dsr.ktIndex++;
        }
        
        /*
        public PageReference changeKeyTasksTotalHours() {
            this.totalHours = calculateKeyTasksTotalHours(this.keyTasks);
            return null;
        }
        
        private String calculateKeyTasksTotalHours(KeyTasksLaborTracking__c kt) {
            String totHours = null;
            if (kt.Hours__c != null && kt.Number_of_Workers__c != null) {
                totHours = String.valueOf(kt.Hours__c * kt.Number_of_Workers__c);
            }
            return totHours;
        }
        */
        
        // Add one Key Tasks row
        public PageReference addKeyTasksRow() {
            List<KeyTasksLaborTracking_Class> tempList = new List<KeyTasksLaborTracking_Class>();
            
            for (KeyTasksLaborTracking_Class kt :this.thisDailySiteReportCtlExt.newDSR.keyTasksList) {
                if (!kt.addKeyTasks) {
                    tempList.add(kt);
                }
            }
            
            this.thisDailySiteReportCtlExt.ktIndex = tempList.size();
            tempList.add(new KeyTasksLaborTracking_Class(new KeyTasksLaborTracking__c(Hours__c = 0, Number_of_Workers__c = 0), false, this.thisDailySiteReportCtlExt));
            tempList.add(new KeyTasksLaborTracking_Class(new KeyTasksLaborTracking__c(), true, this.thisDailySiteReportCtlExt));
            this.thisDailySiteReportCtlExt.newDSR.keyTasksList.clear();
            this.thisDailySiteReportCtlExt.newDSR.keyTasksList.addAll(tempList);
            return null;
        }
        
        // Remove Key Tasks row from the list and mark for deletion from database
        public PageReference removeKeyTasksRow() {
            List<KeyTasksLaborTracking_Class> tempList = new List<KeyTasksLaborTracking_Class>();
            Integer listIndex = 0;
            
            // Add row to the delete list if necessary
            if (this.keyTasks.Id != null) {
                this.thisDailySiteReportCtlExt.delKeyTasksList.add(this.keyTasks);
            }
            
            // Remove Key Tasks record from our list
            for (KeyTasksLaborTracking_Class kt :this.thisDailySiteReportCtlExt.newDSR.keyTasksList) {
                if (kt.index != this.index) {
                    kt.index = listIndex;
                    listIndex++;
                    tempList.add(kt);
                }
            }
            
            this.thisDailySiteReportCtlExt.ktIndex = tempList.size();
            this.thisDailySiteReportCtlExt.newDSR.keyTasksList.clear();
            this.thisDailySiteReportCtlExt.newDSR.keyTasksList.addAll(tempList);
            
            return null;
        }
    }
    
    public class Equipment_Class {
        public Construction_Equipment_on_Site__c equipment {get; set;}
        public List<SelectOption> subConAccOptions {get; set;}
        public Boolean addEquipment {get; set;}
        private String selectedSubConAcc;
        private Integer index;
        private DailySiteReportCtlExt thisDailySiteReportCtlExt;
        
        public Equipment_Class(Construction_Equipment_on_Site__c equip, List<SelectOption> scaOptions, Boolean addE, DailySiteReportCtlExt dsr) {
            this.equipment = equip;
            this.subConAccOptions = scaOptions;
            this.addEquipment = addE;
            
            this.selectedSubConAcc = null;
            if (this.subConAccOptions != null) {
                for (SelectOption so :this.subConAccOptions) {
                    if (so.getValue() != '--None--') {
                        if (this.equipment.Subcontractor_Compliance_Number__c == so.getValue()) {
                            this.selectedSubConAcc = so.getValue();
                        }
                    }
                }
            }
            
            this.thisDailySiteReportCtlExt = dsr;
            this.index = dsr.eqIndex;
            dsr.eqIndex++;
        }
        
        public String getselectedSubConAcc() {
            return this.selectedSubConAcc;
        }
        
        public void setselectedSubConAcc(String scId) {
            this.selectedSubConAcc = scId;
        }
        
        public PageReference subConNumber() {
            if (this.selectedSubConAcc != '--None--') {
                this.equipment.Subcontractor_Compliance_Number__c = this.selectedSubConAcc;
            } else {
                this.equipment.Subcontractor_Compliance_Number__c = null;
            }
            
            return null;
        }
        
        public PageReference subContractorNameEquipment() {
            
            this.selectedSubConAcc = null;
            if (this.equipment.Subcontractor_Compliance_Number__c != null) {
                if (this.subConAccOptions != null) {
                    for (SelectOption so :this.subConAccOptions) {
                        if (so.getValue() != '--None--') {
                            if (this.equipment.Subcontractor_Compliance_Number__c == so.getValue()) {
                                this.selectedSubConAcc = so.getValue();
                            }
                        }
                    }
                }
            }
            
            return null;
        }
        
        // Add one Equipment row
        public PageReference addEquipmentRow() {
            List<Equipment_Class> tempList = new List<Equipment_Class>();
            
            for (Equipment_Class eq :this.thisDailySiteReportCtlExt.newDSR.equipmentList) {
                if (!eq.addEquipment) {
                    tempList.add(eq);
                }
            }
            
            this.thisDailySiteReportCtlExt.eqIndex = tempList.size();
            tempList.add(new Equipment_Class(new Construction_Equipment_on_Site__c(), this.thisDailySiteReportCtlExt.subConComplianceOptions, false, this.thisDailySiteReportCtlExt));
            tempList.add(new Equipment_Class(new Construction_Equipment_on_Site__c(), null, true, this.thisDailySiteReportCtlExt));
            this.thisDailySiteReportCtlExt.newDSR.equipmentList.clear();
            this.thisDailySiteReportCtlExt.newDSR.equipmentList.addAll(tempList);
            return null;
        }
        
        // Remove Equipment row from the list and mark for deletion from database
        public PageReference removeEquipmentRow() {
            List<Equipment_Class> tempList = new List<Equipment_Class>();
            Integer listIndex = 0;
            
            // Add row to the delete list if necessary
            if (this.equipment.Id != null) {
                this.thisDailySiteReportCtlExt.delEquipmentList.add(this.equipment);
            }
            
            // Remove Key Tasks record from our list
            for (Equipment_Class eq :this.thisDailySiteReportCtlExt.newDSR.equipmentList) {
                if (eq.index != this.index) {
                    eq.index = listIndex;
                    listIndex++;
                    tempList.add(eq);
                }
            }
            
            this.thisDailySiteReportCtlExt.eqIndex = tempList.size();
            this.thisDailySiteReportCtlExt.newDSR.equipmentList.clear();
            this.thisDailySiteReportCtlExt.newDSR.equipmentList.addAll(tempList);
            
            return null;
        }
    }
    
    public class MaterialsReceived_Class {
        public Materials_Received__c material {get; set;}
        public Boolean addMaterial {get; set;}
        private Integer index;
        private DailySiteReportCtlExt thisDailySiteReportCtlExt;
        
        
       public MaterialsReceived_Class(Materials_Received__c mat, Boolean addM, DailySiteReportCtlExt dsr) {
            this.material = mat;
            this.addMaterial = addM;
            this.thisDailySiteReportCtlExt = dsr;
            this.index = dsr.matIndex;
            dsr.matIndex++;
        }
        
        // Add one Material row
        public PageReference addMaterialRow() {
            List<MaterialsReceived_Class> tempList = new List<MaterialsReceived_Class>();
            
            for (MaterialsReceived_Class mr :this.thisDailySiteReportCtlExt.newDSR.materialList) {
                if (!mr.addMaterial) {
                    tempList.add(mr);
                }
            }
            
            this.thisDailySiteReportCtlExt.matIndex = tempList.size();
            tempList.add(new MaterialsReceived_Class(new Materials_Received__c(), false, this.thisDailySiteReportCtlExt));
            tempList.add(new MaterialsReceived_Class(new Materials_Received__c(), true, this.thisDailySiteReportCtlExt));
            this.thisDailySiteReportCtlExt.newDSR.materialList.clear();
            this.thisDailySiteReportCtlExt.newDSR.materialList.addAll(tempList);
            return null;
        }
        
        // Remove Material row from the list and mark for deletion from database
        public PageReference removeMaterialRow() {
            List<MaterialsReceived_Class> tempList = new List<MaterialsReceived_Class>();
            Integer listIndex = 0;
            
            // Add row to the delete list if necessary
            if (this.material.Id != null) {
                this.thisDailySiteReportCtlExt.delMaterialList.add(this.material);
            }
            
            // Remove Material record from our list
            for (MaterialsReceived_Class mr :this.thisDailySiteReportCtlExt.newDSR.materialList) {
                if (mr.index != this.index) {
                    mr.index = listIndex;
                    listIndex++;
                    tempList.add(mr);
                }
            }
            
            this.thisDailySiteReportCtlExt.matIndex = tempList.size();
            this.thisDailySiteReportCtlExt.newDSR.materialList.clear();
            this.thisDailySiteReportCtlExt.newDSR.materialList.addAll(tempList);
            
            return null;
        }
    }
    
    public class DSR_Class {
        public Daily_Site_Report__c dsr {get; set;}
        public List<Labor_Class> laborList {get; set;}
        public List<KeyTasksLaborTracking_Class> keyTasksList {get; set;}
        public List<Equipment_Class> equipmentList {get; set;}
        public List<MaterialsReceived_Class> materialList {get; set;}
        private DailySiteReportCtlExt thisDailySiteReportCtlExt;
        private Daily_Site_Report__c latestDSR;
        
        private List<Labor__c> latestLaborList;
        private List<Construction_Equipment_on_Site__c> latestEquipmentList;
        private List<Materials_Received__c> latestMaterialList;
        
        
        public DSR_Class(Daily_Site_Report__c dsReport, List<Labor_Class> labList, List<KeyTasksLaborTracking_Class> ktList, List<Equipment_Class> eqList, List<MaterialsReceived_Class> matList, DailySiteReportCtlExt dsr) {
            this.dsr = dsReport;
            this.laborList = labList;
            this.keyTasksList = ktList;
            this.equipmentList = eqList;
            this.materialList = matList; 
            this.thisDailySiteReportCtlExt = dsr;
            
                  
       
       // List<Equipment_Class> newEquipmentList = new List<Equipment_Class>();
       // List<MaterialsReceived_Class> newMaterialList = new List<MaterialsReceived_Class>();
       // List<KeyTasksLaborTracking__c> ktList;
                        
        }
        
        public PageReference dsrsiteChange() {
        
         List<Labor__c> newLaborList = new List<Labor__c>();
         List<Daily_Site_Report__c> existingDSRs = new List<Daily_Site_Report__c>();
            String dsrName;
            system.debug('SITE ID'+this.dsr.Site__c);
            system.debug('DSR NAME'+this.dsr.Name);
            
            If (this.dsr.Date__c != null) {
            Site__c st = [select Id, Name from Site__c where Id = :this.thisDailySiteReportCtlExt.getselectedSite()];
                  dsrName ='';
                  dsrName = (st.Name.length() > 67) ? st.Name.subString(0, 67) : st.Name;
                  this.dsr.Name ='';
                  this.dsr.Name = dsrName + ' - ' + this.dsr.Date__c.format();      
                  system.debug('THE FINAL RESULT'+this.dsr.Name);
                  }
           
           Else
            {
            
             ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Please Choose the Date.'));
             system.debug('Look Project'+this.dsr.project__c);
             system.debug('Look Site'+this.thisDailySiteReportCtlExt.getselectedSite());
    
                }             
              // code to update the labor, contruction and material table according to site change ..
                       existingDSRs = [select Id, Name, CreatedDate, Date__c, Site__c, Project__c  
                       from Daily_Site_Report__c where  site__c = :this.thisDailySiteReportCtlExt.getselectedSite() order by CreatedDate DESC limit 1]; //  
                       
                     if (!existingDSRs.isEmpty()) { 
                latestDSR = existingDSRs[0];
                latestLaborList = [select Id, Name, Daily_Site_Report__c, Subcontractor_Number__c, Subcontractor__c,Cost_Code__c, Hours__c, 
                        Number_of_Workers__c, Total_Hours__c, Work_Performed__c 
                        from Labor__c where Daily_Site_Report__c = :latestDSR.Id];
                latestEquipmentList = [select Id, Name, Daily_Site_Report__c, Date_Arrived__c, Date_Picked_Up__c, Days_on_Site_formula__c, 
                        Equipment_Type__c, Subcontractor_Compliance_Number__c, Subcontractor__c ,Equipment_Used_Today__c
                        from Construction_Equipment_on_Site__c where Daily_Site_Report__c = :latestDSR.Id];
                latestMaterialList = [select Id, Name, Company__c, Daily_Site_Report__c, Delivery_in_Full__c, Line_Item__c, 
                        Packing_Slip_BOL__c, PO__c, Product__c, Receiving_Individual__c , Date_Received__c
                        from Materials_Received__c where Daily_Site_Report__c = :latestDSR.Id];         
                        
                         this.thisDailySiteReportCtlExt.newDSR.laborList.clear();
                         this.thisDailySiteReportCtlExt.newDSR.EquipmentList.clear();
                         this.thisDailySiteReportCtlExt.newDSR.MaterialList.clear();
                         //this.thisDailySiteReportCtlExt.initSubConCompliance(clearlist);
                         this.thisDailySiteReportCtlExt.initSubConCompliance();
                         
                     
                         for (Labor__c l :latestLaborList) {
                        // this.thisDailySiteReportCtlExt.newDSR.laborList.add(new Labor_Class(l,this.thisDailySiteReportCtlExt.subConComplianceOptions,false,thisDailySiteReportCtlExt)); // 
                        this.thisDailySiteReportCtlExt.newDSR.laborList.add(new Labor_Class(new Labor__c(Subcontractor_Number__c = l.Subcontractor_Number__c),this.thisDailySiteReportCtlExt.subConComplianceOptions,false,thisDailySiteReportCtlExt));
                        }
                              system.debug('LABOR LIST LOOK HERE sitechange'+this.thisDailySiteReportCtlExt.newDSR.laborList);
                           
                           
                           for (Construction_Equipment_on_Site__c eq :latestEquipmentList) {
                           // this.thisDailySiteReportCtlExt.newDSR.EquipmentList.add(new Equipment_Class(eq,this.thisDailySiteReportCtlExt.subConComplianceOptions, false, thisDailySiteReportCtlExt));  
                            this.thisDailySiteReportCtlExt.newDSR.EquipmentList.add(new Equipment_Class(new Construction_Equipment_on_Site__c(Equipment_Type__c = eq.Equipment_Type__c, Subcontractor_Compliance_Number__c = eq.Subcontractor_Compliance_Number__c, Date_Arrived__c = eq.Date_Arrived__c, Date_Picked_Up__c = eq.Date_Picked_Up__c,Equipment_Used_Today__c=eq.Equipment_Used_Today__c),this.thisDailySiteReportCtlExt.subConComplianceOptions, false, thisDailySiteReportCtlExt));
                        }      
                        
                        for (Materials_Received__c mr :latestMaterialList) {
                        this.thisDailySiteReportCtlExt.newDSR.MaterialList.add(new MaterialsReceived_Class(new Materials_Received__c(Line_Item__c = mr.Line_Item__c, Product__c = mr.Product__c , PO__c = mr.PO__c, Receiving_Individual__c = mr.Receiving_Individual__c, Company__c = mr.Company__c, Delivery_in_Full__c = mr.Delivery_in_Full__c, Packing_Slip_BOL__c = mr.Packing_Slip_BOL__c, Date_Received__c = mr.Date_Received__c), false, thisDailySiteReportCtlExt));
                       // this.thisDailySiteReportCtlExt.newDSR.MaterialList.add(new MaterialsReceived_Class(mr, false, thisDailySiteReportCtlExt));
                       }
                  }  
                     Else {
                         this.thisDailySiteReportCtlExt.newDSR.laborList.clear();
                         this.thisDailySiteReportCtlExt.newDSR.EquipmentList.clear();
                         this.thisDailySiteReportCtlExt.newDSR.MaterialList.clear();
                         //this.thisDailySiteReportCtlExt.initSubConCompliance(clearlist);
                         this.thisDailySiteReportCtlExt.initSubConCompliance();
                  }  
                  
                if (this.thisDailySiteReportCtlExt.editMode) {
                this.thisDailySiteReportCtlExt.newDSR.laborList.add(new Labor_Class(new Labor__c(), null, true, thisDailySiteReportCtlExt));
                //this.thisDailySiteReportCtlExt.newKeyTasksList.add(new KeyTasksLaborTracking_Class(new KeyTasksLaborTracking__c(), true, thisDailySiteReportCtlExt));
                this.thisDailySiteReportCtlExt.newDSR.EquipmentList.add(new Equipment_Class(new Construction_Equipment_on_Site__c(), null, true, thisDailySiteReportCtlExt));
                this.thisDailySiteReportCtlExt.newDSR.MaterialList.add(new MaterialsReceived_Class(new Materials_Received__c(), true, thisDailySiteReportCtlExt));
                      }     
            return null;
        }
        
        public PageReference dsrDateChange() {
            String dsrName;
            system.debug('SITE ID'+this.dsr.Site__c);
            system.debug('DSR NAME'+this.dsr.Name);
            system.debug('Project Name'+this.dsr.project__c);
            
            if (String.isBlank(this.dsr.Name) && this.dsr.Site__c != null) {
                Site__c st = [select Id, Name from Site__c where Id = :this.thisDailySiteReportCtlExt.getselectedSite()]; //where Id = :this.dsr.Site__c];
                dsrName = (st.Name.length() > 67) ? st.Name.subString(0, 67) : st.Name;
                this.dsr.Name = dsrName + ' - ' + this.dsr.Date__c.format();
                system.debug('FIRST IF PART'+this.dsr.Name);
                 }
                ELSE {
                Site__c st = [select Id, Name from Site__c where Id = :this.thisDailySiteReportCtlExt.getselectedSite()]; //where Id = :this.dsr.Site__c];
                dsrName = (st.Name.length() > 67) ? st.Name.subString(0, 67) : st.Name;
                this.dsr.Name = dsrName + ' - ' + this.dsr.Date__c.format();
                system.debug('ELSEIF PART'+this.dsr.Name);                 
            }          
            
           /*
            if (String.isNotBlank(this.dsr.Name) && this.dsr.Site__c != null) {
                Site__c st = [select Id, Name from Site__c where Id = :this.thisDailySiteReportCtlExt.getselectedSite()]; //where Id = :this.dsr.Site__c];
                dsrName = (st.Name.length() > 67) ? st.Name.subString(0, 67) : st.Name;
                this.dsr.Name = dsrName + ' - ' + this.dsr.Date__c.format();
                system.debug('SECOND IF PART'+this.dsr.Name);
            }*/
            
            return null;
        }
        
        public PageReference dsrProjectChange() {
            
            // The Project has just changed, re-initialize the subcontractor compliance options
           this.thisDailySiteReportCtlExt.initSubConCompliance();
            
               for (Labor_Class lc :this.laborList) {
                lc.selectedSubConAcc = null;
                if (lc.labor.Subcontractor_Number__c != null) {
                    if (lc.subConAccOptions != null) {
                        for (SelectOption so :lc.subConAccOptions) {
                            if (so.getValue() != '--None--') {
                                if (lc.labor.SubContractor_Number__c == so.getValue()) {
                                    lc.selectedSubConAcc = so.getValue();
                                }
                            }
                        }
                    }
                }
            }
            
            for (Equipment_Class eq :this.equipmentList) {
                eq.selectedSubConAcc = null;
                if (eq.equipment.Subcontractor_Compliance_Number__c != null) {
                    if (eq.subConAccOptions != null) {
                        for (SelectOption so :eq.subConAccOptions) {
                            if (so.getValue() != '--None--') {
                                if (eq.equipment.Subcontractor_Compliance_Number__c == so.getValue()) {
                                    eq.selectedSubConAcc = so.getValue();
                                }
                            }
                        }
                    }
                }
                
            }
            
            return null;
        }
    }
    
    public DSR_Class newDSR {get; set;}
    public Boolean fatalError {get; set;}
    public Boolean editMode {get; set;}
    public Boolean labormode {get; set;}
    
    private Daily_Site_Report__c latestDSR;
    private Daily_Site_Report__c latestDSR1;
    private Daily_Site_Report__c newDSReport;
    private List<Labor__c> latestLaborList;
    private List<Labor__c> delLaborList;
    private List<KeyTasksLaborTracking__c> latestKeyTasksList;
    private List<KeyTasksLaborTracking__c> delKeyTasksList;
    private List<Construction_Equipment_on_Site__c> latestEquipmentList;
    private List<Construction_Equipment_on_Site__c> delEquipmentList;
    private List<Materials_Received__c> latestMaterialList;
    private List<Materials_Received__c> delMaterialList;
    private List<SelectOption> subConComplianceOptions;
    private Integer lcIndex = 0;
    private Integer ktIndex = 0;
    private Integer eqIndex = 0;
    private Integer matIndex = 0;
    private String projectId;
    private String dsrId;
    private String retURL;
    private Boolean isNew;
    private String selectedSite;
    
    // Instance handle for executing base methods from within wrapper instances
    private DailySiteReportCtlExt thisDailySiteReportCtlExt;
    
    public DailySiteReportCtlExt(ApexPages.StandardController stdController) {
        
        Dynamic_Field_Id_Setting__c fieldIds = Dynamic_Field_Id_Setting__c.getOrgDefaults();
        projectId = ApexPages.currentPage().getParameters().get('CF' + fieldIds.DailySiteReport_Project__c + '_lkid');
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        if (String.isBlank(projectId)) {
            isNew = false;
            Daily_Site_Report__c dsr = (Daily_Site_Report__c)stdController.getRecord();
            dsrId = dsr.Id;
            if (String.isNotBlank(dsrId)) {
                dsr = [select Id, Project__c from Daily_Site_Report__c where Id = :dsrId];
                projectId = dsr.Project__c;
            }
        } else {
            isNew = true;
        }
        editMode = (String.isBlank(retURL)) ? false : true;
        
        this.thisDailySiteReportCtlExt = (DailySiteReportCtlExt)this;
        fatalError = false;
        
        latestLaborList = new List<Labor__c>();
        delLaborList = new List<Labor__c>();
        latestKeyTasksList = new List<KeyTasksLaborTracking__c>();
        delKeyTasksList = new List<KeyTasksLaborTracking__c>();
        latestEquipmentList = new List<Construction_Equipment_on_Site__c>();
        delEquipmentList = new List<Construction_Equipment_on_Site__c>();
        latestMaterialList = new List<Materials_Received__c>();
        delMaterialList = new List<Materials_Received__c>();
        subConComplianceOptions = new List<SelectOption>();
        
        fatalError = false;
        if (String.isBlank(projectId)) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No Project Id. Daily Site Reports must be created from a Project.'));
            fatalError = true;
        }
    }
    
    // Initialize the Daily Site Report record and list of Labor records
    public PageReference initNewDSR() {
        newDSReport = new Daily_Site_Report__c();
        List<Labor_Class> newLaborList = new List<Labor_Class>();
        List<KeyTasksLaborTracking_Class> newKeyTasksList = new List<KeyTasksLaborTracking_Class>();
        List<Equipment_Class> newEquipmentList = new List<Equipment_Class>();
        List<MaterialsReceived_Class> newMaterialList = new List<MaterialsReceived_Class>();
        List<KeyTasksLaborTracking__c> ktList;
        List<Daily_Site_Report__c> existingDSRs = new List<Daily_Site_Report__c>();
         List<Daily_Site_Report__c> siteID = new List<Daily_Site_Report__c>();
        PageReference pr;
        
        
        if (!fatalError) {
            
            if (String.isNotBlank(dsrId)) {
                existingDSRs.add(getDailySiteReport(dsrId));
            } else {
                   
             existingDSRs = [select Id, Name, CreatedDate, Date__c, Site__c, Project__c  
                       from Daily_Site_Report__c where  Project__c = :projectId order by CreatedDate DESC limit 1]; //  
                       system.debug('Existing DSRs'+existingDSRs); 
                                  
            }
            if (!existingDSRs.isEmpty()) {
                                  
                latestDSR = existingDSRs[0];
                latestLaborList = [select Id, Name, Daily_Site_Report__c, Subcontractor_Number__c, Subcontractor__c,Cost_Code__c, Hours__c, 
                        Number_of_Workers__c, Total_Hours__c, Work_Performed__c 
                        from Labor__c where Daily_Site_Report__c = :latestDSR.Id];
                
                latestKeyTasksList = [select Id, Name, DailySiteReport__c, Hours__c, Number_of_Workers__c, TaskType__c, 
                        Total_Hours__c, Notes__c 
                        from KeyTasksLaborTracking__c where DailySiteReport__c = :latestDSR.Id];
                
                latestEquipmentList = [select Id, Name, Daily_Site_Report__c, Equipment_Used_Today__c,Date_Arrived__c, Date_Picked_Up__c, Days_on_Site_formula__c, 
                        Equipment_Type__c, Subcontractor_Compliance_Number__c, Subcontractor__c 
                        from Construction_Equipment_on_Site__c where Daily_Site_Report__c = :latestDSR.Id];
                
                latestMaterialList = [select Id, Name, Company__c, Daily_Site_Report__c, Delivery_in_Full__c, Line_Item__c, 
                        Packing_Slip_BOL__c, PO__c, Product__c, Receiving_Individual__c, Date_Received__c 
                        from Materials_Received__c where Daily_Site_Report__c = :latestDSR.Id];
            
            }
            if (latestDSR == null) {
                newDSReport.Project__c = projectId;
                pr = initSubConCompliance();
                
                ktList = defaultKeyTasksLaborTracking();
                for (KeyTasksLaborTracking__c kt :ktList) {
                    newKeyTasksList.add(new KeyTasksLaborTracking_Class(kt, false, thisDailySiteReportCtlExt));
                }
                
                newEquipmentList.add(new Equipment_Class(new Construction_Equipment_on_Site__c(), subConComplianceOptions, false, thisDailySiteReportCtlExt));
                
                newMaterialList.add(new MaterialsReceived_Class(new Materials_Received__c(), false, thisDailySiteReportCtlExt));
            } else {
                if (String.isBlank(dsrId)) {
                    newDSReport.Project__c = latestDSR.Project__c;
                    newDSReport.Site__c = latestDSR.Site__c;
                    pr = initSubConCompliance();
                        
                    for (Labor__c l :latestLaborList) {
                        newLaborList.add(new Labor_Class(new Labor__c(Subcontractor_Number__c = l.Subcontractor_Number__c), subConComplianceOptions, false, thisDailySiteReportCtlExt));
                    }
                    
                    if (latestKeyTasksList.isEmpty()) {
                        ktList = defaultKeyTasksLaborTracking();
                        for (KeyTasksLaborTracking__c kt :ktList) {
                            newKeyTasksList.add(new KeyTasksLaborTracking_Class(kt, false, thisDailySiteReportCtlExt));
                        }
                    } else {
                        for (KeyTasksLaborTracking__c kt :latestKeyTasksList) {
                            newKeyTasksList.add(new KeyTasksLaborTracking_Class(new KeyTasksLaborTracking__c(TaskType__c = kt.TaskType__c), false, thisDailySiteReportCtlExt));
                        }
                    }
                    
                    if (latestEquipmentList.isEmpty()) {
                        newEquipmentList.add(new Equipment_Class(new Construction_Equipment_on_Site__c(), subConComplianceOptions, false, thisDailySiteReportCtlExt));
                    } else {
                        for (Construction_Equipment_on_Site__c eq :latestEquipmentList) {
                            newEquipmentList.add(new Equipment_Class(new Construction_Equipment_on_Site__c(Equipment_Type__c = eq.Equipment_Type__c, Subcontractor_Compliance_Number__c = eq.Subcontractor_Compliance_Number__c, Date_Arrived__c = eq.Date_Arrived__c, Date_Picked_Up__c = eq.Date_Picked_Up__c), subConComplianceOptions, false, thisDailySiteReportCtlExt));
                        }
                    }
                    
                   for (Materials_Received__c mr :latestMaterialList) {
                        system.debug('DISPLAY MATERIAL LIST' +latestMaterialList);
                       // newMaterialList.add(new MaterialsReceived_Class(mr, false, thisDailySiteReportCtlExt));
                        newMaterialList.add(new MaterialsReceived_Class(new Materials_Received__c(Line_Item__c = mr.Line_Item__c, Product__c = mr.Product__c , PO__c = mr.PO__c, Receiving_Individual__c = mr.Receiving_Individual__c, Company__c = mr.Company__c, Delivery_in_Full__c = mr.Delivery_in_Full__c, Packing_Slip_BOL__c = mr.Packing_Slip_BOL__c, Date_Received__c = mr.Date_Received__c), false, thisDailySiteReportCtlExt));
                    } 
                 // newMaterialList.add(new MaterialsReceived_Class(new Materials_Received__c(), true, thisDailySiteReportCtlExt));
                    
                } else {
                    newDSReport = latestDSR;
                    pr = initSubConCompliance();
                    
                    for (Labor__c l :latestLaborList) {
                        newLaborList.add(new Labor_Class(l, subConComplianceOptions, false, thisDailySiteReportCtlExt));
                    }
                    
                    for (KeyTasksLaborTracking__c kt :latestKeyTasksList) {
                        newKeyTasksList.add(new KeyTasksLaborTracking_Class(kt, false, thisDailySiteReportCtlExt));
                    }
                    
                    for (Construction_Equipment_on_Site__c eq :latestEquipmentList) {
                        newEquipmentList.add(new Equipment_Class(eq, subConComplianceOptions, false, thisDailySiteReportCtlExt));
                    }
                    
                    for (Materials_Received__c mr :latestMaterialList) {
                        newMaterialList.add(new MaterialsReceived_Class(mr, false, thisDailySiteReportCtlExt));
                    }
                }
            }
            if (editMode) {
                newLaborList.add(new Labor_Class(new Labor__c(), null, true, thisDailySiteReportCtlExt));
                newKeyTasksList.add(new KeyTasksLaborTracking_Class(new KeyTasksLaborTracking__c(), true, thisDailySiteReportCtlExt));
                newEquipmentList.add(new Equipment_Class(new Construction_Equipment_on_Site__c(), null, true, thisDailySiteReportCtlExt));
                newMaterialList.add(new MaterialsReceived_Class(new Materials_Received__c(), true, thisDailySiteReportCtlExt));
            }
        }
        
        newDSR = new DSR_Class(newDSReport, newLaborList, newKeyTasksList, newEquipmentList, newMaterialList, thisDailySiteReportCtlExt);
        
        return null;
    }
    
    // Read in all fields of an existing Daily Site Report and return the record
    private Daily_Site_Report__c getDailySiteReport(Id dsrId) {
        String selects;
        Daily_Site_Report__c dsr;
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get('Daily_Site_Report__c').getDescribe().Fields.getMap();
        List<string> selectFields = new List<string>();
        
        if (fMap != null) {
            for (Schema.SObjectField ft : fMap.values()) {
                Schema.DescribeFieldResult fd = ft.getDescribe();
                selectFields.add(fd.getName());
            }
        }
        selects = '';
        if (!selectFields.isEmpty()) {
            for (string s:selectFields) {
                selects += s + ',';
            }
            if (selects.endsWith(',')) {
                selects = selects.substring(0,selects.lastIndexOf(','));
            }
        }
        
        dsr = (Daily_Site_Report__c)Database.query('SELECT ' + selects + ' FROM Daily_Site_Report__c WHERE Id = \'' + dsrId + '\'');
        return dsr;
    }
    
    // Returns a new list of KeyTasksLaborTracking__c records - one for each TaskType__c picklist value
    private List<KeyTasksLaborTracking__c> defaultKeyTasksLaborTracking() {
        List<KeyTasksLaborTracking__c> ktList = new List<KeyTasksLaborTracking__c>();
        
        // Determine all of the picklist values for the TaskType__c field
        List<String> pickvalsList = new List<String>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get('KeyTasksLaborTracking__c');
        Sobject Object_name = targetType.newSObject();
        Schema.SObjectType sobject_type = Object_name.getSObjectType();
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe();
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap();
        List<Schema.PicklistEntry> pick_list_values = field_map.get('TaskType__c').getDescribe().getPickListValues();
        for (Schema.PicklistEntry a :pick_list_values) {
            pickvalsList.add(a.getValue());
        }
        
        // Create one new KeyTasksLaborTracking__c for each TaskType__c picklist value
        for (String s :pickvalsList) {
            ktList.add(new KeyTasksLaborTracking__c(TaskType__c = s, Hours__c = 0, Number_of_Workers__c = 0));
        }
        
        return ktList;
    }
    
    public PageReference initSubConCompliance() {
        subConComplianceOptions.clear();
        subConComplianceOptions.add(new SelectOption('--None--', '--None--'));
        
        if (newDSReport.Project__c != null) {
            List<ProjectPartner__c> ppList = new List<ProjectPartner__c>();
            ppList = [select Id, Name, ASProject__c, AccountId__c, AccountId__r.Name 
                        from ProjectPartner__c where ASProject__c = :newDSReport.Project__c];
            for (ProjectPartner__c pp :ppList) {
                subConComplianceOptions.add(new SelectOption(pp.Id, pp.AccountId__r.Name));
            }
        }
        
        return null;
    }
    
    // Get the list of Site records related to the Project on the Daily Site Report
    public List<SelectOption> getsites() {
        List<SelectOption> siteOptions = new List<SelectOption>();
        List<Site__c> siteList = new List<Site__c>();
        
        selectedSite = null;
       // siteOptions.add(new SelectOption('--None--','--None--'));
        if (newDSR.dsr.Project__c != null) {
            siteList = [select Id, Name, Project__c from Site__c where Project__c = :newDSR.dsr.Project__c or Id = :newDSR.dsr.Site__c order by Name];
            for (Site__c s :siteList) {
                siteOptions.add(new SelectOption(s.Id, s.Name));
                if (newDSR.dsr.Site__c == s.Id) {
                    selectedSite = s.Id;
                }
            }
            
            if (selectedSite == null) {
                if (siteOptions.size() == 2) {
                    selectedSite = siteOptions[1].getValue();
                } else {
                    selectedSite = siteOptions[0].getValue();
                }
            }
        }
        
        return siteOptions;
    }
    
    public String getselectedSite() {
        return selectedSite;
    }
    
    public void setselectedSite(String sId) {
        selectedSite = sId;
    }
    
    public PageReference editDSR() {
        
        editMode = true;
        newDSR.laborList.add(new Labor_Class(new Labor__c(), null, true, thisDailySiteReportCtlExt));
        newDSR.keyTasksList.add(new KeyTasksLaborTracking_Class(new KeyTasksLaborTracking__c(), true, thisDailySiteReportCtlExt));
        newDSR.equipmentList.add(new Equipment_Class(new Construction_Equipment_on_Site__c(), null, true, thisDailySiteReportCtlExt));
        newDSR.materialList.add(new MaterialsReceived_Class(new Materials_Received__c(), true, thisDailySiteReportCtlExt));
        return null;
    }
    
    //public PageReference backToProject() {
    
       // newDSR.AcctSeed__Project__c.Id
    
   // }
    
    public PageReference saveDSR() {
        PageReference pr = null;
        Boolean reqFieldsMissing = false;
        String reqFieldErrMsg = 'Error: You must enter a value';
        
        // Verify required fields have been filled out
        if (String.isBlank(newDSR.dsr.Name)) {
            newDSR.dsr.Name.addError(reqFieldErrMsg);
            reqFieldsMissing = true;
        }
        if (newDSR.dsr.Date__c == null) {
            newDSR.dsr.Date__c.addError(reqFieldErrMsg);
            reqFieldsMissing = true;
        }
        if (newDSR.dsr.Project__c == null) {
            newDSR.dsr.Project__c.addError(reqFieldErrMsg);
            reqFieldsMissing = true;
        }
        if (String.isBlank(selectedSite) || selectedSite == '--None--') {
            newDSR.dsr.Site__c.addError(reqFieldErrMsg);
            reqFieldsMissing = true;
        } else {
            newDSR.dsr.Site__c = selectedSite;
        }
        
        for (Labor_Class lc :newDSR.laborList) {
            if (!lc.addLabor) {
                if (lc.labor.Subcontractor_Number__c == null) {
                    lc.labor.Subcontractor_Number__c.addError(reqFieldErrMsg);
                    reqFieldsMissing = true;
                }
                 if (lc.labor.Cost_Code__c == null) {
                    lc.labor.Cost_Code__c.addError(reqFieldErrMsg);
                    reqFieldsMissing = true;
                }
                if (lc.labor.Number_of_Workers__c == null) {
                    lc.labor.Number_of_Workers__c.addError(reqFieldErrMsg);
                    reqFieldsMissing = true;
                }
                if (lc.labor.Hours__c == null) {
                    lc.labor.Hours__c.addError(reqFieldErrMsg);
                    reqFieldsMissing = true;
                }
                if (lc.labor.Work_Performed__c == null) {
                    lc.labor.Work_Performed__c.addError(reqFieldErrMsg);
                    reqFieldsMissing = true;
                }
            }
        }
        
        if (!reqFieldsMissing) {
            Savepoint sp = Database.setSavepoint();
            try {
                // Save the new/modified records
                system.debug('SAVE START HERE');
                system.debug('SAVEPOINT' +sp);
                system.debug('DSR RECORD' +newDSR.dsr);
                upsert newDSR.dsr;
                upsert newDSR.dsr;
                List<Labor__c> laborList = new List<Labor__c>();
                for (Labor_Class lc :newDSR.laborList) {
                    if (!lc.addLabor) {
                        if (lc.labor.Daily_Site_Report__c == null) {
                            lc.labor.Daily_Site_Report__c = newDSR.dsr.Id;
                        }
                        laborList.add(lc.labor);
                    }
                }
                if (!laborList.isEmpty()) {
                    upsert laborList;
                }
                /*
                List<KeyTasksLaborTracking__c> keyTasksList = new List<KeyTasksLaborTracking__c>();
                for (KeyTasksLaborTracking_Class kt :newDSR.keyTasksList) {
                    if (!kt.addKeyTasks) {
                        if (kt.keyTasks.DailySiteReport__c == null) {
                            kt.keyTasks.DailySiteReport__c = newDSR.dsr.Id;
                        }
                        keyTasksList.add(kt.keyTasks);
                    }
                }
                if (!keyTasksList.isEmpty()) {
                    upsert keyTasksList;
                } */
                
                List<Construction_Equipment_on_Site__c> equipmentList = new List<Construction_Equipment_on_Site__c>();
                SYSTEM.DEBUG('MATERIAL LIST'  +newDSR.equipmentList);
                for (Equipment_Class eq :newDSR.equipmentList) {
                    if (!eq.addEquipment) {
                        if (eq.equipment.Daily_Site_Report__c == null) {
                            eq.equipment.Daily_Site_Report__c = newDSR.dsr.Id;
                        }
                        equipmentList.add(eq.equipment);
                    }
                }
                SYSTEM.DEBUG('equipment LIST' + equipmentList);
                if (!equipmentList.isEmpty()) {
                    upsert equipmentList;
                }
                
                List<Materials_Received__c> materialList = new List<Materials_Received__c>();
                SYSTEM.DEBUG('MATERIAL LIST'  +newDSR.materialList);
                for (MaterialsReceived_Class mr :newDSR.materialList) {
                    if (!mr.addMaterial) {
                    system.debug('CHECK HERE' +mr.addMaterial);
                    system.debug('the material list ID' +mr.material.Daily_Site_Report__c);
                        if (mr.material.Daily_Site_Report__c == null) {
                        
                            mr.material.Daily_Site_Report__c = newDSR.dsr.Id;
                            //system.debug('the material list ID' +newDSR.dsr.Id);
                        }
                        materialList.add(mr.material);
                    }
                }
                SYSTEM.DEBUG('MATERIAL LIST'  +materialList);
                if (!materialList.isEmpty()) {
                    upsert materialList;
                }
                
                // delete records if indicated
                if (!delLaborList.isEmpty()) {
                    delete delLaborList;
                }
                if (!delKeyTasksList.isEmpty()) {
                    delete delKeyTasksList;
                }
                if (!delEquipmentList.isEmpty()) {
                    delete delEquipmentList;
                }
                if (!delMaterialList.isEmpty()) {
                    delete delMaterialList;
                }
                
                if (isNew) {
                    isNew = false;
                    retURL = '';
                }
                
                if (String.isNotBlank(retURL)) {
                    pr = new PageReference(retURL);
                    pr.setRedirect(true);
                } else {
                    editMode = false;
                    dsrId = newDSR.dsr.Id;
                    projectId = newDSR.dsr.Project__c;
                    pr = initNewDSR();
                }
                
            } catch(Exception e) {
                Database.rollback(sp);
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Exception: ' + e.getMessage()));
            }
        } else {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Invalid Data. Review all error messages below to correct your data.'));
        }
        
        return pr;
    }
}