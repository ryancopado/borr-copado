/* Auther: Madan(Forcebrain Developer)
/* Date: Sept 18, 2017
/* Description: To increase code coverage of Billing Line Trigger and Handler class
*/
@isTest(SeeAllData=True)
public class TestAccountPayableLineHandler {
 
    class Fixture
    {
        AcctSeed__Account_Payable__c ap_1;
        AcctSeed__Account_Payable_Line__c apl_1;
        AcctSeed__Account_Payable__c ap_2;
        AcctSeed__Account_Payable_Line__c apl_2;
        AcctSeed__Account_Payable__c ap_3;
        AcctSeed__Account_Payable_Line__c apl_3;
        AcctSeed__Account_Payable__c ap_4;
        AcctSeed__Account_Payable_Line__c apl_4;
        AcctSeed__Account_Payable__c ap_5;
        List<AcctSeed__Account_Payable__c> aps =
            new List<AcctSeed__Account_Payable__c>();
        List<AcctSeed__Account_Payable_Line__c> apLines =
            new List<AcctSeed__Account_Payable_Line__c>();
        AcctSeed__Accounting_Period__c aPeriod_one;
        Account account_one;
        Account account_two;
        Account account_five;
        AcctSeed__GL_Account__c expAccount;
        AcctSeed__Accounting_Variable__c var1;
        AcctSeed__Accounting_Variable__c var2;
        AE_SmartInvoiceHeader__c sih_one;
        AE_SmartInvoiceHeader__c sih_two;
        AE_SmartInvoiceHeader__c sih_three;
        AE_SmartInvoiceHeader__c sih_four;
        AE_OcrSmartTimestamp__c timestamp_one;
        AcctSeed__Cash_Disbursement__c cd_1;
        AcctSeed__Cash_Disbursement__c cd_2;
        AcctSeed__Cash_Disbursement__c cd_3;
        AcctSeed__Cash_Disbursement__c cd_4;
        AcctSeed__Cash_Disbursement_Batch__c cdb_1;
        Account ac_1;
        User us_1;
        Contact ct_1;
        AcctSeed__GL_Account__c ba_1;
        AS_ACH__c ach_1;
        AS_ACH__c ach_2;
        AS_ACH__c ach_3;
        AcctSeed__AP_Disbursement__c apd_1;
        
