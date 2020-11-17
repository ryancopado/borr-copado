public with sharing class AmortizationEntriesController {

    public AcctSeed__Billing__c billing {get;set;}
    public AcctSeed__Scheduled_Revenue_Expense__c entry {get; set;}
    public AcctSeed__Accounting_Period__c period {get; set;}

    public AmortizationEntriesController(ApexPages.StandardController stdController) {
        billing = (AcctSeed__Billing__c)stdController.getRecord();

        billing = [
            SELECT Id, Name, AcctSeed__Recurring_Billing__c, Service_Contract__r.ASProject__c, CostDay__c, AcctSeed__Customer__c,
                Service_Contract__r.Branch__c, AcctSeed__Recurring_Billing__r.CurrentPeriodStartDate__c, SubTotal__c,
                AcctSeed__Recurring_Billing__r.CurrentPeriodEndDate__c, AcctSeed__Recurring_Billing__r.DaysinCurrentBillingPeriod__c,Service_Contract__r.O_M_Package__c, Service_Contract__r.ASProject__r.Branch__c,Service_Contract__r.ASProject__r.Ops_Division__r.Name
            FROM AcctSeed__Billing__c
            WHERE Id = :billing.Id
            LIMIT 1
        ];
        period = new AcctSeed__Accounting_Period__c();
        if (billing.AcctSeed__Recurring_Billing__r.CurrentPeriodStartDate__c != null) {
            period.AcctSeed__Start_Date__c = billing.AcctSeed__Recurring_Billing__r.CurrentPeriodStartDate__c;
        } else {
            period.AcctSeed__Start_Date__c = Date.today().toStartOfMonth();
        }
        if (billing.AcctSeed__Recurring_Billing__r.CurrentPeriodEndDate__c != null) {
            period.AcctSeed__End_Date__c = billing.AcctSeed__Recurring_Billing__r.CurrentPeriodEndDate__c;
        } else {
            period.AcctSeed__End_Date__c = Date.today().toStartOfMonth().addMonths(3);
        }
        
        String accVariableBranch;
        String accVariableSalesSegment;
        String accVariableOpsDivision;
        for (AcctSeed__Accounting_Variable__c record : [SELECT Id, AcctSeed__Type__c
                                                        FROM AcctSeed__Accounting_Variable__c
                                                        WHERE Name = :billing.Service_Contract__r.ASProject__r.Branch__c OR Name=:billing.Service_Contract__r.ASProject__r.Ops_Division__r.Name or Name = 'O&M'])
        {
            if (record.AcctSeed__Type__c == 'GL Account Variable 1') {
                accVariableBranch = record.Id;
            }
            if (record.AcctSeed__Type__c == 'GL Account Variable 2') {
                accVariableSalesSegment = record.Id;
            }
            if (record.AcctSeed__Type__c == 'GL Account Variable 3') {
                accVariableOpsDivision = record.Id;
            }
        }

        /*List<AcctSeed__Project_Task__c> projectTask = [
            SELECT Id
            FROM AcctSeed__Project_Task__c
            WHERE AcctSeed__Project__c = :billing.Service_Contract__r.ASProject__c
                AND Name = 'Paid Service-OM'
            LIMIT 1
        ];*/
        
        String glAccountDebit;
        String gkAccountCredit;
        for (AcctSeed__GL_Account__c record : [ SELECT Id, Name
                                                FROM AcctSeed__GL_Account__c
                                                WHERE Name LIKE '%2306%'
                                                    OR Name LIKE '%3100%'])
        {
            if (record.Name.contains('2306')) {
                glAccountDebit = record.Id;
            }
            if (record.Name.contains('3100')) {
                gkAccountCredit = record.Id;
            }
        }

        entry = new AcctSeed__Scheduled_Revenue_Expense__c();
        entry.AcctSeed__Product__c = null;
        entry.AcctSeed__Ledger__c = null;
        entry.AcctSeed__Debit_GL_Account__c = glAccountDebit;
        entry.AcctSeed__Credit_GL_Account__c = gkAccountCredit;
        entry.AcctSeed__Amount__c = billing.SubTotal__c;
        entry.AcctSeed__Project__c = billing.Service_Contract__r.ASProject__c;
        entry.AcctSeed__GL_Account_Variable_1__c = accVariableBranch; //Branch
        entry.AcctSeed__GL_Account_Variable_2__c = accVariableSalesSegment; //Sales Segment
        entry.AcctSeed__GL_Account_Variable_3__c = accVariableOpsDivision; //Ops Division
        entry.AcctSeed__Billing__c = billing.Id;
         if(billing.Service_Contract__r.O_M_Package__c=='Preventative')
        {
        List<AcctSeed__Project_Task__c> projectTask = [
            SELECT Id
            FROM AcctSeed__Project_Task__c
            WHERE AcctSeed__Project__c = :billing.Service_Contract__r.ASProject__c AND  Name = 'Preventative Package Fee'
            LIMIT 1
        ];
        
        if (projectTask.size()<0) {
        system.debug('first if');
            entry.AcctSeed__Project_Task__c = null;
        } else {
         system.debug('second if' +projectTask[0].Id);
            entry.AcctSeed__Project_Task__c = projectTask[0].Id;
        }
        
        }
        if(billing.Service_Contract__r.O_M_Package__c=='Comprehensive')
        {
        List<AcctSeed__Project_Task__c> projectTask = [
            SELECT Id
            FROM AcctSeed__Project_Task__c
            WHERE AcctSeed__Project__c = :billing.Service_Contract__r.ASProject__c AND  Name = 'Corrective Package Fee'
            LIMIT 1
        ];
        
        if (projectTask.size()<0) {
            
            entry.AcctSeed__Project_Task__c = null;
        } else {
           
            entry.AcctSeed__Project_Task__c = projectTask[0].Id;
        }
        
        }
        
    
        
        entry.AcctSeed__Description__c = '';
        entry.AcctSeed__GL_Account_Variable_4__c = null;
        
    }
    
    public PageReference submit() {
        //insert entries;
        System.debug('===submit');
        System.debug(period.AcctSeed__Start_Date__c);
        System.debug(period.AcctSeed__End_Date__c);
        System.debug(entry.AcctSeed__Amount__c);
        Integer diff = period.AcctSeed__Start_Date__c.daysBetween(period.AcctSeed__End_Date__c) + 1;
        System.debug(diff);
        Decimal perDayAmount = entry.AcctSeed__Amount__c / diff;
        perDayAmount = perDayAmount.setScale(4);
        System.debug(perDayAmount);
        Date currentDate = period.AcctSeed__Start_Date__c;
        
        // Integer startDay = 
        Map<String, Decimal> periodNameToAmount = new Map<String, Decimal>();
        while (currentDate < period.AcctSeed__End_Date__c) {
            String prefix = '-';
            Integer year = currentDate.year();
            System.debug(year);
            Integer month = currentDate.month();
            System.debug(month);
            if (month < 10) {
                prefix = '-0';
            }
            Integer daysInMonth = date.daysInMonth(year, month);
            System.debug(daysInMonth);
            Date endOfCurrentMonth = Date.newInstance(year, month + 1, 1);
            System.debug(endOfCurrentMonth);

            if (endOfCurrentMonth > period.AcctSeed__End_Date__c) {
                Integer numOfDays = currentDate.daysBetween(period.AcctSeed__End_Date__c);
                if (numOfDays != 0) {
                    periodNameToAmount.put(year + prefix + month, (numOfDays + 1) * perDayAmount);
                }
                break;
            }
            Integer numOfDays = currentDate.daysBetween(endOfCurrentMonth);
            System.debug(numOfDays);
            periodNameToAmount.put(year + prefix + month, numOfDays * perDayAmount);
            currentDate = endOfCurrentMonth;
        }
        System.debug(currentDate);
        System.debug(periodNameToAmount);

        List<AcctSeed__Scheduled_Revenue_Expense__c> entries = new List<AcctSeed__Scheduled_Revenue_Expense__c>();

        for (AcctSeed__Accounting_Period__c record : [  SELECT Id, Name
                                                        FROM AcctSeed__Accounting_Period__c
                                                        WHERE Name IN :periodNameToAmount.keySet()])
        {
            AcctSeed__Scheduled_Revenue_Expense__c newEntry = new AcctSeed__Scheduled_Revenue_Expense__c();
            newEntry = entry.clone(false, false, false, false);
            newEntry.Name = billing.Name + '-' + record.Name;
            newEntry.AcctSeed__Accounting_Period__c = record.Id;
            newEntry.AcctSeed__Amount__c = periodNameToAmount.get(record.Name);
            System.debug(newEntry);
            entries.add(newEntry);
        }
        System.debug(entries);
        insert entries;
        String baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        String retUrl = '/' + billing.Id;
        return new PageReference(baseUrl + retUrl);
    }

    public PageReference back() {
        String baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        String retUrl = '/' + billing.Id;
        return new PageReference(baseUrl + retUrl);
    }
}