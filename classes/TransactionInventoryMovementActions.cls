public class TransactionInventoryMovementActions {
    public static void populateMovmentFields(AcctSeed__Transaction__c[] transactions) {
        Map<Id,AcctSeedERP__Inbound_Inventory_Movement__c> inboundMovements = new Map<Id,AcctSeedERP__Inbound_Inventory_Movement__c>();
        Map<Id,AcctSeedERP__Outbound_Inventory_Movement__c> outboundMovements = new Map<Id,AcctSeedERP__Outbound_Inventory_Movement__c>();
        
        for (AcctSeed__Transaction__c tran : transactions) {
            if (tran.AcctSeedERP__Inbound_Inventory_Movement__c != null) {
                inboundMovements.put(tran.AcctSeedERP__Inbound_Inventory_Movement__c,null);
            }
            else if (tran.AcctSeedERP__Outbound_Inventory_Movement__c != null) {
                outboundMovements.put(tran.AcctSeedERP__Outbound_Inventory_Movement__c,null);
            }
        }
        
        for (AcctSeedERP__Inbound_Inventory_Movement__c inBound : [Select Id, AcctSeedERP__Project__c, AcctSeedERP__Project_Task__c, Branch__c ,Total_Burdened_Value__c
                                                                    From AcctSeedERP__Inbound_Inventory_Movement__c Where Id In :inboundMovements.keySet()]) {
        
            inboundMovements.put(inBound.Id,inBound);                                                       
        }
        
        for (AcctSeedERP__Outbound_Inventory_Movement__c outBound : [Select Id, AcctSeedERP__Project__c, AcctSeedERP__Project_Task__c, Branch__c,Total_Burdened_Value__c 
                                                                    From AcctSeedERP__Outbound_Inventory_Movement__c Where Id In :outboundMovements.keySet()]) {        
            outboundMovements.put(outBound.Id,outBound);                                                                    
        }
        
        for (AcctSeed__Transaction__c tran : transactions) {
            if (tran.AcctSeedERP__Inbound_Inventory_Movement__c != null) {
                tran.AcctSeed__Project__c = inboundMovements.get(tran.AcctSeedERP__Inbound_Inventory_Movement__c).AcctSeedERP__Project__c;
                tran.AcctSeed__Project_Task__c = inboundMovements.get(tran.AcctSeedERP__Inbound_Inventory_Movement__c).AcctSeedERP__Project_Task__c;
                tran.AcctSeed__GL_Account_Variable_1__c = inboundMovements.get(tran.AcctSeedERP__Inbound_Inventory_Movement__c).Branch__c;
                //tran.AcctSeed__Amount__c =inboundMovements.get(tran.AcctSeedERP__Inbound_Inventory_Movement__c).Total_Burdened_Value__c;
            }
            else if (tran.AcctSeedERP__Outbound_Inventory_Movement__c != null) {
                tran.AcctSeed__Project__c = outboundMovements.get(tran.AcctSeedERP__Outbound_Inventory_Movement__c).AcctSeedERP__Project__c;
                tran.AcctSeed__Project_Task__c = outboundMovements.get(tran.AcctSeedERP__Outbound_Inventory_Movement__c).AcctSeedERP__Project_Task__c;
                tran.AcctSeed__GL_Account_Variable_1__c = outboundMovements.get(tran.AcctSeedERP__Outbound_Inventory_Movement__c).Branch__c;
                //tran.AcctSeed__Amount__c =outboundMovements.get(tran.AcctSeedERP__Outbound_Inventory_Movement__c).Total_Burdened_Value__c;
            }
        }       
    }
    
    @IsTest(SeeAllData=true)
    public static void testTransactionInventoryMovementActions() {
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
         test.starttest();      
         AcctSeed__Accounting_Variable__c glVar1 = new AcctSeed__Accounting_Variable__c();
        glVar1.Name = 'Test Var 1';
        glVar1.AcctSeed__Type__c = 'GL Account Variable 1';         
        insert glVar1;
        
        AcctSeedERP__Inbound_Inventory_Movement__c iim = new AcctSeedERP__Inbound_Inventory_Movement__c();
        iim.AcctSeedERP__Movement_Date__c = Date.newinstance(2025, 1, 1); 
        iim.AcctSeedERP__Inventory_Balance__c = balances[0].Id;
        iim.AcctSeedERP__Quantity__c = 7;
        iim.AcctSeedERP__Unit_Cost__c = 3;
        iim.AcctSeedERP__Type__c = 'Transfer';
        iim.AcctSeedERP__Credit_GL_Account__c = glAccounts[0].Id;
       // iim.Branch__c = glVar1.Id;
        iim.AcctSeedERP__Project__c = projects[0].Id;
        iim.AcctSeedERP__Project_Task__c = projectTasks[0].Id;
        insert iim;
        
        //System.assertEquals(glVar1.Id,[Select AcctSeed__GL_Account_Variable_1__c From AcctSeed__Transaction__c Where AcctSeedERP__Inbound_Inventory_Movement__c =:iim.Id limit 1 ].AcctSeed__GL_Account_Variable_1__c); //
        System.assertEquals(projects[0].Id,[Select AcctSeed__Project__c From AcctSeed__Transaction__c Where AcctSeedERP__Inbound_Inventory_Movement__c = :iim.Id limit 1].AcctSeed__Project__c); //:iim.Id limit 1
        System.assertEquals(projectTasks[0].Id,[Select AcctSeed__Project_Task__c From AcctSeed__Transaction__c Where AcctSeedERP__Inbound_Inventory_Movement__c = :iim.Id limit 1 ].AcctSeed__Project_Task__c); //:iim.Id limit 1

        AcctSeedERP__Outbound_Inventory_Movement__c oim = new AcctSeedERP__Outbound_Inventory_Movement__c();
        oim.AcctSeedERP__Movement_Date__c = Date.newinstance(2025, 1, 1);
        oim.AcctSeedERP__Inventory_Balance__c = balances[0].Id;
        oim.AcctSeedERP__Quantity__c = 7;
        oim.AcctSeedERP__Unit_Cost__c = 3;
        oim.AcctSeedERP__Type__c = 'Transfer';
        oim.AcctSeedERP__Debit_GL_Account__c = glAccounts[0].Id;
       // oim.Branch__c = glVar1.Id;
        oim.AcctSeedERP__Project__c = projects[0].Id;
        oim.AcctSeedERP__Project_Task__c = projectTasks[0].Id;
        insert oim;
        
       // System.assertEquals(glVar1.Id,[Select AcctSeed__GL_Account_Variable_1__c From AcctSeed__Transaction__c Where AcctSeedERP__Outbound_Inventory_Movement__c = :oim.Id limit 1].AcctSeed__GL_Account_Variable_1__c);
        System.assertEquals(projects[0].Id,[Select AcctSeed__Project__c From AcctSeed__Transaction__c Where AcctSeedERP__Outbound_Inventory_Movement__c = :oim.Id limit 1].AcctSeed__Project__c);
      //  System.assertEquals(projectTasks[0].Id,[Select AcctSeed__Project_Task__c From AcctSeed__Transaction__c Where AcctSeedERP__Outbound_Inventory_Movement__c = :oim.Id limit 1].AcctSeed__Project_Task__c);
        
        test.stoptest();
    } 
}