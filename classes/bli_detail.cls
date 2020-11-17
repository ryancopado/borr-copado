public class bli_detail {
    
    private String lockStyle = '';
    private String unlockStyle = '';
    
    private Budget_Line_Item__c[] bli = [select Id, Name, Actual_Budget__c, Cost_Code_Name__c,  
                                            Category_Code__c, Sales_Budget__c, PM_Initial_Projection__c, Sales_PM_Budget_Disceprancy__c, 
                                            Total_PO__c, Pending_PO_Total__c, Active_Budget__c, Cost_Remaining__c, PM_Active_Discrepancy__c, 
                                            Notes__c, (select Name, Id, PO_Status__c, Product__c, Part_Number__c, Vendor_Account__c, Total_Cost__c, 
                                            Status__c, RecordTypeId, Purchase_Order__c from ConReq__r),(select Name, Code__c, Vendor_Account__c, 
                                            Approved_Amount__c, Expense_Header__c, Id from Expense_Line_Items__r) from Budget_Line_Item__c 
                                            where Budget__c = :ApexPages.currentPage().getParameters().get('id')];              
    public Budget_Line_Item__c[] getBli(){
        return bli;
    }
    private Budget__c budget;
    public void setBudget() {
        budget = [select Id, Name, OwnerId, PO_Total__c, Total_Cost_Remaining__c, Actual_Budget__c, Margin_Sales__c, Active_Actual_Variance__c, Margin_Actual__c, Margin_PM__c, Margin_Active__c, Project__c, Total_Contract_Value__c, PM_Lock__c, Sales_Budget__c, PM_Initial_Projection__c, Total_Sales_PM_Discrepancy__c, Total_PM_Active_Discrepancy__c, Active_Budget__c, Pending_PO_Total__c, Approved_PO_Total__c from Budget__c where Id =:ApexPages.currentPage().getParameters().get('id')];
        if (budget.PM_Lock__c == true){
                    lockStyle = 'display:none';
            } else {
                    unlockStyle = 'display:none';
            }
    }
    public Budget__c getBudget(){
            return budget;
    }
    public String getLock(){
            return lockStyle;
    }
    public String getUnlock(){
            return unlockStyle;
    }
    public PageReference PMsave() {
        update bli;
        setBudget();
        return null;
    }
    public PageReference SaveAndLock() {
        update bli;
        
        budget.PM_Lock__c = true;
        update budget;
        
        PageReference budgetPage = new PageReference('/apex/budget?id=' + budget.Id);
        budgetPage.setRedirect(true);

        return budgetPage; 
    }
    public PageReference Cancel() {
        
        PageReference budgetPage = new PageReference('/' + budget.Id);
        budgetPage.setRedirect(true);

        return budgetPage; 
    }

    public static testmethod void budgetTest() {
                       
        //Set Page Parameters 
        
        
       // Budget__c bud = [select Id from Budget__c where Project__c != null and PM_Lock__c = false LIMIT 1];
       // Budget__c bud2 = [select Id from Budget__c where Project__c != null and PM_Lock__c = true LIMIT 1];
        
        
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert acc;
       SFDC_Project__c p = ProjectTestOld.setupTestProj();
       Contract con = new Contract(AccountId = acc.Id); insert con; 
        SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;
        
        Budget__c bud = new Budget__c(Project__c = p.Id,PM_Lock__c = false);  insert bud ; 
        Budget_Line_Item__c bli1 = new Budget_Line_Item__c(Budget__c = bud .Id, Pending_PO_Total__c = 0.0); insert bli1;
            
        Budget__c bud2 = new Budget__c(Project__c = p.Id,PM_Lock__c = true );  insert bud2 ; 
        Budget_Line_Item__c bli2 = new Budget_Line_Item__c(Budget__c = bud2 .Id, Pending_PO_Total__c = 0.0); insert bli2;
        
        
        Test.startTest();
        
        PageReference pageRef = Page.budget;
        Test.setCurrentPage(pageRef);
        
        bli_detail controller = new bli_detail();
        ApexPages.currentPage().getParameters().put('id', bud.Id);
        
          controller.getBli();
          controller.getBudget(); 
          controller.getLock();
          controller.getUnlock(); 
          PageReference result2 = controller.PMsave();
          PageReference result = controller.SaveAndLock();
          PageReference result3 = controller.Cancel();                
        
        
        PageReference pageRef2 = Page.budget;
        Test.setCurrentPage(pageRef2);
        
        bli_detail controller2 = new bli_detail();
        ApexPages.currentPage().getParameters().put('id', bud2.Id);
        
          controller2.getBli();
          controller2.setBudget();
          controller2.getBudget(); 
          controller2.getLock();
          controller2.getUnlock();           
        
        Test.stopTest();
    }    
}