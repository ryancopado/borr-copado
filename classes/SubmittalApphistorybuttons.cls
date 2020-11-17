public class SubmittalApphistorybuttons {

    @AuraEnabled
    public static  string Apphistoryid(Id AppId) //this method is for submittal revise and submit button.
    {
       string result  ;
        String instance;
          
			   list<ProcessInstanceWorkitem> PIWIlist = new list<ProcessInstanceWorkitem>(); 
        list<ProcessInstanceWorkitem>deletePIWI=new list<ProcessInstanceWorkitem>();
        
  			PIWIlist= [Select ProcessInstance.TargetObjectId,ProcessInstanceId,OriginalActorId,Id,ActorId
                                                       From ProcessInstanceWorkitem where Id=:AppId];
        ProcessInstanceWorkitem piwirec = new ProcessInstanceWorkitem();
        piwirec = PIWIlist.get(0);
        
        Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
            objReq.setAction('Approve');
            //objReq.setComments(Comment);
            objReq.setWorkitemId(AppId);
            objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            Approval.ProcessResult result2 =  Approval.process(objReq); 
        if(!test.isRunningTest()){
            Approval.unlockResult unlockedRersult =Approval.unlock(piwirec.ProcessInstance.TargetObjectId);
        }
         
        Submittal_1__c updatesubrec = new Submittal_1__c();
        system.debug('this is targetid-->' +piwirec.ProcessInstance.TargetObjectId);
        try{
            
            updatesubrec.id = piwirec.ProcessInstance.TargetObjectId;
           updatesubrec.Status__c  = 'Revise and Resubmit';
          update  updatesubrec;
         system.debug('final update--> ' +updatesubrec);
        instance = URL.getSalesforceBaseUrl().getHost();//.substringBefore('.')
        result='https://' + instance +'/lightning/r/Submittal_1__c/' +piwirec.ProcessInstance.TargetObjectId+'/view' ;
        }
        catch(Exception e) {
                          result=  e.getMessage();
                      }
        
        
         if(!test.isRunningTest()){
             Approval.lockResult lockedRersult = Approval.lock(piwirec.ProcessInstance.TargetObjectId);
         }
       
     
     //   system.debug('The URL instance' +instance );
       system.debug('Result--> ' +result);
			return  result;  
    }
    
    @AuraEnabled
    public static  string Apphistoryrecallid(Id recallId) //this method is for submittal aprroved as corrected button.
    {
       string result  ;
         String instance;
			   list<ProcessInstanceWorkitem> PIWIlist = new list<ProcessInstanceWorkitem>(); 
        list<ProcessInstanceWorkitem>deletePIWI=new list<ProcessInstanceWorkitem>();
        
  			PIWIlist= [Select ProcessInstance.TargetObjectId,ProcessInstanceId,OriginalActorId,Id,ActorId
                                                       From ProcessInstanceWorkitem where Id=:recallId];
        ProcessInstanceWorkitem piwirec = new ProcessInstanceWorkitem();
        piwirec = PIWIlist.get(0);
         Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
            objReq.setAction('Approve');
            //objReq.setComments(Comment);
            objReq.setWorkitemId(recallId);
            objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            Approval.ProcessResult result2 =  Approval.process(objReq); 
         if(!test.isRunningTest()){
         Approval.unlockResult unlockedRersult =Approval.unlock(piwirec.ProcessInstance.TargetObjectId);
         }
        Submittal_1__c updatesubrec = new Submittal_1__c();
        system.debug('this is targetid-->' +piwirec.ProcessInstance.TargetObjectId);
        
        try{
            updatesubrec.id = piwirec.ProcessInstance.TargetObjectId;
            updatesubrec.Status__c  = 'Approved as Corrected';
            update  updatesubrec;
            instance = URL.getSalesforceBaseUrl().getHost();//.substringBefore('.')
            result='https://' + instance +'/lightning/r/Submittal_1__c/' +piwirec.ProcessInstance.TargetObjectId+'/view' ;
        }
        catch(Exception e) {
                          result=  e.getMessage();
                      }
         if(!test.isRunningTest()){
        Approval.lockResult lockedRersult = Approval.lock(piwirec.ProcessInstance.TargetObjectId); 
         }
      //  system.debug('final update--> ' +updatesubrec);
       system.debug('Result--> ' +result);

        
        
        
			return  result;  
    }
     @AuraEnabled
    public static  string Issueresolved(Id IssueId) //this method is for Issue Tracker Resolved button.
    {
        
         string result  ;
         String instance;
        //String Errormsg;
			   list<ProcessInstanceWorkitem> PIWIlist = new list<ProcessInstanceWorkitem>(); 
        list<ProcessInstanceWorkitem>deletePIWI=new list<ProcessInstanceWorkitem>();
    //    List<Request_for_Information_RFI__c>Issuerecords=New List<Request_for_Information_RFI__c>();
                
  			PIWIlist= [Select ProcessInstance.TargetObjectId,ProcessInstanceId,OriginalActorId,Id,ActorId
                                                       From ProcessInstanceWorkitem where Id=:IssueId];
        ProcessInstanceWorkitem piwirec = new ProcessInstanceWorkitem();
        piwirec = PIWIlist.get(0);
        system.debug('this is resolved-->');
     Request_for_Information_RFI__c  Issuerecords= new Request_for_Information_RFI__c();
       Issuerecords = [select Response__c from Request_for_Information_RFI__c where id=:piwirec.ProcessInstance.TargetObjectId];
      system.debug('this is the record size-->' +Issuerecords.Response__c);
        if(Issuerecords.Response__c != null)
        {
            system.debug('Entering Here');

         Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
            objReq.setAction('Approve');
           // objReq.setComments(Comment);
            objReq.setWorkitemId(IssueId);
            objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
   
            Approval.ProcessResult result2 =  Approval.process(objReq); 
        system.debug('this is process result-->' +result2);
        system.debug('this is id' +piwirec.ProcessInstance.TargetObjectId);
        
         if(!test.isRunningTest()){
        Approval.unlockResult unlockedRersult =Approval.unlock(piwirec.ProcessInstance.TargetObjectId);
         }
      //  system.debug('this is the lock status' +unlockedRersult);
            
      
         Request_for_Information_RFI__c updateIssue = new Request_for_Information_RFI__c();
          system.debug('this is targetid-->' +piwirec.ProcessInstance.TargetObjectId);
        try{
             updateIssue.id = piwirec.ProcessInstance.TargetObjectId;
           updateIssue.Status__c  = 'Resolved';
           update  updateIssue;
             instance = URL.getSalesforceBaseUrl().getHost();//.substringBefore('.')
            system.debug('Instance'  +instance);
        result='https://' + instance +'/lightning/r/Request_for_Information_RFI__c/' +piwirec.ProcessInstance.TargetObjectId+'/view' ;
            
        }
          
        catch(Exception e) {
                          result=  e.getMessage();
                      }
         if(!test.isRunningTest()){
       Approval.lockResult lockedRersult = Approval.lock(piwirec.ProcessInstance.TargetObjectId); 
         }
        
       // system.debug('final update--> ' +updateIssue);
        
        system.debug('Result--> ' +result);
        
			//return  result; 
        }
        else
        {
          result='You are required to add a response before you can Resolve this issue.'  ;
            
        }
        system.debug('Result--> ' +result);
        return  result;

        
    }
    
     @AuraEnabled
    public static  string Buttonshowhide(Id processinstanceId) //this method is for page load determine issue tracker or submittal buttons.
    {
        
        string hideshowresult;
        
      
        list<ProcessInstanceWorkitem> PIWIlistbuttonshow = new list<ProcessInstanceWorkitem>(); 
        PIWIlistbuttonshow=[Select ProcessInstance.TargetObjectId
                                                       From ProcessInstanceWorkitem where Id=:processinstanceId];
        ProcessInstanceWorkitem piwirecbuttonshow = new ProcessInstanceWorkitem();
        piwirecbuttonshow = PIWIlistbuttonshow.get(0);
        
        
        List<Submittal_1__c> subrecords = new List<Submittal_1__c>();
        subrecords=[select id from Submittal_1__c where id=:piwirecbuttonshow.ProcessInstance.TargetObjectId];
        List<Request_for_Information_RFI__c>issuerecords=new List<Request_for_Information_RFI__c>();
        issuerecords=[select id from Request_for_Information_RFI__c where id=:piwirecbuttonshow.ProcessInstance.TargetObjectId]; 
        if(subrecords.size()>0)
        {
            hideshowresult='sub';
        }
        if(issuerecords.size()>0)
        {
            hideshowresult='Issue';
        }
        
        return hideshowresult;
    }
    
}