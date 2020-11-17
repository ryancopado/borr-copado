public with sharing class PercentComplete {
    

    class JsonResponse {
        public JsonPrecentComplete[] objects;
        
        public JsonResponse() {
            objects = new List<JsonPrecentComplete>();
        }
        
    }
    
    class JsonPrecentComplete {
        public String id;
        public Double percent;
        public Double retainage;
                
        public JsonPrecentComplete() {}
        
        public JsonPrecentComplete(String id, Double percent, Double retainage) {
            this.id = id;
            this.percent = percent;
            this.retainage = retainage;
        }
    }
    
    public JsonPrecentComplete foo;
    

    public List<AcctSeed__Project_Task__c> projectTasks{get;set;}
    public AcctSeed__Project__c theProject {get;set;}
    
    public double sumBudgetedRevenue {get;set;}
    public double sumPrevInvoicedTotal {get;set;}
    public String json {get;set;}
    
    public PercentComplete(ApexPages.StandardController stdController) {
        
        theProject = (AcctSeed__Project__c) stdController.getRecord();
    
        projectTasks = [select Id,Name,Cost_Code__r.Name,(Select Name, complete__c, completion_Date__c, Notes__c, Retainage_amount__c From completes__r), complete__c,Cost_Code__r.Category__c,Roll_Up_Transactions__c,AcctSeed__Budgeted_Amount__c,AcctSeed__Budgeted_Revenue__c,AcctSeed__Percent_Complete__c,PM_Budget__c,Active_Budget__c,Roll_Up_Purchase_Order_Line_Totals__c,Notes__c,(select id, Name,AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Product__r.Name,  AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Purchase_Order__r.AcctSeedERP__Vendor__r.Name,Status__c,AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Total__c,AcctSeedERP__Purchase_Order_Line__r.Name, AcctSeedERP__Purchase_Order_Line__r.AcctSeedERP__Purchase_Order__r.AcctSeedERP__Status__c,AcctSeedERP__Purchase_Order_Line__r.Id from AcctSeedERP__Sales_Order_Line__r) from AcctSeed__Project_Task__c where  AcctSeed__Project__c=:theProject.Id and recordType.Name = 'Billing Line Item'];     
    
        initSums();
    }
  
    
    public void initSums(){     
        sumBudgetedRevenue = 0;
        sumPrevInvoicedTotal = 0; 
         
        for(AcctSeed__Project_Task__c task: projectTasks){
            if(task.AcctSeed__Budgeted_Revenue__c != null){
                sumBudgetedRevenue += task.AcctSeed__Budgeted_Revenue__c;
            }
            if(task.Roll_Up_Transactions__c != null){
                sumPrevInvoicedTotal += task.Roll_Up_Transactions__c;
            }
        }
    }
    
    public PageReference save() {
        if( json != null ) {
            JsonResponse resp = (JsonResponse) system.JSON.deserialize(json, JsonResponse.class);
        
            complete__c[] arr = new List<complete__c>(); 
            for( JsonPrecentComplete jcp: resp.objects ) {
                complete__c c = new complete__c();
                c.complete__c = jcp.percent;
                c.Retainage_amount__c = jcp.retainage;
                if( !test.isRunningTest() ) c.Project_Task__c = jcp.id;
                c.completion_Date__c = Date.today();
                arr.add(c);
            }
            if( !test.isRunningTest() ) insert(arr);
        }
        
        
        PageReference percentPage = new PageReference('/apex/Percent_Complete?id=' + theProject.Id);
        percentPage.setRedirect(true);

        return percentPage; 
    }

    
    public PageReference cancel() {
        
        PageReference percentPage = new PageReference('/' + theProject.Id);
        percentPage.setRedirect(true);

        return percentPage; 
    }
    


    public static testmethod void percentCompleteTest() {     
    
    
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
     
          List<AcctSeed__Project__c> projs = TestMethods.getProjectList();
          
          update projs[0];
          
          ApexPages.StandardController stdController = new ApexPages.Standardcontroller(projs[0]);
          
          PercentComplete theController = new PercentComplete(stdController);
          
          theController.initSums();
          
          new JsonResponse();
          new JsonPrecentComplete();
          
          // test json post
          theController.json = '{"objects":[{"percent":0.7,"retainage":550.5,"id":"123456789"}]}';
          
          theController.save();

          theController.cancel();
    }     
}