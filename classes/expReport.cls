public class expReport {
  public class MyException extends Exception {} 
  public static void attachBLI(ELI__c[] eli) {    
    List<Id> pID = new List<Id>();
    List<Id> expID = new List<Id>();
    List<Id> ccID = new List<Id>();
//    List<Id> catID = new List<Id>();
    for(Integer i = 0; i < eli.size(); i++){
      pID.add(eli[i].Project__c);
      expID.add(eli[i].Expense_Header__c);
      ccID.add(eli[i].Cost_Code__c);
//      catID.add(eli[i].Category__c);  
    }  
    SFDC_Project__c[] p = [select Id, Project_Type__c, Job_Number__c from SFDC_Project__c where Id in :pID];
    Map<Id, SFDC_Project__c> pType = new Map<Id, SFDC_Project__c>();
    for(Integer i = 0; i<p.size(); i++){
      pType.put(p[i].Id, p[i]);
    }
    Cost_Code__c[] cc = [select Number__c, Category__c, Id from Cost_Code__c where Id in :ccID];
    Map<Id, Cost_Code__c> cNum = new Map<Id, Cost_Code__c>();
    for(Integer i = 0; i<cc.size(); i++){
      cNum.put(cc[i].Id, cc[i]);
    }
 /*      Category__c[] cat = [select Code__c, Id from Category__c where Id in :catID];
       Map<Id, String> cCode = new Map<Id, String>();
    for(Integer i = 0; i<cat.size(); i++){
      cCode.put(cat[i].Id, cat[i].Code__c);
    } */
    for(Integer i = 0; i < eli.size(); i++){  
      if(pType.get(eli[i].Project__c).Project_Type__c == 'PV Direct'){
        eli[i].PV_Direct__c = true;
      }
      eli[i].Code__c = pType.get(eli[i].Project__c).Job_Number__c+' : '+cNum.get(eli[i].Cost_Code__c).Number__c+' '+cNum.get(eli[i].Cost_Code__c).Category__c;    
    }
  }
  public static void createBLI(ELI__c[] elis) {  
    ELI__c[] eli = [select Id, Project__c, Budget_Line_Item__c, Approved_Amount__c, RecordTypeId,
            Cost_Code__c, PV_Direct__c from ELI__c where Id in :elis];
                
    List<Id> pID = new List<Id>();
    for(Integer i = 0; i < eli.size(); i++){
      pID.add(eli[i].Project__c);
    }
    Budget__c[] bud = [select Id, Project__c from Budget__c where Project__c in :pID];
    Map<Id, Budget__c> pBud = new Map<Id, Budget__c>();
    List<Id> bID = new List<Id>();
    for(Integer i = 0; i<bud.size(); i++){
      pBud.put(bud[i].Project__c, bud[i]);
      bID.add(bud[i].Id);
    }
    system.debug(pBud);
    Map<Id, List<Budget_Line_Item__c>> budBli = new Map<Id, List<Budget_Line_Item__c>>();
    Map<Id, Budget_Line_Item__c> bBline = new Map<Id, Budget_Line_Item__c>();
    List<Id> blId = new List<Id>();
    Budget_Line_Item__c[] blis = [select Id, PO_Total__c, Budget__c, Cost_Code__c from Budget_Line_Item__c where Budget__c in :bID];
    System.debug(blis);
    Map<Id, Budget_Line_Item__c> bliMap = new Map<Id, Budget_Line_Item__c>();
    for(Integer i = 0; i<blis.size(); i++){
      bliMap.put(blis[i].Id, blis[i]);
      bBline.put(blis[i].Id, blis[i]);
      blId.add(blis[i].Id);
    }
    for(Integer m = 0; m<bud.size(); m++){
      List<Budget_Line_Item__c> bLines = new List<Budget_Line_Item__c>();
      for(Integer i = 0; i<blId.size(); i++){
        if(bBline.get(blId[i]).Budget__c == bud[m].Id){
          bLines.add(bBline.get(blId[i]));
        }
      }
      budBli.put(bud[m].Id, bLines);
    }
    system.debug(budBli.size());
    
    Map<Id, ELI__c> newELI = new Map<Id, ELI__c>();
    List<ELI__c> newBLine = new List<ELI__c>();
    Map<Id, ELI__c> upELI = new Map<Id, ELI__c>();
    List<Id> newELIp = new List<Id>();
    Map<Id, Budget_Line_Item__c> bliUpdate = new Map<Id, Budget_Line_Item__c>();
    for(Integer i = 0; i < eli.size(); i++){
      if(eli[i].Budget_Line_Item__c != null){
        if(bliMap.get(eli[i].Budget_Line_Item__c).PO_Total__c == null){
          bliMap.get(eli[i].Budget_Line_Item__c).PO_Total__c = 0;
        }
        bliMap.get(eli[i].Budget_Line_Item__c).PO_Total__c += eli[i].Approved_Amount__c;
        bliUpdate.put(bliMap.get(eli[i].Budget_Line_Item__c).Id, bliMap.get(eli[i].Budget_Line_Item__c));
      }
      else if(eli[i].Budget_Line_Item__c == null){
        if(budBli.size() > 0){
          newELI.put(eli[i].Id, eli[i]);  
          Budget_Line_Item__c[] bli = budBli.get(pBud.get(eli[i].Project__c).Id);
          Map<Id, Budget_Line_Item__c> costLine = new Map<Id, Budget_Line_Item__c>();
          system.debug(bli);
          for(Integer m = 0; m<bli.size(); m++){
            costLine.put(bli[m].Cost_Code__c, bli[m]);
          }  
          if(costLine.get(eli[i].Cost_Code__c) != null){
            if(costLine.get(eli[i].Cost_Code__c).PO_Total__c == null){
              costLine.get(eli[i].Cost_Code__c).PO_Total__c = 0;
            }
            costLine.get(eli[i].Cost_Code__c).PO_Total__c += eli[i].Approved_Amount__c;
            eli[i].Budget_Line_Item__c = costLine.get(eli[i].Cost_Code__c).Id;
            upELI.put(eli[i].Id, eli[i]);
            bliUpdate.put(costLine.get(eli[i].Cost_Code__c).Id, costLine.get(eli[i].Cost_Code__c));
            newELI.remove(eli[i].Id);    
          } else {
            newELIp.add(eli[i].Project__c);
            newBLine.add(eli[i]);
          }
        }
      } else {
        newELI.put(eli[i].Id, eli[i]);
        newBLine.add(eli[i]);
        newELIp.add(eli[i].Project__c);
      }
    }
    System.debug(newBLine.size());
    system.debug(newBLine);
    Map<Id, Budget_Line_Item__c> costBLI = new Map<Id, Budget_Line_Item__c>();
    if(newELI.size() > 0) {
      for(Integer k = 0; k<newBLine.size(); k++){ 
        Budget__c budget = pBud.get(newBLine[k].Project__c);
        Budget_Line_Item__c b = new Budget_Line_Item__c(Cost_Code__c = newELI.get(newBLine[k].Id).Cost_Code__c,
                                Budget__c = budget.Id,
                                PO_Total__c = newELI.get(newBLine[k].Id).Approved_Amount__c);  
        if(costBLI.containsKey(newELI.get(newBLine[k].Id).Cost_Code__c)){
          Budget_Line_Item__c budLine = costBLI.get(newELI.get(newBLine[k].Id).Cost_Code__c);
          budLine.PO_Total__c += newELI.get(newBLine[k].Id).Approved_Amount__c;
          costBLI.put(budLine.Cost_Code__c, budLine);
        } else {
          costBLI.put(b.Cost_Code__c, b);
        }                      
      }
    }    
    if(bliUpdate.size() > 0){
      update bliUpdate.values();
      update upELI.values();
    }
    if(costBLI.size() > 0){
      insert costBLI.values();
      for(Integer k = 0; k<newBLine.size(); k++){
        if(costBLI.get(newELI.get(newBLine[k].Id).Cost_Code__c) != null){
          newELI.get(newBLine[k].Id).Budget_Line_Item__c = costBLI.get(newELI.get(newBLine[k].Id).Cost_Code__c).Id;
        }
      }
      update newELI.values();
    }
  }
  public static void createCode(ELI__c[] elis) {
    Map<String, String> brNum = new Map<String, String>{'Berkeley' => '002', 'San Diego' => '001', 
                              'Boston' => '005', 'Corporate' => '998', 'Mid Atlantic' => '008'};
    Map<String, Integer> depNum = new Map<String, Integer>{'Sales' => 5, 'Corporate' => 6, 'Indirect Construction' => 4};
    Map<String, Decimal> glCode = new Map<String, Integer>{'Dues' => 920, 
                                'Training and Education' => 181, 
                                'Proposal Costs' => 750, 
                                'Office Supplies' => 270,
                                'Vehicle Expense' => 420, 
                                'Mileage' => 420,
                                'Moving and Relocation Expenses' => 186,
                                'Other Employee Benefits' => 190,
                                'Company Wide Meetings' => 480,
                                'Branch Meeting Expenses' => 490,
                                'Employee Meals & Entertainment' => 461,
                                'Customer Meals & Entertainment' => 470};
    for(Integer i=0; i<elis.size(); i++){
      if(elis[i].GLedger_Code__c != null){
        if(elis[i].Expenditure_Type__c == 'Other'){
          elis[i].Code__c = '01-'+brNum.get(elis[i].Branch__c)+'-'
          +elis[i].GLedger_Code__c.intValue();
        } else if(glCode.get(elis[i].Expenditure_Type__c) != null){
          if(glCode.get(elis[i].Expenditure_Type__c).precision() == 3){
               elis[i].Code__c = '01-'+brNum.get(elis[i].Branch__c)+'-'+depNum.get(elis[i].Department__c)
               +glCode.get(elis[i].Expenditure_Type__c).intValue();
          } else {
            elis[i].Code__c = '01-'+brNum.get(elis[i].Branch__c)+'-'
            +glCode.get(elis[i].Expenditure_Type__c).intValue();
          }
        } else {
          elis[i].Code__c = '01-'+brNum.get(elis[i].Branch__c)+'-'+depNum.get(elis[i].Department__c)
          +'460';
        }
      }
    }
  }
  public static void addManager(ER__c[] e){
    List<Id> eU = new List<Id>();
    for(Integer i = 0; i<e.size(); i++){
      eU.add(e[i].User__c);
    }
    Map<Id, Id> uMan = new Map<Id, Id>();
    User[] exUse = [select Id, ManagerId from User where Id in :eU];
    for(Integer i = 0; i<exUse.size(); i++){
      uMan.put(exUse[i].Id, exUse[i].ManagerId);
    }
    for(Integer i = 0; i<e.size(); i++){
      e[i].Manager_for_Approval__c = uMan.get(e[i].User__c);
    } 
  }
  public static testmethod void expTest(){
    User mh = [select Id from User where Name = 'Michael Hall' limit 1];
    SFDC_Project__c p = ProjectTestOld.setupTestProj();
      Cost_Code__c[] costcode = new Cost_Code__c[0];
      costcode.add(new Cost_Code__c(Name = 'Test', Number__c = '80394', Category__c = 'L'));
      costcode.add(new Cost_Code__c(Name = 'Test02', Number__c = '80367', Category__c = 'M'));
      costcode.add(new Cost_Code__c(Name = 'Test03', Number__c = '80377', Category__c = 'O'));
      insert costcode;
    
      Budget__c budget = new Budget__c(Project__c = p.Id);  insert budget; 
      
      List<Budget_Line_Item__c> ListOfBudgetLineItem=new List<Budget_Line_Item__c>();
      
      Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[0].Id, 
                                Pending_PO_Total__c = 0.0, 
                                PO_Total__c = 12.00 ); ListOfBudgetLineItem.add( bli);
      Budget_Line_Item__c bli1 = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[1].Id, 
                                Pending_PO_Total__c = 0.0, 
                                PO_Total__c = 12.00 ); ListOfBudgetLineItem.add(  bli1);
      Budget_Line_Item__c bli2 = new Budget_Line_Item__c(Budget__c = budget.Id, Cost_Code__c = costcode[2].Id, 
                                Pending_PO_Total__c = 0.0, 
                                PO_Total__c = 12.00 ); ListOfBudgetLineItem.add(  bli2);
                                
      Insert ListOfBudgetLineItem;                          
    RecordType projE = [select Id from RecordType where Name = 'Project Expense'];
      ER__c er = new ER__c(User__c = p.OwnerId, Month_Ending__c = System.today()); insert er;
    er.User__c = mh.Id; update er;
    
    ELI__c[] eli = new ELI__c[0];
    eli.add(new ELI__c(Expense_Header__c = er.Id, Cost_Code__c = costcode[0].Id,  
              Manager_Approval__c = true, RecordTypeId = projE.Id, Approved_Amount__c = 150.85, 
              Cost_Miles__c = 150.85, Project__c = p.Id));
    eli.add(new ELI__c(Expense_Header__c = er.Id, Cost_Code__c = costcode[1].Id, 
              Manager_Approval__c = true, RecordTypeId = projE.Id, Approved_Amount__c = 258.75, 
              Cost_Miles__c = 258.75, Project__c = p.Id));
    eli.add(new ELI__c(Expense_Header__c = er.Id, Expenditure_Type__c = 'Dues',  
              Manager_Approval__c = true, Approved_Amount__c = 258.75, 
              Cost_Miles__c = 258.75, Project__c = p.Id));                
    insert eli;
    
    p.Project_Type__c = 'PV Direct'; update p;
    ELI__c neli = new ELI__c(Expense_Header__c = er.Id, Cost_Code__c = costcode[2].Id, 
          Manager_Approval__c = true, RecordTypeId = projE.Id, Cost_Miles__c = 258.75, 
          Approved_Amount__c = 500.75, Project__c = p.Id);
    insert neli;  
    
    er.Status__c = 'Approved';
    update er;
    
    expRepButton.checkAtt(er.Id);
    //expRepButton.clone(er.Id);
    er.Receipts_Attached__c = true;
    update er;
    expRepButton.submit(er.Id);    
  }
}