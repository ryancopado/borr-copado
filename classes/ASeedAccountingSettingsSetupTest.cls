@IsTest
public class ASeedAccountingSettingsSetupTest {

    @IsTest
    public static void testDataSetup() {
            List<AcctSeed__GL_Account__c> glAccounts = new List<AcctSeed__GL_Account__c>();
            // 0
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '1000-Cash',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Bank__c = true,
                    AcctSeed__Sub_Type_1__c = 'Assets',
                    AcctSeed__Sub_Type_2__c = 'Cash'
                )
            );

            // 1
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '1205-Unapplied A/R',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Assets',
                    AcctSeed__Sub_Type_2__c = 'Cash'
                )
            );

            // 2
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '1200-Accounts Receivable',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Assets',
                    AcctSeed__Sub_Type_2__c = 'Current Assets'
                )
            );

            // 3
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '1600-Work In Process',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Assets',
                    AcctSeed__Sub_Type_2__c = 'Current Assets'
                )
            );

            // 4
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '2000-Accounts Payable',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Liabilities',
                    AcctSeed__Sub_Type_2__c = 'Current Liabilities'
                )
            );

            // 5
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '2010-Vouchers Payable',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Liabilities',
                    AcctSeed__Sub_Type_2__c = 'Current Liabilities'
                )
            );

            // 6
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '2020-Accrued Expenses',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Liabilities',
                    AcctSeed__Sub_Type_2__c = 'Current Liabilities'
                )
            );


            // 7
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '3000-Owners Equity',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Owners Equity',
                    AcctSeed__Sub_Type_2__c = 'Equity'
                )
            );

            // 8
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '3050-Retained Earnings',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Owners Equity',
                    AcctSeed__Sub_Type_2__c = 'Equity'
                )
            );

            // 9
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '3060-Current Year Earnings',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Owners Equity',
                    AcctSeed__Sub_Type_2__c = 'Equity'
                )
            );

            // 10
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '4000-Product Revenue',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Revenue',
                    AcctSeed__Sub_Type_1__c = 'Product Revenue',
                    AcctSeed__Sub_Type_2__c = 'Product Family 1'
                )
            );

            // 11
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '4010-Services Revenue',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Revenue',
                    AcctSeed__Sub_Type_1__c = 'Service Revenue',
                    AcctSeed__Sub_Type_2__c = 'Service Family 1'
                )
            );

            // 12
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '5000-Cost of Goods Sold',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Sub_Type_1__c = 'Cost of Goods Sold',
                    AcctSeed__Sub_Type_2__c = 'Materials'
                )
            );

            // 13
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '5010-Inventory Cost Variance',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Sub_Type_1__c = 'Cost of Goods Sold',
                    AcctSeed__Sub_Type_2__c = 'Materials'
                )
            );

            // 14
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '5040-Vendor Payment Discounts',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Sub_Type_1__c = 'Cost of Goods Sold',
                    AcctSeed__Sub_Type_2__c = 'Materials'
                )
            );

            // 15
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '5050-Labor',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Sub_Type_1__c = 'Cost of Goods Sold',
                    AcctSeed__Sub_Type_2__c = 'Salaries & Wages'
                )
            );

            // 16
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '6000-Marketing Expense',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Sub_Type_1__c = 'Sales & Marketing',
                    AcctSeed__Sub_Type_2__c = 'Marketing Events'
                )
            );

            // 17
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '7000-Facilities Expense',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Sub_Type_1__c = 'Facilities',
                    AcctSeed__Sub_Type_2__c = 'Rent'
                )
            );

            // 18
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '7050-Telecommunications',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Sub_Type_1__c = 'Facilities',
                    AcctSeed__Sub_Type_2__c = 'Utilities'
                )
            );

            // 19
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = 'zLabor Clearing',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense'
                )
            );

            // 20
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = 'zProject Labor',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense'
                )
            );

            // 21
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '4900-Customer Payment Discounts',
                    AcctSeed__Active__c = true,
                    AcctSeed__Bank__c = false,
                    AcctSeed__Type__c = 'Revenue',
                    AcctSeed__Sub_Type_1__c = 'Product Revenue',
                    AcctSeed__Sub_Type_2__c = 'Product Family 1'
                )
            );

            // 22
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '1500-Inventory',
                    AcctSeed__Active__c = true,
                    AcctSeed__Bank__c = false,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Assets',
                    AcctSeed__Sub_Type_2__c = 'Current Assets'
                )
            );

            // 23
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '1400-Prepaid Expenses',
                    AcctSeed__Active__c = true,
                    AcctSeed__Bank__c = false,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Assets',
                    AcctSeed__Sub_Type_2__c = 'Current Assets'
                )
            );
            // 24
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '1700-Accumulated Depreciation',
                    AcctSeed__Active__c = true,
                    AcctSeed__Bank__c = false,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Assets',
                    AcctSeed__Sub_Type_2__c = 'Fixed Assets'
                )
            );
            // 25
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '2500-Deferred Revenue',
                    AcctSeed__Active__c = true,
                    AcctSeed__Bank__c = false,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Liabilities',
                    AcctSeed__Sub_Type_2__c = 'Current Liabilities'
                )
            );
            // 26
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '3900-Opening Balances',
                    AcctSeed__Active__c = true,
                    AcctSeed__Bank__c = false,
                    AcctSeed__Type__c = 'Balance Sheet',
                    AcctSeed__Sub_Type_1__c = 'Owners Equity',
                    AcctSeed__Sub_Type_2__c = 'Equity'
                )
            );
            // 27
            glAccounts.add(
                new AcctSeed__GL_Account__c(
                    Name = '6500-Depreciation Expense',
                    AcctSeed__Active__c = true,
                    AcctSeed__Bank__c = false,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Sub_Type_1__c = 'General & Administrative',
                    AcctSeed__Sub_Type_2__c = 'Software'
                )
            );
            insert glAccounts;

            List<AcctSeed__GL_Account__c> glAccountsExpense = new List<AcctSeed__GL_Account__c>();

            // 0
            glAccountsExpense.add(
                new AcctSeed__GL_Account__c(
                    Name = '6050-Travel Expenses',
                    AcctSeed__Active__c = true,
                    AcctSeed__Used_In_Expense_Reports__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Expense_Report_Name__c = 'Travel Expenses',
                    AcctSeed__Billing_Description__c = 'Travel Expenses',
                    AcctSeed__TM_Revenue_Conversion__c = glAccounts[11].Id,
                    AcctSeed__Sub_Type_1__c = 'Sales & Marketing',
                    AcctSeed__Sub_Type_2__c = 'Sales Travel'
                )
            );

            // 1
            glAccountsExpense.add(
                new AcctSeed__GL_Account__c(
                    Name = '6060-Meals and Entertainment',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Used_In_Expense_Reports__c = true,
                    AcctSeed__Expense_Report_Name__c = 'Meals and Entertainment',
                    AcctSeed__Billing_Description__c = 'Meals and Entertainment',
                    AcctSeed__TM_Revenue_Conversion__c = glAccounts[11].Id,
                    AcctSeed__Sub_Type_1__c = 'Sales & Marketing',
                    AcctSeed__Sub_Type_2__c = 'Sales Travel'
                )
            );

            // 2
            glAccountsExpense.add(
                new AcctSeed__GL_Account__c(
                    Name = '6070-Mileage',
                    AcctSeed__Active__c = true,
                    AcctSeed__Type__c = 'Expense',
                    AcctSeed__Used_In_Expense_Reports__c = true,
                    AcctSeed__Expense_Report_Name__c = 'Mileage',
                    AcctSeed__Billing_Description__c = 'Mileage',
                    AcctSeed__Mileage_Account__c = true,
                    AcctSeed__Mileage_Rate__c = .52,
                    AcctSeed__TM_Revenue_Conversion__c = glAccounts[11].Id,
                    AcctSeed__Sub_Type_1__c = 'Sales & Marketing',
                    AcctSeed__Sub_Type_2__c = 'Sales Travel'
                )
            );

            insert glAccountsExpense;
            glAccounts.addAll(glAccountsExpense);


            List<AcctSeed__Billing_Format__c> billingFormats = new List<AcctSeed__Billing_Format__c>();
            billingFormats.add(
                new AcctSeed__Billing_Format__c(
                    Name = 'Default Billing Product',
                    AcctSeed__Visualforce_PDF_Page__c = 'BillingProductPDF',
                    AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                    AcctSeed__Type__c = 'Billing',
                    AcctSeed__Sort_Field__c = 'Name'
                )
            );

            billingFormats.add(
                new AcctSeed__Billing_Format__c(
                    Name = 'Default Billing Service',
                    AcctSeed__Visualforce_PDF_Page__c = 'BillingServicePDF',
                    AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                    AcctSeed__Type__c = 'Billing',
                    AcctSeed__Sort_Field__c = 'Name'
                )
            );

            billingFormats.add(
                new AcctSeed__Billing_Format__c (
                    Name = 'Billing Outstanding Statment',
                    AcctSeed__Visualforce_PDF_Page__c = 'BillingOutstandingStatementPDF',
                    AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                    AcctSeed__ReplyTo_Email__c = 'test3463464364646@gmail.com',
                    AcctSeed__Type__c = 'Outstanding Statement'
                )
            );

            billingFormats.add(
                new AcctSeed__Billing_Format__c (
                    Name = 'Billing Activity Statment',
                    AcctSeed__Visualforce_PDF_Page__c = 'BillingActivityStatementPDF',
                    AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                    AcctSeed__ReplyTo_Email__c = 'test3463464364646@gmail.com',
                    AcctSeed__Type__c = 'Activity Statement'
                )
            );

            billingFormats.add(
                new AcctSeed__Billing_Format__c(
                    Name = 'Default Purchase Order',
                    AcctSeed__Visualforce_PDF_Page__c = 'BillingServicePDF',
                    AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                    AcctSeed__Type__c = 'Purchase Order',
                    AcctSeed__Sort_Field__c = 'Name'
                )
            );

            billingFormats.add(
                new AcctSeed__Billing_Format__c(
                    Name = 'Default Packing Slip',
                    AcctSeed__Visualforce_PDF_Page__c = 'BillingServicePDF',
                    AcctSeed__Default_Email_Template__c = [Select Id, DeveloperName From EmailTemplate limit 1].DeveloperName,
                    AcctSeed__Type__c = 'Packing Slip',
                    AcctSeed__Sort_Field__c = 'Name'
                )
            );

            insert billingFormats;

            List<AcctSeed__Ledger__c> ledgers = new List<AcctSeed__Ledger__c>();

            ledgers.add(
                new AcctSeed__Ledger__c(
                    Name = 'Actual',
                    AcctSeed__Type__c = 'Transactional',
                    AcctSeed__Default_Bank_Account__c = glAccounts[0].Id,
                    AcctSeed__Default_Billing_Format__c = billingFormats[0].Id,
                    AcctSeed__Billing_Outstanding_Statement_Format__c = billingFormats[2].Id,
                    AcctSeed__Billing_Activity_Statement_Format__c = billingFormats[3].Id,
                    AcctSeed__Default_Purchase_Order_Format__c = billingFormats[4].Id,
                    AcctSeed__Default_Packing_Slip_Format__c = billingFormats[5].Id
                )
            );

            ledgers.add(
                new AcctSeed__Ledger__c(
                    Name = 'Budget',
                    AcctSeed__Type__c = 'Budget'
                )
            );
            
            insert ledgers;


            List<AcctSeed__Accounting_Settings__c> settings = new List<AcctSeed__Accounting_Settings__c>();

            settings.add(
                new AcctSeed__Accounting_Settings__c(
                    AcctSeed__AR_Control_GL_Account__c = glAccounts[2].Id,
                    AcctSeed__AP_Control_GL_Account__c = glAccounts[4].Id,
                    AcctSeed__Labor_GL_Account__c = glAccounts[19].Id,
                    AcctSeed__Payment_Discount_GL_Account__c = glAccounts[14].Id,
                    AcctSeed__Unapplied_Cash_GL_Account__c = glAccounts[1].Id,
                    AcctSeed__Retained_Earnings_GL_Account__c = glAccounts[8].Id,
                    AcctSeed__Default_Ledger__c = ledgers[0].Id,
                    AcctSeed__Legacy_Default_Ledger__c = ledgers[0].Id,
                    AcctSeed__Revenue_GL_Account__c = glAccounts[10].Id,
                    AcctSeed__Default_Project_Task_Labor_GL_Account__c = glAccounts[20].Id,
                    AcctSeed__Current_Year_Earnings_GL_Account__c = glAccounts[9].Id,
                    AcctSeed__Enable_Product_Costing__c = true,
                    AcctSeed__Work_in_Process_GL_Account__c = glAccounts[3].Id,
                    AcctSeed__Vouchers_Payable_GL_Account__c = glAccounts[5].Id,
                    AcctSeed__Inventory_Variance_GL_Account__c =  glAccounts[13].Id,
                    AcctSeed__Customer_Payment_Adjustment_GL_Account__c = glAccounts[21].Id,
                    AcctSeed__Display_Billable_Flag_in_Time_Card_Entry__c = true,
                    AcctSeed__Enable_Billing_Period_Sensitive_Aging__c = true,
                    AcctSeed__Enable_AP_Period_Sensitive_Aging__c = true,
                    AcctSeed__Prepaid_Expense_GL_Account__c = glAccounts[23].Id
                )
            );
            insert settings;
    }
}