public class AccountPayableFromPurchaseOrder {
    private AcctSeedERP__Purchase_Order__c purchaseOrder;
    private AcctSeed__Account_Payable__c acctPayable;
    private Date issueDate;
    private Date dueDate;
    public Boolean showMessages {get; private set;}
    private Boolean isNegativeError;
    private Boolean isOverPayError;
    Public Boolean isLines;
    public List<PurchaseOrderLineWrapper> polWrapper {get; private set;}
    
    
    public List<ChangeOrderWrapper> colWrapper {get; private set;}
    
    public Decimal totalAmmountRequested {get;set;}
    
    public Decimal totalAmmountPaid {get;set;}
    
    public static final String NO_PO_LINES = 'No purchase order lines have both the amount to pay and quantity to pay fields populated';
    
    public AccountPayableFromPurchaseOrder(ApexPages.StandardController controller) {
        purchaseOrder = (AcctSeedERP__Purchase_Order__c) controller.getRecord();
        issueDate = dueDate = System.today();
        showMessages = false;
        isNegativeError = false;
        isOverPayError = false;
        isLines = false;
        getSummaryInformation();
    }
    
    public class PurchaseOrderLineWrapper {
        public AcctSeedERP__Purchase_Order_Line__c poLine {get; private set;}
        public Decimal paidAmount {get; private set;}
        public Double quantityReceived {get; private set;}
        public AcctSeed__Account_Payable_Line__c apl {get; set;}
        
        public PurchaseOrderLineWrapper(AcctSeedERP__Purchase_Order_Line__c poLine, Decimal paidAmount, Double quantityReceived) {
           this.poLine = poLine;
           this.paidAmount = paidAmount;
           this.quantityReceived = quantityReceived;
           this.apl = new AcctSeed__Account_Payable_Line__c();
        }
    }
    
    
    
     public class ChangeOrderWrapper {
        public Con_Req__c coLine {get; private set;}
        public Decimal paidAmount {get; set;}
        public Double quantityReceived {get; set;}
        public Decimal ALPpaidAmount {get; set;}
        public AcctSeed__Account_Payable_Line__c apl {get; set;}
        
