trigger FieldUpdate on SFDC_Project__c (before update) {
  
   if(approveELI.IsRecursiveUpdate==null) approveELI.IsRecursiveUpdate=false;
    
    if(approveELI.IsRecursiveUpdate==false){
                
            List<SFDC_Project__c> handoff = new List<SFDC_Project__c>();
            List<SFDC_Project__c> completed = new List<SFDC_Project__c>();
            List<SFDC_Project__c> rebate = new List<SFDC_Project__c>();
            List<SFDC_Project__c> rebateStatus = new List<SFDC_Project__c>();
            List<SFDC_Project__c> interconnection = new List<SFDC_Project__c>();
            Map<Id, SFDC_Project__c> projsWithNewOwner = new Map<Id, SFDC_Project__c>();
            
         
                        Map<Id, Decimal> MapOfTimeEntrySummaryFields = new Map<Id, Decimal>();
                        Map<Id, Decimal> MapOfExpenseSummaryFields = new Map<Id, Decimal>();
                        
                        For(Sobject Result:[Select Project__c,sum( Total_Cost_Internal_Calc__c)  Result 
                                                From Time_Entry__c 
                                                Where Project__c in :Trigger.New
                                                Group by Project__c])
                                MapOfTimeEntrySummaryFields.Put((ID)Result.Get('Project__C'),(Decimal)Result.Get('Result'));
                                
                        For(Sobject Result:[Select Project__c,sum( Expenditure_Amount__c)  Result 
                                                From ELI__c where Chargeback__c=false
                                                and Project__c in :Trigger.New
                                                Group by Project__c])
                                MapOfExpenseSummaryFields.Put((ID)Result.Get('Project__C'),(Decimal)Result.Get('Result'));
                         
                       For(SFDC_Project__c Project:Trigger.new){
                        
                            Project.Total_Hourly_Cost_to_Borrego__c=0;
                            Project.Expenses__c=0;
                            
                            Decimal ResultForTimeEntry=MapOfTimeEntrySummaryFields.Get(Project.ID);
                            Decimal ResultForExpense=MapOfExpenseSummaryFields.Get(Project.ID);
                            
                            If(ResultForTimeEntry!=null)
                                Project.Total_Hourly_Cost_to_Borrego__c=ResultForTimeEntry;
                                
                            If(ResultForExpense!=null)
                                Project.Expenses__c=ResultForExpense;
                        
                       } 
            
            
                            
            for (Integer i = 0; i <Trigger.new.size(); i++) {
                if(Trigger.new[i].SFDC_Project_Status__c == 'Design' && Trigger.old[i].SFDC_Project_Status__c != 'Design'){
                    handoff.add(Trigger.new[i]);
                }
                if(Trigger.new[i].SFDC_Project_Stage__c == 'Inspections Complete' && Trigger.old[i].SFDC_Project_Stage__c != 'Inspections Complete') {
                    completed.add(Trigger.new[i]);
                }   
                if(Trigger.new[i].Rebate_Status__c == 'Rebate Received' && Trigger.old[i].Rebate_Status__c != 'Rebate Received'){
                    rebate.add(Trigger.new[i]);
                }
                if(Trigger.new[i].Rebate_Status__c != Trigger.old[i].Rebate_Status__c){
                    rebateStatus.add(Trigger.new[i]);
                } 
                if(Trigger.new[i].Interconnection_Status__c != Trigger.old[i].Interconnection_Status__c){
                    interconnection.add(Trigger.new[i]);
                }
                if (Trigger.old[i].OwnerId != Trigger.new[i].OwnerId) {
                    projsWithNewOwner.put(Trigger.old[i].Id, Trigger.new[i]);
                }        
            }
            if(handoff.size() > 0) {
                FieldUpdate.addHandoffDate(handoff);
            }
            if(completed.size() > 0) {
                FieldUpdate.addEndDate(completed);
            }
            if(rebate.size() > 0) {
                FieldUpdate.addCompleteStatus(rebate); 
            }
            if(rebateStatus.size() > 0) {
                FieldUpdate.addRebateDate(rebateStatus);
            }
            if(interconnection.size() > 0) {
                FieldUpdate.addInterconnectionDate(interconnection);
            }
            if(projsWithNewOwner.size() > 0){
                FieldUpdate.ownerUpdate(projsWithNewOwner);
            } 
     } 
}