public class ExpenseReportControllerExt {
    public AcctSeed__Expense_Report__c expReport {get; set;}
    private Map<Id,AcctSeed__GL_Account__c> expenseTypesMap;
    
    public Integer selectedExpenseRow {get; set;}
    public Integer selectedMileageRow {get; set;}
    public Boolean isNameError {get; set;}
    public Boolean isEmployeeError {get; set;}
    public Boolean isStatusError {get; set;}
    public Boolean isLocked {get; set;}		// If TRUE, means Expense Report has been submitted for approval and is locked for edits
    public Boolean editReadOnlyFields {get; set;}		// If TRUE, means user profile has "Edit Read Only Fields" permission
    public Id erId {get; set;}				// Id for the Expense Report detail page
    private Boolean isExpenseError;
    private Boolean isMileageError;
    private Boolean isReimburseAndCCVendorError;
    private String UserBranch;
    private String UserDepartment;
    private String UserManagerID;
    private Id UserOpsDivision;
    private Id UserSalesSegment;
    
    public List<SelectOption> expenseTypesList {get; set;}
    public List<SelectOption> mileageTypesList {get; set;}
    public List<SelectOption> ccVendorList {get; set;}
    
    public List<userBranchIntervalWrapper> userIntervals {get; set;}
    
     public class userBranchIntervalWrapper {
        public Decimal upperLimit {get; set;}
        public Decimal lowerLimit {get; set;}
        public userBranchIntervalWrapper(Decimal theLowerLimit ,Decimal  theupperLimit){
            upperLimit = theUpperLimit;
            lowerLimit = theLowerLimit;
        }
     }
    
    // Wrapper class for each line item
    public class ExpenseLineWrapper {
        public AcctSeed__Expense_Line__c expenseLine {get; set;}
        public Integer intRowNum {get; set;}
        public List<SelectOption> projectTasksList {get; set;}
        public String strExpenseTypeId {get; set;}
        private Map<Id,AcctSeed__GL_Account__c> glAccounts;
        public Boolean isProjectError {get; set;}
        public Boolean isProjectTaskError {get; set;}        
        public Boolean isDateError {get; set;}
        public Boolean isVendorError {get; set;}	// if TRUE means Vendor field is blank
        public Boolean isAmountError {get; set;}
        public Boolean isInternalCommentError {get; set;}
        public Boolean isExpenseTypeError {get; set;}
        public Boolean isOriginError {get; set;}
        public Boolean isDestinationError {get; set;}
        public Boolean isMilesError {get; set;}
        public Boolean isAmountNegativeError {get; set;}     
        public Boolean isMilesNegativeError {get; set;}
        public Boolean isReimburseAndCCVendorError {get; set;}
        public String ccVendorId {get; set;}
               
        public ExpenseLineWrapper(Map<Id,AcctSeed__GL_Account__c> glAccounts) {
            isDateError = false;
            isVendorError = false;
            isAmountError = false;
            isExpenseTypeError = false;
            isOriginError = false;
            isDestinationError = false;
            isMilesError = false;
            isAmountNegativeError = false;
            isMilesNegativeError = false;
            isProjectError = false;
            isProjectTaskError = false;
            isReimburseAndCCVendorError = false;
            isInternalCommentError = false;
            this.glAccounts = glAccounts;
        }
        
        public Decimal getAmount() {
            Decimal total = 0;
            if (expenseLine != null && strExpenseTypeId != null && expenseLine.AcctSeed__Miles__c != null && glAccounts.containsKey(strExpenseTypeId) && glAccounts.get(strExpenseTypeId).AcctSeed__Mileage_Rate__c != null) {
                total = glAccounts.get(strExpenseTypeId).AcctSeed__Mileage_Rate__c * expenseLine.AcctSeed__Miles__c;
            }
            expenseLine.AcctSeed__Amount__c = total;          
            return total;
        }
    }
    
    public List<ExpenseLineWrapper> expensesList {get; set;}
    public List<ExpenseLineWrapper> mileageList {get; set;}
    
