global with sharing class batchMigrateAttachments implements Database.Batchable<sObject> {

    global List<sObject> start(Database.BatchableContext batchableContext) {
        
        List<Attachment> theSObjects = new List<Attachment> ();
        
        Integer theBatchLimitupper = Integer.valueOf(Label.batchMigration);
        
        Integer theBatchLimitlower = Integer.valueOf(Label.batchMigrationLow);
        
        List<AcctSeedERP__Purchase_Order__c> pos =[select id, old_PO__c from  AcctSeedERP__Purchase_Order__c where old_PO__c != null];

        List<String> olds = new List<String>();
        
        for(AcctSeedERP__Purchase_Order__c po:pos){
            
            olds.add(po.old_PO__c);
        
        }
        
        
        theSObjects = [Select a.SystemModstamp, a.ParentId,a.Owner.isActive, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById, a.IsPrivate, a.IsDeleted, a.Id, a.Description, a.CreatedDate, a.CreatedById,a.CreatedBy.Name, a.ContentType, a.BodyLength, a.Body FROM Attachment a where a.ParentId in: olds and a.BodyLength >: theBatchLimitlower and a.BodyLength <: theBatchLimitupper];
        
        //theSObjects = [select a.SystemModstamp, a.ParentId,a.Owner.isActive, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById, a.IsPrivate, a.IsDeleted, a.Id, a.Description, a.CreatedDate, a.CreatedById,a.CreatedBy.Name, a.ContentType, a.BodyLength, a.Body From Attachment a  where a.ParentId in( SELECT SFDCProject__c  FROM AcctSeed__Project__c WHERE SFDCProject__c != null) and a.BodyLength >: theBatchLimitlower and a.BodyLength <: theBatchLimitupper];
        
        return theSObjects;
    }

    global void execute(Database.BatchableContext batchableContext, List<Attachment> emailAttachments) {
        
        
        /*Map<String,AcctSeed__Project__c> ASProjMap = new Map<String,AcctSeed__Project__c>();
        for (AcctSeed__Project__c ASProject : [SELECT ID,SFDCProject__c  FROM AcctSeed__Project__c WHERE SFDCProject__c != null]) {
            ASProjMap.put(((String)ASProject.SFDCProject__c).substring(0,15), ASProject);
        }*/
        
        
        Map<String,AcctSeedERP__Purchase_Order__c> ASProjMap = new Map<String,AcctSeedERP__Purchase_Order__c>();
        
        for (AcctSeedERP__Purchase_Order__c po :[select id, old_PO__c from  AcctSeedERP__Purchase_Order__c where old_PO__c != null]) {
            ASProjMap.put(((String)po.old_PO__c).substring(0,15), po);
        }
        

        
        
        User theUser = [select id from User where name = 'System User' limit 1];
        
        List<Attachment> AttachmentsToUpdate = new List<Attachment>();
        for(Attachment theAttachment: emailAttachments){
            if(ASProjMap.containsKey(((String)theAttachment.ParentId).substring(0,15))){
                Attachment newAttachment = theAttachment.clone();
                newAttachment.ParentId = ASProjMap.get(((String)theAttachment.ParentId).substring(0,15)).Id;
                if(theAttachment.Description != null){
                    newAttachment.Description = theAttachment.Description + ':' + theAttachment.CreatedDate + theAttachment.CreatedBy.Name; 
                }else{
                    newAttachment.Description = ':' + theAttachment.CreatedDate + theAttachment.CreatedBy.Name;
                }
                if(!theAttachment.Owner.isActive){
                    newAttachment.OwnerId = theUser.Id;
                }
                
                AttachmentsToUpdate.add(newAttachment);  
            }
        }
        insert AttachmentsToUpdate;
        
        
        
    }

    global void finish(Database.BatchableContext batchableContext) {
        
        
            
    }

}