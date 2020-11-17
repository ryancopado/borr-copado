public class ItemCode {

/* deactivate as per emily 12/141/18 -- MG
    public static void addItemCode(SFDC_Purchase_Requisition__c[] reqs){
        for (SFDC_Purchase_Requisition__c r:reqs) {
            SFDC_Purchase_Items__c itemCode = [select Item_Code__c, Standard_Cost__c, Type__c from SFDC_Purchase_Items__c where Id = :r.Item_Requested__c];
            Branch__c branchCode = [select Code__c from Branch__c where Id = :r.Branch__c];
            if (itemCode.Standard_Cost__c < 1000) {
                r.Item_Code__c = '01-' + branchCode.Code__c + '-' + itemCode.Item_Code__c;
            }
            else if (itemCode.Standard_Cost__c >= 1000 && itemCode.Type__c == 'Hardware') {
                 r.Item_Code__c = '01-000-1740.00';
            }
            else if (itemCode.Standard_Cost__c >= 1000 && itemCode.Type__c == 'Software') {
                 r.Item_Code__c = '01-000-1745.00';
            }
        }
    }
    public static void addCalculateCost(SFDC_Purchase_Requisition__c[] reqs){
        for (SFDC_Purchase_Requisition__c r:reqs) {
            SFDC_Purchase_Items__c itemCode = [select Standard_Cost__c from SFDC_Purchase_Items__c where Id = :r.Item_Requested__c];
            r.Cost__c = itemCode.Standard_Cost__c*r.Quantity__c;
        }
    }
    public static void addDeptHead(SFDC_Purchase_Requisition__c[] reqs){
        for (SFDC_Purchase_Requisition__c r:reqs) {
            Department__c dept = ([select Department_Head__c, Executive__c from Department__c where Id = :r.Department__c]);
                r.Department_Head__c = dept.Department_Head__c;
                r.Executive__c = dept.Executive__c;
        }
    } 
    public static void addManager(SFDC_Purchase_Requisition__c[] reqs){
        for (SFDC_Purchase_Requisition__c r:reqs) {
            User manager = ([select ManagerId from User where Id = :r.OwnerId]);
                r.Manager__c = manager.ManagerId; 
        }
    }
    public static void newCard(SFDC_Purchase_Requisition__c[] reqs){
        
        // RecordType account = ([select Id from RecordType where Name = 'Business Card Request' LIMIT 1]);
        RecordType account = ([select Id from RecordType where Name = 'Personnel Request' LIMIT 1]);
        
        for (SFDC_Purchase_Requisition__c r:reqs) {
            SFDC_Purchase_Requisition__c bCard = new SFDC_Purchase_Requisition__c(RecordTypeId = account.Id, Employee_Name__c = r.Employee_Name__c, Employee_Title__c = r.Employee_Title__c, Department__c = r.Department__c, Branch__c = r.Branch__c);
            insert bCard;
        }
    }
/*    public static void newPhone(SFDC_Purchase_Requisition__c[] reqs){
    
        RecordType phone = ([select Id from RecordType where Name = 'Cell Phone Request' LIMIT 1]);

        for (SFDC_Purchase_Requisition__c r:reqs) {
            SFDC_Purchase_Requisition__c cPhone = new SFDC_Purchase_Requisition__c(RecordTypeId = phone.Id, Employee_Name__c = r.Employee_Name__c, Employee_Title__c = r.Employee_Title__c, Department__c = r.Department__c, Branch__c = r.Branch__c, Cell_Phone__c = r.Cell_Phone__c);
            insert cPhone;
            NoRoleEmail.addNoRoleEmail(UserInfo.getUserId(), 'Complete Cell Phone Request', cPhone.Id, false);
        }
    }
    public static void newPosition(SFDC_Purchase_Requisition__c[] reqs){
        Position__c[] position = new Position__c[]{};
        for (SFDC_Purchase_Requisition__c r:reqs) {
            position.add(new Position__c(Name = r.Employee_Title__c, Start_Date__c = r.Start_Date__c, Branch__c = r.Branch__c, 
                        Department__c = r.Department__c, Hiring_Manager__c = r.Manager__c, Min_Pay__c = r.Minimum__c, 
                        Max_Pay__c = r.Maximum__c, Certifications_Required__c = r.Certifications_Required__c, Education__c = r.Education_Experience__c, 
                        Type__c = r.Type__c, Job_Description__c = r.Job_Description__c, Responsibilities__c = r.Responsibilities__c, 
                        Starting__c = r.Starting__c, Ending__c = r.Ending__c, Duration__c = r.Duration__c, Additional_Notes__c = r.Additional_Notes__c,
                        Current_Employee_Qualify__c = r.Current_Employee_Qualify__c, Who__c = r.Who__c , Replacement__c = r.Replacement__c, 
                        Former_Employee__c = r.Former_Employee__c, Staff_Addition__c = r.Staff_Addition__c, Reason_Staff__c = r.Reason_Staff__c));
        }
        insert position;
    }  
*/ 
  /* deactivate as per emily 12/141/18 -- MG  
    public static testMethod void ItemCode(){
    SFDC_Purchase_Items__c item = new SFDC_Purchase_Items__c(Item_Code__c = '5679.00', Name = 'TestItem', Standard_Cost__c = 10.00, Type__c = 'Hardware'); insert item;
    SFDC_Purchase_Items__c item2 = new SFDC_Purchase_Items__c(Item_Code__c = '6319.00', Name = 'TestItem2', Standard_Cost__c = 1000.00, Type__c = 'Software'); insert item2;
    SFDC_Purchase_Items__c item3 = new SFDC_Purchase_Items__c(Item_Code__c = '6319.00', Name = 'TestItem2', Standard_Cost__c = 1000.00, Type__c = 'Hardware'); insert item3;
    Branch__c branch = new Branch__c(Name = 'Petaluma', Code__c = '007'); insert branch;
    User user = [SELECT Id FROM User WHERE Name = 'System User'];
    User user2 = [SELECT Id FROM User WHERE Name = 'Michael Hall'];
    Department__c dept = new Department__c(Name = 'Engineering', Department_Head__c = user.Id , Executive__c = user.Id); insert dept;
    Department__c dept2 = new Department__c(Name = 'Accounting', Department_Head__c = user.Id , Executive__c = user.Id); insert dept2;
   
    RecordType account = ([select Id from RecordType where Name = 'Personnel Request' LIMIT 1]);
//    RecordType personnel = ([select Id from RecordType where Name = 'Personnel Request' LIMIT 1]);
    SFDC_Purchase_Requisition__c[] req = new SFDC_Purchase_Requisition__c[0];
    req.add(new SFDC_Purchase_Requisition__c(RecordTypeId = account.Id, Department__c = dept.Id, Branch__c = branch.Id, Employee_Name__c = 'John Doe', Employee_Title__c = 'Tester', Business_Card__c = true, Cell_Phone__c = 'PDA'));
    req.add(new SFDC_Purchase_Requisition__c(RecordTypeId = account.Id, Department__c = dept.Id, Branch__c = branch.Id, Employee_Name__c = 'John Doe', Employee_Title__c = 'Tester', Business_Card__c = false, Cell_Phone__c = null));
    req.add(new SFDC_Purchase_Requisition__c(RecordTypeId = account.Id,Department__c = dept.Id, Branch__c = branch.Id, Item_Requested__c = item.Id, Quantity__c = 2.00, Manager__c = user.Id));
//  req.add(new SFDC_Purchase_Requisition__c(RecordTypeId = personnel.Id, Department__c = dept.Id, Branch__c = branch.Id, Employee_Name__c = 'John Doe', Employee_Title__c = 'Tester', Business_Card__c = false, Cell_Phone__c = null)); 
    insert req;
    
    req[1].Business_Card__c = true;
    req[1].Cell_Phone__c = 'PDA';
    update req[1];
    
    req[2].Quantity__c = 10.00;
    req[2].Department__c = dept2.Id;
    req[2].Item_Requested__c = item2.Id;
    update req[2];
    req[2].OwnerId = user2.Id;
    req[2].Item_Requested__c = item3.Id;
    update req[2];
//  req[3].Status__c = 'Approved';
//  update req[3];
    }
    public static testMethod void buttonCode(){
    SFDC_Purchase_Items__c item = new SFDC_Purchase_Items__c(Item_Code__c = '5679.00', Name = 'TestItem', Standard_Cost__c = 10.00); insert item;
    SFDC_Purchase_Items__c item2 = new SFDC_Purchase_Items__c(Item_Code__c = '6319.00', Name = 'TestItem2', Standard_Cost__c = 25.00); insert item2;
    Branch__c branch = new Branch__c(Name = 'Petaluma', Code__c = '007'); insert branch;
    User user = [SELECT Id FROM User WHERE Name = 'System User'];
    Department__c dept = new Department__c(Name = 'Engineering', Department_Head__c = user.Id , Executive__c = user.Id); insert dept;
    Department__c dept2 = new Department__c(Name = 'Accounting', Department_Head__c = user.Id , Executive__c = user.Id); insert dept2;
    SFDC_Purchase_Requisition__c req = new SFDC_Purchase_Requisition__c(Department__c = dept.Id, Branch__c = branch.Id, Item_Requested__c = item.Id, Quantity__c = 2.00); insert req;
    Id[] reqs = new Id[0];
    reqs.add(req.Id);
    POButton.createPO(reqs);
    } 
    
 deactivate as per emily 12/141/18 -- MG   */  
}