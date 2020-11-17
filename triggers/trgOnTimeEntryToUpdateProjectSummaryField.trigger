trigger trgOnTimeEntryToUpdateProjectSummaryField on Time_Entry__c (after delete, after insert, after update) {

  	List<ID> ListOfProjectIds=new List<ID>();
        
        If(Trigger.IsUpdate || Trigger.IsInsert)
	        For(Time_Entry__C TimeEntry: Trigger.New)	        
	            ListOfProjectIDS.ADD(TimeEntry.Project__c);
	        
	        
        If(Trigger.IsDelete)
	        For(Time_Entry__C TimeEntry: Trigger.Old)	        
	            ListOfProjectIDS.ADD(TimeEntry.Project__c);	        
	
	List<SFDC_Project__c>   ListOfProjects=new List<SFDC_Project__c>();
	   
	ListOfProjects=[Select ID,Total_Hourly_Cost_to_Borrego__c,Expenses__c 
						FROM SFDC_Project__c 
						WHERE ID IN :ListOfProjectIDS];
	
	
	Map<Id, Decimal> MapOfTimeEntrySummaryFields = new Map<Id, Decimal>();
        
    For(Sobject Result:[Select Project__c,sum( Total_Cost_Internal_Calc__c)  Result 
                            From Time_Entry__c 
                            Where Project__c in :ListOfProjectIDS
                            Group by Project__c])
            MapOfTimeEntrySummaryFields.Put((ID)Result.Get('Project__C'),(Decimal)Result.Get('Result'));
            
    
     
   For(SFDC_Project__c Project:ListOfProjects){
    
        Decimal ResultForTimeEntry=MapOfTimeEntrySummaryFields.Get(Project.ID);
                
        If(ResultForTimeEntry!=null)
            Project.Total_Hourly_Cost_to_Borrego__c=ResultForTimeEntry;
          
   } 
   
   approveELI.IsRecursiveUpdate=True;
   Update ListOfProjects;
   approveELI.IsRecursiveUpdate=false;
	   
}