    private List<AcctSeed__Expense_Line__c> removedRowsList;
    
    public ExpenseReportControllerExt(ApexPages.StandardController controller) {   
        // Querying the expense report and it's related expense lines
        isEmployeeError = false;
        isNameError = false;
        isStatusError = false;
		ccVendorList = new List<SelectOption>();
    
        try {
          
            ccVendorList.add(new SelectOption('', '--None--'));            
            for (Account acct : [Select Id, Name From Account Where
                       AcctSeed__Credit_Card_Vendor__c = true]) {
              ccVendorList.add(new SelectOption(acct.Id, acct.Name));             
            }
                      
            expReport = [SELECT Id, Name, AcctSeed__Employee__c, AcctSeed__Status__c, AcctSeed__Total_Expenses__c,Manager_for_Approval__c ,
                        (SELECT AcctSeed__Project__c, AcctSeed__Project_Task__c, AcctSeed__Amount__c,AcctSeed__Billable__c, AcctSeed__Internal_Comment__c,
                        AcctSeed__Date__c, AcctSeed__Expense_GL_Account__c, AcctSeed__Invoice_Comment__c, AcctSeed__Employee_Reimburse__c,
                        AcctSeed__Mileage_Origin__c, AcctSeed__Mileage_Destination__c, AcctSeed__Miles__c, AcctSeed__Project_Task__r.Name, AcctSeed__Credit_Card_Vendor__c, vendorText__c
                        FROM AcctSeed__Expense_Lines__r Order By Name Desc)
                        FROM AcctSeed__Expense_Report__c WHERE Id = :controller.getRecord().Id];
        }
        catch (Exception ex) {
            expReport = new AcctSeed__Expense_Report__c();
            expReport.AcctSeed__Employee__c = UserInfo.getUserId();
            expReport.AcctSeed__Status__c = 'In Process';
        }
        
        // Check if read-only fields are editable or if entire Expense Report is locked and can't be edited
        isLocked = FALSE;
        editReadOnlyFields = FALSE;
        Profile pr = [SELECT Id, Name, PermissionsEditReadonlyFields, PermissionsModifyAllData FROM Profile WHERE Id =: UserInfo.getProfileId()];
        if (pr.PermissionsEditReadonlyFields) {
        	editReadOnlyFields = TRUE;
        }
        if (expReport != NULL) {
        	erId = expReport.Id;
        	if ( !(pr.PermissionsModifyAllData || pr.Name == 'Accounting- Administrator' || pr.Name == 'Accounting- Accounts Payable') ) {
				if (expReport.AcctSeed__Status__c == 'Pending Approval' || expReport.AcctSeed__Status__c == 'Approved' || expReport.AcctSeed__Status__c == 'Posted') {
        			isLocked = TRUE;
        		}
        	}
        }
        
        if(expReport != null && expReport.AcctSeed__Employee__c != null ){ 
             User currentUser = [select Branch__c,ManagerId,Expense_Report_Dept__c, Ops_Division__c, Sales_Segment__c from user where id=:expReport.AcctSeed__Employee__c];
             //only on insert
              if(currentUser.Expense_Report_Dept__c != null){
                UserDepartment = currentUser.Expense_Report_Dept__c;
            }
             if(currentUser.Branch__c != null && expReport.Id == null){
                UserBranch = currentUser.Branch__c;
                expReport.ReportBranch__c = UserBranch;
             }
             if(currentUser.ManagerId != null  && expReport.Id == null){
                expReport.Manager_for_Approval__c = currentUser.ManagerId;
             }
             // Set the Accounting Variables on the Expense Report but only on insert
             List<AcctSeed__Accounting_Variable__c> avList = new List<AcctSeed__Accounting_Variable__c>();
             Map<String, Id> avODMap = new Map<String, Id>();
             Map<String, Id> avSSMap = new Map<String, Id>();
             avList = [select Id, Name, AcctSeed__Type__c from AcctSeed__Accounting_Variable__c where AcctSeed__Type__c = 'GL Account Variable 2' or AcctSeed__Type__c = 'GL Account Variable 3'];
             for (AcctSeed__Accounting_Variable__c av :avList) {
             	if (av.AcctSeed__Type__c == 'GL Account Variable 2') {
             		avSSMap.put(av.Name, av.Id);
             	}
             	if (av.AcctSeed__Type__c == 'GL Account Variable 3') {
             		avODMap.put(av.Name, av.Id);
             	}
             }
             if (avSSMap.containsKey(currentUser.Sales_Segment__c)) {
             	UserSalesSegment = avSSMap.get(currentUser.Sales_Segment__c);
             } else {
             	UserSalesSegment = null;
             }
             if (avODMap.containsKey(currentUser.Ops_Division__c)) {
             	UserOpsDivision = avODMap.get(currentUser.Ops_Division__c);
             } else {
             	UserOpsDivision = null;
             }
             if (expReport.Id == null) {
             	expReport.Sales_Segment__c = UserSalesSegment;
             	expReport.Ops_Division__c = UserOpsDivision;
             }
        }
        setUserIntervals();
        
                        
        isExpenseError = false;
        isMileageError = false;
            
        expensesList = new List<ExpenseLineWrapper>();
        mileageList = new List<ExpenseLineWrapper>();
        removedRowsList = new List<AcctSeed__Expense_Line__c>();
        
        expenseTypesList = new List<SelectOption>();

        mileageTypesList = new List<SelectOption>();
        
        expenseTypesList.add(new SelectOption('','--None--'));
        mileageTypesList.add(new SelectOption('','--None--'));
        
        expenseTypesMap = new Map<Id,AcctSeed__GL_Account__c>();
         
        for (AcctSeed__GL_Account__c objExpType : [SELECT Id, AcctSeed__Expense_Report_Name__c, Name, AcctSeed__Mileage_Account__c, AcctSeed__Mileage_Rate__c 
                FROM AcctSeed__GL_Account__c WHERE 
                AcctSeed__Used_in_Expense_Reports__c = true AND  AcctSeed__Active__c = true
                ORDER BY Name LIMIT 1000]) {
        
            expenseTypesMap.put(objExpType.Id,objExpType);

            // Mileage GL Accounts : for Mileage tab expense types
            if (objExpType.AcctSeed__Mileage_Account__c) {            
                if (objExpType.AcctSeed__Expense_Report_Name__c != null){
                    if(isExpenditureNumberAllowed(objExpType.AcctSeed__Expense_Report_Name__c)){
                        mileageTypesList.add(new SelectOption(objExpType.Id,objExpType.AcctSeed__Expense_Report_Name__c));
                    }
                }else{
                    if(isExpenditureNumberAllowed(objExpType.Name)){
                        mileageTypesList.add(new SelectOption(objExpType.Id,objExpType.Name));
                    }
                }
            }
            // Non Mileage GL Accounts : for Project and Non Project expense tabs
            else {
                if (objExpType.AcctSeed__Expense_Report_Name__c != null) {      
                    if(isExpenditureNumberAllowed(objExpType.AcctSeed__Expense_Report_Name__c)){          
                        expenseTypesList.add(new SelectOption(objExpType.Id,objExpType.AcctSeed__Expense_Report_Name__c));
                    }
                }
                else {      
                    if(isExpenditureNumberAllowed(objExpType.Name)){          
                        expenseTypesList.add(new SelectOption(objExpType.Id,objExpType.Name));
                    }
                }
            }
        }
        
        // Pre- populating existing expense lines related to the expense report
        if (expReport.AcctSeed__Expense_Lines__r.size() > 0) {
        
            Set<Id> projectIdsSet = new Set<Id>();
            for (AcctSeed__Expense_Line__c expenseLine : expReport.AcctSeed__Expense_Lines__r) {
            
                if (expenseLine.AcctSeed__Project__c != null)
                    projectIdsSet.add(expenseLine.AcctSeed__Project__c);
            }
            Map<Id,AcctSeed__Project__c> projectsMap = new Map<Id,AcctSeed__Project__c>
                                            ([SELECT Id,(SELECT Id,Name FROM AcctSeed__Project_Tasks__r)
                                            FROM AcctSeed__Project__c WHERE Id IN :projectIdsSet]);
            
            Integer intTab1,intTab3;
            intTab1 = intTab3 = 0;
            for (AcctSeed__Expense_Line__c expenseLine : expReport.AcctSeed__Expense_Lines__r) {
            
                ExpenseLineWrapper objWrapper = new ExpenseLineWrapper(expenseTypesMap);
                objWrapper.expenseLine = expenseLine;
                objWrapper.ccVendorId = expenseLine.AcctSeed__Credit_Card_Vendor__c;
                
                List<SelectOption> temp = new List<SelectOption>();
                temp.add(new SelectOption('','--None--'));
                
                if (expenseLine.AcctSeed__Project_Task__c != null && projectsMap.containsKey(expenseLine.AcctSeed__Project__c)) {
                    
                    List<AcctSeed__Project_Task__c> tempList = projectsMap.get(expenseLine.AcctSeed__Project__c).AcctSeed__Project_Tasks__r;
                    for (AcctSeed__Project_Task__c objProjectTask : tempList) {
                        temp.add(new SelectOption(objProjectTask.Id,objProjectTask.Name));
                    }                  
                }
                objWrapper.projectTasksList = temp;
                
                if (expenseTypesMap.containsKey(expenseLine.AcctSeed__Expense_GL_Account__c))
                    objWrapper.strExpenseTypeId = expenseTypesMap.get(expenseLine.AcctSeed__Expense_GL_Account__c).Id;
                
                if (expenseLine.AcctSeed__Miles__c == null) {
                
                    objWrapper.intRowNum = intTab1++;
                    expensesList.add(objWrapper);
                }
                else if (expenseLine.AcctSeed__Miles__c != null) {
                    objWrapper.intRowNum = intTab3++;
                    mileageList.add(objWrapper);
                }
            }
        }
    }
    
