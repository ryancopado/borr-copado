@isTest(seealldata=TRUE) 
public class TestUpdateMilestoneDates1 
{
 static testMethod void testMethod1() 
 {
 List <Site__c> lstsite = new List<Site__c>();
 
 Site__c testsite = new Site__c();
 testsite.Name='12 River Street - Palmer' ;
 testsite.Opportunity__c='00634000015Qmk9';
 testsite.Site_Address__c='12 River Street';
 testsite.Site_City__c='Palmer';
 testsite.Site_State__c='Massachusetts';
 testsite.Site_Zip__c='01069';
 testsite.Type__c='Fixed Ground';
 testsite.MarkettoOwnerDate__c= Date.newinstance(2018, 10, 21);
 //testsite.ProductDeliveryDateUpdated__c= Date.newinstance(2018, 06, 26);
 testsite.PB9CCApprovalDate__c= Date.newinstance(2018, 10, 21);
 testsite.BuildingPermitObtainedDate__c= Date.newinstance(2018, 06, 20);
 testsite.Handoff_Date__c= Date.newinstance(2018, 10, 21);
 testsite.Mobilization_Date__c= Date.newinstance(2018, 07, 02);
 testsite.ISA_Received_Date__c= Date.newinstance(2018, 10, 22);
 testsite.Energy_Storage_Unit_Delivery_Date__c= Date.newinstance(2018, 09, 24);
 testsite.X25PaymentDate__c= Date.newinstance(2018, 08, 21);
 
 lstsite.add(testsite);
 Site__c testsite1 = new Site__c();
 testsite1.Name='1718 County Route 1- SOUTH' ;
 testsite1.Opportunity__c='0068000000tUDvH';
 testsite1.Site_Address__c='1718 County Route 1- SOUTH';
 testsite1.Site_City__c='Westtown';
 testsite1.Site_State__c='New York';
 testsite1.Site_Zip__c='10998';
 testsite1.Type__c='Fixed Ground';
 testsite1.MarkettoOwnerDate__c= Date.newinstance(2018, 10, 21);
 //testsite1.ProductDeliveryDateUpdated__c= Date.newinstance(2018, 06, 26);
 testsite1.PB9CCApprovalDate__c= Date.newinstance(2018, 10, 21);
 testsite1.BuildingPermitObtainedDate__c= Date.newinstance(2018, 06, 20);
 testsite1.Handoff_Date__c= Date.newinstance(2018, 10, 21);
 testsite1.Mobilization_Date__c= Date.newinstance(2018, 07, 02);
 testsite1.ISA_Received_Date__c= Date.newinstance(2018, 10, 22);
 testsite1.Energy_Storage_Unit_Delivery_Date__c= Date.newinstance(2018, 09, 24);
 testsite1.X25PaymentDate__c= Date.newinstance(2018, 08, 21);
 
 Site__c testsite2 = new Site__c();
 testsite2.Name='3 Perkins Way - Newburyport - Site 1' ;
 testsite2.Opportunity__c='00634000015Nz1Y';
 testsite2.Site_Address__c='3 Perkins Way';
 testsite2.Site_City__c='Newburyport';
 testsite2.Site_State__c='Massachusetts';
 testsite2.Site_Zip__c='01950';
 testsite2.Type__c='Fixed Ground';
 testsite2.MarkettoOwnerDate__c= Date.newinstance(2018, 10, 21);
 //testsite1.ProductDeliveryDateUpdated__c= Date.newinstance(2018, 06, 26);
 testsite2.PB9CCApprovalDate__c= Date.newinstance(2018, 10, 21);
 testsite2.BuildingPermitObtainedDate__c= Date.newinstance(2018, 06, 20);
 testsite2.Handoff_Date__c= Date.newinstance(2018, 10, 21);
 testsite2.Mobilization_Date__c= Date.newinstance(2018, 07, 02);
 testsite2.ISA_Received_Date__c= Date.newinstance(2018, 10, 22);
 testsite2.Energy_Storage_Unit_Delivery_Date__c= Date.newinstance(2018, 09, 24);
 testsite2.X25PaymentDate__c= Date.newinstance(2018, 08, 21);
 
 lstsite.add(testsite2);
 insert  lstsite;
 
 List <ProjectDeadline__c> lstprojectdeadline = new List<ProjectDeadline__c>();
 ProjectDeadline__c testprojectdeadline = new ProjectDeadline__c();
 testprojectdeadline.Project__c='a1t340000034GBh';
 testprojectdeadline.Site__c='a6934000000Bie8';
 testprojectdeadline.DeadlineDate__c=Date.newinstance(2018, 10, 12);
 testprojectdeadline.AssociatedMilestone__c='Building Permit';
 lstprojectdeadline.add(testprojectdeadline );
 //insert lstprojectdeadline;
 
 
 ProjectDeadline__c testprojectdeadline1 = new ProjectDeadline__c();
 testprojectdeadline1.Project__c='a1t340000037Rm3';
 testprojectdeadline1.Site__c='a6934000001gRgz';
 testprojectdeadline1.DeadlineDate__c=Date.newinstance(2018, 10, 12);
 testprojectdeadline1.AssociatedMilestone__c='Building Permit';
 lstprojectdeadline.add(testprojectdeadline1 );
 insert lstprojectdeadline;
 
 
 Test.startTest();
  Test.setCurrentPage(Page.UpdateMilestondDates);
  ApexPages.StandardSetController stdSetController= new ApexPages.StandardSetController(lstsite);
  stdSetController.setSelected(lstsite);
  
  UpdateMilestoneDates1 ext = new UpdateMilestoneDates1(stdSetController);
  //ext.selectedsiteid=lstsite[0].id;
  ext.selectedsiteid='a6934000001gRgz';
  List<SelectOption> lst = ext.Sitelist1;
  
  //ext.siteSelected();
  
  ext.getsiterecords();
  //System.assertEquals(0, ext.SiteList.size());
  
  ext.Save();
 Test.stopTest();
 }
}