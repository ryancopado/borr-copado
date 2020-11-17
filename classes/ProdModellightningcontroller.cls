public class ProdModellightningcontroller {
    
    @AuraEnabled
      
    public  static string PrdModSubmit(Id PModId) {
        
        string result;
        
        Production_Modeling__c Pmvalues  = new Production_Modeling__c();
        List<Production_Modeling__c> pmlist = new List<Production_Modeling__c>();
        
        pmlist = [select id,Standards__c,Request_Status__c from Production_Modeling__c where id=:PModId];
        
        Pmvalues = pmlist.get(0);
        
        system.debug(Pmvalues.Standards__c);
        if (Pmvalues.Standards__c !=null){
            
            Pmvalues.Request_Status__c = 'Submitted';
            
            
            try{
            
            update Pmvalues;
            
        }
        catch(Exception e) {
                           result=  e.getMessage(); 
                       }
            
        }
        else{
            
            result = 'The Standard Field Must be filled Out Before Submitting the Request';
        }
            
        
        
        
        
        return  result;
    }
   
    
     @AuraEnabled
      
    public  static string PrdModCancel(Id PModId) {
        
        string result;
        
        Production_Modeling__c Pmvalues  = new Production_Modeling__c();
        List<Production_Modeling__c> pmlist = new List<Production_Modeling__c>();
        
        pmlist = [select id,Status__c,Request_Status__c from Production_Modeling__c where id=:PModId];
        
        Pmvalues = pmlist.get(0);
        
        if((Pmvalues.Request_Status__c == 'New' || Pmvalues.Request_Status__c == 'Submitted') && (Pmvalues.Status__c != 'Submitted')  ) {
            
                      pmvalues.Cancel_Request__c =true;
            
            
            try{
            
            update Pmvalues;
            
        }
        catch(Exception e) {
                           result=  e.getMessage(); 
                       }
            
        }
        else{
            
            result = 'Production Model \"Request Status\" must be "New" or "Submitted" and not presently in an Approval Process in order to be Cancelled. Also, record must not be locked.';
        }
            
        
        
        
        
        return  result;
    }
        
    }