public class ProcessInstanceWorkItemIssueTrackerCtrl{

    public id shopdr;
    
    Public Request_for_Information_RFI__c IssueTracker {get; set;}
    
    Public string Comment{get; set;}
        
    ProcessInstanceWorkItem PIWI;
    
    List<ProcessInstanceWorkItem> workItemList{get; set;}
    
    Id TargetId;
    
    public SelectOption[] selectedUsers { get; set; }
    public SelectOption[] allUsers { get; set; }
    
    public String message { get; set; }
    
    public ProcessInstanceWorkItemIssueTrackerCtrl() {
    
        list<Request_for_Information_RFI__c> listOfIssueTracker=[Select id,Contact_E_mail_Address__c,Account__c, 
                     Notes_and_Additional_Information__c,Name,Contact__c,Selected_Users__c,
                     Status__c from Request_for_Information_RFI__c where id=:ApexPages.currentPage().getParameters().get('IT')];
        
        IF(listOfIssueTracker!=null && listOfIssueTracker.Size()>0) 
            IssueTracker=listOfIssueTracker[0];
        
        workItemList = [Select p.ProcessInstance.TargetObjectId,p.ProcessInstanceId,p.OriginalActorId,p.Id,p.ActorId 
                                                        From ProcessInstanceWorkitem p 
                                                        where p.id = :ApexPages.currentPage().getParameters().get('id')];

    
        IF(workItemList!=null && workItemList.Size()>0){
            PIWI=workItemList[0];
            
        
        TargetId=PIWI.ProcessInstance.TargetObjectId;
        }
         selectedUsers = new List<SelectOption>();
        
        List<User> Users = [SELECT Name,email, Id FROM User where isActive=true];    
        allUsers = new List<SelectOption>();
        for ( User c : Users ) {
            string strSelectedUsers=IssueTracker.Selected_Users__c;
            if(strSelectedUsers!=null){
                if(strSelectedUsers.contains(c.id)){
                    selectedUsers.add(new SelectOption(c.Id, c.Name));
                }
                else{
                    allUsers.add(new SelectOption(c.Id, c.Name));
                }
            }
            else
                allUsers.add(new SelectOption(c.Id, c.Name));
        }
    }
    
     public PageReference save() {
        message = 'Selected Users: ';
        Boolean first = true;
        for ( SelectOption so : selectedUsers ) {
            if (!first) {
                message += ', ';
            }
            message += so.getLabel() + ' (' + so.getValue() + ')';
            first = false;
        }
        
        return null;       
    }
     public PageReference Resolved(){
        ProcessApproveRequest();
        PageReference PR=GoBack();
         
          SendMail();           
                            
         if(IssueTracker != null){
             IssueTracker.Status__c ='Resolved';
             
             string strSelectedOptions='';
             for(SelectOption SO: selectedUsers ){
                 if(strSelectedOptions=='')
                     strSelectedOptions+=so.getValue();
                 else
                     strSelectedOptions+=','+ so.getValue();
             }
             
             IssueTracker.Selected_Users__c=strSelectedOptions;
             update IssueTracker;
         }
         
         return PR;
     }
     
