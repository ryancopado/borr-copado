@isTest(seealldata=true)
public class MyControllerTestClass 
{
 static testMethod void testMethod2() 
{
  User owner = [select Id from User where Name = 'Michael Hall']; 
    Account AccMake = new Account(Name = 'TOOTALOO - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert AccMake;   
    Opportunity OppMake = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 2456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting',Team__c='a1O2H00000D2ijv'); insert OppMake;            


Site__c testAccount = new Site__c();
AcctSeed__Project__c testproject= new AcctSeed__Project__c();
ProjectDeadline__c  testprojectdeadline = new ProjectDeadline__c();
Account testrecord = new Account();
testrecord.Name='testaccount';
testrecord.Branch__c='Mid-Atlantic';
testrecord.Phone='(609)-524-4500';
testrecord.Type='service';
testrecord.Industry='Electric Utilities';
testrecord.Job_Type__c='Private';
testrecord.Description='NY Community Solar - developer'; 
insert testrecord;  
        
testproject.Name='testaccount-montevideo';
testproject.Branch__c='Midwest';
insert testproject; 
//testprojectdeadline.Name='PD-0000018';
testprojectdeadline.AssociatedMilestone__c='FNTP Date';
 //testprojectdeadline.AtRisk__c='AtRisk';
    //testprojectdeadline.Site__c='NRG-OYA MN - Montevideo';
   //testprojectdeadline.Project__c='testproject.id';   
    //insert testprojectdeadline;     
   
testAccount.Name ='testaccount-montevideo';
testAccount.Opportunity__c=OppMake.id;
testAccount.Site_Address__c='4795 345th Ave';
testAccount.Site_City__c='Montevideo';
testAccount.Site_Zip__c='52625';
testAccount.Site_State__c ='Minnesota'; 
testAccount.Type__c='Fixed Ground';
//testAccount.Project__c  ='testproject.id';
//testAccount.Overall_Project_Status__c='Design';
 
   

insert testAccount;
Test.StartTest();
PageReference pageRef = Page.PortfolioDashboard;
//pageRef.getParameters().put('id','a6934000000NDJRAA4');
//pageRef.getParameters().put('id','a6934000001gRgzAAE');

Test.setCurrentPage(pageRef);
//MyController testAccPlan = new MyController();
PortfolioDashboardController testAccPlan = new PortfolioDashboardController();
testAccPlan.getprojects();
testAccPlan.method1();
Test.StopTest();


 }
}