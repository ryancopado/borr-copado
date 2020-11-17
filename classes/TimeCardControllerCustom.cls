public with sharing class TimeCardControllerCustom {
    
    // Methods to support custom Time Card and Line Item cloning.
    private final AcctSeed__Time_Card__c tc;
    
    public Boolean isPeriodError {get; set;}
    public Boolean isEmployeeError {get; set;}
    public AcctSeed__Time_Card__c timecard {get; set;}
    public List<AcctSeed__Time_Card_Period__c> tcpList = new List<AcctSeed__Time_Card_Period__c>();
    
    // Initialize by cloning the current Time Card and reading in all current active Time Card Periods
    public TimeCardControllerCustom(ApexPages.StandardController stdController) {
        AcctSeed__Time_Card__c card;
        
        this.tc = (AcctSeed__Time_Card__c)stdController.getRecord();
        isPeriodError = FALSE;
        isEmployeeError = FALSE;
        card = [SELECT Id, AcctSeed__Employee__c, AcctSeed__Time_Card_Period__c, OwnerId FROM AcctSeed__Time_Card__c WHERE Id =: tc.Id];
        system.debug('Look Here Card' +card);
        timecard = card.clone(false,true,false,false);
        system.debug('TC Clone' +timecard);
        timecard.AcctSeed__Time_Card_Period__c = NULL;  // Force user to select a new Time Card Period
        tcpList = [SELECT Id, Name, AcctSeed__Start_Date__c, AcctSeed__Status__c FROM AcctSeed__Time_Card_Period__c WHERE AcctSeed__Status__c =: 'Open' ORDER BY AcctSeed__Start_Date__c ASC];
    }
    
    // Populate and return the drop-down list of Time Card Periods for user selection
    public List<SelectOption> getTimeCardPeriods() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '--None--'));
        for (AcctSeed__Time_Card_Period__c tcp : tcpList) {
            options.add(new SelectOption(tcp.Id, tcp.Name));
        }
        return options;
    }
    
    // For testing purposes, set the Time Card Period
    public void timeCardPeriodSetForTest(Id tcpId) {
        timecard.AcctSeed__Time_Card_Period__c = tcpId;
    }

