@isTest
private class testAsset_ServiceVisitCtlExt {
    
    /*
     *  Test methods for Asset_ServiceVisitCtlExt
     *
     */
    
    // Create test data
    @testSetup static void asvTestData() {
        
        Dynamic_Field_Id_Setting__c fieldIds = new Dynamic_Field_Id_Setting__c(
            SetupOwnerId = UserInfo.getOrganizationId(),
            Asset_ServiceVisitCase__c = 'field1',
            Asset_Project__c = 'field2',
            Asset_Contract__c = 'field3',
            Asset_ProductWarrantyStartDate__c = 'field4'
        );
        insert fieldIds;
        
        Product2 p = new Product2(Name = 'Miscellaneous', IsActive = true);
        insert p;
        
        Account acc = new Account(Name = 'asvAccount');
        insert acc;
        Case cas = new Case(Status ='New', Priority = 'Medium', Origin = 'Email');
        insert cas;
        Contract cntrct = new Contract(Name = 'asvContract', AccountId = acc.Id, Type__c = 'O&M');
        insert cntrct;
        Map<id,SV__c> svMap=new Map<id,SV__c>();
        list<SV__c> svlist=new list<SV__c>();
        SV__c sv = new SV__c(Account__c = acc.Id, Contract__c = cntrct.Id,Case__c=cas.id);
        insert sv;
        sv.Completed__c=true;
        update sv;
        svMap.put(sv.id, sv);
        svlist.add(sv);
        Pending_Work__c pw=new Pending_Work__c();
        pw.Associated_Service_Visit_to_Close__c=sv.id;
        pw.Status__c='Open';
        insert pw;
        pw.Status__c='Assigned';
        update pw;
        //ServiceVisitService.caseBillingStatus(null,svMap,true,false,false,false);
        delete sv;
        undelete sv;
        
        
    }

    static testMethod void asvTest1() {
        
        SV__c sv = [select Id from SV__c ];
        
        ApexPages.StandardController std = new ApexPages.StandardController(sv);
        ApexPages.currentPage().getParameters().put('serviceVisitId', sv.Id);
        ApexPages.currentPage().getParameters().put('retURL', '/');
        Asset_ServiceVisitCtlExt ctl = new Asset_ServiceVisitCtlExt(std);
        
        ctl.initRecordTypes();
    }
}