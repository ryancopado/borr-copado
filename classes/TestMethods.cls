/** 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts. However, this class is
 * public because we want the test data singletons to be available to external
 * test classes. Only private top-level non-exception class types can be
 * marked as tests
 * 
 * Unit test methods take no arguments, commit no data to the database, and 
 * are flagged with the testMethod keyword in the method definition.
 */
 
// @isTest
public class TestMethods {
	
	// starts test utils
	public static Boolean runConReqBeforeTrigger = true;
	
	public static void stopConReqBeforeTrigger(){
		TestMethods.runConReqBeforeTrigger = false;
	}
	
	public static void startConReqBeforeTrigger(){
		TestMethods.runConReqBeforeTrigger = true;
	}
	// ends test utils
    
    // starts test data singletons
    private static Profile testProfile = null;
    
    public static testMethod Profile getProfileStandardUser(){
        if ( null == TestMethods.testProfile ) {
            TestMethods.testProfile = [select id from Profile where name='Standard User']; 
        }
        return TestMethods.testProfile;
    }
    
  /*  public static UserRole testUserRole = null;
	public static testMethod UserRole getUserRoleListingsManager(){
		if ( null == TestMethods.testUserRole ) {
			TestMethods.testUserRole = [select id from UserRole where name='Listings Manager'];
		}
		return testUserRole;
	}*/
	
	public static Account testAccount = null;
	public static testMethod Account getAccount(){
		if ( null == TestMethods.testAccount ) {
			TestMethods.testAccount = new Account(Name = 'Knight - 2456',Type = 'Business',Job_Type__c = 'Residential',Branch__c = 'Berkeley', Project_End_Date__c = null, ShippingCity = 'San Francisco');
			insert TestMethods.testAccount;
		}
		return TestMethods.testAccount;
	}
	
	public static Opportunity testOpportunity = null;
	public static testMethod Opportunity getOpportunity(){
		if ( null == TestMethods.testOpportunity ) {
			TestMethods.testOpportunity = new Opportunity(OwnerId = TestMethods.getUserList()[0].Id, Name = 'Knight - 2456',AccountId = TestMethods.getAccount().Id,Type = 'Turnkey System',		CloseDate = System.today(),StageName = 'Prospecting');
			insert TestMethods.testOpportunity;
		}
		return TestMethods.testOpportunity;
	}
	
	public static List<User> testUsers = null;
	public static testMethod List<User> getUserList(){
		if ( null == TestMethods.testUsers ) {
			List<User> theUsers = new List<User>();
			
		    for(Integer i = 0; i < 20; i++){
		        //User theUser = new User(profileid = getProfileStandardUser().Id, alias = 'standt'+i, email='standarduser'+i+'@testorg.com', emailencodingkey='UTF-8', lastname='Testing'+i, languagelocalekey='en_US', localesidkey='en_US', timezonesidkey='America/Los_Angeles', username='standarduser'+i+'@testorg.com');
		        User theUser = new User(profileid = getProfileStandardUser().Id, alias = 'standt'+i, email='standarduser'+i+'@testorg.com', emailencodingkey='UTF-8', lastname='Testing'+i, languagelocalekey='en_US', localesidkey='en_US', timezonesidkey='America/Los_Angeles', username='ttttt'+i+'@testorg.com', Department='Marketing');
		        theUsers.add(theUser);
		    }
		    TestMethods.testUsers = theUsers;
		    insert TestMethods.testUsers;
		}
		return TestMethods.testUsers;
	}
	
	public static Contact testContact = null;
	public static testMethod Contact getContact(){
		if ( null == TestMethods.testContact ) {
			TestMethods.testContact = new Contact(LastName = 'Toovich', FirstName='Arana' ,AccountId = TestMethods.getAccount().Id);
			insert TestMethods.testContact;
		}
		return TestMethods.testContact;
	}
	
	public static List<AcctSeed__Project__c> testProjects = null;
	public static testMethod List<AcctSeed__Project__c> getProjectList(){
		if ( null == TestMethods.testProjects ) {
			List<AcctSeed__Project__c> theProjects = new List<AcctSeed__Project__c>();
			
			for(Integer i = 0; i < 1; i++){
		        AcctSeed__Project__c theProject = new AcctSeed__Project__c(Name = 'Knight - 2456'+i,AcctSeed__Opportunity__c = TestMethods.getOpportunity().Id, AcctSeed__Account__c = TestMethods.getAccount().Id, SFDC_Project_Stage__c = 'Sales', 
	    								Interconnection_Status__c = 'Submitted', Rebate_Status__c = null, SFDC_Project_End_Date__c = null, 
	    								Job_Number__c = 'TEST_TEST-00-' +i);
	    								//Job_Number__c = 'TEST_TEST-00-' +i, OwnerId = TestMethods.getUserList()[i].Id);
		        theProjects.add(theProject);
		    }
		    TestMethods.testProjects = theProjects;
		    insert TestMethods.testProjects;
		}
		
		return TestMethods.testProjects;
	}
	
	public static Request_for_Information_RFI__c testRfi = null;
	public static testMethod Request_for_Information_RFI__c getRfi(){
		if ( null == TestMethods.testRfi ) {
			TestMethods.testRfi = new Request_for_Information_RFI__c(Subject__c = 'Test', Detailed_Description__c = 'Detailed Test' ,Contact__c = TestMethods.getContact().Id, ASProject__c = getProjectList()[0].Id);
			insert TestMethods.testRfi;
		}
		return TestMethods.testRfi;
	}
	
	public static Attachment testAttachment = null;
	public static testMethod Attachment getAttachment(){
		if ( null == TestMethods.testAttachment ) {
			TestMethods.testAttachment = new Attachment(ParentId = TestMethods.getRfi().Id, Name='test' , Body=getBlob());
			insert TestMethods.testAttachment;
		}
		return TestMethods.testAttachment;

	}
	
	public static Blob testBlob;
	public static testMethod Blob getBlob() {
		return Blob.valueOf('blobString');
	}
	
	
	
}