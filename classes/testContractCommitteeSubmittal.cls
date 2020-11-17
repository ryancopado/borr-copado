/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers related to the Contract Committee Submittal object.
 *
 */
@isTest(seeAllData=true)
private class testContractCommitteeSubmittal {
    
    public static Contract_Committee_Submittal__c initTestData() {
        
        Id ccSubRtId;
        Id accRtId;
        Id projRtId;
        
        List<RecordType> rtList = [select Id, Name from RecordType where Name =: 'Contract Execution' or Name =: 'Customer' or Name =: 'AS Commercial Project'];
        for (RecordType rt : rtList) {
            if (rt.Name == 'Contract Execution') {
                ccSubRtId = rt.Id;
            }
            if (rt.Name == 'Customer') {
                accRtId = rt.Id;
            }
            if (rt.Name == 'AS Commercial Project') {
                projRtId = rt.Id;
            }
        }
        
        Account acc = new Account();
        acc.Name = 'TestAccount';
        acc.Type = 'Business';
        acc.Job_Type__c = 'Commercial';
        acc.Branch__c = 'Berkeley';
        acc.ShippingStreet = 'x';
        acc.ShippingCity = 'x';
        acc.ShippingState = 'x';
        acc.ShippingPostalCode = 'x';
        acc.Branch__c = 'Berkeley';
        acc.RecordTypeId = accRtId;
        insert acc;
        
        List<Contact> cnList = new List<Contact>();
        cnList.add(new Contact(AccountId = acc.ID, FirstName = 'FirstTest1', LastName = 'LastTest1')); 
        cnList.add(new Contact(AccountId = acc.ID, FirstName = 'FirstTest2', LastName = 'LastTest2'));          
        cnList.add(new Contact(AccountId = acc.ID, FirstName = 'FirstTest3', LastName = 'LastTest3')); 
        
        insert cnList;
        
        Opportunity opp = new Opportunity();
        opp.Approximate_Install_Date__c=system.now().Date();
        opp.Rebate_Assigned_To__c=([Select Id from User limit 1][0]).id;
        opp.Expected_Rebate__c=20;
        opp.Name='Test Opportunity';
        opp.Job_Type__c ='PV Direct';                                  
        opp.Accountid =acc.id;
        opp.StageName='Project Awarded';
        opp.Last_Date_Called__c=system.now().Date();          
        opp.Module_Delivery_Date__c =system.now().Date();         
        opp.Inverter_Delivery_Date__c =system.now().Date();
        opp.Racking_Delivery_Date__c =system.now().Date();          
        opp.CloseDate=system.now().date();                  
        opp.Type='Turnkey System';
        opp.Proposal_Submitted_Date__c = system.today();
        opp.Proposed_System_Size__c = 10000;
        opp.Expected_Rebate__c = 0;
        opp.System_Owner__c = cnList[0].Id;
        opp.Utility_Rate__c = 'N/A';
        opp.Prevailing_Wage__c = 'No';
        opp.Original_Contract_System_Size__c = 1000;
        opp.Amount = 1000;
        opp.Financing__c = 'Cash';
        opp.Union__c = 'No';
        opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId();
        insert opp;
        
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        List<PriceBookEntry> pbeList = [select Id from PricebookEntry where IsActive =: True Limit 2];
        for (PriceBookEntry pbe : pbeList) {  
            OpportunityLineItem oli = new OpportunityLineItem();
            oli.OpportunityId = opp.Id;
            oli.Quantity = 2;
            oli.TotalPrice = 9;
            oli.PricebookEntryId = pbe.Id;
            oliList.add(oli);      
        }
        insert oliList;
        
        AcctSeed__Project__c project = new AcctSeed__Project__c();
        project.RecordTypeId = projRtId;
        project.AcctSeed__Opportunity__c = opp.id;
        project.Name = 'Test Project';
        insert project;
        
        Production_Modeling__c productionModel=new Production_Modeling__c();
        productionModel.Opportunity__c = opp.id;
        productionModel.Name = 'Test Model';
        productionModel.Annual_Production_MWh__c = 200;
        productionModel.Specific_Yield_kWh_kWp__c = 300;
        insert productionModel;
        
        //List<AcctSeed__Project_Task__c> liList = new List<AcctSeed__Project_Task__c>();
        //liList = [select Id, Name from AcctSeed__Project_Task__c where Name =: 'Solar Modules' limit 1];
        
        //system.debug('*****size of liList = ' + liList.size());
        
        Finance_Request__c financeRequest = new Finance_Request__c();
        financeRequest.Name = 'FNR Test';
        financeRequest.Opportunity__c = opp.Id;
        financeRequest.Owned_or_Leased__c = 'Owned';
        financeRequest.Local_Property_Tax_Treatment__c = 'xx';
        financeRequest.Credit_Rating__c = 'xx';
        financeRequest.Credit_Rating_Agency__c = 'Other';
        //financeRequest.Property_Tax_Rate__c = 10;
        financeRequest.System_Size_DC__c = 10000;
        financeRequest.Year_1_Production__c = 10000;
        financeRequest.Year_1_O_M_amount__c = 10000;
        financeRequest.Cost_per_DC_Watt_ASP__c = 10;
        financeRequest.Project_Location__c = 'California';
        financeRequest.Number_of_Sites__c = 1;
        financeRequest.Estimated_In_Service_Date__c = system.today();
        financeRequest.Utility_Rate_kWh__c = 10;
        financeRequest.Annual_Utility_Escalation__c = 10;
        financeRequest.Incentive_Type__c = 'xx';
        financeRequest.Ineligible_Interconnection_EPC_watt__c = 1;
        insert financeRequest;
        
        PSD__c psDesign = new PSD__c();
        psDesign.Opportunity__c = opp.Id;
        psDesign.Site_Address2__c = 'xx';
        psDesign.Which_AC_Rating_is_Required__c = 'AC';
        psDesign.Shading_Notes__c = 'xx';
        psDesign.Designer__c = 'Outsource';
        psDesign.Applications_Engineer__c = 'Other';
        psDesign.Contact__c = cnList[0].Id;
        insert psDesign;
        
        PSD_Revision__c psdRevision = new PSD_Revision__c();
        psdRevision.Name = 'Revision 2';
        psdRevision.Pre_Sales_Design__c = psDesign.Id;
        psdRevision.Reason_for_modifiction__c = 'Design Change';
        psdRevision.Proposal_Level_Needed__c = 'L1';
        psdRevision.Due_Date__c = system.today();
        psdRevision.Priority__c = 'High';
        psdRevision.Revision_Status__c = 'Submitted';
        psdRevision.OpportunityLookup__c = opp.Id;
        insert psdRevision;
        
        Pricing_Tool_Approval__c ptApproval = new Pricing_Tool_Approval__c();
        ptApproval.Name = 'Test Pricing Tool Approval';
        ptApproval.Opportunity__c = opp.Id;
        ptApproval.Applications_Engineer__c = 'Patrick Canning';
        ptApproval.System_Size_from_Pricing_Tool__c = 10000;
        ptApproval.EPC_Contract_Price_from_Pricing_Tool__c = 10000;
        ptApproval.watt_from_Pricing_Tool__c = 2;
        ptApproval.Estimated_NTP_Date__c = system.today();
        ptApproval.Estimated_COD_Date__c = system.today();
        ptApproval.Pre_Sales_Design__c = psDesign.Id;
        ptApproval.PSD_Revision__c = psdRevision.Id;
        ptApproval.Link_to_Pricing_Tool_on_box_com__c = 'http://www.google.com';
        ptApproval.Customer_requirements_beyond_code__c = 'xx';
        ptApproval.Are_there_union_labor_requirements__c = 'xx';
        ptApproval.Anyone_walked_the_site__c = 'xx';
        ptApproval.Any_sign_of_wetlands__c = 'xx';
        ptApproval.Permit_costs_validated_with_the_town__c = 'xx';
        ptApproval.Town_restrictions_or_mandates__c = 'xx';
        ptApproval.Status__c = 'New';
        ptApproval.Production_Guarantee_Level__c = 'None';
        insert ptApproval;
        ptApproval.Status__c = 'Preliminary Approval';
        update ptApproval;
        ptApproval.Status__c = 'Final Approval';
        update ptApproval;
        
        Contract_Committee_Submittal__c ccSubmittal = new Contract_Committee_Submittal__c();
        ccSubmittal.RecordTypeId = ccSubRtId;
        ccSubmittal.Opportunity__c = opp.Id;
        ccSubmittal.Pricing_Tool_Approval__c = ptApproval.Id;
        ccSubmittal.Finance_Request__c = financeRequest.Id;
        ccSubmittal.Production_Modeling__c = productionModel.Id;
        ccSubmittal.Project__c = project.Id;
        //ccSubmittal.Line_Item__c = liList[0].Id;
        ccSubmittal.Requested_amount_to_spend__c = 10000;
        ccSubmittal.CC_Request__c = 'xx';
        ccSubmittal.PSD_Revision__c = psdRevision.Id;
        insert ccSubmittal;
        
        return ccSubmittal;
    }
    