/*
    // Save just the Time Card and don't bother with the Line Items
    public PageReference saveTimeCard() {
        Savepoint sp = Database.setSavepoint();
        try {
            insert timecard;
        }
        catch(Exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
            Database.rollback(sp);
            return null;
        }
        PageReference tcPage = new ApexPages.Standardcontroller(timecard).view();
        tcPage.setRedirect(true);
        return (tcPage);
    }
*/  

    // Save the cloned Time Card and clone and save associated Line Items
    public PageReference saveCloneLineItems() {
        
        List<AcctSeed__Time_Card_Line__c> tclines = new List<AcctSeed__Time_Card_Line__c>();
        List<AcctSeed__Time_Card_Line__c> tclinesClone = new List<AcctSeed__Time_Card_Line__c>();
        
        isPeriodError = FALSE;
        isEmployeeError = FALSE;
        if (timecard.AcctSeed__Time_Card_Period__c == NULL) {
            isPeriodError = TRUE;
        }
        if (timecard.AcctSeed__Employee__c == NULL) {
            isEmployeeError = TRUE;
        }
        
        if (isPeriodError || isEmployeeError) {
            return NULL;
        }
        
        timecard.OwnerId = UserInfo.getUserId();
        timecard.AcctSeed__Status__c = 'In Process';
        
        Savepoint sp = Database.setSavepoint();
        try {
            system.debug('this is insert');
           insert timecard;
            system.debug('LOOK HERE TC' +tc.Id);
            system.debug('Look here Timecard' +timecard.Id);
            tclines = [SELECT Id, AcctSeed__Time_Card__c, AcctSeed__Project__c, AcctSeed__Project_Task__c, AcctSeed__Time_Card_Variable_1__c, AcctSeed__Time_Card_Variable_2__c FROM AcctSeed__Time_Card_Line__c WHERE AcctSeed__Time_Card__c =: tc.Id];
            system.debug('Look here TCL' +tclines);
            //system.debug('AC2' +tclines.AcctSeed__Time_Card_Variable_2__c);
            for (AcctSeed__Time_Card_Line__c tcl : tclines) {
                tclinesClone.add(
                    new AcctSeed__Time_Card_Line__c(
                        AcctSeed__Time_Card__c = timecard.Id,
                        AcctSeed__Project__c = tcl.AcctSeed__Project__c,
                        AcctSeed__Project_Task__c = tcl.AcctSeed__Project_Task__c,
                        AcctSeed__Time_Card_Variable_1__c = tcl.AcctSeed__Time_Card_Variable_1__c,
                        AcctSeed__Time_Card_Variable_2__c = tcl.AcctSeed__Time_Card_Variable_2__c
                    )
                );  
            }
    
            if (tclinesClone.size() > 0) {
            //tclinesClone=tclines.clone(false);
            insert tclinesClone;
             
             
            }
            //made the changes on 8/12/2020 to fix the accounting seed managed pacakage upgrade duplication error.
            List<AcctSeed__Time_Card_Line__c>tclines1=new List<AcctSeed__Time_Card_Line__c>();
             tclines1 = [SELECT Id, AcctSeed__Time_Card__c, AcctSeed__Project__c, AcctSeed__Project_Task__c, AcctSeed__Time_Card_Variable_1__c, AcctSeed__Time_Card_Variable_2__c FROM AcctSeed__Time_Card_Line__c WHERE( AcctSeed__Time_Card__c =: timecard.Id and AcctSeed__Time_Card_Variable_2__c=null) ];//
             system.debug('Look Here delete' +tclines1);
             if(tclines1 .size()>0)
             {
             delete tclines1 ;
             }
          
        }
        catch(Exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
            Database.rollback(sp);
            return null;
        }
        
        PageReference tcPage = new ApexPages.Standardcontroller(timecard).edit();
        tcPage.setRedirect(true);
        return (tcPage);
    }

    @isTest(seeAllData=true)
    public static void TimeCardControllerCustomTest() {
        User[] users;
        AcctSeed__Time_Card_Period__c[] periods;
        
        // Create some dummy data to use for the test
        Profile p = [select id from profile where name='Sys Admin w/o HR'];
        users = [SELECT Id, Name FROM User WHERE ProfileId = :p.Id AND IsActive = true];
        periods = [SELECT Id, Name, AcctSeed__Start_Date__c, AcctSeed__Status__c FROM AcctSeed__Time_Card_Period__c WHERE AcctSeed__Status__c =: 'Open' ORDER BY AcctSeed__Start_Date__c DESC];
        
        //List<AcctSeed__Project__c> projects = new List<AcctSeed__Project__c>();
        //projects = [SELECT Id FROM AcctSeed__Project__c];
        
       
        
        List<AcctSeed__Accounting_Variable__c> accVariable = new List<AcctSeed__Accounting_Variable__c>();
        accVariable = [SELECT Id FROM AcctSeed__Accounting_Variable__c where AcctSeed__Type__c = 'Time Card Variable 1'];
        
       
        
        List<Site__c> sites=new List<Site__c>();
        sites=[select Id,Project__c from Site__c where Project__c!=null limit 1 ];
        Site__c newsite=new Site__c();
        newsite=sites.get(0);
        
         List<AcctSeed__Project_Task__c> projectTasks = new List<AcctSeed__Project_Task__c>();
        projectTasks = [SELECT Id FROM AcctSeed__Project_Task__c where AcctSeed__Project__c=:newsite.Project__c limit 10];
        
        
         List<AcctSeed__Accounting_Variable__c> accVariable1 = new List<AcctSeed__Accounting_Variable__c>();
        accVariable1 = [SELECT Id FROM AcctSeed__Accounting_Variable__c where AcctSeed__Type__c = 'Time Card Variable 2' and Site__c=:newsite.Id];
 
        List<AcctSeed__Time_Card__c> timeCards = new List<AcctSeed__Time_Card__c>();
        timeCards.add(
            new AcctSeed__Time_Card__c(
                AcctSeed__Time_Card_Period__c = periods[1].Id,
                AcctSeed__Employee__c = users[0].Id,
                AcctSeed__Status__c = 'In Process'
            )   
        );
        
        insert timeCards;
        
        List<AcctSeed__Time_Card_Line__c> timeCardLines = new List<AcctSeed__Time_Card_Line__c>();
        
        timeCardLines.add(
            new AcctSeed__Time_Card_Line__c(
               AcctSeed__Project__c = newsite.Project__c,
               AcctSeed__Project_Task__c = projectTasks[0].Id,
               AcctSeed__Time_Card__c = timeCards[0].Id,
               AcctSeed__Time_Card_Variable_1__c = accVariable[0].Id,
                 AcctSeed__Time_Card_Variable_2__c= accVariable1[0].Id,
                Site__c=newsite.Id
            )
        );
        
        timeCardLines.add(
            new AcctSeed__Time_Card_Line__c(
               AcctSeed__Project__c = newsite.Project__c,
               AcctSeed__Project_Task__c = projectTasks[0].Id,
               AcctSeed__Time_Card__c = timeCards[0].Id,
               AcctSeed__Time_Card_Variable_1__c = accVariable[0].Id,
                AcctSeed__Time_Card_Variable_2__c= accVariable1[0].Id,
               Site__c=newsite.Id
                
            )
        );
       insert timeCardLines;
        
        // Add the Id of the dummy Time Card as a parameter to our Page
        ApexPages.currentPage().getParameters().put('id', timeCards[0].Id);
        
        //Instantiate a new controller to test the page
        ApexPages.StandardController std = new ApexPages.StandardController(timeCards[0]);
        TimeCardControllerCustom ctl = new TimeCardControllerCustom(std);
        List<SelectOption> opt = ctl.getTimeCardPeriods();
        ctl.timeCardPeriodSetForTest(periods[0].Id);
        PageReference pr = ctl.saveCloneLineItems();
    }
}