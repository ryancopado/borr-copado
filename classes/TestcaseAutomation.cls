@isTest(seealldata=true)
public class TestcaseAutomation {
    
    static testMethod void testMethod1() 
 {
  // Perform DML here only
  List<serviceappointment> servicerecords= new List<serviceappointment>();
    servicerecords= [select id,Case__c from serviceappointment where ParentRecordStatusCategory ='New'and Case__c!=null  order by status asc limit 1];
     
     serviceappointment records=new serviceappointment();
     serviceappointment SA=new serviceappointment();
     records=servicerecords.get(0);
     SA.status='Scheduled';
     SA.id=records.Id;
     update SA;
     
     
     
 
        }
    
    static testMethod void testMethod2() 
 {
  // Perform DML here only
  List<serviceappointment> servicerecords1= new List<serviceappointment>();
    servicerecords1= [select id,Case__c from serviceappointment where ParentRecordStatusCategory ='New'and Case__c !=null and Case__r.status!='On Hold' order by status desc limit 1 ];
     
     serviceappointment records1=new serviceappointment();
     serviceappointment SA1=new serviceappointment();
     records1=servicerecords1.get(0);
     SA1.status='None';
     SA1.id=records1.Id;
     update SA1;
     
     
     
 
        }


}