public class ProcessInstanceWorkItemController{    

    public id shopdr;
    
    Public Shop_Drawing__c ShopDrawing {get; set;}
    
    Public string Comment{get; set;}
        
    ProcessInstanceWorkItem PIWI;
    
    Id TargetId;
     
    public ProcessInstanceWorkItemController() {
    
        ShopDrawing=[Select id,Specs_and_Submittals__c,Name,Account__c,Date_Received__c,
                     Notes_and_Additional_Information__c,Approved__c,Approved_as_Corrected__c,
                     Revise_and_Resubmit__c,Status__c from Shop_Drawing__c where id=:ApexPages.currentPage().getParameters().get('SD')];
        
        List<ProcessInstanceWorkItem> workItemList = [Select p.ProcessInstance.TargetObjectId,p.ProcessInstanceId,p.OriginalActorId,p.Id,p.ActorId 
                                                        From ProcessInstanceWorkitem p 
                                                        where p.id = :ApexPages.currentPage().getParameters().get('id')];

    
        IF(workItemList!=null && workItemList.Size()>0)
            PIWI=workItemList[0];
            
        
        TargetId=PIWI.ProcessInstance.TargetObjectId;
        
   
    }
     public PageReference ReviseandResubmit(){
         PageReference PR=Approved();
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
            
            Approval.Processworkitemrequest objReq = new Approval.Processworkitemrequest();
            objReq.setAction('Approve');
            objReq.setComments(Comment);
            objReq.setWorkitemId(PIWI.ID);
            objReq.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            Approval.ProcessResult result2 =  Approval.process(objReq);
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
        
            Public static ProcessInstanceWorkItemController CreateData(){
        
              User owner = [select Id from User where Name = 'System User'];
    
       
                       
                    //Set Page Parameters
                  
                    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                                        Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                                        Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
                    insert acc;
                   
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
                    
                    Shop_Drawing__c shopdr = new Shop_Drawing__c(Name='testsubmittal',Date_Received__c=Date.Today(),status__C='New',Specs_and_Submittals__c=spec.Id);
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
                        
                        ApexPages.currentPage().getParameters().put('id',newWorkItemIds.get(0));
                      
                        
                         ProcessInstanceWorkItemController proc = new ProcessInstanceWorkItemController();
                        
                        return proc;
                    
        }
        
           // test method
        static testMethod void testCase1()
    {
        
     ProcessInstanceWorkItemController proc = CreateData();
     
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
        
     ProcessInstanceWorkItemController proc = CreateData();
     
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
        
     ProcessInstanceWorkItemController proc = CreateData();
     
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
        
     ProcessInstanceWorkItemController proc = CreateData();
     
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
        
     ProcessInstanceWorkItemController proc = CreateData();
     
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
        
     ProcessInstanceWorkItemController proc = CreateData();
     
     //  proc.ReviseandResubmit();
     //  proc.ApprovedasCorrected();
     //  proc.Approved();
     //  proc.Rejected();
     //   proc.Cancel();
        proc.GoBack();
    }  
    

        
}