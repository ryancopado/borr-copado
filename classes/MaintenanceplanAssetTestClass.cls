@isTest(seealldata=true) 
public class MaintenanceplanAssetTestClass
{
    static testMethod void testMethod1() 
 {
  MaintenancePlan  MP=new MaintenancePlan ();
  MP.StartDate=Date.newInstance(2019, 3, 22);
  MP.Type__c='Primary PM';
  MP.Frequency=1234;
  MP.FrequencyType='Months';
  MP.GenerationTimeframe=12;
  MP.GenerationTimeframeType='Months'; 
  

  MP.NextSuggestedMaintenanceDate=Date.newInstance(2019, 3, 22);
 MP.ServiceContract__c='80034000002LoiFAAS';
 Insert MP;
        }
}