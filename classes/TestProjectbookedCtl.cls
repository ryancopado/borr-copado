@isTest
public class TestProjectbookedCtl {
    // Test Class for  Lightning Apex Class 
      
     
    static testMethod void testMethod1() 
    {
        
          ASeedAccountingSettingsSetupTest.testDataSetup();
        
          Account acc = new Account(Name = 'nsvAccount');
          insert acc;
      
        
        Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
       
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = acc.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Prospecting', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(),Won_Loss_Explanation__c='test',Tax_Exemption__c='Exempt', Proposal_Submitted_Date__c = System.today(), Financing__c = 'PPA', 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Captive/OnSite').getRecordTypeId());
        insert testOpportunity;
         system.debug('recid' +testOpportunity.RecordTypeId);
        
        AcctSeed__Project__c testProject = new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Account__c = acc.Id, AcctSeed__Opportunity__c = testOpportunity.Id, Branch__c = 'San Diego',PC_Code__c = 10);  // ,PC_Code__c = '10''
        insert testProject;
       
        AcctSeedERP__Sales_Order__c testSalesOrder = new AcctSeedERP__Sales_Order__c(AcctSeedERP__Customer__c = acc.Id, AcctSeedERP__Status__c = 'Open', Project__c = testProject.Id);
        insert testSalesOrder;
        
        Contract cntrct = new Contract(Name = 'csvContract', AccountId = acc.Id, Type__c = 'O&M',ASProject__c=testProject.Id);
    	insert cntrct;

        
         String result = ProjectBookedcontroller.OppUpdate(testOpportunity.id); //This is the first Apex class 
       
      
         Map<Id,string> values = RecordTypeSelector.fetchRecordTypeValues('Opportunity'); // Second Apex class
        
        
         String result2 = constructionreqcontroller.redirect(testProject.Id); // Thirs Apex Class
        
        string result3 = constructionreqcontroller.locksales(testProject.Id); //calling the locksalesbudget class
        List<opportunity>  result4=createcontractfromopp.createcontract(testOpportunity.Id);//calling the createcontract method in createcontractfromopp apex class for createcontract from Opp.
        
        List<contract> result5=createmaintainancecasefromcontract.createMP(cntrct.Id);//calling the createMP method in createmaintainancecasefromcontract apex class for create MP from Contract.
        
        string result6=creatependingworklightning.Projupdate(testProject.Id);
       /*  below is test class for Create Case lightning button */ 
        List<contract> result7 = createcaselightning.ProjectId(testproject.Id);
         Map<Id,string> values1 = createcaselightning.fetchRecordTypeValues(cntrct.Id);
        List<Contract> result8 = createcaselightning.editpage(cntrct.Id);
        
    }
    
	/*	static testmethod void testFetchRecordTypes() {
              Account acc = new Account(Name = 'nsvAccount');
         insert acc;
      
        
        Contact con = new Contact(FirstName = 'Generic', LastName = 'Technician', Title = 'Solar Tech', AccountId = acc.Id);
        insert con;
       
        Opportunity testOpportunity = new Opportunity(Name = 'Test test', AccountId = acc.Id, CloseDate = System.today(), Module_Delivery_Date__c =system.now().Date(),         
                Inverter_Delivery_Date__c =system.now().Date(), Racking_Delivery_Date__c =system.now().Date(), StageName = 'Prospecting', Amount = 500000, Proposed_System_Size__c = 10000,
                System_Owner__c = con.Id, Expected_Rebate__c = 0,Utility_Rate__c = 'N/A', Prevailing_Wage__c = 'No', Original_Contract_System_Size__c = 1000, 
                Type = 'Turnkey System', Approximate_Install_Date__c = System.today(),Won_Loss_Explanation__c='test',Tax_Exemption__c='Exempt', Proposal_Submitted_Date__c = System.today(), Financing__c = 'PPA', 
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Captive/OnSite').getRecordTypeId());
        insert testOpportunity;
           
		
					}*/
		


}