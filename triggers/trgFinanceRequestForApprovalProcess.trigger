trigger trgFinanceRequestForApprovalProcess on Finance_Request__c (before Update) {

     if (Trigger.New.size()==1){
       
        
        if (Trigger.New[0].IsSubmittedForApproval__c==true){
           
 
               
           Trigger.New[0].IsSubmittedForApproval__c=false;
           //Insert  CloneFinanceRequest;
           
           List<Finance_Request__c> ListOfFinanceRequest = [Select ID,Status__c 
                                                                   FROM Finance_Request__c 
                                                                   WHERE Opportunity__c=:Trigger.New[0].Opportunity__c
                                                                   AND ID != :Trigger.New[0].ID
                                                                   And Status__c='Approved'];
                                                                   
          FOR(Finance_Request__c FinanceReq:ListOfFinanceRequest){
          
              FinanceReq.Status__c='Previously Approved';
          
          }
          
          if(ListOfFinanceRequest !=null && ListOfFinanceRequest.size()>0)
              Update ListOfFinanceRequest;

        }       
      }  

}