public with sharing class TestProductionModelApprovalTrigger {

    static testMethod void testCase(){

        User owner = [select Id from User where Name = 'System User'];
        
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
         
       Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                        Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
       insert opp;
       
       Production_Modeling__c prod = new Production_Modeling__c(Name='ProductionModel',Opportunity__c=opp.Id,
                                           Production_Modeling_Stage__c='Sale',System_Size__c=1001,Percent_of_Downtime_Modeled__c=56,
                                           Raw_Annual_Production__c=77,Status__c='Draft',Date_Needed_By__c=Date.newinstance(2018, 3, 11));
    
        insert prod ;
        prod.IsSubmittedForApproval__c=true;
        
        update prod ;
       
    }    

}