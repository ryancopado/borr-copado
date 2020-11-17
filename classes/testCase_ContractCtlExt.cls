@isTest
private class testCase_ContractCtlExt {
    
    /*
     *  Test methods for Case_ContractCtlExt
     *
     */
    
    // Create test data
    @testSetup static void ccTestData() {
        
        Dynamic_Field_Id_Setting__c fieldIds = new Dynamic_Field_Id_Setting__c(
            SetupOwnerId = UserInfo.getOrganizationId(),
            Case_ServiceContractCase__c = 'field1',
            Case_Project__c = 'field2',
            Case_Branch__c = 'field3',
            Case_ContractType__c= 'field4'
        );
        insert fieldIds;
        
       user userid = [select id from user where isactive=true  and department ='o&m' and title like '%Manager%' limit 1];
        
        List<ContractTypeCaseRecordTypes__c> ctcrtList = new List<ContractTypeCaseRecordTypes__c>();
        ctcrtList.add(new ContractTypeCaseRecordTypes__c(Name = 'Borrego Warranty', Case_Record_Types__c = 'Construction Closeout;Operational Commissioning;Preoperational Commissioning;Warranty'));
        ctcrtList.add(new ContractTypeCaseRecordTypes__c(Name = 'O&M', Case_Record_Types__c = 'Additional Services;Landscaping;Maintenance Case;Module Washing;Performance Investigation;Reactive'));
        ctcrtList.add(new ContractTypeCaseRecordTypes__c(Name = 'O&M and Warranty', Case_Record_Types__c = 'Additional Services;Landscaping;Maintenance Case;Module Washing;Performance Investigation;Reactive'));
        ctcrtList.add(new ContractTypeCaseRecordTypes__c(Name = 'O&M T&M', Case_Record_Types__c = 'Additional Services;Landscaping;Maintenance Case;Module Washing;Performance Investigation;Reactive'));
        ctcrtList.add(new ContractTypeCaseRecordTypes__c(Name = 'Project', Case_Record_Types__c = 'Project'));
        insert ctcrtList;
        
        Account acc = new Account(Name = 'ccAccount');
        insert acc;
        
        Contract cntrct = new Contract(Name = 'ccContract', Contract_Status__c = 'Active', Escalator__c = 2, Escalator_Details__c = 'Increases per calendar year', Date_of_First_Escalator_to_be_Applied__c = system.today(), Payment_Options__c = 'Monthly in Advance', AccountId = acc.Id, Type__c = 'O&M',Service_Contract_Tier__c='Tier 0',
      Monitoring_Required__c ='No',Area_Supervisor__c=userid.id,Regional_Manager_User__c=userid.id);
        insert cntrct;
    }
    
    static testMethod void ccTest1() {
        
        Contract cntrct = [select Id from Contract];
        
        ApexPages.StandardController std = new ApexPages.StandardController(cntrct);
        ApexPages.currentPage().getParameters().put('contractId', cntrct.Id);
        ApexPages.currentPage().getParameters().put('retURL', '/');
        Case_ContractCtlExt ctl = new Case_ContractCtlExt(std);
        
        ctl.initRecordTypes();
        ctl.selectedRecordTypeId = ctl.recordTypeList[1].getValue();
        ctl.saveRecordType();
    }
}