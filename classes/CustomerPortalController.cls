public with  sharing class CustomerPortalController{

    public Account CurrentAccount{get;set;}    
    
    List<OpportunityContactRole> ListOfContacts;

    Public User CurrentUser{get; set;}
       
    List<id> ListOfChildAccountIds=new List<id>();

    List<OpportunityLineItem> ListOfOpportunityLineItems;    
    
    public List<AcctSeed__Project__c> ListOfProjects {get;set;}
    

    public AcctSeed__Project__c SelectedProject{get;set;}
    public List<FAQ__c> FAQlist {get; set;}
    
    public opportunity CurrentOpportunity{get; set;} 
    public Contract CurrentContract;   
    public String CurrentContractType {get; set;}

    public String chanageRebateId{get;set;}
    public boolean systemNotworking{get;set;}
    public boolean GeneralInq{get;set;}
    public String Subject{get;set;}
    public String Description{get;set;}
    public list<SelectOption> ListOfCaseOptions{get; set;}
    public boolean isRebateAssignedTo{get; set;}
    public Id CaseDetailId;
    Map<String, String> caseFieldLabelMap = new Map<String, String>();
    
    public User ProjectOwner{get; set;}
        
    public User ProjectManager{get; set;}
    
    public Branch__c Branch {get; set;}
    
    //Properties to recognize current status of page
    public boolean IsParent{get;set;}
    public boolean IsProjectRecord{get;set;}
    public boolean IsMySysSummaryRecord{get;set;}
    public boolean Isdefaultpage{get;set;} 
    public boolean IsFAQpage{get;set;}
    public boolean IsCaseViewPage{get;set;}
    public boolean IsCaseDetailPage{get;set;}
    public boolean IsProjectDocpage{get;set;}
    public boolean IsWhoToContactpage{get;set;}
    public boolean IsconatctusportalPage{get;set;}
    public boolean IsRebateInforPage{get;set;}
    public boolean IsAccountInfo{get;set;}
    public boolean UseCustomerBackground{get;set;}
    //---------------------------------------------------------
    
    public string ProjectDeveloper{get; set;}
    
    public CustomerPortalController(ApexPages.StandardController controller) {
        ListOfContacts = new List<OpportunityContactRole>();
        ListOfOpportunityLineItems = new List<opportunitylineitem >();
        IsParent = false;
        IsProjectRecord =false;
        IsFAQpage = false;
        IsMySysSummaryRecord = false;
        Isdefaultpage = true;
        IsProjectDocpage= false;
        IsCaseViewPage = false;
        IsCaseDetailPage = false;
        IsWhoToContactpage = false;
        systemNotworking =false;
        IsRebateInforPage =false;
        GeneralInq = true;
        IsconatctusportalPage = false;
        isAccountInfo=false;
        
        ListOfProjects = new List<AcctSeed__Project__c>();
        SelectedProject = new AcctSeed__Project__c();

           Branch = new Branch__c();
          ProjectOwner = new User();
          ProjectManager = new User();
        CurrentAccount = [select Id,
                        Name,
                        Parentid,
                        Website,
                        Parent.Name,
                        BillingStreet,
                        BillingPostalCode,
                        BillingCity,
                        BillingState,
                        ShippingStreet,
                        ShippingPostalCode,
                        ShippingCity,
                        ShippingState,
                        phone,
                        TempContact__c
                        from Account 
                        where id=:controller.getrecord().Id];
       
        List<Opportunity> ListOfOpportunity=[Select id, Rebate_Assigned_To__c from Opportunity where accountid=:CurrentAccount.id];
        
        if(ListOfOpportunity!=null && ListOfOpportunity.size()>0)
            CurrentOpportunity=ListOfOpportunity[0];
            
        List<Contract> ListOfContracts = [SELECT Id, AccountId, Type__c FROM Contract WHERE AccountId =: CurrentAccount.Id];
        if (ListOfContracts != NULL && ListOfContracts.size() > 0) {
            CurrentContract = ListOfContracts[0];
            CurrentContractType = ListOfContracts[0].Type__c;
        }
        
        List<id> ListOfAccountIds=new List<id>();
        ListOfAccountIds.add(CurrentAccount.id);
        if(CurrentAccount.Parentid != null ){
            IsParent  = true;
            ListOfAccountIds.add(CurrentAccount.Parentid );        
        }
        
        /*
        ListOfChildAccountIds.add(CurrentAccount.id);
        for(Account ACC:[Select id from Account
                            Where ParentId=:CurrentAccount.id]){
            ListOfChildAccountIds.Add(ACC.ID);
        }
        */
        
        // Determine the list of child accounts - there can be multiple levels
        List<Id> accIds = new List<Id>();
        Map<Id, Account> accMap = new Map<Id, Account>();
        List<Account> accList = new List<Account>();
        accList.add(CurrentAccount);
        while (!accList.isEmpty()) {
            accIds.clear();
            for (Account a : accList) {
                if (!accMap.containsKey(a.Id)) {
                    accMap.put(a.Id, a);
                    accIds.add(a.Id);
                }
            }
            accList.clear();
            if (!accIds.isEmpty()) {
                accList = [select Id from Account where ParentId in: accIds];
            }
        }
        ListOfChildAccountIds.addAll(accMap.keySet());
        
        system.debug('*****TESTCLASS ListOfChildAccountIds.size = ' + ListOfChildAccountIds.size());
        
        
        SelectedProject=new AcctSeed__Project__c();
        ListOfProjects = [select Id, Name, 
                        AcctSeed__Account__c,Rebate_Status__c,Rebate_ProgramF__c,
                        PTO_Date__c,Rebate_Assigned_To__c,Performance_reporting__c, 
                        AcctSeed__Opportunity__r.Utility_Company__c,WATTS_STC__c ,Rebate_Id__c,
                        Site_Superintendent__c,Utility_CompanyF__c,Current_Project_System_Size2__c,
                        Rebate_Expiration_Date__c,Closeout_Document__c,owner.Name,ownerId,Project_developer_Opportunity__c,
                        AcctSeed__Opportunity__c,Project_Developer__c, EC__r.Id,EC__r.Name,AcctSeed__Opportunity__r.Owner.Name,
                        EC__r.Email,EC__r.phone,Branch__c, Foreman__c , Foreman__r.name
                        ,Site_Street_AddressF__c,Site_CityF__c,Site_StateF__c,Site_Zip_CodeF__c, Racking_Type__c
                        from AcctSeed__Project__c 
                        where Opp_Type__c='Turnkey System' 
                        and Overall_Project_Status__c!='Dead' 
                        and Overall_Project_Status__c!='On Hold' 
                        and Overall_Project_Status__c!='Pre-Contract' 
                        and AcctSeed__Status__c!='Dead' 
                        and AcctSeed__Account__c in :ListOfChildAccountIds];
                        
        if(ListOfProjects.size()>0){
            IsProjectRecord =true;
            SelectedProject = ListOfProjects.get(0);
            chanageRebateId=SelectedProject.id;
            ProjectDeveloper=SelectedProject.AcctSeed__Opportunity__r.Owner.Name;
        }
        
        isRebateAssignedTo=false;
        
         
         ListOfCaseOptions= new List<SelectOption>();
         ListOfCaseOptions.add(new SelectOption('false','My System Is Not Working')); 
         ListOfCaseOptions.add(new SelectOption('false','General Inquiries/Feedback'));  
         
         CurrentUser=[Select id, Company_logo__c from User where id=:UserInfo.GetUserID()];
/*
         if (CurrentUser.Background_Name__c != NULL) {
            UseCustomerBackground = TRUE;
         } else {
            UseCustomerBackground = FALSE;
         }
*/
         
         // Get list of Case fields to expose in Case History view
         List<Portal_Case_Field__c> caseFields = new List<Portal_Case_Field__c>();
         caseFields = [SELECT Name, Case_Field_Label__c FROM Portal_Case_Field__c];
         for (Portal_Case_Field__c pcf : caseFields) {
            caseFieldLabelMap.put(pcf.Case_Field_Label__c, pcf.Name);
            system.debug('*****Case Field Label = ' + pcf.Case_Field_Label__c);
            system.debug('*****Case Field Name = ' + pcf.Name);
         }
    }

    public string getAccountId(){
        return string.valueOf(CurrentAccount.id);
    }

    public string getCompanyName(){ return 'Borrego Customer Ltd';}
    public string getWebsite(){ return 'www.BorregoCustomerLtd.com';}
    public string getAddress(){ return '123 5th Avenue, NY NY, 10435';}        

    public void doNothing(){
    
    }
    
    
    //get OpportunityContactRole records
    public List<ContactWrapper> getContacts(){
    
    List<OpportunityContactRole> oppconRol = new List<OpportunityContactRole>(); 
    list<id> ListOfContactIds=new List<id>();
    List<ContactWrapper> ListOfContactWrapper=new List<ContactWrapper>();
    id PrimaryContactId;
    
    //if(SelectedProject!=null && SelectedProject.Opportunity__c!=null)
                             oppconRol =[Select ContactId, 
                                             Contact.AccountId, 
                                             Contact.Email, 
                                             Contact.Id, 
                                             Contact.Name, 
                                             Contact.Phone, 
                                             Contact.Title, 
                                             Id, 
                                             IsPrimary, 
                                             OpportunityId, 
                                             Role 
                                             from OpportunityContactRole
                             where Contact.VIP_Contact__c = true and Opportunity.accountid = :ListOfChildAccountIds];//CurrentAccount.id];
         
      if(oppconRol != null && oppconRol .size()>0){
          for(OpportunityContactRole oppco:oppconRol ){
              ListOfContactIds.add(oppco.ContactId);
              
              if(oppco.IsPrimary==true)
                  PrimaryContactId=Oppco.ContactId;
          }                    
      }                     
    
      for(Contact  Con: [Select AccountId, 
                     Email, 
                     Id, 
                     Name, 
                     Phone,VIP_Contact__c, 
                     Title
                     From Contact where VIP_Contact__c = true and AccountId = :CurrentAccount.Id]){
                     //From Contact where VIP_Contact__c = true and (id in :ListOfContactIds or  AccountId in :ListOfChildAccountIds)]){//=:CurrentAccount.Id])
              ListOfContactWrapper.add(new ContactWrapper(Con,(Con.id==PrimaryContactId)));
          }
    
        return ListOfContactWrapper;
    
    }
    
    
   //get OpportunityContactRole records
    public List<OpportunityContactRole> getContactList(){
    
    List<OpportunityContactRole> oppconRol = new List<OpportunityContactRole>(); 

    
    if(SelectedProject!=null && SelectedProject.AcctSeed__Opportunity__c!=null)
                             ListOfContacts =[Select ContactId, 
                                             Contact.AccountId, 
                                             Contact.Email, 
                                             Contact.Id, 
                                             Contact.Name, 
                                             Contact.Phone, 
                                             Contact.Title, 
                                             Id, 
                                             IsPrimary, 
                                             OpportunityId, 
                                             Role 
                                             from OpportunityContactRole
                             where (OpportunityId = :SelectedProject.AcctSeed__Opportunity__c or contact.accountid =:CurrentAccount.id)];
         
      if(ListOfContacts != null && ListOfContacts.size()>0){
          for(OpportunityContactRole oppco:ListOfContacts){
              oppconRol.add(oppco);
          }                    
      }                     
    return oppconRol;
    

    
    }
    //display rebate section according to project
     public void RebateRecords(){
        //ResetBooleans();
         //Isdefaultpage=false;
         //IsMySysSummaryRecord=true;
         IsRebateInforPage =true;
         isRebateAssignedTo=false;
          
    if(chanageRebateId != null && chanageRebateId != '')
        SelectedProject = [select Id,Name,AcctSeed__Account__c,Rebate_Status__c,Rebate_ProgramF__c,
                                    PTO_Date__c,Rebate_Assigned_To__c,Performance_reporting__c, 
                                    AcctSeed__Opportunity__r.Utility_Company__c,WATTS_STC__c ,Rebate_Id__c,
                                    Site_Superintendent__c,Utility_CompanyF__c,Current_Project_System_Size2__c,
                                    Rebate_Expiration_Date__c,Closeout_Document__c,owner.Name,ownerId,AcctSeed__Opportunity__r.Owner.Name,
                                    AcctSeed__Opportunity__c,Project_Developer__c,EC__r.Id,EC__r.Name,Project_developer_Opportunity__c,
                                    EC__r.Email,EC__r.phone,Branch__c, Foreman__c  , Foreman__r.name
                                    ,Site_Street_AddressF__c,Site_CityF__c,Site_StateF__c,Site_Zip_CodeF__c, Racking_Type__c
                          from AcctSeed__Project__c 
                          where  Opp_Type__c='Turnkey System' 
                          and Overall_Project_Status__c!='Dead'  
                          and Overall_Project_Status__c!='On Hold' 
                          and Overall_Project_Status__c!='Pre-Contract' 
                          and AcctSeed__Status__c!='Dead'  
                          and id=:chanageRebateId];
        
        list<User> ListOfUsers;
        
        ListOfUsers  = [select Id,Name,manager.FirstName,Manager.LastName,Manager.Id,email from User where Id=: SelectedProject.OwnerId];
        
        if(ListOfUsers!=null && ListOfUsers.size()>0)
            ProjectOwner=ListOfUsers[0];
        
        ListOfUsers=null;
        
        if(ProjectOwner!=null) ListOfUsers = [select Id,Name,FirstName,LastName,phone,Email from User where Id=: ProjectOwner.Manager.Id];

        if(ListOfUsers!=null && ListOfUsers.size()>0)
            ProjectManager=ListOfUsers[0];
        
        list<Branch__c > ListOfBranches;    
        ListOfBranches = [select Id,Name,Zip_Code__c,Street_Address__c,State__c,City__c from Branch__c where Name=:SelectedProject.Branch__c limit 1];
        if(ListOfBranches!=null && ListOfBranches.size()>0) Branch=ListOfBranches[0];
        
        ProjectDeveloper=SelectedProject.AcctSeed__Opportunity__r.Owner.Name;
        
        if(SelectedProject !=null && SelectedProject.Rebate_Assigned_To__c!=null && SelectedProject.Rebate_Assigned_To__c=='Host Customer' )
            isRebateAssignedTo=true;
        
        if (SelectedProject != null && SelectedProject.AcctSeed__Account__c != null) {
            List<Contract> svcContract = [select Id, Name, Type__c from Contract where AccountId =: SelectedProject.AcctSeed__Account__c];
            if (svcContract.size() > 0) {
                CurrentContract = svcContract[0];
                CurrentContractType = svcContract[0].Type__c;
            } else {
                CurrentContractType = null;
            }
        }
        
        // We are switching projects but we need to stay on the last tab as clicked
        system.debug('*****Before Isdefaultpage = ' + Isdefaultpage);
        system.debug('*****Before IsMySysSummaryRecord = ' + IsMySysSummaryRecord);
        system.debug('*****Before IsFAQPage = ' + IsFAQPage);
        system.debug('*****Before IsProjectDocpage = ' + IsProjectDocpage);
        system.debug('*****Before IsWhoToContactpage = ' + IsWhoToContactpage);
        system.debug('*****Before Isconatctusportalpage = ' + Isconatctusportalpage);
        system.debug('*****Before IsCaseViewPage = ' + IsCaseViewPage);
        system.debug('*****Before IsCaseDetailPage = ' + IsCaseDetailPage);
        system.debug('*****Before isAccountInfo = ' + isAccountInfo);
        
        PageReference pr;
        if (IsMySysSummaryRecord || Isdefaultpage) {
            pr = MySysSummary();
        }
        if (IsFAQPage) {
            pr = CreateFAQ();
        }
        if (IsProjectDocpage) {
            pr = ProjectDoc();
        }
        if (IsWhoToContactpage) {
            pr = WhoToContact();
        }
        if (Isconatctusportalpage) {
            pr = ConatctUsPortal();
        }
        if (IsCaseViewPage || IsCaseDetailPage) {
            pr = CaseView();
        }
        if (isAccountInfo) {
            pr = AccountInformation();
        }
        
        system.debug('*****After Isdefaultpage = ' + Isdefaultpage);
        system.debug('*****After IsMySysSummaryRecord = ' + IsMySysSummaryRecord);
        system.debug('*****After IsFAQPage = ' + IsFAQPage);
        system.debug('*****After IsProjectDocpage = ' + IsProjectDocpage);
        system.debug('*****After IsWhoToContactpage = ' + IsWhoToContactpage);
        system.debug('*****After Isconatctusportalpage = ' + Isconatctusportalpage);
        system.debug('*****After IsCaseViewPage = ' + IsCaseViewPage);
        system.debug('*****After IsCaseDetailPage = ' + IsCaseDetailPage);
        system.debug('*****After isAccountInfo = ' + isAccountInfo);
    }
    
    // Return the list of Service Visits associated with the current Contract
    public List<ServiceVisitWrapper> getServiceVisitlist() {
        List<SV__c> svList = new List<SV__c>();
        List<ServiceVisitWrapper> svWrapper = new List<ServiceVisitWrapper>();
        
        if (CurrentContract != NULL) {
            svList = [SELECT Id, Name, Contract__c, Visit_Date__c, Visit_Reason__c, Performed_By__c, Notes__c, Private_Notes__c  
                    FROM SV__c WHERE Contract__c =: CurrentContract.Id Order By Name DESC];
            system.debug('*****TESTCLASS svList.size = ' + svList.size());
            for (SV__c sv : svList) {
                svWrapper.add(new ServiceVisitWrapper(
                    sv.Name,
                    sv.Visit_Date__c.format(),
                    sv.Visit_Reason__c,
                    sv.Performed_By__c,
                    sv.Notes__c,
                    sv.Private_Notes__c
                    )
                );
            }
        }
        return svWrapper;
    }
    
    // Return the list of Service Visits associated with the current Case
    public List<ServiceVisitWrapper> getCaseServiceVisits() {
        List<SV__c> svList = new List<SV__c>();
        List<ServiceVisitWrapper> svWrapper = new List<ServiceVisitWrapper>();
        
        if (CaseDetailId != NULL) {
            svList = [SELECT Id, Name, Case__c, Visit_Date__c, Visit_Reason__c, Performed_By__c, Notes__c, Private_Notes__c 
                    FROM SV__c WHERE Case__c =: CaseDetailId ORDER BY Name DESC];
            
            for (SV__c sv : svList) {
                svWrapper.add(new ServiceVisitWrapper(
                    sv.Name,
                    sv.Visit_Date__c.format(),
                    sv.Visit_Reason__c,
                    sv.Performed_By__c,
                    sv.Notes__c,
                    sv.Private_Notes__c
                    )
                );
            }
        }
        return svWrapper;
    }
    
    
    //return the list of opportunitylineitem
    public List<ProductWrapper> getOppLineItemlist(){
    
    Map<id,opportunitylineitem> oppLnItm = new Map<id,opportunitylineitem>(); 
    if(CurrentAccount.id != null || CurrentAccount.id != '') 
    
    if(SelectedProject!=null)
     ListOfOpportunityLineItems = [select Id,
                             PricebookEntry.Product2.Name,
                             PricebookEntry.Product2.ProductCode,
                             PricebookEntry.Product2.Product_Spec_Data_Sheet__c,
                             PricebookEntry.Product2.Family,
                             PricebookEntry.Product2.Manufacturer_Account__c,
                             PricebookEntry.Product2.Manufacturer_Account__r.Name,
                             PricebookEntry.Product2.Manufacturer_Data_Sheet__c,
                             PricebookEntry.Product2.Vendor_Product_Page__c,
                             PricebookEntry.Product2.Materials_Warranty_Yrs__c,                                                          
                             PricebookEntry.Product2.Manufacturer__c,Quantity
                 from opportunitylineitem 
                 where Opportunity.id = :SelectedProject.AcctSeed__Opportunity__c
                 and PricebookEntry.Product2.Family in ('Inverters','Solar Modules','Racking','Data Monitoring')];
                 
      list<ProductWrapper> ListOfProductWrapper=new List<ProductWrapper>();
      
      if(ListOfOpportunityLineItems != null && ListOfOpportunityLineItems.size()>0){
           for(opportunitylineitem oplnit:ListOfOpportunityLineItems ){
               if(!oppLnItm.containskey(oplnit.PricebookEntry.Product2.id)){
                   oppLnItm.put(oplnit.PricebookEntry.Product2.id,oplnit); 
                   ListOfProductWrapper.add(new ProductWrapper(oplnit.PricebookEntry.Product2.Name
                                                               ,oplnit.Quantity
                                                               ,oplnit.PricebookEntry.Product2.Family
                                                               ,oplnit.PricebookEntry.Product2.Manufacturer_Account__r.Name
                                                               ,oplnit.PricebookEntry.Product2.Materials_Warranty_Yrs__c
                                                               ,oplnit.PricebookEntry.Product2.Vendor_Product_Page__c , oplnit.PricebookEntry.Product2.Manufacturer_Data_Sheet__c)); 
                   
                }
          } 
        }
      //return oppLnItm.values();
      return ListOfProductWrapper;
    }
    // return the list of project
    public List<AcctSeed__Project__c> getProjectlist(){
        
        List<id> ListOfAccountIds=new List<id>();
        ListOfAccountIds.add(CurrentAccount.id);
        
        if(CurrentAccount.Parentid != null ){
            ListOfAccountIds.add(CurrentAccount.Parentid );        
        }   
    
        ListOfProjects = [select Id,Name, AcctSeed__Account__c,AcctSeed__Opportunity__c  
                                from AcctSeed__Project__c 
                                where  Opp_Type__c='Turnkey System' 
                                  and Overall_Project_Status__c!='Dead' 
                                  and Overall_Project_Status__c!='Pre-Contract' 
                                  and AcctSeed__Status__c!='Dead'  
                                  and AcctSeed__Account__c in :ListOfChildAccountIds];//ListOfAccountIds];
        if(ListOfProjects.size()>0){
            IsProjectRecord =true;
        
        }
      return ListOfProjects;
    
    }
    //display FAQ Page
    public pageReference CreateFAQ() {
        ResetBooleans();
        IsFAQpage = true;
        FAQlist = initFAQlist();
        return null;
    }
    
    private void ResetBooleans(){
        
        IsCaseViewPage = false;
        IsCaseDetailPage = false;
        IsProjectDocpage = false;
        IsMySysSummaryRecord = false;
        IsWhoToContactpage = false;
        IsconatctusportalPage = false;
        IsFAQpage = false;
        Isdefaultpage=false;
        isAccountInfo=false;
        system.debug('*****Booleans reset');
    }
     //display Project Document Page
     public pageReference ProjectDoc(){
        ResetBooleans();
        IsProjectDocpage = true;               
        return null;
    }
    //display CaseView Page
     public pageReference CaseView(){
        ResetBooleans();
        IsCaseViewPage = true;
        system.debug('*****IsCaseViewPage = ' + isCaseViewPage);
        return null;
    }
    //display CaseDetailView Page
     public pageReference CaseDetailView() {
        ResetBooleans();
        IsCaseDetailPage = true;
        system.debug('*****IsCaseDetailPage = ' + isCaseDetailPage);
        return null;
    }
    //display WhoToCoantact Page
     public pageReference WhoToContact(){
        ResetBooleans();
        IsWhoToContactpage = true;
        return null;
    }
    // display ConatctUs page
     public pageReference ConatctUsPortal(){
        ResetBooleans();
        IsconatctusportalPage = true;
        return null;
    }
    // Display Account information
    public pageReference AccountInformation(){
        ResetBooleans();
        isAccountInfo = true;
        return null;
    }
    //Display SystemSummary section
    public pageReference SysSummary(){
        pageReference Ref=new pageReference('/apex/CustomerPortalPage?id='+CurrentAccount.id);
        //Ref.getParameters().Put('id','/'+CurrentAccount.id);
        Ref.SetRedirect(true);
        return Ref;
    }
     //Display SystemSummary section
     public pageReference MySysSummary(){
        ResetBooleans();
        IsMySysSummaryRecord = true;
        return null;
    }
    
    //return the list of FAQ
    public List<FAQ__c> initFAQlist() {
        List<FAQ__c> ListOfFAQ = new List<FAQ__c>();
        List<FAQ__c> faqls = [SELECT Name, Project_Type__c, Question__c, Answer__c FROM FAQ__c ORDER BY Name ASC];
        if(faqls != NULL && faqls.size() > 0) {
            for (FAQ__c FAQ : faqls) {
                if (FAQ.Project_Type__c != null && FAQ.Project_Type__c.contains(SelectedProject.Racking_Type__c)) {
                    ListOfFAQ.Add(FAQ);
                }
            }
        }
        return ListOfFAQ;                                
    }
    
     //return the list of User
     public List<User> getUserList(){
        List<User> ListOfUser = new List<User>();
         List<User> user = [SELECT Id, Name,Email,phone FROM User limit 5];
         if(user != null && user.size()> 0){
            for(User FAQ:user ){
                ListOfUser.Add(FAQ);
            }
        }
        return ListOfUser;                                
    }
    
    //return the list of Case
     public List<Case> getCaselist(){
        List<Case> ListofCase=new List<Case>();
        List<Case> csls = new List<Case>();
        id CurAccountId;
        if(SelectedProject!=null)
            CurAccountId=SelectedProject.AcctSeed__Account__c ;
        else
            CurAccountId=CurrentAccount.id;
            
        if(CurAccountId != null)
        csls = [Select Id, CaseNumber,Type,Status,CreatedDate,owner.Name,Subject,Case_End_Date__c,Component__c,Reason,isPortalCase__c, 
                        Solution_in_Progress__c from case where AccountId = :CurAccountId and isPortalCase__c= true order by CreatedDate desc];
        if(csls != null && csls.size()>0){
            for(Case cs: csls ){
                ListofCase.Add(cs);
            }
         }
        return ListofCase;                                
    }
    
    // Get Case detail information
    public Case getCaseInfo() {
        Case caseRecord = new Case();
        List<CaseComment> ccList = new List<CaseComment>();
        List<SV__c> svList = new List<SV__c>();
        
        if (CaseDetailId != NULL) {
            caseRecord = [SELECT Id, Owner.Name, CaseNumber, Case_Start_Date__c, Portal_Inquiry_Type__c, Contact.Name, Origin, Status, Component__c, 
                    Case_End_Date__c, Technician__c, Solution_in_Progress__c, Subject, Description, Reason FROM Case WHERE Id =: CaseDetailId];
        }
        system.debug('*****caseRecord CaseNumber = ' + caseRecord.CaseNumber);
        return caseRecord;
    }
    
    public List<CaseComment> getComment_RelList() {
        List<CaseComment> ccList = new List<CaseComment>();
        
        if (CaseDetailId != NULL) {
            ccList = [SELECT Id, CommentBody, IsPublished, CreatedDate, Createdby.Name, ParentId 
                    FROM CaseComment WHERE ParentId =: CaseDetailId AND IsPublished =: TRUE ORDER BY CreatedDate DESC];
        }
        return ccList;
    }
    
    public List<CaseHistory> getCaseHistory_RelList() {
        List<CaseHistory> chList = new List<CaseHistory>();
        
        system.debug('*****Size of caseFieldLabelMap = ' + caseFieldLabelMap.size());
        if (CaseDetailId != NULL) {
            chList = [SELECT Id, CaseId, Field, NewValue, OldValue, CreatedBy.Name, CreatedDate, IsDeleted 
                FROM CaseHistory WHERE CaseId =: CaseDetailId AND Field IN: caseFieldLabelMap.keySet() AND IsDeleted =: FALSE ORDER BY CreatedDate DESC];
            for (CaseHistory ch : chList) {
                system.debug('*****ch.Field before = ' + ch.Field);
                //ch.Field = caseFieldLabelMap.get(ch.Field);
                //system.debug('*****ch.Field after = ' + ch.Field);
            }
        }
        return chList;
    }
    
    public void setCaseDetailId(Id caseId) {
        CaseDetailId = caseId;
        system.debug('*****setCaseDetailId = ' + CaseDetailId);
    }
    
    public Id getCaseDetailId() {
        system.debug('*****getCaseDetailId = ' + CaseDetailId);
        return CaseDetailId;
    }
    
    
    
    //test Method
    
    
      
    static testMethod void case1() {
    
    ASeedAccountingSettingsSetupTest.testDataSetup(); 
    
  
        Account ParentAccount = new Account(Name = 'Parent Knight - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', Project_End_Date__c = null, ShippingCity = 'San Francisco');
        insert ParentAccount;
        Account CurrentAccount = new Account(Name = 'Knight - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', Project_End_Date__c = null, ShippingCity = 'San Francisco', ParentId = ParentAccount.Id);
        insert CurrentAccount;
        
        List<Contact> clist = new List<Contact>();
        cList.add(new Contact(LastName = 'Toovich',VIP_Contact__c=true, FirstName='Arana' ,AccountId = CurrentAccount.Id));
        cList.add(new Contact(LastName = 'Toovich',VIP_Contact__c=true, FirstName='Brana' ,AccountId = CurrentAccount.Id));
        insert cList;
        
        Opportunity opp=New Opportunity(Name='Test Data Trigger',
                AccountId=CurrentAccount .Id,
                StageName='Prospecting',
                Type = 'Turnkey System',
                closedate=Date.Today());    
        insert opp;            
        
        OpportunityContactRole ocr=new OpportunityContactRole();
        ocr.contactid=cList[0].id;
        ocr.opportunityid=opp.id;
        ocr.isPrimary=true;
        insert ocr;
        
        FAQ__c fq = new FAQ__c(FAQ_Content__c ='test',Account__c=CurrentAccount.Id);
        insert fq;
        
        //profile  pro=  [select id from Profile where name='Standard User'];
        
        List<User> theUsers = new List<User>();
        theUsers = TestMethods.getUserList();
        /*
        for(Integer i = 0; i < 20; i++){
            //User theUser = new User(profileid = getProfileStandardUser().Id, alias = 'standt'+i, email='standarduser'+i+'@testorg.com', emailencodingkey='UTF-8', lastname='Testing'+i, languagelocalekey='en_US', localesidkey='en_US', timezonesidkey='America/Los_Angeles', username='standarduser'+i+'@testorg.com');
            User theUser = new User(profileid = pro.Id, alias = 'standt'+i, email='standarduser'+i+'@testorg.com', emailencodingkey='UTF-8', lastname='Testing'+i, languagelocalekey='en_US', localesidkey='en_US', timezonesidkey='America/Los_Angeles', username='ttttt'+i+'@testorg.com');
            theUsers.add(theUser);
        }
        
        insert theUsers;
        
        FAQ__c fq = new FAQ__c(FAQ_Content__c ='test',Account__c=CurrentAccount.Id);
        insert fq;
        Contact con = new Contact(LastName = 'Toovich', FirstName='Arana' ,AccountId = CurrentAccount.Id);
        insert con;
        
        list<user> lu=[select id from user where isActive=true];
        */
        
        List<AcctSeed__Project__c> theProjects = new List<AcctSeed__Project__c>();
        for (Integer i = 0; i < 1; i++) {
            /*
            AcctSeed__Project__c theProject = new AcctSeed__Project__c(Name = 'Knight - 2456'+i,AcctSeed__Opportunity__c = TestMethods.getOpportunity().Id, Account__c =CurrentAccount.Id, SFDC_Project_Stage__c = 'Sales', 
                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                    Job_Number__c = 'TEST_TEST-00-' +i ); 
            */
            AcctSeed__Project__c theProject = new AcctSeed__Project__c(Name = 'Knight - 2456'+i,AcctSeed__Opportunity__c = opp.Id, Account__c =CurrentAccount.Id, SFDC_Project_Stage__c = 'Sales', 
                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                    Job_Number__c = 'TEST_TEST-00-' +i ); 
            theProjects.add(theProject);
        }
        insert theProjects;
        
        for (AcctSeed__Project__c p :theProjects) {
            system.debug('*****TESTCLASS Opp_Type = ' + p.Opp_Type__c + ' Overall Project Status = ' + p.Overall_Project_Status__c + ' AcctSeed__Status = ' + p.AcctSeed__Status__c);
        }
        
        /*
         Contact con1 = new Contact(LastName = 'Toovich',VIP_Contact__c=true, FirstName='Arana' ,AccountId = CurrentAccount .Id);
        insert con1;
        
        Opportunity opp=New Opportunity(Name='Test Data Trigger',
                         AccountId=CurrentAccount .Id,
                         StageName='Prospect',
                         closedate=Date.Today());    
         Insert Opp;            
        
        OpportunityContactRole ocr=new OpportunityContactRole();
        ocr.contactid=con1.id;
        ocr.opportunityid=opp.id;
        ocr.isPrimary=true;
        insert ocr; 
        */
        
        Contract svcContract = new Contract(AccountId = CurrentAccount.Id);
        insert svcContract;
        SV__c svcVisit = new SV__c(Contract__c = svcContract.Id, Visit_Date__c = system.today(), Notes__c = 'test', Private_Notes__c = false);
        insert svcVisit;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(CurrentAccount);
        CustomerPortalController conpr = new CustomerPortalController(controller);
       // conpr.SelectedProject=theProjects[0];
        String account = conpr.getAccountId();
        conpr.getCompanyName();
        conpr.getWebsite();
        conpr.getAddress();
        conpr.doNothing();
        conpr.getContactList();
        conpr.RebateRecords();
        conpr.getOppLineItemlist();
        conpr.getProjectlist();
        conpr.CreateFAQ();
        conpr.ProjectDoc();
        conpr.CaseView();
        conpr.WhoToContact();
        conpr.AccountInformation();
        conpr.SysSummary();
        conpr.MySysSummary();
        conpr.getServiceVisitList();
        conpr.getUserList();
        conpr.getCaselist();
        conpr.ConatctUsPortal();
        conpr.getContacts();
        conpr.CaseDetailView();
        conpr.getCaseServiceVisits();
        conpr.getCaseInfo();
        conpr.getCaseHistory_RelList();
        //conpr.RebateRecords();
     
    }
    
    public class ContactWrapper{
    
        public Contact Contact {get; set;}
        public boolean isPrimary{get; set;}
    
        public ContactWrapper(Contact CurContact, boolean IsPri){
        
            Contact=CurContact;
            isPrimary=IsPri;
        
        }
    
    }
    
    Public Class ProductWrapper{
    
        public string Name{get; set;}
        public decimal Quantity{get; set;}
        public string Family{get; set;}
        public string Manufacturer {get; set;}
        public string Warranty {get; set;}
        public string VendorProduct{get; set;}
        
        public ProductWrapper(string Nm,decimal Qty,string FML, string MF, string Warr, string pp,string VP){
            Name=Nm;
            Quantity=Qty;
            Family=FML;
            Manufacturer=MF;
            Warranty = Warr;
            VendorProduct='';
            if(pp!=null)VendorProduct+=pp + ' ';
            if(VP!=null)VendorProduct+=VP;
        }
    
    }
/*    
    Public Class ServiceVisitWrapper {
    
        public string SVNumber {get; set;}
        public date VisitDate {get; set;}
        public string VisitReason {get; set;}
        public string PerformedBy {get; set;}
        public string Notes {get; set;}
        
        public ServiceVisitWrapper(string NM, date VD, string VR, string PB, string NT) {
            SVNumber = NM;
            VisitDate = VD;
            VisitReason = VR;
            PerformedBy = PB;
            Notes = NT;
        }
    }
*/

}