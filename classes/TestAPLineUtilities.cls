/*
Auther: Madan (Forcebrain Developer)
Date: Dec 12, 2017
Description: Test class related to APLineUtilities.cls
*/
@isTest
private class TestAPLineUtilities {

 @testSetup
    public static void setup() {
        //TestDataSuite.initialize();
      	ASeedAccountingSettingsSetupTest.testDataSetup(); 
    }
    
    static User owner = [select Id from User where Name = 'System User'];
    static testMethod void myUnitTest() {
        // create AcctSeed__Accounting_Variable__c record
        List<AcctSeed__Accounting_Variable__c> lstAV = new List<AcctSeed__Accounting_Variable__c>();
        AcctSeed__Accounting_Variable__c accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='Nor Cal';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        lstAV.add(accvar);
        
        accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='New England';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        lstAV.add(accvar);
        
        accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='Mid Atlantic';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        lstAV.add(accvar);
        
        accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='So Cal';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        lstAV.add(accvar);
        
        accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='Puerto Rico';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        lstAV.add(accvar);
        
        accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='Mid-Atlantic';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        lstAV.add(accvar);
        
        accvar = new AcctSeed__Accounting_Variable__c();
        accvar.Name='Midwest';
        accvar.AcctSeed__Type__c='GL Account Variable 1';
        accvar.AcctSeed__Active__c=true;
        lstAV.add(accvar);
        
        insert lstAV;
        
        //Set Page Parameters
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        
        Contract cont = new Contract(AccountId = acc.Id); insert cont;
        SV__c sv = new SV__c(Contract__c = cont.Id);
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        User bh = [select Id from User where Name = 'Bradley Hibberd'];
        Product2 ProdMake;
        System.runAs(bh){
           // CreatePriceBook();
            ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                            Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
        }
        
        AcctSeed__Project__c[] proj = new AcctSeed__Project__c[0];
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-001', OwnerId = owner.Id, Branch__c='Midwest', PC_Code__c=1)); 
        /*
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2457',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-002', OwnerId = owner.Id, Branch__c='Mid Atlantic', PC_Code__c=2)); 
        
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2458',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-003', OwnerId = owner.Id, Branch__c='Berkeley', PC_Code__c=3)); 
                                        
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2459',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-004', OwnerId = owner.Id, Branch__c='Oakland', PC_Code__c=4)); 
        
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2460',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-005', OwnerId = owner.Id, Branch__c='Puerto Rico', PC_Code__c=5)); 
        
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2461',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-006', OwnerId = owner.Id, Branch__c='San Diego', PC_Code__c=6)); 
        
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2462',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-007', OwnerId = owner.Id, Branch__c='Mid Atlantic', PC_Code__c=7)); 
        
        proj.add(new AcctSeed__Project__c(Name = 'Knight - 2463',AcctSeed__Opportunity__c = opp.Id, AcctSeed__Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-008', OwnerId = owner.Id, Branch__c='Boston', PC_Code__c=8)); 
        */
        insert proj;
                                        
        AcctSeed__Account_Payable_Line__c apl = new AcctSeed__Account_Payable_Line__c();
        
        //1.
        test.startTest();
        proj[0].Branch__c='Mid Atlantic';
        update proj;
        apl.AcctSeed__Project__c = proj[0].Id;
        
        Map<Id, AcctSeed__Project__c> projMap = new Map<Id, AcctSeed__Project__c>();
        projMap.put(proj[0].Id, proj[0]);
        
        APLineUtilities.aplSetBranch(projMap, new List<AcctSeed__Account_Payable_Line__c>{apl});
        test.stopTest();
        //2.
     /*   proj[0].Branch__c='Berkeley';
        update proj;
        apl.AcctSeed__Project__c = proj[0].Id;
        
        projMap = new Map<Id, AcctSeed__Project__c>();
        projMap.put(proj[0].Id, proj[0]);
        
        APLineUtilities.aplSetBranch(projMap, new List<AcctSeed__Account_Payable_Line__c>{apl});
        
        //3.
        proj[0].Branch__c='Oakland';
        update proj;
        apl.AcctSeed__Project__c = proj[0].Id;
        
        projMap = new Map<Id, AcctSeed__Project__c>();
        projMap.put(proj[0].Id, proj[0]);
        
        APLineUtilities.aplSetBranch(projMap, new List<AcctSeed__Account_Payable_Line__c>{apl});
        
        //4.
        proj[0].Branch__c='Puerto Rico';
        update proj;
        apl.AcctSeed__Project__c = proj[0].Id;
        
        projMap = new Map<Id, AcctSeed__Project__c>();
        projMap.put(proj[0].Id, proj[0]);
        
        APLineUtilities.aplSetBranch(projMap, new List<AcctSeed__Account_Payable_Line__c>{apl});
        
        //5.
        proj[0].Branch__c='San Diego';
        update proj;
        apl.AcctSeed__Project__c = proj[0].Id;
        
        projMap = new Map<Id, AcctSeed__Project__c>();
        projMap.put(proj[0].Id, proj[0]);
        
        APLineUtilities.aplSetBranch(projMap, new List<AcctSeed__Account_Payable_Line__c>{apl});
        
        //6.
        proj[0].Branch__c='Mid Atlantic';
        update proj;
        apl.AcctSeed__Project__c = proj[0].Id;
        
        projMap = new Map<Id, AcctSeed__Project__c>();
        projMap.put(proj[0].Id, proj[0]);
        
        APLineUtilities.aplSetBranch(projMap, new List<AcctSeed__Account_Payable_Line__c>{apl});
        
        //7.
        proj[0].Branch__c='Boston';
        update proj;
        apl.AcctSeed__Project__c = proj[0].Id;
        
        projMap = new Map<Id, AcctSeed__Project__c>();
        projMap.put(proj[0].Id, proj[0]);
        
        APLineUtilities.aplSetBranch(projMap, new List<AcctSeed__Account_Payable_Line__c>{apl});
       */
    }
}