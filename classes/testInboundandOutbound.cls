@isTest(SeeAllData = true)
public class testInboundandOutbound {
    /*** 

      Method for testing Inbound and Outbound Movement 
      
      ***/
      
      static testMethod void testmethod1() {
      
      List<Account> accounts = new List<Account>();
        
        accounts.add(
            new Account(
                Name = 'Test Account',
                AcctSeed__Accounting_Type__c = 'Customer and Vendor',
                ShippingCity = 'San Francisco',
                AcctSeed__Credit_Card_Vendor__c = true
            )
        );

   List<AcctSeedERP__Warehouse__c> warehouses = new List<AcctSeedERP__Warehouse__c>();
        
        warehouses.add(
            new AcctSeedERP__Warehouse__c(
                Name = 'Warehouse 1'
            )
        );
        insert warehouses;
        
        List<AcctSeedERP__Location__c> locations = new List<AcctSeedERP__Location__c>();
        
        locations.add(
            new AcctSeedERP__Location__c(
                Name = 'Warehouse 1 Location 1',
                AcctSeedERP__Warehouse__c = warehouses[0].Id
            )
        );       
        insert locations;

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
                Name = 'Test Prod 1',
                AcctSeed__Inventory_GL_Account__c = glAccounts[5].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[0].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[2].Id,
                AcctSeed__Inventory_Type__c = 'Other Costs',
                AcctSeed__Inventory_Product__c = true,
                AcctSeed__Unit_Cost__c = 100
            )
        );
        insert products;
       
        List<AcctSeedERP__Inventory_Balance__c> balances = new List<AcctSeedERP__Inventory_Balance__c>();                
        balances.add(
            new AcctSeedERP__Inventory_Balance__c(
                AcctSeedERP__Product__c = products[0].Id,
                AcctSeedERP__Warehouse__c = warehouses[0].Id,
                AcctSeedERP__Location__c = locations[0].Id
            )
        );
        insert balances;

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

        

        List<AcctSeed__Project__c> projects = new List<AcctSeed__Project__c>(); 
        projects.add(
            new AcctSeed__Project__c(
                Name = 'Test Project',
                //AcctSeed__Account__c = accounts[0].Id,
               
                AcctSeed__Status__c = 'Active'
            )
        );
        insert projects;
          User owner = [select Id from User where Name = 'Michael Hall']; 
          
        Account AccMake = new Account(Name = 'test123456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert AccMake;   
    Opportunity OppMake1 = new Opportunity(OwnerId = owner.Id, Name = 'Knight - 245613456',AccountId = AccMake.Id,Type = 'Turnkey System',
                                            CloseDate = System.today(),StageName = 'Prospecting'); insert OppMake1;       
        
          Site__c testSite = new Site__c(Name = 'testSite', Project__c = projects[0].Id,opportunity__c=OppMake1.Id,Site_Address__c='123 test street',Site_City__c='Hopkinton',Site_Zip__c='01748',Type__c='Fixed Tilt Ground');
        insert testSite;
        
       List<AcctSeed__Project_Task__c> projectTasks = new List<AcctSeed__Project_Task__c>();
        projectTasks.add(
            new AcctSeed__Project_Task__c(
                Name = 'Test Project Task 1',
                AcctSeed__Project__c = projects[0].Id,
                AcctSeed__Status__c = 'Active',
                AcctSeed__Labor_GL_Account__c = glAccounts[0].Id
            )
        );
        insert projectTasks;
             
         AcctSeed__Accounting_Variable__c glVar1 = new AcctSeed__Accounting_Variable__c();
        glVar1.Name = 'Test Var 1';
        glVar1.AcctSeed__Type__c = 'GL Account Variable 1';         
        insert glVar1;
        
                List<AcctSeedERP__Purchase_Order__c> purchaseOrders = new List<AcctSeedERP__Purchase_Order__c>();
                
                List<Tax_Rate__c> taxRates = new List<Tax_Rate__c>();
        taxRates.add(
            new Tax_Rate__c(
                Tax_Rate__c = 7
            )
        );  
        insert taxRates;
        
        purchaseOrders.add(
            new AcctSeedERP__Purchase_Order__c(
               AcctSeedERP__Vendor__c = accounts[0].Id,
               AcctSeedERP__Status__c = 'Open'
            )
        );  
        
       // insert purchaseOrders; 
        List<AcctSeedERP__Purchase_Order_Line__c> purchaseOrderLines = new List<AcctSeedERP__Purchase_Order_Line__c>();
        
        purchaseOrderLines.add(
            new AcctSeedERP__Purchase_Order_Line__c(
               AcctSeedERP__Purchase_Order__c = 'a2980000001HzAB',
               AcctSeedERP__Product__c = products[0].Id,
               AcctSeedERP__Quantity__c = 6,
               AcctSeedERP__Unit_Price__c = 1,
               AcctSeedERP__Project__c = projects[0].Id,
               Unit_Cost__c = 4,
               Freight__c = 10,
               AcctSeedERP__Project_Task__c=projectTasks[0].Id,
               Sales_Tax_Rate_Table__c = taxRates[0].Id
            )        
        ); 
         
         insert purchaseOrderLines;
        system.debug('look here' +purchaseOrderLines);
        
         test.starttest(); 
        AcctSeedERP__Inbound_Inventory_Movement__c iim = new AcctSeedERP__Inbound_Inventory_Movement__c();
        iim.AcctSeedERP__Movement_Date__c = Date.newinstance(2025, 1, 1); 
        iim.AcctSeedERP__Inventory_Balance__c = balances[0].Id;
        iim.AcctSeedERP__Quantity__c = 7;
        iim.AcctSeedERP__Unit_Cost__c = 3;
        iim.AcctSeedERP__Type__c = 'Transfer';
        iim.AcctSeedERP__Credit_GL_Account__c =glAccounts[0].Id;// 'a1m80000000p2kt';//
          
       // iim.Branch__c = glVar1.Id;
        iim.AcctSeedERP__Project__c = projects[0].Id;
        iim.AcctSeedERP__Project_Task__c = projectTasks[0].Id;
        iim.Site__c = testSite.id;
        iim.Purchase_Order_Line__c =  purchaseOrderLines[0].id;
        insert iim;
        
        system.debug('LOOK HERE'  +iim);
     //   System.assertEquals(glVar1.Id,[Select AcctSeed__GL_Account_Variable_1__c From AcctSeed__Transaction__c Where AcctSeedERP__Inbound_Inventory_Movement__c =:iim.Id limit 1 ].AcctSeed__GL_Account_Variable_1__c); //
     //   System.assertEquals('',[Select AcctSeed__GL_Account_Variable_1__c From AcctSeed__Transaction__c Where AcctSeedERP__Inbound_Inventory_Movement__c =:iim.Id limit 1 ].AcctSeed__GL_Account_Variable_1__c); //
        System.assertEquals(projects[0].Id,[Select AcctSeed__Project__c From AcctSeed__Transaction__c Where AcctSeedERP__Inbound_Inventory_Movement__c = :iim.Id limit 1].AcctSeed__Project__c); //:iim.Id limit 1
        System.assertEquals(projectTasks[0].Id,[Select AcctSeed__Project_Task__c From AcctSeed__Transaction__c Where AcctSeedERP__Inbound_Inventory_Movement__c = :iim.Id limit 1 ].AcctSeed__Project_Task__c); //:iim.Id limit 1

        AcctSeedERP__Outbound_Inventory_Movement__c oim = new AcctSeedERP__Outbound_Inventory_Movement__c();
        oim.AcctSeedERP__Movement_Date__c = Date.newinstance(2025, 1, 1);
        oim.AcctSeedERP__Inventory_Balance__c = balances[0].Id;
        oim.AcctSeedERP__Quantity__c = 7;
        oim.AcctSeedERP__Unit_Cost__c = 3;
        oim.AcctSeedERP__Type__c = 'Transfer';
        oim.AcctSeedERP__Debit_GL_Account__c = glAccounts[0].Id;//'a1m80000000p2kt'
       // oim.Branch__c = glVar1.Id;
        oim.AcctSeedERP__Project__c = projects[0].Id;
        oim.AcctSeedERP__Project_Task__c = projectTasks[0].Id;
        oim.Site__c = testSite.id;
        oim.Purchase_Order_Line__c = purchaseOrderLines[0].id;
        insert oim;

       // System.assertEquals(glVar1.Id,[Select AcctSeed__GL_Account_Variable_1__c From AcctSeed__Transaction__c Where AcctSeedERP__Outbound_Inventory_Movement__c = :oim.Id limit 1].AcctSeed__GL_Account_Variable_1__c);
        System.assertEquals(projects[0].Id,[Select AcctSeed__Project__c From AcctSeed__Transaction__c Where AcctSeedERP__Outbound_Inventory_Movement__c = :oim.Id limit 1].AcctSeed__Project__c);
      //  System.assertEquals(projectTasks[0].Id,[Select AcctSeed__Project_Task__c From AcctSeed__Transaction__c Where AcctSeedERP__Outbound_Inventory_Movement__c = :oim.Id limit 1].AcctSeed__Project_Task__c);
        
        test.stoptest();

      }

}