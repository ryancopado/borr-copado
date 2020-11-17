public class Lead_WhitePagesProCtlExt {
	
	/*
	 *	Controller extension to update the FirstName, LastName, and Phone fields on the selected 
	 *	Lead records using WhitePages.
	 */
	
	private ApexPages.StandardSetController stdSetCon;
	private Map<Id, Lead> leadMap;
	private String filterId;
	
	public List<Lead> selectedLeads;
	public Boolean isError {get; set;}
	
	public Lead_WhitePagesProCtlExt(ApexPages.StandardSetController stdSetCon) {
		this.stdSetCon = stdSetCon;
		selectedLeads = stdSetCon.getSelected();
		filterId = stdSetCon.getFilterId();
		isError = false;
		
		if (selectedLeads.size() > 0 && selectedLeads.size() <= 20) {
			Set<Id> leadIds = new Set<Id>();
			for (Lead ld :selectedLeads) {
				leadIds.add(ld.Id);
			}
			leadMap = new Map<Id, Lead>([select Id, Name, City, Country, FirstName, LastName, Phone, PostalCode, State, Street, Updated_with_WhitePages__c from Lead where Id in :leadIds]);
		} else {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select at least one and no more than 20 Lead records.'));
			isError = true;
		}
	}
	
	// Update the phone number on the lead via WhitePages from name and address information
	public PageReference findPerson() {
		WhitePagesPro.WPP_FP_Response_Class fpResp;
		String errors = 'WhitePages FindPerson Errors:';
		List<Lead> leadUpList = new List<Lead>();
		PageReference pr = null;
		
		if (!isError) {
			
			try {
				for (Lead ld :leadMap.values()) {
					fpResp = WhitePagesPro.findPerson(ld.FirstName + ' ' + ld.LastName, ld.Street, null, ld.City, ld.PostalCode, ld.State, ld.Country);
					if (fpResp.result != 'SUCCESS') {
						errors += ' Lead = ' + ld.Name + ', error = ' + fpResp.result + ';';
					} else if (fpResp.findPerson.person == null || fpResp.findPerson.person.isEmpty()) {
						errors += ' Lead = ' + ld.Name + ', error = no results found;';
					} else if (fpResp.findPerson.person[0].phones == null || fpResp.findPerson.person[0].phones.isEmpty()) {
						errors += ' Lead = ' + ld.Name + ', error = no phone numbers found;';
					} else {
						ld.Phone = fpResp.findPerson.person[0].phones[0].phone_number;
						ld.Updated_with_WhitePages__c = system.now();
						leadUpList.add(ld);
					}
				}
			
				if (!leadUpList.isEmpty()) {
					update leadUpList;
					ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'The phone number field was updated on ' + leadUpList.size() + ' Lead record(s).'));
				}
			} catch(Exception e) {
				ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Lead update exception: ' + e.getMessage()));
			}
			
			if (errors != 'WhitePages FindPerson Errors:') {
				ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, errors));
			}
		}
		
		return pr;
	}
	
	// Update the first name, last name and phone number on the lead via WhitePages from address information
	public PageReference reverseAddress() {
		WhitePagesPro.WPP_RA_Response_Class raResp;
		String errors = 'WhitePages ReverseAddress Errors:';
		List<Lead> leadUpList = new List<Lead>();
		Integer noPhoneCount = 0;
		PageReference pr = null;
		
		if (!isError) {
			
			try {
				for (Lead ld :leadMap.values()) {
					raResp = WhitePagesPro.reverseAddress(ld.Street, null, ld.City, ld.PostalCode, ld.State, ld.Country);
					if (raResp.result != 'SUCCESS') {
						errors += ' Lead = ' + ld.Name + ', error = ' + raResp.result + ';';
					} else if (raResp.reverseAddress.current_residents == null || raResp.reverseAddress.current_residents.isEmpty()) {
						errors += ' Lead = ' + ld.Name + ', no current residents;';
					} else if (raResp.reverseAddress.current_residents[0].id.startsWith('Person')) {
						ld.FirstName = raResp.reverseAddress.current_residents[0].firstname;
						ld.LastName = raResp.reverseAddress.current_residents[0].lastname;
						if (raResp.reverseAddress.current_residents[0].phones == null || raResp.reverseAddress.current_residents[0].phones.isEmpty()) {
							errors += ' Lead = ' + ld.Name + ', no phone number found;';
							noPhoneCount++;
						} else {
							ld.Phone = raResp.reverseAddress.current_residents[0].phones[0].phone_number;
						}
						ld.Updated_with_WhitePages__c = system.now();
						leadUpList.add(ld);
					} else if (raResp.reverseAddress.current_residents[0].id.startsWith('Business')) {
						ld.Company = raResp.reverseAddress.current_residents[0].name;
						if (raResp.reverseAddress.current_residents[0].phones == null || raResp.reverseAddress.current_residents[0].phones.isEmpty()) {
							errors += ' Lead = ' + ld.Name + ', no phone number found;';
							noPhoneCount++;
						} else {
							ld.Phone = raResp.reverseAddress.current_residents[0].phones[0].phone_number;
						}
						ld.Updated_with_WhitePages__c = system.now();
						leadUpList.add(ld);
					} else {
						errors += ' Lead = ' + ld.Name + ', bad current residents id = ' + raResp.reverseAddress.current_residents[0].id + ';';
					}
				}
				
				if (!leadUpList.isEmpty()) {
					update leadUpList;
					ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'The name and company fields were updated on ' + leadUpList.size() + ' Lead record(s) and the phone field was updated on ' + (leadUpList.size() - noPhoneCount) + ' Lead record(s).'));
				}
			} catch(Exception e) {
				ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Lead update exception: ' + e.getMessage()));
			}
			
			if (errors != 'WhitePages ReverseAddress Errors:') {
				ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, errors));
			}
		}
		
		return pr;
	}
}