    public Decimal getProjectAmountTotal() {
        Decimal total = 0;
        
        for (ExpenseLineWrapper elw : expensesList) {
            if (elw.expenseLine.AcctSeed__Amount__c != null)
              total += elw.expenseLine.AcctSeed__Amount__c;
        }
        
        return total;
    }
    
    public Decimal getMileageMilesTotal() {
        Decimal total = 0;
        
        for (ExpenseLineWrapper elw : mileageList) {
            if (elw.expenseLine.AcctSeed__Miles__c != null)
              total += elw.expenseLine.AcctSeed__Miles__c;
        }
        
        return total;
    }  

    public Decimal getMileageAmountTotal() {
        Decimal total = 0;
        
        for (ExpenseLineWrapper elw : mileageList) {
            if (elw.expenseLine.AcctSeed__Amount__c != null)
              total += elw.expenseLine.AcctSeed__Amount__c;
        }
        
        return total;
    }

    public Decimal getExpenseAmountTotal() {
        
        return getMileageAmountTotal() + getProjectAmountTotal();
    }
    
    // Creating project tasks drop down options when a project is selected : Project Expenses
    public void setExpenseProjectTask() {
        List<SelectOption> temp = new List<SelectOption>();
        temp.add(new SelectOption('','--None--'));
                
        String strProjectId = expensesList[selectedExpenseRow].expenseLine.AcctSeed__Project__c;
        for (AcctSeed__Project_Task__c objProjectTask : [SELECT Id,Name FROM AcctSeed__Project_Task__c 
                                                WHERE AcctSeed__Project__c = :strProjectId]) {
        
            temp.add(new SelectOption(objProjectTask.Id,objProjectTask.Name));
        }
        expensesList[selectedExpenseRow].projectTasksList = temp;
    }
    