     private void SendMail(){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         
                    list<contact> listOfTemparoryContacts=new list<contact>();
                    
                    Try{ 
         
                            list<id> listOfUserId=new list<id>();
                            
                            for(SelectOption SO: selectedUsers ){
                                     listOfUserId.add(so.getValue());
                             }
                            
                            list<string> listOfEmailAdd=new list<string>();
                            
                            for(User user:[Select id,email,Name from User where id in :listOfUserId]){
                                if(listOfTemparoryContacts.size()==1){
                                    listOfEmailAdd.add(user.email);
                                }
                                else{
                                    Contact con=new Contact();
                                    con.LastName=user.Name;
                                    con.email=user.email;
                                    listOfTemparoryContacts.add(con);
                                    //listOfEmailAdd.add(user.email);
                               }
                            }
                            
                            insert listOfTemparoryContacts;
                            
                            for(Contact con : listOfTemparoryContacts) {            
                               mail.setTargetObjectId(con.id);
                            } 
                            
                            mail.setToAddresses(listOfEmailAdd);
                            
                            //list<string> listOfBCCEmailAdd=new list<string>();
                            
                            //listOfBCCEmailAdd.add('hardik.ce1993@gmail.com');
                            
                            //mail.setBCCAddresses(listOfBCCEmailAdd);
                            
                            mail.setwhatid(issueTracker.id);
                            
                            EmailTemplate e = [select Id,Name,Subject,body from EmailTemplate where name ='RFI Approved'];
                            
                    
                    
                            mail.setTemplateId(e.Id);
                           //mail.setSubject('test');
                           //mail.setPlainTextBody('test');
                                
                            mail.setSaveAsActivity(false);
                    
                         
                            Messaging.EmailFileAttachment[] attachments = new Messaging.EmailFileAttachment[] {};
                    
                            Messaging.sendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                    
                            
                            if(results.size() > 0){
                                for ( Messaging.sendEmailResult result : results ) {
                                    if ( !result.isSuccess () ) {
                                        Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, result.getErrors().get(0).getMessage()));
                    
                                    }
                                }
                            } 
                            
                            
                 }
                 catch(exception ex){
                 
                 }
                 
                 if(listOfTemparoryContacts.size()>0) delete listOfTemparoryContacts;   
     }
      
    // Function called when Approve/Reject Button is clicked

    Public void ProcessApproveRequest(){
            Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
            objReq.setAction('Approve');
            objReq.setComments(Comment);
            objReq.setWorkitemId(PIWI.ID);
            objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            Approval.ProcessResult result2 =  Approval.process(objReq);     
    }

        public PageReference Approved(){
            
           ProcessApproveRequest(); 
           
           IssueTracker.Status__c ='Closed';
           update IssueTracker;  
            
            SendMail();
                   
            return GoBack();
        }
        
        
        
        public PageReference Rejected(){
            
            Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
            objReq.setAction('Reject');
            objReq.setComments(Comment);
            objReq.setWorkitemId(PIWI.ID);
            objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            Approval.ProcessResult result2 =  Approval.process(objReq);               
            return GoBack();
        }
        
        Public Pagereference Cancel(){
            return GoBack();
        }

        Private Pagereference GoBack(){
            
            Pagereference PR=New Pagereference('/'+TargetId);
            
            PR.SetRedirect(true);
            
            return PR;
            
        }
          Public static ProcessInstanceWorkItemIssueTrackerCtrl  CreateData(){
        
              User owner = [select Id from User where Name = 'SFDC Developer'];
              list<User> listOfApprover  = [select Id from User where Name = 'Anne Dunbar'];
       
                       
                    //Set Page Parameters
                  System.runAs(owner) {
                    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                                        Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                                        Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
                    insert acc;
                   
                    Contact cn = new Contact();
                    cn.LastName = 'test';
                    cn.Phone = '12312312';
             
                    insert cn;
                   
                    Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                                Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
                    insert opp;
                    
                    
                    SFDC_Project__c[] proj = new SFDC_Project__c[0];
                    proj.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                                    Interconnection_Status__c = 'IssueTrackered', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                                    Job_Number__c = '000-000', OwnerId = owner.Id)); 
                    insert proj;
                    
                    Request_for_Information_RFI__c RIR=new Request_for_Information_RFI__c(Detailed_Description__c='test'
                                                                                            ,Contact__c= cn.id
                                                                                            ,Approver__c='Anne Dunbar'
                                                                                            ,From__c=owner.id
                                                                                            ,To_Borrego_Approver__c=owner.id
                                                                                            ,Selected_Users__c= owner.id
                                                                                            ,Response__c = 'this is the response' ); 
                    insert RIR;
                    
                    if(listOfApprover!=null && listOfApprover.size()>0)
                        RIR.Approver_Lookup__c=listOfApprover[0].id;
                        
                    Update RIR;
                    
                    
                     
                    ApexPages.currentPage().getParameters().put('IT',RIR.Id);
                    
                    
                   
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                        req1.setComments('IssueTrackering request for approval.');
                        req1.setObjectId(RIR.id);
                        req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
                        Approval.ProcessResult result = Approval.process(req1);
                        
                        system.debug('--------'+result);
                        List<Id> newWorkItemIds = result.getNewWorkitemIds();
                        
                        if(newWorkItemIds!=null && newWorkItemIds.size()>0)
                        ApexPages.currentPage().getParameters().put('id',newWorkItemIds.get(0));
                        
               }         
                        
                       ProcessInstanceWorkItemIssueTrackerCtrl proc = new ProcessInstanceWorkItemIssueTrackerCtrl();
                       
                       return proc;
                   
                 
        }
        
        
        // test method
        static testMethod void testCase1()
    {
        
     ProcessInstanceWorkItemIssueTrackerCtrl proc = CreateData();
     
       proc.IssueTracker.Response__c = 'Test Response';
       proc.Resolved();
      
    }
    
   
    
             // test method
    static testMethod void testCase3()
    {
        
     ProcessInstanceWorkItemIssueTrackerCtrl proc = CreateData();
      
       proc.Approved();
     
    }
    
             // test method
    static testMethod void testCase4()
    {
        
     ProcessInstanceWorkItemIssueTrackerCtrl proc = CreateData();
      
       proc.Rejected();
     
    }
        
             // test method
    static testMethod void testCase5()
    {
        
     ProcessInstanceWorkItemIssueTrackerCtrl proc = CreateData();
      
        proc.Cancel();
     
    } 
             // test method
    static testMethod void testCase6()
    {
        
     ProcessInstanceWorkItemIssueTrackerCtrl proc = CreateData();
      
        proc.GoBack();
    }  
    
}