public with sharing class Case_ProjectCtlExt 
{

   /*
   *  Case controller for case creation from a Project - creates list of allowable record types
   *  for selection and pre-populates several fields.
   *
   */
   private ApexPages.StandardSetController stdSetCon;
   public List<Contract> selectedContracts;
   
   String Projectnumber;
   String retURL;
  // public List<AcctSeed__Project__c> lstQuery{get;set;}
   public List<Contract> lstQuery{get;set;}
   public Case_ProjectCtlExt(ApexPages.StandardController stdController) 
   {
        this.stdSetCon = stdSetCon;
        system.debug('Controller - '+stdSetCon);
        Projectnumber = ApexPages.currentpage().getParameters().get('JOB_NUMBER');   
        system.debug('Job Id'+Projectnumber);       
        lstQuery=new List<Contract>();
        Contract ctr = new Contract();   
        if(Projectnumber!=NULL)
        {
            string Query='SELECT id,ContractNumber,ASProject__c,Type__c FROM Contract WHERE JobNumber__c =:Projectnumber AND Contract_Status__c=\'ACTIVE\'';
          
            lstQuery=Database.query(Query);
            
            system.debug('No of projects = '+lstQuery.size());
            
            //for(integer i=0;i<lstQuery.size();i++)
            //{
                //ctr = lstQuery.get(0);
                //system.debug('Contractnumber ' +ctr.ContractNumber);
                
            //}
         }
    }
    // public PageReference movetocase() {
        //system.debug('movetocase - '+stdSetCon);
        //PageReference pr = null;
        //selectedContracts = stdSetCon.getSelected();        
        //system.debug('Contract id ' +selectedContracts[0].Id);
        //if (selectedContracts.size() == 1) {
            
            //pr = new PageReference('/apex/Case_Contract?contractId=' + selectedContracts[0].Id + '&retURL=/apex/Case_Tab');
            //pr.setRedirect(true);
            
       // } else {
           // ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select only one Contract.'));
        //}
        
        //return pr;
   // }
}