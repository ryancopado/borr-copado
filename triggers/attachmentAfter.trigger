trigger attachmentAfter on Attachment (after insert) {

	Set<Id> rfiIds = new Set<Id> {};

	//build a list of line items so we can use it in the query below
	for ( Attachment currentAttachment : Trigger.new ) {
		rfiIds.add(currentAttachment.ParentId);
	}
	//get a map of BLIs
	List <Request_for_Information_RFI__c> rfiList = [	SELECT Last_Attachment_Date__c 
														FROM Request_for_Information_RFI__c
														WHERE Id IN :rfiIds ];

	for (Request_for_Information_RFI__c currentRfi : rfiList) {
		currentRfi.Last_Attachment_Date__c = System.today();
	}
	update rfiList;
	
}