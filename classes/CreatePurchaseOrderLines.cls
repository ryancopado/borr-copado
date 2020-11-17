public class CreatePurchaseOrderLines {
    private ApexPages.StandardSetController setController;
    public String filterId {get; private set;}
    private AcctSeedERP__Sales_Order_Line__c[] salesOrderLineList;
    private List<AcctSeedERP__Purchase_Order__c> poList;
    private Map<Id,AcctSeedERP__Purchase_Order_Line__c> poLineMap;  

    public List<SalesOrderWrapper> soWrapperList {get; set;}
    public Boolean showMessages {get; private set;}
    public Boolean isProcessed {get; private set;}
 
    public Decimal grandTotal {get; private set;}
    public Boolean isError {get; private set;}
        
    public CreatePurchaseOrderLines(ApexPages.StandardSetController setController) {
                                
        this.setController = setController;
        filterId = setController.getFilterId().subString(0,15); 
        isProcessed = false;    
        isError = false;
        getSummaryInformation();
        //poWrapperList = new List<PurchaseOrderWrapper>();
    }
    
    public class SalesOrderWrapper { //implements Comparable {
        public AcctSeedERP__Purchase_Order__c po {get; set;}
        //public Product2 product {get; set;}
        public Account vendor {get; set;}
        public List<AcctSeedERP__Sales_Order_Line__c> soLines {get; set;}
        
        public SalesOrderWrapper(Account vendor, List<AcctSeedERP__Sales_Order_Line__c> soLines) {
            this.po = new AcctSeedERP__Purchase_Order__c();
            this.po.AcctSeedERP__Vendor__c = vendor.Id;
            this.po.Not_To_Exceed__c = 'No';
            this.vendor = vendor;
            this.soLines = soLines;
        }
        
        public Decimal getTotal() {
            Decimal total = 0;
            
            for (AcctSeedERP__Sales_Order_Line__c sol : soLines) {
                if (sol.SOLine_Total__c != null)
                    total += sol.SOLine_Total__c;
            }
            
            return total;
        }
                
    }

    private void getSummaryInformation() {
        
        Map<Id,SalesOrderWrapper> productSOWrapperMap = new Map<Id,SalesOrderWrapper>();
        
        for (AcctSeedERP__Sales_Order_Line__c so : [SELECT Name, Tax_Group__c, Requested_Delivery_Date__c, AcctSeedERP__Quantity_Needed__c, AcctSeedERP__Sales_Order__c, AcctSeedERP__Product__c, AcctSeedERP__Product__r.ProductCode, AcctSeedERP__Product__r.Name,
                                        AcctSeedERP__Product__r.Description, AcctSeedERP__Product__r.AcctSeedERP__Default_Vendor__c, AcctSeedERP__Product__r.AcctSeed__Unit_Cost__c,
                                        Vendor__c, Vendor__r.Name, Vendor__r.Id, Freight__c, Ship_to_Account__c, AcctSeedERP__Product__r.AcctSeed__Inventory_Product__c, AcctSeedERP__Product__r.AcctSeed__Inventory_Type__c,
                                        AcctSeedERP__Product__r.AcctSeedERP__Minimum_Order_Quantity__c, AcctSeedERP__Product__r.AcctSeedERP__Safety_Stock_Quantity__c,  AcctSeedERP__Project__c, AcctSeedERP__Project_Task__c,
                                        SOLine_Total__c, Cost_Code__c, Unit_Cost__c, Additional_Notes__c, Customer__c, Not_To_Exceed__c, Site__c, Con_Req_Group__c, 
                                        AcctSeedERP__GL_Account_Variable_1__c, AcctSeedERP__GL_Account_Variable_2__c, AcctSeedERP__GL_Account_Variable_3__c, AcctSeedERP__GL_Account_Variable_4__c
                                        FROM AcctSeedERP__Sales_Order_Line__c 
                                        WHERE Id In :(AcctSeedERP__Sales_Order_Line__c[])setController.getSelected() 
                                        AND AcctSeedERP__Purchase_Order_Line__c = null 
                                        AND AcctSeedERP__Manufacturing_Order__c = null 
                                        //And AcctSeedERP__Sales_Order__r.AcctSeedERP__Status__c = 'Open'
                                        And Approval_Status__c = 'Approved'
                                        And Vendor__c != null
                                        And AcctSeedERP__Quantity_Needed__c > 0
                                        And ((AcctSeedERP__Product__r.AcctSeed__Inventory_Type__c = 'Raw Material'
                                        And AcctSeedERP__Product__r.AcctSeed__Inventory_Product__c = true) Or AcctSeedERP__Product__r.AcctSeed__Inventory_Type__c = 'Purchased')]) {
            
            if (productSOWrapperMap.containsKey(so.Vendor__c)) {
                productSOWrapperMap.get(so.Vendor__c).soLines.add(so);
                if (so.Not_To_Exceed__c == 'Yes') {
                	productSOWrapperMap.get(so.Vendor__c).po.Not_To_Exceed__c = so.Not_To_Exceed__c;
                } 
            }
            else {
                productSOWrapperMap.put(so.Vendor__c, new SalesOrderWrapper(so.Vendor__r,new AcctSeedERP__Sales_Order_Line__c[]{so}));
                if (so.Not_To_Exceed__c == 'Yes') {
                	productSOWrapperMap.get(so.Vendor__c).po.Not_To_Exceed__c = so.Not_To_Exceed__c;
                }
            }           
        } 
              
        soWrapperList = productSOWrapperMap.values();  

        if (soWrapperList.isEmpty()) {
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.INFO, 'None of the sales orders lines you have selected require a purchase order. The sales order lines must have a vendor and be associated with a product where inventory product is checked and raw material is the inventory type or the inventory type is purchased and have an approval status of \'Approved\''));  
            showMessages = true;
            isError = true;   
        }
    }

    public PageReference createPurchaseOrders() {
        
         Savepoint sp = Database.setSavepoint();
        
        try {
            // Get the Con Req Group Ids that are associated with the Sales Order Lines and the POs that need to be created
            poList = new List<AcctSeedERP__Purchase_Order__c>();
            Set<Id> crgIds = new Set<Id>();
            for (SalesOrderWrapper sow : soWrapperList) {
            	for (AcctSeedERP__Sales_Order_Line__c sol : sow.soLines) {
            		if (sol.Con_Req_Group__c != null) {
            			crgIds.add(sol.Con_Req_Group__c);
            		}
            	}
            	poList.add(sow.po);
            }
            
            insert poList;
			
			poLineMap = new Map<Id,AcctSeedERP__Purchase_Order_Line__c>();
            for (SalesOrderWrapper sow : soWrapperList) {
                for (AcctSeedERP__Sales_Order_Line__c sol : sow.soLines) {
                    AcctSeedERP__Purchase_Order_Line__c pol = new AcctSeedERP__Purchase_Order_Line__c();
                    pol.AcctSeedERP__Purchase_Order__c = sow.po.Id;
                    pol.Freight__c = sol.Freight__c;
                    pol.AcctSeedERP__Quantity__c = sol.AcctSeedERP__Quantity_Needed__c;
                    //pol.Sales_Tax_Rate_Table__c = sol.Sales_Tax_Rate_Table__c;
                    pol.Tax_Group__c = sol.Tax_Group__c;
                    pol.Additional_Notes__c = sol.Additional_Notes__c;
                    pol.Unit_Cost__c = sol.Unit_Cost__c;
                    pol.Ship_to_Account__c = sol.Ship_to_Account__c;
                    pol.AcctSeedERP__Product__c = sol.AcctSeedERP__Product__c;
                    pol.AcctSeedERP__Project__c = sol.AcctSeedERP__Project__c;
                    pol.AcctSeedERP__Project_Task__c = sol.AcctSeedERP__Project_Task__c;
                    pol.AcctSeedERP__GL_Account_Variable_1__c = sol.AcctSeedERP__GL_Account_Variable_1__c;
                    pol.AcctSeedERP__GL_Account_Variable_2__c = sol.AcctSeedERP__GL_Account_Variable_2__c;
                    pol.AcctSeedERP__GL_Account_Variable_3__c = sol.AcctSeedERP__GL_Account_Variable_3__c;
                    pol.AcctSeedERP__GL_Account_Variable_4__c = sol.AcctSeedERP__GL_Account_Variable_4__c;
                    pol.AcctSeedERP__Unit_Price__c = 1;
                    pol.Requested_Delivery_Date__c = sol.Requested_Delivery_Date__c;
                    //pol.Customer__c = sol.Customer__c; 
                    pol.Site__c = sol.Site__c;                   
                    poLineMap.put(sol.Id,pol);
                    
                }
            }
            
            insert poLineMap.values();
            
            List<AcctSeedERP__Sales_Order_Line__c> solList = new List<AcctSeedERP__Sales_Order_Line__c>();
            for (SalesOrderWrapper sow : soWrapperList) {
                for (AcctSeedERP__Sales_Order_Line__c sol : sow.soLines) {
                    sol.AcctSeedERP__Purchase_Order_Line__c = poLineMap.get(sol.Id).Id;
                    solList.add(sol);
                }
            }
            
            update solList;
            
            // Get the Con Req Group records that are associated with the Sales Order Lines - we
            // will grab the Ship To information in the Con Req Group and copy it to the PO.  We
            // have to do this after the POs have been inserted to override the default AcctSeed behavior.
            if (!crgIds.isEmpty()) {
            	Map<Id, Con_Req_Group__c> crgMap = new Map<Id, Con_Req_Group__c>([select Id, Ship_To_Street__c, Ship_To_City__c, 
            			Ship_To_State__c, Ship_To_Zip__c from Con_Req_Group__c where Id in :crgIds]);
            	
            	poList.clear();
            	for (SalesOrderWrapper sow : soWrapperList) {
                	for (AcctSeedERP__Sales_Order_Line__c sol : sow.soLines) {
            			if (crgMap.containsKey(sol.Con_Req_Group__c)) {
            				sow.po.AcctSeedERP__Shipping_Street__c = crgMap.get(sol.Con_Req_Group__c).Ship_To_Street__c;
            				sow.po.AcctSeedERP__Shipping_City__c = crgMap.get(sol.Con_Req_Group__c).Ship_To_City__c;
            				sow.po.AcctSeedERP__Shipping_State__c = crgMap.get(sol.Con_Req_Group__c).Ship_To_State__c;
            				sow.po.AcctSeedERP__Shipping_Postal_Code__c = crgMap.get(sol.Con_Req_Group__c).Ship_To_Zip__c;
            				poList.add(sow.po);
            				break;
            			}
            		}
           		}
            	if (!poList.isEmpty()) {
            		update poList;
            	}
            }
            
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'The purchase orders have been created'));  
            isProcessed = true;
                
        } catch (Exception ex) {
            Database.rollback(sp);
            ApexPages.addMessages(ex);
        }
        
        return null;
    }
    
    @IsTest(SeeAllData = true)
    public static void testCreatePurchaseOrders() {
        
        //List<AcctSeed__Project__c> projects = new List<AcctSeed__Project__c>();
        //projects = [select Id from AcctSeed__Project__c where Name = 'Seneca Solar'];

        List<AcctSeedERP__Sales_Order_Line__c> salesOrderLines = new List<AcctSeedERP__Sales_Order_Line__c>();
        /*
        salesOrderLines = [select Id, AcctSeedERP__Sales_Order__c, AcctSeedERP__Product__c, AcctSeedERP__Quantity_Ordered__c,
                AcctSeedERP__Unit_Price__c, Approval_Status__c, Unit_Cost__c, Freight__c, Vendor__c, Service_Visit__c, 
                Type__c, AcctSeedERP__Project__c, AcctSeedERP__Project_Task__c 
                from AcctSeedERP__Sales_Order_Line__c where AcctSeedERP__Project__c = :projects[0].Id];
        */
                   
        salesOrderLines = [select Id, AcctSeedERP__Sales_Order__c, AcctSeedERP__Product__c, AcctSeedERP__Quantity_Ordered__c,
                AcctSeedERP__Unit_Price__c, Approval_Status__c, Unit_Cost__c, Freight__c, Vendor__c, Service_Visit__c, 
                Type__c, AcctSeedERP__Project__c, AcctSeedERP__Project_Task__c 
                from AcctSeedERP__Sales_Order_Line__c 
                where AcctSeedERP__Project__c != null 
                and AcctSeedERP__Purchase_Order_Line__c = null 
                and AcctSeedERP__Manufacturing_Order__c = null 
                and Approval_Status__c = 'Approved' 
                //and Vendor__c != null 
                and Vendor__r.AcctSeed__Accounting_Type__c = 'Customer and Vendor' 
                and AcctSeedERP__Quantity_Needed__c > 0 
                and ((AcctSeedERP__Product__r.AcctSeed__Inventory_Type__c = 'Raw Material' and AcctSeedERP__Product__r.AcctSeed__Inventory_Product__c = true) or AcctSeedERP__Product__r.AcctSeed__Inventory_Type__c = 'Purchased') 
                limit 3];
        
        //system.assertEquals(3, salesOrderLines.size());
        system.assert(!salesOrderLines.isEmpty());
        
        ApexPages.StandardSetController setController = new ApexPages.StandardSetController(salesOrderLines);
        CreatePurchaseOrderLines cpol = new CreatePurchaseOrderLines(setController);
        // Test no selected sales orders
        //System.assertEquals(0, cpol.soWrapperList.size());
        //System.assertEquals(true, cpol.isError);
        system.debug('***** size of soWrapperList = ' + cpol.soWrapperList.size());
        system.debug('***** isError = ' + cpol.isError);
        
        setController.setSelected(setController.getRecords());
        cpol = new CreatePurchaseOrderLines(setController);
        //System.assertEquals(3, cpol.soWrapperList.size());
        system.debug('***** size of soWrapperList 2 = ' + cpol.soWrapperList.size());
        
        cpol.createPurchaseOrders();
    }
    
    /*
    public static void testCreatePurchaseOrders() {
        List<Account> accounts = new List<Account>();
        
        accounts.add(
            new Account(
                Name = 'TOOTALOO',
                AcctSeed__Accounting_Type__c = 'Customer and Vendor',
                AcctSeed__Credit_Card_Vendor__c = true,
                ShippingCity = 'San Francisco'
            )
        );

        accounts.add(
            new Account(
                Name = 'LOOTJUNK',
                AcctSeed__Accounting_Type__c = 'Customer and Vendor',
                AcctSeed__Credit_Card_Vendor__c = true,
                ShippingCity = 'San Francisco'
            )
        );
        
        accounts.add(
            new Account(
                Name = 'JAMBONAROO',
                AcctSeed__Accounting_Type__c = 'Customer and Vendor',
                AcctSeed__Credit_Card_Vendor__c = true,
                ShippingCity = 'San Francisco'
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

        insert products;   
        
        List<AcctSeedERP__Sales_Order__c> salesOrders = new List<AcctSeedERP__Sales_Order__c>();
        accounts[0].AcctSeed__Accounting_Type__c = 'Vendor';
        accounts[1].AcctSeed__Accounting_Type__c = 'Vendor';
        accounts[2].AcctSeed__Accounting_Type__c = 'Vendor';
        update accounts;
                
        salesOrders.add(
            new AcctSeedERP__Sales_Order__c(
               AcctSeedERP__Customer__c = accounts[0].Id,
               AcctSeedERP__Status__c = 'Open'
            )
        );  
        
        salesOrders.add(
            new AcctSeedERP__Sales_Order__c(
               AcctSeedERP__Customer__c = accounts[1].Id,
               AcctSeedERP__Status__c = 'Open'
            )
        );  

        salesOrders.add(
            new AcctSeedERP__Sales_Order__c(
               AcctSeedERP__Customer__c = accounts[2].Id,
               AcctSeedERP__Status__c = 'Open'
            )
        );  
                
        insert salesOrders;   
        
        // Create a Service Contract and Service Visits
        List<Contract> svContracts = new List<Contract>();
        svContracts.add(
        	new Contract(
        		AccountId = accounts[0].Id,
        		Contract_Amount__c = 30000,
        		ContractTerm = 120,
        		Service_Schedule_months__c = 12
        	)
        );
        insert svContracts;
        
        List<SV__c> serviceVisits = new List<SV__c>();
        serviceVisits.add(
        	new SV__c(
        		Account__c = accounts[0].Id,
        		Visit_Date__c = system.today(),
        		Visit_Reason__c = 'Reactive Service',
        		Cost__c = 500,
        		Status__c = 'Complete',
        		Contract__c = svContracts[0].Id,
        		Notes__c = 'This is a note'
        	)
        );
        serviceVisits.add(
        	new SV__c(
        		Account__c = accounts[0].Id,
        		Visit_Date__c = system.today(),
        		Visit_Reason__c = 'Reactive Service',
        		Cost__c = 500,
        		Status__c = 'Complete',
        		Contract__c = svContracts[0].Id,
        		Notes__c = 'This is a note'
        	)
        );
        insert serviceVisits;
        
        List<AcctSeedERP__Sales_Order_Line__c> salesOrderLines = new List<AcctSeedERP__Sales_Order_Line__c>();
        
        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[0].Id,
               AcctSeedERP__Product__c = products[0].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Approval_Status__c = 'Approved',               
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[0].Id
            )        
        ); 
        
        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[0].Id,
               AcctSeedERP__Product__c = products[1].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Approval_Status__c = 'Approved',               
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[0].Id               
            )        
        );
               
        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[1].Id,
               AcctSeedERP__Product__c = products[1].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Approval_Status__c = 'Approved',               
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[1].Id             
            )        
        ); 
        
        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[1].Id,
               AcctSeedERP__Product__c = products[0].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Approval_Status__c = 'Approved',               
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[1].Id              
            )        
        );   

        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[2].Id,
               AcctSeedERP__Product__c = products[1].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Approval_Status__c = 'Approved',               
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[2].Id               
            )        
        );
        
        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[2].Id,
               AcctSeedERP__Product__c = products[0].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Approval_Status__c = 'Approved',               
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[2].Id
            )        
        ); 
        
        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[2].Id,
               AcctSeedERP__Product__c = products[1].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               Approval_Status__c = 'Approved',
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[2].Id               
            )        
        );

        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[1].Id,
               AcctSeedERP__Product__c = products[0].Id,
               AcctSeedERP__Quantity_Ordered__c = 2,
               AcctSeedERP__Unit_Price__c = 2,
               Approval_Status__c = 'Approved',
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[1].Id              
            )        
        ); 

        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[0].Id,
               AcctSeedERP__Product__c = products[1].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 3,
               Approval_Status__c = 'Approved',
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[0].Id
            )        
        );
        
        // Construction Requisitions (Sales Order Lines) of recordtype Service
        RecordType rtService = [SELECT Id, Name FROM RecordType WHERE Name = 'Service' and SobjectType = 'AcctSeedERP__Sales_Order_Line__c'];
        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[0].Id,
               AcctSeedERP__Product__c = products[1].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 3,
               Approval_Status__c = 'Approved',
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[2].Id,
               RecordTypeId = rtService.Id,
               Service_Visit__c = serviceVisits[0].Id,
               Type__c = 'Warranty'
            )        
        );
        
        salesOrderLines.add(
            new AcctSeedERP__Sales_Order_Line__c(
               AcctSeedERP__Sales_Order__c = salesOrders[0].Id,
               AcctSeedERP__Product__c = products[1].Id,
               AcctSeedERP__Quantity_Ordered__c = 6,
               AcctSeedERP__Unit_Price__c = 3,
               Approval_Status__c = 'Approved',
               Unit_Cost__c = 100,
               Freight__c = 25,
               Vendor__c = accounts[2].Id,
               RecordTypeId = rtService.Id,
               Service_Visit__c = serviceVisits[1].Id,
               Type__c = 'Paid'
            )        
        );
                
        insert salesOrderLines;     
        
        ApexPages.StandardSetController setController = new ApexPages.StandardSetController(salesOrderLines);
        CreatePurchaseOrderLines cpol = new CreatePurchaseOrderLines(setController);
        // Test no selected sales orders
        System.assertEquals(0, cpol.soWrapperList.size());
        System.assertEquals(true, cpol.isError);
        
        setController.setSelected(setController.getRecords());
        cpol = new CreatePurchaseOrderLines(setController);
        System.assertEquals(3, cpol.soWrapperList.size());
        
        //cpol.createPurchaseOrders();
        
        //System.assertEquals(3,cpol.poList.size());
        //System.assertEquals(11,[Select count() From AcctSeedERP__Purchase_Order_Line__c Where Id In :cpol.poLineMap.values()]);
        
    }
	*/
}