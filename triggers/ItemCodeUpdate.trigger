trigger ItemCodeUpdate on SFDC_Purchase_Requisition__c (before insert, before update) {

    /*RecordType IT = ([select Id from RecordType where Name = 'IT Request' LIMIT 1]);
    RecordType office = ([select Id from RecordType where Name = 'Office Request' LIMIT 1]);
    RecordType account = ([select Id from RecordType where Name = 'Account Creation Request' LIMIT 1]);
//    RecordType personnel = ([select Id from RecordType where Name = 'Personnel Request' LIMIT 1]);
    
    List<SFDC_Purchase_Requisition__c> itemcodes = new List<SFDC_Purchase_Requisition__c>();
    List<SFDC_Purchase_Requisition__c> cost = new List<SFDC_Purchase_Requisition__c>();
    List<SFDC_Purchase_Requisition__c> deptHead = new List<SFDC_Purchase_Requisition__c>();
    List<SFDC_Purchase_Requisition__c> manager = new List<SFDC_Purchase_Requisition__c>();
    List<SFDC_Purchase_Requisition__c> card = new List<SFDC_Purchase_Requisition__c>();
//    List<SFDC_Purchase_Requisition__c> phone = new List<SFDC_Purchase_Requisition__c>();
//    List<SFDC_Purchase_Requisition__c> position = new List<SFDC_Purchase_Requisition__c>();
        
    for (Integer i = 0; i <Trigger.new.size(); i++) {
        if (Trigger.isInsert){
             if(Trigger.new[i].RecordTypeId == office.Id || Trigger.new[i].RecordTypeId == IT.Id) {
                    itemcodes.add(Trigger.new[i]);
                    cost.add(Trigger.new[i]);
                    deptHead.add(Trigger.new[i]);
                    manager.add(Trigger.new[i]);
             }
             if (Trigger.new[i].RecordTypeId == account.Id) {
                if (Trigger.new[i].Business_Card__c == true) {
                    card.add(Trigger.new[i]);
                }
       //       if (Trigger.new[i].Cell_Phone__c != null) {
       //           phone.add(Trigger.new[i]);
       //       }
             }           
        }
        if (Trigger.isUpdate) {
            if(Trigger.new[i].RecordTypeId == IT.Id || Trigger.new[i].RecordTypeId == office.Id) {
                if((Trigger.old[i].Item_Requested__c != Trigger.new[i].Item_Requested__c)
                    || (Trigger.old[i].Branch__c != Trigger.new[i].Branch__c)){
                    itemcodes.add(Trigger.new[i]);
                }
                if((Trigger.old[i].Item_Requested__c != Trigger.new[i].Item_Requested__c)
                    ||  (Trigger.old[i].Quantity__c != Trigger.new[i].Quantity__c)){
                    cost.add(Trigger.new[i]);
                }
                if((Trigger.old[i].Department__c != Trigger.new[i].Department__c)){
                    deptHead.add(Trigger.new[i]);
                }
                if((Trigger.old[i].OwnerId != Trigger.new[i].OwnerId)){
                    manager.add(Trigger.new[i]);
                }
            }
            if (Trigger.new[i].RecordTypeId == account.Id) {
                if (Trigger.new[i].Business_Card__c == true && Trigger.old[i].Business_Card__c != true) {
                    card.add(Trigger.new[i]);
                }
          //    if (Trigger.new[i].Cell_Phone__c != null && Trigger.old[i].Cell_Phone__c == null) {
          //        phone.add(Trigger.new[i]);
          //    }
            }
    /*      if (Trigger.new[i].RecordTypeId == personnel.Id) {
                if (Trigger.new[i].Status__c == 'Approved' && Trigger.old[i].Status__c != 'Approved') {
                    position.add(Trigger.new[i]);
                } 
            }       
      } */     
    /*}*/
    /*if(itemcodes.size() > 0) {
        ItemCode.addItemCode(itemcodes);
    }
    if(cost.size() > 0) {
        ItemCode.addCalculateCost(cost);
    }
    if(deptHead.size() > 0) {
        ItemCode.addDeptHead(deptHead);
    }
    if(manager.size() > 0) { 
        ItemCode.addManager(manager);
    }
    if(card.size() > 0) {
        ItemCode.newCard(card);
    }
/*     if(phone.size() > 0) {
        ItemCode.newPhone(phone);
    }
    if(position.size() > 0) {
        ItemCode.newPosition(position);
    } */  
}