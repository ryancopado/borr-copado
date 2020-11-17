public class FieldUpdate { 
    
    public static void addHandOffDate(SFDC_Project__c[] pros){
    } 
    public static void addEndDate(SFDC_Project__c[] pros) {
    }
    public static void addRebateDate(SFDC_Project__c[] pros) {
    }
    public static void addInterconnectionDate(SFDC_Project__c[] pros) {
    }
     public static void addCompleteStatus(SFDC_Project__c[] pros) {
    }
    public static void ownerUpdate(Map<Id, SFDC_Project__c> updatedProjs) {
    }
    
    public static void addHandOffDate(AcctSeed__Project__c[] pros){
       for (AcctSeed__Project__c p:pros){
            if(p.Hand_off_Date__c == null){
               p.Hand_off_Date__c = System.today();
            }
        }
    } 
    public static void addEndDate(AcctSeed__Project__c[] pros) {
        for (AcctSeed__Project__c p:pros) {
            if (p.SFDC_Project_End_Date__c == null){
                p.SFDC_Project_End_Date__c = System.today();
            }
        }
    }
    public static void addRebateDate(AcctSeed__Project__c[] pros) {
        for (AcctSeed__Project__c p:pros) {
            p.Rebate_Date__c = System.today();
        }
    }
    public static void addInterconnectionDate(AcctSeed__Project__c[] pros) {
        for (AcctSeed__Project__c p:pros) {
            p.Interconn_Date__c = System.today();
        }
    }
     public static void addCompleteStatus(AcctSeed__Project__c[] pros) {
        for (AcctSeed__Project__c p:pros) {
            if (p.Overall_Project_Status__c != 'Completed'){
                p.Overall_Project_Status__c = 'Completed';
            }
        }
    }
    public static void ownerUpdate(Map<Id, AcctSeed__Project__c> updatedProjs) {
        List<Con_Req__c> upReqs = new List<Con_Req__c>();
        for (Con_Req__c r : [SELECT Project_PM__c, ASProject__c, Status__c FROM Con_Req__c WHERE ASProject__c in :updatedProjs.keySet() and 
                             Status__c != 'Approved']) {
            AcctSeed__Project__c parentProj = updatedProjs.get(r.ASProject__c);
            r.Project_PM__c = parentProj.OwnerId;           
            upReqs.add(r);
        }
        update upReqs; 
    }
    public static testMethod void FieldUpdateTest(){
        ProjectTest.FieldUpdate();
        
        
        
        FieldUpdate.addHandOffDate(new SFDC_Project__c[]{}); 
        FieldUpdate.addEndDate(new SFDC_Project__c[]{}); 
        FieldUpdate.addRebateDate(new SFDC_Project__c[]{}); 
        FieldUpdate.addInterconnectionDate(new SFDC_Project__c[]{}); 
        FieldUpdate.addCompleteStatus(new SFDC_Project__c[]{}); 
        FieldUpdate.ownerUpdate(new Map<Id, SFDC_Project__c>() ); 
        
        
        
        
        
    }
}