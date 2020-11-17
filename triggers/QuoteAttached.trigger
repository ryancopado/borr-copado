trigger QuoteAttached on SBQQ__Quote__c (After insert,Before delete) {
     
     
      SBQQ__Quote__c quotelist = new SBQQ__Quote__c();
      
       List<Id> qIds = new List<Id>();
      
 if(trigger.isinsert){
 
     SBQQ__Quote__c  quoteatt = Trigger.new[0];
    
      system.debug('quote id' +quoteatt.id);
      quotelist = [SELECT Id,name,case__c FROM SBQQ__Quote__c where id=:quoteatt.id];
      case caseatt = new case();
      //SBQQ__Quote__c listcount = new SBQQ__Quote__c();
      AggregateResult[] listcount= [select count(id)countid from SBQQ__Quote__c  where case__c = :quotelist.case__c];
       
    if (quotelist.Case__c !=null){
        
        caseatt.id = quotelist.case__c;
        caseatt.Quote_Attached__c = (decimal)listcount[0].get('countid');
        
        
    }
   update caseatt; 
    }
    
    
    if (Trigger.isdelete)
    {
        
      //  system.debug('quote id' +Trigger.oldmap.get(quoteatt.id));
       
       
        for (SBQQ__Quote__c getquoteid: trigger.old) {
        
          qIds.add(getquoteid.id);
        }
        
         if (!qIds.isEmpty()) {
            
            // Get the list of associated Requisition form records
               quotelist = [SELECT Id,name,case__c FROM SBQQ__Quote__c where id=:qIds];     
               
          }
       // quotelist = [SELECT Id,name,case__c FROM SBQQ__Quote__c where id=:getquoteid ];
        case caseatt = new case();
        caseatt = [select Quote_Attached__c from case where id= :quotelist.case__c ];
        caseatt.id = quotelist.case__c;
        caseatt.Quote_Attached__c = caseatt.Quote_Attached__c  -1; 
        update caseatt;
    }
    
    
}