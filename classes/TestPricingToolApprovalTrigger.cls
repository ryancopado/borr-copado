public with sharing class TestPricingToolApprovalTrigger {

    static testMethod void testCase(){

        User owner = [select Id from User where Name = 'System User'];
        
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
         
       Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                        Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
       insert opp;
       
       Pricing_Tool_Approval__c pric = new Pricing_Tool_Approval__c(Name='pricingtool',EPC_Contract_Price_from_Pricing_Tool__c=565,
                                            System_Size_from_Pricing_Tool__c=122,watt_from_Pricing_Tool__c=34,Opportunity__c=opp.Id,
                                            Link_to_Pricing_Tool_on_box_com__c='https://cs3.salesforce.com/a1D/',
                                            Status__c='Approved', Production_Guarantee_Level__c = 'None');
    
        insert pric;
        pric.IsSubmittedForApproval__c=true;
        
        update pric;
       
    }    

}