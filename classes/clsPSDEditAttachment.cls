public with sharing class clsPSDEditAttachment {

    Public Attachment Attch{get; Set;}
    
    Public PreSaleDesignAttchment__c FileAttachment{get; set;}
    
   public Id AttachId;
    
    Public clsPSDEditAttachment(){
    
        List<Attachment> ListOfAttachment=[Select  BodyLength, ContentType, CreatedById
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
            else{
                FileAttachment=new PreSaleDesignAttchment__c ();
                FileAttachment.AttachmentID__C=AttachId;
               
            }
        
        }
        
    
    }
    Public PageReference CancelAttach(){
    
        PageReference PR=new PageReference('/'+Attch.ParentId );
        
        PR.getParameters().Put('id',Attch.ParentId);
        PR.setRedirect(true);
        return PR;
    
    }
     Public PageReference SaveAttachment(){
     system.debug('!!'+AttachId);
     /*   List<PreSaleDesignAttchment__c >  ListOfFileAttachment=[Select AttachmentID__c,id,WorkDesign__c
                                From PreSaleDesignAttchment__c where AttachmentID__c=:AttachId];

        IF(ListOfFileAttachment.SIZE()>0)                                
            ListOfFileAttachment[0].WorkDesign__c= FileAttachment.WorkDesign__c;
        else{
            PreSaleDesignAttchment__c PreSaleDesignAttchment =new PreSaleDesignAttchment__c ();
            PreSaleDesignAttchment.WorkDesign__c= FileAttachment.WorkDesign__c;
             ListOfFileAttachment.add(PreSaleDesignAttchment);
        }*/
            
        //FileAttachment.AttachmentID__c=ApexPages.currentPage().getParameters().get('id');
        upsert FileAttachment;
        List<Attachment> ListOfAttachment=[Select  BodyLength, ContentType, CreatedById
                            , CreatedDate, Id, IsDeleted, IsPrivate, LastModifiedById, LastModifiedDate
                            , Name, OwnerId, ParentId, SystemModstamp From Attachment 
                            where ID=:AttachId];
        ListOfAttachment[0].Name=Attch.Name;
        Upsert ListOfAttachment;
    
            
        PSD__C PSD=[Select ID From PSD__C Where id=:ListOfAttachment[0].ParentId];
        
    
        PageReference PageRef=new ApexPages.StandardController(PSD).view();
        return PageRef;
        
    }
    
   static testMethod void Test_clsPreSalesDesignController () {
            User owner = [select Id from User where Name = 'System User'];
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        RecordType ContentRT = [select Id FROM RecordType WHERE name='O&M Opportunity'];
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id, of_Sites__c = 1, 
                                    Type = 'Turnkey System',CloseDate = System.today(),RecordTypeId = ContentRT.Id, StageName = 'Prospecting'); 
             // opp.StageName = 'Qualified';
      //  opp.Development_Only__c = 'No';
      //  opp.Expected_Bid_Date__c = system.today();
 
        insert opp;
        opp.StageName = 'Qualified';
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
        clsPSDEditAttachment CPA=new clsPSDEditAttachment ();
        CPA.CancelAttach();
        CPA.SaveAttachment();
   
   }
}