//Made inactive 8/7/2018 as part of 2018.07 b Sprint
//Was causing an issue when we were trying to get the Site Installation Type fields to match on the Oppty and Site.
//After removing that field from this Apex Class we realized we no longer need this functionality. 

public with sharing class clsPSDAttachmentView {

/*    Public Attachment Attch{get; Set;}
    
    Public PreSaleDesignAttchment__c  FileAttachment{get; set;}
    
    public Id AttachId;
    
    Public clsPSDAttachmentView (){
    
        List<Attachment> ListOfAttachment=[Select  BODY, BodyLength, ContentType, CreatedById
                            , CreatedDate, Id, IsDeleted, IsPrivate, LastModifiedById, LastModifiedDate
                            , Name, OwnerId, ParentId, SystemModstamp From Attachment 
                            where ID=:ApexPages.currentPage().getParameters().get('id')];
          AttachId=  ApexPages.currentPage().getParameters().get('id');    
                      
        IF(ListOfAttachment!=null && ListOfAttachment.size()>0){
        
            Attch=ListOfAttachment[0];
            List<PreSaleDesignAttchment__c > ListOfFileAttachment=[Select AttachmentID__c,id,WorkDesign__c
                                From PreSaleDesignAttchment__c where AttachmentID__c=:Attch.id];

            IF(ListOfFileAttachment!=null && ListOfFileAttachment.size()>0)            
                FileAttachment=ListOfFileAttachment[0];                
            else
                FileAttachment=new PreSaleDesignAttchment__c ();
            
       
        }
         
    
    }
    Public PageReference CancelAttach(){
    
    
    
        PageReference PR=new PageReference('/'+Attch.ParentId );
        
        PR.getParameters().Put('id',Attch.ParentId);
        PR.setRedirect(true);
        return PR;
    
    }
     Public PageReference EditAttachment(){
    
       // PageReference PageRef=new ApexPages.StandardController(TempCase);
       // return PageRef;
       return null; 
    }

    static testMethod void Test_clsPSDAttachmentView () {
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
            Attachment att=new Attachment();
            att.ParentId=TempPSD.ID;
            Blob attachBody = Blob.valueOf('attachment body');
            att.Name='Test';
            att.Body=attachBody ;
            insert att;
            
            PreSaleDesignAttchment__c PADA=NEW PreSaleDesignAttchment__c ();
            PADA.AttachmentID__c=att.ID;
            
            
        ApexPages.currentPage().getParameters().pUT('id',att.ID);
        clsPSDAttachmentView CPA=new clsPSDAttachmentView ();
        CPA.CancelAttach();
        CPA.EditAttachment();
    }
*/
}