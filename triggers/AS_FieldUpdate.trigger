trigger AS_FieldUpdate on AcctSeed__Project__c (before update) {
/* Commented out entire trigger 1/8/2017  
   if(approveELI.IsRecursiveUpdate==null) approveELI.IsRecursiveUpdate=false;
    
    if(approveELI.IsRecursiveUpdate==false){
                
            List<AcctSeed__Project__c> handoff = new List<AcctSeed__Project__c>();
            List<AcctSeed__Project__c> completed = new List<AcctSeed__Project__c>();
            List<AcctSeed__Project__c> rebate = new List<AcctSeed__Project__c>();
            List<AcctSeed__Project__c> rebateStatus = new List<AcctSeed__Project__c>();
            List<AcctSeed__Project__c> interconnection = new List<AcctSeed__Project__c>();
            Map<Id, AcctSeed__Project__c> projsWithNewOwner = new Map<Id, AcctSeed__Project__c>();
*/            
      /* CN: not-mapped on ASProject   
                        Map<Id, Decimal> MapOfTimeEntrySummaryFields = new Map<Id, Decimal>();
                        Map<Id, Decimal> MapOfExpenseSummaryFields = new Map<Id, Decimal>();
                        
                        For(Sobject Result:[Select ASProject__c,sum( Total_Cost_Internal_Calc__c)  Result 
                                                From Time_Entry__c 
                                                Where ASProject__c in :Trigger.New
                                                Group by ASProject__c])
                                MapOfTimeEntrySummaryFields.Put((ID)Result.Get('Project__C'),(Decimal)Result.Get('Result'));
                                
                        For(Sobject Result:[Select ASProject__c,sum( Expenditure_Amount__c)  Result 
                                                From ELI__c where Chargeback__c=false 
                                                and ASProject__c in :Trigger.New
                                                Group by ASProject__c])
                                MapOfExpenseSummaryFields.Put((ID)Result.Get('Project__C'),(Decimal)Result.Get('Result'));


                       For(AcctSeed__Project__c Project:Trigger.new){
                        
                            //Project.Total_Hourly_Cost_to_Borrego__c=0; // CN: not-mapped on ASProject
                            //Project.Expenses__c=0; // CN: not-mapped on ASProject
                            
                            Decimal ResultForTimeEntry=MapOfTimeEntrySummaryFields.Get(Project.ID);
                            Decimal ResultForExpense=MapOfExpenseSummaryFields.Get(Project.ID);
                            
                            If(ResultForTimeEntry!=null)
                                Project.Total_Hourly_Cost_to_Borrego__c=ResultForTimeEntry;
                                
                            If(ResultForExpense!=null)
                                Project.Expenses__c=ResultForExpense;
                        
                       } 
*/          
            
/* Commented out entire trigger 1/8/2017                              
            for (Integer i = 0; i <Trigger.new.size(); i++) {
                if(Trigger.new[i].Overall_Project_Status__c == 'Design' && Trigger.old[i].Overall_Project_Status__c != 'Design'){
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
*/ 
}