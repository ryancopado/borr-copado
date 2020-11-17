public with sharing class TestFinanceRequestApprovalTrigger {

    static testMethod void testCase(){

        User owner = [select Id from User where Name = 'System User'];
        
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
         
       Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                        Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
       insert opp;
       
       Finance_Request__c finc= new Finance_Request__c(Name='FinanceRequest',Opportunity__c=opp.Id,
                                            Credit_Rating__c='3',Owned_or_Leased__c='Owned',Credit_Rating_Agency__c='D&B',
                                            System_Size_DC__c=3,Project_Location__c='Indiana',Year_1_Production__c=3,Number_of_Sites__c=3,
                                            Cost_per_DC_Watt_ASP__c=3,Estimated_In_Service_Date__c=date.today(),Ineligible_Interconnection_EPC_watt__c=3,
                                            Utility_Rate_kWh__c=3,Annual_Utility_Escalation__c=3,Incentive_Type__c='3',
                                            PPA_Target_Rate__c=3,Requested_Annual_Escalation_Rate__c=3,PPA_Agreement_Term__c=3,Status__c='Approved',IsSubmittedForApproval__c=true);
                                         
    
        insert finc;
       
      
       finc.Status__c='Previously Approved';
       update finc;
       
    }    
        

}