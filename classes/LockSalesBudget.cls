/* Auther: Madan (Forcebrain Developer)
   Date: Jan 18, 2017
   Description: Lock Sales Budget button functionality
   */
public with sharing class LockSalesBudget {
    private AcctSeed__Project__c projectObj {get;set;}
    private List<AcctSeed__Project_Task__c> projectTasks {get;set;}
    public string prjectName {get;set;}
    public LockSalesBudget() {
        String strProjectId;
        if(ApexPages.currentPage().getParameters().containsKey('id')) {
            strProjectId = ApexPages.currentPage().getParameters().get('id');
        }
        
        projectObj = new AcctSeed__Project__c();
        
        if(strProjectId != null) {
            for(AcctSeed__Project__c prj:[select Id, Name, Sales_Budget_Locked__c, Date_Sales_Budget_Locked__c 
                                            FROM AcctSeed__Project__c where Id=:strProjectId]) {
                projectObj = prj;
                prjectName = prj.Name;
            }
            
            projectTasks = [select PM_Budget__c, Sales_Budget__c
                                from AcctSeed__Project_Task__c 
                                where AcctSeed__Project__c=:projectObj.Id and recordType.Name = 'Budget Line Item' and (not Name like '%Retainage%')];
        }
    }
    
    public PageReference doInit() {
        PageReference pr;
        try {
            doProcess();
            return goBack();
        } catch(Exception ex) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, ex.getMessage()));
            System.debug('EXCEPTION: ' + ex.getMessage() + '==' + ex.getStackTraceString());
        }
        
        return pr;
    }
    
    public PageReference goBack() {
        PageReference pr;
        if(projectObj != null && projectObj.Id != null) {
             pr = new PageReference('/' + projectObj.Id);
             pr.setRedirect(true);
        }
        
        return pr;
    }
    
    private void doProcess() {
        projectObj.Sales_Budget_Locked__c = true;
        projectObj.Date_Sales_Budget_Locked__c = system.today();
        update projectObj;
        
        for (AcctSeed__Project_Task__c task :projectTasks) {
            task.PM_Budget__c = task.Sales_Budget__c;
        } 
        
        if(projectTasks.size() > 0) {
            update projectTasks;
        }
    }
}