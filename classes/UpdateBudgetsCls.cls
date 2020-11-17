public without sharing class UpdateBudgetsCls {
	
    private String lockStyle = '';
    private String unlockStyle = '';
    public List<AcctSeed__Project_Task__c> projectTasks{get;set;}
    public List<projectTaskWrapper> projectTasksWrappers{get;set;}
    public AcctSeed__Project__c theProject{get;set;}
    public double PMBudgetTotal {get;set;}
    public double ActiveBudgetTotal {get;set;}
    public double POsTotal {get;set;}
    public double SalesTotal {get;set;}
    public double LineItemGrandTotal {get; set;}
    public double COsGrandTotal {get; set;}
    public double CTDGrandTotal {get; set;}
    public double RemCOsGrandTotal {get; set;}
    public double NonPOCostsGrandTotal {get; set;}
    
    public UpdateBudgetsCls(ApexPages.StandardController stdController) {
        
        projectTasksWrappers = new List<projectTaskWrapper> ();
        
        theProject = (AcctSeed__Project__c)stdController.getRecord();
        
        //projectTasks = [select Id,Name,Cost_Code__r.Name,Cost_Code__r.Category__c,AcctSeed__Budgeted_Amount__c,PM_Budget__c,Active_Budget__c,Roll_Up_Purchase_Order_Line_Totals__c,Notes__c,(select id, Name,AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Product__r.Name,  AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Purchase_Order__r.AcctSeedERP__Vendor__r.Name,Status__c,AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Total__c, AcctSeedERP__Purchase_Order_Line__r.POLine_Total__c, AcctSeedERP__Purchase_Order_Line__r.Name, AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c,AcctSeedERP__Purchase_Order_Line__r.Id from AcctSeedERP__Sales_Order_Line__r) from AcctSeed__Project_Task__c where  AcctSeed__Project__c=:theProject.Id and recordType.Name = 'Budget Line Item'];
        
        projectTasks = [select Id,Name,Cost_Code__r.Name,Cost_Code__r.Category__c,Cost_Code__r.Number__c,AcctSeed__Budgeted_Amount__c,PM_Budget__c,Active_Budget__c,Roll_Up_Purchase_Order_Line_Totals__c,Notes__c,Total_Actual_Costs__c, Non_PO_Costs_Currency__c, Line_Item_Total__c, Cost_Code__r.Grouping__c, Sales_Budget__c, Not_In_Rollup__c, RecordTypeId, 
                                (select  Name,AcctSeedERP__Product__r.Name,  Roll_Up_All_Account_Payable_Lines__c,AcctSeedERP__Purchase_Order__r.AcctSeedERP__Vendor__r.Name,AcctSeedERP__Total__c,POLine_Total__c, AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c,AcctSeedERP__Purchase_Order__r.Change_Order_Total__c,AcctSeedERP__Purchase_Order__c,Id from AcctSeedERP__Purchase_Order_Lines__r where AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c != 'Canceled' and AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c != 'Rejected' order by AcctSeedERP__Purchase_Order__r.AcctSeedERP__Vendor__r.Name ) ,
                                (select id,Name,Status__c,AcctSeedERP__Purchase_Order_Line__c from AcctSeedERP__Sales_Order_Line__r ),
                                (select id,Vendor_Account__r.name,Vendor_Account__c,Name,Purchase_Order2__c,Status__c,Amount_Requested__c,AP_Line_CO_Total__c from Change_Orders__r where Status__c = 'Approved' or Status__c = 'Borrego Approved' order by Vendor_Account__r.name ) 
                                from AcctSeed__Project_Task__c where AcctSeed__Project__c=:theProject.Id and recordType.Name = 'Budget Line Item' and (not Name like '%Retainage%')];
        
        
        for(AcctSeed__Project_Task__c pt:projectTasks){
            projectTasksWrappers.add(new projectTaskWrapper(pt));
        }
        
        if (theProject.PM_Lock__c) {
            lockStyle = 'display:none';
        } else {
            unlockStyle = 'display:none';
        }
        
        initSums();
    
        
    }
    
    
    
    public Boolean getAmISysAdmin(){
        
        List<String> Profiles = new List<String> {'Sys Admin w/o HR','System Administrator'};
        
        List<profile> theprofiles = [select id from profile where id=:Userinfo.getProfileId() and name in: Profiles];
        
        return !theprofiles.isEmpty();
    }
    
    
    public Boolean getAmIPM(){
        
        List<String> PMProfiles = new List<String> {'Sys Admin w/o HR','System Administrator','Borrego - PM','Borrego - COO','Borrego-Dir of Ops','Engineering- Apps Engineer','Procurement'};
        
        List<profile> profiles = [select id from profile where id=:Userinfo.getProfileId() and  name in: PMProfiles];
        
        return !profiles.isEmpty();
    }
    
    public Boolean getAmIApps() {
        List<Profile> profiles = new List<Profile>();
        profiles = [select Id from Profile where Id = :Userinfo.getProfileId() and  Name = 'Engineering- Apps Engineer'];
        return !profiles.isEmpty();
    }
    
    
    public void initSums() {
        
        PMBudgetTotal = 0;
        ActiveBudgetTotal = 0; 
        POsTotal = 0;
        SalesTotal = 0;
        LineItemGrandTotal = 0;
        COsGrandTotal = 0;
        CTDGrandTotal = 0;
        RemCOsGrandTotal = 0;
        NonPOCostsGrandTotal = 0;
        
        for (AcctSeed__Project_Task__c task:projectTasks) {
            if (task.PM_Budget__c != null && !task.Not_In_Rollup__c) {
                PMBudgetTotal += task.PM_Budget__c;
            }
            if (task.Sales_Budget__c != null && !task.Not_In_Rollup__c) {
                SalesTotal += task.Sales_Budget__c;
            }
            if (task.Active_Budget__c != null && !task.Not_In_Rollup__c) {
                ActiveBudgetTotal += task.Active_Budget__c;
            }
            if (task.Roll_Up_Purchase_Order_Line_Totals__c != null) {
                POsTotal += task.Roll_Up_Purchase_Order_Line_Totals__c;
            }
            if (task.Total_Actual_Costs__c != null) {
                CTDGrandTotal += task.Total_Actual_Costs__c;
            }
            if (task.Non_PO_Costs_Currency__c != null) {
                NonPOCostsGrandTotal += task.Non_PO_Costs_Currency__c;
            }
        } 
        for (projectTaskWrapper ptw :projectTasksWrappers) {
            LineItemGrandTotal += ptw.totalLineItem;
            COsGrandTotal += ptw.totalChangeOrder;
            RemCOsGrandTotal += ptw.totalRemCOs;
        }
        
    }
    
    public String getLock(){
            return lockStyle;
    }
    public String getUnlock(){
            return unlockStyle;
    }
	
    public PageReference PMsave() {
        update projectTasks;
        return null;
    }
    
    /*
    public PageReference saveBudgetComment() {
        
        PageReference pr = null;
        
        // Save the new budget comment on the project record
        try {
            update theProject;
            pr = new PageReference('/apex/Update_Budgets?id=' + theProject.Id);
            pr.setRedirect(true);
        } catch (Exception e) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
        
        return pr;
    }
    */
    
    public PageReference SaveIt() {
        
        PageReference pr = null;
        
        // If Active Budget or PM Budget have changed by $10K or more, make sure there is an explanation why
        Boolean saveProject = false;
        Double activeBudget = 0;
        Double pmBudget = 0;
        String explainBudget = '';
        for (AcctSeed__Project_Task__c pt :projectTasks) {
            if (!pt.Not_In_Rollup__c) {
                if (pt.PM_Budget__c != null) {
                    pmBudget += pt.PM_Budget__c;
                }
                if (pt.Active_Budget__c != null) {
                    activeBudget += pt.Active_Budget__c;
                }
            }
        }
        List<AcctSeed__Project__c> proj = new List<AcctSeed__Project__c>();
        proj = [select Id, Active_Budget__c, PM_Budget__c, Margin_Change_Explanation__c from AcctSeed__Project__c where Id = :theProject.Id];
        
        if (proj[0].Margin_Change_Explanation__c != theProject.Margin_Change_Explanation__c) {
        	saveProject = true;
        }
        if (math.abs(pmBudget - proj[0].PM_Budget__c) >= 10000 || math.abs(activeBudget - proj[0].Active_Budget__c) >= 10000) {
            if (String.isBlank(theProject.Margin_Change_Explanation__c) || proj[0].Margin_Change_Explanation__c == theProject.Margin_Change_Explanation__c) {
                explainBudget = 'Active and/or PM budget has changed, please provide an explanation for the change.';
            }
        }
        
        if (String.isBlank(explainBudget)) {
            
            for (AcctSeed__Project_Task__c pt :projectTasks) {
                if (!theProject.PM_Lock__c) {
                    pt.AcctSeed__Budgeted_Amount__c = pt.Sales_Budget__c;
                }
            }
            
            try {
                if (saveProject) {
                    update theProject;
                }
                update projectTasks;
                pr = new PageReference('/apex/Update_Budgets?id=' + theProject.Id);
                pr.setRedirect(true);
            } catch (Exception e) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
        } else {
            theProject.Margin_Change_Explanation__c.addError(explainBudget);
        }
        
        return pr; 
    }
    
    
    public PageReference LockIt() {
        
        Boolean updatePTs = false;
        theProject.PM_Lock__c = true;
        theProject.Contract_Price_at_Budget_Lock__c = theProject.Final_Contract_PriceProject__c;
        theProject.Date_Projection_Locked__c = system.today();
        update theProject;
        
        // Cause the remaining available budget to be rolled-up from construction requesition records (Sales Order Line) 
        // related to the project to the parent con req group record.
        List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
        List<AcctSeedERP__Sales_Order_Line__c> solUpList = new List<AcctSeedERP__Sales_Order_Line__c>();
        solList = [select Id, AcctSeedERP__Project__c, Con_Req_Group__c, RollUp_Remaining_Available_Budget__c  
                from AcctSeedERP__Sales_Order_Line__c where  AcctSeedERP__Project__c = :theProject.Id];
        
        for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
            if (sol.Con_Req_Group__c != null) {
                sol.RollUp_Remaining_Available_Budget__c = !sol.RollUp_Remaining_Available_Budget__c;
                solUpList.add(sol);
            }
        }
        
        if (!solUpList.isEmpty()) {
            update solUpList;
        }
        
        for(AcctSeed__Project_Task__c task:projectTasks){
            if(task.Active_Budget__c == null || task.Active_Budget__c == 0){
                task.Active_Budget__c = task.PM_Budget__c ;
                updatePTs = true;
            }
        } 
        if (updatePTs) {
            update projectTasks;
        }
        
        PageReference budgetPage = new PageReference('/apex/Update_Budgets?id=' + theProject.Id);
        budgetPage.setRedirect(true);

        return budgetPage; 
    }
    
    
    public PageReference unLockIt() {
        
        theProject.PM_Lock__c = false;
        update theProject;
        
        // Cause the remaining available budget to be rolled-up from construction requesition records (Sales Order Line) 
        // related to the project to the parent con req group record.
        List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
        List<AcctSeedERP__Sales_Order_Line__c> solUpList = new List<AcctSeedERP__Sales_Order_Line__c>();
        solList = [select Id, AcctSeedERP__Project__c, Con_Req_Group__c, RollUp_Remaining_Available_Budget__c  
                from AcctSeedERP__Sales_Order_Line__c where  AcctSeedERP__Project__c = :theProject.Id];
        
        for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
            if (sol.Con_Req_Group__c != null) {
                sol.RollUp_Remaining_Available_Budget__c = !sol.RollUp_Remaining_Available_Budget__c;
                solUpList.add(sol);
            }
        }
        
        if (!solUpList.isEmpty()) {
            update solUpList;
        }
        
        PageReference budgetPage = new PageReference('/apex/Update_Budgets?id=' + theProject.Id);
        budgetPage.setRedirect(true);

        return budgetPage; 
    }
	
	public PageReference LockSalesBudget() {
		
		theProject.Sales_Budget_Locked__c = true;
		theProject.Date_Sales_Budget_Locked__c = system.today();
		update theProject;
		
		for (AcctSeed__Project_Task__c task :projectTasks) {
			task.PM_Budget__c = task.Sales_Budget__c;
		} 
		
		update projectTasks;
		
		PageReference budgetPage = new PageReference('/apex/Update_Budgets?id=' + theProject.Id);
		budgetPage.setRedirect(true);
		
		return budgetPage; 
	}
	
	public PageReference unLockSalesBudget() {
		theProject.Sales_Budget_Locked__c = false;
		update theProject;
		
		PageReference budgetPage = new PageReference('/apex/Update_Budgets?id=' + theProject.Id);
		budgetPage.setRedirect(true);
		
		return budgetPage;
	}
    
    public PageReference Cancel() {
        
        PageReference budgetPage = new PageReference('/' + theProject.Id);
        budgetPage.setRedirect(true);

        return budgetPage; 
    }
    
    private String sortColumn = null;
    private Boolean sortASC = false;
    
    // Sort the list of Line Items (Project Tasks) based upon the column parameter provided
    public pageReference sortLineItems() {
        String colName;
        List<AcctSeed__Project_Task__c> sortedList = new List<AcctSeed__Project_Task__c>();
        
        colName = ApexPages.currentPage().getParameters().get('columnSort');
        
        system.debug('***** colName = ' + colName);
        system.debug('***** projectTasks.size = ' + projectTasks.size());
        
        // First do the basic sort by Name field, then sort based upon the column parameter
        projectTasks.sort();
        
        if (colName == sortColumn) {
            sortASC = !sortASC;
        } else {
            sortASC = true;
        }
        sortColumn = colName;
        
        sortedList = lineItemSort(colName, sortASC, projectTasks);
        
        if (sortedList.size() == projectTasks.size()) {
            projectTasks.clear();
            projectTasks.addAll(sortedList);
        }
        
        projectTasksWrappers = new List<projectTaskWrapper> ();
        for(AcctSeed__Project_Task__c pt:projectTasks){
            projectTasksWrappers.add(new projectTaskWrapper(pt));
        }
        initSums();
        
        return null;
    }
    
    // Sort the supplied list of Line Items by column/field colName.
    private static List<AcctSeed__Project_Task__c> lineItemSort(String colName, Boolean sortDir, List<AcctSeed__Project_Task__c> lineItemList) {
        Boolean liAdded;
        List<AcctSeed__Project_Task__c> tempList = new List<AcctSeed__Project_Task__c>();
        List<AcctSeed__Project_Task__c> sortedList = new List<AcctSeed__Project_Task__c>();
        
        system.debug('***** colName = ' + colName);
        system.debug('***** lineItemList.size = ' + lineItemList.size());
        
        // Sort the list of available Products
        for (AcctSeed__Project_Task__c li : lineItemList) {
            system.debug('*****tempList.size = ' + tempList.size() + ' sortedList.size = ' + sortedList.size());
            tempList.clear();
            tempList.addAll(sortedList);
            sortedList.clear();
            system.debug('***** li.Name = ' + li.Name + ' li.Cost_Code__r.Category__c = ' + li.Cost_Code__r.Category__c + ' li.Cost_Code__r.Grouping__c = ' + li.Cost_Code__r.Grouping__c + ' tempList.size = ' + tempList.size());
            if (tempList.size() == 0) {
                sortedList.add(li);
            } else {
                liAdded = false;
                while (!liAdded) {
                    for (Integer i=0; i<tempList.size(); i++) {
                        if (!liAdded) {
                            if (colName == 'Name') {
                                system.debug('*****li.Name = ' + li.Name + ' t.Name = ' + tempList[i].Name);
                                if (sortDir) {
                                    if (li.Name.compareTo(tempList[i].Name) < 0) {
                                        if (!liAdded) {
                                            sortedList.add(li);
                                            liAdded = true;
                                            system.debug('*****Added li to ASC sortedList, size = ' + sortedList.size());
                                        }
                                    }
                                } else {
                                    if (li.Name.compareTo(tempList[i].Name) >= 0) {
                                        if (!liAdded) {
                                            sortedList.add(li);
                                            liAdded = true;
                                            system.debug('*****Added li to DSC sortedList, size = ' + sortedList.size());
                                        }
                                    }
                                }
                            }
                            if (colName == 'Number') {
                                system.debug('*****li.Cost_Code__r.Number__c = ' + li.Cost_Code__r.Number__c + ' t.Cost_Code__r.Number__c = ' + tempList[i].Cost_Code__r.Number__c);
                                if (sortDir) {
                                    if ( (li.Cost_Code__r.Number__c == null) || 
                                         (tempList[i].Cost_Code__r.Number__c != null && li.Cost_Code__r.Number__c.compareTo(tempList[i].Cost_Code__r.Number__c) < 0) ) {
                                        if (!liAdded) {
                                            sortedList.add(li);
                                            liAdded = true;
                                            system.debug('*****Added li to ASC sortedList, size = ' + sortedList.size());
                                        }
                                    }
                                } else {
                                    if ( (li.Cost_Code__r.Number__c != null) && 
                                         (tempList[i].Cost_Code__r.Number__c != null && li.Cost_Code__r.Number__c.compareTo(tempList[i].Cost_Code__r.Number__c) >= 0) ) {
                                        if (!liAdded) {
                                            sortedList.add(li);
                                            liAdded = true;
                                            system.debug('*****Added li to DSC sortedList, size = ' + sortedList.size());
                                        }
                                    }
                                }
                            }
                            if (colName == 'Category') {
                                system.debug('*****li.Cost_Code__r.Category__c = ' + li.Cost_Code__r.Category__c + ' t.Cost_Code__r.Category__c = ' + tempList[i].Cost_Code__r.Category__c);
                                if (sortDir) {
                                    if ( (li.Cost_Code__r.Category__c == null) || 
                                         (tempList[i].Cost_Code__r.Category__c != null && li.Cost_Code__r.Category__c.compareTo(tempList[i].Cost_Code__r.Category__c) < 0) ) {
                                        if (!liAdded) {
                                            sortedList.add(li);
                                            liAdded = true;
                                            system.debug('*****Added li to ASC sortedList, size = ' + sortedList.size());
                                        }
                                    }
                                } else {
                                    if ( (li.Cost_Code__r.Category__c != null) && 
                                         (tempList[i].Cost_Code__r.Category__c != null && li.Cost_Code__r.Category__c.compareTo(tempList[i].Cost_Code__r.Category__c) >= 0) ) {
                                        if (!liAdded) {
                                            sortedList.add(li);
                                            liAdded = true;
                                            system.debug('*****Added li to DSC sortedList, size = ' + sortedList.size());
                                        }
                                    }
                                }
                            }
                            if (colName == 'Grouping') {
                                system.debug('*****li.Cost_Code__r.Grouping__c = ' + li.Cost_Code__r.Grouping__c + ' t.Cost_Code__r.Grouping__c = ' + tempList[i].Cost_Code__r.Grouping__c);
                                if (sortDir) {
                                    if ( (li.Cost_Code__r.Grouping__c == null) || 
                                         (tempList[i].Cost_Code__r.Grouping__c != null && li.Cost_Code__r.Grouping__c.compareTo(tempList[i].Cost_Code__r.Grouping__c) < 0) ) {
                                        if (!liAdded) {
                                            sortedList.add(li);
                                            liAdded = true;
                                            system.debug('*****Added li to ASC sortedList, size = ' + sortedList.size());
                                        }
                                    }
                                } else {
                                    if ( (li.Cost_Code__r.Grouping__c != null) && 
                                         (tempList[i].Cost_Code__r.Grouping__c != null && li.Cost_Code__r.Grouping__c.compareTo(tempList[i].Cost_Code__r.Grouping__c) >= 0) ) {
                                        if (!liAdded) {
                                            sortedList.add(li);
                                            liAdded = true;
                                            system.debug('*****Added li to DSC sortedList, size = ' + sortedList.size());
                                        }
                                    }
                                }
                            }
                        }
                        sortedList.add(tempList[i]);
                        system.debug('*****Added t to sortedList, size = ' + sortedList.size());
                    }
                    if (!liAdded) {
                        sortedList.add(li);
                        liAdded = true;
                        system.debug('*****Added li to sortedList at end of for loop, size = ' + sortedList.size());
                    }
                }
            }
        }
        return sortedList;
    }
    
    
    public class projectTaskWrapper{
        public AcctSeed__Project_Task__c projectTask {get;set;}
        public List<POLWrapper> POLs{get;set;}
        public List<Con_Req__c> COs{get;set;}
        public decimal totalChangeOrder {get;set;}
        public decimal totalAPInvoice {get;set;}
        public decimal totalLineItem {get; set;}
        public decimal totalRemCOs {get; set;}
        
        public projectTaskWrapper(AcctSeed__Project_Task__c pt){
            
            
            POLs = new List<POLWrapper>();
            
            COs = new List<Con_Req__c>();
            
            projectTask = pt;
            
            Map<String,AcctSeedERP__Sales_Order_Line__c> solMap = new Map<String,AcctSeedERP__Sales_Order_Line__c> ();
            
            for(AcctSeedERP__Sales_Order_Line__c so:pt.AcctSeedERP__Sales_Order_Line__r){
                if(so.AcctSeedERP__Purchase_Order_Line__c != null){
                    solMap.put(so.AcctSeedERP__Purchase_Order_Line__c, so);
                }
            }
            
            set<String> poIds = new Set<String> ();
            
            totalChangeOrder = 0;
            totalAPInvoice = 0;
            totalLineItem = 0;
            totalRemCOs = 0;
            
            
            
            for(AcctSeedERP__Purchase_Order_Line__c po:pt.AcctSeedERP__Purchase_Order_Lines__r){
                if(solMap.containsKey(po.Id)){
                    POLs.add(new POLWrapper(po,solMap.get(po.Id)));
                }else{
                    POLs.add(new POLWrapper(po,null));
                }
                
                if(!poIds.contains(po.AcctSeedERP__Purchase_Order__c)){
                    poIds.add(po.AcctSeedERP__Purchase_Order__c);
                    if(po.AcctSeedERP__Purchase_Order__r.Change_Order_Total__c != null){
                        //totalChangeOrder += po.AcctSeedERP__Purchase_Order__r.Change_Order_Total__c;
                    }
                }
                if(po.Roll_Up_All_Account_Payable_Lines__c != null){
                    totalAPInvoice += po.Roll_Up_All_Account_Payable_Lines__c;
                }
            }
            
            for(Con_Req__c co:pt.Change_Orders__r){
                COs.add(co);
                if(co.Amount_Requested__c!= null){
                    totalChangeOrder += co.Amount_Requested__c;
                }
            }
            
            //totalLineItem = totalChangeOrder + pt.Roll_Up_Purchase_Order_Line_Totals__c;
            totalLineItem = pt.Line_Item_Total__c;
            //totalRemCOs = totalChangeOrder + pt.Roll_Up_Purchase_Order_Line_Totals__c - totalAPInvoice;
            totalRemCOs = totalLineItem - pt.Total_Actual_Costs__c;
        }
        
    }
    

     public class POLWrapper{
        public AcctSeedERP__Purchase_Order_Line__c POL {get;set;}
        public AcctSeedERP__Sales_Order_Line__c SOL{get;set;}
        
        public POLWrapper(AcctSeedERP__Purchase_Order_Line__c thePOL,AcctSeedERP__Sales_Order_Line__c theSOL){
            if(thePOL!=null){
                POL = thePOL;
            }
            if(theSOL!=null){
                SOL = theSOL;
            }
        }
    }
}