public with sharing class Opportunity_newCtrlExt {
	
	/*
	 *	Controller extension when creating a new Opportunity.
	 *
	 *	Methods to pre-populate the Name field as the concatenation of two required fields
	 *	provided by the user.
	 *
	 */
	
	ApexPages.StandardController stdController;
	String accIdPageParameter;
	String conIdPageParameter;
	String lookupcmpgnPageParameter;
	String opp6PageParameter;
	String retURL;
	String oppRecordType;
	
	public Opportunity opp {get; set;}
	public Boolean isEnforceOppName {get; set;}
	
	public Opportunity_newCtrlExt(ApexPages.StandardController stdController) {
		
		this.opp = new Opportunity();
		isEnforceOppName = false;
		
		// Get the page parameters if any
		accIdPageParameter = '';
		conIdPageParameter = '';
		lookupcmpgnPageParameter = '';
		opp6PageParameter = '';
		retURL = ApexPages.currentPage().getParameters().get('retURL');
		oppRecordType = ApexPages.currentPage().getParameters().get('RecordType');
		String accountId = ApexPages.currentPage().getParameters().get('accid');
		String contactId = ApexPages.currentPage().getParameters().get('conid');
		String lookupCmpgn = ApexPages.currentPage().getParameters().get('lookupcmpgn');
		String opp6 = ApexPages.currentPage().getParameters().get('opp6');
		if (String.isNotBlank(accountId)) {
			accIdPageParameter = '&accid=' + accountId;
		}
		if (String.isNotBlank(contactId)) {
			conIdPageParameter = '&conid=' + contactId;
		}
		if (String.isNotBlank(lookupCmpgn)) {
			lookupcmpgnPageParameter = '&lookupcmpgn=' + lookupCmpgn;
		}
		if (String.isNotBlank(opp6)) {
			opp6PageParameter = '&opp6=' + opp6;
		}
	}
	
	// Check the Opportunity record type to see if we need to enforce the Name field convention
	public PageReference enforceOppName() {
		PageReference pr = null;
		
		Map<Id, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Opportunity.getRecordTypeInfosById();
		if (oppRecordType != null && rtMap.containsKey(oppRecordType)) {
			String rtName = rtMap.get(oppRecordType).getName();
			if (rtName == 'Development' || rtName == 'Captive/OnSite') {
				isEnforceOppName = true;
			}
		}
		
		if (!isEnforceOppName) {
			pr = new PageReference('/006/e?retURL=' + retURL + accIdPageParameter + conIdPageParameter + opp6PageParameter + lookupcmpgnPageParameter + '&RecordType=' + oppRecordType + '&ent=Opportunity');
		}
		return pr;
	}
	
	public PageReference createNewOpportunity() {
		
		Dynamic_Field_Id_Setting__c fieldIds = Dynamic_Field_Id_Setting__c.getOrgDefaults();
		String oppName = opp.Project_or_Location_Description__c + ' - ' + opp.City__c;
		String bldProjDescField = '&' + fieldIds.Opp_Proj_Loc_Desc_Field_Id__c + '=' + opp.Project_or_Location_Description__c;
		String cityField = '&' + fieldIds.Opp_City_Field_Id__c + '=' + opp.City__c;
		PageReference pr = new PageReference('/006/e?retURL=' + retURL + '&opp3=' + oppName + accIdPageParameter + conIdPageParameter + opp6PageParameter + lookupcmpgnPageParameter + '&RecordType=' + oppRecordType + '&ent=Opportunity' + bldProjDescField + cityField);
		return pr;
	}
	
	public PageReference cancelNewOpportunity() {
		PageReference pr = new PageReference(retURL);
		return pr;
	}
}