        Fixture()
        { 
            Boolean result = AE_Utilities.getConfig();
            if(result == false)
            {
              throw new AE_Utilities.AE_Exception('No APSmart Configuration');
            }
            insert timestamp_one = new AE_OcrSmartTimestamp__c();
            expAccount = [SELECT Id,Name
                          FROM AcctSeed__GL_Account__c
                          WHERE Name like  '4301%'
                          LIMIT 1];
            System.debug('AS: WSUT expAccount is `' + expAccount + '\'');
            var1 = [SELECT Id,Name,AcctSeed__Type__c
                    FROM AcctSeed__Accounting_Variable__c
                    WHERE Name like 'So Cal'
                    LIMIT 1];
            System.debug('AS: WSUT var1 is `' + var1 + '\'');
            var2 = [SELECT Id,Name,AcctSeed__Type__c
                    FROM AcctSeed__Accounting_Variable__c
                    WHERE Name like 'WDG'
                    LIMIT 1];
            System.debug('AS: WSUT var2 is `' + var2 + '\'');
            account_one = [SELECT Id,Name
              FROM Account 
              WHERE Name = :AE_Utilities.AE_Config.UnknownVendor__c];
            System.debug('AS: WSUT account_one is `' + account_one + '\'');
            account_two = [SELECT Id,Name
              FROM Account
              WHERE Name = :AE_Utilities.AE_Config.DefaultVendor__c];
            System.debug('AS: WSUT account_two is `' + account_two + '\'');
              account_five = [SELECT Id,Name
              FROM Account 
              WHERE Name = 'Also Energy Inc.'];
            System.debug('AS: WSUT account_five is `' + account_five + '\'');
           /* insert aPeriod_one = new AcctSeed__Accounting_Period__c(
              Name = '2020-11', //'2000-11',
              AcctSeed__Start_Date__c = Date.newInstance(2020, 11, 1),     //(2000, 11, 1),
              AcctSeed__End_Date__c = Date.newInstance(2020, 11, 30),  //(2000, 11, 30),
              AcctSeed__Status__c = 'Open'
            );*/
            /*
            aPeriod_one = [SELECT Id,Name
                           FROM AcctSeed__Accounting_Period__c
                           WHERE AcctSeed__Status__c = 'Open'
                           LIMIT 1
                          ];
            */
            String dateNow = AE_Utilities.getLocalDateTime().format('yyyy-MM');
            System.debug('AS: FPI dateNow is `' + dateNow + '\'');
            aPeriod_one = [SELECT Id,Name 
                          FROM AcctSeed__Accounting_Period__c
                          WHERE Name = :dateNow];
            ap_1 = new AcctSeed__Account_Payable__c(
                AcctSeed__Vendor__c = account_one.Id,
                AcctSeed__Accounting_Period__c = aPeriod_one.Id,
                AcctSeed__Payee_Reference__c = 'INV01233'
            );
            aps.add(ap_1);
            
            /*ap_1 = new AcctSeed__Account_Payable__c(
                AcctSeed__Vendor__c = account_one.Id,
                AcctSeed__Accounting_Period__c = aPeriod_one.Id,
                AcctSeed__Payee_Reference__c = 'INV01233',
                AcctSeed__Status__c = 'Rejected'
            );
            aps.add(ap_1);*/
            ap_2 = new AcctSeed__Account_Payable__c(
                AcctSeed__Vendor__c = account_one.Id,
                AcctSeed__Accounting_Period__c = aPeriod_one.Id,
                AcctSeed__Payee_Reference__c = 'INV01234');
            aps.add(ap_2);
            ap_3 = new AcctSeed__Account_Payable__c(
                AcctSeed__Vendor__c = account_one.Id,
                AcctSeed__Accounting_Period__c = aPeriod_one.Id,
                AcctSeed__Payee_Reference__c = 'INV01235');
            aps.add(ap_3);
            ap_4 = new AcctSeed__Account_Payable__c(  
                AcctSeed__Vendor__c = account_one.Id,
                AcctSeed__Accounting_Period__c = aPeriod_one.Id,
                AcctSeed__Payee_Reference__c = 'INV01236');
            aps.add(ap_4);
            insert aps;
            
            // Create all of the data we will need for the unit tests
        List<Account> accounts = new List<Account>();
        accounts.add(
            new Account(
                Name = 'adfg Acc1',
                RecordTypeId = '012800000007h2p',
                AcctSeed__Accounting_Active__c = true,
                AcctSeed__Accounting_Type__c = 'Customer and Vendor',
                ShippingCity = 'San Francisco',
                AcctSeed__Credit_Card_Vendor__c = true
            )
        );
        accounts.add(
            new Account(
                Name = 'vblo Acc2',
                RecordTypeId = '012300000000Yip',
                Type = 'Business',
                Job_Type__c = 'Commercial',
                Branch__c = 'Berkeley',
                ShippingStreet = 'x',
                ShippingCity = 'x',
                ShippingState = 'x',
                ShippingPostalCode = 'x',
                AcctSeed__Accounting_Type__c = 'Customer'
            )
        );
        insert accounts;
        
        List<Opportunity> opp = new List<Opportunity>();
        opp.add(
            new Opportunity(
                Approximate_Install_Date__c = system.today(),
                Name = 'Test Opportunity',
                RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Standard Opportunity').getRecordTypeId(),
                Job_Type__c = 'PV Direct',                                 
                Accountid = accounts[1].Id,
                StageName = 'Project Awarded',
                Last_Date_Called__c = system.today(),
                Module_Delivery_Date__c = system.today(),
                Inverter_Delivery_Date__c = system.today(),
                Racking_Delivery_Date__c = system.today(),
                CloseDate = system.today(),
                Type = 'Turnkey System',
                Proposal_Submitted_Date__c = system.today(),
                Proposed_System_Size__c = 10000,
                Expected_Rebate__c = 0,
                Utility_Rate__c = 'N/A',
                Prevailing_Wage__c = 'No', 
                Original_Contract_System_Size__c = 1000,
                Amount = 1000,
                Financing__c = 'Cash'
            )
        );
        insert opp;
        
        List<AcctSeed__Project__c> project = new List<AcctSeed__Project__c>();
        project.add(
            new AcctSeed__Project__c(
                AcctSeed__Opportunity__c = opp[0].Id,
                Name = 'Test Project'
            )
        );
        insert project;
        
        List<AcctSeed__GL_Account__c> glAccounts = new List<AcctSeed__GL_Account__c>();
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '3600-Cost of revenue - installation - test',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense'
            )
        );
        glAccounts.add(
            new AcctSeed__GL_Account__c(
                Name = '3604-Unassigned COGS - test',
                AcctSeed__Active__c = true,
                AcctSeed__Type__c = 'Expense'
            )
        );
        insert glAccounts;
        
