public class AccountPayableTriggerHandler {
  public static void validateApprovalReason(list<AcctSeed__Account_Payable__c> AccountPayablelist,Map<Id,AcctSeed__Account_Payable__c> oldMap){
      Map<Id, AcctSeed__Account_Payable__c> CommentStatements  = new Map<Id, AcctSeed__Account_Payable__c>{};
      for(AcctSeed__Account_Payable__c Acctseed:AccountPayablelist){
         /* Get the old object record, and check if the approval status  field has been updated to rejected. 
          If so, put it in a map so we only have to use 1 SOQL query to do all checks.*/
          AcctSeed__Account_Payable__c oldinv=oldMap.get(Acctseed.id);            
            
          if(oldInv.AcctSeed__Status__c != 'Rejected' && Acctseed.AcctSeed__Status__c == 'Rejected' ) 
            {
             CommentStatements.put(Acctseed.id,Acctseed) ;
               //Put the id  AcctSeed__Account_Payable__c in map                  
            }
       }
      if(!CommentStatements.isEmpty()){            
         // Get the most recent approval process instance for the object.
         // If there are some approvals to be reviewed for approval, then
         // get the most recent process instance for each object
       list<id> processInstanceIdsList = new list<id>(); 
       for(AcctSeed__Account_Payable__c pros:[SELECT (SELECT id FROM ProcessInstances ORDER BY CreatedDate DESC LIMIT 1) 
                                                      	FROM AcctSeed__Account_Payable__c 
                                                       	WHERE id IN:CommentStatements.keySet()])
             {
                 processInstanceIdsList.add(pros.ProcessInstances[0].id);                    
             }
        // Now that we have the most recent process instances, we can check
        // the most recent process steps for comments.  
        for(ProcessInstance pi:[SELECT TargetObjectId,(SELECT id,StepStatus, Comments FROM Steps ORDER BY CreatedDate DESC LIMIT 1)
                                             FROM ProcessInstance WHERE id IN:processInstanceIdsList ORDER BY CreatedDate DESC])
            //for loop on the ProcessInstance and for loop variable is pi
          {
            if(pi.steps.size()<1 || (pi.Steps[0].comments==null || pi.Steps[0].comments.trim().length()==0)) {
            CommentStatements.get(pi.TargetObjectId).addError('Operation Cancelled: Please provide a reason in Comments Box!');
            }
          }
       }
   }
}