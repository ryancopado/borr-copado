public with sharing class clsGeneratePOInvoiceCSV {

     

    List<DataObjectForPOInvoiceCSV> ListOfDOPOInvoiceCSV=new List<DataObjectForPOInvoiceCSV>();
    DataObjectForPOInvoiceCSV DOPOInvoiceCSV;
    Map<id,PO_Invoice__c> MapOfPOInvoice;
    Map<id,List<Invoice_Distribution_Line__c>> MapOfPOInvoiceLineItem=new Map<id,List<Invoice_Distribution_Line__c>>();
        
             
    Public clsGeneratePOInvoiceCSV (){
        DOPOInvoiceCSV=NEW DataObjectForPOInvoiceCSV();
        String StrPOInvoiceIDs='';
        List<String> ListOfPOInvoiceIds=new List<String>();

        StrPOInvoiceIDs=ApexPages.currentPage().getParameters().get('ID');        
        ListOfPOInvoiceIds=StrPOInvoiceIDs.split(',');
        
      
        MapOfPOInvoice=new Map<id,PO_Invoice__c>([Select ID, VendorID__c,Invoice_Number__c
                ,Description__c,Total_Invoice_Amount2__c,Tax_Amount__c,Discount_Offered__c, Invoice_Date__c
                ,Date_Received__c,Discount_Date__c,Payment_Date__c,PaymentDate__c,Accounting_Date__c,Payment_Date_Override__c,Adjusted_Payment_Date__c  From PO_Invoice__c 
                Where ID IN :ListOfPOInvoiceIds]);
                
        for(Invoice_Distribution_Line__c InvoiceDistLineItem:[Select ID,
                Job_Number__c, New_Cost_Code_No__c,New_Category__c,Tax_Group__c,Tax_Group__r.Name,Amount__c,Tax__c,Tax_Liability__c,
                Retention__c,Description__c,POInvoice__C,GL_Account__c, RecordType.Name,Column_M_Static_Value2__c From Invoice_Distribution_Line__c Where POInvoice__c  IN :ListOfPOInvoiceIds]){
                
                    if (MapOfPOInvoiceLineItem.containsKey(InvoiceDistLineItem.POInvoice__c)){
                        
                        List<Invoice_Distribution_Line__c> ListOfInvDistLineItem=MapOfPOInvoiceLineItem.get(InvoiceDistLineItem.POInvoice__c);
                        if(ListOfInvDistLineItem!=null)
                        ListOfInvDistLineItem.add(InvoiceDistLineItem);
                                                
                    }
                    else{
                      
                        List<Invoice_Distribution_Line__c> ListOfInvDistLineItem=new List<Invoice_Distribution_Line__c>();                    
                        ListOfInvDistLineItem.add(InvoiceDistLineItem); 
                        MapOfPOInvoiceLineItem.PUT(InvoiceDistLineItem.POInvoice__c,ListOfInvDistLineItem);
                    }
                
                }        
        
        
        
    }
    
    Public List<DataObjectForPOInvoiceCSV> GetCSVRecords(){
        for(PO_Invoice__c POInvoice: MapOfPOInvoice.values()){
        
         ListOfDOPOInvoiceCSV.add(SetPOInvoiceData(POInvoice));
         List<Invoice_Distribution_Line__c> ListOfInvDistLineItem=MapOfPOInvoiceLineItem.get(POInvoice.id);
                       
         if(ListOfInvDistLineItem!=null)
            for(Invoice_Distribution_Line__c InvoiceLineItem:ListOfInvDistLineItem)
                If(InvoiceLineItem.RecordType.Name=='General Ledger')
                    ListOfDOPOInvoiceCSV.add(SetGeneralLedgerDistributionLineItemData(InvoiceLineItem));
                Else
                     ListOfDOPOInvoiceCSV.add(SetDistributionLineItemData(InvoiceLineItem));
         
        }
        return ListOfDOPOInvoiceCSV;
    }
    
   Private DataObjectForPOInvoiceCSV SetPOInvoiceData(PO_Invoice__c POInvoice){
   
       DataObjectForPOInvoiceCSV DOForPOInvoice=new DataObjectForPOInvoiceCSV();
       
                DOForPOInvoice.IsPOInvoice=true;
                DOForPOInvoice.PType='APIF';
                DOForPOInvoice.Commitment=POInvoice.VendorID__c;
                If (POInvoice.Invoice_Number__c!=null) DOForPOInvoice.CommitmentLineItem='/'+POInvoice.Invoice_Number__c;
                DOForPOInvoice.Equipment=POInvoice.Description__c;
                DOForPOInvoice.EQCostCode= String.valueof(POInvoice.Total_Invoice_Amount2__c);
                DOForPOInvoice.JobNumber=String.valueof(POInvoice.Tax_Amount__c);
                DOForPOInvoice.Extra=POInvoice.Discount_Offered__c;
                if (POInvoice.Invoice_Date__c!=null) DOForPOInvoice.Category='/'+datetime.newInstance(POInvoice.Invoice_Date__c.year(), POInvoice.Invoice_Date__c.month(),POInvoice.Invoice_Date__c.day()).format('MMddyyyy'); 
                if (POInvoice.Date_Received__c!=null) DOForPOInvoice.BLStdItem='/'+datetime.newInstance(POInvoice.Date_Received__c.year(), POInvoice.Date_Received__c.month(),POInvoice.Date_Received__c.day()).format('MMddyyyy');
                if (POInvoice.Discount_Date__c!=null) DOForPOInvoice.Reserved='/'+datetime.newInstance(POInvoice.Discount_Date__c.year(), POInvoice.Discount_Date__c.month(),POInvoice.Discount_Date__c.day()).format('MMddyyyy');
                
                if(POInvoice.Payment_Date_Override__c==true){
                    if (POInvoice.Adjusted_Payment_Date__c!=null) DOForPOInvoice.ExpenseAccount='/'+datetime.newInstance(POInvoice.Adjusted_Payment_Date__c.year(), POInvoice.Adjusted_Payment_Date__c.month(),POInvoice.Adjusted_Payment_Date__c.day()).format('MMddyyyy');
                }
                else{
                        System.debug('222222' + POInvoice.PaymentDate__c);
                        if (POInvoice.PaymentDate__c!=null){
                            Date PaymentDate=POInvoice.PaymentDate__c;
                            System.debug('1111111' + PaymentDate);
                            DOForPOInvoice.ExpenseAccount='/'+datetime.newInstance(PaymentDate.year(), PaymentDate.month(),PaymentDate.day()).format('MMddyyyy');//String.valueof(PaymentDate.Month())+String.valueof(PaymentDate.Day())+String.valueof(PaymentDate.Year());
                        }
                }                
                    
                
                                    
                if (POInvoice.Accounting_Date__c!=null) DOForPOInvoice.AccountsPayable='/'+datetime.newInstance(POInvoice.Accounting_Date__c.year(), POInvoice.Accounting_Date__c.month(),POInvoice.Accounting_Date__c.day()).format('MMddyyyy');
       
       return DOForPOInvoice;
   
   }
   
   Private DataObjectForPOInvoiceCSV SetDistributionLineItemData(Invoice_Distribution_Line__c InvoiceLineItem){
   
       DataObjectForPOInvoiceCSV DOForInvoiceLineItem=new DataObjectForPOInvoiceCSV();
       
           DOForInvoiceLineItem.IsPOInvoice=false;
            DOForInvoiceLineItem.PType='APDF';       
            DOForInvoiceLineItem.JobNumber=InvoiceLineItem.Job_Number__c;
            if (InvoiceLineItem.New_Cost_Code_No__c!=null)  DOForInvoiceLineItem.CostCodeNumber=InvoiceLineItem.New_Cost_Code_No__c + '.';
            If(InvoiceLineItem.New_Category__c!=null) DOForInvoiceLineItem.Category='/'+InvoiceLineItem.New_Category__c;
            if (InvoiceLineItem.Tax_Group__c!=null) DOForInvoiceLineItem.TaxGroup=InvoiceLineItem.Tax_Group__r.Name;
            DOForInvoiceLineItem.Amount=String.valueof(InvoiceLineItem.Amount__c);
            DOForInvoiceLineItem.Tax=String.valueof(InvoiceLineItem.Tax__c);
            DOForInvoiceLineItem.TaxLiability=String.valueof(InvoiceLineItem.Tax_Liability__c);
            DOForInvoiceLineItem.Retention=String.valueof(InvoiceLineItem.Retention__c);
            DOForInvoiceLineItem.Description=InvoiceLineItem.Description__c;
            if (InvoiceLineItem.Column_M_Static_Value2__c!=null)  DOForInvoiceLineItem.AccountsPayable='/'+InvoiceLineItem.Column_M_Static_Value2__c;//'01-000-2010.00';
       
       return DOForInvoiceLineItem;
   
   }
   
     Private DataObjectForPOInvoiceCSV SetGeneralLedgerDistributionLineItemData(Invoice_Distribution_Line__c InvoiceLineItem){
   
       DataObjectForPOInvoiceCSV DOForInvoiceLineItem=new DataObjectForPOInvoiceCSV();
       
           DOForInvoiceLineItem.IsPOInvoice=false;
            DOForInvoiceLineItem.PType='APDF';       
            DOForInvoiceLineItem.ExpenseAccount=InvoiceLineItem.GL_Account__c;
            DOForInvoiceLineItem.Amount=String.ValueOf(InvoiceLineItem.Amount__c);
            DOForInvoiceLineItem.Description=InvoiceLineItem.Description__c;
            if (InvoiceLineItem.Column_M_Static_Value2__c!=null)  DOForInvoiceLineItem.AccountsPayable='/'+InvoiceLineItem.Column_M_Static_Value2__c;//'01-000-2010.00';
            
       return DOForInvoiceLineItem;
   
   }
   
    Public Class DataObjectForPOInvoiceCSV{
    
        Public Boolean IsPOInvoice{get; set;}
        Public string PType{Get; Set;}    
        Public string Commitment{Get; Set;}
        Public string CommitmentLineItem{Get; Set;}
        Public string Equipment{Get; Set;}
        Public string EQCostCode{Get; Set;}
        Public string JobNumber{Get; Set;}
        Public string Extra{Get; Set;}
        Public string CostCodeNumber{Get; Set;}
        Public string Category{Get; Set;}
        Public string BLStdItem{Get; Set;}
        Public string Reserved{Get; Set;}
        Public string ExpenseAccount{Get; Set;}
        Public string AccountsPayable{Get; Set;}
        Public string MiscDeduction2{Get; Set;}
        Public string TaxGroup{Get; Set;}
        Public string Units{Get; Set;}
        Public string UnitsCost{Get; Set;}
        Public string Amount{Get; Set;}
        Public string Tax{Get; Set;}
        Public string TaxLiability{Get; Set;}
        Public string DiscountOffered{Get; Set;}
        Public string Retention{Get; Set;}
        Public string MiscDeduction{Get; Set;}
        Public string Exempt{Get; Set;}
        Public string DisCode{Get; Set;}
        Public string Draw{Get; Set;}
        Public string MiscEntry1{Get; Set;}
        Public string MiscEntryUnites1{Get; Set;}
        Public string MiscEntry2{Get; Set;}
        Public string MiscEQEntryUnits2{Get; Set;}
        Public string EQMeterOdomenter{Get; Set;}
        Public string Description{Get; Set;}
        Public string Authorization{Get; Set;}
        Public string JointPayee{Get; Set;}
    
    }
    
        public static testmethod void TestGenerateCSV() {
           PO_Invoice__c POInvoice=new PO_Invoice__c();
           
               Insert POInvoice;
                
           Invoice_Distribution_Line__c IDL =new Invoice_Distribution_Line__c();
                IDL.POInvoice__c =POInvoice.ID;
                Insert IDL;
           ApexPages.currentPage().getParameters().Put('ID',POInvoice.id);
           clsGeneratePOInvoiceCSV CGP=new clsGeneratePOInvoiceCSV();
           CGP.SetGeneralLedgerDistributionLineItemData(IDL);
           CGP.SetPOInvoiceData(POInvoice);
           CGP.SetDistributionLineItemData(IDL);
           CGP.GetCSVRecords();
        }
                       
}