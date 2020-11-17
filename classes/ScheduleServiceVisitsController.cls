public with sharing class ScheduleServiceVisitsController {
    
    private ID ContractId;
    
    public SV__c ServiceVisitObject {get; set;}
    
    public integer VisitDuration {get; set;}
    
    public string FrequencyType {get; set;}
    
    public integer Frequency {get; set;}
    
    public ScheduleServiceVisitsController(ApexPages.StandardSetController controller) {

        ContractId = apexpages.currentpage().getparameters().get('id');
        
        Contract CurrentContract=[Select id, Accountid from Contract where id=:Contractid];
        list<case> ListOfCase=[Select id from Case where ServiceContract_Case__c=:Contractid];
        
        ServiceVisitObject =new SV__c();
        ServiceVisitObject .Contract__c=ContractId ;
        //ServiceVisitObject.Owner__c=UserInfo.GetUserid();
        if(ListOfCase!=null && ListOfCase.size()>0) ServiceVisitObject.Case__c=ListOfCase[0].id;
        ServiceVisitObject .Account__c=CurrentContract.Accountid;
    }
    
    public List<SelectOption> getFrequencyTypeItems() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('Month','Month'));
            options.add(new SelectOption('Year','Year'));
            options.add(new SelectOption('Week','Week'));
            options.add(new SelectOption('Day','Day'));
            return options;
    }
    
   public pageReference returnBackToContract(){
        pageReference pgRef=new pageReference('/'+ ContractId);
        pgRef.SetRedirect(true);
        return pgRef;   
   }
    
    
    
    Public pageReference ScheduleServiceVisits(){
        try{
    
            list<SV__C> ListOfServiceVisits=new list<sv__C>();
            
            date StartDate=ServiceVisitObject.Visit_Date__c;
            
            date EndDate;//=StartDate.AddMonths(VisitDuration);
            
             if(FrequencyType=='Month')
                    EndDate=StartDate.addMonths(VisitDuration*Frequency);
                else if(FrequencyType=='Year')
                    EndDate=StartDate.addYears(VisitDuration*Frequency);
                else if(FrequencyType=='Week')
                    EndDate=StartDate.addDays(7*VisitDuration*Frequency);
                else if(FrequencyType=='Day')
                    EndDate=StartDate.addDays(VisitDuration*Frequency);
               
            
            while(StartDate<EndDate){
            
                sv__C ServiceVisit=new SV__c();
                
                ServiceVisit.Visit_Date__c=startDate;
                ServiceVisit.Owner__C=ServiceVisitObject.Owner__C;
                ServiceVisit.Cost__c=0;
                ServiceVisit.Visit_Reason__c=ServiceVisitObject.Visit_Reason__c;
                ServiceVisit.Account__c=ServiceVisitObject.Account__c;
                ServiceVisit.Case__c=ServiceVisitObject.Case__c;
                ServiceVisit.Contract__c=ContractId ;
                ServiceVisit.status__c='Scheduled';
                ServiceVisit.Notes__C=ServiceVisitObject.Notes__C;
            
                ListOfServiceVisits.add(ServiceVisit);
            
                if(FrequencyType=='Month')
                    StartDate=StartDate.addMonths(Frequency);
                else if(FrequencyType=='Year')
                    StartDate=StartDate.addYears(Frequency );
                else if(FrequencyType=='Week')
                    StartDate=StartDate.addDays(7*Frequency);
                else if(FrequencyType=='Day')
                    StartDate=StartDate.addDays(Frequency );
            }                            
            
            
            Insert ListOfServiceVisits;
            
            return returnBackToContract();
         }
         catch(exception e){
             ApexPages.addMessages(e);
         }
         return null;
    }
    
    Public pageReference Cancel(){
        return returnBackToContract();
    }

}