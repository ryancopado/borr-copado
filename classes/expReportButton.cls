global class expReportButton {
	webService static void processExp(Id[] expId){
		ER__c[] ex = [select Id, Status__c from ER__c where Id in :expId];
		for(Integer i = 0; i<ex.size(); i++){
			if(ex[i].Status__c == 'Approved'){
				ex[i].Status__c = 'Processed by Accounting';
			}
		}
		update ex;		
	}
	public static testMethod void recallTest(){
		//ER__c ex = [select Id from ER__c where Status__c != 'Approved' LIMIT 1];
		//ER__c exp = [select Id from ER__c where Status__c = 'Approved' LIMIT 1];	
		
		ER__c ex = new ER__c(Status__c='Approved', Month_Ending__c=date.today());
		ER__c exp = new ER__c(Status__c='Processed by Accounting',Month_Ending__c=date.today());
		
		List<ER__c> myErcs = new List<ER__c>();	
		myErcs.add(ex);
		myErcs.add(exp);
		
		insert myErcs;
		
		Test.startTest();

/*  commented out by tburre@soliantconsulting.com on 091217
	    Id[] expIds = new Id[0];
	    expIds.add(ex.Id);
	    expIds.add(exp.Id);
	    expReportButton.processExp(expIds);
*/	    
// added by tburre@soliantconsulting.com on 091217 to replace above code
	    Id[] expIds = new List<Id>();	
	    expIds.add(myErcs[0].id);
	    expIds.add(myErcs[1].id);
	    expReportButton.processExp(expIds);
	    
	    Test.stopTest();
	} 
}