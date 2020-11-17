trigger trgProductionModelingForApprovalProcess on Production_Modeling__c (before Update) {

    List<Id> oppId = new List<Id>();
    for (Integer i=0; i<Trigger.size; i++) {
        oppId.add(Trigger.new[i].Opportunity__c);
    }
    Map<id,AcctSeed__Project__c > MapOfProjects=new Map<id,AcctSeed__Project__c >();
    
    for(AcctSeed__Project__c Project:[Select id,AcctSeed__Opportunity__c,AcctSeed__Project_Manager__c ,Ownerid
                                        From AcctSeed__Project__c 
                                        where AcctSeed__Opportunity__c in :oppId]){
        if(!MapOfProjects.containsKey(Project.AcctSeed__Opportunity__c))
            MapOfProjects.Put(Project.AcctSeed__Opportunity__c ,Project);
    }
    
    for(Production_Modeling__c ProductionModeling:Trigger.new){
        if(MapOfProjects.containsKey(ProductionModeling.Opportunity__c)){
           ProductionModeling.Project__c= MapOfProjects.get(ProductionModeling.Opportunity__c).id;
           ProductionModeling.Project_Manager__c=MapOfProjects.get(ProductionModeling.Opportunity__c).Ownerid;
        }
    }

   if (Trigger.New.size()==1){
       
        //Production_Modeling__c CloneProductionModeling;
        
        if (Trigger.New[0].IsSubmittedForApproval__c==true){
           
           //CloneProductionModeling=Trigger.New[0].Clone();
           
           //If (Trigger.New[0].Status__c!='Approved for CC')
             //  Trigger.New[0].Status__c='Currently Approved';
               
           Trigger.New[0].IsSubmittedForApproval__c=false;
           //Insert  CloneProductionModeling;
           
           List<Production_Modeling__c> ListOfProductionModel=[Select ID,Status__c 
                                                                   FROM Production_Modeling__c 
                                                                   WHERE Opportunity__c=:Trigger.New[0].Opportunity__c
                                                                   AND ID != :Trigger.New[0].ID
                                                                   And Status__c!='Approved for CC'];
                                                                   
          FOR(Production_Modeling__c ProductionModel:ListOfProductionModel){
          
              ProductionModel.Status__c='Previously Approved';
          
          }
          
          if(ListOfProductionModel!=null && ListOfProductionModel.size()>0)
              Update ListOfProductionModel;

        }
        
        // If we are dealing with a single Production Modeling record that has just been Approved, set the 
        // Current Approved Weather Station field on all Production Modeling records associated with the
        // same Opportunity to the Weather Station Used field on this Production Modeling record.
        if (trigger.new.size() == 1 && trigger.new[0].Status__c == 'Approved' && trigger.new[0].Status__c != trigger.old[0].Status__c) {
        	List<Production_Modeling__c> pmList = new List<Production_Modeling__c>();
        	pmList = [SELECT Id, Current_Approved_Weather_Station__c, Opportunity__c 
        			FROM Production_Modeling__c WHERE Opportunity__c =: trigger.new[0].Opportunity__c AND Id !=: trigger.new[0].Id];
        	trigger.new[0].Current_Approved_Weather_Station__c = trigger.new[0].Weather_Station_Used__c;
        	for (Production_Modeling__c pm : pmList) {
        		pm.Current_Approved_Weather_Station__c = trigger.new[0].Weather_Station_Used__c;
        	}
        	if (pmList.size() > 0) {
        		update pmList;
        	}
        }
    }

}