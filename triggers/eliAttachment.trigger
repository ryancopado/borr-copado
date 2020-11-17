trigger eliAttachment on Attachment (before delete, before insert, before update) {

    //Do not allow any changes to Expense Line Item attachments if the associated
    //Expense Report has been submitted for approval.
    List<Attachment> attTrigger = new List<Attachment>();
    List<Id> pId = new List<Id>();
    if (Trigger.isDelete) {
        for (Integer i=0; i<Trigger.old.size(); i++) {
            attTrigger.add(Trigger.old[i]);
            pId.add(Trigger.old[i].ParentId);
        }
    } else {
        for (Integer i=0; i<Trigger.new.size(); i++) {
            attTrigger.add(Trigger.new[i]);
            pId.add(Trigger.new[i].ParentId);
        }
    }
    ELI__c[] eli = [select Id, Expense_Header__c from ELI__c where Id in:pId];
    if (eli.size() > 0) {
        List<Id> erId = new List<Id>();
        for (Integer i=0; i<eli.size(); i++) {
            erId.add(eli[i].Expense_Header__c);
        }
        ER__c[] er = [select Id, Status__c from ER__c where Id in:erId];
        Map<Id, ER__c> erMap = new Map<Id, ER__c>();
        for (Integer i=0; i<er.size(); i++) {
            erMap.put(er[i].Id, er[i]);
        }
        //Do not allow changes to attachments if Expense Report in approval process

        for (Integer i=0; i<eli.size(); i++) {
            if ( (erMap.get(eli[i].Expense_Header__c).Status__c != 'New')  &&
                 (erMap.get(eli[i].Expense_Header__c).Status__c != 'Rejected') ) {
                for (Integer a=0; a<attTrigger.size(); a++) {
                    if (attTrigger[a].ParentId == eli[i].Id) {
                        attTrigger[a].addError(' Can not change Expense Reports that are in approval process.');
                    }
                }
            }
        }
    }
}