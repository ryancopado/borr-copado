trigger contract_Contacts on Contract (after insert,after Update) {

    //List<Contact> GlobalListOfContact=new List<Contact>();
    Map<Id, Contact> GlobalMapOfContact = new Map<Id, Contact>();
    List<Production_Modeling__c> ListOfProductionModeling=new List<Production_Modeling__c>();
        
    Map<id,Contract> MapOfContactRole=new Map<id,Contract>();  
    MAP<ID,Contract> MAPOfProjectID=new MAP<ID,Contract>();
    //MAP<ID,Contract> MapOfAccountID=new MAP<ID,Contract>();
    MAP<ID,Contract> MAPOfOpportunityID=new MAP<ID,Contract>();
    MAP<ID,Contract> MAPOfContactID=new MAP<ID,Contract>();
    Map<ID,Contract> MapOFContract=new Map<ID,Contract>();
    
    
    if (trigger.isInsert) {
    	system.debug('*****contract_Contacts AFTER INSERT trigger.newMap.size() = ' + trigger.newMap.size() + ' first Id = ' + trigger.new[0].Id);
    } else {
    	system.debug('*****contract_Contacts AFTER UPDATE trigger.newMap.size() = ' + trigger.newMap.size() + ' first Id = ' + trigger.new[0].Id);
    }
    
    ////////////////This portion will set contacts from opportunity=>Account=>Contact
    
    for(Contract Contract: [Select ID,ASProject__r.ACCTSeed__Opportunity__c,ASProject__c FROM 
                                                        Contract WHERE id in :Trigger.newMap.Keyset()]) 
                    MapOFContract.Put(Contract.id,Contract);
    
    
    For(Contract Contract: MapOFContract.values()){
     
        if (Contract.ASProject__c != null) {
        	MAPOfProjectID.Put(Contract.ASProject__c,Contract );
        	if (Contract.ASProject__r.AcctSeed__Opportunity__c != null) {
        		MAPOfOpportunityID.Put(Contract.ASProject__r.ACCTSeed__Opportunity__c,Contract );
        	}
        }
    }  
   
    /*
    For (ProjectPartner__c ProjectPartner:[Select AccountId__c, Primary_Contact__c, Role__c,ASProject__c  From ProjectPartner__c 
                                    where ASProject__c in :MAPOfProjectID.keyset() and Primary_Contact__c != null]){
                                    
               Contract Contract=MAPOfProjectID.get(ProjectPartner.ASProject__c);
               MapOfAccountID.put(ProjectPartner.Primary_Contact__c, Contract);
               
    }
    
    FOR(Contact Contact : [Select Id From Contact where id in :MapOfAccountID.KeySet()])
    {
         Contract Contract=MapOfAccountID.get(Contact.id);
         Contact.Contract__c=Contract.id;
         //GlobalListOfContact.add(Contact);
         GlobalMapOfContact.put(Contact.Id, Contact);
    }
    */
    
    For(Production_Modeling__c  ProductionModel:[Select Id,Opportunity__c , Name, Annual_Production_MWh__c, Specific_Yield_kWh_kWp__c 
                        From Production_Modeling__c where Opportunity__c in :MAPOfOpportunityID.KeySet()
                        and Status__c!= 'Bradley Approved']){
          
          Contract Contract=MAPOfOpportunityID.get(ProductionModel.Opportunity__c);
          ProductionModel.Contract_del__c=Contract.id;          
          ListOfProductionModeling.ADD(ProductionModel);                       
     }
                        
    
    
    /////////////////////////////////////////////////////////////////////////////////////
    
    
   
    For(OpportunityContactRole  OCR:  [Select Role, ContactId,ID,OpportunityId  From OpportunityContactRole 
                            where OpportunityId in :MAPOfOpportunityID.KeySet()]){
                            
                                Contract Contract=MAPOfOpportunityID.get(OCR.OpportunityId );
                                MapOfContactRole.put(OCR.ContactId,Contract);
                                
                            }
    
    
     
    
	For(Contact Contact:[Select id,Contract__C from Contact where id in :MapOfContactRole.KeySet()]){
    
		Contract Contract=MapOfContactRole.get(Contact.id);
		
		Contact.Contract__c=Contract.id;
		//GlobalListOfContact.add(Contact);
		GlobalMapOfContact.put(Contact.Id, Contact);
          
     }
      //Update GlobalListOfContact;
      update GlobalMapOfContact.values();
      
      Update ListOfProductionModeling;
      
      
      ////////////////////////Pull Project Partners from related projects/////////////////////////////////////////
     
     List<id> ListOfProjectIDs=new List<id>();
     
     /*
     List<ProjectPartner__c> ListOfProjectPartner=new List<ProjectPartner__c>();     
     
     Map<id,ProjectPartner__c> MapOfProjectPartner=new Map<id,ProjectPartner__c>();
     */
     
     MapOfContract=new Map<id,Contract>();     
                                      
     For(Contract Contract:Trigger.new)
     {
         ListOfProjectIDs.add(Contract.ASProject__c);
         MapOfContract.put(Contract.ASProject__c,Contract);
     }
      
     
     /*
     For(ProjectPartner__c ProjectPartner:[Select id,ASProject__c From ProjectPartner__c
                                      Where ASProject__c in :ListOfProjectIDs])
      {
      
          Contract Contract=MapOfContract.get(ProjectPartner.ASProject__c);
          ProjectPartner.Contract__c=Contract.id;
          ListOfProjectPartner.Add(ProjectPartner);
          
          //MapOfProjectPartner.Put(ProjectPartner.ASProject__c ,ProjectPartner);
      }
      
      Update ListOfProjectPartner;
      */
      
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////      
    
}