@isTest(SeeAllData = true)
private class testComponentMaintenance {
    
    /*
     *  Test methods for CaseMaintenanceReportController.cls and ComponentMaintenanceCtrlExt.cls
     *
     */
    
    static void initCmpMaintData(Case cs, List<Component__c> cmpList) {
        
        Account acc = new Account(
            Name = 'CmpMaintAccount'
        );
        insert acc;
        
        Contact cnt = new Contact(
            AccountId = acc.Id,
            LastName = 'CmpMaintContact'
        );
        insert cnt;
        
        cs.AccountId = acc.Id;
        cs.ContactId = cnt.Id;
        cs.RecordTypeId = '012340000007kUM';
        insert cs;
        
        cmpList.add(new Component__c(
            Case__c = cs.Id,
            Component_Type__c = 'Transformers',
            Summary__c = 'Transformer summary')
        );
        cmpList.add(new Component__c(
            Case__c = cs.Id,
            Component_Type__c = 'Roof',
            Summary__c = 'Roof summary')
        );
        insert cmpList;
    }
    
    static testMethod void testCmpMaintCtrlExt() {
        
        Case cs = new Case();
        List<Component__c> cmpList = new List<Component__c>();
        
        initCmpMaintData(cs, cmpList);
        
        //Instantiate a new controller with an existing Component record
        ApexPages.StandardController std = new ApexPages.StandardController(cmpList[0]);
        ComponentMaintenanceCtrlExt ctl = new ComponentMaintenanceCtrlExt(std);
        
        ctl.saveAll();
        ctl.saveAndNew();
        
        //Instantiate a new controller with a new Component record
        Component__c cmp = new Component__c();
        std = new ApexPages.StandardController(cmp);
        ApexPages.currentPage().getParameters().put('caseId', cs.Id);
        ctl = new ComponentMaintenanceCtrlExt(std);
        
        ctl.saveComponent();
    }
    
    static testMethod void testCaseMaintRepCtrl() {
        
        Case cs = new Case();
        List<Component__c> cmpList = new List<Component__c>();
        List<Maintenance_Item__c> miList = new List<Maintenance_Item__c>();
        
        initCmpMaintData(cs, cmpList);
        
        List<Id> cmpIds = new List<Id>();
        for (Component__c cmp :cmpList) {
            cmpIds.add(cmp.Id);
        }
        miList = new List<Maintenance_Item__c>();
        miList = [select Id, Component_Type__c, Completed__c, Follow_Up_Required__c, Component__c, Notes__c 
                from Maintenance_Item__c where Component__c in :cmpIds];
        for (Maintenance_Item__c mi :miList) {
            mi.Completed__c = true;
            mi.Follow_Up_Required__c = 'Yes';
        }
        update miList;
        
        //Instantiate a new controller with the Case record
        ApexPages.StandardController std = new ApexPages.StandardController(cs);
        CaseMaintenanceReportController ctl = new CaseMaintenanceReportController(std);
        ctl.getDocumentLogoUrl();
        //ctl.ComponentImage();
        //ctl.ComponentSummary();
        
    }
}