public class ContactUsPortalController {

    /*public id AccountId {get; set;}
    private case newCase;
    public boolean isSystemNotWorking {get; set;}
    public id projectid {get; set;}
    public boolean isclicked {get; set;}
    public integer no{get;set;}
    public Account CurrentAccount{get; set;}
    public string Branch{get; set;}
    public id SystemNotWorkingUserid;
    
    Private id PortalContactId;
    
    public ContactUsPortalController (){
         isSystemNotWorking =true;
    }
    
    
    private id getPortalContactId(){
        if(PortalContactId==null){
            
                List<User> ListOfUsers=[Select Contactid from User where Contact.VIP_Contact__c=false and id=:userinfo.getuserid()];
                if(ListOfUsers!=null && ListOfUsers.size()>0) PortalContactId=ListOfUsers[0].Contactid ;
           
        }
        if(PortalContactId==null) return null;
        else return PortalContactId;
    }
  /*  
    private id GetUserId(){
        list<user> ListOfUser;
        
        system.debug('***UserId Branch'+ Branch);
        
        if(Branch==null) return null;
        
        if(Branch=='Berkeley'){
           ListOfUser=[select id from User where isActive=true and (email= 'adamico@borregosolar.com.training' or email= 'adamico@borregosolar.com')];
        }
        else if(Branch=='San Diego'){
             ListOfUser=[select id from User where isActive=true and  (email='dmarks@borregosolar.com.training' or email= 'dmarks@borregosolar.com')];
        }
        else if(Branch=='Boston' || Branch=='Mid Atlantic'){
             ListOfUser=[select id from User where  isActive=true and (email='mmurphy@borregosolar.com.training' or email= 'mmurphy@borregosolar.com')];
        }
        if(ListOfUser!=null && ListOfUser.size()>0)
            return ListOfUser[0].id;

        system.debug('***User Id Branch1'+ Branch);            
        
        return null;
    }
    
    private string GetUserEmail(){
        list<user> ListOfUser;
        
        system.debug('***User Email Branch'+ Branch);
        
        if(Branch==null) return null;
        
        if(Branch=='Berkeley'){
           return 'adamico';
        }
        else if(Branch=='San Diego'){
             return 'dmarks';
        }
        else if(Branch=='Boston' || Branch=='Mid Atlantic'){
             return 'mmurphy';
        }
                   
        
        return null;
    }
  */  
    /*public case getNewCase(){
    
        if(newCase==null){
             newCase=new case();
             newCase.Accountid=AccountID;
             
             newCase.Origin='Customer Portal';
             newCase.Portal_Inquiry_Type__c='My System Is Not Working';
             SystemNotWorkingUserid=NewCase.Ownerid;
             list<AcctSeed__Project__c>  proj = [select Id,Name, Account__c,Rebate_Status__c,Rebate_ProgramF__c,PTO_Date__c,Rebate_Assigned_To__c,Performance_reporting__c, AcctSeed__Opportunity__r.Utility_Company__c,WATTS_STC__c ,Rebate_Id__c,Rebate_Expiration_Date__c,Closeout_Document__c,owner.Name,ownerId,AcctSeed__Opportunity__c,AcctSeed__Opportunity__r.OwnerId,AcctSeed__Opportunity__r.owner.Name,AcctSeed__Opportunity__r.owner.Email,AcctSeed__Opportunity__r.owner.phone,Branch__c from   AcctSeed__Project__c where  Overall_Project_Status__c!='Dead' and id=:ProjectId];
              
            List<OpportunityContactRole> ListOfContacts;
            
            if(Proj!=null && proj.size()>0){
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
                             where OpportunityId =:proj[0].AcctSeed__Opportunity__c and isPrimary=true];
                             
                      NewCase.Branch__c= proj[0].Branch__c ;                  
            }
            if(ListOfContacts!=null && ListOfContacts.size()>0){
                //NewCase.Contactid=ListOfContacts[0].ContactId;
                //CurrentAccount.TempContact__c=NewCase.Contactid;
               
               // if(ListOfContacts[0].ContactId!=null && ListOfContacts[0].Contact.Email!=null)
                 //       NewCase.Contact.Email=ListOfContacts[0].Contact.Email;
                 
            }
            
        }
        
        system.debug('*****NewCase Branch = ' + NewCase.Branch__c);
        
        NewCase.isPortalCase__c= true;
        return newCase;
    
    }
    
    // Return the list of VIP Contacts associated with the current portal user's Account
    public List<SelectOption> getVIPContacts() {
        List<SelectOption> options = new List<SelectOption>();
        List<Contact> cnList = new List<Contact>();
        User portalUser = new User();
        
        portalUser = [select Id, AccountId from User where Id = :userInfo.getUserId()];
        cnList = [select Id, Name, Email, AccountId, VIP_Contact__c from Contact where AccountId = :portalUser.AccountId and VIP_Contact__c = true];
        if (cnList.size() > 0) {
            for (Contact c : cnList) {
                options.add(new SelectOption(c.Id, c.Name + ' <' + c.Email + '>'));
            }
        }
        return options;
    }
    
    public List<SelectOption> getCaseReasons()
        {
          List<SelectOption> options = new List<SelectOption>();
          
          
          if(NewCase.Portal_Inquiry_Type__c=='General Inquiries/Feedback')
                  return options;
               
          
          
                
           Schema.DescribeFieldResult fieldResult = Case.Reason.getDescribe();
           List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                
           for( Schema.PicklistEntry f : ple)
           {
              options.add(new SelectOption(f.getLabel(), f.getValue()));
           }       
           return options;
        }


        public List<SelectOption> getCaseComponents()
        {
              List<SelectOption> options = new List<SelectOption>();
              
              if(isSystemNotWorking==false)
                  return options;
                    
               Schema.DescribeFieldResult fieldResult = Case.Component__c.getDescribe();
               List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                    
               for( Schema.PicklistEntry f : ple)
               {
                  options.add(new SelectOption(f.getLabel(), f.getValue()));
               }       
               return options;
        }


     public void doNothing(){
     newCase.Reason='';
     newCase.Component__C='';
     isclicked =true;
        if(no==1){
                isSystemNotWorking =true;
                
            }
        else{
                isSystemNotWorking =false;
                 
            }
            
        if(isSystemNotWorking)
               if(SystemNotWorkingUserid!=null) NewCase.Ownerid=SystemNotWorkingUserid;
        else{
                newCase.Ownerid=UserInfo.getUserId();
        }
            
        if(isSystemNotWorking==true){
            getNewCase().Type='Problem';
        }
        else{
            getNewCase().Type='Question';
        }
    }
    
    public pageReference RecSaved(){
       
        return null;
    }

    public pagereference Save(){
        
       
        
        id contactid;
        if(CurrentAccount!=null)contactid=CurrentAccount.TempContact__c;
        NewCase.Contactid=getPortalContactId();
        string branch=NewCase.Branch__C;
        
/*        
        if(isSystemNotWorking){
                id Userid=GetUserId();
                if (UserId!=null) NewCase.Ownerid=UserId;
                else NewCase.Ownerid=UserInfo.getUserId();
                
                NewCase.MailID__c=GetUserEmail();
        }
        else{
                newCase.Ownerid=UserInfo.getUserId();
        }
     
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule= true;
        Case caseToInsert = getNewCase();
        caseToInsert.setOptions(dmo);
        insert caseToInsert;
        
        //insert getNewCase();
        newCase=new case();
        newCase.Accountid=AccountID;
        NewCase.Contactid=contactId;
        NewCase.Branch__C=branch;
        
        if(CurrentAccount!=null)CurrentAccount.TempContact__c =null;
        
        if(isSystemNotWorking==true){
            getNewCase().Type='Problem';
        }
        else{
            getNewCase().Type='Question';
        }
        
        return null;
    }
    
    //test class
   
    
     
     
     public static testMethod void case1() {
     
      
      ASeedAccountingSettingsSetupTest.testDataSetup(); 
    
    
      
        
        //create account
        Account acc = new Account();
        //enter details  
        acc.Name = 'Test Account';
        acc.ShippingCity = 'San Francisco';
        insert acc;
        
        Contact cn = new Contact();
        cn.LastName = 'test';
        cn.Phone = '12312312';
         cn.AccountId = acc .Id;
         cn.VIP_Contact__c=true;
        insert cn;
        
        Contact con = new Contact(LastName = 'Toovich',VIP_Contact__c=true, FirstName='Arana' ,AccountId = acc .Id);
        insert con;
        
        Opportunity opp=New Opportunity(Name='Test Data Trigger',
                         AccountId=acc.Id,
                         StageName='Prospecting',
                         closedate=Date.Today());    
         Insert Opp;            
        
        OpportunityContactRole ocr=new OpportunityContactRole();
        ocr.contactid=con.id;
        ocr.opportunityid=opp.id;
        ocr.isPrimary=true;
        insert ocr;
        
         acc.TempContact__c =con.id;
         update acc;
       
          List<AcctSeed__Project__c> theProjects = new List<AcctSeed__Project__c>();
         for(Integer i = 0; i < 1; i++){
            AcctSeed__Project__c theProject = new AcctSeed__Project__c(Name = 'Knight - 2456'+i,AcctSeed__Opportunity__c = TestMethods.getOpportunity().Id, Account__c =acc .Id, SFDC_Project_Stage__c = 'Sales', 
                      Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                      Job_Number__c = 'TEST_TEST-00-' +i); 
            theProjects.add(theProject);
        }
       
        insert theProjects;
        
        ContactUsPortalController  conus = new ContactUsPortalController();
        conus.getNewCase();
        conus.AccountID=acc.id;
        conus.CurrentAccount=acc;
        conus.Save();
        conus.RecSaved();
        conus.doNothing();
        //conus.GetUserId();
        conus.getCaseReasons();
        conus.getCaseComponents();
        conus.Branch='Berkeley';
        //conus.GetUserId();
         conus.Branch='Boston';
        //conus.GetUserId();
         conus.Branch='San Diego';
        //conus.GetUserId();
        
    }*/
}