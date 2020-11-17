public class POTriggerHandler{
        public static void BillingLine(Set<Id> acceptedCaseIds) {
        
        List<AcctSeed__Billing_Line__c>casebilling=[select id,AcctSeed__Billing__r.AcctSeed__Status__c from AcctSeed__Billing_Line__c where Case__c=:acceptedCaseIds];
       /*List<AcctSeed__Billing__c>billing=[select id from AcctSeed__Billing__c where Case__c=:acceptedCaseIds];
       if(billing.size()>0)
       {
       AcctSeed__Billing__c billingrecords=new AcctSeed__Billing__c();
       
        billingrecords=billing.get(0);
        billingrecords.AcctSeed__Status__c='Ready to Process';
        update billingrecords;
        }*/
        if(casebilling.size()>0)
        {
         AcctSeed__Billing_Line__c billingline=new AcctSeed__Billing_Line__c ();
         billingline=casebilling.get(0);
         
         billingline.AcctSeed__Revenue_GL_Account__c='a1m80000000p2ir';
         update billingline;
        }
        
     List<SBQQ__Quote__c> primaryQuote = [SELECT Id, SBQQ__MasterContract__c,BillingType__c,SBQQ__Type__c, SBQQ__Account__c, Site_Address__c, Site_City__c, Site_State__c, Site_Country__c, Site_Zip__c,Labor_Billing__c, P_M_Billing__c, Case__c,con_req_group__c, SBQQ__Opportunity2__c,Project__c,OwnerId,
                                Customer_Reference_Number__c, Payment_Due_Days__c,SBQQ__ShippingStreet__c, SBQQ__ShippingCity__c, SBQQ__ShippingState__c,SBQQ__ShippingCountry__c,SBQQ__ShippingPostalCode__c,
                                (SELECT Id, SBQQ__Quantity__c,SBQQ__NetPrice__c,SBQQ__Discount__c,SBQQ__AdditionalDiscountAmount__c, SBQQ__ProductFamily__c,
                                 SBQQ__ListPrice__c,Tax_Category__c,Item_Notes__c, SBQQ__Taxable__c, SBQQ__Product__c,PO_Line_Status__c, Project_Line_Item__c,Taxable_form__c   FROM SBQQ__LineItems__r )
                                 
                                 FROM SBQQ__Quote__c WHERE SBQQ__Primary__c = TRUE AND SBQQ__Status__c = 'Accepted' AND Case__c IN :acceptedCaseIds AND (Labor_Billing__c != 'Not Billable' OR P_M_Billing__c != 'Not Billable')];
        
         List<AcctSeed__Billing_Line__c > billingLinesToInsert = new List<AcctSeed__Billing_Line__c >();

         Map<Id,ID> idmap= new Map<Id,ID>();
         Set<Id> Ids=new Set<Id>();
         for(SBQQ__Quote__c q : primaryQuote){
             Ids.add(q.id);
         }
         List<AcctSeed__Billing__c> bList= [select id,Quote__c from AcctSeed__Billing__c where Quote__c IN:ids];
         for(AcctSeed__Billing__c b : bList){
              idmap.put(b.Quote__c,b.id);  
              b.AcctSeed__Status__c='Ready to Review'; 
         }
         update bList;
         
        /* System.debug('########primaryQuote'+ primaryQuote.size());
         for(SBQQ__Quote__c q : primaryQuote){
         for (SBQQ__QuoteLine__c qL : q.SBQQ__LineItems__r) {
                    System.debug('########SBQQ__LineItems__r'+ q.SBQQ__LineItems__r.size());
                    //billingLinesToInsert.addAll(createBillingLines(1, qL));
                 
            }
            for (AcctSeed__Billing_Line__c bl : billingLinesToInsert) {
             
             if(q.BillingType__c=='Mows/Wash' ){
                bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2ir';
                
            }
           
             else if(q.BillingType__c=='Mows/Wash- Internal'){
             system.debug('IF CONDITION');
             system.debug('Billing Lines check before assign -->' +bl.AcctSeed__Revenue_GL_Account__c);
               bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2iq';
               system.debug('Billing Lines check -->' +bl.AcctSeed__Revenue_GL_Account__c);
            }
                bl.Case__c = q.Case__c;
                bl.AcctSeed__Opportunity_Product_Id__c = q.SBQQ__Opportunity2__c;
                bl.AcctSeed__Project__c = q.Project__c;
                bl.AcctSeed__Employee__c = q.OwnerId;
                bl.AcctSeed__Billing__c = idmap.get(q.id);
            }
            //insert billingLinesToInsert;
        }
                    insert billingLinesToInsert;

        }
         public static List<AcctSeed__Billing_Line__c> createBillingLines(Integer count,SBQQ__QuoteLine__c QL) {
        List<AcctSeed__Billing_Line__c> linesToReturn = new List<AcctSeed__Billing_Line__c>();
        //if (count == 2) {
            System.debug('########createBillingLines in q' );
            linesToReturn.add(createLineType('Billing', QL));
            //linesToReturn.add(createLineType('Credit', QL));
            //linesToReturn.add(createLineType('Debit', QL));
        //} 
        System.debug('########createBillingLines in linereturn'+linesToReturn);
        return linesToReturn;
    }
    public static AcctSeed__Billing_Line__c createLineType(String RecType,SBQQ__QuoteLine__c QL ) {
        AcctSeed__Billing_Line__c lineToReturn = new AcctSeed__Billing_Line__c();
        lineToReturn.AcctSeed__Hours_Units__c = QL.SBQQ__Quantity__c;
        //lineToReturn.AcctSeed__Billing__c
        //lineToReturn.AcctSeed__Discount_Pct__c = QL.SBQQ__Discount__c;
        //lineToReturn.AcctSeed__Discount_Amt__c = QL.SBQQ__AdditionalDiscountAmount__c;
        lineToReturn.AcctSeed__List_Price__c = QL.SBQQ__ListPrice__c;
        lineToReturn.AcctSeed__Rate__c = QL.SBQQ__NetPrice__c;
        lineToReturn.Category__c = QL.Tax_Category__c;
        //lineToReturn.Description__c = QL.Line_Notes_Instructions__c;
        lineToReturn.Description__c = QL.Item_Notes__c;
        lineToReturn.Taxable__c = QL.Taxable_form__c;
        lineToReturn.Product2__c = QL.SBQQ__Product__c;
        lineToReturn.AcctSeed__Date__c = date.today();
        lineToReturn.Type__c = RecType;
        lineToReturn.Quote_Line_Item__c = QL.id;
        lineToReturn.Project_Task__c = QL.Project_Line_Item__c;
        System.debug('########createLineType in linereturn'+RecType);
        return lineToReturn;*/
    }
        

}