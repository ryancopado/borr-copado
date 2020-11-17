@isTest 
Private class CommonTest {
     
  public static testMethod Void TestSpecificationTrigger(){
    
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
                   
                    Opportunity opp = new Opportunity(OwnerId = listOfApprover[0].Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                                Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
                    insert opp;
                    
                    
                    SFDC_Project__c[] proj = new SFDC_Project__c[0];
                    proj.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                                    Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                                    Job_Number__c = '000-000', OwnerId = listOfApprover[0].Id)); 
                    insert proj;
                    
                    Spec_Submittal__c spec = new Spec_Submittal__c(Name='testspec',Approvers__c='David Dutil',Project__c = proj.get(0).Id);
                    
                    insert spec;
                    
                    Request_for_Information_RFI__c RIR=new Request_for_Information_RFI__c(Detailed_Description__c='test',Contact__c= cn.id ,   Approver__c='Anne Dunbar' ); 
                    insert RIR;
                     
                     Specification_1__c Spec1= new Specification_1__c (Name='testsubmittal' , Issue_Tracker__c=RIR.ID, Selected_Users__c=listOfApprover[0].id);
                    insert Spec1; 
    
                    Spec1.Status__c='Approved';
                    Update Spec1;
  } 
  
  public static testmethod void testSubmital1SelectedUserCtrl(){
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
                    
                    Submittal_1__c sub = new Submittal_1__c(Name='testsubmittal',Selected_Users__c=owner.Id,Date_Received__c=Date.Today(),status__C='New', Issue_Tracker__c=RIR.ID);
                    insert sub;
                    
                    ApexPages.currentPage().getParameters().put('Id',sub.id);
                    Submital1SelectedUserCtrl UserCtrl=new Submital1SelectedUserCtrl(new ApexPages.StandardController(sub));
                    UserCtrl.Submittal1.Selected_Users__c=listOfApprover[0].id;
                    UserCtrl.save();
  
  }
  
    public static testmethod void testShopDrawingSelectedUserCtrl(){
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
                    
                    Shop_Drawing_1__c shopdr = new Shop_Drawing_1__c(Name='testsubmittal' ,Selected_Users__c=owner.Id,Date_Received__c=Date.Today(),status__C='New', Issue_Tracker__c=RIR.ID);
                    insert shopdr;
                    
                    ApexPages.currentPage().getParameters().put('Id',shopdr.id);
                    ShopDrawingSelectedUserCtrl UserCtrl=new ShopDrawingSelectedUserCtrl(new ApexPages.StandardController(shopdr ));
                    UserCtrl.ShopDrawing.Selected_Users__c=listOfApprover[0].id;
                    UserCtrl.save();
  
  }
  
  
      public static testmethod void testRecordDrawingSelectedUserCtrl (){
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
                    
                    Record_Drawing_1__c shopdr = new Record_Drawing_1__c(Name='testsubmittal',Selected_Users__c=owner.Id,Date_Received__c=Date.Today(),status__C='New', Issue_Tracker__c=RIR.ID);
                    insert shopdr;
                    
                    ApexPages.currentPage().getParameters().put('Id',shopdr.id);                    
                    RecordDrawingSelectedUserCtrl UserCtrl =new RecordDrawingSelectedUserCtrl (new ApexPages.StandardController(shopdr ));
                    UserCtrl.RecordDrawing.Selected_Users__c=listOfApprover[0].id;
                    UserCtrl.save();
  
  }
  
   public static testmethod void testSpecificationSelectedUserCtrl  (){
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
                    
                     Specification_1__c Spec1= new Specification_1__c (Name='testsubmittal' , Selected_Users__c=owner.Id,Issue_Tracker__c=RIR.ID);
                    insert Spec1; 
                    
                    ApexPages.currentPage().getParameters().put('Id',Spec1.id);                    
                    SpecificationSelectedUserCtrl UserCtrl =new SpecificationSelectedUserCtrl (new ApexPages.StandardController(Spec1));
                    UserCtrl.Specification.Selected_Users__c=listOfApprover[0].id;
                    UserCtrl.save();
  
  }
}