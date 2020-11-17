public class approveELI {
    
    private ELI__c[] eli = [select Id, Name, Expense_Header__c, Cost_Code__c, Vendor__c, Project__c, Expenditure_Type__c, PV_Direct__c,
                                Expenditure_Amount__c, Code__c, Date__c, Approved_Amount__c, Manager_Approval__c, Rejected_Reason__c from ELI__c 
                                where Expense_Header__c = :ApexPages.currentPage().getParameters().get('id')];
    
  /*  private ELI__c[] eli_pv = [select Id, Name, Expense_Header__c, Cost_Code__c, Vendor__c, Project__c, Expenditure_Type__c, PV_Direct__c,
                                Expenditure_Amount__c, Code__c, Date__c, Approved_Amount__c, Manager_Approval__c, Rejected_Reason__c 
                                from ELI__c where Expense_Header__c = :ApexPages.currentPage().getParameters().get('id') and PV_Direct__c = true]; */
                                             
    public ELI__c[] getEli(){
  /*      if(UserInfo.getName() == 'Brian von Moos'){
            return eli_pv;
        } else { */
            return eli;
     //   }
    }
    private ER__c exp = [select Name, User__c, Month_Ending__c, Status__c, Requested_Total__c, 
                            Total__c from ER__c where Id = :ApexPages.currentPage().getParameters().get('id')];
    public ER__c getER(){
        return exp;
    }
    public PageReference Save() {
        try{
            update eli;
            sendEmail();                     
            PageReference expRep = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
            expRep.setRedirect(true);
    
            return expRep;
        } catch (DmlException e) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Only the Manager can approve Expense Lines. \n' + e)); 
            return null;
        } 
    }
    public PageReference SaveAll() {
        try{
            for(Integer i = 0; i<eli.size(); i++){
                eli[i].Manager_Approval__c = true;
            }
            update eli;
            sendEmail();                     
            PageReference expRep = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
            expRep.setRedirect(true);
    
            return expRep;
        } catch (DmlException e) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Only the Manager can approve Expense Lines. \n' + e)); 
            return null;
        } 
    }
    public void sendEmail() {
        List<Id> elID = new List<Id>();
        for(Integer i = 0; i<eli.size(); i++){
            elID.add(eli[i].Id);
        }
        Attachment[] att = [select Name, Body, ContentType from Attachment where ParentId in :elID];
  
        update eli;
        submitApproval.app_rej(exp.Id, 'Approved.', 'Approve');
        
        User accounting = [select Id, Email from User where userrole.name = 'Purchasing and Logistics Manager' and IsActive = True];//FirstName = 'Anita' 
        User submitter = [select Name, LastName, FirstName from User where Id = :exp.User__c];
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        
        PageReference pdf =  Page.expReport;
        pdf.getParameters().put('id',(String)exp.id); 
        pdf.setRedirect(true);

        // Take the PDF content
        Blob b;
        
        try{
            b = pdf.getContent();
        }
        catch(exception e){}
        
        // Create the email attachment
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName(submitter.LastName+'_'+submitter.FirstName+'.pdf');
        
        if(b!=null) efa.setBody(b);    
        
        String [] toAddresses = new String[] {accounting.Email};


        // Sends the email
        try {           
            Messaging.EmailFileAttachment[] attachments = new Messaging.EmailFileAttachment[0];
            if(b!=null) attachments.add(efa);
            
            Integer n = 0;  
            for(Integer i = 0; i < att.size(); i++){
                n += 1;
                Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                attach.setFileName('receipts('+n+').pdf');
                attach.setBody(att[i].Body);
                attachments.add(attach);
            }
            
            // Sets the paramaters of the email
            email.setSubject('Expense Report for '+submitter.Name);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody( 'Attached is the expense report and receipts for '+submitter.Name+' for the month ending '
                                    +exp.Month_Ending__c+'.');                                       
            if(attachments.size()>0) email.setFileAttachments(attachments);
            
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        } catch (Exception e){
            Messaging.EmailFileAttachment[] attachments = new Messaging.EmailFileAttachment[0];
            if(b!=null) attachments.add(efa); 
            
            email.setSubject('Expense Report for '+submitter.Name);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody( 'Attached is the expense report for '+submitter.Name+' for the month ending '
                                    +exp.Month_Ending__c+'. The receipts were too large to attach. They can be found here:'+
                                    ' http://na6.salesforce.com/'+exp.Id);                                       
            if(attachments.size()>0) email.setFileAttachments(attachments);
            
            if (!Test.isRunningTest()) {
            	Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            }
        }
        
    }
    public PageReference Cancel() {
        submitApproval.app_rej(exp.Id, 'Rejected.', 'Reject');
        
        PageReference expRep = new PageReference('/' + ApexPages.currentPage().getParameters().get('id'));
        expRep.setRedirect(true);

        return expRep;
    }
    public static testmethod void approveTest() {
        User su = [select Id, ManagerId from User where Name = 'System User'];
  //    User bvm = [select Id from User where Name = 'Brian von Moos'];
        ER__c er = new ER__c(User__c = su.Id, Month_Ending__c = System.today(), Receipts_Attached__c = true);
        insert er;           
        
        
        User owner = [select Id from User where Name = 'System User'];
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        
        SFDC_project__c[] proj = new SFDC_project__c[0];
        proj.add(new SFDC_project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        
        
        ELI__c[] eli = new ELI__c[0];
        eli.add(new ELI__c(Expense_Header__c = er.Id, PV_Direct__c = true,Project__c=proj[0].id));
        eli.add(new ELI__c(Expense_Header__c = er.Id,Project__c=proj[0].id));
        insert eli;
        Blob b = Blob.valueOf('toast and jam');
        Attachment att = new Attachment(Name = 'Cheese!', ParentId = eli[0].Id, Body = b); insert att;
                            
        PageReference pageRef = Page.approveELI;
        Test.setCurrentPage(pageRef);
        
        ApexPages.currentPage().getParameters().put('id', er.Id);
        approveELI controller = new approveELI();
   /*       System.runAs(bvm){
                controller.getEli();
            } */
            controller.getEli();
            controller.getER();
            
            System.runAs(su){ 
                PageReference result2 = controller.Save();
            }
            PageReference result4 = controller.Save();
             
            PageReference result = controller.SaveAll();
             
            PageReference result3 = controller.Cancel();
            
            submitApproval.submit(er.Id, 'Approve');
            submitApproval.app_rej(er.Id, 'Rejected.', 'Reject');
                                  
    }    
     Public Static Boolean IsRecursiveUpdate{ get; set;}
     Public Static Boolean IsOpportunityLineItemUpdating{ get; set;}
}