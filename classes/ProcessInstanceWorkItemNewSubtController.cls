public class ProcessInstanceWorkItemNewSubtController{    

    public id shopdr;
    
    Public Submittal_1__c Submitt {get; set;}
    
    Public string Comment{get; set;}
        
    ProcessInstanceWorkItem PIWI;
    
    List<ProcessInstanceWorkItem> workItemList{get; set;}
    
    Id TargetId;
    
    public SelectOption[] selectedUsers { get; set; }
    
    public ProcessInstanceWorkItemNewSubtController() {
    
        Submitt=[Select id,Contact_email_address__c,Account__c,Date_Received__c,
                     Notes_and_Additional_Information__c,Name,Contact__c,Selected_Users__c,
                     Status__c from Submittal_1__c where id=:ApexPages.currentPage().getParameters().get('SD')];
        
        workItemList = [Select p.ProcessInstance.TargetObjectId,p.ProcessInstanceId,p.OriginalActorId,p.Id,p.ActorId 
                                                        From ProcessInstanceWorkitem p 
                                                        where p.id = :ApexPages.currentPage().getParameters().get('id')];

    
        IF(workItemList!=null && workItemList.Size()>0){
            PIWI=workItemList[0];
            TargetId=PIWI.ProcessInstance.TargetObjectId;
        }
        
        selectedUsers = new List<SelectOption>();
        
        List<User> Users = [SELECT Name,email, Id FROM User where isActive=true];    
         
        for ( User c : Users ) {
            string strSelectedUsers=Submitt.Selected_Users__c;
            if(strSelectedUsers!=null){
                if(strSelectedUsers.contains(c.id)){
                    selectedUsers.add(new SelectOption(c.Id, c.Name));
                } 
            }
        }
        
    }
     public PageReference ReviseandResubmit(){
         DoApprove();
         PageReference PR=GoBack();
         if(Submitt != null){
             Submitt.Status__c ='Revise and Resubmit';
         }
         update Submitt;
        
         return PR;
     }
      public PageReference ApprovedasCorrected(){
         PageReference PR=Approved();
         if(Submitt != null){
             Submitt.Status__c ='Approved as Corrected';
         }
         update Submitt;
         
         return PR;
     }
    // Function called when Approve/Reject Button is clicked


        public PageReference Approved(){           
                 
            DoApprove();
            SendMail();         
            return GoBack();
        }
        
        
        public void DoApprove(){
             Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
            objReq.setAction('Approve');
            objReq.setComments(Comment);
            objReq.setWorkitemId(PIWI.ID);
            objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            Approval.ProcessResult result2 =  Approval.process(objReq);   
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
                            
                            /*list<string> listOfBCCEmailAdd=new list<string>();
                            
                            listOfBCCEmailAdd.add('hardik.ce1993@gmail.com');
                            
                            mail.setBCCAddresses(listOfBCCEmailAdd);*/
                            
                            mail.setwhatid(Submitt.id);
                            
                            EmailTemplate e = [select Id,Name,Subject,body from EmailTemplate where name ='Submittal 1 Approved'];
                            
                    
                    
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
        
        
          Public static ProcessInstanceWorkItemNewSubtController  CreateData(){
        
              User owner = [select Id from User where Name = 'System User'];
              list<User> listOfApprover  = [select Id from User where Name = 'Anne Dunbar'];
       
                       
                    //Set Page Parameters
                  
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
                                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                                    Job_Number__c = '000-000', OwnerId = owner.Id)); 
                    insert proj;
                    
                    Request_for_Information_RFI__c RIR=new Request_for_Information_RFI__c(Detailed_Description__c='test',Contact__c= cn.id,Approver__c='Anne Dunbar' ); 
                    insert RIR;
                    
                    if(listOfApprover!=null && listOfApprover.size()>0)
                        RIR.Approver_Lookup__c=listOfApprover[0].id;
                        
                    Update RIR;
                    
                    Submittal_1__c sub = new Submittal_1__c(Name='testsubmittal',Selected_Users__c=listOfApprover[0].id,Date_Received__c=Date.Today(),status__C='New', Issue_Tracker__c=RIR.ID, Assigned_To__c = listOfApprover[0].Id);
                    insert sub;
                     
                    ApexPages.currentPage().getParameters().put('SD',sub.Id);
                    
                   // proc.Submitt = sub;
                   
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                        req1.setComments('Submitting request for approval.');
                        req1.setObjectId(sub.id);
                        req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
                        Approval.ProcessResult result = Approval.process(req1);
                        
                        system.debug('--------'+result);
                        List<Id> newWorkItemIds = result.getNewWorkitemIds();
                        
                        if(newWorkItemIds!=null && newWorkItemIds.size()>0)
                        ApexPages.currentPage().getParameters().put('id',newWorkItemIds.get(0));
                        
                      /*  Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
                        req2.setComments('Approving request.');
                        req2.setAction('Approve');
                        req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
                        system.debug('--------'+newWorkItemIds.get(0));
                        req2.setWorkitemId(newWorkItemIds.get(0));
                        ApexPages.currentPage().getParameters().put('id',newWorkItemIds.get(0));
                        Approval.ProcessResult result2 =  Approval.process(req2);*/
                        
                       ProcessInstanceWorkItemNewSubtController proc = new ProcessInstanceWorkItemNewSubtController();
                        
                       return proc;
                    
        }
        
        
        // test method
        static testMethod void testCase1()
    {
        
     ProcessInstanceWorkItemNewSubtController proc = CreateData();
     
       proc.ReviseandResubmit();
      /* proc.ApprovedasCorrected();
       proc.Approved();
       proc.Rejected();
        proc.Cancel();
        proc.GoBack();*/
    }
    
            // test method
        static testMethod void testCase2()
    {
        
     ProcessInstanceWorkItemNewSubtController proc = CreateData();
     
     //  proc.ReviseandResubmit();
       proc.Submitt.Response__c = 'Test Response';
       proc.ApprovedasCorrected();
     /*  proc.Approved();
       proc.Rejected();
        proc.Cancel();
        proc.GoBack();*/
    }
    
             // test method
    static testMethod void testCase3()
    {
        
     ProcessInstanceWorkItemNewSubtController proc = CreateData();
     
     //  proc.ReviseandResubmit();
     //  proc.ApprovedasCorrected();
       proc.Approved();
     /*  proc.Rejected();
        proc.Cancel();
        proc.GoBack();*/
    }
    
             // test method
    static testMethod void testCase4()
    {
        
     ProcessInstanceWorkItemNewSubtController proc = CreateData();
     
     //  proc.ReviseandResubmit();
     //  proc.ApprovedasCorrected();
     //  proc.Approved();
       proc.Rejected();
     /*   proc.Cancel();
        proc.GoBack();*/
    }
        
             // test method
    static testMethod void testCase5()
    {
        
     ProcessInstanceWorkItemNewSubtController proc = CreateData();
     
     //  proc.ReviseandResubmit();
     //  proc.ApprovedasCorrected();
     //  proc.Approved();
     //  proc.Rejected();
        proc.Cancel();
     //   proc.GoBack();*/
    } 
             // test method
    static testMethod void testCase6()
    {
        
     ProcessInstanceWorkItemNewSubtController proc = CreateData();
     
     //  proc.ReviseandResubmit();
     //  proc.ApprovedasCorrected();
     //  proc.Approved();
     //  proc.Rejected();
     //   proc.Cancel();
        proc.GoBack();
    }  
    
}