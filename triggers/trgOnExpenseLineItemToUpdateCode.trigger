trigger trgOnExpenseLineItemToUpdateCode on ELI__c (Before Insert, Before Update) {

   /* Map<Id,SFDC_Project__c> MapOfProjects;
    
    List<Id> ListOfProjectIds=new List<ID>();
    
    for(ELI__c ExpenseLineItem: Trigger.New){
    
        ListOfProjectIds.Add(ExpenseLineItem.Project__c);
            
    }
    
    MapOfProjects=new Map<Id,SFDC_Project__c>([Select id,Branch__C from SFDC_Project__c where id in : ListOfProjectIds]);
*/

/*AND(  NOT(ISNULL(Budget_Line_Item__r.Cost_Code__c)),  
Budget_Line_Item__r.Cost_Code__r.Name  != Cost_Code__r.Name  , 
$RecordType.Name =='Project Expense', PV_Direct__c ==false)*/


    RecordType RecordType=[Select id from RecordType where name='Project Expense'];

    List<id> ListOfBudgetLineItemIds=new List<id>();
    
    

    for(ELI__c ExpenseLineItem: Trigger.New){
    
        ListOfBudgetLineItemIds.Add(ExpenseLineItem.Budget_Line_Item__c);
    
        String Code='01-';
    
        /*SFDC_Project__c Project=MapOfProjects.Get(ExpenseLineItem.Project__C);
        
        If (Project!=null){
        
            If(Project.Branch__C.ToLowerCase()=='san diego')
                Code +='001';
            Else if (Project.Branch__C.ToLowerCase()=='berkeley')
                Code +='002';            
            Else if (Project.Branch__C.ToLowerCase()=='boston')
                Code +='005';            
            Else if (Project.Branch__C.ToLowerCase()=='mid atlantic')
                Code +='008';      
    
            Code+='-';
         }*/
            If(ExpenseLineItem.Branch__C!=null){
                If(ExpenseLineItem.Branch__C.ToLowerCase()=='san diego')
                    Code +='001';
                Else if (ExpenseLineItem.Branch__C.ToLowerCase()=='berkeley')
                    Code +='002';            
                Else if (ExpenseLineItem.Branch__C.ToLowerCase()=='boston')
                    Code +='005';            
                Else if (ExpenseLineItem.Branch__C.ToLowerCase()=='mid atlantic')
                    Code +='008';   
                Else if (ExpenseLineItem.Branch__C.ToLowerCase()=='corporate')
                    Code +='998'; 
                Else if (ExpenseLineItem.Branch__C.ToLowerCase()=='puerto rico')
                    Code +='909';       
              }
              
            Code+='-';

        If (ExpenseLineItem.Expenditure_Type__c!=null && ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='office supplies') 
              Code +='6';
        Else If (ExpenseLineItem.Expenditure_Type__c!=null && ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='dues') 
              Code +='6';              
        Else If (ExpenseLineItem.Expenditure_Type__c!=null && ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='proposal costs') 
              Code +='5';              
        Else
            If (ExpenseLineItem.Department__c!=null){
                
                If(ExpenseLineItem.Department__c.ToLowerCase()=='sales')
                    Code +='5';
                Else if (ExpenseLineItem.Department__c.ToLowerCase()=='indirect construction')
                    Code +='4';            
                Else if (ExpenseLineItem.Department__c.ToLowerCase()=='corporate')
                    Code +='6';                         
                
            }   
        
        If (ExpenseLineItem.Expenditure_Type__c!=null){
            
             If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='office supplies')
                Code +='270';
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='dues')
                Code +='920';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='training and education')
                Code +='181';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='proposal costs')
                Code +='750';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='vehicle expense')
                Code +='420';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='mileage')
                Code +='420';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='moving and relocation expenses')
                Code +='186';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='other employee benefits')
                Code +='190';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='company wide meetings')
                Code +='480';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='branch meeting expenses')
                Code +='490';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='employee meals & entertainment')
                Code +='461';            
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='customer meals & entertainment')
                Code +='470'; 
             Else If(ExpenseLineItem.Expenditure_Type__c.ToLowerCase()=='airfare/travel')
                Code +='460'; 
                                                   
          
        }                      
        
        ExpenseLineItem.Code__c=Code;
            
    }


    Map<id,Budget_Line_Item__c> MapOfBudgetLineitems=new Map<id,Budget_Line_Item__c>
                    ([Select id,Cost_Code__c,Expense_Total__c,Budget__c from Budget_Line_Item__c where id in :ListOfBudgetLineItemIds]);
    
    Map<id,id> MapOfBudgetIds=new Map<id,id>();
    
    for( Budget_Line_Item__c BLI: MapOfBudgetLineitems.Values()){
    
        MapOfBudgetIds.Put(BLI.ID,BLI.Budget__c );
    
    }
    
    Map<id,Map<string,string>> MapOfBudget=new Map<id,Map<string,string>>();
    For(Budget_Line_Item__c BLI: [Select id,Cost_Code__c,Expense_Total__c,Budget__c from Budget_Line_Item__c where Budget__c in :MapOfBudgetIds.values()]){
        
        Map<string,string> MapOfCostCode=new Map<string,string>();
        
        if(MapOfBudget.ContainsKey(BLI.Budget__c))        
            MapOfCostCode=MapOfBudget.get(BLI.Budget__c);
        else
            MapOfBudget.Put(BLI.Budget__c,MapOfCostCode);
        
         if(! MapOfCostCode.ContainsKey(BLI.Cost_Code__c))
            MapOfCostCode.Put(BLI.Cost_Code__c,BLI.Cost_Code__c);
            
            
        
    }
   
   
   
   List<id> ListOfProjectIds=new List<id>();
   
    
   for(ELI__c ExpenseLineItem: Trigger.New){
       ListOfProjectIds.Add(ExpenseLineItem.Project__c);
   }

   Map<id,Budget__c> MapOfProjectBudget=new Map<id,Budget__c>();
   For(Budget__c BDT:[Select id,Project__C from Budget__C where project__C in :ListOfProjectIds]){
       MapOfProjectBudget.Put(BDT.project__C,BDT);
   }
   
   
    Map<id,Map<string,Budget_Line_Item__c >> MapOfProject=new Map<id,Map<string,Budget_Line_Item__c >>();
    For(Budget_Line_Item__c BLI: [Select id,Cost_Code__c,Expense_Total__c,Budget__r.Project__c 
                            from Budget_Line_Item__c where Budget__r.Project__c in :ListOfProjectIds]){
        
        Map<string,Budget_Line_Item__c > MapOfCostCode=new Map<string,Budget_Line_Item__c >();
        
        if(MapOfProject.ContainsKey(BLI.Budget__r.Project__c ))        
            MapOfCostCode=MapOfProject.get(BLI.Budget__r.Project__c );
        else
            MapOfProject.Put(BLI.Budget__r.Project__c ,MapOfCostCode);
        
         if(! MapOfCostCode.ContainsKey(BLI.Cost_Code__c))
            MapOfCostCode.Put(BLI.Cost_Code__c,BLI); 
    }
    
    
    
   for(ELI__c ExpenseLineItem: Trigger.New){
    
        If(ExpenseLineItem.Cost_Code__c!=null && ExpenseLineItem.Project__c !=null){
        
           
            
            Map<string,Budget_Line_Item__c > MapOfCostCode=MapOfProject.get(ExpenseLineItem.Project__c);
             
                       
            if(( MapOfCostCode==null || (MapOfCostCode!=null && (!MapOfCostCode.ContainsKey(ExpenseLineItem.Cost_Code__c ) )))
                                            && ExpenseLineItem.PV_Direct__c ==false 
                                            && ExpenseLineItem.RecordTypeid ==RecordType.id){
            
                ExpenseLineItem.AddError('Cost Code is Not in Project Budget –please select another Cost Code');
            
            }
            else if(MapOfCostCode!=null && (MapOfCostCode.ContainsKey(ExpenseLineItem.Cost_Code__c ) )
                                            && ExpenseLineItem.PV_Direct__c ==false 
                                            && ExpenseLineItem.RecordTypeid ==RecordType.id){
                Budget_Line_Item__c BL=MapOfCostCode.GET(ExpenseLineItem.Cost_Code__c );
                ExpenseLineItem.Budget_Line_Item__c=BL.ID;
                
            }
        }
        
        if( ExpenseLineItem.Project__c ==null || (ExpenseLineItem.Project__c !=null && (!MapOfProjectBudget.containsKey(ExpenseLineItem.Project__c)))){
            If (ExpenseLineItem.RecordTypeID==RecordType.id && ExpenseLineItem.PV_Direct__c ==false )
                    ExpenseLineItem.AddError('A Project Budget is Required for Adding Expense and/or Budget Line Items');
        }
    
    } 
    
    Map<id,Decimal> MapForExpenseTotal=new Map<id,Decimal>();
    
    For(AggregateResult Result:[SELECT Budget_Line_Item__c , SUM(Expenditure_Amount__c) SUM
                                  FROM ELI__c 
                                  where Budget_Line_Item__c in :MapOfBudgetLineitems.KeySet()
                                  GROUP BY Budget_Line_Item__c ]){
      
          If(Result.Get('SUM')!=null)
              MapForExpenseTotal.Put((id)Result.Get('Budget_Line_Item__c'),(decimal)Result.Get('SUM'));
      
      }
      
    For(Budget_Line_Item__c  BudgetLineItem : MapOfBudgetLineitems.Values()){
        
        if (MapForExpenseTotal.ContainsKey(BudgetLineItem.id) && MapForExpenseTotal.Get(BudgetLineItem.id)!=null){
        
            BudgetLineItem.Expense_Total__c =MapForExpenseTotal.Get(BudgetLineItem.id);
        
        }
        
    }
    
    Update MapOfBudgetLineitems.Values();

}