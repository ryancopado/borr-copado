//Made inactive 8/7/2018 as part of 2018.07 b Sprint
//Was causing an issue when we were trying to get the Site Installation Type fields to match on the Oppty and Site.
//After removing that field from this Apex Class we realized we no longer need this functionality. 

public with sharing class clsPSDNewAttachment {

/*    Public PSD__c TempPSD{get; set;}
    
    Public string Status{get; set;}
    
    public void clsPSDNewAttachment(){
    
        ID PSDID=ApexPages.currentPage().getParameters().get('id');
        
        TempPSD=[Select ID From PSD__c Where id=:PSDID];
        
        System.debug('PSD__c Value:---'+ TempPSD);
    
    }
    
      public PreSaleDesignAttchment__c FileAttachment{
        get {
          if (FileAttachment == null)
            FileAttachment= new PreSaleDesignAttchment__c();
          return FileAttachment;
        }
        set;
      }

    public Attachment Attachment {
        get {
          if (Attachment == null)
            Attachment = new Attachment ();
          return Attachment ;
        }
        set;
      }

public void AttachFile() {
 
   
    try {
    System.debug('****123'+TempPSD);    
      Attachment.ParentID=ApexPages.currentPage().getParameters().get('id');
      insert Attachment ;
      FileAttachment.AttachmentID__c=Attachment.ID;
 
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
     
    } finally {
      Attachment .body = null; 
      Attachment = new Attachment ();
    }
 
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
   
  }
  
    Public PageReference Done(){
    system.debug('ooooo'+FileAttachment); 
               insert FileAttachment;
    
         ID PSDID=ApexPages.currentPage().getParameters().get('id');
        
        TempPSD=[Select ID From PSD__c Where id=:PSDID];
        
    System.debug('*******'+TempPSD);
        PageReference PageRef=new ApexPages.StandardController(TempPSD).view();
        return PageRef;
        
    }

   static testMethod void Test_clsPSDNewAttachment () {
       User owner = [select Id from User where Name = 'System User'];
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id, of_Sites__c = 1, 
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        opp.StageName = 'Qualified';
        opp.Development_Only__c = 'No';
        opp.Expected_Bid_Date__c = system.today();
        update opp;
        PSD__C TempPSD=new PSD__c();//[Select ID From PSD__c LIMIT 1];
        TempPSD.Opportunity__c=Opp.Id;
        INSERT TempPSD;
        ApexPages.currentPage().getParameters().pUT('id',TempPSD.ID);
        clsPSDNewAttachment CPA=new clsPSDNewAttachment ();
        CPA.AttachFile();
        CPA.Done();
   
   }
*/
}