public class commission {
    /*Private String FixedCostValidationMessage ='When Fixed Cost is unchecked, Percent should not be blank  or 0'; 
        ApexPages.StandardController stdController;
        RecordType CurrentRecordType;
        RecordType AffiliateRecordType;
    private final Commission__c comm; 
    
        public commission(ApexPages.StandardController stdController) {
                this.comm = (Commission__c)stdController.getRecord(); 
                this.stdController = stdController;
                
                
                List<RecordType> ListOfRecordType=new List<RecordType>();
                
                if(this.comm.Recordtypeid!=null)  
                ListOfRecordType=[select ID,Name from RecordType where id=:this.comm.Recordtypeid];
                
                if (ListOfRecordType.size()>0)
                CurrentRecordType=ListOfRecordType[0];
           
           AffiliateRecordType=[Select ID from RecordType Where Name='Affiliates'];     
    }

    private Boolean show;
    public Boolean getself() {
        if (comm.User__c != null) {
         //   try {
                User self = [select Id from User where Id = :comm.User__c];
                if (UserInfo.getUserId() == self.Id) {
                    show = false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot create or edit a record for which you are the User.'));

                }else {
                    show = true;
                }
    //        } catch (Exception e) {
    //            show = false;
   //             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot create or edit a record for which you are the User.'));

   //         }
        } else {
            show = true;
        }  
        return show; 
    }
    public PageReference saveAndNew() {
    
        Double totalpercent = 0;
        Double tp = 0;
     
    if (CurrentRecordType==null && this.comm.Recordtypeid!=null){
                 List<RecordType> ListOfRecordType=new List<RecordType>();
                ListOfRecordType=[select ID,Name from RecordType where id=:this.comm.Recordtypeid];
                
                if (ListOfRecordType.size()>0)
                CurrentRecordType=ListOfRecordType[0];
    }
    
     
        If(CurrentRecordType!=null &&  CurrentRecordType.Name=='Affiliates' && comm.Fixed_Cost__c==false && (comm.Percent__c==null || comm.Percent__c==0)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,FixedCostValidationMessage  ));
            return null;
        }
        else  if ((CurrentRecordType==null || (CurrentRecordType!=null &&  CurrentRecordType.Name!='Affiliates') )    &&  comm.Percent__c==null){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Percent is Required.')); return null;
        }
        else{       
                Commission__c[] coms = [select Percent__c from Commission__c where (recordtypeid=null or RecordTypeid!=:AffiliateRecordType.id) and Opportunity__c = :comm.Opportunity__c];
                Opportunity opps = [select Commission_Percent_Cap__c from Opportunity where Id = :comm.Opportunity__c];
                if(opps.Commission_Percent_Cap__c == null){
                        opps.Commission_Percent_Cap__c = 3.00;
                }
                for (Integer i = 0; i <coms.size(); i++) {
                            if(coms[i].Percent__c != null){
                            totalpercent += coms[i].Percent__c;
                        }
                }
                
                
                if(comm.Percent__c!=null)
                    tp += totalpercent + comm.Percent__c;
                
                
                    try {
                        if (Double.valueOf(tp) <= opps.Commission_Percent_Cap__c || (CurrentRecordType!=null && CurrentRecordType.Name=='Affiliates')){
                            Upsert comm;
                            
                            PageReference newcontact ;

                            
                                if (CurrentRecordType!=null && CurrentRecordType.Name=='Affiliates')
                                    newcontact = new PageReference('/apex/CommissionAffiliateNew?RecordType='+CurrentRecordType.Id+'&'+'oid=' + comm.Opportunity__c );
                                else if (CurrentRecordType!=null && CurrentRecordType.Name!='Affiliates')
                                    newcontact = new PageReference('/apex/commission_new?RecordType='+CurrentRecordType.Id+'&'+'oid=' + comm.Opportunity__c );
                                else
                                    newcontact = new PageReference('/apex/commission_new?oid=' + comm.Opportunity__c );                                 
                                                                                            
                            newcontact.setRedirect(true);
                            return newcontact;
                        } else {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Total Commission Percent cannot exceed ' +opps.Commission_Percent_Cap__c+'%. Total Commisison Percent is currently ' +totalpercent +'%. Your current commission exceeds the limit by ' + (tp-opps.Commission_Percent_Cap__c) +'%.'));
                            getSelf();
                            return null;
                        }
                     }  catch (System.DmlException e) {
                    //    System.debug(e.getDmlMessage(0));
                    //    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Commission Record Failed to insert. Please contact your System Administrator.'));
                        return null;
                    } 
         }
    }
    public PageReference saves() {
    
    
        Double totalpercent = 0;
        Double tp = 0;
    
    
       if (CurrentRecordType==null && this.comm.Recordtypeid!=null){
                 List<RecordType> ListOfRecordType=new List<RecordType>();
                ListOfRecordType=[select ID,Name from RecordType where id=:this.comm.Recordtypeid];
                
                if (ListOfRecordType.size()>0)
                CurrentRecordType=ListOfRecordType[0];
            }
         
        If(CurrentRecordType!=null && CurrentRecordType.Name=='Affiliates' &&  comm.Fixed_Cost__c==false && (comm.Percent__c==null || comm.Percent__c==0)){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, FixedCostValidationMessage ));
            return null;
        }
        else  if ((CurrentRecordType==null || (CurrentRecordType!=null &&  CurrentRecordType.Name!='Affiliates') )    &&  comm.Percent__c==null){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Percent is Required.')); return null;
        }
        else{        
            
                    Commission__c[] coms = [select Percent__c from Commission__c where (recordtypeid=null or RecordTypeid!=:AffiliateRecordType.id)  and  Opportunity__c = :comm.Opportunity__c];
                    Opportunity opps = [select Commission_Percent_Cap__c from Opportunity where Id = :comm.Opportunity__c];
                    if(opps.Commission_Percent_Cap__c == null){
                            opps.Commission_Percent_Cap__c = 3.00;
                    }
                    System.debug(coms);
                    for (Integer i = 0; i <coms.size(); i++) {
                            if(coms[i].Percent__c != null){
                            totalpercent += coms[i].Percent__c;
                            }
                    }
                    
                    if (comm.Percent__c!=null)
                        tp += totalpercent + comm.Percent__c;
                        
                        try {
                            if (Double.valueOf(tp) <= opps.Commission_Percent_Cap__c || (CurrentRecordType!=null && CurrentRecordType.Name=='Affiliates')){
                                return stdController.save();
                            } else {
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Total Commission Percent cannot exceed ' +opps.Commission_Percent_Cap__c+'%. Total Commisison Percent is currently ' +totalpercent +'%. Your current commission exceeds the limit by ' + (tp-opps.Commission_Percent_Cap__c) +'%.'));
                                getSelf();
                                return null;
                            }
                         }  catch (System.DmlException e) {
                            System.debug(e.getDmlMessage(0));
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Commission Record Failed to insert. Please contact your System Administrator.'));
                            return null;
                        } 
                        
                        
              }
    }
    public void setPercent() {
        try {
            User payee = [select Commission_Percentage__c from User where Id = :comm.User__c];
            comm.Percent__c = payee.Commission_Percentage__c;  
        } catch (Exception e) {
            System.debug(e);
            comm.Percent__c = 0.0; 
        }
    }
    public void setOpp() {
        if(ApexPages.currentPage().getParameters().get('oid') != null){
                comm.Opportunity__c = ApexPages.currentPage().getParameters().get('oid');
                comm.RecordTypeID= ApexPages.currentPage().getParameters().get('RecordType');
                List<RecordType> ListOfRecordType=new List<RecordType>();
                ListOfRecordType=[select ID,Name from RecordType where id=:this.comm.Recordtypeid];
                
                if (ListOfRecordType.size()>0)
                CurrentRecordType=ListOfRecordType[0];
        }
/*        String opps = ApexPages.currentPage().getParameters().get('CF00N80000002mpsx_lkid'); 
        if (opp != null){
            comm.Opportunity__c = opp;
        } else { 
            comm.Opportunity__c = opps;
        } */
   /* }
    public static testmethod void commissionTest() {
                       
        //Set Page Parameters 
        User other = [select Id from User where Name = 'Michael Hall']; 
        Account AccMake = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                        Project_End_Date__c = null, ShippingCity = 'Park City'); insert AccMake;
        Opportunity opp = new Opportunity(OwnerId = other.Id, Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                                                                CloseDate = System.today(),StageName = 'Prospecting'); insert opp;
        Commission__c com = new Commission__c(User__c = other.Id, Percent__c = 3, Opportunity__c = opp.Id); insert com; 
        
        Test.startTest();
        
        //Test Paperwork Page
        PageReference pageRef = Page.commission_new;
        Test.setCurrentPage(pageRef);
        
        //Set Paperwork Parameters
        ApexPages.StandardController con = new ApexPages.StandardController(new Commission__c());
        commission ext = new commission(con);
        ApexPages.currentPage().getParameters().put('oid', opp.Id);
        
        
        //Call all methods on Paperwork page    
        ext = new commission(con);
              
          ext.setOpp();
          ext.getself();
          ext.setPercent();
          PageReference result2 = ext.saves();
          PageReference result = ext.saveAndNew();          
          
        //Test contractCA Page  
        PageReference pageRef2 = Page.commission_edit;
        Test.setCurrentPage(pageRef2);
        
        //Set Parameters
        ApexPages.StandardController con2 = new ApexPages.StandardController(com);
        commission ext2 = new commission(con2);
        ApexPages.currentPage().getParameters().put('oid', opp.Id);
        ApexPages.currentPage().getParameters().put('id', com.Id);
        
          ext2.getself();
          ext2.setPercent();
          PageReference result3 = ext2.saves();
          PageReference result4 = ext2.saveAndNew();                           
        
        Test.stopTest();
    }  */ 
}