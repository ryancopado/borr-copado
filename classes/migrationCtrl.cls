public with sharing class migrationCtrl {


    Map<String,AcctSeed__Project__c> ASProjMap;
    
    public Integer theRestCount{get;set;}
    
    public Integer  migrateGLSAssetCount{get;set;}
    
    public Integer  migrateNotesCount{get;set;}
    
    public Integer  migrateAttachmentsCount{get;set;}
        
    public Integer  migrateCustSatisCount{get;set;}
            
    public Integer  migrateSpecSubCount{get;set;}
                    
    public Integer  migrateContractCount{get;set;}
            
    //public Integer  migratePartnerProjectCount{get;set;}
            
    public Integer  migrateContReqCount{get;set;}
        
    public Integer  migrateRFICount{get;set;}   
        
    public Integer  migrateInterconnectionCount{get;set;}
        
    public Integer  migratePermitCount{get;set;}    
        
    public Integer  migrateRebateCount{get;set;}
    
    

    public Pagereference migrateProject(){
        Pagereference destination = null;
        try{
            List<AcctSeed__Project__c> ASprojs = new List<AcctSeed__Project__c>();
            
            
            
            List<SFDC_Project__c> oldProjs = [select CD_on_time__c,Final_approved_QC__c,Handoff_Completed_and_Approved__c,Handoff_Was_Scheduled__c,Initially_Submitted_to_QA__c,Permit_on_time__c,Standard_Project__c, X50_on_time__c,Name,Paperwork_Signed__c,Rebate_Reassigned__c,PPM_Complete__c,Borrego_Received__c,Submit_To_Quality_Assurance__c,Excluded_in_Job_Cost_Reports__c,Pre_Contract__c,Reserved__c,Final_Rebate_Amount__c,Expected_Amount_Federal__c,Final_Amount_Federal__c,SREC_Price__c,Traded_Price__c,Amount__c,Extra_Payment_Amount__c,SFDC_Project_Start_Date__c,SFDC_Project_End_Date__c,Deadline_Date__c,Hand_off_Date__c,Internal_NTP_Baseline__c,Internal_NTP_Date__c,X50_Baseline_Date__c,X50_Forecast_Release_Date__c,X50_Set_Completed__c,Permit_Baseline_Date__c,Permit_Forecast_Release_Date__c,Permit_Set_Completed__c,CD_Baseline_Date__c,CD_Forecast_Release_Date__c,Const_Set_Completed__c,As_Built_Completed__c,X50_Review_Baseline__c,X50_Review_Date__c,Permit_Review_Baseline__c,Permit_Review_Date__c,Const_Review_Baseline__c,Const_Review_Date__c,PTO_Date__c,Interconn_Date__c,Due_Date__c,PPM_Date__c,ICF_Approval_Date__c,ICF_Submission_Date__c,Rebate_Expected_Date__c,Rebate_Received_Date__c,X1st_Payment_Date__c,Rebate_Date__c,Rebate_Expiration_Date__c,Submitted_Date_Federal__c,Approval_Date_Federal__c,NEPOOL_Reg_Approved_Date__c,NEPOOL_Reg_Requested_Date__c,Qtr_1st_SREC_produced_Date__c,Qtr_Submitted_Date__c,SQA_Approved_Date__c,SQA_Submission_Date__c,PV_Detail_Form_Approved_Date__c,PV_Detail_Form_Submission_Date__c,Commencement_Date__c,Date_First_Expected__c,Extra_Payment_Date__c,Commissioning_Date__c,O_M_Handoff_Date__c,Prior_50_Forecast_Date__c,Prior_CD_Forecast_Date__c,Prior_Permit_Forecast_Date__c,Construction_Stage_Change_Date__c,Rebate_Notes__c,Design_Notes__c,Notes_Federal__c,Comments_on_Budget__c,Deadline_Description__c,Account__c,Commissioning_Agent__c,Opportunity__c,OwnerId,EC__c,Trade_Day__c,Internal_NTP_On_Hold_Days__c,kWh_kW_Rating__c,Reserved_KW__c,Final_KW__c,WATTS_STC__c,Number_of_SRECs_Traded__c,Frequency_days__c,PC_Code__c,Branch__c,SFDC_Project_Status__c,SFDC_Project_Stage__c,Design_Stage__c,Revenue_Year__c,Modules_Status__c,Inverter_Status__c,Racking_Status__c,Racking_Type__c,Senior_Design_Engineer__c,Reviewer__c,Design_Subcontractor__c,Interconnection_Status__c,Rebate_Status__c,Rebate_Assigned_To__c,PBI_Payment_Cycle__c,App_Fee_Paid_By__c,Fed_Rebate_Status__c,Grant_Assigned_To_Federal__c,Lease_Payment_Status__c,Contingent_Upon_Commencement__c,Payment_Plan__c,Commissioning_Status__c,O_M_Handoff_Status__c,DAS_Vendor__c,SFDC_Status_Description__c,Job_Number__c,Electrical_Engineer__c,Structural_Engineer__c,Comments_on_Schedule__c,Incentive__c,Next_Steps__c,SREC_Purchaser__c,Trade_Off_taker__c,Trade_Quarter__c,Foreman__c,Rebate_Id__c,Picasa_Album__c 
                                            from SFDC_Project__c where recordType.Name = 'Commercial Project' and Id not in (select SFDCProject__c from AcctSeed__Project__c) limit 300];
            
            for(SFDC_Project__c oldProj:oldProjs){
                AcctSeed__Project__c newProj = new AcctSeed__Project__c();
                copyProject (newProj,oldProj);
                newProj.SFDCProject__c = oldProj.Id;
                ASprojs.add(newProj);
            }
            
            insert ASprojs;
            String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    
    public migrationCtrl(){
        
        
        list<String> notinHere = new list<String>();
        for( SFDC_Project__c thesfdc:[select id from SFDC_Project__c where recordType.Name != 'Commercial Project' ]){
        
            notinHere.add(thesfdc.Id);
        
        }
       
        
        //theRestCount =  [select ID from SFDC_Project__c where recordType.Name = 'Commercial Project' and Id not in (select SFDCProject__c from AcctSeed__Project__c)].size();
        theRestCount = 0;
        //if(theRestCount == 0){
        
         
            migrateGLSAssetCount =  [select ASProject__c, Project__c from GLC_Asset__c where Project__c != null and ASProject__c = null and Project__c not in:notinHere].size();    
    
            migrateCustSatisCount = [select ASProject__c, Project__c from Customer_Satisfaction__c where Project__c != null and ASProject__c = null and Project__c not in:notinHere].size();
    
            migrateSpecSubCount =   [select ASProject__c, Project__c from Spec_Submittal__c where Project__c != null and ASProject__c = null and Project__c not in:notinHere].size();
        
            migrateContractCount =  [select ASProject__c, Project__c from Contract where Project__c != null and ASProject__c = null and Project__c not in:notinHere].size();
        
            //migratePartnerProjectCount =    [select ASProject__c, ProjectId__c from ProjectPartner__c where ProjectId__c != null and ASProject__c = null and ProjectId__c not in:notinHere].size();
    
            migrateContReqCount =   [select ASProject__c, Project__c from Con_Req__c where Project__c != null and ASProject__c = null  and (recordType.Name = 'Change Order' OR recordType.Name = 'Subcontractor Change Order' ) and Project__c not in:notinHere].size();
    
            migrateRFICount =   [select ASProject__c, Project__c from Request_for_Information_RFI__c where Project__c != null and ASProject__c = null and Project__c not in:notinHere].size();
    
            migrateInterconnectionCount =   [select ASProject__c, Project__c from Interconnection_Application__c where Project__c != null and ASProject__c = null and Project__c not in:notinHere].size();
    
            migratePermitCount =    [select ASProject__c, Project__c from Permit_PJ__c where Project__c != null and ASProject__c = null and Project__c not in:notinHere].size();
    
            migrateRebateCount =    [select ASProject__c, Project__c from Rebate_Request__c where Project__c != null and ASProject__c = null and Project__c not in:notinHere].size();
        
            ASProjMap = new Map<String,AcctSeed__Project__c>();
            for (AcctSeed__Project__c ASProject : [SELECT ID,SFDCProject__c  FROM AcctSeed__Project__c WHERE SFDCProject__c != null]) {
                ASProjMap.put(((String)ASProject.SFDCProject__c).substring(0,15), ASProject);
            }
            
            
            //migrateNotesCount = 1;
            
            
            //migrateAttachmentsCount = 1;
            
            
            System.debug(ASProjMap.values().size());
            
            if([select n.id From Note n  where n.ParentId in (select id from AcctSeed__Project__c )].size() ==0){
                migrateNotesCount = [select n.id From Note n  where n.ParentId in: ASProjMap.keyset()].size();
            }else{
                migrateNotesCount = 0;
            }
            
            
             if([select n.id From Attachment n  where n.ParentId in (select id from AcctSeed__Project__c )].size() ==0){
                migrateAttachmentsCount = [select n.id From Attachment n  where n.ParentId in: ASProjMap.keyset()].size();
            }else{
                migrateAttachmentsCount = 0;
            }
            
        //}
    }
    
    
    
   public Pagereference migrateforeman(){
        Pagereference destination = null;
        try{
            map<String,List<AcctSeed__Project__c>> theids = new map<String,List<AcctSeed__Project__c>>();
            List<AcctSeed__Project__c> theASprojs = [select id,foreman__c,foremanText__c,Internal_Electrical_Contact__c from AcctSeed__Project__c];
            
            for(AcctSeed__Project__c thepro:theASprojs){
                if(thepro.Internal_Electrical_Contact__c != null){
                    thepro.foremanText__c = thepro.Internal_Electrical_Contact__c;
                    thepro.Internal_Electrical_Contact__c = '';
                    if(!theids.containsKey(thepro.foremanText__c)){
                        theids.put(thepro.foremanText__c,new List<AcctSeed__Project__c>());
                    }
                    theids.get(thepro.foremanText__c).add(thepro);
                }
            }
        
            List<user> theUsers = [select id,name from user where name in:theids.keyset() ];        
            
            for(user theUser:theUsers){
                if(theids.containsKey(theUser.name)){
                    for(AcctSeed__Project__c thepro2:theids.get(theUser.name)){
                        thepro2.foreman__c = theUser.Id;
                    }
                }
            }
            
            List<AcctSeed__Project__c> toUpdate = new List<AcctSeed__Project__c>();
            for(List<AcctSeed__Project__c> theProList:theids.values()){
                toUpdate.addAll(theProList);
            }
            update toUpdate;
            
            String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
        
    }
    public Pagereference migrateGLSAsset(){
        Pagereference destination = null;
        try{
        List<GLC_Asset__c> relateds10 = [select ASProject__c, Project__c from GLC_Asset__c where Project__c != null and ASProject__c = null];   
        for(GLC_Asset__c rr: relateds10){
            if(ASProjMap.containsKey(((String)rr.Project__c).substring(0,15))){
                rr.ASProject__c = ASProjMap.get(((String)rr.Project__c).substring(0,15)).Id;
            }
        }
        update relateds10;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    
    
    public Pagereference migrateAttachments(){
        Pagereference destination = null;
        try{
            User theUser = [select id from User where name = 'System User' limit 1];
            List<Attachment> AttachmentsToUpdate = new List<Attachment>();
            System.debug(ASProjMap.keyset());
            List<Attachment> Attachments = [select a.SystemModstamp, a.ParentId,a.Owner.isActive, a.OwnerId, a.Name, a.LastModifiedDate, a.LastModifiedById, a.IsPrivate, a.IsDeleted, a.Id, a.Description, a.CreatedDate, a.CreatedById,a.CreatedBy.Name, a.ContentType, a.BodyLength, a.Body From Attachment a  where a.ParentId in: ASProjMap.keyset()];
            for(Attachment theAttachment: Attachments){
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
            String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    
    public Pagereference migrateNotes(){
        Pagereference destination = null;
        try{
            User theUser = [select id from User where name = 'System User' limit 1];
            List<Note> notesToUpdate = new List<Note>();
            System.debug(ASProjMap.keyset());
            List<Note> notes = [select n.Title, n.SystemModstamp, n.ParentId, n.OwnerId,n.Owner.isActive, n.LastModifiedDate, n.LastModifiedById, n.IsPrivate, n.IsDeleted, n.Id, n.CreatedBy.Name, n.CreatedDate, n.CreatedById, n.Body From Note n  where n.ParentId in: ASProjMap.keyset()];
            for(Note theNote: notes){
                if(ASProjMap.containsKey(((String)theNote.ParentId).substring(0,15))){
                    Note newNote = theNote.clone();
                    newNote.ParentId = ASProjMap.get(((String)theNote.ParentId).substring(0,15)).Id;
                    newNote.Body = newNote.Body + ':'+theNote.CreatedDate + newNote.CreatedBy.Name;
                    if(!theNote.Owner.isActive){
                        newNote.OwnerId = theUser.Id;
                    }
                    notesToUpdate.add(newNote);  
                }
            }
            insert notesToUpdate;
            String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    
    public Pagereference migrateCustSatis(){
        Pagereference destination = null;
        try{
        List<Customer_Satisfaction__c> relateds19 = [select ASProject__c, Project__c from Customer_Satisfaction__c where Project__c != null and ASProject__c = null];
        for(Customer_Satisfaction__c rr: relateds19){
            if(ASProjMap.containsKey(((String)rr.Project__c).substring(0,15))){
                rr.ASProject__c = ASProjMap.get(((String)rr.Project__c).substring(0,15)).Id;
            }
        }
        update relateds19;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    public Pagereference migrateSpecSub(){
        Pagereference destination = null;
        try{
        List<Spec_Submittal__c> relateds18 =    [select ASProject__c, Project__c from Spec_Submittal__c where Project__c != null and ASProject__c = null];
        for(Spec_Submittal__c rr: relateds18){
            if(ASProjMap.containsKey(((String)rr.Project__c).substring(0,15))){
                rr.ASProject__c = ASProjMap.get(((String)rr.Project__c).substring(0,15)).Id;
            }
        }
        update relateds18;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    public Pagereference migrateContract(){
        Pagereference destination = null;
        try{
        List<Contract> relateds17 = [select ASProject__c, Project__c from Contract where Project__c != null and ASProject__c = null];
        for(Contract rr: relateds17){
            if(ASProjMap.containsKey(((String)rr.Project__c).substring(0,15))){
                rr.ASProject__c = ASProjMap.get(((String)rr.Project__c).substring(0,15)).Id;
            }
        }
        update relateds17;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    /*
    public Pagereference migratePartnerProject(){
        Pagereference destination = null;
        try{
        List<ProjectPartner__c> relateds16 =    [select ASProject__c, ProjectId__c from ProjectPartner__c where ProjectId__c != null and ASProject__c = null];
        for(ProjectPartner__c rr: relateds16){
            if(ASProjMap.containsKey(((String)rr.ProjectId__c).substring(0,15))){
                rr.ASProject__c = ASProjMap.get(((String)rr.ProjectId__c).substring(0,15)).Id;
            }
        }
        update relateds16;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    */
    
    public Pagereference migrateContReq(){
        Pagereference destination = null;
        try{
        List<Con_Req__c> relateds15 =   [select ASProject__c, Project__c from Con_Req__c where Project__c != null and (recordType.Name = 'Change Order' OR recordType.Name = 'Subcontractor Change Order' ) and ASProject__c = null];
        
        for(Con_Req__c rr: relateds15){
            if(ASProjMap.containsKey(((String)rr.Project__c).substring(0,15))){
                rr.ASProject__c = ASProjMap.get(((String)rr.Project__c).substring(0,15)).Id;
            }
        }
        update relateds15;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    public Pagereference migrateRFI(){
        Pagereference destination = null;
        try{
        List<Request_for_Information_RFI__c> relateds14 =   [select ASProject__c, Project__c from Request_for_Information_RFI__c where Project__c != null and ASProject__c = null];
        for(Request_for_Information_RFI__c rr: relateds14){
            if(ASProjMap.containsKey(((String)rr.Project__c).substring(0,15))){
                rr.ASProject__c = ASProjMap.get(((String)rr.Project__c).substring(0,15)).Id;
            }
        }
        update relateds14;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    public Pagereference migrateInterconnection(){
        Pagereference destination = null;
        try{
        List<Interconnection_Application__c> relateds13 =   [select ASProject__c, Project__c from Interconnection_Application__c where Project__c != null and ASProject__c = null];
        
        for(Interconnection_Application__c rr: relateds13){
            if(ASProjMap.containsKey(((String)rr.Project__c).substring(0,15))){
                rr.ASProject__c = ASProjMap.get(((String)rr.Project__c).substring(0,15)).Id;
            }
        }
        update relateds13;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    public Pagereference migratePermit(){
        Pagereference destination = null;
        try{
        List<Permit_PJ__c> relateds12 = [select ASProject__c, Project__c from Permit_PJ__c where Project__c != null and ASProject__c = null];
        
        for(Permit_PJ__c rr: relateds12){
            System.debug('here is the id' +((String)((String)rr.Project__c).substring(0,15)).substring(0,15) );
            if(ASProjMap.containsKey(((String)((String)rr.Project__c).substring(0,15)).substring(0,15))){
                System.debug('I am in' );
                rr.ASProject__c = ASProjMap.get(((String)rr.Project__c).substring(0,15)).Id;
            }
        }
        update relateds12;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    
    public Pagereference migrateRebate(){
        Pagereference destination = null;
        try{
        
        List<Rebate_Request__c> relateds1 = [select ASProject__c, Project__c from Rebate_Request__c where Project__c != null and ASProject__c = null];
    
        for(Rebate_Request__c rr: relateds1){
            if(ASProjMap.containsKey(((String)rr.Project__c).substring(0,15))){
                rr.ASProject__c = ASProjMap.get(((String)rr.Project__c).substring(0,15)).Id;
            }
        }
        update relateds1;
        String strDest = '/apex/projectmigration';
            destination = new ApexPages.PageReference(strDest);
            destination.setRedirect(true);
    }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
        }
        return destination;
    }
    

    public void copyProject (AcctSeed__Project__c newProject,SFDC_Project__c oldProject){
        
        /*newProject.Name = (oldProject.Name == null ? null:oldProject.Name);
        
        
        newProject.Paperwork_Signed__c= (oldProject.Paperwork_Signed__c == null ? null:oldProject.Paperwork_Signed__c);
        newProject.Commissioning_Status__c = (oldProject.Commissioning_Status__c == null ? null:oldProject.Commissioning_Status__c);
        newProject.Final_approved_QC__c = (oldProject.Final_approved_QC__c == null ? null:oldProject.Final_approved_QC__c);
        newProject.Handoff_Completed_and_Approved__c = (oldProject.Handoff_Completed_and_Approved__c == null ? null:oldProject.Handoff_Completed_and_Approved__c);
        newProject.Handoff_Was_Scheduled__c = (oldProject.Handoff_Was_Scheduled__c == null ? null:oldProject.Handoff_Was_Scheduled__c);
        newProject.Initially_Submitted_to_QA__c = (oldProject.Initially_Submitted_to_QA__c == null ? null:oldProject.Initially_Submitted_to_QA__c);
        newProject.Standard_Project__c = (oldProject.Standard_Project__c == null ? null:oldProject.Standard_Project__c);
        
        newProject.Rebate_Reassigned__c= (oldProject.Rebate_Reassigned__c == null ? null:oldProject.Rebate_Reassigned__c);
        newProject.PPM_Complete__c= (oldProject.PPM_Complete__c == null ? null:oldProject.PPM_Complete__c);
        newProject.Borrego_Received__c= (oldProject.Borrego_Received__c == null ? null:oldProject.Borrego_Received__c);
        newProject.Submit_To_Quality_Assurance__c= (oldProject.Submit_To_Quality_Assurance__c == null ? null:oldProject.Submit_To_Quality_Assurance__c);
        newProject.Excluded_in_Job_Cost_Reports__c= (oldProject.Excluded_in_Job_Cost_Reports__c == null ? null:oldProject.Excluded_in_Job_Cost_Reports__c);
        newProject.Pre_Contract__c= (oldProject.Pre_Contract__c == null ? null:oldProject.Pre_Contract__c);
        newProject.Reserved__c= (oldProject.Reserved__c == null ? null:oldProject.Reserved__c);
        newProject.Final_Rebate_Amount__c= (oldProject.Final_Rebate_Amount__c == null ? null:oldProject.Final_Rebate_Amount__c);
        newProject.Expected_Amount_Federal__c= (oldProject.Expected_Amount_Federal__c == null ? null:oldProject.Expected_Amount_Federal__c);
        newProject.Final_Amount_Federal__c= (oldProject.Final_Amount_Federal__c == null ? null:oldProject.Final_Amount_Federal__c);
        newProject.SREC_Price__c= (oldProject.SREC_Price__c == null ? null:oldProject.SREC_Price__c);
        newProject.Traded_Price__c= (oldProject.Traded_Price__c == null ? null:oldProject.Traded_Price__c);
        newProject.Amount__c= (oldProject.Amount__c == null ? null:oldProject.Amount__c);
        newProject.Extra_Payment_Amount__c= (oldProject.Extra_Payment_Amount__c == null ? null:oldProject.Extra_Payment_Amount__c);
        newProject.SFDC_Project_Start_Date__c= (oldProject.SFDC_Project_Start_Date__c == null ? null:oldProject.SFDC_Project_Start_Date__c);
        newProject.SFDC_Project_End_Date__c= (oldProject.SFDC_Project_End_Date__c == null ? null:oldProject.SFDC_Project_End_Date__c);
        newProject.Deadline_Date__c= (oldProject.Deadline_Date__c == null ? null:oldProject.Deadline_Date__c);
        newProject.Hand_off_Date__c= (oldProject.Hand_off_Date__c == null ? null:oldProject.Hand_off_Date__c);
        newProject.Internal_NTP_Baseline__c= (oldProject.Internal_NTP_Baseline__c == null ? null:oldProject.Internal_NTP_Baseline__c);
        newProject.Internal_NTP_Date__c= (oldProject.Internal_NTP_Date__c == null ? null:oldProject.Internal_NTP_Date__c);
        newProject.X50_Baseline_Date__c= (oldProject.X50_Baseline_Date__c == null ? null:oldProject.X50_Baseline_Date__c);
        newProject.X50_Forecast_Release_Date__c= (oldProject.X50_Forecast_Release_Date__c == null ? null:oldProject.X50_Forecast_Release_Date__c);
        newProject.X50_Set_Completed__c= (oldProject.X50_Set_Completed__c == null ? null:oldProject.X50_Set_Completed__c);
        newProject.Permit_Baseline_Date__c= (oldProject.Permit_Baseline_Date__c == null ? null:oldProject.Permit_Baseline_Date__c);
        newProject.Permit_Forecast_Release_Date__c= (oldProject.Permit_Forecast_Release_Date__c == null ? null:oldProject.Permit_Forecast_Release_Date__c);
        newProject.Permit_Set_Completed__c= (oldProject.Permit_Set_Completed__c == null ? null:oldProject.Permit_Set_Completed__c);
        newProject.CD_Baseline_Date__c= (oldProject.CD_Baseline_Date__c == null ? null:oldProject.CD_Baseline_Date__c);
        newProject.CD_Forecast_Release_Date__c= (oldProject.CD_Forecast_Release_Date__c == null ? null:oldProject.CD_Forecast_Release_Date__c);
        newProject.Const_Set_Completed__c= (oldProject.Const_Set_Completed__c == null ? null:oldProject.Const_Set_Completed__c);
        newProject.As_Built_Completed__c= (oldProject.As_Built_Completed__c == null ? null:oldProject.As_Built_Completed__c);
        newProject.X50_Review_Baseline__c= (oldProject.X50_Review_Baseline__c == null ? null:oldProject.X50_Review_Baseline__c);
        newProject.X50_Review_Date__c= (oldProject.X50_Review_Date__c == null ? null:oldProject.X50_Review_Date__c);
        newProject.Permit_Review_Baseline__c= (oldProject.Permit_Review_Baseline__c == null ? null:oldProject.Permit_Review_Baseline__c);
        newProject.Permit_Review_Date__c= (oldProject.Permit_Review_Date__c == null ? null:oldProject.Permit_Review_Date__c);
        newProject.Const_Review_Baseline__c= (oldProject.Const_Review_Baseline__c == null ? null:oldProject.Const_Review_Baseline__c);
        newProject.Const_Review_Date__c= (oldProject.Const_Review_Date__c == null ? null:oldProject.Const_Review_Date__c);
        newProject.PTO_Date__c= (oldProject.PTO_Date__c == null ? null:oldProject.PTO_Date__c);
        newProject.Interconn_Date__c= (oldProject.Interconn_Date__c == null ? null:oldProject.Interconn_Date__c);
        newProject.Due_Date__c= (oldProject.Due_Date__c == null ? null:oldProject.Due_Date__c);
        newProject.PPM_Date__c= (oldProject.PPM_Date__c == null ? null:oldProject.PPM_Date__c);
        newProject.ICF_Approval_Date__c= (oldProject.ICF_Approval_Date__c == null ? null:oldProject.ICF_Approval_Date__c);
        newProject.ICF_Submission_Date__c= (oldProject.ICF_Submission_Date__c == null ? null:oldProject.ICF_Submission_Date__c);
        newProject.Rebate_Expected_Date__c= (oldProject.Rebate_Expected_Date__c == null ? null:oldProject.Rebate_Expected_Date__c);
        newProject.Rebate_Received_Date__c= (oldProject.Rebate_Received_Date__c == null ? null:oldProject.Rebate_Received_Date__c);
        newProject.X1st_Payment_Date__c= (oldProject.X1st_Payment_Date__c == null ? null:oldProject.X1st_Payment_Date__c);
        newProject.Rebate_Date__c= (oldProject.Rebate_Date__c == null ? null:oldProject.Rebate_Date__c);
        newProject.Rebate_Expiration_Date__c= (oldProject.Rebate_Expiration_Date__c == null ? null:oldProject.Rebate_Expiration_Date__c);
        newProject.Submitted_Date_Federal__c= (oldProject.Submitted_Date_Federal__c == null ? null:oldProject.Submitted_Date_Federal__c);
        newProject.Approval_Date_Federal__c= (oldProject.Approval_Date_Federal__c == null ? null:oldProject.Approval_Date_Federal__c);
        newProject.NEPOOL_Reg_Approved_Date__c= (oldProject.NEPOOL_Reg_Approved_Date__c == null ? null:oldProject.NEPOOL_Reg_Approved_Date__c);
        newProject.NEPOOL_Reg_Requested_Date__c= (oldProject.NEPOOL_Reg_Requested_Date__c == null ? null:oldProject.NEPOOL_Reg_Requested_Date__c);
        newProject.Qtr_1st_SREC_produced_Date__c= (oldProject.Qtr_1st_SREC_produced_Date__c == null ? null:oldProject.Qtr_1st_SREC_produced_Date__c);
        newProject.Qtr_Submitted_Date__c= (oldProject.Qtr_Submitted_Date__c == null ? null:oldProject.Qtr_Submitted_Date__c);
        newProject.SQA_Approved_Date__c= (oldProject.SQA_Approved_Date__c == null ? null:oldProject.SQA_Approved_Date__c);
        newProject.SQA_Submission_Date__c= (oldProject.SQA_Submission_Date__c == null ? null:oldProject.SQA_Submission_Date__c);
        newProject.PV_Detail_Form_Approved_Date__c= (oldProject.PV_Detail_Form_Approved_Date__c == null ? null:oldProject.PV_Detail_Form_Approved_Date__c);
        newProject.PV_Detail_Form_Submission_Date__c= (oldProject.PV_Detail_Form_Submission_Date__c == null ? null:oldProject.PV_Detail_Form_Submission_Date__c);
        newProject.Commencement_Date__c= (oldProject.Commencement_Date__c == null ? null:oldProject.Commencement_Date__c);
        newProject.Date_First_Expected__c= (oldProject.Date_First_Expected__c == null ? null:oldProject.Date_First_Expected__c);
        newProject.Extra_Payment_Date__c= (oldProject.Extra_Payment_Date__c == null ? null:oldProject.Extra_Payment_Date__c);
        newProject.Commissioning_Date__c= (oldProject.Commissioning_Date__c == null ? null:oldProject.Commissioning_Date__c);
        newProject.O_M_Handoff_Date__c= (oldProject.O_M_Handoff_Date__c == null ? null:oldProject.O_M_Handoff_Date__c);
        newProject.Prior_50_Forecast_Date__c= (oldProject.Prior_50_Forecast_Date__c == null ? null:oldProject.Prior_50_Forecast_Date__c);
        newProject.Prior_CD_Forecast_Date__c= (oldProject.Prior_CD_Forecast_Date__c == null ? null:oldProject.Prior_CD_Forecast_Date__c);
        newProject.Prior_Permit_Forecast_Date__c= (oldProject.Prior_Permit_Forecast_Date__c == null ? null:oldProject.Prior_Permit_Forecast_Date__c);
        newProject.Construction_Stage_Change_Date__c= (oldProject.Construction_Stage_Change_Date__c == null ? null:oldProject.Construction_Stage_Change_Date__c);
        newProject.Rebate_Notes__c= (oldProject.Rebate_Notes__c == null ? null:oldProject.Rebate_Notes__c);
        newProject.Design_Notes__c= (oldProject.Design_Notes__c == null ? null:oldProject.Design_Notes__c);
        newProject.Notes_Federal__c= (oldProject.Notes_Federal__c == null ? null:oldProject.Notes_Federal__c);
        newProject.Comments_on_Budget__c= (oldProject.Comments_on_Budget__c == null ? null:oldProject.Comments_on_Budget__c);
        newProject.Deadline_Description__c= (oldProject.Deadline_Description__c == null ? null:oldProject.Deadline_Description__c);
        newProject.Account__c= (oldProject.Account__c == null ? null:oldProject.Account__c);
        newProject.Commissioning_Agent__c= (oldProject.Commissioning_Agent__c == null ? null:oldProject.Commissioning_Agent__c);
        newProject.AcctSeed__Opportunity__c= (oldProject.Opportunity__c == null ? null:oldProject.Opportunity__c);
        newProject.OwnerId= (oldProject.OwnerId == null ? null:oldProject.OwnerId);
        newProject.EC__c= (oldProject.EC__c == null ? null:oldProject.EC__c);
        newProject.Trade_Day__c= (oldProject.Trade_Day__c == null ? null:oldProject.Trade_Day__c);
        newProject.Internal_NTP_On_Hold_Days__c= (oldProject.Internal_NTP_On_Hold_Days__c == null ? null:oldProject.Internal_NTP_On_Hold_Days__c);
        newProject.kWh_kW_Rating__c= (oldProject.kWh_kW_Rating__c == null ? null:oldProject.kWh_kW_Rating__c);
        newProject.Reserved_KW__c= (oldProject.Reserved_KW__c == null ? null:oldProject.Reserved_KW__c);
        newProject.Final_KW__c= (oldProject.Final_KW__c == null ? null:oldProject.Final_KW__c);
        newProject.WATTS_STC__c= (oldProject.WATTS_STC__c == null ? null:oldProject.WATTS_STC__c);
        newProject.Number_of_SRECs_Traded__c= (oldProject.Number_of_SRECs_Traded__c == null ? null:oldProject.Number_of_SRECs_Traded__c);
        newProject.Frequency_days__c= (oldProject.Frequency_days__c == null ? null:oldProject.Frequency_days__c);
        newProject.PC_Code__c= (oldProject.PC_Code__c == null ? null:oldProject.PC_Code__c);
        newProject.Branch__c= (oldProject.Branch__c == null ? null:oldProject.Branch__c);
        newProject.AcctSeed__Status__c= (oldProject.SFDC_Project_Status__c == null ? null:oldProject.SFDC_Project_Status__c);
        newProject.SFDC_Project_Stage__c= (oldProject.SFDC_Project_Stage__c == null ? null:oldProject.SFDC_Project_Stage__c);
        newProject.Design_Stage__c= (oldProject.Design_Stage__c == null ? null:oldProject.Design_Stage__c);
        newProject.Revenue_Year__c= (oldProject.Revenue_Year__c == null ? null:oldProject.Revenue_Year__c);
        newProject.Modules_Status__c= (oldProject.Modules_Status__c == null ? null:oldProject.Modules_Status__c);
        newProject.Inverter_Status__c= (oldProject.Inverter_Status__c == null ? null:oldProject.Inverter_Status__c);
        newProject.Racking_Status__c= (oldProject.Racking_Status__c == null ? null:oldProject.Racking_Status__c);
        newProject.Racking_Type__c= (oldProject.Racking_Type__c == null ? null:oldProject.Racking_Type__c);
        newProject.Senior_Design_Engineer__c= (oldProject.Senior_Design_Engineer__c == null ? null:oldProject.Senior_Design_Engineer__c);
        newProject.Reviewer__c= (oldProject.Reviewer__c == null ? null:oldProject.Reviewer__c);
        newProject.Design_Subcontractor__c= (oldProject.Design_Subcontractor__c == null ? null:oldProject.Design_Subcontractor__c);
        newProject.Interconnection_Status__c= (oldProject.Interconnection_Status__c == null ? null:oldProject.Interconnection_Status__c);
        newProject.Rebate_Status__c= (oldProject.Rebate_Status__c == null ? null:oldProject.Rebate_Status__c);
        newProject.Rebate_Assigned_To__c= (oldProject.Rebate_Assigned_To__c == null ? null:oldProject.Rebate_Assigned_To__c);
        newProject.PBI_Payment_Cycle__c= (oldProject.PBI_Payment_Cycle__c == null ? null:oldProject.PBI_Payment_Cycle__c);
        newProject.App_Fee_Paid_By__c= (oldProject.App_Fee_Paid_By__c == null ? null:oldProject.App_Fee_Paid_By__c);
        newProject.Fed_Rebate_Status__c= (oldProject.Fed_Rebate_Status__c == null ? null:oldProject.Fed_Rebate_Status__c);
        newProject.Grant_Assigned_To_Federal__c= (oldProject.Grant_Assigned_To_Federal__c == null ? null:oldProject.Grant_Assigned_To_Federal__c);
        newProject.Lease_Payment_Status__c= (oldProject.Lease_Payment_Status__c == null ? null:oldProject.Lease_Payment_Status__c);
        newProject.Contingent_Upon_Commencement__c= (oldProject.Contingent_Upon_Commencement__c == null ? null:oldProject.Contingent_Upon_Commencement__c);
        newProject.Payment_Plan__c= (oldProject.Payment_Plan__c == null ? null:oldProject.Payment_Plan__c);
        newProject.Commissioning_Status__c= (oldProject.Commissioning_Status__c == null ? null:oldProject.Commissioning_Status__c);
        newProject.O_M_Handoff_Status__c= (oldProject.O_M_Handoff_Status__c == null ? null:oldProject.O_M_Handoff_Status__c);
        newProject.DAS_Vendor__c= (oldProject.DAS_Vendor__c == null ? null:oldProject.DAS_Vendor__c);
        newProject.SFDC_Status_Description__c= (oldProject.SFDC_Status_Description__c == null ? null:oldProject.SFDC_Status_Description__c);
        newProject.Job_Number__c= (oldProject.Job_Number__c == null ? null:oldProject.Job_Number__c);
        newProject.Electrical_Engineer__c= (oldProject.Electrical_Engineer__c == null ? null:oldProject.Electrical_Engineer__c);
        newProject.Structural_Engineer__c= (oldProject.Structural_Engineer__c == null ? null:oldProject.Structural_Engineer__c);
        newProject.Comments_on_Schedule__c= (oldProject.Comments_on_Schedule__c == null ? null:oldProject.Comments_on_Schedule__c);
        newProject.Incentive__c= (oldProject.Incentive__c == null ? null:oldProject.Incentive__c);
        newProject.Next_Steps__c= (oldProject.Next_Steps__c == null ? null:oldProject.Next_Steps__c);
        newProject.SREC_Purchaser__c= (oldProject.SREC_Purchaser__c == null ? null:oldProject.SREC_Purchaser__c);
        newProject.Trade_Off_taker__c= (oldProject.Trade_Off_taker__c == null ? null:oldProject.Trade_Off_taker__c);
        newProject.Trade_Quarter__c= (oldProject.Trade_Quarter__c == null ? null:oldProject.Trade_Quarter__c);
        newProject.Foreman__c= (oldProject.Foreman__c == null ? null:oldProject.Foreman__c);
        newProject.Rebate_Id__c= (oldProject.Rebate_Id__c == null ? null:oldProject.Rebate_Id__c);
        newProject.Picasa_Album__c= (oldProject.Picasa_Album__c == null ? null:oldProject.Picasa_Album__c);
        
        
        
        
        //setFields(newProject.Name,oldProject.Name);
        setFields(newProject.Paperwork_Signed__c,oldProject.Paperwork_Signed__c);
        setFields(newProject.Rebate_Reassigned__c,oldProject.Rebate_Reassigned__c);
        setFields(newProject.PPM_Complete__c,oldProject.PPM_Complete__c);
        setFields(newProject.Borrego_Received__c,oldProject.Borrego_Received__c);
        setFields(newProject.Submit_To_Quality_Assurance__c,oldProject.Submit_To_Quality_Assurance__c);
        setFields(newProject.Excluded_in_Job_Cost_Reports__c,oldProject.Excluded_in_Job_Cost_Reports__c);
        setFields(newProject.Pre_Contract__c,oldProject.Pre_Contract__c);
        setFields(newProject.Reserved__c,oldProject.Reserved__c);
        setFields(newProject.Final_Rebate_Amount__c,oldProject.Final_Rebate_Amount__c);
        setFields(newProject.Expected_Amount_Federal__c,oldProject.Expected_Amount_Federal__c);
        setFields(newProject.Final_Amount_Federal__c,oldProject.Final_Amount_Federal__c);
        setFields(newProject.SREC_Price__c,oldProject.SREC_Price__c);
        setFields(newProject.Traded_Price__c,oldProject.Traded_Price__c);
        setFields(newProject.Amount__c,oldProject.Amount__c);
        setFields(newProject.Extra_Payment_Amount__c,oldProject.Extra_Payment_Amount__c);
        setFields(newProject.SFDC_Project_Start_Date__c,oldProject.SFDC_Project_Start_Date__c);
        setFields(newProject.SFDC_Project_End_Date__c,oldProject.SFDC_Project_End_Date__c);
        setFields(newProject.Deadline_Date__c,oldProject.Deadline_Date__c);
        setFields(newProject.Hand_off_Date__c,oldProject.Hand_off_Date__c);
        setFields(newProject.Internal_NTP_Baseline__c,oldProject.Internal_NTP_Baseline__c);
        setFields(newProject.Internal_NTP_Date__c,oldProject.Internal_NTP_Date__c);
        setFields(newProject.X50_Baseline_Date__c,oldProject.X50_Baseline_Date__c);
        setFields(newProject.X50_Forecast_Release_Date__c,oldProject.X50_Forecast_Release_Date__c);
        setFields(newProject.X50_Set_Completed__c,oldProject.X50_Set_Completed__c);
        setFields(newProject.Permit_Baseline_Date__c,oldProject.Permit_Baseline_Date__c);
        setFields(newProject.Permit_Forecast_Release_Date__c,oldProject.Permit_Forecast_Release_Date__c);
        setFields(newProject.Permit_Set_Completed__c,oldProject.Permit_Set_Completed__c);
        setFields(newProject.CD_Baseline_Date__c,oldProject.CD_Baseline_Date__c);
        setFields(newProject.CD_Forecast_Release_Date__c,oldProject.CD_Forecast_Release_Date__c);
        setFields(newProject.Const_Set_Completed__c,oldProject.Const_Set_Completed__c);
        setFields(newProject.As_Built_Completed__c,oldProject.As_Built_Completed__c);
        setFields(newProject.X50_Review_Baseline__c,oldProject.X50_Review_Baseline__c);
        setFields(newProject.X50_Review_Date__c,oldProject.X50_Review_Date__c);
        setFields(newProject.Permit_Review_Baseline__c,oldProject.Permit_Review_Baseline__c);
        setFields(newProject.Permit_Review_Date__c,oldProject.Permit_Review_Date__c);
        setFields(newProject.Const_Review_Baseline__c,oldProject.Const_Review_Baseline__c);
        setFields(newProject.Const_Review_Date__c,oldProject.Const_Review_Date__c);
        setFields(newProject.PTO_Date__c,oldProject.PTO_Date__c);
        setFields(newProject.Interconn_Date__c,oldProject.Interconn_Date__c);
        setFields(newProject.Due_Date__c,oldProject.Due_Date__c);
        setFields(newProject.PPM_Date__c,oldProject.PPM_Date__c);
        setFields(newProject.ICF_Approval_Date__c,oldProject.ICF_Approval_Date__c);
        setFields(newProject.ICF_Submission_Date__c,oldProject.ICF_Submission_Date__c);
        setFields(newProject.Rebate_Expected_Date__c,oldProject.Rebate_Expected_Date__c);
        setFields(newProject.Rebate_Received_Date__c,oldProject.Rebate_Received_Date__c);
        setFields(newProject.X1st_Payment_Date__c,oldProject.X1st_Payment_Date__c);
        setFields(newProject.Rebate_Date__c,oldProject.Rebate_Date__c);
        setFields(newProject.Rebate_Expiration_Date__c,oldProject.Rebate_Expiration_Date__c);
        setFields(newProject.Submitted_Date_Federal__c,oldProject.Submitted_Date_Federal__c);
        setFields(newProject.Approval_Date_Federal__c,oldProject.Approval_Date_Federal__c);
        setFields(newProject.NEPOOL_Reg_Approved_Date__c,oldProject.NEPOOL_Reg_Approved_Date__c);
        setFields(newProject.NEPOOL_Reg_Requested_Date__c,oldProject.NEPOOL_Reg_Requested_Date__c);
        setFields(newProject.Qtr_1st_SREC_produced_Date__c,oldProject.Qtr_1st_SREC_produced_Date__c);
        setFields(newProject.Qtr_Submitted_Date__c,oldProject.Qtr_Submitted_Date__c);
        setFields(newProject.SQA_Approved_Date__c,oldProject.SQA_Approved_Date__c);
        setFields(newProject.SQA_Submission_Date__c,oldProject.SQA_Submission_Date__c);
        setFields(newProject.PV_Detail_Form_Approved_Date__c,oldProject.PV_Detail_Form_Approved_Date__c);
        setFields(newProject.PV_Detail_Form_Submission_Date__c,oldProject.PV_Detail_Form_Submission_Date__c);
        setFields(newProject.Commencement_Date__c,oldProject.Commencement_Date__c);
        setFields(newProject.Date_First_Expected__c,oldProject.Date_First_Expected__c);
        setFields(newProject.Extra_Payment_Date__c,oldProject.Extra_Payment_Date__c);
        setFields(newProject.Commissioning_Date__c,oldProject.Commissioning_Date__c);
        setFields(newProject.O_M_Handoff_Date__c,oldProject.O_M_Handoff_Date__c);
        setFields(newProject.Prior_50_Forecast_Date__c,oldProject.Prior_50_Forecast_Date__c);
        setFields(newProject.Prior_CD_Forecast_Date__c,oldProject.Prior_CD_Forecast_Date__c);
        setFields(newProject.Prior_Permit_Forecast_Date__c,oldProject.Prior_Permit_Forecast_Date__c);
        setFields(newProject.Construction_Stage_Change_Date__c,oldProject.Construction_Stage_Change_Date__c);
        setFields(newProject.Rebate_Notes__c,oldProject.Rebate_Notes__c);
        setFields(newProject.Design_Notes__c,oldProject.Design_Notes__c);
        setFields(newProject.Notes_Federal__c,oldProject.Notes_Federal__c);
        setFields(newProject.Comments_on_Budget__c,oldProject.Comments_on_Budget__c);
        setFields(newProject.Deadline_Description__c,oldProject.Deadline_Description__c);
        setFields(newProject.Account__c,oldProject.Account__c);
        setFields(newProject.Commissioning_Agent__c,oldProject.Commissioning_Agent__c);
        setFields(newProject.Opportunity__c,oldProject.Opportunity__c);
        setFields(newProject.OwnerID,oldProject.OwnerId);
        setFields(newProject.EC__c,oldProject.EC__c);
        setFields(newProject.Trade_Day__c,oldProject.Trade_Day__c);
        setFields(newProject.Internal_NTP_On_Hold_Days__c,oldProject.Internal_NTP_On_Hold_Days__c);
        setFields(newProject.kWh_kW_Rating__c,oldProject.kWh_kW_Rating__c);
        setFields(newProject.Reserved_KW__c,oldProject.Reserved_KW__c);
        setFields(newProject.Final_KW__c,oldProject.Final_KW__c);
        setFields(newProject.WATTS_STC__c,oldProject.WATTS_STC__c);
        setFields(newProject.Number_of_SRECs_Traded__c,oldProject.Number_of_SRECs_Traded__c);
        setFields(newProject.Frequency_days__c,oldProject.Frequency_days__c);
        setFields(newProject.PC_Code__c,oldProject.PC_Code__c);
        setFields(newProject.Branch__c,oldProject.Branch__c);
        setFields(newProject.AcctSeed__Status__c,oldProject.SFDC_Project_Status__c);
        setFields(newProject.SFDC_Project_Stage__c,oldProject.SFDC_Project_Stage__c);
        setFields(newProject.Design_Stage__c,oldProject.Design_Stage__c);
        setFields(newProject.Revenue_Year__c,oldProject.Revenue_Year__c);
        setFields(newProject.Modules_Status__c,oldProject.Modules_Status__c);
        setFields(newProject.Inverter_Status__c,oldProject.Inverter_Status__c);
        setFields(newProject.Racking_Status__c,oldProject.Racking_Status__c);
        setFields(newProject.Racking_Type__c,oldProject.Racking_Type__c);
        setFields(newProject.Senior_Design_Engineer__c,oldProject.Senior_Design_Engineer__c);
        setFields(newProject.Reviewer__c,oldProject.Reviewer__c);
        setFields(newProject.Design_Subcontractor__c,oldProject.Design_Subcontractor__c);
        setFields(newProject.Interconnection_Status__c,oldProject.Interconnection_Status__c);
        setFields(newProject.Rebate_Status__c,oldProject.Rebate_Status__c);
        setFields(newProject.Rebate_Assigned_To__c,oldProject.Rebate_Assigned_To__c);
        setFields(newProject.PBI_Payment_Cycle__c,oldProject.PBI_Payment_Cycle__c);
        setFields(newProject.App_Fee_Paid_By__c,oldProject.App_Fee_Paid_By__c);
        setFields(newProject.Fed_Rebate_Status__c,oldProject.Fed_Rebate_Status__c);
        setFields(newProject.Grant_Assigned_To_Federal__c,oldProject.Grant_Assigned_To_Federal__c);
        setFields(newProject.Lease_Payment_Status__c,oldProject.Lease_Payment_Status__c);
        setFields(newProject.Contingent_Upon_Commencement__c,oldProject.Contingent_Upon_Commencement__c);
        setFields(newProject.Payment_Plan__c,oldProject.Payment_Plan__c);
        setFields(newProject.Commissioning_Status__c,oldProject.Commissioning_Status__c);
        setFields(newProject.O_M_Handoff_Status__c,oldProject.O_M_Handoff_Status__c);
        setFields(newProject.DAS_Vendor__c,oldProject.DAS_Vendor__c);
        setFields(newProject.SFDC_Status_Description__c,oldProject.SFDC_Status_Description__c);
        setFields(newProject.Job_Number__c,oldProject.Job_Number__c);
        setFields(newProject.Electrical_Engineer__c,oldProject.Electrical_Engineer__c);
        setFields(newProject.Structural_Engineer__c,oldProject.Structural_Engineer__c);
        setFields(newProject.Comments_on_Schedule__c,oldProject.Comments_on_Schedule__c);
        setFields(newProject.Incentive__c,oldProject.Incentive__c);
        setFields(newProject.Next_Steps__c,oldProject.Next_Steps__c);
        setFields(newProject.SREC_Purchaser__c,oldProject.SREC_Purchaser__c);
        setFields(newProject.Trade_Off_taker__c,oldProject.Trade_Off_taker__c);
        setFields(newProject.Trade_Quarter__c,oldProject.Trade_Quarter__c);
        setFields(newProject.Foreman__c,oldProject.Foreman__c);
        setFields(newProject.Rebate_Id__c,oldProject.Rebate_Id__c);
        setFields(newProject.Picasa_Album__c,oldProject.Picasa_Album__c);
        
        */
    }

/*

    public void setFields(SObject newField, SObject oldField){
        if(oldField != null){
            newField = oldField;
        }
    }
    
    
    public void setFields(boolean newField, boolean oldField){
        if(oldField != null){
            newField = oldField;
        }
    }
    
    public void setFields(Decimal newField, Decimal oldField){
        if(oldField != null){
            newField = oldField;
        }
    }
    
    public void setFields(Date newField, Date oldField){
        if(oldField != null){
            newField = oldField;
        }
    }
    
    public void setFields(DateTime newField, DateTime oldField){
        if(oldField != null){
            newField = oldField;
        }
    }
    
    public void setFields(String newField, String oldField){
        if(oldField != null){
            newField = oldField;
        }
    }
*/


public static testmethod void migrationTest() {
        User su = [select Id, ManagerId from User where  isactive = true limit 1];
  //    User bvm = [select Id from User where Name = 'Brian von Moos'];
        ER__c er = new ER__c(User__c = su.Id, Month_Ending__c = System.today(), Receipts_Attached__c = true);
        insert er;           
        
        
        User owner = [select Id from User where isactive = true limit 1];
        Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',
                            Job_Type__c = 'Residential', Branch__c = 'Berkeley', 
                            Project_End_Date__c = null, ShippingCity = 'Petaluma'); 
        insert acc;
        
        
        Opportunity opp = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = acc.Id,
                                    Type = 'Turnkey System',CloseDate = System.today(), StageName = 'Prospecting'); 
        insert opp;
        
        SFDC_Project__c[] proj = new SFDC_Project__c[0];
        proj.add(new SFDC_Project__c(Name = 'Knight - 2456',Opportunity__c = opp.Id, Account__c = acc.Id, SFDC_Project_Stage__c = 'Sales', 
                                        Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
                                        Job_Number__c = '000-000', OwnerId = owner.Id)); 
        insert proj;
        
        
        
        migrationCtrl migrate = new migrationCtrl();
        migrate.migrateProject();
        
        migrate = new migrationCtrl();
        migrate.migrateGLSAsset();
        
        migrate.migrateCustSatis();
            
        migrate.migrateSpecSub();
                    
        migrate.migrateContract();
            
        //migrate.migratePartnerProject();
            
        migrate.migrateContReq();
            
        
        migrate.migrateRFI();
            
        
        migrate.migrateInterconnection();
            
        
        migrate.migratePermit();
            
        
        migrate.migrateRebate();
        migrate.migrateforeman();
        migrate.migrateAttachments();
        migrate.migrateNotes();
        
        
}




}