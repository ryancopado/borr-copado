trigger PSDRevision_WorkingDesign on PSD_Revision__c (after insert, after update, before insert, before update) {
	
	// This trigger makes sure there can only be at most one PSD Revision object for each Pre-Sales Design object
	// with Revision Status equal to "Working Design".
	
	List<PSD_Revision__c> psdrWD = new List<PSD_Revision__c>();
	List<Id> psdIds = new List<Id>();
	List<PSD_Revision__c> otherPSDR = new List<PSD_Revision__c>();
	Boolean isTooManyWD;
	PSD_Revision__c otherWD;
	
	// If this is a before trigger, for each PSD Revision with Revision Status equal to "Working Design", make sure
	// it is the only PSD Revision with that status for its Pre-Sales Design
	if (trigger.isBefore) {
		for (PSD_Revision__c psdr : trigger.new) {
			if (psdr.Revision_Status__c == 'Working Design') {
				psdrWD.add(psdr);
				psdIds.add(psdr.Pre_Sales_Design__c);
			}
		}
		if (!psdIds.isEmpty()) {
			otherPSDR = [select Id, Name, Pre_Sales_Design__c, Revision_Status__c from PSD_Revision__c where Pre_Sales_Design__c in: psdIds];
			for (PSD_Revision__c wd : psdrWD) {
				isTooManyWD = false;
				for (PSD_Revision__c oPSDR : otherPSDR) {
					if (oPSDR.Id != wd.Id && oPSDR.Pre_Sales_Design__c == wd.Pre_Sales_Design__c) {
						if (oPSDR.Revision_Status__c == 'Working Design') {
							isTooManyWD = true;
							otherWD = oPSDR;
						}
					}
				}
				if (isTooManyWD) {
					trigger.newMap.get(wd.Id).addError('Only one PSD Revision per Pre-Sales Design can be marked "Working Design". PSD Revision Name/Id:  ' + otherWD.Name + '/' + otherWD.Id + ', is already marked "Working Design".');
				}
			}
		}
	}
	
	// If this is an after trigger, for each PSD Revision marked "Submitted", change all existing PSD Revision records with
	// Revision Status equal to "Working Design" for the same Pre-Sales Design record to "Previously Approved"
	if (trigger.isAfter) {
		for (PSD_Revision__c psdr : trigger.new) {
			if (psdr.Revision_Status__c == 'Submitted') {
				if (trigger.isUpdate) {
					if (trigger.oldMap.get(psdr.Id).Revision_Status__c != 'Submitted') {
						psdIds.add(psdr.Pre_Sales_Design__c);
					}
				} else {
					psdIds.add(psdr.Pre_Sales_Design__c);
				}
			}
		}
		if (!psdIds.isEmpty()) {
			psdrWD = [select Id, Pre_Sales_Design__c, Revision_Status__c from PSD_Revision__c where Pre_Sales_Design__c in: psdIds and Revision_Status__c =: 'Working Design'];
			for (PSD_Revision__c psdr : psdrWD) {
				psdr.Revision_Status__c = 'Previously Approved';
			}
			if (!psdrWD.isEmpty()) {
				update psdrWD;
			}
		}
	}
}