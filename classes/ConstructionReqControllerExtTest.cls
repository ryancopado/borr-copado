@isTest(seeAllData=true)
    public class ConstructionReqControllerExtTest {
    static void ConstructionReqControllerExtTest1() 
 {
        
        // Create test data
        Account vendorAccount = new Account(
            Branch__c = 'New England',
            Name = 'TESTvendor',
            Phone = '123-456-7890',
            Target_Market__c = 'Agriculture',
            Type = 'Customers',
            Job_Type__c = 'Private',
            Small_Business_Type__c = 'Veteran Owned',
            Description = 'This is a test',
            ShippingCity = 'San Francisco'
        );
        insert vendorAccount;

        AcctSeed__Project__c testProject = [SELECT Id, Name, AcctSeed__Opportunity__c, AcctSeed__Account__c FROM AcctSeed__Project__c WHERE Name =: 'Loft 27'];
        AcctSeed__Project_Task__c projectTask = [SELECT Id, Name, AcctSeed__Project__c FROM AcctSeed__Project_Task__c WHERE AcctSeed__Project__c =: testProject.Id AND Name =: 'Solar Modules'];
        AcctSeedERP__Sales_Order__c salesOrder = [SELECT Id, Name, Project__c FROM AcctSeedERP__Sales_Order__c WHERE Project__c =: testProject.Id];
        RecordType rt = [SELECT Id, Name FROM RecordType WHERE Name =: 'Major Component'];
                
        // Add the parameters to our page
        Dynamic_Field_Id_Setting__c FieldIds = [SELECT Sales_Order_Line_Project_Field_Id__c, Sales_Order_Line_Sales_Order_Field_Id__c, Sales_Order_Line_Ent__c FROM Dynamic_Field_Id_Setting__c];
        ApexPages.currentPage().getParameters().put('CF' + FieldIds.Sales_Order_Line_Project_Field_Id__c, testProject.Id);
        ApexPages.currentPage().getParameters().put('CF' + FieldIds.Sales_Order_Line_Sales_Order_Field_Id__c, salesOrder.Id);
        ApexPages.currentPage().getParameters().put('ent', FieldIds.Sales_Order_Line_Ent__c);
        ApexPages.currentPage().getParameters().put('RecordType', rt.Id);
                
        //Instantiate a new controller to test the page
        AcctSeedERP__Sales_Order_Line__c conrequisition = new AcctSeedERP__Sales_Order_Line__c();
        ApexPages.StandardController std = new ApexPages.StandardController(conrequisition);
        ConstructionReqControllerExt ctl = new ConstructionReqControllerExt(std);
        ctl.initConstructionReq();
        List<SelectOption> opt = ctl.getProjProducts();
        ctl.requiredFieldSetForTest(testProject.AcctSeed__Account__c, projectTask.Id, vendorAccount.Id, opt[1].getValue());
        PageReference pr = ctl.saveMajorConstructionReq();
    } 
    }