        List<Product2> products = new List<Product2>();
        products.add(
            new Product2(
                Name = 'Other Subcontractor - test',
                AcctSeed__Inventory_GL_Account__c = glAccounts[1].Id,
                AcctSeed__Expense_GL_Account__c = glAccounts[1].Id,
                AcctSeed__Revenue_GL_Account__c = glAccounts[1].Id,
                AcctSeed__Inventory_Type__c = 'Purchased',
                AcctSeed__Inventory_Product__c = true,
                AcctSeed__Unit_Cost__c = 1,
                Status__c = 'Approved For Sale'
            )
        );
        insert products;
        
            List<AcctSeedERP__Purchase_Order__c> purchaseOrders = new List<AcctSeedERP__Purchase_Order__c>();
            purchaseOrders.add(
                new AcctSeedERP__Purchase_Order__c(
                   AcctSeedERP__Vendor__c = accounts[0].Id,
                   AcctSeedERP__Status__c = 'Open',
                   AcctSeedERP__Type__c = 'Non-Material'
                )
            );
            insert purchaseOrders;
            
            List<Tax_Rate__c> taxRates = new List<Tax_Rate__c>();
            taxRates.add(
                new Tax_Rate__c(
                    Tax_Rate__c = 7
                )
            );  
            insert taxRates;
            
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
            insert purchaseOrderLines;
            
