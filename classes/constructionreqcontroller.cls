public with sharing class constructionreqcontroller
{
    @AuraEnabled
      
    public  static string redirect(Id ProId) {
        string result;
        //   Dynamic_Field_Id_Setting__c dynamicfieldid=new Dynamic_Field_Id_Setting__c();
        //  List<Dynamic_Field_Id_Setting__c > dynamicid=[select Con_Req_Group_Project_Field_Id__c ,Con_Req_Group_Sales_Order_Field_Id__c from Dynamic_Field_Id_Setting__c];
        // dynamicfieldid=dynamicid.get(0);
        //  string salesorderid=dynamicfieldid.Con_Req_Group_Sales_Order_Field_Id__c;
        //result=salesorderid;
        
        
        
        AcctSeedERP__Sales_Order__c salesvalues=new AcctSeedERP__Sales_Order__c();
        AcctSeed__Project__c projectvalues=new AcctSeed__Project__c ();
        List<AcctSeedERP__Sales_Order__c > sales=[SELECT Id, Name, Project__c FROM AcctSeedERP__Sales_Order__c where Project__c = :ProId Limit 1];
        if(sales.size()>0)
        {
            salesvalues=sales.get(0);
            result=salesvalues.Id;
            
            
            List<AcctSeed__Project__c> project = [SELECT Id, Name, Owner.Name FROM AcctSeed__Project__c where Id = :ProId limit 1];
            if(project.size()>0)
            {
                projectvalues=project.get(0);
                
                string ownername=projectvalues.Owner.Name;
            }
            
            
            
            
            
            
        }
        
        
        else
        {
            String errormsg='Cannot create new Con Req Group unless Project has a Sales Order associated with it.';
            result=errormsg;
        }
        return result;
    }
    
    
    /*  this is th apex class for lightning component Lock sales budget (Project object)  */
   @AuraEnabled      
    public  static string locksales(Id ProId) {
        
        Boolean lockresult;
        string sendlockresult;
        AcctSeed__Project__c lockvalue=new AcctSeed__Project__c ();
        
        
        List<AcctSeed__Project__c> project = [SELECT id,Sales_Budget_Locked__c FROM AcctSeed__Project__c where Id = :ProId limit 1];
        if(project.size()>0){
            lockvalue = project.get(0);
            lockresult = lockvalue.Sales_Budget_Locked__c;
            
        }
        
        system.debug('lock Result-->'  +lockresult);
        if (lockresult == true){
            
            sendlockresult = 'Already Sales budget locked.';
            
        }
        else{
            
          sendlockresult  ='/apex/LockSalesBudget?id='+lockvalue.id;
            
      }
            system.debug('final-->' +sendlockresult);
        return sendlockresult;  
    }
    
}