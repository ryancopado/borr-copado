public with sharing class BillingPrintCtrl {
    /**
     * calculated vars for Invoice
     */
    public Double i_1originalContractSum { get; set;}

    public AcctSeed__Billing_Line__c theBLProject {get;set;}
    
    
    public AcctSeed__Billing__c theBilling {get;set;}
    
    
    public List<AcctSeed__Billing_Line__c> billingLines {get;set;}
    
    public Map<String, list<complete__c>> completeMap;


    public Double completedDuringtheperiodMaterial{get;set;}

    public Double completedDuringtheperiodLabor {get;set;}

    //public Double hColumn {get;set;}
    
    //public Double hColumn33 {get;set;}

    public Double retainageA {get;set;}
    
    public Double retainageB {get;set;}


    public Double completedPreviouslyMaterial{get;set;}
    
    public Double completedPreviouslyLabor{get;set;}
    
    public Double completedPreviously{get;set;}
    
    public Double completedDuringtheperiod {get;set;}
    
    
    public Double totalpos {get;set;}
    
    public Double totalneg {get;set;}


    public BillingPrintCtrl(ApexPages.StandardController stdController){
        billingLines = new List<AcctSeed__Billing_Line__c> ();
                
        theBilling = (AcctSeed__Billing__c)stdController.getRecord();
        
        List<AcctSeed__Billing_Line__c> billingRecords = [select id  ,AcctSeed__Project__r.AcctSeed__Opportunity__r.Change_Orders__c,AcctSeed__Project_Task__r.Id,  AcctSeed__Project__r.Roll_Up_Billed_To_Date__c, AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c,AcctSeed__Project_Task__r.Billing_type__c,AcctSeed__Project__r.Job_Number__c ,AcctSeed__Project__r.Name,AcctSeed__Project__r.Id,AcctSeed__Project__c,AcctSeed__Project__r.AcctSeed__Budgeted_Amount__c  from AcctSeed__Billing_Line__c where AcctSeed__Billing__c=:theBilling.Id ];


        List<string> pTaskIds = new List<string>();


        
        for(AcctSeed__Billing_Line__c billLine:billingRecords){
            if(theBLProject == null)
                theBLProject = billLine;
            if(theBLProject.AcctSeed__Project__r.Id == billLine.AcctSeed__Project__r.Id){
                billingLines.add(billLine);
                pTaskIds.add(billLine.AcctSeed__Project_Task__r.ID);
            }
        }
        
        
        List<complete__c> completes = [select id, complete__c,completion_Date__c,Project_Task__c from complete__c where Project_Task__c IN: pTaskIds];
        
        completeMap = new Map<String, list<complete__c>> ();
        
        
        for(complete__c com:completes){
            if(!completeMap.containsKey(com.Project_Task__c)){
                completeMap.put(com.Project_Task__c,new list<complete__c>{com});
            }else{
                completeMap.get(com.Project_Task__c).add(com);
            }
        }
        
        
        initValues();
        
        
        i_1originalContractSum = 0.0;
        
        inflateCalculatedValues();
    }
    
    
    public list<Con_Req__c> getRelatedChangeOrders(){
        list<Con_Req__c> conReq = [Select c.Job_Number__c, c.LastModifiedDate, c.Status__c,c.Final_Change_Order_Amount__c From Con_Req__c c where c.Status__c = 'Approved By Customer' and c.ASProject__c =: theBLProject.AcctSeed__project__c and recordType.Name = 'Customer Change Order'];
        
        totalpos = 0;
        
        totalneg = 0;
        
        for(Con_Req__c theCon:conReq){
            if(theCon.Final_Change_Order_Amount__c!= null && theCon.Final_Change_Order_Amount__c >0){
                totalpos += theCon.Final_Change_Order_Amount__c;
            } else if(theCon.Final_Change_Order_Amount__c!= null ) {
                totalneg += theCon.Final_Change_Order_Amount__c;
            }
        }
        return conReq;
    }
    
    
    public Decimal getChangeOrder(){
        if(theBLProject != null && theBLProject.AcctSeed__Project__r.AcctSeed__Opportunity__r.Change_Orders__c !=null){
            return theBLProject.AcctSeed__Project__r.AcctSeed__Opportunity__r.Change_Orders__c;
        }else{
            return 0;
        }
    }
    
    private void inflateCalculatedValues() {
        if(theBLProject != null) {
            i_1originalContractSum = removeNulls(theBLProject.AcctSeed__project__r.AcctSeed__Budgeted_Amount__c);
            if(i_1originalContractSum == null) {
                i_1originalContractSum = 0;
            }
        }
    }

    public void initValues(){

        //completedDuringtheperiod = dogetcompletedDuringtheperiod();       
        //completedPreviously = dogetcompletedPreviously();

        //hColumn = completedPreviously + completedDuringtheperiod + removeNulls(theBilling.Material_presently_stored__c);

        //hColumn33 =  removeNulls(theBilling.AcctSeed__Opportunity__r.Change_Orders__c);
        
        
        
        List<AggregateResult> agResultsb = [select SUM(AcctSeed__Amount__c) from AcctSeed__Transaction__c where AcctSeed__Project__c =: theBLProject.AcctSeed__Project__c and AcctSeed__Project_Task__r.Name = 'Retention Billing- Material'  and AcctSeed__Amount__c > 0];
        
        List<AggregateResult> agResultsa = [select SUM(AcctSeed__Amount__c) from AcctSeed__Transaction__c where AcctSeed__Project__c =: theBLProject.AcctSeed__Project__c and AcctSeed__Project_Task__r.Name = 'Retention Billing- Labor'  and AcctSeed__Amount__c > 0];
        
        
        retainageA =  removeNulls((Decimal) agResultsa[0].get('expr0'));
        
        retainageB = removeNulls((Decimal) agResultsb[0].get('expr0'));
        

    }

    /*public Double dogetcompletedDuringtheperiod(){
        Decimal sumComplete = 0;
        Double total = 0;
        completedDuringtheperiodMaterial = 0;
        completedDuringtheperiodLabor = 0;
        for(AcctSeed__Billing_Line__c billLine:billingLines){
            if(completeMap.containsKey(billLine.AcctSeed__Project_Task__r.Id)){
                for(complete__c com:completeMap.get(billLine.AcctSeed__Project_Task__r.Id)){
                    //com.completion_Date__c in the period
                    if(com.completion_Date__c != null && theBilling.Period_To__c != null &&  theBilling.Period_To__c.month() == com.completion_Date__c.month()){
                        sumComplete += com.complete__c;
                    }
                }
            }
            if(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c != null){
                if(billLine.AcctSeed__Project_Task__r.Billing_type__c == 'Material'){
                    completedDuringtheperiodMaterial += sumComplete*removeNulls(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c);
                }else{
                    completedDuringtheperiodLabor +=sumComplete*removeNulls(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c);
                }
                if(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c != null){
                    total +=  sumComplete*removeNulls(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c);
                }
            }
        }
        completedDuringtheperiodLabor = completedDuringtheperiodLabor/100;
        completedDuringtheperiodMaterial = completedDuringtheperiodMaterial/100;
        return total/100;
        
    }

    
    public Double dogetcompletedPreviously(){
        Decimal sumComplete = 0;
        Double total = 0;
        completedPreviouslyMaterial = 0;
        completedPreviouslyLabor = 0;
        for(AcctSeed__Billing_Line__c billLine:billingLines){
            if(billLine != null) {
                if(completeMap.containsKey(billLine.AcctSeed__Project_Task__r.Id)){
                    for(complete__c com:completeMap.get(billLine.AcctSeed__Project_Task__r.Id)){
                        if(com.completion_Date__c != null && theBilling.Period_To__c != null && theBilling.Period_To__c.month() != com.completion_Date__c.month()){
                            sumComplete += com.complete__c;
                        }
                    }
                }
                if(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c != null){
                    if(billLine.AcctSeed__Project_Task__r.Billing_type__c == 'Material'){
                        completedPreviouslyMaterial += sumComplete*removeNulls(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c);
                    }else{
                        completedPreviouslyLabor +=sumComplete*removeNulls(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c);
                    }
                    
                    if(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c != null){
                        total +=  sumComplete*removeNulls(billLine.AcctSeed__Project_Task__r.AcctSeed__Budgeted_Amount__c);
                    }
                }
            }
        }
        
        completedPreviouslyLabor = completedPreviouslyLabor/100;
        completedPreviouslyMaterial = completedPreviouslyMaterial/100;
        
        return total/100;
        
    }*/
    
    
    public Decimal removeNulls(Decimal theDecimal){
        if(theDecimal != null){
            return theDecimal;
        }
        return 0;
    }
    
    
    public static testMethod void TestBillingrint(){
        
        Account testAccount = new Account(Name = 'Test test', Branch__c = 'San Diego', ShippingCity = 'San Francisco');
        insert testAccount;
        Contact testContact = new Contact(LastName = 'testContact', Title = 'CEO', AccountId = testAccount.Id, Phone = '123-456-7890', Email = 'testContact@testContact.com');
        insert testContact;

        //Create an Accounting Period to use for the test
        AcctSeed__Accounting_Period__c testAccountingPeriod = new AcctSeed__Accounting_Period__c(Name = '2200-01',AcctSeed__Start_Date__c = date.today().addYears(5), AcctSeed__End_Date__c = date.today().addYears(5).addMonths(3), AcctSeed__Status__c = 'Open');
        insert testAccountingPeriod;


        AcctSeed__Billing_Format__c billingF = new AcctSeed__Billing_Format__c();
        billingF.AcctSeed__Default_Email_Template__c = 'Billing_Email_Template';
        billingF.AcctSeed__Visualforce_PDF_Page__c = 'BillingServicePDF';
        insert billingF;


        
        
        //Create Opportunity
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = testAccount.Id, CloseDate = System.today(),Module_Delivery_Date__c =system.now().Date(),         
                                                            Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000,
                                                            Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), System_Owner__c = testContact.Id, Expected_Rebate__c = 0,
                                                            Proposal_Submitted_Date__c = System.today(), Proposed_System_Size__c = 10000, Utility_Rate__c = 'N/A', Financing__c = 'Cash',
                                                            Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert testOpportunity; 
        
        //Create a Project for this test
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Account__c = testAccount.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Branch__c = 'San Diego',PC_Code__c = 10);
        insert testProject;

        //Create a new GL Account to use for this test
        AcctSeed__GL_Account__c testGLAccount = new AcctSeed__GL_Account__c(AcctSeed__Type__c = 'Expense', Name = 'Test GL Account');
        insert testGLAccount;
        
        
        AcctSeed__Project_Task__c projectTask = new AcctSeed__Project_Task__c(AcctSeed__Budgeted_Amount__c = 52,RecordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Billing Line Item').getRecordTypeId(), Name = 'Test Project Task', AcctSeed__Project__c = testProject.Id, AcctSeed__Labor_GL_Account__c = testGLAccount.Id, AcctSeed__Budgeted_Revenue__c = 123);
        insert projectTask;  
        Test.StartTest();
        
        complete__c newComp = new complete__c();
        newComp.complete__c = 50;
        newComp.completion_Date__c = Date.today();
        
       newComp.Project_Task__c = projectTask.Id;
       
       insert newComp;
       
       
        newComp = new complete__c();
        newComp.complete__c = 30;
        newComp.completion_Date__c = Date.today();
        
        newComp.Project_Task__c = projectTask.Id;
       
        insert newComp;
       
       AcctSeed__Recurring_Billing__c testRecBilling = new AcctSeed__Recurring_Billing__c(AcctSeed__Customer__c = testAccount.Id ,  AcctSeed__Status__c = 'Active' ,AcctSeed__Billing_Frequency__c = '01J3400000KNb35' , AcctSeed__Next_Billing_Date__c = Date.today());
       
       insert  testRecBilling ;
        
        AcctSeed__Billing__c testBilling = new AcctSeed__Billing__c(AcctSeed__Date__c = date.today(), AcctSeed__Customer__c = testAccount.Id, Period_To__c =Date.today());
        testBilling.AcctSeed__Accounting_Period__c= testAccountingPeriod.Id;
        testBilling.AcctSeed__Billing_Format__c = billingF.Id;
        testBilling.AcctSeed__Recurring_Billing__c = testRecBilling.Id ;
        testBilling.retainage__c = 10;
        insert testBilling;
        
        // AcctSeed__Billing_Line__c.testBilling.AcctSeed__Recurring_Billing__c = 'a321g0000005Anx',
        system.debug('LOOK HERE BILLING'  +testBilling);
        
        AcctSeed__Billing_Line__c billingLine = new AcctSeed__Billing_Line__c(AcctSeed__Billing__c = testBilling.Id, AcctSeed__Hours_Units__c = 1, AcctSeed__Rate__c = 10.0, AcctSeed__Project__c = testProject.Id, AcctSeed__Project_Task__c = projectTask.Id);
       // AcctSeed__Billing_Line__c.AcctSeed__Billing__c.AcctSeed__Recurring_Billing__c = testRecBilling.Id ;
       system.debug('LOOK HERE BILLING LINE'  +billingLine );
        insert billingLine;
        
        
        ApexPages.StandardController stdController = new ApexPages.StandardController (testBilling);
        
        
        BillingPrintCtrl bilingPrint = new BillingPrintCtrl(stdController);
    
        //System.assert(bilingPrint.completedPreviously ==0);
        
        //System.assert(bilingPrint.completedDuringtheperiod == (0.8*52));
        
        //System.assert(bilingPrint.hColumn == (0.8*52));
    
        System.debug(' 000000000000000000 ' + bilingPrint.retainageA);
        bilingPrint .getRelatedChangeOrders();
    
        //System.assert(bilingPrint.retainageA == (0.8*52)/10);
    
        Test.stopTest();
        
    }
    
    
    



}