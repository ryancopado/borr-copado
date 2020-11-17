public class OMPrintPO {
    
    private final AcctSeedERP__Purchase_Order__c con_po;
    
    public Map<string,PO> MapOfDescription;
    
    public Map<string,CO> MapOfCODescription;
    
    public List<Con_Req__c> ListOfCO = new List<Con_Req__c>();
    
    public class PO{
    
        public string description{get; set;}
        
        public string JobNo{get; set;}
        
        public AcctSeedERP__Purchase_Order_Line__c LineItem{get; set;}
        
        Public PO(AcctSeedERP__Purchase_Order_Line__c POLine,string dsc){
            description=dsc;
            LineItem=POLine;
            JobNo='';
            if(POLine.AcctSeedERP__Project_Task__r.AcctSeed__Project__r.Job_Number__c!=null 
                    && POLine.AcctSeedERP__Project_Task__r.AcctSeed__Project__r.Job_Number__c!=''
                    && POLine.AcctSeedERP__Project_Task__r.AcctSeed__Project__r.Job_Number__c.length()>8){
                JobNo=POLine.AcctSeedERP__Project_Task__r.AcctSeed__Project__r.Job_Number__c.mid(0,8);
            }
            else
                JobNo=POLine.AcctSeedERP__Project_Task__r.AcctSeed__Project__r.Job_Number__c;
        }
    
    }
    
    public class CO{
    
        public string description{get; set;}
        
        public Con_Req__c LineItem{get; set;}
        
        public string JobNo{get; set;}
        
        Public CO(Con_Req__c Line,string dsc){
            description=dsc;
            LineItem=Line;
        }
    
    }
    
    
    public list<PO> getListOfPOs(){
        return MapOfDescription.values();
    }
    
    public String getStyle() {

            return 'color: black';

}

 
 /*   
     public list<CO> getListOfCOs(){
        return MapOfCODescription.values();
    }
*/
    public List<Con_Req__c> getListOfCOs() {
        return ListOfCO;
    }
    
    public OMPrintPO(ApexPages.StandardController stdController) {
        
        this.con_po = [select Id, AP_Invoice_Line_Total__c, ARRA_Compliant__c, Additional_Notes__c, CreatedById, CreatedDate, 
                IsDeleted, Delivery_Notes__c, LastActivityDate, LastModifiedById, LastModifiedDate, AcctSeedERP__Order_Date__c, 
                Order_Received_BOL__c, OwnerId, PO_18_Character_ID__c, PO_Line_Total__c, Name, Retention_Percent__c, 
                SOA_Returned__c, AcctSeedERP__Shipping_City__c, AcctSeedERP__Shipping_Company__c, Ship_To_Contact__c, 
                AcctSeedERP__Shipping_Contact__c, AcctSeedERP__Shipping_State__c, AcctSeedERP__Shipping_Street__c, 
                Ship_To_Telephone__c, AcctSeedERP__Shipping_Postal_Code__c, AcctSeedERP__Shipping_Country__c, Shipping_Method__c, 
                Special_Notes__c, AcctSeedERP__Status__c, Subtotals__c, SystemModstamp, AcctSeedERP__Total__c, Total_Cost__c, 
                Total_Freight_Allowed__c, Total_sales_tax__c, AcctSeedERP__Type__c, AcctSeedERP__Vendor__c, 
                AcctSeedERP__Vendor_City__c, AcctSeedERP__Vendor_Contact__c, AcctSeedERP__Vendor_Country__c, 
                AcctSeedERP__Vendor_Postal_Code__c, AcctSeedERP__Vendor_State__c, AcctSeedERP__Vendor_Street__c,Vendor_Reference__c 
                from AcctSeedERP__Purchase_Order__c where Id = :stdController.getRecord().Id];
        
        POLFreight = 0;
        POLSalesTax = 0;
        POLSubTotal = 0;
        POLTotal = 0;
        ChangeOrderTotal = 0;
        Total = 0;
        coTable = false;
        
        /*list<Con_Req__c> ListOfCO=[SELECT Name, Job_Number2__c,Subtotal__c,Amount_Requested__c,Freight__c,Sales_Tax__c,Job_Number__c,Product_Code__c,Product_Description__c FROM Con_Req__c
                            Where Purchase_Order2__c=:this.con_po.id];
                            
        
        if(ListOfCO!=null)
            for(Con_Req__c CO:ListOfCO){
            
                //if(CO.Sales_Tax__c!=null) COSalesTax+=CO.Sales_Tax__c;
                if(CO.Freight__c!=null) COFreight+=CO.Freight__c;
                if(CO.Amount_Requested__c!=null) COSubTotal+=CO.Amount_Requested__c;
                                            
            }*/
        
        ListOfCO = [select Id, Name, Job_Number2__c, CO__c, Subject__c, Description__c, Amount_Requested__c, Amount_Requested_Total__c, Sales_Tax__c  
                from Con_Req__c where Purchase_Order2__c = :this.con_po.Id and Status__c = 'Borrego Approved'];
        AcctSeedERP__Purchase_Order_Line__c[] getshippingcost =[select Unit_Cost__c,AcctSeedERP__Product__r.name from AcctSeedERP__Purchase_Order_Line__c  where AcctSeedERP__Purchase_Order__c=:stdController.getRecord().Id and  AcctSeedERP__Product__r.name ='Shipping and Handling'];    
       AcctSeedERP__Purchase_Order_Line__c unitcost = new AcctSeedERP__Purchase_Order_Line__c();
        if(con_po.Subtotals__c!= null) 
            POLSubTotal += con_po.Subtotals__c;
        
        if (ListOfCO.size() > 0) {
            coTable = true;
            for (Con_Req__c co : ListOfCO) {
                if (co.Amount_Requested_Total__c != NULL) {
                    ChangeOrderTotal += co.Amount_Requested_Total__c;
                }
            }
        }
        
        if(con_po.Total_sales_tax__c != null) 
            POLSalesTax += con_po.Total_sales_tax__c;
        
        if (getshippingcost.size() >0)
        {
            unitcost = getshippingcost.get(0);
        }
        
         system.debug('this is unitcost-->' +unitcost.Unit_Cost__c);
            if (unitcost.Unit_Cost__c != null){
                 POLFreight += unitcost.Unit_Cost__c;
            }

       // if(con_po.Total_Freight_Allowed__c != null) 
          //  POLFreight += con_po.Total_Freight_Allowed__c ;
           POLSubTotal= POLSubTotal -POLFreight;
        POLTotal = POLSubTotal + POLSalesTax ;
        Total = POLTotal + ChangeOrderTotal + POLFreight ;
        
        MapOfDescription=new Map<string,PO>();
        
        MapOfCODescription=new Map<string,CO>();
        
        for(AcctSeedERP__Purchase_Order_Line__c LineItem:[select Vendor_Description__c , Name,
                                                AcctSeedERP__Project_Task__r.AcctSeed__Project__r.Job_Number__c,Requested_Delivery_Date__c
                                                ,AcctSeedERP__Product__r.ProductCode,AcctSeedERP__Product__r.Name,AcctSeedERP__Quantity__c,Unit_Cost__c,AcctSeedERP__Total__c
                                                ,Sales_Tax_Rate_Percent__c,Sales_Tax__c,Freight__c,Vendor_Part_number__c
                                                from AcctSeedERP__Purchase_Order_Line__c 
                                                                    where AcctSeedERP__Purchase_Order__c=:stdController.getRecord().id ]){
                                                                    
                        //and AcctSeedERP__Product__r.name !='Shipping and Handling'
                        string description='';
                        // integer noOfCharInCell=7;
                        integer noOfCharInCell=300;
                        if(LineItem.Vendor_Description__c!=null && LineItem.Vendor_Description__c!=''){
                            integer counter=0;
                            integer max=LineItem.Vendor_Description__c.length()/noOfCharInCell;
                            integer index=0;
                            if(LineItem.Vendor_Description__c.length()>noOfCharInCell){
                                    for(counter=0;counter<max-1;counter++){
                                        description+=LineItem.Vendor_Description__c.substring(index,index+noOfCharInCell)+' ';
                                        index+=noOfCharInCell;
                                    }
                                    
                                   description+=LineItem.Vendor_Description__c.substring(index,LineItem.Vendor_Description__c.length()-1)+' ';
                            }
                            else
                                description+=LineItem.Vendor_Description__c;
                        }        
                        MapOfDescription.Put(LineItem.id,  new PO(LineItem,description));                                                 
                                                                    
        }
        
        /*for(Con_Req__c  LineItem:[select Description__c,
                                                Job_Number2__c,Product__r.ProductCode,Product__r.Name
                                                ,New_QuantityCOConReq__c,Amount_Requested__c,Freight__c
                                                from Con_Req__c  
                                                                    where Purchase_Order2__c=:stdController.getRecord().id]){
                                                                    
                        
                        string description='';
                        integer noOfCharInCell=7;
                        if(LineItem.Description__c!=null && LineItem.Description__c!=''){
                            integer counter=0;
                            integer max=LineItem.Description__c.length()/noOfCharInCell;
                            integer index=0;
                            if(LineItem.Description__c.length()>noOfCharInCell){
                                    for(counter=0;counter<max-1;counter++){
                                        description+=LineItem.Description__c.substring(index,index+noOfCharInCell)+' ';
                                        index+=noOfCharInCell;
                                    }
                                    
                                   description+=LineItem.Description__c.substring(index,LineItem.Description__c.length()-1)+' ';
                            }
                            else
                                description+=LineItem.Description__c;
                        }        
                        MapOfCODescription.Put(LineItem.id,  new CO(LineItem,description));                                                  
                                                                    
        }*/
        
    
    }
    
    private String reqs;
    private Con_Req__c req;
    private User PM;
    private String poClean;
    
    public decimal POLFreight{get; set;}
    public decimal POLSalesTax{get; set;}
    public decimal POLSubTotal{get; set;}
    public decimal POLTotal{get; set;}
    public decimal ChangeOrderTotal{get; set;}        
    public decimal Total{get; set;}    
    public Boolean coTable {get; set;}
    
    
    public string getValue(string id){
       return '';
      // return MapOfDescription.get(id);
    }  
        
/*    
    public String getReqs() {
        try {
            req = [select Project__c, Project_PM__c from Con_Req__c where Purchase_Order__c = :ApexPages.currentPage().getParameters().get('id')];
            SFDC_Project__c proj = [select Name from SFDC_Project__c where Id = :req.Project__c];
            reqs = proj.Name;
        } catch (Exception e) {
            reqs = null;
        }
        return reqs;
    } */
    public User getPM(){
       // try {
       //     PM = [select Username, Name from User where Id = :req.Project_PM__c];
       // } catch (Exception e) {
            PM = [select Username, Name from User where Name = 'System User'];
        //}
        return PM;
    }
    public Boolean getUser() {
        Map<String, PrintPOSignatures__c> poSigMap = PrintPOSignatures__c.getAll();
        User runningUser = new User();
        Boolean poSig = false;
        
        runningUser = [select Id, Alias from User where Id = :UserInfo.getUserId()];
        if (poSigMap.containsKey(runningUser.Alias)) {
            poSig = true;
        }
        
        return poSig;
        
        /*
        if(Userinfo.getName() != 'Lynne Parker' && Userinfo.getName() != 'Mary Mathis' 
            && Userinfo.getName() != 'Michael Hall' && Userinfo.getName() != 'Aaron Hall'
            && Userinfo.getName() != 'Anita Orozco' && Userinfo.getName() != 'Tanya Reas'
            && Userinfo.getName() != 'Sean Osterling'){
            return false;
        }
        return true; 
        */
    }
    
    public String getpoClean() {
        String[] parts = this.con_po.name.split('-');
        String poNum = '1';
        if( parts.size() > 1 ) {
            poNum = parts[1].replaceAll('^0*', '');
            if( poNum.length() == 0 ) return '0';
        }
        return poNum;
    }    
    
    

}