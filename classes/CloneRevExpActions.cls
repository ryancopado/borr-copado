public class CloneRevExpActions {
    public static final String ACCOUNTING_PERIOD_ERROR = 'This Scheduled Revenue Expense record has been set up to create Scheduled Revenue Expense records for Accounting periods which do not exist or have a status = closed. Please setup the future Accounting Periods needed for the number of recurring Scheduled Revenue Expenses';


    public static void setProrateAmount(AcctSeed__Scheduled_Revenue_Expense__c[] schedRevList) {
        for (AcctSeed__Scheduled_Revenue_Expense__c scr : schedRevList) {
            if (scr.Prorate_Start_Day__c != null && scr.Number_of_Periods__c != null) {
                scr.AcctSeed__Amount__c = scr.AcctSeed__Amount__c * (scr.Prorate_for_Month_1__c/100);   
            }
        }
    }
    
    /*Added By Madan - Jun 6, 2017(To populate few fields on New Record Create)*/
    public static void populateFields(List<AcctSeed__Scheduled_Revenue_Expense__c> newList) {
        Set<Id> setBillingId = new Set<Id>();
        for(AcctSeed__Scheduled_Revenue_Expense__c schRev:newList) {
            if(schRev.AcctSeed__Project__c == null && schRev.AcctSeed__Billing__c != null) {
                setBillingId.add(schRev.AcctSeed__Billing__c);
            }
        }
        
        if(setBillingId.size() > 0) {
            // Create Map of Billing records
            Map<Id,AcctSeed__Billing__c> mapBilling = new Map<Id,AcctSeed__Billing__c>(
                                            [Select Id,Service_Contract__c,Service_Contract__r.ASProject__c,Service_Contract__r.Branch__c 
                                                From AcctSeed__Billing__c 
                                                Where Id IN:setBillingId]);

            Set<Id> setProjectId = new Set<Id>();
            
            // Predefined Branch Mapping this mapping used to populate lookup value from Picklist field value
            Map<String,String> mapBrnachMapping = new Map<String,String>{
                                                                'Nor Cal' => 'Oakland', 
                                                                'So Cal' => 'San Diego', 
                                                                'New England' => 'Boston', 
                                                                'Mid Atlantic' => 'Mid-Atlantic', 
                                                                'Southeast' => 'Southeast',
                                                                'Mid-Atlantic' => 'Mid-Atlantic',
                                                                'Midwest' => 'Midwest'  // change made on 12/20 since midwest was not populating
                                                            };
                                                            
            // Map of Accounting Variable[Branch] correspondence to Branch Name
            Map<String,AcctSeed__Accounting_Variable__c> mapAccVariable = new Map<String,AcctSeed__Accounting_Variable__c>();
            for(AcctSeed__Accounting_Variable__c accVariable:[Select Id,Name From AcctSeed__Accounting_Variable__c 
                                                                                                Where AcctSeed__Active__c=true AND 
                                                                                                AcctSeed__Type__c='GL Account Variable 1' AND 
                                                                                                Name IN:mapBrnachMapping.keySet()]) {
                if(accVariable.Name == 'Mid-Atlantic') {
                    mapAccVariable.put('Mid Atlantic',accVariable);
                }
                mapAccVariable.put(accVariable.Name,accVariable);
            }
            System.debug('===================mapAccVariable: ' + mapAccVariable);
            
            // Create set of Project Id to fetch Project Task[Line Item]
            for(Id billingId:mapBilling.keySet()) {
                if(mapBilling.get(billingId).Service_Contract__c != null) {
                    if(mapBilling.get(billingId).Service_Contract__r.ASProject__c != null) {
                        setProjectId.add(mapBilling.get(billingId).Service_Contract__r.ASProject__c);
                    }
                    
                }
            }
            
            // Fetch Line item of name 'Paid Service-OM' for each Projects to populate AcctSeed__Scheduled_Revenue_Expense__c.AcctSeed__Project_Task__c Lookup
            Map<Id,AcctSeed__Project__c> mapProject = new Map<Id,AcctSeed__Project__c>();
            if(setProjectId.size() > 0) {
                mapProject = new Map<Id,AcctSeed__Project__c>(
                                        [Select Id,(Select Id From AcctSeed__Project_Tasks__r Where Name='Paid Service-OM' Limit 1) From AcctSeed__Project__c Where Id IN:setProjectId]);
            }
            
            // Fetch O&M Active Accounting Variable Record
            AcctSeed__Accounting_Variable__c accVariable2, accVariable3;
            for(AcctSeed__Accounting_Variable__c accVar:[Select Id From AcctSeed__Accounting_Variable__c 
                                                            Where Name='O&M' AND 
                                                                AcctSeed__Active__c=true AND 
                                                                AcctSeed__Type__c='GL Account Variable 2' LIMIT 1]) {
                accVariable2 = accVar;
            }
            for(AcctSeed__Accounting_Variable__c accVar:[Select Id From AcctSeed__Accounting_Variable__c 
                                                            Where Name='O&M' AND 
                                                                AcctSeed__Active__c=true AND 
                                                                AcctSeed__Type__c='GL Account Variable 3' LIMIT 1]) {
                accVariable3 = accVar;
            }
            
            for(AcctSeed__Scheduled_Revenue_Expense__c schRev:newList) {
                if(schRev.AcctSeed__Project__c == null && schRev.AcctSeed__Billing__c != null && mapBilling.get(schRev.AcctSeed__Billing__c).Service_Contract__c != null) {
                    schRev.AcctSeed__Project__c = mapBilling.get(schRev.AcctSeed__Billing__c).Service_Contract__r.ASProject__c;
                    
                    // Set Line Item from Associated Project who's name is 'Paid Service- OM'
                    if(schRev.AcctSeed__Project__c != null && mapProject.get(schRev.AcctSeed__Project__c).AcctSeed__Project_Tasks__r.size() > 0) {
                        schRev.AcctSeed__Project_Task__c = mapProject.get(schRev.AcctSeed__Project__c).AcctSeed__Project_Tasks__r[0].Id;
                    }
                    
                    // Populate Branch correspondence to svc contract Branch Picklist value
                    String branchName = mapBilling.get(schRev.AcctSeed__Billing__c).Service_Contract__r.Branch__c;
                    System.debug('===================branchName: ' + branchName);
                    if(branchName != null) {
                        //if(mapBrnachMapping.containsKey(branchName) && mapAccVariable.containsKey(mapBrnachMapping.get(branchName))) {
                        if(mapAccVariable.containsKey(branchName)) {
                            //schRev.AcctSeed__GL_Account_Variable_1__c = mapAccVariable.get(mapBrnachMapping.get(branchName)).Id;
                            schRev.AcctSeed__GL_Account_Variable_1__c = mapAccVariable.get(branchName).Id;
                        }
                    } else { //  Reset to Null if no mapping found
                        schRev.AcctSeed__GL_Account_Variable_1__c = null;
                    }
                    
                    // Populate Sales Segment [AcctSeed__GL_Account_Variable_2__c] field with {Acitve Accounting variable + Type is Accounting variable 2 + Name is O&M}
                    if(accVariable2 != null) {
                        schRev.AcctSeed__GL_Account_Variable_2__c = accVariable2.Id;
                    }
                    
                    // Populate Ops Division [AcctSeed__GL_Account_Variable_3__c] field with {Acitve Accounting variable + Type is Accounting variable 3 + Name is O&M}
                    if(accVariable3 != null) {
                        schRev.AcctSeed__GL_Account_Variable_3__c = accVariable3.Id;
                    } 
                }
            }
        }
    }
    
    public static void checkAccountPeriodsExist(AcctSeed__Scheduled_Revenue_Expense__c[] schedRevList) {
        Set<String> acctPeriodNameSet = new Set<String>();
        Set<String> checkAcctPeriodNameSet = new Set<String>();
        for (AcctSeed__Scheduled_Revenue_Expense__c scr : schedRevList) {
            if (scr.Number_of_Periods__c != null) {
              Integer numberOfPeriods = scr.Prorate_Start_Day__c != null ? scr.Number_of_Periods__c.intValue() : scr.Number_of_Periods__c.intValue()-1;                                             
                for (integer i = 1; i <= numberOfPeriods; i++) {    
                    Date getPeriodDate = scr.Hidden_Accounting_Period__c.addMonths(i);
                    if (getPeriodDate.month()<10) {
                        // convert from single digit to double digit
                        acctPeriodNameSet.add(getPeriodDate.year()+'-0'+getPeriodDate.month().format());                                
                    }
                    else {
                        acctPeriodNameSet.add(getPeriodDate.year()+'-'+getPeriodDate.month().format());
                    }
                } 
            }
        }
        
        for (AcctSeed__Accounting_Period__c ap : [Select Id, Name From AcctSeed__Accounting_Period__c
                                                    Where Name In :acctPeriodNameSet
                                                    And AcctSeed__Status__c = 'Open']) {
            checkAcctPeriodNameSet.add(ap.Name);                                            
        }
        
        for (AcctSeed__Scheduled_Revenue_Expense__c scr : schedRevList) {
            if (scr.Number_of_Periods__c != null) {
                Integer numberOfPeriods = scr.Prorate_Start_Day__c != null ? scr.Number_of_Periods__c.intValue() : scr.Number_of_Periods__c.intValue()-1;                                                             
                for (integer i = 1; i <= numberOfPeriods; i++) {    
                    Date getPeriodDate = scr.Hidden_Accounting_Period__c.addMonths(i);
                    String key = '';
                    if (getPeriodDate.month()<10) {
                        key = getPeriodDate.year()+'-0'+getPeriodDate.month().format();                              
                    }
                    else {
                        key = getPeriodDate.year()+'-'+getPeriodDate.month().format();
                    }
                    
                    if (!checkAcctPeriodNameSet.contains(key)) {
                        scr.addError(ACCOUNTING_PERIOD_ERROR);
                    }
                } 
            }
        }               
    }
    
    public static void cloneScheduledRevenueExpense(AcctSeed__Scheduled_Revenue_Expense__c[] schedRevList) {
        Set<String> acctPeriodNameSet = new Set<String>();
        Map<String,AcctSeed__Accounting_Period__c> acctPeriodMap = new Map<String,AcctSeed__Accounting_Period__c>();
        List<AcctSeed__Scheduled_Revenue_Expense__c> scrList = new List<AcctSeed__Scheduled_Revenue_Expense__c>();
        
        for (AcctSeed__Scheduled_Revenue_Expense__c scr : schedRevList) {
            if (scr.Number_of_Periods__c != null) {
                Integer numberOfPeriods = scr.Prorate_Start_Day__c != null ? scr.Number_of_Periods__c.intValue() : scr.Number_of_Periods__c.intValue()-1;                                               
              
                for (integer i = 1; i <= numberOfPeriods; i++) {    
                    Date getPeriodDate = scr.Hidden_Accounting_Period__c.addMonths(i);
                    if (getPeriodDate.month()<10) {
                        // convert from single digit to double digit
                        acctPeriodNameSet.add(getPeriodDate.year()+'-0'+getPeriodDate.month().format());                                
                    }
                    else {
                        acctPeriodNameSet.add(getPeriodDate.year()+'-'+getPeriodDate.month().format());
                    }
                } 
            }
        }
        
        for (AcctSeed__Accounting_Period__c ap : [Select Id, Name From AcctSeed__Accounting_Period__c
                                                    Where Name In :acctPeriodNameSet
                                                    And AcctSeed__Status__c = 'Open']) {
            acctPeriodMap.put(ap.Name,ap);                                            
        }
        
        for (AcctSeed__Scheduled_Revenue_Expense__c scr : schedRevList) {
            if (scr.Number_of_Periods__c != null) {
                Integer numberOfPeriods = scr.Prorate_Start_Day__c != null ? scr.Number_of_Periods__c.intValue() : scr.Number_of_Periods__c.intValue()-1;                                               
              
                for (integer i = 1; i <= numberOfPeriods; i++) {    
                    Date getPeriodDate = scr.Hidden_Accounting_Period__c.addMonths(i);
                    String key = '';
                    if (getPeriodDate.month()<10) {
                        // convert from single digit to double digit
                        key = getPeriodDate.year()+'-0'+getPeriodDate.month().format();                             
                    }
                    else {
                        key = getPeriodDate.year()+'-'+getPeriodDate.month().format();
                    }
                    
                    AcctSeed__Scheduled_Revenue_Expense__c cloneRecord = scr.clone(false);
                    cloneRecord.Number_of_Periods__c = null;
                    cloneRecord.AcctSeed__Accounting_Period__c = acctPeriodMap.get(key).Id;
                    if (i == scr.Number_of_Periods__c && scr.Prorate_Start_Day__c != null) {  
                        cloneRecord.AcctSeed__Amount__c = (scr.AcctSeed__Amount__c / (scr.Prorate_for_Month_1__c/100)) - scr.AcctSeed__Amount__c;                                                       
                    }
                    else if (scr.Prorate_Start_Day__c != null) {
                        cloneRecord.AcctSeed__Amount__c = scr.AcctSeed__Amount__c / (scr.Prorate_for_Month_1__c/100);  
                    } 
                    
                    scrList.add(cloneRecord);                               
                }
            }
        } 
        
        insert scrList;      
    }

    public static testMethod void testCloneScheduledRevenueExpense() {
        AcctSeed__GL_Account__c glAccount = new AcctSeed__GL_Account__c();
        glAccount.Name =' test';
        glAccount.AcctSeed__Active__c=true;
        glAccount.AcctSeed__Type__c='Expense';
        insert glAccount;
        
        List<AcctSeed__Accounting_Period__c> acctPeriodList = new List<AcctSeed__Accounting_Period__c>();
        
        for (Integer i = 1; i <= 12; i++) {
            AcctSeed__Accounting_Period__c acctPeriod = new AcctSeed__Accounting_Period__c();
            if (i<10) {
                // convert from single digit to double digit
                acctPeriod.Name = '1990-0'+ i;                             
            }
            else {
                acctPeriod.Name = '1990-'+ i;
            }
            acctPeriod.AcctSeed__Start_Date__c = Date.newInstance(1990,i,1);
            acctPeriod.AcctSeed__End_Date__c = Date.newInstance(1990,i,Date.daysInMonth(1990,i));
            acctPeriod.AcctSeed__Status__c = 'Open';
            acctPeriodList.add(acctPeriod);
        }
        
        insert acctPeriodList;
        
        AcctSeed__Scheduled_Revenue_Expense__c scr = new AcctSeed__Scheduled_Revenue_Expense__c();
        scr.Name='test';
        scr.AcctSeed__Accounting_Period__c = acctPeriodList[0].id;
        scr.Prorate_Start_Day__c =5;
        scr.AcctSeed__Amount__c=100;
        scr.AcctSeed__Credit_GL_Account__c=glAccount.id;
        scr.AcctSeed__Debit_GL_Account__c=glAccount.id;
        scr.Number_of_Periods__c=3;
        try{
            insert scr;
        }catch(Exception e){
            
        }
        //System.assertEquals(1,[Select count() From AcctSeed__Scheduled_Revenue_Expense__c Where AcctSeed__Accounting_Period__r.Name = :acctPeriodList[1].Name]); 
        //System.assertEquals(1,[Select count() From AcctSeed__Scheduled_Revenue_Expense__c Where AcctSeed__Accounting_Period__r.Name = :acctPeriodList[2].Name]);   
        //System.assertEquals(1,[Select count() From AcctSeed__Scheduled_Revenue_Expense__c Where AcctSeed__Accounting_Period__r.Name = :acctPeriodList[3].Name]);      
        //System.assertEquals(0,[Select count() From AcctSeed__Scheduled_Revenue_Expense__c Where AcctSeed__Accounting_Period__r.Name = :acctPeriodList[4].Name]);                    
    }
        
    public static testMethod void testSetProrateAmount() {
        AcctSeed__GL_Account__c glAccount = new AcctSeed__GL_Account__c();
        glAccount.Name =' test';
        glAccount.AcctSeed__Active__c=true;
        glAccount.AcctSeed__Type__c='Expense';
        insert glAccount;
        
        List<AcctSeed__Accounting_Period__c> acctPeriodList = new List<AcctSeed__Accounting_Period__c>();
        
        for (Integer i = 1; i <= 12; i++) {
            AcctSeed__Accounting_Period__c acctPeriod = new AcctSeed__Accounting_Period__c();
            if (i<10) {
                // convert from single digit to double digit
                acctPeriod.Name = '1990-0'+ i;                             
            }
            else {
                acctPeriod.Name = '1990-'+ i;
            }
            acctPeriod.AcctSeed__Start_Date__c = Date.newInstance(1990,i,1);
            acctPeriod.AcctSeed__End_Date__c = Date.newInstance(1990,i,Date.daysInMonth(1990,i));
            acctPeriod.AcctSeed__Status__c = 'Open';
            acctPeriodList.add(acctPeriod);
        }
        
        insert acctPeriodList;
        
        AcctSeed__Scheduled_Revenue_Expense__c scr = new AcctSeed__Scheduled_Revenue_Expense__c();
        scr.Name='test';
        scr.AcctSeed__Accounting_Period__c = acctPeriodList[0].id;
        scr.Prorate_Start_Day__c =5;
        scr.AcctSeed__Amount__c=100;
        scr.AcctSeed__Credit_GL_Account__c=glAccount.id;
        scr.AcctSeed__Debit_GL_Account__c=glAccount.id;
        scr.Number_of_Periods__c=11;
        try{
            insert scr;
        }catch(Exception e){
            
        }
        
        //System.assertEquals(83.87, [Select AcctSeed__Amount__c From AcctSeed__Scheduled_Revenue_Expense__c Where Id = :scr.Id].AcctSeed__Amount__c);
    }
    /*
    public static testMethod void testCheckAccountPeriodsExist() {
        AcctSeed__GL_Account__c glAccount = new AcctSeed__GL_Account__c();
        glAccount.Name =' test';
        glAccount.AcctSeed__Active__c=true;
        glAccount.AcctSeed__Type__c='Expense';
        insert glAccount;
        
        List<AcctSeed__Accounting_Period__c> acctPeriodList = new List<AcctSeed__Accounting_Period__c>();
        
        for (Integer i = 1; i <= 12; i++) {
            AcctSeed__Accounting_Period__c acctPeriod = new AcctSeed__Accounting_Period__c();
            if (i<10) {
                // convert from single digit to double digit
                acctPeriod.Name = '1990-0'+ i;                             
            }
            else {
                acctPeriod.Name = '1990-'+ i;
            }
            acctPeriod.AcctSeed__Start_Date__c = Date.newInstance(1990,i,1);
            acctPeriod.AcctSeed__End_Date__c = Date.newInstance(1990,i,Date.daysInMonth(1990,i));
            acctPeriod.AcctSeed__Status__c = 'Open';
            acctPeriodList.add(acctPeriod);
        }
        
        insert acctPeriodList;
        acctPeriodList[0].AcctSeed__Status__c = 'Closed';
        update acctPeriodList[0];
        
        AcctSeed__Scheduled_Revenue_Expense__c scr = new AcctSeed__Scheduled_Revenue_Expense__c();
        scr.Name='test';
        scr.AcctSeed__Accounting_Period__c = acctPeriodList[0].id;
        scr.Prorate_Start_Day__c =5;
        scr.AcctSeed__Amount__c=100;
        scr.AcctSeed__Credit_GL_Account__c=glAccount.id;
        scr.AcctSeed__Debit_GL_Account__c=glAccount.id;
        scr.Number_of_Periods__c=3;
        
        DMLException dmlEx;
        
        try {
            insert scr;
        }
        catch (DMLException ex) {
            dmlEx = ex;
        }
        
        System.assertEquals(ACCOUNTING_PERIOD_ERROR, dmlEx.getDMLMessage(0));
    }
    */
}