            apl_1 = new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Amount__c = 900.90,
                AcctSeed__Account_Payable__c = ap_1.Id,
                AcctSeed__Expense_GL_Account__c = expAccount.Id,
                AcctSeed__GL_Account_Variable_1__c = var1.Id,
                AcctSeed__GL_Account_Variable_2__c = var2.Id,
                AcctSeedERP__Purchase_Order_Line__c = purchaseOrderLines[0].Id
            );
            apLines.add(apl_1);
            apl_2 = new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Amount__c = 2002.00,
                AcctSeed__Account_Payable__c = ap_2.Id,
                AcctSeed__Expense_GL_Account__c = expAccount.Id,
                AcctSeed__GL_Account_Variable_1__c = var1.Id,
                AcctSeed__GL_Account_Variable_2__c = var2.Id
            );
            apLines.add(apl_2);
            apl_3 = new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Amount__c = 3003.33,
                AcctSeed__Account_Payable__c = ap_3.Id,
                AcctSeed__Expense_GL_Account__c = expAccount.Id,
                AcctSeed__GL_Account_Variable_1__c = var1.Id,
                AcctSeed__GL_Account_Variable_2__c = var2.Id
            ); 
            apLines.add(apl_3);
            apl_4 = new AcctSeed__Account_Payable_Line__c(
                AcctSeed__Amount__c = 639.99,
                AcctSeed__Account_Payable__c = ap_4.Id,
                AcctSeed__Expense_GL_Account__c = expAccount.Id,
                AcctSeed__GL_Account_Variable_1__c = var1.Id,
                AcctSeed__GL_Account_Variable_2__c = var2.Id
            );
            apLines.add(apl_4);
            insert aplines;
            insert sih_one = new AE_SmartInvoiceHeader__c(
                vendorname__c = 'Aeolean Inc',
                locator__c = '00001072',
                locale__c = 'en_AU',
                invoicenumber__c = 'YTL-60721',
                invoicedate__c = Date.newInstance(2013, 9, 14),
                invoicetotal__c = 2002.00,
                taxtotal__c = 200.20,
                additionalitem_freight__c = 678.25,
                additionalitem_drumcharge__c = 187.22,
                duedate__c = Date.newInstance(2013,10,31),
                terms__c = 'Due by October 31',
                AccountPayable__c = ap_1.Id
            );
            ap_1.AE_SmartInvoiceHeader__c = sih_one.Id;
            update ap_1;
            insert sih_two = new AE_SmartInvoiceHeader__c(
                vendorname__c = 'Aeolean Inc',
                locator__c = '00001073',
                locale__c = 'en_AU',
                invoicenumber__c = 'YTL-60722',
                invoicedate__c = Date.newInstance(2013, 9, 14),
                invoicetotal__c = 1801.80,
                taxtotal__c = 200.20,
                additionalitem_freight__c = 482.26,
                additionalitem_drumcharge__c = 87.22,
                duedate__c = Date.newInstance(2013,10,31),
                terms__c = 'Due by October 31',
                AccountPayable__c = ap_2.Id
            );
            ap_2.AE_SmartInvoiceHeader__c = sih_two.Id;
            update ap_2;
            insert sih_three = new AE_SmartInvoiceHeader__c(
                vendorname__c = 'Aeolean Inc',
                locator__c = '00001073',
                locale__c = 'en_AU',
                invoicenumber__c = 'YTL-60723',
                invoicedate__c = Date.newInstance(2013, 9, 14),
                invoicetotal__c = 5555.56,
                taxtotal__c = 200.20,
                additionalitem_freight__c = 893.12,
                additionalitem_drumcharge__c = 81.56,
                duedate__c = Date.newInstance(2013,10,31),
                terms__c = 'Due by October 31',
                AccountPayable__c = ap_3.Id
            );
            ap_3.AE_SmartInvoiceHeader__c = sih_three.Id;
            update ap_3;
            insert sih_four = new AE_SmartInvoiceHeader__c(
                vendorname__c = 'Aeolean Inc',
                locator__c = '00001073',
                locale__c = 'en_AU',
                invoicenumber__c = 'YTL-60724',
                invoicedate__c = Date.newInstance(2013, 9, 14),
                invoicetotal__c = 666.66,
                taxtotal__c = 2.22,
                additionalitem_freight__c = 123.45,
                additionalitem_drumcharge__c = 17.54,
                duedate__c = Date.newInstance(2013,10,31),
                terms__c = 'Due by October 31',
                AccountPayable__c = ap_4.Id
            );
            ap_4.AE_SmartInvoiceHeader__c = sih_four.Id;
            update ap_4; 
            ba_1 = [SELECT Id,AcctSeed__Bank__c
              FROM AcctSeed__GL_Account__c
              WHERE AcctSeed__Bank__c = True
              LIMIT 1];
            insert ac_1 = new Account(
                Name = 'Trial Account' 
                /*
                AcctSeed__Accounting_Type__c = 'Vendor',
                AcctSeed__Accounting_Active__c = True,
                Phone = '(203) 123 4567',
                Branch__c = 'Corporate',
                Type = 'Business',
                Description = 'Is required'
                */
                );
            System.debug('AS: WSUT ac_1 is `' + ac_1 + '\'');
            us_1 = [SELECT Id,Name
              FROM User
              WHERE Name like 'AP Smart'];
            insert ct_1 = new Contact(
              FirstName = 'Derek',
              LastName = 'Hill',
              Account = ac_1
              );
            insert ach_1 = new AS_ACH__c(
                BankAccountNumber__c = '1234',
                BankRoutingNumber__c = '5678',
                Bank_Account_Type__c = 'Checking',
                Account__c = ac_1.id,
                Approval_Status__c = 'Approved'
                );
            System.debug('AS: WSUT ach_1 is `' + ach_1 + '\'');
            insert ach_2 = new AS_ACH__c(
                BankAccountNumber__c = '22222222',
                BankRoutingNumber__c = '33333333',
                Bank_Account_Type__c = 'Checking',
                User__c = us_1.id,
                Approval_Status__c = 'Approved'
                );
            System.debug('AS: WSUT ach_2 is `' + ach_2 + '\'');
            insert ach_3 = new AS_ACH__c(
                BankAccountNumber__c = '3333',
                BankRoutingNumber__c = '34567',
                Bank_Account_Type__c = 'Checking',
                Contact__c = ct_1.id,
                Approval_Status__c = 'Approved'
                );
            System.debug('AS: WSUT ach_3 is `' + ach_3 + '\'');
            insert cdb_1 = new AcctSeed__Cash_Disbursement_Batch__c(
                Name = 'CD Batch 1'
                );
            insert cd_1 = new AcctSeed__Cash_Disbursement__c(
                AcctSeed__Amount__c = 12.34,
                AcctSeed__Bank_Account__c = ba_1.Id,
                AcctSeed__Vendor__c =  ac_1.Id,
                AcctSeed__Cash_Disbursement_Batch__c = cdb_1.Id,
                ACH_OK_RW__c = True,
                AcctSeed__Type__c = 'Electronic'
                );
            insert cd_2 = new AcctSeed__Cash_Disbursement__c(
                AcctSeed__Amount__c = 99.34,
                AcctSeed__Bank_Account__c = ba_1.Id,
                AcctSeed__Employee__c =  us_1.Id,
                AcctSeed__Cash_Disbursement_Batch__c = cdb_1.Id,
                ACH_OK_RW__c = True,
                AcctSeed__Type__c = 'Electronic'
                );
            insert cd_3 = new AcctSeed__Cash_Disbursement__c(
                AcctSeed__Amount__c = 100.43,
                AcctSeed__Bank_Account__c = ba_1.Id,
                AcctSeed__Contact__c =  ct_1.Id,
                AcctSeed__Cash_Disbursement_Batch__c = cdb_1.Id,
                ACH_OK_RW__c = True,
                AcctSeed__Type__c = 'Electronic'
                );
            insert cd_4 = new AcctSeed__Cash_Disbursement__c(
                AcctSeed__Amount__c = 400.43,
                AcctSeed__Bank_Account__c = ba_1.Id,
                AcctSeed__Vendor__c = account_five.Id, //ac_1.Id,
                AcctSeed__Cash_Disbursement_Batch__c = cdb_1.Id,
                ACH_OK_RW__c = True,
                AcctSeed__Type__c = 'Electronic',
                AcctSeed__Status__c = 'Posted'
                );
            System.debug('AS: WSUT cd_4 is `' + cd_4 + '\'');
            /*
             ap_5 = [SELECT Id,Name,AcctSeed__Status__c,AcctSeed__Vendor__c
              FROM AcctSeed__Account_Payable__c
              WHERE Name =  'AP-52805'];
            System.debug('AS: WSUT ap_5 is `' + ap_5 + '\'');
            insert apd_1 = new AcctSeed__AP_Disbursement__c(
              AcctSeed__Account_Payable__c = ap_5.Id,
              AcctSeed__Paid_Amount__c = 444.0,
              AcctSeed__Cash_Disbursement__c = cd_4.Id
              );
            System.debug('AS: WSUT apd_1 is `' + apd_1 + '\'');
            */
            
            /*
             ap_5 = [SELECT Id,Name,AcctSeed__Status__c,AcctSeed__Vendor__c
              FROM AcctSeed__Account_Payable__c
              WHERE Name =  'AP-145850'];
            insert apd_1 = new AcctSeed__AP_Disbursement__c(
              AcctSeed__Account_Payable__c = ap_5.Id, //ap_4.Id,
              AcctSeed__Paid_Amount__c = 444.0,
              AcctSeed__Cash_Disbursement__c = cd_4.Id
              );
            System.debug('AS: WSUT apd_1 is `' + apd_1 + '\'');
            */
        }
    }
    
    static testMethod void myUnitTest() {
        Fixture f = new Fixture();
        
        
        Test.startTest();
        AccountPayableLineHandler.populateFields(new List<AcctSeed__Account_Payable_Line__c>{f.apl_1});
        Test.stopTest();
    }
}