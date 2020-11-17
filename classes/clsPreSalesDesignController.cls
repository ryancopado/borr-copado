public withOut sharing class clsPreSalesDesignController {

    Public PSD__c PSD { get; set; }

     Public string AttachmentID{get; set;}

    public clsPreSalesDesignController(ApexPages.StandardController controller) {

        PSD=[Select ID, Opportunity__C
                , (Select  CreatedById, CreatedDate, Field, Id, IsDeleted, NewValue, OldValue, ParentId From Histories) 
                FROM PSD__C WHERE ID=:((PSD__C) Controller.GetRecord()).ID];
        
       
    } 
     
    Public List<Attachment> getOpportunityAttachments() {
        
        List<Attachment> ListOfAttachments=new List<Attachment>();
        
        ListOfAttachments = [select Id, Name, OwnerId, CreatedDate from Attachment where ParentId = :PSD.Opportunity__c];    
        
        IF(ListOfAttachments.size() > 0) {
        
          return ListOfAttachments;
        
        } else {
        
          return null;
        
        }
    }
    
 
 
 
 
 
 
 public list<cHistories> getHistories() {
     
     
     // Initialize list to be returned
     list<cHistories> list_ch = new list<cHistories>();
     
    
     
     List<ID> ListOfUserID=NEW List<ID>();
     
     for (PSD__History fh: PSD.Histories) {
     
         ListOfUserID.ADD(fh.CreatedById);
     
     }
     
      Map<Id, User> MapOfUser=new Map<Id, User>([Select id,Name from User where id in :ListOfUserID]);
     
     // Loop through all field history records
     for (PSD__History fh: PSD.Histories) {
   
                       // Create a new wrapper object
                       cHistories ch = new cHistories();
                       
                           ch.PSDHistory =fh;
                           // Set the Date
                           ch.theDate = String.valueOf(fh.createddate.format());
                           
                           // Set who performed the action
                           ch.who = MapOfUser.get(fh.CreatedById);
                           
                           // Set the Action value
                           if (String.valueOf(fh.Field) == 'created') {    // on Creation
                            
                            ch.action = 'Created.';
                            
                           } else if (fh.OldValue != null && fh.NewValue == null){ // when deleting a value from a field
                            
                            // Format the Date and if there's an error, catch it and re
                            try {
                             ch.action = 'Deleted ' + Date.valueOf(fh.OldValue).format() + ' in <b>' + String.valueOf(fh.Field) + '</b>.';
                            } catch (Exception e){
                             ch.action = 'Deleted ' + String.valueOf(fh.OldValue) + ' in <b>' + String.valueOf(fh.Field) + '</b>.';
                            }
                            
                           } else {             // all other scenarios
                            
                            String fromText = '';
                            if (fh.OldValue != null) {
                             try {
                              fromText = ' from ' + Date.valueOf(fh.OldValue).format();
                             } catch (Exception e) {
                              fromText = ' from ' + String.valueOf(fh.OldValue);
                             }
                            }
                            
                            String toText = '';
                            try {
                             toText = ' from ' + Date.valueOf(fh.NewValue).format();
                            } catch (Exception e) {
                             toText = ' from ' + String.valueOf(fh.NewValue);
                            }
                            
                            ch.action = 'Changed <b>' + String.valueOf(fh.Field) + '</b>' + fromText + ' to <b>' + toText + '</b>.';
                            
                           }
                          list_ch.add(ch);    
           
                          }
  
  
  
                      return list_ch;
            }
            
  Public list<CustomAttachment> GetAttachments(){
    
            List<CustomAttachment> ListOfCustomAttachment= new List<CustomAttachment>();
            
            Map<ID,Attachment> MapOfAttachments=new Map<ID,Attachment>();
            
            List<Attachment> ListOfTempAttachment= new List<Attachment>();
            
            //BODY, 
            for (Attachment att:[Select  BodyLength, ContentType, CreatedById
                            , CreatedDate, Id, IsDeleted, IsPrivate, LastModifiedById, LastModifiedDate
                            , Name, OwnerId, ParentId, SystemModstamp From Attachment where ParentID=:PSD.ID 
                            Order by LastModifiedDate desc]){
                                
                                MapOfAttachments.put(att.id,att);
                                ListOfTempAttachment.add(att);
                            }
            
            
            Map<ID,PreSaleDesignAttchment__c  > MapOfFileAttachments=new Map<ID,PreSaleDesignAttchment__c  >();
            
            for(PreSaleDesignAttchment__c  FileAttachment:[Select s.Id, s.AttachmentID__c
                            , s.WorkDesign__c from PreSaleDesignAttchment__c s
                             Where s.AttachmentID__c in :MapOfAttachments.KeySet()  Order by LastModifiedDate]){
             
                 MapOfFileAttachments.Put(FileAttachment.AttachmentID__c,FileAttachment);
                            
            }                
            
            for(Attachment Att:ListOfTempAttachment){
             
                 CustomAttachment CA=NEW CustomAttachment();
                 
                 CA.Attachment=Att;
                 
                 CA.FileAttachment=MapOfFileAttachments.Get(Att.ID);
             
                 ListOfCustomAttachment.Add(CA);
                            
            }   
            
        return ListOfCustomAttachment;
    }

    Public PageReference AttachNewFile(){
    
        PageReference PR=new PageReference('/apex/vfNewAttachment' );
        
        PR.getParameters().Put('id',PSD.id);
        PR.setRedirect(true);
        return PR;
    
    }

 Public Void DeleteAttachment(){
    
            AttachmentID=ApexPages.currentPage().getParameters().get('AttchID');
                      
            Map<ID,Attachment> MapOfAttachments=new Map<ID,Attachment>([Select   BodyLength, ContentType, CreatedById
                            , CreatedDate, Id, IsDeleted, IsPrivate, LastModifiedById, LastModifiedDate
                            , Name, OwnerId, ParentId, SystemModstamp From Attachment where id=:AttachmentID]);
            
            
           
            
             List<PreSaleDesignAttchment__c > ListOfFileAttachment=[Select s.Id, s.AttachmentID__c
                            , s.WorkDesign__c from PreSaleDesignAttchment__c s
                              Where s.AttachmentID__c in :MapOfAttachments.KeySet()];
             
             System.debug('*****'+ ListOfFileAttachment);     
             System.debug('*****'+ MapOfAttachments.values());     
             if (ListOfFileAttachment!=null && ListOfFileAttachment.size()>0)             
                         Delete ListOfFileAttachment;
             
             Delete MapOfAttachments.values();               
                   
    
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
            
            
            
            
    
    public class cHistories {
     
     // Class properties
        public String theDate {get; set;}
        public User who {get; set;}
        public String action {get; set;}
        Public PSD__History PSDHistory {get; set;}
        
    }
    
    static testMethod void Test_clsPreSalesDesignController () {
    
         PSD__c PSD ;

          PSD=[Select ID, Opportunity__C
                , (Select  CreatedById, CreatedDate, Field, Id, IsDeleted, NewValue, OldValue, ParentId From Histories) 
                FROM PSD__C Limit 1];
    
        ApexPages.StandardController Controller=new ApexPages.StandardController(PSD );

        clsPreSalesDesignController clsPreSalesDesignController=new clsPreSalesDesignController(Controller);        
        clsPreSalesDesignController.getOpportunityAttachments();
        clsPreSalesDesignController.getHistories();
        clsPreSalesDesignController.DeleteAttachment();
        clsPreSalesDesignController.AttachNewFile();  
        clsPreSalesDesignController.GetAttachments();                
        
    }
}