public class CasePendingWork {

  public  Id ProjectID;  
  private final Case rcdCase;
  Public List<PendingWorkWrapper> lstPendingWork {get; set;} 
    public String redirectUrl {public get; private set;}
    public Boolean shouldRedirect {public get; private set;}
    private ApexPages.StandardController stdController;
    
    
     public CasePendingWork(ApexPages.StandardController stdController) {
         this.stdController = stdController;
         shouldRedirect = false;
         this.rcdCase = [select id, Project__c, AccountId from case where id = : stdController.getId() limit 1 ];//(Case)stdController.getRecord();  
         lstPendingWork= new List<PendingWorkWrapper>();
         
         for(Pending_Work__c pw: [Select Id, Name, Asset__c, Project__c, Case__c, Contract__c,
                                  		Description_of_Pending_Work__c
                                                   From Pending_Work__c 
                                  					where 
                                  					Project__c =: rcdCase.Project__c
                                                    and
                                                    status__c = 'Open'
                                  					order by Name Asc
                                 					])
           {
               lstPendingWork.add(new PendingWorkWrapper(pw));               
           }         
    }
    
    
    public void  CreateReactiveService()
    {
        Savepoint sp = Database.setSavepoint();
        try{
        	List<SV__c> lstService = new List<SV__c>();
            map<id,SV__c> svByPwId = new map<id,SV__c>();
            
            for(PendingWorkWrapper pw: lstPendingWork){
                 if( pw.selected ){
                     SV__c rcdSV = new SV__c();                 
                     rcdSV.Asset__c = pw.pwrk.Asset__c ;
                     rcdSV.Project__c = pw.pwrk.Project__c ;
                     rcdSV.Case__c = rcdCase.id ; //pw.pwrk.Case__c ;  -- 15-08-2018 Updated as per email from Kumar           
                     rcdSV.Contract__c = pw.pwrk.Contract__c; 
                     rcdSV.Account__c = rcdCase.AccountId ; // -- 17-08-2018 Updated as per email from Kumar        
                     svByPwId.put( pw.pwrk.id , rcdSV );
                     lstService.add(rcdSV);
                 }       
              }
            if(lstService.size()>0)
            {
                insert lstService;  
                list<Pending_Work__c> lstPWtoUpdate = new list<Pending_Work__c>();
                for(id key: svByPwId.keyset()){
                    Pending_Work__c rcdPW = new Pending_Work__c(id = key);	
                    rcdPW.Associated_Case_to_Close__c = rcdCase.id ;
                    if( svByPwId.keyset().contains(key) ){
                    	rcdPW.Associated_Service_Visit_to_Close__c = svByPwId.get(key).id ;    
                    }
                    rcdPW.Status__c = 'Assigned';
                    lstPWtoUpdate.add(rcdPW);
                }
                if( lstPWtoUpdate.size() > 0 ){
                    update lstPWtoUpdate ;	    
                }
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Service Visit Created Successfully.' ));
                shouldRedirect = true;
                redirectUrl = stdController.view().getUrl();
            }
            else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info, label.Case_Pending_Work_Not_Selected ));
            }    
        }
        catch(exception ex){
        	Database.rollback(sp);   
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage() ));
        }
    }
    
    public class PendingWorkWrapper
    {
        public Pending_Work__c pwrk{get; set;}
        public Boolean selected {get; set;}
      
        public PendingWorkWrapper(Pending_Work__c pwrk)
        {
            this.pwrk = pwrk;
            this.selected = false;
        } 
    } 
}