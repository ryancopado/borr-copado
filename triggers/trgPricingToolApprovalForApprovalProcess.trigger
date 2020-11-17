trigger trgPricingToolApprovalForApprovalProcess on Pricing_Tool_Approval__c (before Update) {

     if (Trigger.New.size()==1){
       
        
        if (Trigger.New[0].IsSubmittedForApproval__c==true){
           
 
               
           Trigger.New[0].IsSubmittedForApproval__c=false;
           //Insert  ClonePricingToolApproval;
           
           List<Pricing_Tool_Approval__c> ListOfPricingToolApproval = [Select ID,Status__c 
                                                                   FROM Pricing_Tool_Approval__c
                                                                   WHERE Opportunity__c=:Trigger.New[0].Opportunity__c
                                                                   AND ID != :Trigger.New[0].ID
                                                                   And Status__c='Approved'];
                                                                   
          FOR(Pricing_Tool_Approval__c PricingTool:ListOfPricingToolApproval){
          
              PricingTool.Status__c='Previously Approved';
          
          }
          
          if(ListOfPricingToolApproval !=null && ListOfPricingToolApproval.size()>0)
              Update ListOfPricingToolApproval;

        }       
      }  

}