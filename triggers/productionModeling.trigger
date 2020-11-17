trigger productionModeling on Production_Modeling__c (before insert) {

    //Pull the Design Stage value from the most recently modified, associated Project
    //record (via the Opportunity record) to this Production Modeling record.
    List<Id> oppId = new List<Id>();
    for (Integer i=0; i<Trigger.size; i++) {
        oppId.add(Trigger.new[i].Opportunity__c);
    }
    SFDC_Project__c[] p = [select Id, Opportunity__c, Design_Stage__c
            from SFDC_Project__c where Opportunity__c in:oppId order by LastModifiedDate desc nulls last];
    
    Map<id,AcctSeed__Project__c > MapOfProjects=new Map<id,AcctSeed__Project__c >();
    
    for(AcctSeed__Project__c Project:[Select id,AcctSeed__Opportunity__c,AcctSeed__Project_Manager__c,Ownerid From AcctSeed__Project__c 
                                        where AcctSeed__Opportunity__c in :oppId]){
        if(!MapOfProjects.containsKey(Project.AcctSeed__Opportunity__c))
            MapOfProjects.Put(Project.AcctSeed__Opportunity__c ,Project);
    }
    
    for(Production_Modeling__c ProductionModeling:Trigger.new){
        if(MapOfProjects.containsKey(ProductionModeling.Opportunity__c)){
           ProductionModeling.Project__c= MapOfProjects.get(ProductionModeling.Opportunity__c).id;
           ProductionModeling.Project_Manager__c=MapOfProjects.get(ProductionModeling.Opportunity__c).Ownerid ;
        }
    }
    
    if (p.size() > 0) {
        for (Integer i=0; i<Trigger.size; i++) {
            for (Integer j=0; j<p.size(); j++) {
                if (p[j].Opportunity__c == Trigger.new[i].Opportunity__c) {
                    Trigger.new[i].Design_Stage__c = p[j].Design_Stage__c;
                    break;
                }
            }
        }
    }
    
    // Set the Current Approved Weather Station field of the new Production Modeling records to the
    // Current Approved Weather Station field of an existing Production Modeling record associated
    // with the same Opportunity record.
    List<Production_Modeling__c> pmList = new List<Production_Modeling__c>();
    pmList = [SELECT Id, Current_Approved_Weather_Station__c, Opportunity__c FROM Production_Modeling__c WHERE Opportunity__c IN: oppId];
    Map<Id, Production_Modeling__c> pmMap = new Map<Id, Production_Modeling__c>();
    for (Production_Modeling__c pm : pmList) {
    	if (!pmMap.containsKey(pm.Opportunity__c)) {
    		pmMap.put(pm.Opportunity__c, pm);
    	}
    }
    if (pmList.size() > 0) {
    	for (Production_Modeling__c pm : trigger.new) {
    		if (pmMap.containsKey(pm.Opportunity__c)) {
    			pm.Current_Approved_Weather_Station__c = pmMap.get(pm.Opportunity__c).Current_Approved_Weather_Station__c;
    		}
    	}
    }
}