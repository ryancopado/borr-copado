@isTest
public class Case_ProjectCtlExtTestClass 
{
static testMethod void testMethod1() 
{
AcctSeed__Project__c testAccount = new AcctSeed__Project__c();
testAccount.Name='National Grid - 24 Bouthelier Road - O&M';
testAccount.Site_State__c='MA';
testAccount.Job_Number__c='805-0053';
insert testAccount;
 //Account acc = new Account(Name = 'billybob - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
             //Project_End_Date__c = null, ShippingStreet = 'Main Street', ShippingCity = 'San Francisco');
            //insert acc;
//Contract cntrct = new Contract(Name = 'csvContract', AccountId = 'acc.Id',Contract_Status__c = 'Active');
     // insert cntrct;
Test.StartTest(); 

PageReference pageRef = Page.CaseProject;
Test.setCurrentPage(pageRef);
ApexPages.currentPage().getParameters().put('id',testAccount.id);
ApexPages.currentPage().getParameters().put('Job_Number__c',testAccount.Job_Number__c);

ApexPages.StandardController sc = new ApexPages.StandardController(testAccount);
Case_ProjectCtlExt testAccPlan = new Case_ProjectCtlExt(sc);

//testAccPlan.movetocase();


            
        


Test.StopTest();
}
 }