    public static PricingToolApproval_ApprovalCTL initPricingToolApproval_ApprovalProc() {
        
        // Initialize the basic data set
        Contract_Committee_Submittal__c ccSubmittal = initTestData();
        Pricing_Tool_Approval__c ptApproval = [select Id, Pricing_Request_Completed__c, Status__c from Pricing_Tool_Approval__c where Id =: ccSubmittal.Pricing_Tool_Approval__c];
        ptApproval.Status__c = 'New';
        ptApproval.Pricing_Request_Completed__c = true;
        ptApproval.Process_Time_hours__c = 2;
        ptApproval.Link_to_Pricing_Tool_on_box_com__c = 'www.google.com';
        ptApproval.Final_EPC_W__c = 10;
        ptApproval.Final_EPC_Total__c = 10;
        ptApproval.Direct_Margin__c = 10;
        ptApproval.Module_Price_Assumption__c = 'test';
       // ptApproval.AE_Design_Notes_and_Scope_Concerns__c = 'test';
        ptApproval.System_Size_from_Pricing_Tool__c = 100;
        ptApproval.Gross_Margin_from_the_Pricing_Tool__c = 100;
        ptApproval.Date_Request_Entered__c = system.today();
        ptApproval.Date_Pricing_Needed_By__c = system.today() + 5;
        ptApproval.Fields_Complete__c = true;
        ptApproval.Ineligible_costs__c = 5;
        update ptApproval;
        
        // Initialize the approval process for Pricing Tool Approval
        ApexPages.currentPage().getParameters().put('ptaID', ptApproval.Id);
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Submitting request for approval.');
        req1.setObjectId(ptApproval.Id);
        req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        Approval.ProcessResult result = Approval.process(req1);
        
        system.debug('***** PTA Approval.ProcessResult = ' + result);
        
        List<Id> newWorkItemIds = result.getNewWorkitemIds();
        if (newWorkItemIds != null && newWorkItemIds.size() > 0) {
            ApexPages.currentPage().getParameters().put('id',newWorkItemIds.get(0));
        }
        
        PricingToolApproval_ApprovalCTL proc = new PricingToolApproval_ApprovalCTL();
        return proc;
        
        
    }
    