    // Creating project tasks drop down options when a project is selected : Mileage Expenses
    public void setMileageProjectTask() {
        List<SelectOption> temp = new List<SelectOption>();
        temp.add(new SelectOption('','--None--'));
        String strProjectId = mileageList[selectedMileageRow].expenseLine.AcctSeed__Project__c;
        for (AcctSeed__Project_Task__c objProjectTask : [SELECT Id,Name FROM AcctSeed__Project_Task__c 
                                                WHERE AcctSeed__Project__c = :strProjectId]) {
        
            temp.add(new SelectOption(objProjectTask.Id,objProjectTask.Name));
        }
        mileageList[selectedMileageRow].projectTasksList = temp;
    }
    
    // Method to handle deletion of a expense line from tab 1 : Project Expenses
    public void deleteExpenseLine() {
        // If it is an actual record then adding to a list of records to be deleted
        if (expensesList[selectedExpenseRow].expenseLine.Id != null)
            removedRowsList.add(expensesList[selectedExpenseRow].expenseLine);
            
        expensesList.remove(selectedExpenseRow);
        
        // Re-Numbering
        Integer intIndex = 0;
        for (ExpenseLineWrapper obj : expensesList)
            obj.intRowNum = intIndex++;
    }

    // Method to handle deletion of a expense line from tab 3 : Mileage Expenses
    public void deleteMileageLine() {
        
        // If it is an actual record then adding to a list of records to be deleted
        if (mileageList[selectedMileageRow].expenseLine.Id != null)
            removedRowsList.add(mileageList[selectedMileageRow].expenseLine);
        
        mileageList.remove(selectedMileageRow);
        
        // Re-Numbering
        Integer intIndex = 0;
        for (ExpenseLineWrapper obj : mileageList)
            obj.intRowNum = intIndex++;
    }
    
