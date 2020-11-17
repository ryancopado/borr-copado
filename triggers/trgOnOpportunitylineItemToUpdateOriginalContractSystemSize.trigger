trigger trgOnOpportunitylineItemToUpdateOriginalContractSystemSize  on OpportunityLineItem (After Insert,After Update) {

    Map<string,Decimal> MapOfOpportunityOriginalSysSize = New Map<string,Decimal>();
    Set<Id> SetOfOpportunityIds = new Set<Id>();
    List<Opportunity> ListOfOpportunities = new List<Opportunity>(); 



    For(OpportunityLineItem OLI:Trigger.New)
        SetOfOpportunityIds.Add(OLI.OpportunityID);
        
    ListOfOpportunities=[Select id,StageName,Original_Contract_System_Size__c from Opportunity
                            Where id IN :SetOfOpportunityIds];
                            
             
    
    For(Sobject sobj:[Select  OpportunityId, Sum(Project_Watts__c)  Sum
                                    from OpportunityLineItem 
                                    Where OpportunityId in : SetOfOpportunityIds and PricebookEntry.Product2.Family='Solar Modules'
                                    Group by OpportunityId]){
    
        MapOfOpportunityOriginalSysSize.Put((string)sobj.Get('OpportunityId'),(Decimal)sobj.Get('Sum'));
    
    }

    For(Opportunity Opp: ListOfOpportunities){
    
        If(Opp.StageName.toLowerCase()!='contract signed' && MapOfOpportunityOriginalSysSize.Get(Opp.Id) != null)
            Opp.Original_Contract_System_Size__c=MapOfOpportunityOriginalSysSize.Get(Opp.Id);
    
    }
    approveELI.IsRecursiveUpdate=True;
        Update ListOfOpportunities;
    approveELI.IsRecursiveUpdate=False;        
}