    static testMethod void testclsCCSubProducts() {
        
        Contract_Committee_Submittal__c ccSubmittal = initTestData();
        ApexPages.StandardController controller = new ApexPages.StandardController(ccSubmittal);
        clsCCSubProducts clsCCSubProducts =new clsCCSubProducts(controller);
        clsCCSubProducts.getProducts();
     }
     
     static testMethod void testPTAapprovalCase1() {
        
        PricingToolApproval_ApprovalCTL proc = initPricingToolApproval_ApprovalProc();
        proc.cancel();
     }
     
     static testMethod void testPTAapprovalCase2() {
        
        PricingToolApproval_ApprovalCTL proc = initPricingToolApproval_ApprovalProc();
       // proc.reject();
     }
     
     static testMethod void testPTAapprovalCase3() {
        
        PricingToolApproval_ApprovalCTL proc = initPricingToolApproval_ApprovalProc();
      //  proc.approve();
     }
     
     static testMethod void testPTAapprovalCase4() {
        
        PricingToolApproval_ApprovalCTL proc = initPricingToolApproval_ApprovalProc();
      //  proc.preliminaryApproval();
     }
     
     static testMethod void testPTAapprovalCase5() {
        
        PricingToolApproval_ApprovalCTL proc = initPricingToolApproval_ApprovalProc();
      //  proc.finalApproval();
     }
}