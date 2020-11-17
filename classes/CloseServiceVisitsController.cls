public class CloseServiceVisitsController {

    private ID ContractId;
    private list<SV__C> ListOfServiceVisits;
    public CloseServiceVisitsController(ApexPages.StandardSetController controller) {
    
         ContractId = apexpages.currentpage().getparameters().get('id');
         ListOfServiceVisits=new List<SV__c>();
         
         for(sObject SOBJ:controller.getSelected()){
             ListOfServiceVisits.add((sv__C) SOBJ);
         }
    }

   Public pageReference CloseServiceVisits(){
   
       for(sv__C ServiceVisit:ListOfServiceVisits){
             ServiceVisit.Status__c='Closed';
         }
   
       Update ListOfServiceVisits;
   
        pageReference pgRef=new pageReference('/'+ ContractId);
        pgRef.SetRedirect(true);
        return pgRef;   
   }

}