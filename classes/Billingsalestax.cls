public with sharing class Billingsalestax {

    AcctSeed__Billing__c Billingrecid = new AcctSeed__Billing__c();
    List<AcctSeed__Billing_Line__c> lstBillinglines = new List<AcctSeed__Billing_Line__c>();
    List<AcctSeed__Billing_Line__c> lstDelBillinglines = new List<AcctSeed__Billing_Line__c>();
    List<AcctSeed__Billing_Line__c> lstsumBillinglines = new List<AcctSeed__Billing_Line__c>();
    List<Account_Tax__c> lstAccountTaxs = new List<Account_Tax__c>();
    AcctSeed__Billing__c Billingrec = new AcctSeed__Billing__c();
    double dobTotal = 0.00;
    public string newRecordId;
    
    //Standard Controller
    public Billingsalestax (ApexPages.StandardController controller) {
        
        // Get Billing Record details
        Billingrecid = (AcctSeed__Billing__c)controller.getRecord();   
        Billingrec = [select id, Name, AcctSeed__Customer__c from AcctSeed__Billing__c where Id=:Billingrecid.Id]; 
        
        // Load Billing lines             
        lstBillinglines = [select id, Name, AcctSeed__Product__c,AcctSeed__Total__c, AcctSeed__Product__r.AcctSeed__Accounting_Type__c,
            AcctSeed__Billing__r.AcctSeed__Customer__c from AcctSeed__Billing_Line__c where 
                AcctSeed__Product__c != null AND AcctSeed__Billing__c =: Billingrec.Id];
                
         //Load Account Taxs   
        lstAccountTaxs = [select Id, Name, Account__c, Tax_Rate__c, Tax_Type__c,
            Tax_Rate__r.AcctSeed__Tax_Rate__c, Tax_Rate__r.AcctSeed__Revenue_GL_Account__c from 
                Account_Tax__c where Account__c =: Billingrec.AcctSeed__Customer__c];
                
        system.debug('Look Here' +lstBillinglines);

        if(lstBillinglines.size()>0) {
            for(AcctSeed__Billing_Line__c irow: lstBillinglines) {                
                if(irow.AcctSeed__Product__r.AcctSeed__Accounting_Type__c == 'Tax Rate') {
                    lstDelBillinglines.add(irow);
                }
                if(irow.AcctSeed__Product__r.AcctSeed__Accounting_Type__c == 'Taxable Product') {
                    dobTotal += irow.AcctSeed__Total__c;
                }  
            }
        } 
        
        else {        
                ApexPages.Message ErrMsg1 = 
                new ApexPages.Message(ApexPages.Severity.ERROR,'NO Billing Lines Found');
                ApexPages.addmessage(ErrMsg1);
        }  
                system.debug('***lstDelBillinglines'+lstDelBillinglines);                  
    } 
    
    public PageReference save() {
    try {
            // Delete all Product/Accounting Type equals 'Tax Rate'
            if(lstDelBillinglines.size()>0) {
                delete lstDelBillinglines;
            }
            
            if(lstAccountTaxs.size()>0) {
                for(Account_Tax__c irow:lstAccountTaxs) {
                    AcctSeed__Billing_Line__c Billinglines = new AcctSeed__Billing_Line__c();
                    Billinglines.AcctSeed__Hours_Units__c = 1;
                    Billinglines.AcctSeed__Billing__c = Billingrecid.Id;
                    Billinglines.AcctSeed__Rate__c = ((irow.Tax_Rate__r.AcctSeed__Tax_Rate__c / 100) * dobTotal);
                    Billinglines.AcctSeed__Product__c = irow.Tax_Rate__c;
                    Billinglines.AcctSeed__Revenue_GL_Account__c = irow.Tax_Rate__r.AcctSeed__Revenue_GL_Account__c;
                    Billinglines.AcctSeed__List_Price__c = ((irow.Tax_Rate__r.AcctSeed__Tax_Rate__c / 100) * dobTotal);
                    lstsumBillinglines.add(Billinglines);
                }
                if(lstsumBillinglines.size()>0) {
                    // create Billing lines                
                    insert lstsumBillinglines;
                    newRecordId = Billingrecid.id; // use in test method
                    PageReference page = new PageReference('/'+Billingrecid.Id);      
                    return page;                                
                }                
            }
        } catch (System.DMLException e) {
              ApexPages.addMessages(e); 
                ApexPages.Message ErrMsg1 = 
                new ApexPages.Message(ApexPages.Severity.ERROR,e.getmessage());
                ApexPages.addmessage(ErrMsg1);                         
              return null;  
          }
        PageReference page = new PageReference('/'+Billingrecid.Id);      
        return page; 
    }
    
    // test mehod
    
    public static testmethod void testBillingsalestax () {
    
        // create customer type
        Account account = new Account();
        account.Name = 'account';
        account.ShippingCity = 'San Francisco';
        insert account;
        
        AcctSeed__GL_Account__c glaccount = new AcctSeed__GL_Account__c();
        glaccount.Name = 'glaccount';
        glaccount.AcctSeed__Type__c = 'Balance Sheet';
        glaccount.AcctSeed__Active__c = true;
        glaccount.AcctSeed__Sub_Type_1__c = 'Assets';
        insert glaccount;
        
        Product2 product = new Product2();
        product.name = 'product';
        product.ProductCode = 'product';
        product.AcctSeed__Tax_Rate__c = 50.00;
        product.AcctSeed__Accounting_Type__c = 'Taxable Product';
        product.AcctSeed__Revenue_GL_Account__c = glaccount.id;
        product.IsActive= true;
        insert product;

        Product2 product1 = new Product2();
        product1.name = 'product';
        product1.ProductCode = 'product';
        product1.AcctSeed__Tax_Rate__c = 50.00;
        product1.AcctSeed__Accounting_Type__c =  'Tax Rate';
        product1.AcctSeed__Revenue_GL_Account__c = glaccount.id;
        product1.IsActive= true;
        insert product1;
        
        Product2 product3 = new Product2();
        product3.name = 'product';
        product3.ProductCode = 'product';
        product3.AcctSeed__Tax_Rate__c = 50.00;
        product3.AcctSeed__Accounting_Type__c = 'Taxable Product';
        product3.AcctSeed__Revenue_GL_Account__c = glaccount.id;
        product3.IsActive= true;
        insert product3;
        
        Account_Tax__c acctax = new Account_Tax__c();
        acctax.Account__c = account.id;
        acctax.Tax_Rate__c = product.id;   
        acctax.Tax_Type__c = 'Sales';
        insert acctax;
        
        Account_Tax__c acctax1 = new Account_Tax__c();
        acctax1.Account__c = account.id;
        acctax1.Tax_Rate__c = product1.id;   
        acctax1.Tax_Type__c = 'Sales';
        insert acctax1;
        
        Account_Tax__c acctax2 = new Account_Tax__c();
        acctax2.Account__c = account.id;
        acctax2.Tax_Rate__c = product1.id;   
        acctax2.Tax_Type__c = 'Sales';
        insert acctax2;
        
        Account_Tax__c acctax3 = new Account_Tax__c();
        acctax3.Account__c = account.id;
        acctax3.Tax_Rate__c = product3.id;   
        acctax3.Tax_Type__c = 'Sales';
        insert acctax3;
        
         // billing record
        // billing format
        AcctSeed__Billing_Format__c billingformat = new AcctSeed__Billing_Format__c();
        billingformat.Name = 'billingformat';
        billingformat.AcctSeed__Default_Email_Template__c = 'Billing_Email_Template';
        billingformat.AcctSeed__Visualforce_PDF_Page__c = 'BillingServicePDF';
        insert billingformat;
         
        AcctSeed__Billing__c billing = new AcctSeed__Billing__c();
        billing.AcctSeed__Customer__c = account.id;
        billing.AcctSeed__Date__c = system.today();
        billing.AcctSeed__Billing_Format__c = billingformat.id;
        insert billing;
        
        AcctSeed__Billing_Line__c billingline = new AcctSeed__Billing_Line__c();
        billingline.AcctSeed__Date__c = system.today();
        billingline.AcctSeed__Billing__c = billing.id;
        billingline.AcctSeed__Hours_Units__c = 2.00;
        billingline.AcctSeed__Rate__c = 50.00;
        billingline.AcctSeed__Revenue_GL_Account__c = glaccount.id;
        billingline.AcctSeed__Product__c = product3.id;
        insert billingline;
      
        AcctSeed__Billing_Line__c billingline1 = new AcctSeed__Billing_Line__c();
        billingline1.AcctSeed__Date__c = system.today();
        billingline1.AcctSeed__Billing__c = billing.id;
        billingline1.AcctSeed__Hours_Units__c = 4.00;
        billingline1.AcctSeed__Rate__c = 100.00;
        billingline1.AcctSeed__Revenue_GL_Account__c = glaccount.id;
        billingline1.AcctSeed__Product__c = product1.id;
      //  insert billingline1;
      
        AcctSeed__Billing_Line__c billingline3 = new AcctSeed__Billing_Line__c();
        billingline3.AcctSeed__Date__c = system.today();
        billingline3.AcctSeed__Billing__c = billing.id;
        billingline3.AcctSeed__Hours_Units__c = 5.00;
        billingline3.AcctSeed__Rate__c = 200.00;
        billingline3.AcctSeed__Revenue_GL_Account__c = glaccount.id;
        billingline3.AcctSeed__Product__c = product3.id;
        insert billingline3; 
      
                
        ApexPages.StandardController con = new ApexPages.StandardController(billing);
        Billingsalestax ext = new Billingsalestax(con);
        PageReference ref = ext.save();
        PageReference redir = new PageReference('/'+ext.newRecordId+'/e?retURL=%2F'+ext.newRecordId);
    }
    

}