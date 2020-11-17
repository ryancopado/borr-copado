public with sharing class ReviewServicePurchaseOrder {

    private final Service_PO__c ServicePurchaseOrder;
    private String reqs;
    private Service_Construction_Requisition__c ServiceConstructionRequisition;
    private User PM;
    Public Decimal Total{get; Set;}
    
    public ReviewServicePurchaseOrder (ApexPages.StandardController controller) {
        this.ServicePurchaseOrder = (Service_PO__c )controller.getRecord();
        if (ServicePurchaseOrder.SCR_Unit_Cost__c!=null && ServicePurchaseOrder .SCR_Quantity__c!=null)
            Total=((Decimal ) ServicePurchaseOrder.SCR_Unit_Cost__c )* ((Decimal) ServicePurchaseOrder .SCR_Quantity__c);
        else
            Total=0;
    }
    
 
//  public User getPM(){
//    try {
//      PM = [select Username, Name from User where Id = :ServiceConstructionRequisition.Project_PM__c];
//    } catch (Exception e) {
//      PM = [select Username, Name from User where Name = 'Lynne Parker'];
//    }
//    return PM;
//  } 
  
  public Boolean getUser() {
      if(Userinfo.getName() != 'Lynne Parker' && Userinfo.getName() != 'Mary Mathis' 
        && Userinfo.getName() != 'Michael Hall' && Userinfo.getName() != 'Aaron Hall'){
        return false;
      }
      return true; 
    }
  public static testMethod void testImbed() {
        PageReference pageRef = Page.po;
        Test.setCurrentPage(pageRef);
       
         Account Acc= new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert Acc; 
        Contact Contact=new Contact(FirstName='Test',LastName='Tst',Accountid=Acc.ID); Insert Contact;   
         Contract con = new Contract(AccountId = acc.Id); insert con;                                   
         SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;

        Product2 Product=NEW Product2(NAME='Test'); Insert Product;
        Cost_Code__c CostCode=new Cost_Code__c(NAME='Test',Number__c='4'); Insert CostCode;
        
        Service_Construction_Requisition__c SCR=NEW Service_Construction_Requisition__c();
        SCR.Cost_Code__c=CostCode.ID;
        SCR.Date_Needed__c=Date.today();
        SCR.Product__c=Product.ID;
        SCR.Quantity__c=05;        
        SCR.Service_Visit__c=SV.ID;
        SCR.Ship_To_Account__c=Acc.ID;
        SCR.Status__c='New';
      //  SCR.ServiceVisit__c=sv.ID;  
          
        SCR.Tax_Rate__c=23;
        SCR.Type__c='Paid';
        SCR.Cost__c=34;
        SCR.Vendor_Account__c=Acc.ID;        
        SCR.Vendor_Contact__c=Contact.ID;
        
        Insert SCR;
       
        Service_PO__c po = new Service_PO__c();
        
        po.SCR_Vendor_Account__c=Acc.ID;   
        po.Service_Construction_Requisition__c=SCR.id;
        po.SCR_Cost_Code_Cat__c=CostCode.ID;
        //Service_PO__c po = [select Id from Service_PO__c LIMIT 1];
        
        ApexPages.StandardController stdCon = new ApexPages.StandardController(new Service_PO__c ());
        ReviewServicePurchaseOrder ext = new ReviewServicePurchaseOrder (stdCon ); 
        
        ApexPages.currentPage().getParameters().put('id', po.Id);
        ext = new ReviewServicePurchaseOrder (stdCon );
   
     // ext.getPM();
      ext.getUser();     
    } 
}