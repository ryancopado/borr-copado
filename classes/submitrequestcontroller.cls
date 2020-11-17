public with sharing class submitrequestcontroller {
    @AuraEnabled
    public  static string PricepUpdate(Id PriceId) 
    {
        String resultMap;
        String errmsg;
        Pricing_Tool_Approval__c Pricevalues=new Pricing_Tool_Approval__c ();
        List<Pricing_Tool_Approval__c> Price = [Select Id, Request_Status__c FROM Pricing_Tool_Approval__c Where Id =: PriceId];
        Pricevalues=Price.get(0);
        Pricevalues.Request_Status__c='Submitted';
        try {
            update Pricevalues;
            errmsg= ('Pricing Request Updated to ' +Pricevalues.Request_Status__c);
            resultMap=errmsg;
            
        }
        catch(Exception e) {
            resultMap=  e.getMessage(); 
        }
        return resultMap;
    }
    
    
    @AuraEnabled
    public  static string CancelPR(Id PriceId1) 
    {
        string result; 
        Pricing_Tool_Approval__c Pricevalues=new Pricing_Tool_Approval__c ();
        List<Pricing_Tool_Approval__c> Price = [Select Id, Request_Status__c,Status__c FROM Pricing_Tool_Approval__c Where Id =: PriceId1];
        Pricevalues=Price.get(0);
        system.debug('Look here'+Pricevalues.Request_Status__c);
        system.debug('Look here'+Pricevalues.Status__c);
        if((Pricevalues.Request_Status__c == 'New' || Pricevalues.Request_Status__c == 'Submitted' || Pricevalues.Request_Status__c == 'In Progress') && (Pricevalues.Status__c != 'Approval Pending')){
            system.debug('this is if');
            try {
                system.debug('lll-->');
                 system.debug('this is try');
                Pricevalues.Request_Status__c ='Cancelled' ;  
                pricevalues.Status__c ='Cancelled';
                 system.debug('this is update' +Pricevalues);
                update Pricevalues;
               
                
            }
            catch(Exception e) {
                system.debug('this is catch');
                result=  e.getMessage(); 
            }
        }
        else{
            system.debug('else condition-->' +Pricevalues.Request_Status__c);
            if((Pricevalues.Request_Status__c != 'New' || Pricevalues.Request_Status__c != 'Submitted' ) ){
            result ='A request cannot be cancelled if it is Completed, Cancelled, or pending approval.';
                //'"Pricing Tool \"Request Status\" must be "New" or "Submitted" and not presently in an Approval Process in order to be Cancelled.testing';
            }
        }
        
        system.debug('this is result-->' +result);
        return result;
    }
}