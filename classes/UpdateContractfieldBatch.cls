global class UpdateContractfieldBatch implements Database.Batchable<sObject>
{

    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        
       
        
        String query = 'SELECT Id,  EndDate,Year_of_Contract__c FROM Contract WHERE Contract_Status__c= \'ACTIVE\' AND RecordType.Name=\'Paid\'';
         system.debug('Query Size' +query);         
        return Database.getQueryLocator(query);
              
    } 
    global void execute(Database.BatchableContext BC, List<Contract> Contracts)
    {
        system.debug('No of contracts fetched for renewal = '+Contracts.size());
        try 
        {
            for(Contract c :Contracts)
            {
           List< Service_Contract_Escalator__c> currentyear= new  List<Service_Contract_Escalator__c>();
           
             Service_Contract_Escalator__c currentyear1=new Service_Contract_Escalator__c ();
             currentyear=[select CurrentYearContractValue__c,Current_Year_Solar_Electrician_1_Rate__c,Current_Year_Solar_Electrician_1_OT_Ra__c	,Current_Year__c,Current_Year_Solar_Electrician_2_OT_Ra__c,Current_Year12__c,Current_Year_Solar_Engineer_OT_Rate__c,Current_Year1__c from Service_Contract_Escalator__c where Year__c=:c.Year_of_Contract__c and Service_Contract__c=:c.id];
          system.debug('this is 2nd year--->' +currentyear.size());
             if(currentyear.size()>0)
             { 
             currentyear1=currentyear.get(0);
                 
             
             c.Current_Year_Contract_Value__c=currentyear1.CurrentYearContractValue__c;    // ;//updatedcurrentyear;
             
             c.Current_Solar_Electrician_1_Rate__c = currentyear1.Current_Year_Solar_Electrician_1_Rate__c;
             c.Current_Solar_Electrician_1_Rate_OT__c = currentyear1.Current_Year_Solar_Electrician_1_OT_Ra__c;
             c.Current_Solar_Electrician_2_Rate__c = currentyear1.Current_Year__c;
             c.Current_Solar_Electrician_2_Rate_OT__c = currentyear1.Current_Year_Solar_Electrician_2_OT_Ra__c;
             c.Current_Engineer_Rate__c = currentyear1.Current_Year12__c;
             c.Current_Engineer_Rate_OT__c = currentyear1.Current_Year_Solar_Engineer_OT_Rate__c	 ;     
             c.Current_Regional_Manager_Rate__c = currentyear1.Current_Year1__c ;
                     
             Update c; 
              }
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