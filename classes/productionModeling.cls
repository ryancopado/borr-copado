public with sharing class productionModeling {

	//Class file for future methods needed and/or related to the Production Modeling object.
	//For the moment we only need this class file for the test methods to help run tests for
	//related triggers.
	
	@isTest static void prodModelCreateTest() {
		
		//Create a Production Modeling object to test the related trigger (productionModeling)
		//that fires upon insert.
		//First create the related Account, Opportunity and Project objects
		Account[] a = new Account[0];
	    a.add(new Account(Name = 'Test test', Branch__c = 'Berkeley', ShippingCity = 'Park City')); 
		insert a;
		
	    Opportunity[] o = new Opportunity[0];
	    o.add(new Opportunity(Name = 'Test test', AccountId = a[0].Id, CloseDate = System.today(),
	    								StageName = 'Prospecting', Amount = 500000, Type = 'Turnkey System'));																																						
	    insert o;																								 						
	    
	    AcctSeed__Project__c[] p = new AcctSeed__Project__c[0];
	    p.add(new AcctSeed__Project__c(Name = 'Knight - 2456',AcctSeed__Opportunity__c = o[0].Id, Design_Stage__c = '50% Design'));
	    insert p;
	    
	    //Now create the Production Modeling object which will cause the trigger to fire
	    Production_Modeling__c[] pm = new Production_Modeling__c[0];
	    pm.add(new Production_Modeling__c(Name = 'Test test', Opportunity__c = o[0].Id));
	    insert pm;
	}
}