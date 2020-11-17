/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ProductionModelingTestControllers {
    
    
    static testMethod void myUnitTest() {
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
          pm.add(new Production_Modeling__c(Name = 'Test test', Opportunity__c = o[0].Id,Date_Needed_By__c=Date.newinstance(2018, 3, 11)));
          insert pm;
          
          Update pm;
    }
}