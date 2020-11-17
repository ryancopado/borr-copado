trigger trgOnExpenseToUpdateProjectSummaryField on ELI__c (after delete, after insert, after update) {

	List<ID> ListOfProjectIds=new List<ID>();
        
        If(Trigger.IsUpdate || Trigger.IsInsert)
	        For(ELI__c ExpenseEntry: Trigger.New)	        
	            ListOfProjectIDS.ADD(ExpenseEntry.Project__c);
	        
	        
        If(Trigger.IsDelete)
	        For(ELI__c ExpenseEntry: Trigger.Old)	        
	            ListOfProjectIDS.ADD(ExpenseEntry.Project__c);	        
	
	List<SFDC_Project__c>   ListOfProjects=new List<SFDC_Project__c>();
	   
	ListOfProjects=[Select ID,Total_Hourly_Cost_to_Borrego__c,Expenses__c 
						FROM SFDC_Project__c 
						WHERE ID IN :ListOfProjectIDS];
	
	
	
    Map<Id, Decimal> MapOfExpenseSummaryFields = new Map<Id, Decimal>();
    
     
    For(Sobject Result:[Select Project__c,sum( Expenditure_Amount__c)  Result 
                            From ELI__c 
                            Where Chargeback__c=false and Project__c in :ListOfProjectIDS
                            Group by Project__c])
            MapOfExpenseSummaryFields.Put((ID)Result.Get('Project__C'),(Decimal)Result.Get('Result'));
     
   For(SFDC_Project__c Project:ListOfProjects){
    
        Decimal ResultForExpense=MapOfExpenseSummaryFields.Get(Project.ID);
            
        If(ResultForExpense!=null)
            Project.Expenses__c=ResultForExpense;
    
   } 
   approveELI.IsRecursiveUpdate=True;
   Update ListOfProjects;
   approveELI.IsRecursiveUpdate=false;

}