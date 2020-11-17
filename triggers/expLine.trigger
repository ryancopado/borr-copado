trigger expLine on ELI__c (before insert, before update) {
 
    List<ELI__c> insertELI = new List<ELI__c>();
    List<ELI__c> updateELI = new List<ELI__c>();
    List<ELI__c> insertGL = new List<ELI__c>();
    List<ELI__c> updateGL = new List<ELI__c>();
    RecordType project = [select Id from RecordType where Name = 'Project Expense'];
    
    List<Id> pId = new List<Id>();
    Map<Id, Id> eliProj = new Map<Id, Id>();
    Map<Id, Id> projBud = new Map<Id, Id>();
    if(Trigger.isInsert){
        for (Integer i = 0; i <Trigger.new.size(); i++) {
      //      eliProj.put(Trigger.new[i].Id, Trigger.new[i].Project__c);
            pId.add(Trigger.new[i].Project__c);
        }
        SFDC_Project__c[] proj = [select Project_Type__c, (select Id from Budgets__r) from SFDC_Project__c where Id in :pId];
        Map<Id, SFDC_Project__c> pType = new Map<Id, SFDC_Project__c>();
        List<Budget_Line_Item__c> lines = new List<Budget_Line_Item__c>();
        Map<Id,List<Budget_Line_Item__c>> bLines = new Map<Id,List<Budget_Line_Item__c>>();
        for (Integer i = 0; i<proj.size(); i++){
            pType.put(proj[i].Id, proj[i]);
            try{
                Budget__c b = proj[i].Budgets__r;
                lines = new List<Budget_Line_Item__c>([select Cost_Code__c, Budget__c, Category_Name__c, 
                                                        Cost_Code_Name__c from Budget_Line_Item__c where Budget__c = :b.Id]);
                bLines.put(proj[i].Id, lines);  
                projBud.put(proj[i].Id, b.Id);
            } catch (Exception e){
                System.debug(e);
            }   
        }
        for (Integer i = 0; i <Trigger.new.size(); i++){
            if(Trigger.new[i].RecordTypeId == project.Id) {
                if(pType.get(Trigger.new[i].Project__c).Project_Type__c == 'PV Direct') {
                    insertELI.add(Trigger.new[i]);
                } else {
                    if(projBud.get(Trigger.new[i].Project__c) != null || Trigger.new[i].PV_Direct__c==true){
                        Budget_Line_Item__c[] blis = bLines.get(Trigger.new[i].Project__c);
                        if(blis!=null && blis.size() > 0){
                            for(Integer k = 0; k < blis.size(); k++)    {
                                if(Trigger.new[i].Cost_Code__c == blis[k].Cost_Code__c) {
                                    Trigger.new[i].Budget_Line_Item__c = blis[k].Id;
                                    insertELI.add(Trigger.new[i]);   
                                }  else {
                                    Trigger.new[i].Budget_Line_Item__c = null;
                                    insertELI.add(Trigger.new[i]); 
                                }
                            }
                        } else{
                            insertELI.add(Trigger.new[i]); 
                        }   
                    } else {
                        Trigger.new[i].addError('Please create a Budget for this Project before submitting your Expense Report.');
                    }
                }
            } else {
                insertGL.add(Trigger.new[i]);
            }
        }
    }
    if(Trigger.isUpdate){
        for (Integer i = 0; i <Trigger.new.size(); i++) {
            if((Trigger.new[i].Cost_Code__c != Trigger.old[i].Cost_Code__c) && Trigger.new[i].RecordTypeId == project.Id){               
                if(Trigger.new[i].PV_Direct__c == false) {  
                    SFDC_Project__c proj = [select Project_Type__c, (select Id from Budgets__r) from SFDC_Project__c 
                                                where Id = :Trigger.new[i].Project__c];
                    Map<Id, SFDC_Project__c> pType = new Map<Id, SFDC_Project__c>();
                    List<Budget_Line_Item__c> lines = new List<Budget_Line_Item__c>();
                    Map<Id,List<Budget_Line_Item__c>> bLines = new Map<Id,List<Budget_Line_Item__c>>();

                    Budget__c b = proj.Budgets__r;
                    lines = new List<Budget_Line_Item__c>([select Cost_Code__c, Budget__c, Category_Name__c, 
                                                            Cost_Code_Name__c from Budget_Line_Item__c where Budget__c = :b.Id]);
                    bLines.put(proj.Id, lines);  
                    projBud.put(proj.Id, b.Id);

                    Budget_Line_Item__c[] blis = bLines.get(Trigger.new[i].Project__c);
                    for(Integer k = 0; k < blis.size(); k++)    {
                        if(Trigger.new[i].Cost_Code__c == blis[k].Cost_Code__c) {
                            Trigger.new[i].Budget_Line_Item__c = null;
                            updateELI.add(Trigger.new[i]);   
                        }  else {
                            Trigger.new[i].Budget_Line_Item__c = null;
                            updateELI.add(Trigger.new[i]); 
                        }
                    }
                } else {
                    updateELI.add(Trigger.new[i]);
                }
            } else if((Trigger.new[i].Expenditure_Type__c != Trigger.old[i].Expenditure_Type__c) || 
                        (Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) ||
                        (Trigger.new[i].Department__c != Trigger.old[i].Department__c) ||
                        (Trigger.new[i].GL_Code__c != Trigger.old[i].GL_Code__c)
                         && Trigger.new[i].RecordTypeId != project.Id) {
                updateGL.add(Trigger.new[i]);
            }
        }
    } 
    if(insertELI.size() > 0) {
        expReport.attachBLI(insertELI);
    }
    if(updateELI.size() > 0){
        expReport.attachBLI(updateELI);
    }
    if(insertGL.size() > 0) {
        expReport.createCode(insertGL);
    }
    if(updateGL.size() > 0){ 
        expReport.createCode(updateGL);
    }  
}