    // Method to handle addition of a expense line to tab 1 : Project Expenses
    public void addExpenseLine() {
        ExpenseLineWrapper objWrapper = new ExpenseLineWrapper(expenseTypesMap);
        objWrapper.expenseLine = new AcctSeed__Expense_Line__c(AcctSeed__Expense_Report__c = expReport.Id);
        objWrapper.intRowNum = expensesList.size();
        List<SelectOption> temp = new List<SelectOption>();
        temp.add(new SelectOption('','--None--'));
        objWrapper.projectTasksList = temp;
        expensesList.add(objWrapper);
    }

    // Method to handle addition of a expense line to tab 3 : Mileage Expenses
    public void addMileageLine() {
        ExpenseLineWrapper objWrapper = new ExpenseLineWrapper(expenseTypesMap);
        objWrapper.expenseLine = new AcctSeed__Expense_Line__c(AcctSeed__Expense_Report__c = expReport.Id);
        objWrapper.intRowNum = mileageList.size();
        List<SelectOption> temp = new List<SelectOption>();
        temp.add(new SelectOption('','--None--'));
        objWrapper.projectTasksList = temp;
        mileageList.add(objWrapper);
    }
    
    public PageReference saveAndClose() {
        saveAndRefresh();
        if (!isExpenseError && !isMileageError && !isEmployeeError && !isNameError && !isStatusError && !isReimburseAndCCVendorError)
            return (new PageReference('/' + expReport.Id));
             
        return null;
    }
    
