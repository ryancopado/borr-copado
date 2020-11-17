global class RenewContractsBatch implements Database.Batchable<sObject>
{

    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        
        DateTime dT = System.now();
        Date endDate = date.newinstance(dT.year(), dT.month(), dT.day());      
        system.debug('End date = '+enddate);
        
        String query = 'SELECT Id, ContractTerm, EndDate, Current_Year_Contract_Start__c, CY_Completed_Landscaping_Visits__c, CY_Completed_Module_Wash_Visits__c, CY_Completed_Primary_PM_Visits__c, CY_Completed_Reactive_Visits__c, CY_Completed_Secondary_PM_Visits__c, PY_Completed_Landscaping_Visits__c, PY_Completed_Module_Wash_Visits__c, PY_Completed_Primary_PM_Visits__c, PY_Completed_Reactive_Visits__c, PY_Completed_Secondary_PM_Visits__c FROM Contract WHERE Does_Contract_Auto_Renew__c= \'YES\' AND Contract_Status__c= \'ACTIVE\' AND (EndDate=:endDate)';// OR Current_Year_Contract_Start__c = :endDate        
        return Database.getQueryLocator(query);        
    }   
        
    global void execute(Database.BatchableContext BC, List<Contract> Contracts)
    {
        system.debug('No of contracts fetched for renewal = '+Contracts.size());
        try 
        {
            for(Contract c :Contracts)
            {
                system.debug('End Date before update is = '+c.EndDate);
                
                //Date endDate = c.EndDate.addMonths(c.ContractTerm);   
                Date endDate = c.EndDate.addMonths(12);  
                system.debug('End Date before update is = '+endDate);
                
                c.EndDate = endDate;
                
                // Reset the visit counts
                c.PY_Completed_Landscaping_Visits__c = c.CY_Completed_Landscaping_Visits__c;
                c.CY_Completed_Landscaping_Visits__c = 0;
                c.PY_Completed_Module_Wash_Visits__c = c.CY_Completed_Module_Wash_Visits__c;
                c.CY_Completed_Module_Wash_Visits__c = 0;
                c.PY_Completed_Primary_PM_Visits__c = c.CY_Completed_Primary_PM_Visits__c;
                c.CY_Completed_Primary_PM_Visits__c = 0;
                c.PY_Completed_Reactive_Visits__c = c.CY_Completed_Reactive_Visits__c;
                c.CY_Completed_Reactive_Visits__c = 0;
                c.PY_Completed_Secondary_PM_Visits__c = c.CY_Completed_Secondary_PM_Visits__c;
                c.CY_Completed_Secondary_PM_Visits__c = 0;
                c.CY_Completed_Module_Wash_Visits_Not_Bill__c =0;
                c.CY_Completed_Landscaping_Visits_Not_Bi__c =0;
                // Update the Contract Records
                update c;
                system.debug('Contract is updated.');
            }
            
        } catch(Exception e) {
            System.debug('Error occured during execution.'+e);
        }
    }
    global void finish(Database.BatchableContext BC) 
    {
        // execute any post-processing operations
    }
}