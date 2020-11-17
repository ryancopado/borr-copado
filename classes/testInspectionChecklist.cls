/**
 * Test methods for testing classes and triggers related to the Inspection Checklist object. 
 */
@isTest
private class testInspectionChecklist {

   @testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    }

    static testMethod void testICtrigger() {
        
        // Test InspectionChecklist.trigger
        AcctSeed__Project__c proj = ProjectTest.setupTestProj();
        User owner = [select Id from User where Name = 'Michael Hall']; 
    Account AccMake = new Account(Name = 'test123',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert AccMake;   
    Opportunity OppMake1 = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 24561',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting',Team__c='a1O2H00000D2ijv'); insert OppMake1;       
        //AcctSeed__Project__c opp = ProjectTest.setupTestProj();
        Site__c projectSite = new Site__c();
        projectSite.Project__c = proj.Id;
        projectSite.Name = '1234 Main Street';
       projectSite.opportunity__c=OppMake1.Id;
        projectSite.Site_Address__c='123 test street';
         projectSite.Site_City__c='Hopkinton';
          projectSite.Site_Zip__c='01748';
          projectSite.Type__c='Fixed Tilt Ground';
        insert projectSite;
        Inspection_Checklist__c ic = new Inspection_Checklist__c(
            Project__c = proj.Id,
            Site__c = projectSite.Id
        );
        insert ic;
    }
}