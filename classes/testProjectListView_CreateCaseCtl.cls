@isTest(seealldata=true)
public class testProjectListView_CreateCaseCtl  {
 /*
   *  Test methods for ProjectListView_CreateCaseCtl
   *
   */
    // Create test data
      static testMethod void testMethod1()  {
      List <AcctSeed__Project__c> lstProj = new List<AcctSeed__Project__c>();
      AcctSeed__Project__c testAccount = new AcctSeed__Project__c();
     
             Account acc = new Account(Name = 'billybob - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
             Project_End_Date__c = null, ShippingStreet = 'Main Street', ShippingCity = 'San Francisco');
            insert acc;
            //Opportunity opp= new Opportunity(Name='billybob - 2456',StageName='Prospecting',CloseDate=system.now().Date(),Project_Likelihood__c='1%',
            //Owner_Type__c='Owner-single site',Did_Borrego_do_EPC__c='External',Opp_Notes__c='test record',Contract_Types_Included__c='basic and reactive',Number_of_Sites__c=1,
            //Site_States__c  ='california');
            //insert opp;
    
               
      Contract cntrct = new Contract(Name = 'csvContract', AccountId = acc.Id, Type__c = 'O&M', Contract_Status__c = 'Active');
   //   insert cntrct;
      testAccount.Name = 'National Grid - 24 Bouthelier Road - O&M';
      testAccount.Site_State__c='MA';
      lstProj.add(testAccount);
      AcctSeed__Project__c testAccount1 = new AcctSeed__Project__c();
      testAccount1.Name='TestAccount';
      testAccount1.Site_State__c='MA';
      lstProj.add(testAccount1);
      insert  lstProj;
      
      Test.startTest();
      Test.setCurrentPage(Page.CreateCaseProjectListView);
      ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstProj);
          lstProj=[select id from AcctSeed__Project__c where contract__c!=null  Limit 1];
      stdSetController.setSelected(lstProj);
      ProjectListView_CreateCaseCtl ext = new ProjectListView_CreateCaseCtl(stdSetController);
    //  ProjectListView_CreateCaseCtl.Contract_Class xyz = new ProjectListView_CreateCaseCtl.Contract_Class(cntrct.id,'abc');
      
      //ext.createCase();
      //cntrctList = [select Id from Contract where Contract_Status__c='Active'];
      //stdSetController = new ApexPages.StandardSetController(lstProj);
      //stdSet.setSelected(cntrctList);
      //stdSetController = new ProjectListView_CreateCaseCtl(lstProj);
      //stdSetController.createCase();
      //ext = new ProjectListView_CreateCaseCtl(stdSetController);
      //ext.Contract_Class();
      Test.stopTest();
 }
}