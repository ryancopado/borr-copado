@isTest//(seealldata=True)
 Private class testDailySiteReportCtlExt {
     
  
   /* @testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    } */
    
    /* private
     *  Test methods for DailySiteReportCtlExt.cls
     *
     */
    
    // Create test data @testSetup 
   @testSetup
     static void dsrTestData() {
        
       
        ASeedAccountingSettingsSetupTest.testDataSetup();
        Account acc = new Account(Name = 'nsvAccount');
       
        insert acc;
        system.debug('ACCOUNT DETAILS LOOK HERE' +acc);
        
        Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
       
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = acc.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Project Awarded', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(), Proposal_Submitted_Date__c = System.today(), Financing__c = 'Cash', 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId());
        insert testOpportunity;
        
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Account__c = acc.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Branch__c = 'San Diego',PC_Code__c = 10);  // ,PC_Code__c = '10''
        insert testProject;
        system.debug('LOOK HERE TESTPROJECT ID' +testProject );
        
        
        Site__c testSite = new Site__c(Name = 'testSite', Project__c = testProject.Id, Site_City__c='Hopkinton',Site_Zip__c='01748',Type__c='Fixed Tilt Ground',Opportunity__c =testOpportunity.id);
        insert testSite;
        
        List<ProjectPartner__c> ppList = new List<ProjectPartner__c>();
        ppList.add(new ProjectPartner__c(ASProject__c = testProject.Id, AccountId__c = acc.Id));
        insert ppList;
        
        Dynamic_Field_Id_Setting__c fieldIds = new Dynamic_Field_Id_Setting__c();
        fieldIds.DailySiteReport_Project__c = '00N4C0000018kAC';
        insert fieldIds;
       // Dynamic_Field_Id_Setting__c fieldIds = Dynamic_Field_Id_Setting__c.getOrgDefaults();
        
        Daily_Site_Report__c testDSR = new Daily_Site_Report__c(Name = 'testDSR', Project__c =testProject.Id, Site__c = testSite.Id); //'a6934000001Kx1kAAC'
        insert testDSR;
    }
    
    
     static testMethod void dsrTest1() {
        string p;
        Dynamic_Field_Id_Setting__c fieldIds = Dynamic_Field_Id_Setting__c.getOrgDefaults();
        AcctSeed__Project__c testProject = [select Id from AcctSeed__Project__c ];
        system.debug('the PROJECT ID' +testProject );
       // p ='a1t1g000000DEOAAA4';
      /*  if (testProject.size() > 0){
        
             p = testProject[0].Id;
            }*/
        Daily_Site_Report__c testDSR = new Daily_Site_Report__c();
        
        ApexPages.StandardController std = new ApexPages.StandardController(testDSR);
        
        
        ApexPages.currentPage().getParameters().put('CF' + fieldIds.DailySiteReport_Project__c + '_lkid', testProject.Id);//testProject.Id
        ApexPages.currentPage().getParameters().put('retURL', '/' + testProject.Id); //testProject.Id
        DailySiteReportCtlExt ctl = new DailySiteReportCtlExt(std);
        
        ctl.initNewDSR();
        ctl.editDSR();
        List<SelectOption> siteOptions = ctl.getSites();
        ctl.saveDSR();
        
        ctl.newDSR.dsr.Date__c = system.today();
        ctl.newDSR.dsrDateChange();
        ctl.newDSR.dsrsiteChange();
        ctl.newDSR.dsrProjectChange();
        //ctl.newDSR.initSubConCompliance();
        
        String sId = ctl.getselectedSite();
        ctl.setselectedSite(siteOptions[0].getValue());
        
        ctl.newDSR.laborList[0].addLaborRow();
        ctl.saveDSR();
        ctl.newDSR.laborList[1].addLaborRow();
        ctl.newDSR.laborList[1].removeLaborRow();
        
        String subConAcc = ctl.newDSR.laborList[0].getselectedSubConAcc();
        ctl.newDSR.laborList[0].setselectedSubConAcc(ctl.newDSR.laborList[0].subConAccOptions[0].getValue());
        ctl.newDSR.laborList[0].subConNumber();
        ctl.newDSR.laborList[0].subContractorNameLabor();
        ctl.newDSR.laborList[0].labor.Number_of_Workers__c = 2;
        ctl.newDSR.laborList[0].labor.Hours__c = 3;
        ctl.newDSR.laborList[0].labor.Work_Performed__c = 'Lots';
        
        ctl.newDSR.laborList[0].changeLaborTotalHours();
        
              
        ctl.newDSR.keyTasksList[ctl.newDSR.keyTasksList.size() - 1].addKeyTasksRow();
        for (Integer i=ctl.newDSR.keyTasksList.size() - 1; i>0; i--) {
            ctl.newDSR.keyTasksList[i].removeKeyTasksRow();
        }
        
        ctl.newDSR.equipmentList[0].addEquipmentRow();
        ctl.saveDSR();
        ctl.newDSR.equipmentList[0].addEquipmentRow();
        //ctl.newDSR.equipmentList[0].removeEquipmentRow();
        subConAcc = ctl.newDSR.equipmentList[0].getselectedSubConAcc();
        ctl.newDSR.equipmentList[0].setselectedSubConAcc(ctl.newDSR.equipmentList[0].subConAccOptions[0].getValue());
        ctl.newDSR.equipmentList[0].subConNumber();
        ctl.newDSR.equipmentList[0].subContractorNameEquipment();
        ctl.newDSR.equipmentList[0].removeEquipmentRow();
        
       /* ctl.newDSR.equipmentList[0].addEquipmentRow();
       ctl.saveDSR();
        ctl.newDSR.equipmentList[1].addEquipmentRow();
         ctl.newDSR.materialList[1].removeEquipmentRow();
        subConAcc = ctl.newDSR.equipmentList[1].getselectedSubConAcc();
       ctl.saveDSR();
        ctl.newDSR.equipmentList[0].setselectedSubConAcc(ctl.newDSR.equipmentList[0].subConAccOptions[1].getValue());
        ctl.newDSR.equipmentList[0].subConNumber();
        ctl.newDSR.equipmentList[0].subContractorNameEquipment();
        ctl.newDSR.equipmentList[0].removeEquipmentRow();
              */
        
        ctl.newDSR.materialList[0].addMaterialRow();
         ctl.saveDSR();
         ctl.newDSR.materialList[1].addMaterialRow();
        ctl.newDSR.materialList[1].removeMaterialRow();
        System.assert(ApexPages.hasMessages());
        
        ctl.saveDSR();
        
    }
    
    
    static testMethod void dsrTest2() {
        
        Daily_Site_Report__c testDSR = [select Id from Daily_Site_Report__c];
        
        ApexPages.StandardController std = new ApexPages.StandardController(testDSR);
        DailySiteReportCtlExt ctl = new DailySiteReportCtlExt(std);
        
        ctl.initNewDSR();
        ctl.editDSR();
        ctl.getSites();
        String sId = ctl.getselectedSite();
        ctl.setselectedSite(sId);
        ctl.saveDSR();
    }
    
}