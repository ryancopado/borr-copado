public class closecaselightning {
   

    @AuraEnabled
     public  static List<Case> getcase(Id caseid) 
    {
     List<Case>  caserecord = new Case[]{};
        
       
       caserecord = [select id,RecordType.Name,RecordTypeId from Case where id= :caseid];
   
         return caserecord;
      }
    
    @AuraEnabled
     public  static List<Case> getquotefields(Id caseid1) 
    {
     List<Case>  casequoterec = new Case[]{};
        
       
       casequoterec = [select Project__c,ServiceContract_Case__c from Case where id= :caseid1];
   
         return casequoterec;
      }


}