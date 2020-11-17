global class expRepButton {
	Webservice static String checkAtt(Id eId){
		String para = '';
		Boolean noAttachment = false;
		
		//Get all the Expense Line Items associated with this Expense Report
		//and verify that each Expense Line Item has an attachment if required
		ELI__c[] el = [select Id, Name, Expenditure_Type__c, Expenditure_Amount__c, (select Id from NotesAndAttachments) 
							from ELI__c where Expense_Header__c = :eId];
		if (el.size() > 0) {
			ER__c e = [select Id, Receipts_Attached__c from ER__c where Id =:eId];
			List<Id> elId = new List<Id>();
			for (Integer i=0; i<el.size(); i++) {
				elId.add(el[i].Id);
			}
			Attachment[] att = [select ParentId from Attachment where ParentId in :elId];
		
			for(Integer i=0; i<el.size(); i++) {
				if(el[i].Expenditure_Type__c != 'Mileage' && el[i].Expenditure_Amount__c > 25.00) {
					noAttachment = true;
					for (Integer m=0; m<att.size(); m++) {
						if (att[m].ParentId == el[i].Id) {
							noAttachment = false;
						}
					}
					if (noAttachment) {
						para += el[i].Name +'\n';
					}
				}
			}
			if (para.length() > 0) {
				e.Receipts_Attached__c = false;
			} else {
				e.Receipts_Attached__c = true;
				para = 'null';
			}
			update e;
			return para;
		} else {
			return 'none';
		}
/*
		for(Integer i=0; i<el.size(); i++){
			NoteAndAttachment[] na = el[i].NotesAndAttachments; 
			if(el[i].Expenditure_Type__c != 'Mileage' && el[i].Expenditure_Amount__c > 25.00 && na.size() <= 0){
				para += el[i].Name +'\n';
			}
		}
		
		if(para.length() > 0) {					
			return para;
		} else {
			return 'null';
		}
*/ 
	}
	Webservice static void submit(String id){
		submitApproval.submit(id, '');
	}
	Webservice static String clone(Id e){
		ER__c ex = [select User__c, Month_Ending__c, OwnerId from ER__c where Id = :e];
		RecordType gl = [select Id from RecordType where Name = 'General Ledger'];
		ELI__c[] el = [select Id, RecordTypeId, Expenditure_Type__c, GL_Code__c,  
							Branch__c, Department__c, Description__c, Cost_Miles__c, Vendor__c from ELI__c 
							where Expense_Header__c = :e and RecordTypeId = :gl.Id];

		ER__c expense = new ER__c(User__c = ex.User__c,
									Month_Ending__c = ex.Month_Ending__c+30,
									OwnerId = ex.OwnerId);
		insert expense;
		
		ELI__c[] elis = new ELI__c[0];
		for(Integer i=0; i<el.size(); i++){
		elis.add(new ELI__c(RecordTypeId = el[i].RecordTypeId,
		 						Branch__c = el[i].Branch__c,
		 						Department__c = el[i].Department__c,
		 						Description__c = el[i].Description__c,
		 						Expenditure_Type__c = el[i].Expenditure_Type__c,
		 						Cost_Miles__c = el[i].Cost_Miles__c,
		 						Expense_Header__c = expense.Id,
		 						Vendor__c = el[i].Vendor__c));	
		}
		insert elis;
		return expense.Id;	
	}
	public static testmethod void buttonTest(){
		expReport.expTest();
	}
}