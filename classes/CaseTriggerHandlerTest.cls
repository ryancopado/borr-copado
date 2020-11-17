@isTest(seealldata=true)
public  class CaseTriggerHandlerTest {

  
    /*  static testMethod void casedata() {
      List<sObject> setupData = new List<sObject>();

        Case oCase = new Case(status = 'Open');
        insert oCase;
        
        Account a = new Account();
      a.Name = 'this is my test account';
      a.AcctSeed__Accounting_Type__c = 'Customer and Vendor';
     
      insert a;
        
        AcctSeed__Project__c p = new AcctSeed__Project__c();
      p.Account__c = a.id;
      insert p;
        
        AcctSeed__Project_Task__c pt = new AcctSeed__Project_Task__c();
     
      pt.AcctSeed__Project__c = p.id;
     // pt.Cost_Code__c = cc.id;
      pt.Not_In_Rollup__c = false;
      insert pt;


        SBQQ__Quote__c quote = new SBQQ__Quote__c(
                Labor_Billing__c    = 'Billable',
                P_M_Billing__c      = 'Billable',
                SBQQ__Status__c     = 'Accepted',
                SBQQ__Primary__c    = true,
                case__c             =  oCase.Id,
                Payment_Due_Days__c = 5


        );
       insert quote;

 //AcctSeed__Type__c=Balance Sheet, AcctSeed__Used_in_Expense_Reports__c=false, BalSheet_Type__c=16Other Accrued Expenses, IncStmt_Type__c=20BalanceSheet, Id=a1m80000000p2k3AAA})


   
        

        SBQQ__QuoteLine__c ql = new SBQQ__QuoteLine__c(SBQQ__Quote__c =  quote.Id,Tax_Category__c='');
        //insert ql;
        //
       SBQQ__QuoteLine__c ql1 = new SBQQ__QuoteLine__c();
      ql1.SBQQ__Quote__c = quote.id;
      ql1.Vendor__c = a.id;
      ql1.SBQQ__NetPrice__c = 5.00;
      ql1.SBQQ__Quantity__c = 1;
      ql1.SBQQ__Description__c = 'test';
      ql1.SBQQ__Number__c = 1;
      ql1.Tax_Category__c = 'Labor - Internal';
      ql1.SBQQ__PricingMethod__c = 'List';
      ql1.Vendor__c = a.id;
      ql1.Project__c = p.id;
      //ql1.SBQQ__ProductFamily__c = 'Labor and Service';
      ql1.SBQQ__Product__c = [SELECT Id FROM Product2 WHERE Family = 'Labor and Service' LIMIT 1].id;
      ql1.Project_Line_Item__c = pt.id;
      insert ql1;

        //AcctSeed__Billing_Format__c billingFormat = new AcctSeed__Billing_Format__c(Name ='O&M',  AcctSeed__Default_Email_Template__c = 'O_M_Svc_Billing_Email_Template', AcctSeed__Visualforce_PDF_Page__c = 'Billing_InvoicePDF');
        //setupData.add(billingFormat);
        //insert setupData;
    }*/


   
    static testmethod void casedata(){
           test.startTest();
         
         SBQQ__Quote__c quoteline  = [select id,Case__c,case__r.status,SBQQ__Status__c from SBQQ__Quote__c where BillingType__c='Internal Labor Only'  and      SBQQ__Status__c ='Accepted'  and case__r.status!='Closed'AND SBQQ__Primary__c =TRUE and case__r.status!=null limit 1    ];
        Case oCase = [SELECT Id, Status FROM Case where id = :quoteline.Case__c];
        oCase.status = 'Closed';
        //oCase.IsSelfServiceClosed = true;
        update oCase;
         test.stopTest();
        
        system.debug('caseId' +oCase);
      



        List<SBQQ__Quote__c> primaryQuote = [SELECT Id, SBQQ__MasterContract__c, SBQQ__Account__c, Site_Address__c, Site_City__c, Site_State__c, Site_Country__c, Site_Zip__c,Labor_Billing__c, P_M_Billing__c, Case__c,con_req_group__c, SBQQ__Opportunity2__c,Project__c,OwnerId,
                Customer_Reference_Number__c, Payment_Due_Days__c,SBQQ__ShippingStreet__c, SBQQ__ShippingCity__c, SBQQ__ShippingState__c,SBQQ__ShippingCountry__c,SBQQ__ShippingPostalCode__c
        FROM SBQQ__Quote__c WHERE SBQQ__Primary__c = TRUE AND SBQQ__Status__c = 'Accepted' AND Case__c =:oCase.Id AND (Labor_Billing__c != 'Not Billable' OR P_M_Billing__c != 'Not Billable')];
        system.debug('Primary' +primaryQuote);
        
        system.debug('Size' +primaryQuote);
        
  //     System.AssertEquals(1, primaryQuote.size());
      
    }
    
/*    static testmethod void podata(){ 
    
    AcctSeedERP__Purchase_Order__c podata=[select id,Case__c,AcctSeedERP__Status__c,Case__r.status from AcctSeedERP__Purchase_Order__c where AcctSeedERP__Status__c='open' and Case__r.status = 'closed' limit 1];
          test.startTest();
        podata.AcctSeedERP__Status__c ='Closed';
      // update podata;
        test.stopTest();
    } */

}