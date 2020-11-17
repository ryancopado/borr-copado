public with sharing class Lead_SingleWhitePagesProCtlExt {
	
	/*
	 *	Lead controller extension - allows access to WhitePagesPro functionality to update Lead 
	 *	record data (name, address, phone, etc.).
	 */
	
	public class LeadPerson_Class {
		public Integer Id {get; set;}
		public Boolean selected {get; set;}
		public String status {get; set;}
		public String phone {get; set;}
		public String lineType {get; set;}
		public WhitePagesPro.WPP_RA_Person_Class person {get; set;}
		
		public LeadPerson_Class() {
			this.Id = null;
			this.selected = false;
			this.status = '';
			this.phone = '';
			this.lineType = '';
			this.person = new WhitePagesPro.WPP_RA_Person_Class();
		}
		
		public LeadPerson_Class(Integer i, Boolean sel, String st, String ph, String lt, WhitePagesPro.WPP_RA_Person_Class p) {
			this.Id = i;
			this.selected = sel;
			this.status = st;
			this.phone = ph;
			this.lineType = lt;
			this.person = p;
			this.person.id = (this.person.id == null) ? '' : this.person.id.substringBefore('.');
		}
	}
	
	public Lead leadRec {get; set;}
	public Boolean isError {get; set;}
	
	private WhitePagesPro.WPP_RA_Response_Class raResp;
	private List<LeadPerson_Class> persons;
	private List<LeadPerson_Class> selectedPersons;
	private Integer personId = 0;
	
	public Lead_SingleWhitePagesProCtlExt(ApexPages.StandardController stdCon) {
		
		isError = false;
		
		this.leadRec = (Lead)stdCon.getRecord();
		this.leadRec = [select Id, Name, City, Company, Country, FirstName, LastName, Phone, PostalCode, State, Street, Updated_with_WhitePages__c 
				from Lead where Id = :this.leadRec.Id];
		
		raResp = new WhitePagesPro.WPP_RA_Response_Class();
		persons = new List<LeadPerson_Class>();
		selectedPersons = new List<LeadPerson_Class>();
	}
	
	public PageReference reverseAddress() {
		
		if (!isError) {
			try {
				raResp = WhitePagesPro.reverseAddress(leadRec.Street, null, leadRec.City, leadRec.PostalCode, leadRec.State, leadRec.Country);
				if (raResp.result != 'SUCCESS') {
					ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Reverse Address lookup error: ' + raResp.result));
				}
			} catch(Exception e) {
				ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Reverse Address lookup exception: ' + e.getMessage()));
			}
		}
		
		return null;
	}
	
	public List<LeadPerson_Class> getpersons() {
		
		if (persons.isEmpty()) {
			if (raResp.result == 'SUCCESS') {
				if (raResp.reverseAddress.current_residents != null) {
					for (WhitePagesPro.WPP_RA_Person_Class cr :raResp.reverseAddress.current_residents) {
						if (cr.phones == null || cr.phones.isEmpty()) {
							persons.add(new LeadPerson_Class(personId, false, 'Resident', '', '', cr));
							personId++;
						} else {
							for (WhitePagesPro.WPP_Phone_Class ph :cr.phones) {
								persons.add(new LeadPerson_Class(personId, false, 'Resident', ph.phone_number, ph.line_type, cr));
								personId++;
							}
						}
					}
				}
			
				if (raResp.reverseAddress.owners != null) {
					for (WhitePagesPro.WPP_RA_Person_Class own :raResp.reverseAddress.owners) {
						if (own.phones == null || own.phones.isEmpty()) {
							persons.add(new LeadPerson_Class(personId, false, 'Owner', '', '', own));
							personId++;
						} else {
							for (WhitePagesPro.WPP_Phone_Class ph :own.phones) {
								persons.add(new LeadPerson_Class(personId, false, 'Owner', ph.phone_number, ph.line_type, own));
								personId++;
							}
						}
					}
				}
			}
		}
		
		return persons;
	}
	
	/* For debug with the VF page purposes
	public List<LeadPerson_Class> getselectedItems() {
        List<LeadPerson_Class> selectedList = null;
        if (selectedPersons.size() > 0) {
            selectedList = selectedPersons;
        }
        return selectedList;
    }
    */
	
	// Record the selected item - we only allow one item to be selected
	public PageReference getselectedPersons() {
		
		// Clear previous selection
		for (LeadPerson_Class sp :selectedPersons) {
			for (LeadPerson_Class cr :persons) {
				if (sp.Id == cr.Id) {
					cr.selected = false;
				}
			}
		}
		
		// Record current selection
		selectedPersons.clear();
		for (LeadPerson_Class cr :persons) {
			if (cr.selected) {
				selectedPersons.add(cr);
			}
		}
		
		return null;
	}
	
	// Update the Lead record with the selected person
	public PageReference saveSelection() {
		LeadPerson_Class selected;
		PageReference pr = null;
		
		if (selectedPersons.size() == 1) {
			selected = selectedPersons[0];
			
			if (selected.person.id == 'Business') {
				leadRec.Company = selected.person.name;
			} else {
				leadRec.FirstName = selected.person.firstname + ' ' + selected.person.middlename;
				leadRec.LastName = selected.person.lastname;
			}
			
			if (String.isNotBlank(selected.phone)) {
				leadRec.Phone = selected.phone;
			}
			
			try {
				update leadRec;
				pr = new PageReference('/' + leadRec.Id);
			} catch(Exception e) {
				ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Lead update exception: ' + e.getMessage()));
			}
		} else {
			ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select one resident or owner.'));
		}
		
		return pr;
	}
}