    public PageReference saveAndRefresh() {
        isExpenseError = false;
        isMileageError = false;
        isEmployeeError = false;
        isNameError = false;
        isStatusError = false;
        isReimburseAndCCVendorError = false;
                
        if (expReport.Name == null)
            isNameError = true;
            
        if (expReport.AcctSeed__Employee__c == null)
            isEmployeeError = true;
        
        if (expReport.AcctSeed__Status__c == null)
            isStatusError = true;
                                        
        List<AcctSeed__Expense_Line__c> expensesListUpsert = new List<AcctSeed__Expense_Line__c>();        

        // Project Expenses
        for (ExpenseLineWrapper elw : expensesList) {
            
            elw.isProjectError = false;
            elw.isProjectTaskError = false;
            elw.isVendorError = false;
            elw.isAmountError = false;
            elw.isInternalCommentError = false;
            elw.isDateError = false;
            elw.isExpenseTypeError = false;
            elw.isAmountNegativeError = false;
            
            if (elw.expenseLine.AcctSeed__Project__c == null) {
                elw.isProjectError = true;
                isExpenseError = true;              
            }

            if (elw.expenseLine.AcctSeed__Project_Task__c == null) {
                elw.isProjectTaskError = true;
                isExpenseError = true;                
            }
                                 
            if (elw.expenseLine.VendorText__c == null) {
                elw.isVendorError = true;
                isExpenseError = true;
            }
            
            if (elw.expenseLine.AcctSeed__Amount__c == null) {
                elw.isAmountError = true;
                isExpenseError = true;
            }

            if (elw.expenseLine.AcctSeed__Internal_Comment__c == null) {
                elw.isInternalCommentError = true;
                isExpenseError = true;
            }

            if (elw.expenseLine.AcctSeed__Amount__c != null && elw.expenseLine.AcctSeed__Amount__c < 0) {
                elw.isAmountNegativeError = true;
                isExpenseError = true;
            }
            
            if (elw.expenseLine.AcctSeed__Date__c == null) {
                elw.isDateError = true;
                isExpenseError = true;
            }

            if (elw.strExpenseTypeId == null) {
                elw.isExpenseTypeError = true;
                isExpenseError = true;
            }
            
            if (expenseTypesMap.containsKey(elw.strExpenseTypeId)) {            
                elw.expenseLine.AcctSeed__Expense_GL_Account__c = (Id)elw.strExpenseTypeId;
            }
            
            elw.expenseLine.AcctSeed__Credit_Card_Vendor__c = (Id)elw.ccVendorId;
            if (elw.expenseLine.AcctSeed__Employee_Reimburse__c && elw.expenseLine.AcctSeed__Credit_Card_Vendor__c != null) {
              elw.isReimburseAndCCVendorError = true;
              isReimburseAndCCVendorError = true;
            }

            expensesListUpsert.add(elw.expenseLine);
        }

        // Mileage Expenses
        for (ExpenseLineWrapper elw : mileageList) {

            elw.isProjectError = false;
            elw.isProjectTaskError = false;
            elw.isDateError = false;
            elw.isExpenseTypeError = false;
            elw.isOriginError = false;
            elw.isDestinationError = false;
            elw.isMilesError = false;
            elw.isMilesNegativeError = false;
            
            if (elw.expenseLine.AcctSeed__Project__c == null) {
                elw.isProjectError = true;
                isMileageError = true;              
            }

            if (elw.expenseLine.AcctSeed__Project_Task__c == null) {
                elw.isProjectTaskError = true;
                isMileageError = true;                
            }
            
            if (elw.expenseLine.AcctSeed__Date__c == null) {
                elw.isDateError = true;
                isMileageError = true;
            }

            if (elw.strExpenseTypeId == null) {
                elw.isExpenseTypeError = true;
                isMileageError = true;
            }

            if (elw.expenseLine.AcctSeed__Mileage_Origin__c == null) {
                elw.isOriginError = true;
                isMileageError = true;
            }

            if (elw.expenseLine.AcctSeed__Mileage_Destination__c == null) {
                elw.isDestinationError = true;
                isMileageError = true;
            }

            if (elw.expenseLine.AcctSeed__Miles__c == null) {
                elw.isMilesError = true;
                isMileageError = true;
            }
            
            if (elw.expenseLine.AcctSeed__Miles__c != null && elw.expenseLine.AcctSeed__Miles__c < 0) {
                elw.isMilesNegativeError = true;
                isMileageError = true;
            }   
                     
            if (expenseTypesMap.containsKey(elw.strExpenseTypeId)) {            
                elw.expenseLine.AcctSeed__Expense_GL_Account__c = (Id)elw.strExpenseTypeId;
            }
             
            expensesListUpsert.add(elw.expenseLine);
        }
        
        Savepoint sp = Database.setSavepoint();                 
        try {
            if (isExpenseError)
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Expenses Tab : Please fill all required fields in partially filled expense lines.'));
            
            if (isMileageError)
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Mileage Tab : Please fill all required fields in partially filled mileage lines.'));
                
            if (!isExpenseError && !isMileageError && !isEmployeeError && !isNameError && !isStatusError && !isReimburseAndCCVendorError) {
				upsert expReport;   
                for (AcctSeed__Expense_Line__c el : expensesListUpsert) {
					if (el.AcctSeed__Expense_Report__c == null)
						el.AcctSeed__Expense_Report__c = expReport.Id;
					//only on inserts
					if (el.Id == null) {
						if (UserBranch != null) {
							el.Branch__c = UserBranch;
						}
						el.Sales_Segment__c = UserSalesSegment;
						el.Ops_Division__c = UserOpsDivision;
					}  
                }             
                upsert expensesListUpsert;        
                delete removedRowsList;
            }
        }
        catch(Exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
            Database.rollback(sp);
            return null;
        }
        
        return null;
    }
    
    
    private void setUserIntervals(){
        userIntervals = new List<userBranchIntervalWrapper>();
        if(UserDepartment != null){
            Map<String, Branch_Expenditure__c> BranchExpendsettings = Branch_Expenditure__c.getall();
            for(Branch_Expenditure__c Bex:BranchExpendsettings.values()){
                String theBranch = Bex.name;
                if(theBranch.indexOf('__') > -1){
                    theBranch = theBranch.substring(0,theBranch.indexOf('__'));
                }
                if(theBranch == UserDepartment){
                    userIntervals.add(new userBranchIntervalWrapper(Bex.Interval_Lower_Number__c,Bex.Interval_Upper_Number__c));
                }
            }
        }
    }
    
    
     private Boolean isExpenditureNumberAllowed(String theGlAccountName){
       if(!test.isRunningTest()){
            String TheExNumber = theGlAccountName;
            if(TheExNumber.indexOf('-') >-1){
                TheExNumber = TheExNumber.substring(0,TheExNumber.indexOf('-'));
            }
            Integer exNumberConveted = -1;
            try{
                exNumberConveted = Integer.valueOf(TheExNumber);
            }catch(Exception e){
                System.debug('error while transforming the expenditure number');
            }
            
            for(userBranchIntervalWrapper ubiw:userIntervals){
                if(ubiw.lowerLimit <= exNumberConveted && exNumberConveted <= ubiw.upperLimit) {
                    return true;
                }
            }       
            return false;
        }else{
            return true;
        }
    }
    
