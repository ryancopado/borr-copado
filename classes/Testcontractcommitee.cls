@isTest(SeeAllData=true)
public class Testcontractcommitee {
    //Test class for NotifyPB3,PB3Complete controller
    static testMethod void testMethod1() 
    {
        List<Contract_Committee_Submittal__c> sourceList =new List<Contract_Committee_Submittal__c>();
        Contract_Committee_Submittal__c sourceList1=new Contract_Committee_Submittal__c();
        sourceList = [SELECT Id 
                      FROM Contract_Committee_Submittal__c where recordtype.name = 'PB3 Approval' and Execution_Version_of_Lease__c!=null and Lease_Extraction_Form__c != null and Wetlands_Delineation__c != null and GIS_LIDAR_survey__c != null and Skeletal_survey__c != null and Title_Report_its_Legal_Review__c != null LIMIT 1];
        sourceList1=sourceList.get(0);
        Contract_Committee_Submittal__c PB3List=new Contract_Committee_Submittal__c();
        
        PB3List=[SELECT Id,name ,status__c,Execution_Version_of_Lease__c,Pricing_Request_Approved__c FROM Contract_Committee_Submittal__c  where recordtype.name = 'PB3 Approval' and Execution_Version_of_Lease__c!=null and  Pricing_Request_Approved__c ='yes' limit 1];
        
        
        String result = NotifyPB3.ConComitteeUpdate(sourceList1.Id); //This is the NotifyPB3 Apex class 
        String result2=Pb3Complete.ConComitteeUpdate(PB3List.Id);// This is Pb3Complete Apex class
        
    }
    
    
    
}