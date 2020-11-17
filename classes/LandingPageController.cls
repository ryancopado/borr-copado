public with sharing class LandingPageController {
	public LandingPageController(){
	}
	
	public id getAccountID(){
		List<User> ListOfUser=[Select id, Accountid__C from User where id =:UserInfo.getUserId()];
		if(ListOfUser!=null && ListOfUser.size()>0)
			return ListOfUser[0].Accountid__c;
			
		return null;
	}
	
	public static testMethod void TestLandingPageController(){
		LandingPageController LPC=new LandingPageController();
		LPC.getAccountID();
	}
}