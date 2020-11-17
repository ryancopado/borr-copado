public with sharing class Billing_InvoiceCtlExt {
        
        /*
         *      Methods to support the Billing Invoice PDF.
         *
         */
        
        ApexPages.StandardController stdController;
        
        public AcctSeed__Billing__c billing {get; set;}
        public List<AcctSeed__Project__c> projectList {get; set;}
        public AcctSeed__Project__c svConProject {get; set;}
        public String invoiceDate {get; set;}
        public String dueDate {get; set;}
        public String dueDateOM {get; set;}
        public String attentionNames {get; set;}
        public String attentionNamesOM {get; set;}
        public String solarFund {get; set;}
        //public String salesTaxTotal {get; set;}
        public String omBillLineTotal {get; set;}
        public List<OMBillingLines> omBillLines {get; set;}
        public List<AcctSeed__Billing_Line__c> billLines {get; set;}
        public Decimal subTotal {get;set;}
        
        public Billing_InvoiceCtlExt(ApexPages.StandardController stdController) {
                
                this.billing = new AcctSeed__Billing__c();
                this.billing = (AcctSeed__Billing__c)stdController.getRecord();
                this.billing = [select Id, Name, Application_Number__c, AcctSeed__Date__c, AcctSeed__Due_Date2__c, BS_Due_Date__c, 
                                SalesTaxPercent__c, AvaAcctSeed__Sales_Tax_Amount__c, SubTotal__c,
                                AcctSeed__Type__c, PAyment_Due__c, Customer_Reference_Number__c, SolarFund__c, AcctSeed__Shipping_Street__c, 
                                AcctSeed__Shipping_City__c, AcctSeed__Shipping_State__c, AcctSeed__Shipping_PostalCode__c, AcctSeed__Total__c, 
                                AcctSeed__Customer__c, AcctSeed__Customer__r.Name, AcctSeed__Customer__r.BillingStreet, AcctSeed__Customer__r.BillingCity, 
                                AcctSeed__Customer__r.BillingState, AcctSeed__Customer__r.BillingPostalCode, 
                                Service_Contract__c, Service_Contract__r.ContractNumber, Service_Contract__r.ASProject__c, Service_Contract__r.BillingStreet, 
                                Service_Contract__r.BillingCity, Service_Contract__r.BillingState, Service_Contract__r.BillingPostalCode, 
                                Service_Contract__r.Payment_due_days__c, Service_Contract__r.O_M_Client_Contact__r.Name 
                                from AcctSeed__Billing__c where Id = :this.billing.Id];
                
                invoiceDate = (billing.AcctSeed__Date__c == null) ? ' ' : String.valueOf(billing.AcctSeed__Date__c);
                dueDate = (billing.AcctSeed__Due_Date2__c == null) ? ' ' : String.valueOf(billing.AcctSeed__Due_Date2__c);
                dueDateOM = (billing.BS_Due_Date__c == null) ? ' ' : String.valueOf(billing.BS_Due_Date__c);
                solarFund = (String.isBlank(billing.SolarFund__c)) ? 'N/A' : billing.SolarFund__c;
                
                // Added By Madan - Jan 31, 2018(to show Sub Total on PDF page)
                if(billing.AcctSeed__Total__c != null) {
                    if(billing.AvaAcctSeed__Sales_Tax_Amount__c != null) {
                        String salesTaxAmt = billing.AvaAcctSeed__Sales_Tax_Amount__c;
                        
                        System.debug('===salesTaxAmt: ' + salesTaxAmt);
                        salesTaxAmt = salesTaxAmt.replace('$','').replace(' ','').replace(',', '');
                        
                        System.debug('===salesTaxAmt: ' + salesTaxAmt);
                        subTotal = billing.AcctSeed__Total__c - Decimal.valueOf(salesTaxAmt);
                        System.debug('===billing.AcctSeed__Total__c: ' + billing.AcctSeed__Total__c);
                        System.debug('===subTotal: ' + subTotal);
                    } else {
                        subTotal = billing.AcctSeed__Total__c;
                    }
                    
                    //subTotal = billing.AcctSeed__Total__c - (billing.AvaAcctSeed__Sales_Tax_Amount__c!=null?Decimal.valueOf(billing.AvaAcctSeed__Sales_Tax_Amount__c):0);
                } else {
                    subTotal = 0.00;
                }
                subTotal.setScale(0);
                
                //salesTaxTotal = (String.isBlank(billing.AvaAcctSeed__Sales_Tax_Amount__c)) ? ' ' : '$' + billing.AvaAcctSeed__Sales_Tax_Amount__c;
                
                List<AcctSeed__Billing_Line__c> billingLineList = new List<AcctSeed__Billing_Line__c>();
                billingLineList = [select Id, AcctSeed__Billing__c, AcctSeed__Project__c, Description__c, AcctSeed__Total__c, 
                                Taxable__c, Case__c, Case__r.CaseNumber, Service_Visit__r.Work_Ended__c, Category__c, AcctSeed__Hours_Units__c, 
                                AcctSeed__Rate__c, AvaAcctSeed__Rate__c, AcctSeed__Revenue_GL_Account__c, AcctSeed__Revenue_GL_Account__r.Name,
                                SalesTaxRateFormula__c  
                                from AcctSeed__Billing_Line__c where AcctSeed__Billing__c = :billing.Id];
                
                billLines = new List<AcctSeed__Billing_Line__c>();
                omBillLines = new List<OMBillingLines>();
                Decimal omBLTotal = 0;
                for (AcctSeed__Billing_Line__c bl :billingLineList) {
                        if (bl.AcctSeed__Revenue_GL_Account__r.Name.startsWith('22') || bl.AcctSeed__Revenue_GL_Account__r.Name.startsWith('3102')) {
                                omBillLines.add(new OMBillingLines(bl));
                        }
                        if (!bl.AcctSeed__Revenue_GL_Account__r.Name.startsWith('2204')) {
                                billLines.add(bl);
                        }
                        
                        if (bl.AcctSeed__Total__c != null) {
                                omBLTotal += bl.AcctSeed__Total__c;
                        }
                        
                }
                omBillLineTotal = '$' + String.valueOf(omBLTotal);
                
                Set<Id> pIds = new Set<Id>();
                Id pSvConId = null;
                if (billing.Service_Contract__r.ASProject__c != null) {
                        pSvConId = billing.Service_Contract__r.ASProject__c;
                }
                for (AcctSeed__Billing_Line__c bl :billLines) {
                        if (bl.AcctSeed__Project__c != null) {
                                pIds.add(bl.AcctSeed__Project__c);
                        }
                }
                
                projectList = new List<AcctSeed__Project__c>();
                List<AcctSeed__Project__c> pList = new List<AcctSeed__Project__c>();
                svConProject = new AcctSeed__Project__c();
                if (!pIds.isEmpty() || pSvConId != null) {
                        pList = [select Id, Name, Customer_Project_Name__c, O_M_Manager__c, O_M_Manager__r.Name, 
                                        Site_Address__c, Site_City__c, Site_State__c, Site_Zip__c 
                                        from AcctSeed__Project__c where Id in :pIds or Id = :pSvConId];
                }
                for (AcctSeed__Project__c p :pList) {
                        if (pSvConId == p.Id) {
                                svConProject = p;
                        }
                        if (pIds.contains(p.Id)) {
                                projectList.add(p);
                        }
                }
                
                //attentionNames = (String.isBlank(billing.Service_Contract__r.O_M_Client_Contact__r.Name)) ? ' ' : billing.Service_Contract__r.O_M_Client_Contact__r.Name;
                attentionNames = '';
                attentionNamesOM = '';
                List<ContractContactRole> ccrList = new List<ContractContactRole>();
                ccrList = [select Id, ContactId, Contact.Name, Role from ContractContactRole 
                                where ContractId = :billing.Service_Contract__c and (Role = 'O&M Billing Contact' or Role = 'O&M Service Billing Contact')];
                
                if (!ccrList.isEmpty()) {
                        for (ContractContactRole ccr :ccrList) {
                                attentionNames += (ccr.Role == 'O&M Service Billing Contact') ? ccr.Contact.Name + ', ' : '';
                                attentionNamesOM += (ccr.Role == 'O&M Billing Contact') ? ccr.Contact.Name + ', ' : '';
                        }
                }
                if (String.isBlank(attentionNames)) {
                        attentionNames = ' ';
                } else {
                        attentionNames = attentionNames.removeEnd(', ');
                }
                if (String.isBlank(attentionNamesOM)) {
                        attentionNamesOM = ' ';
                } else {
                        attentionNamesOM = attentionNamesOM.removeEnd(', ');
                }
        }
        
        public class OMBillingLines {
                public AcctSeed__Billing_Line__c billingLine {get; set;}
                public String endDate {get; set;}
                public String quantity {get; set;}
                public String unitMeasure {get; set;}
                public String unitCost {get; set;}
                
                public OMBillingLines(AcctSeed__Billing_Line__c bl) {
                        this.billingLine = bl;
                        this.endDate = (bl.Service_Visit__r.Work_Ended__c == null) ? '' : String.valueOf(bl.Service_Visit__r.Work_Ended__c.date());
                        this.quantity = (bl.AcctSeed__Hours_Units__c == null) ? '' : bl.AcctSeed__Hours_Units__c.setscale(2).toPlainString();
                        this.unitMeasure = (bl.Category__c == 'Labor' || bl.Category__c == 'Drive Time/Travel') ? 'Hours' : '';
                        this.unitCost = (bl.AcctSeed__Rate__c == null) ? '' : '$' + bl.AcctSeed__Rate__c.setscale(2).toPlainString();
                }
        }
}