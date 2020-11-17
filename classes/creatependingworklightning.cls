public with sharing class creatependingworklightning {
    @AuraEnabled
   
    //This is the apex class to convert the creatependingwork button on O&M project Related list to work in ligthing.
    public  static string Projupdate(Id ProId1) 
    {
         String result;
         AcctSeed__Project__c Projvalues=new AcctSeed__Project__c ();
        List<AcctSeed__Project__c>projectrecord=[select Name,AccountID__c from AcctSeed__Project__c where id=:ProId1];
        if(projectrecord.size()>0)
        {
            Projvalues=projectrecord.get(0);
           result=Projvalues.AccountID__c;
            
        }
         system.debug('Account' +result);
        return result;
        
       
}
}