        public ChangeOrderWrapper(Con_Req__c coLine, Decimal paidAmount, Double quantityReceived,Decimal ALPpaidAmount) {
           this.coLine = coLine;
           this.paidAmount = paidAmount;
           this.quantityReceived =quantityReceived;
           this.ALPpaidAmount = ALPpaidAmount;
           this.apl = new AcctSeed__Account_Payable_Line__c();
        }
    }
    
    
    private void getSummaryInformation() {
        polWrapper = new List<PurchaseOrderLineWrapper>();
        colWrapper = new List<ChangeOrderWrapper> ();
        for (AcctSeedERP__Purchase_Order_Line__c poLine : [Select Id, Name, AcctSeedERP__Quantity__c, AcctSeedERP__Unit_Price__c, AcctSeedERP__Product__r.Name,
                                            AcctSeedERP__Project__c, AcctSeedERP__Project_Task__c, AcctSeedERP__Purchase_Order__r.AcctSeedERP__Vendor__r.AcctSeed__Account_Payable_Terms__c,
                                            AcctSeedERP__GL_Account_Variable_1__c, AcctSeedERP__GL_Account_Variable_2__c, AcctSeedERP__GL_Account_Variable_3__c, AcctSeedERP__GL_Account_Variable_4__c,
                                            AcctSeedERP__Product__c, AcctSeedERP__Product__r.AcctSeed__GL_Account_Variable_1__c, AcctSeedERP__Product__r.AcctSeed__GL_Account_Variable_2__c,
                                            AcctSeedERP__Product__r.AcctSeed__GL_Account_Variable_3__c, AcctSeedERP__Product__r.AcctSeed__GL_Account_Variable_4__c,
                                            AcctSeedERP__Product__r.AcctSeed__Expense_GL_Account__c, POLine_Total__c, Site__c, 
                                           (Select Id, AcctSeedERP__Quantity__c From AcctSeedERP__Purchase_Order_Inventory_Movements__r),
                                           (Select Id, AcctSeed__Amount__c, AcctSeed__Quantity__c From AcctSeedERP__Account_Payable_Lines__r)
                                           From AcctSeedERP__Purchase_Order_Line__c Where AcctSeedERP__Purchase_Order__c = :purchaseOrder.Id]) {
            Decimal paidAmount = 0;
            Double quantityReceived = 0;
            dueDate = poLine.AcctSeedERP__Purchase_Order__r.AcctSeedERP__Vendor__r.AcctSeed__Account_Payable_Terms__c != null ? dueDate + poLine.AcctSeedERP__Purchase_Order__r.AcctSeedERP__Vendor__r.AcctSeed__Account_Payable_Terms__c.intValue() : dueDate;
            
            for (AcctSeedERP__Purchase_Order_Inventory_Movement__c poim : poLine.AcctSeedERP__Purchase_Order_Inventory_Movements__r) {
                quantityReceived += poim.AcctSeedERP__Quantity__c;
            }

            for (AcctSeed__Account_Payable_Line__c apl : poLine.AcctSeedERP__Account_Payable_Lines__r) {
                paidAmount += apl.AcctSeed__Amount__c;
            }
                        
            polWrapper.add(new PurchaseOrderLineWrapper(poLine,paidAmount,quantityReceived));                               
        }
        
        totalAmmountRequested = 0;
        totalAmmountPaid = 0;
        
        for (Con_Req__c coLine : [Select Id, Name, Product__c, ASProject__c, New_QuantityCOConReq__c, Amount_Requested__c,Vendor_Account__c,ASProject__r.Account__c, recordType.name,
                                        Budget_Line_Item2__c, ASProject__r.Branch__c,Product__r.AcctSeed__GL_Account_Variable_1__c,Product__r.AcctSeed__GL_Account_Variable_2__c,Product__r.AcctSeed__GL_Account_Variable_3__c,
                                        Product__r.AcctSeed__GL_Account_Variable_4__c,ASProject__r.Default_Expense_GL_Account__c,Product__r.AcctSeed__Expense_GL_Account__c, Site__c, 
                                        (select Id, AcctSeed__Amount__c, AcctSeed__Quantity__c from  Account_Payable_Lines__r)
                                           From Con_Req__c Where Purchase_Order2__c = :purchaseOrder.Id]) {
            Decimal paidAmount = 0;
            Double quantityReceived = 0;
             Decimal ALPpaidAmount = 0;
                 
            if(coLine.Amount_Requested__c != null){
                totalAmmountRequested +=coLine.Amount_Requested__c;
            }
            
            for (AcctSeed__Account_Payable_Line__c apl : coLine.Account_Payable_Lines__r) {
                ALPpaidAmount += apl.AcctSeed__Amount__c;
                totalAmmountPaid += apl.AcctSeed__Amount__c;
            }
            
                        
            colWrapper.add(new ChangeOrderWrapper(coLine,paidAmount,quantityReceived,ALPpaidAmount)); 
            system.debug('LOOK HERE WRAPPER' +colWrapper);                              
        }
        
    }
    
    
    public PageReference createAccountPayable() {
        showMessages = false;
        isNegativeError = false;
        isOverPayError = false;
        system.debug('LOOK HERE WRAPPER' +colWrapper);         
        
        for (ChangeOrderWrapper cow : colWrapper) {
            if (cow.quantityReceived != null && cow.quantityReceived < 0) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR,'quantity Cannot be a negative number'));
                isNegativeError = true;
            }
        }
        
        for (PurchaseOrderLineWrapper pow : polWrapper) {
            
            // Check if both quantity and amount are positive; error if false
            if (pow.apl.AcctSeed__Amount__c != null && pow.apl.AcctSeed__Amount__c < 0) {
                pow.apl.AcctSeed__Amount__c.addError('Cannot be a negative number'); 
                isNegativeError = true;
            }
                        
            if (pow.apl.AcctSeed__Quantity__c != null && pow.apl.AcctSeed__Quantity__c < 0) {
                pow.apl.AcctSeed__Quantity__c.addError('Cannot be a negative number'); 
                isNegativeError = true;
            }
                                    
            // Check if quantity plus amount received is greater than total quantity
            if (pow.apl.AcctSeed__Amount__c != null && (pow.apl.AcctSeed__Amount__c + pow.paidAmount) > pow.poLine.POLine_Total__c) {
                pow.apl.AcctSeed__Amount__c.addError('amount to pay cannot be greater than outstanding amount');
                isOverPayError = true;
            }      
        }   

        if (isNegativeError || isOverPayError)
            return null;

        Savepoint sp = Database.setSavepoint();
        acctPayable = new AcctSeed__Account_Payable__c();
        
        isLines = false;
        Boolean isLinesCO = false;//Boolean isLinesCO = false
                                 
        try { 

            for (PurchaseOrderLineWrapper pow : polWrapper) {          
                
                if (pow.apl.AcctSeed__Amount__c != null && pow.apl.AcctSeed__Quantity__c != null) {  
                     isLines = true;
                }           
            }  
            
            
            for (ChangeOrderWrapper cow : colWrapper) {
                if (cow.quantityReceived != null && cow.quantityReceived > 0) {
                     isLinesCO = true;
                }
            }
            
            
            if (isLines || isLinesCO) {
                acctPayable.AcctSeed__Vendor__c = purchaseOrder.AcctSeedERP__Vendor__c;
                acctPayable.AcctSeed__Date__c = issueDate;
                acctPayable.AcctSeed__Due_Date__c = dueDate; 
                acctPayable.AcctSeed__Payee_Reference__c = purchaseOrder.Name + ' - ' + System.now(); 
                acctPayable.Purchase_Order__c = purchaseOrder.Id;
                if (purchaseOrder.AcctSeedERP__Vendor__c != NULL) {
                    Account vendorAcct = [SELECT Id, Name, Payment_Method__c FROM Account WHERE Id =: purchaseOrder.AcctSeedERP__Vendor__c];
                    acctPayable.Payment_Method__c = vendorAcct.Payment_Method__c;
                }
                insert acctPayable;
                system.debug('accountpyable' +acctPayable);
                List<AcctSeed__Account_Payable_Line__c> apLines = new List<AcctSeed__Account_Payable_Line__c>();
                    system.debug('The po line' +polWrapper );
                for (PurchaseOrderLineWrapper pow : polWrapper) {          
                    
                    if (pow.apl.AcctSeed__Amount__c != null && pow.apl.AcctSeed__Quantity__c >0  && pow.apl.AcctSeed__Quantity__c != null) {  
                    // pow.apl.AcctSeed__Quantity__c != null
                        pow.apl.AcctSeed__Project__c = pow.poLine.AcctSeedERP__Project__c;
                        pow.apl.AcctSeed__Project_Task__c = pow.poLine.AcctSeedERP__Project_Task__c;
                        pow.apl.AcctSeed__GL_Account_Variable_1__c = pow.poLine.AcctSeedERP__GL_Account_Variable_1__c != null ? pow.poLine.AcctSeedERP__GL_Account_Variable_1__c : pow.poLine.AcctSeedERP__Product__r.AcctSeed__GL_Account_Variable_1__c;
                        pow.apl.AcctSeed__GL_Account_Variable_2__c = pow.poLine.AcctSeedERP__GL_Account_Variable_2__c != null ? pow.poLine.AcctSeedERP__GL_Account_Variable_2__c : pow.poLine.AcctSeedERP__Product__r.AcctSeed__GL_Account_Variable_2__c;   
                        pow.apl.AcctSeed__GL_Account_Variable_3__c = pow.poLine.AcctSeedERP__GL_Account_Variable_3__c != null ? pow.poLine.AcctSeedERP__GL_Account_Variable_3__c : pow.poLine.AcctSeedERP__Product__r.AcctSeed__GL_Account_Variable_3__c;
                        pow.apl.AcctSeed__GL_Account_Variable_4__c = pow.poLine.AcctSeedERP__GL_Account_Variable_4__c != null ? pow.poLine.AcctSeedERP__GL_Account_Variable_4__c : pow.poLine.AcctSeedERP__Product__r.AcctSeed__GL_Account_Variable_4__c;          
                        pow.apl.AcctSeed__Expense_GL_Account__c = pow.poLine.AcctSeedERP__Product__r.AcctSeed__Expense_GL_Account__c;                
                        pow.apl.AcctSeed__Account_Payable__c = acctPayable.Id;
                        pow.apl.AcctSeedERP__Purchase_Order_Line__c = pow.poLine.Id;    
                        pow.apl.AcctSeed__Product__c = pow.poLine.AcctSeedERP__Product__c;
                        pow.apl.Site__c = pow.poLine.Site__c;
                        apLines.add(pow.apl);    
                    }   
                     
                }
                if(aplines.size()>0){
                     system.debug('look here aplines' +apLines);
                     insert apLines; 
                     }
                                
                //insert apLines;       
                
                system.debug('LOOK HERE' +isLinesCO);
                List<AcctSeed__Account_Payable_Line__c> apLinesCO = new List<AcctSeed__Account_Payable_Line__c>();
                if (isLinesCO)  {        
                    //List<AcctSeed__Account_Payable_Line__c> apLinesCO = new List<AcctSeed__Account_Payable_Line__c>();
    
                    Map<String,String> avs = new Map<String,String>();
                    
                    for(AcctSeed__Accounting_Variable__c av:[Select a.Name From AcctSeed__Accounting_Variable__c a]){
                        avs.put(av.Name,av.Id);
                    }
                        system.debug('CO WRAPPER' +colWrapper);
                    for (ChangeOrderWrapper cow : colWrapper) {
                       system.debug('CO QUANTITY' +cow.quantityReceived);
                        if (cow.quantityReceived != null && cow.quantityReceived > 0) {
                            
                            
                            cow.apl.AcctSeed__Project__c = cow.coLine.ASProject__c;
                            cow.apl.AcctSeed__Project_Task__c = cow.coLine.Budget_Line_Item2__c;
                            cow.apl.Branch__c = cow.coLine.ASProject__r.branch__c;
                            cow.apl.AcctSeed__Account_Payable__c = acctPayable.Id; //commented on 4/2/19 by MG.
                            //cow.apl.AcctSeed__Product__c = cow.coLine.AcctSeedERP__Product__c;
                            system.debug('Quantity received' +cow.quantityReceived);
                            cow.apl.AcctSeed__Quantity__c = cow.quantityReceived;
                            cow.apl.AcctSeed__Amount__c = cow.paidAmount; //cow.coLine.Amount_Requested__c;
                            //cow.apl.Vendor__c = cow.coLine.Vendor_Account__c;
                            cow.apl.Change_order__c = cow.coLine.Id;
                            //cow.apl.AcctSeed__Account__c = cow.coLine.ASProject__r.Account__c;
                            
                            cow.apl.AcctSeed__GL_Account_Variable_1__c = cow.coLine.Product__r.AcctSeed__GL_Account_Variable_1__c;
                            cow.apl.AcctSeed__GL_Account_Variable_2__c = cow.coLine.Product__r.AcctSeed__GL_Account_Variable_2__c;   
                            cow.apl.AcctSeed__GL_Account_Variable_3__c = cow.coLine.Product__r.AcctSeed__GL_Account_Variable_3__c;
                            cow.apl.AcctSeed__GL_Account_Variable_4__c = cow.coLine.Product__r.AcctSeed__GL_Account_Variable_4__c;          
                        
                            
                           /* if(avs.containsKey(cow.coLine.ASProject__r.branch__c)){
                                cow.apl.AcctSeed__GL_Account_Variable_1__c = avs.get(cow.coLine.ASProject__r.branch__c);
                            }else{
                                cow.apl.AcctSeed__GL_Account_Variable_1__c ='a1O80000005KqHT';
                            }*/
                            
                            if(cow.coLine.Product__r.AcctSeed__Expense_GL_Account__c != null){
                                cow.apl.AcctSeed__Expense_GL_Account__c = cow.coLine.Product__r.AcctSeed__Expense_GL_Account__c;                
                            }
                            cow.apl.Site__c = cow.coLine.Site__c;
                            
                            apLinesCO.add(cow.apl);    
                        }         
                    }              
                  //  apLines.addAll(apLinesCO);
                  
                }
                if (aplinesCO.size()>0){
                    insert apLinesCO ;
                    }
                
                // Do one insert of all AP Line records
                system.debug('look here'+apLines);
              // apLines.addAll(apLinesCO);
                if (!apLines.isEmpty()) {
                   //   insert apLines;
                }
               
            } else {
                system.debug('Look Here APlines');
              //  ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR, NO_PO_LINES));
                //showMessages = true;
                //return null;
            }  //commented on 4/5 since not required according to recent requirement 
                                                      
       }
       catch (Exception ex) {
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR,ex.getMessage()));
            showMessages = true;
            return null;
        } 
        
        return new PageReference('/' + acctPayable.Id + '/e?retURL=%2F' + acctPayable.Id);                  
        
    }

    public Decimal getTotalPaid() {
        Decimal totalPaid = 0;
        
        for (PurchaseOrderLineWrapper polw : polWrapper) {
            totalPaid += polw.paidAmount;
        }
        
        return totalPaid;
    }   

    public Decimal getTotalAmount() {
        Decimal totalAmount = 0;
        
        for (PurchaseOrderLineWrapper polw : polWrapper) {
            totalAmount += polw.poLine.POLine_Total__c;
        }
        
        return totalAmount;
    }   
    
    
    public Decimal getTotalOutstanding() {
        return getTotalAmount() - getTotalPaid();
    }    
    
    
   @IsTest   //(SeeAllData=true)
    private static List<AcctSeedERP__Purchase_Order__c> initializeTestPurchaseOrders() {
       ASeedAccountingSettingsSetupTest.testDataSetup(); 
        List<Account> accounts = new List<Account>();
        
        accounts.add(
            new Account(
                Name = 'Test Account',
                AcctSeed__Accounting_Type__c = 'Customer and Vendor',
                ShippingCity = 'San Francisco',
                AcctSeed__Credit_Card_Vendor__c = true
            )
        );
       
        insert accounts;

        List<AcctSeed__GL_Account__c> glAccounts = new List<AcctSeed__GL_Account__c>();
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '5000-Labor',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense'
            )
        );
        
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '6010-Mileage',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense',
                AcctSeed__Used_In_Expense_Reports__c = true,
                AcctSeed__Mileage_Account__c = true,
                AcctSeed__Mileage_Rate__c = .5
            )
        );
        
        
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '4000-Consulting Revenue',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Revenue'
            )
        );

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '2000-Accounts Payable',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Revenue'
            )
        );

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '1000-Bank of America Account 5347',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Balance Sheet',
                AcctSeed__Sub_Type_1__c = 'Assets',
                AcctSeed__Bank__c = true
            )
        );          

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = 'Inventory',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense'
            )
        );   

        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = 'Vouchers Payable',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense'
            )
        );  
                                
        insert glAccounts;


        List<Product2> products = new List<Product2>();
        
        products.add(
            new Product2(
                Name = 'Test Prod 1',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
                AcctSeed__Inventory_Product__c = true,
                AcctSeed__Unit_Cost__c = 100
            )
        );
        
        products.add(
            new Product2(
                Name = 'Test Prod 2',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
                AcctSeed__Inventory_Product__c = true,
                AcctSeed__Unit_Cost__c = 200
            )
        );
        
        products.add(
            new Product2(
                Name = 'Test Prod 3',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
              //  AcctSeed__Inventory_Type__c = 'Raw Material',
                AcctSeed__Inventory_Product__c = true,
                AcctSeedERP__Inventory_Asset__c = true,
                AcctSeedERP__Serialized__c = true,
                AcctSeed__Unit_Cost__c = 200
            )
        );

        products.add(
            new Product2(
                Name = 'Test Prod 4',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
             //   AcctSeed__Inventory_Type__c = 'Manufactured',
                AcctSeed__Inventory_Product__c = true,
                AcctSeedERP__Serialized__c = true,
                AcctSeed__Unit_Cost__c = 200
            )
        ); 
        
        products.add(
            new Product2(
                Name = 'Test Prod 5',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
              //  AcctSeed__Inventory_Type__c = 'Manufactured',
                AcctSeed__Inventory_Product__c = true,
                AcctSeedERP__Serialized__c = true,
                AcctSeed__Unit_Cost__c = 200
            )
        );    
        
       products.add(
            new Product2(
                Name = 'Test Prod 6',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
              //  AcctSeed__Inventory_Type__c = 'Manufactured',
                AcctSeed__Inventory_Product__c = true,
                AcctSeedERP__Serialized__c = true,
                AcctSeed__Unit_Cost__c = 200
            )
        );   
        
        products.add(
            new Product2(
                Name = 'Test Prod 7',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
              //  AcctSeed__Inventory_Type__c = 'Manufactured',
                AcctSeed__Inventory_Product__c = true,
                AcctSeedERP__Serialized__c = true,
                AcctSeed__Unit_Cost__c = 200
            )
        ); 

        products.add(
            new Product2(
                Name = 'Test Prod 8',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
              //  AcctSeed__Inventory_Type__c = 'Manufactured',
                AcctSeed__Inventory_Product__c = true,
                AcctSeedERP__Serialized__c = true,
                AcctSeed__Unit_Cost__c = 200
            )
        ); 

        products.add(
            new Product2(
                Name = 'Test Prod 9',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
                AcctSeed__Inventory_Product__c = true,
                AcctSeed__Unit_Cost__c = 500
            )
        );

        products.add(
            new Product2(
                Name = 'Test Kit Prod',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
              //  AcctSeed__Inventory_Type__c = 'Kit',
                AcctSeed__Inventory_Product__c = true,
                AcctSeed__Unit_Cost__c = 500
            )
        );
                                        
        insert products;
        
        List<Tax_Rate__c> taxRates = new List<Tax_Rate__c>();
        taxRates.add(
            new Tax_Rate__c(
                Tax_Rate__c = 7
            )
        );  
        insert taxRates;
        
        accounts[0].AcctSeed__Accounting_Type__c = 'Vendor';
        update accounts[0];
        
         AcctSeed__Ledger__c ledger;
            Id ledgerId;
            try{
            ledger = [SELECT Id From AcctSeed__Ledger__c WHERE AcctSeed__Type__c = 'Transactional' LIMIT 1];
            }Catch(Exception e){}
            if(ledger !=null){
            ledgerId=ledger.ID;
            }
        
        List<AcctSeedERP__Purchase_Order__c> purchaseOrders = new List<AcctSeedERP__Purchase_Order__c>();
        
        
        purchaseOrders.add(
            new AcctSeedERP__Purchase_Order__c(
               AcctSeedERP__Vendor__c = accounts[0].Id,
               AcctSeedERP__Ledger__c=ledgerId,
               AcctSeedERP__Status__c = 'Open'
            )
        );  
        
        purchaseOrders.add(
            new AcctSeedERP__Purchase_Order__c(
               AcctSeedERP__Vendor__c = accounts[0].Id,
               AcctSeedERP__Ledger__c=ledgerId,
               AcctSeedERP__Status__c = 'Open'
            )
        );  
        
        insert purchaseOrders; 

        List<AcctSeedERP__Purchase_Order_Line__c> purchaseOrderLines = new List<AcctSeedERP__Purchase_Order_Line__c>();
        
        purchaseOrderLines.add(
            new AcctSeedERP__Purchase_Order_Line__c(
               AcctSeedERP__Purchase_Order__c = purchaseOrders[0].Id,
               AcctSeedERP__Product__c = products[0].Id,
               AcctSeedERP__Quantity__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Unit_Cost__c = 4,
               Freight__c = 10,
               Sales_Tax_Rate_Table__c = taxRates[0].Id
            )        
        ); 
        
        purchaseOrderLines.add(
            new AcctSeedERP__Purchase_Order_Line__c(
               AcctSeedERP__Purchase_Order__c = purchaseOrders[0].Id,
               AcctSeedERP__Product__c = products[1].Id,
               AcctSeedERP__Quantity__c = 6,
               AcctSeedERP__Unit_Price__c = 2,
               Unit_Cost__c = 4,
               Freight__c = 10,
               Sales_Tax_Rate_Table__c = taxRates[0].Id              
            )        
        );
        
        purchaseOrderLines.add(
            new AcctSeedERP__Purchase_Order_Line__c(
               AcctSeedERP__Purchase_Order__c = purchaseOrders[1].Id,
               AcctSeedERP__Product__c = products[0].Id,
               AcctSeedERP__Quantity__c = 6,
               AcctSeedERP__Unit_Price__c = 3,
               Unit_Cost__c = 4,
               Freight__c = 10,
               Sales_Tax_Rate_Table__c = taxRates[0].Id               
            )        
        ); 
        
        purchaseOrderLines.add(
            new AcctSeedERP__Purchase_Order_Line__c(
               AcctSeedERP__Purchase_Order__c = purchaseOrders[1].Id,
               AcctSeedERP__Product__c = products[8].Id,
               AcctSeedERP__Quantity__c = 6,
               AcctSeedERP__Unit_Price__c = 4,
               Unit_Cost__c = 4,
               Freight__c = 10,
               Sales_Tax_Rate_Table__c = taxRates[0].Id               
            )        
        );

        purchaseOrderLines.add(
            new AcctSeedERP__Purchase_Order_Line__c(
               AcctSeedERP__Purchase_Order__c = purchaseOrders[0].Id,
               AcctSeedERP__Product__c = products[2].Id,
               AcctSeedERP__Quantity__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Unit_Cost__c = 4,
               Freight__c = 10,
               Sales_Tax_Rate_Table__c = taxRates[0].Id               
            )        
        ); 
                
        insert purchaseOrderLines;  

        List<AcctSeed__Accounting_Period__c> acctPeriods = new List<AcctSeed__Accounting_Period__c>();
        
        acctPeriods.add(
            new AcctSeed__Accounting_Period__c(
                Name = '2025-01',
                AcctSeed__Start_Date__c = Date.newinstance(2025, 1, 1),
                AcctSeed__End_Date__c = Date.newinstance(2025, 1, 31),
                AcctSeed__Status__c = 'Open'
            )
        );
        insert acctPeriods;

        return purchaseOrders;  
    }

    @IsTest//(SeeAllData=true)    
    public static void testCreateAccountPayableNegativeError() {
        List<AcctSeedERP__Purchase_Order__c> purchaseOrders = initializeTestPurchaseOrders();
        
        ApexPages.StandardController controller = new ApexPages.StandardController(purchaseOrders[0]);
        AccountPayableFromPurchaseOrder apo = new AccountPayableFromPurchaseOrder(controller);
        apo.issueDate = apo.dueDate = Date.newinstance(2025, 1, 1);
        
        System.assertEquals(false, apo.isNegativeError);
        
        apo.polWrapper[0].apl.AcctSeed__Quantity__c = -1;
        apo.polWrapper[0].apl.AcctSeed__Amount__c = -100;
        apo.createAccountPayable();
        
        System.assertEquals(true, apo.isNegativeError);
        
        apo.isNegativeError = false;
        apo.polWrapper[0].apl.AcctSeed__Quantity__c = -1;
        apo.polWrapper[0].apl.AcctSeed__Amount__c = -100;
        apo.createAccountPayable();
        
        System.assertEquals(true, apo.isNegativeError);        
    }
 
    @IsTest//(SeeAllData=true)
    public static void testCreateAccountPayableOverPayError() {
        List<AcctSeedERP__Purchase_Order__c> purchaseOrders = initializeTestPurchaseOrders();
        
        ApexPages.StandardController controller = new ApexPages.StandardController(purchaseOrders[0]);
        AccountPayableFromPurchaseOrder apo = new AccountPayableFromPurchaseOrder(controller);
        apo.issueDate = apo.dueDate = Date.newinstance(2025, 1, 1);
        
        System.assertEquals(false, apo.isOverPayError);
        apo.polWrapper[0].apl.AcctSeed__Quantity__c = 1;
        apo.polWrapper[0].apl.AcctSeed__Amount__c = 100000;
        apo.createAccountPayable();
                
        System.assertEquals(true, apo.isOverPayError);
        
    }

    @IsTest//(SeeAllData=true)
    public static void testCreateAccountPayableNoPoLinesError() {
        List<AcctSeedERP__Purchase_Order__c> purchaseOrders = initializeTestPurchaseOrders();
        
        ApexPages.StandardController controller = new ApexPages.StandardController([Select Name, AcctSeedERP__Vendor__c From AcctSeedERP__Purchase_Order__c Where Id = :purchaseOrders[0].Id]);
        AccountPayableFromPurchaseOrder apo = new AccountPayableFromPurchaseOrder(controller);
        apo.issueDate = apo.dueDate = Date.newinstance(2025, 1, 1);
        
        System.assertEquals(false, apo.isOverPayError);

        apo.createAccountPayable();
                
        System.assertEquals(false, apo.isLines);
        
    }
    
   @IsTest//(SeeAllData=true)
    public static void testCreateAccountPayable() {
        List<AcctSeedERP__Purchase_Order__c> purchaseOrders = initializeTestPurchaseOrders();
        
        ApexPages.StandardController controller = new ApexPages.StandardController([Select Name, AcctSeedERP__Vendor__c From AcctSeedERP__Purchase_Order__c Where Id = :purchaseOrders[0].Id]);
        AccountPayableFromPurchaseOrder apo = new AccountPayableFromPurchaseOrder(controller);
        apo.issueDate = apo.dueDate = Date.newinstance(2025, 1, 1);
        
        System.assertEquals(false, apo.isOverPayError);
        apo.polWrapper[0].apl.AcctSeed__Quantity__c = 1;
        apo.polWrapper[0].apl.AcctSeed__Amount__c = 3;
        apo.createAccountPayable();
                
        System.assertNotEquals(null, [Select id From AcctSeed__Account_Payable__c Where Id = :apo.acctPayable.Id]);
        
        // Test Aggregate Methods        
        System.assertEquals(0, apo.getTotalPaid());
        System.assertEquals(102.00, apo.getTotalAmount());
        System.assertEquals(102.00, apo.getTotalOutstanding());        
    } 
  /*  @IsTest(SeeAllData=true)
     public static void testCreateAccountPayablelines() {
     
      List<AcctSeedERP__Purchase_Order__c> purchaseOrders = initializeTestPurchaseOrders();
        
        ApexPages.StandardController controller = new ApexPages.StandardController(purchaseOrders[0]);
        AccountPayableFromPurchaseOrder apo = new AccountPayableFromPurchaseOrder(controller);
        
        apo.createAccountPayable();
     
     
     } */

}