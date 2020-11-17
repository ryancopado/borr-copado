/*
Auther: Madan (Forcebrain Developer)
Date: Dec 12, 2017
Description: Test class related to ChangeOrderApprovalRequest.cls
*/
@isTest
private class TestChangeOrderApprovalRequest {

 @testSetup
    public static void setup() {
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    }
    static User owner = [select Id from User where Name = 'System User'];
    
    static testMethod void myUnitTest() {
        
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
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        SFDC_Project__c sfdc_proj = new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id); 
        insert sfdc_proj;
        
        Budget__c budget = new Budget__c(Project__c = sfdc_proj.Id);
        insert budget;
        
        RecordType major,minor,sub,change ;
       
        Con_Req__c[] req = new Con_Req__c[0];
        req.add(new Con_Req__c(
                                ASProject__c = proj[0].Id,  
                                Status__c = 'New', 
                                New_Quantity__c = 2, 
                                Original_Product__c = ProdMake.Id,
                                Type__c = 'Original Order',
                                Change_Order_Type__c = 'System Size or Product Change'
                            )); 
        req.add(new Con_Req__c(ASProject__c = proj[0].Id));
        req.add(new Con_Req__c(Service_Visit__c = sv.Id, Tax_Rate__c = null));
        req.add(new Con_Req__c(Service_Visit__c = sv.Id));
        req.add(new Con_Req__c(Service_Visit__c = sv.Id));
        insert req;
        
        ChangeOrderApprovalRequest.SendApprovalRequest(req[0].Id);
    }
}