    @isTest(seeAllData=true)
    public static void testExpenseReportControllerExt() {
       TestDataSuite.initialize();
        
        ExpenseReportControllerExt ere = new ExpenseReportControllerExt(new ApexPages.StandardController(TestDataSuite.expenseReports[0]));
        
        // Check lists have loaded as expected
        System.assertEquals(ere.expensesList.size(),1);
        System.assertEquals(ere.mileageList.size(),1);
        
        // Test aggregation methods
        System.assertEquals(50.0,ere.getProjectAmountTotal());
        System.assertEquals(50.0,ere.getMileageMilesTotal());
        System.assertEquals(25.0,ere.getMileageAmountTotal());
        
        // Checking addition of expense rows on the page
        ere.addExpenseLine();
        System.assertEquals(2,ere.expensesList.size());
        //ere.mileageList = new List<ExpenseLineWrapper>();
        
        //delete ere.mileageList[1].expenseLine;
        // save and check error conditions for each row are set correctly        
        ere.saveAndClose();    
        // Check expense errors    
        System.assertEquals(true,ere.expensesList[1].isProjectError);
        System.assertEquals(true,ere.expensesList[1].isProjectTaskError);
        System.assertEquals(true,ere.expensesList[1].isVendorError);
        System.assertEquals(true,ere.expensesList[1].isAmountError);
        System.assertEquals(true,ere.expensesList[1].isExpenseTypeError);
        System.assertEquals(true,ere.expensesList[1].isDateError);  
        
        //ere.mileageList[1].expenseLine.AcctSeed__Amount__c = -2;
        //ere.saveAndClose();
        //System.assertEquals(true,ere.expensesList[1].isAmountNegativeError);
        
        // Test adding new expense line 
        ere.mileageList[0].strExpenseTypeId = ere.expenseTypesList[1].getValue();
        ere.mileageList[0].expenseLine.AcctSeed__Mileage_Origin__c = 'Test';
        ere.mileageList[0].expenseLine.AcctSeed__Mileage_Destination__c = 'Test';
        ere.expensesList[1].expenseLine.AcctSeed__Project__c = TestDataSuite.projects[0].Id;
        ere.expensesList[1].expenseLine.AcctSeed__Project_Task__c = TestDataSuite.projectTasks[0].Id;
        ere.expensesList[1].expenseLine.AcctSeed__Amount__c = 100;
        ere.expensesList[1].expenseLine.AcctSeed__Expense_GL_Account__c = ere.expenseTypesList[1].getValue();
        ere.expensesList[1].expenseLine.AcctSeed__Date__c = System.today();
        ere.expensesList[1].strExpenseTypeId = ere.expenseTypesList[1].getValue();
        System.debug('expense list ' + ere.expensesList);
        
        ere.saveAndRefresh(); 
        
        //System.assertNotEquals(null,ere.expensesList[1].expenseLine.Id);
 
        ere.addMileageLine();  
        System.assertEquals(2,ere.mileageList.size());   
        ere.saveAndClose();
 
         // Check mileage errors
        System.assertEquals(true,ere.mileageList[1].isProjectError);
        System.assertEquals(true,ere.mileageList[1].isProjectTaskError);
        System.assertEquals(true,ere.mileageList[1].isMilesError);
        System.assertEquals(true,ere.mileageList[1].isExpenseTypeError);
        System.assertEquals(true,ere.mileageList[1].isDateError);  
        System.assertEquals(true,ere.mileageList[1].isOriginError);
        System.assertEquals(true,ere.mileageList[1].isDestinationError);  
                           
        // Test adding new mileage line
        ere.mileageList[1].expenseLine.AcctSeed__Project__c = TestDataSuite.projects[0].Id;
        ere.mileageList[1].expenseLine.AcctSeed__Project_Task__c = TestDataSuite.projectTasks[0].Id;
        ere.mileageList[1].expenseLine.AcctSeed__Amount__c = 100;
        ere.mileageList[1].expenseLine.AcctSeed__Expense_GL_Account__c = ere.expenseTypesList[1].getValue();
        ere.mileageList[1].expenseLine.AcctSeed__Date__c = System.today();
        ere.mileageList[1].expenseLine.AcctSeed__Mileage_Origin__c = 'Riverside CA';
        ere.mileageList[1].expenseLine.AcctSeed__Mileage_Destination__c = 'San Bernadino CA';
        ere.mileageList[1].expenseLine.AcctSeed__Miles__c = 50;
        ere.mileageList[1].strExpenseTypeId = ere.expenseTypesList[1].getValue();
        ere.saveAndRefresh(); 
        
        //System.assertNotEquals(null,ere.mileageList[1].expenseLine.Id);
        
        // Test delete mileage and expense lines
        ere.selectedExpenseRow = 1;
        ere.deleteExpenseLine();
        System.assertEquals(1,ere.expensesList.size());
        
        ere.selectedMileageRow = 1;
        ere.deleteMileageLine();
        System.assertEquals(1,ere.mileageList.size());   
        
        ere.selectedExpenseRow = 0;
        ere.setExpenseProjectTask();
        ere.selectedMileageRow = 0;
        ere.setMileageProjectTask();      
    
    }
}