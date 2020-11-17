public class ProcessInstanceWorkItemSDController{    

    public id shopdr;
    
    Public Shop_Drawing_1__c ShopDrawing {get; set;}
    
    Public string Comment{get; set;}
    
    List<ProcessInstanceWorkItem> workItemList{get; set;}
        
    ProcessInstanceWorkItem PIWI;
    
    Id TargetId;
    
    public SelectOption[] selectedUsers { get; set; }
     
    public ProcessInstanceWorkItemSDController() {
    
        ShopDrawing=[Select id,Name,Account__c,Date_Received__c,Selected_Users__c,
                     Notes_and_Additional_Information__c,Approved__c,Approved_as_Corrected__c,
                     Revise_and_Resubmit__c,Status__c from Shop_Drawing_1__c where id=:ApexPages.currentPage().getParameters().get('SD')];
        
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
            string strSelectedUsers=ShopDrawing.Selected_Users__c;
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
         if(ShopDrawing != null){
             ShopDrawing.Status__c ='Revise and Resubmit';
         }
         update ShopDrawing;
         return PR;
     }
      public PageReference ApprovedasCorrected(){
        PageReference PR=Approved();
         if(ShopDrawing != null){
             ShopDrawing.Status__c ='Approved as Corrected';
         }
         update ShopDrawing;
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
                            
                            mail.setwhatid(ShopDrawing.id);
                            
                            EmailTemplate e = [select Id,Name,Subject,body from EmailTemplate where name ='Shop Drawing 1 Approved'];
                            
                    
                    
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
        
            Public static ProcessInstanceWorkItemSDController CreateData(){
        
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
                    
                    Spec_Submittal__c spec = new Spec_Submittal__c(Name='testspec',Approvers__c='David Dutil',Project__c = proj.get(0).Id);
                    
                    insert spec;
                    
                    Request_for_Information_RFI__c RIR=new Request_for_Information_RFI__c(Detailed_Description__c='test',Contact__c= cn.id ,   Approver__c='Anne Dunbar' ); 
                    insert RIR;
                     
                    if(listOfApprover!=null && listOfApprover.size()>0)
                        RIR.Approver_Lookup__c=listOfApprover[0].id;
                        
                    Update RIR;
                    
                    Shop_Drawing_1__c shopdr = new Shop_Drawing_1__c(Name='testsubmittal',Selected_Users__c=listOfApprover[0].id,Date_Received__c=Date.Today(),status__C='New', Issue_Tracker__c=RIR.ID, Assigned_To__c = listOfApprover[0].Id);
                    insert shopdr;
                     
                     ApexPages.currentPage().getParameters().put('SD',shopdr.Id);
                    
                   // proc.Submitt = sub;
                   
                    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                        req1.setComments('Submitting request for approval.');
                        req1.setObjectId(shopdr.Id);
                        req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
                        Approval.ProcessResult result = Approval.process(req1);
                        
                        system.debug('--------'+result);
                        List<Id> newWorkItemIds = result.getNewWorkitemIds();
                        
                        if(newWorkItemIds!=null && newWorkItemIds.size()>0)
                        ApexPages.currentPage().getParameters().put('id',newWorkItemIds.get(0));
                      
                        
                         ProcessInstanceWorkItemSDController proc = new ProcessInstanceWorkItemSDController();
                        
                        return proc;
                    
        }
        
           // test method
        static testMethod void testCase1()
    {
        
     ProcessInstanceWorkItemSDController proc = CreateData();
     
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
        
     ProcessInstanceWorkItemSDController proc = CreateData();
     
     //  proc.ReviseandResubmit();
       proc.ApprovedasCorrected();
     /*  proc.Approved();
       proc.Rejected();
        proc.Cancel();
        proc.GoBack();*/
    }
    
             // test method
    static testMethod void testCase3()
    {
        
     ProcessInstanceWorkItemSDController proc = CreateData();
     
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
        
     ProcessInstanceWorkItemSDController proc = CreateData();
     
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
        
     ProcessInstanceWorkItemSDController proc = CreateData();
     
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
        
     ProcessInstanceWorkItemSDController proc = CreateData();
     
     //  proc.ReviseandResubmit();
     //  proc.ApprovedasCorrected();
     //  proc.Approved();
     //  proc.Rejected();
     //   proc.Cancel();
        proc.GoBack();
    }  
    

        
}