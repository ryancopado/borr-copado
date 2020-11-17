public with sharing class OpportunityProjectSync {
/*

    MAP<Id,Opportunity> newOpps;
    MAP<Id,Opportunity> oldOpps;
    
    MAP<Id,AcctSeed__Project__c> newProjects;
    MAP<Id,AcctSeed__Project__c> oldProjects;


    boolean isInsert ;



    public OpportunityProjectSync(MAP<Id,Opportunity> theNewOpps,MAP<Id,Opportunity> theOldOpps,boolean theIsInsert){
        newOpps = theNewOpps;
        oldOpps = theOldOpps;
        isInsert = theIsInsert;
    }


    public OpportunityProjectSync(MAP<Id,AcctSeed__Project__c> theNewProjects,MAP<Id,AcctSeed__Project__c> theOldProjects,boolean theIsInsert){
        NewProjects = theNewProjects;
        OldProjects = theOldProjects;
        isInsert = theIsInsert;
    }




    public void syncOppWithProject(){
        
        map<String,objectDates> oppDates = new map<String,objectDates>();
    
    
      //Set the Delivery Date Updated field to 'Yes' if the Module Deliver Date,
      //Inverter Deliver Date, or Racking Delivery Date fields have been changed.
      if (isInsert) {
        for (Integer i=0; i<newOpps.values().size(); i++) {
            
            
            objectDates theDate = new objectDates(newOpps.values()[i].Inverter_Delivery_Date__c,newOpps.values()[i].Racking_Delivery_Date__c,newOpps.values()[i].Module_Delivery_Date__c);
            
            
            
            if(theDate.isChanged()){
                oppDates.put(newOpps.values()[i].Id,theDate);
            }
            
          
        }
      }
      
      if (!isInsert) {
        for (Integer i=0; i<newOpps.values().size(); i++) {
            
            
            objectDates theDate = new objectDates(newOpps.values()[i].Inverter_Delivery_Date__c,newOpps.values()[i].Racking_Delivery_Date__c,newOpps.values()[i].Module_Delivery_Date__c,
                                                    oldOpps.values()[i].Inverter_Delivery_Date__c,oldOpps.values()[i].Racking_Delivery_Date__c,oldOpps.values()[i].Module_Delivery_Date__c);
            
            
            
            if(theDate.isChanged()){
                oppDates.put(newOpps.values()[i].Id,theDate);
            }
            
        }
      }
        
        List<AcctSeed__Project__c> projects = [select id,Inverter_Delivery_Date__c,Module_Delivery_Date__c,Racking_Delivery_Date__c,AcctSeed__Opportunity__c from AcctSeed__Project__c where AcctSeed__Opportunity__c in: oppDates.keySet()]; 
        
        for(AcctSeed__Project__c pro:projects){
            
            
            objectDates theProDate = oppDates.get(pro.AcctSeed__Opportunity__c);
            if(theProDate.isInverterChanged(pro.Inverter_Delivery_Date__c) ){
                pro.Inverter_Delivery_Date__c = theProDate.inverter;
                System.debug('updating project with: ' + pro.Inverter_Delivery_Date__c);
            }
            
            if(theProDate.isModuleChanged(pro.Module_Delivery_Date__c) ){
                pro.Module_Delivery_Date__c = theProDate.Module;
                System.debug('updating project with: ' + pro.Module_Delivery_Date__c);
            }
            
            if(theProDate.israckingChanged(pro.Racking_Delivery_Date__c) ){
                pro.Racking_Delivery_Date__c = theProDate.racking;
                System.debug('updating project with: ' + pro.Racking_Delivery_Date__c);
            }
            
            
        }
        
        update projects;
        
    }
    
    
    
    public void syncProjectWithOpp(){
        
        map<String,objectDates> oppDates = new map<String,objectDates>();
    
    
      //Set the Delivery Date Updated field to 'Yes' if the Module Deliver Date,
      //Inverter Deliver Date, or Racking Delivery Date fields have been changed.
      if (isInsert) {
        for (Integer i=0; i<newProjects.values().size(); i++) {
            
            
            objectDates theDate = new objectDates(newProjects.values()[i].Inverter_Delivery_Date__c,newProjects.values()[i].Racking_Delivery_Date__c,newProjects.values()[i].Module_Delivery_Date__c);
            
            
            
            if(theDate.isChanged() && newProjects.values()[i].AcctSeed__Opportunity__c != null){
                oppDates.put(newProjects.values()[i].AcctSeed__Opportunity__c,theDate);
            }
            
          
        }
      }
      
      if (!isInsert) {
        for (Integer i=0; i<newProjects.values().size(); i++) {
            
            
            objectDates theDate = new objectDates(newProjects.values()[i].Inverter_Delivery_Date__c,newProjects.values()[i].Racking_Delivery_Date__c,newProjects.values()[i].Module_Delivery_Date__c,
                                                    oldProjects.values()[i].Inverter_Delivery_Date__c,oldProjects.values()[i].Racking_Delivery_Date__c,oldProjects.values()[i].Module_Delivery_Date__c);
            
            
            
            if(theDate.isChanged()  && newProjects.values()[i].AcctSeed__Opportunity__c != null){
                oppDates.put(newProjects.values()[i].AcctSeed__Opportunity__c,theDate);
            }
            
        }
      }
        
        List<Opportunity> opps = [select id,Inverter_Delivery_Date__c,Module_Delivery_Date__c,Racking_Delivery_Date__c from Opportunity where Id in: oppDates.keySet()]; 
        
        for(Opportunity opp:opps){
            
            
            objectDates theProDate = oppDates.get(opp.Id);
            
            if(theProDate.isInverterChanged(opp.Inverter_Delivery_Date__c)){
                opp.Inverter_Delivery_Date__c = theProDate.inverter;
                System.debug('updating project with: ' + opp.Inverter_Delivery_Date__c);
            }
            
            if(theProDate.isModuleChanged(opp.Module_Delivery_Date__c)){
                opp.Module_Delivery_Date__c = theProDate.Module;
                System.debug('updating project with: ' + opp.Module_Delivery_Date__c);
            }
            
            if(theProDate.israckingChanged(opp.Racking_Delivery_Date__c)){
                opp.Racking_Delivery_Date__c = theProDate.racking;
                System.debug('updating project with: ' + opp.Racking_Delivery_Date__c);
            }
            
            
        }
        
        update opps;
        
    }
    

    
    public class objectDates {
        
        public Date inverter {get;set;}
        public Date racking {get;set;}
        public Date module {get;set;}
        
        
        public Date oldinverter {get;set;}
        public Date oldRacking {get;set;}
        public Date oldModule {get;set;}
        
        
        public objectDates(Date inverterV,Date RackingV,Date ModuleV){
            inverter = inverterV;
            racking = rackingV;
            module = moduleV;
        }
        
        
        public objectDates(Date inverterV,Date RackingV,Date ModuleV,Date oldinverterV,Date oldRackingV,Date oldModuleV){
            
            inverter = inverterV;
            racking = rackingV;
            module = moduleV;
            
            oldinverter = oldinverterV;
            oldracking = oldrackingV;
            oldmodule = oldmoduleV;
        }
        
        public boolean isChanged(){
            if(inverter != oldinverter || racking != oldracking || module != oldmodule){
                return true;
            }
            return false;
        }
        
        
        public boolean isInverterChanged(Date inverterDate){
            if(inverter != oldinverter  && inverterDate != inverter){
                return true;
            }
            return false;
        }
        
        
        public boolean israckingChanged(Date rackingDate){
            if(racking != oldracking  && rackingDate != racking){
                return true;
            }
            return false;
        }
        
        
        public boolean ismoduleChanged(Date moduleDate){
            if(module != oldmodule  && moduleDate != module){
                return true;
            }
            return false;
        }
        
        
        
    }




*/
}