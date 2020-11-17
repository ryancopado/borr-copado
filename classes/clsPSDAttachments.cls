public with sharing class clsPSDAttachments {

    Public PSD__c CurrentPSD{get; set;}
    
   Public string AttachmentID{get; set;}
    
    public clsPSDAttachments(ApexPages.StandardController controller) {

        CurrentPSD=[Select c.Id
                    from PSD__C c where c.id=:controller.getrecord().id];
        
    
    }
    
    Public Void DeleteAttachment(){
    
                        
            Map<ID,Attachment> MapOfAttachments=new Map<ID,Attachment>([Select  BODY, BodyLength, ContentType, CreatedById
                            , CreatedDate, Id, IsDeleted, IsPrivate, LastModifiedById, LastModifiedDate
                            , Name, OwnerId, ParentId, SystemModstamp From Attachment where id=:AttachmentID]);
            
            
           
            
             List<PreSaleDesignAttchment__c > ListOfFileAttachment=[Select s.Id, s.AttachmentID__c
                            , s.WorkDesign__c from PreSaleDesignAttchment__c s
                              Where s.AttachmentID__c in :MapOfAttachments.KeySet()];
             
                  
             Delete ListOfFileAttachment;
             
             Delete MapOfAttachments.values();               
                   
    
    }
    
    Public list<CustomAttachment> GetAttachments(){
    
            List<CustomAttachment> ListOfCustomAttachment= new List<CustomAttachment>();
            
            Map<ID,Attachment> MapOfAttachments=new Map<ID,Attachment>([Select  BODY, BodyLength, ContentType, CreatedById
                            , CreatedDate, Id, IsDeleted, IsPrivate, LastModifiedById, LastModifiedDate
                            , Name, OwnerId, ParentId, SystemModstamp From Attachment where ParentID=:CurrentPSD.ID]);
            
            
            Map<ID,PreSaleDesignAttchment__c  > MapOfFileAttachments=new Map<ID,PreSaleDesignAttchment__c  >();
            
            for(PreSaleDesignAttchment__c  FileAttachment:[Select s.Id, s.AttachmentID__c
                            , s.WorkDesign__c from PreSaleDesignAttchment__c s 
                            Where s.AttachmentID__c in :MapOfAttachments.KeySet()]){
             
                 MapOfFileAttachments.Put(FileAttachment.AttachmentID__c,FileAttachment);
                            
            }                
            
            for(Attachment Att:MapOfAttachments.VALUES()){
             
                 CustomAttachment CA=NEW CustomAttachment();
                 
                 CA.Attachment=Att;
                 
                 CA.FileAttachment=MapOfFileAttachments.Get(Att.ID);
             
                 ListOfCustomAttachment.Add(CA);
                            
            }   
            
        return ListOfCustomAttachment;
    }

    Public PageReference AttachNewFile(){
    
        PageReference PR=new PageReference('/apex/vfNewAttachment' );
        
        PR.getParameters().Put('id',CurrentPSD.id);
        PR.setRedirect(true);
        return PR;
    
    }

    Public Class CustomAttachment{

        Public Attachment Attachment{get; Set;}
        
        Public PreSaleDesignAttchment__c  FileAttachment{ Get; Set;}
        
        Public CustomAttachment(){ }
        
        Public CustomAttachment(Attachment Att,PreSaleDesignAttchment__c  FileAtt){ 
            
               Attachment=Att;
               FileAttachment=FileAtt;
            
        }
                
    }
    
    static testMethod void Test_clsPSDAttachments  () {
    
         PSD__c PSD ;

          PSD=[Select ID, Opportunity__C
                , (Select  CreatedById, CreatedDate, Field, Id, IsDeleted, NewValue, OldValue, ParentId From Histories) 
                FROM PSD__C Limit 1];
    
        ApexPages.StandardController Controller=new ApexPages.StandardController(PSD );

        clsPSDAttachments CPA=NEW clsPSDAttachments(Controller);
        
        CPA.DeleteAttachment();
        CPA.GetAttachments();
        CPA.AttachNewFile();       
    
    }
}