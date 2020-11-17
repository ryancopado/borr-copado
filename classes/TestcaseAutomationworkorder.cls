@isTest(seealldata=true)
public class TestcaseAutomationworkorder {
    
    static testMethod void testMethod1() 
 {
     List<workorder>workorderrecords1=new List<workorder>();
     workorderrecords1=[select Id,CaseId,status from workorder where  Status!='Completed' limit 1];
     workorder WO=new workorder();
     workorder records=new workorder();
     WO=workorderrecords1.get(0);
      records.Id=WO.Id;
     records.status='Completed';
     update records;
}
}