public class CaseTriggerHandler {
    public static void acceptedCase(List<Id> acceptedCaseIds) {
        List<SBQQ__Quote__c> primaryQuote = new List<SBQQ__Quote__c>();
        List<Con_Req_Group__c> conList=new List<Con_Req_Group__c>();
        List<WorkOrder> wOrder=new List<WorkOrder>();
        
        system.debug('Accepted caseid' +acceptedCaseIds);
        
        
        case assignhr =new case();
        list<case> getcasehr = new list<case>();
        
        getcasehr = [select id,TotalTravelHoursfromWOs__c,TotalLaborHoursfromWOs__c,Total_Travel_Hours_from_WO_round__c,TotalLaborHours__c,Quote_Accepted__c,Subject from case where id=:acceptedCaseIds];
        if (getcasehr.size()>0) {
            
            assignhr= getcasehr.get(0);
        }       
        //   SBQQ__LineItems__r gettravelline = new SBQQ__LineItems__r();
        //   list<SBQQ__LineItems__r> quoteline1 = new list<SBQQ__LineItems__r>();
        //  quoteline =[select id from SBQQ__LineItems__c where SBQQ__Product__c='01t34000004eGpG' and id ='']
        List<SBQQ__QuoteLine__c> quoteline1 = new List<SBQQ__QuoteLine__c>();
        
        List<AcctSeed__Billing__c> billingToInsert = new List<AcctSeed__Billing__c>();
        List<AcctSeed__Billing_Line__c > billingLinesToInsert = new List<AcctSeed__Billing_Line__c >();
        //List<AcctSeed__Billing_Line__c > travelbl = new List<AcctSeed__Billing_Line__c >();
        Boolean APRecieved=false;
        List<AcctSeedERP__Purchase_Order__c> poList=[select id from AcctSeedERP__Purchase_Order__c where Case__c IN :acceptedCaseIds AND AcctSeedERP__Status__c='Closed' ];
        if(poList !=null && poList.size()>0){
            APRecieved=true;
        }
        primaryQuote = [SELECT Id, SBQQ__MasterContract__c,CountofMow__c, SBQQ__Account__c,BillingType__c, Site_Address__c, Site_City__c, Site_State__c, Site_Country__c, Site_Zip__c,Labor_Billing__c, P_M_Billing__c, Case__c,con_req_group__c, SBQQ__Opportunity2__c,Project__c,OwnerId,
                       Customer_Reference_Number__c, Payment_Due_Days__c,SBQQ__ShippingStreet__c, SBQQ__ShippingCity__c, SBQQ__ShippingState__c,SBQQ__ShippingCountry__c,SBQQ__ShippingPostalCode__c,
                        (SELECT Id, SBQQ__Quantity__c,SBQQ__NetPrice__c,SBQQ__Discount__c,SBQQ__AdditionalDiscountAmount__c, SBQQ__ProductFamily__c,Name,
                         SBQQ__ListPrice__c,Tax_Category__c,Item_Notes__c, SBQQ__Taxable__c, SBQQ__Product__c,PO_Line_Status__c, Project_Line_Item__c,Taxable_form__c   FROM SBQQ__LineItems__r )
                        FROM SBQQ__Quote__c WHERE SBQQ__Primary__c = TRUE AND SBQQ__Status__c = 'Accepted' AND Case__c IN :acceptedCaseIds AND (Labor_Billing__c != 'Not Billable' OR P_M_Billing__c != 'Not Billable')];
    
        // AcctSeed__Billing_Format__c formatDefault = [SELECT Id FROM AcctSeed__Billing_Format__c WHERE Name = 'O&M' Limit 1];
        System.debug('+++++++++++Pquote'+primaryQuote.size());
        system.debug('this is quote' +primaryquote);
        
        List<AcctSeed__Billing_Format__c> formatDefault = [SELECT Id FROM AcctSeed__Billing_Format__c WHERE Name ='O&M' LIMIT 1];
    /*  this is to update the quote_accepted__c field in case object
    * if there are no quote in accepted status
            case quoteacc = new case();
    if (primaryquote.size()==0 && acceptedCaseIds.size()>0 ){
        
        quoteacc.id = assignhr.id;
           quoteacc.Quote_Accepted__c = true;
        update quoteacc;
        
    }else if(acceptedCaseIds.size()>0)
    {
        quoteacc.id = assignhr.id;
           quoteacc.Quote_Accepted__c = false;
        update quoteacc;
    } */
       /////////////////////////////
    /*SBQQ__Quote__c q1 = new SBQQ__Quote__c();
        if (primaryQuote.size()>0){
            q1 = primaryQuote.get(0);
        }*/
        
       //AcctSeed__Billing__c[] billingrec = [select id from AcctSeed__Billing__c where Quote__c = :q1.id];
    
        for (SBQQ__Quote__c q : primaryQuote) {
            
            /*if (billingrec.size()>0){
                break;
            }*/
            system.debug('this is the start-->' +q.id);
            Date lastDayOfCurrentMonth = Date.today().addMonths(1).toStartofMonth().addDays(-1);
            
            AcctSeed__Billing__c newBilling = new AcctSeed__Billing__c();
            newBilling.ConReqGroup__c=q.Con_Req_Group__c;
            newBilling.Service_Contract__c = q.SBQQ__MasterContract__c;
            system.debug('this is BILLING TYPE' +q.BillingType__c);
            if(q.BillingType__c=='Mows/Wash' && APRecieved==true){
                newBilling.AcctSeed__Status__c='Ready to Process';
                
            }
            else if(q.BillingType__c=='Mows/Wash' && APRecieved==false){
                newBilling.AcctSeed__Status__c='New- No AP';
            }
    
            else{
                newBilling.AcctSeed__Status__c='New';
            }
            
            newBilling.AcctSeed__Customer__c = q.SBQQ__Account__c;
            newBilling.AcctSeed__Shipping_Street__c = q.Site_Address__c;
            newBilling.AcctSeed__Shipping_City__c = q.Site_City__c;
            newBilling.AcctSeed__Shipping_State__c = q.Site_State__c;
            newBilling.AcctSeed__Shipping_Country__c = q.Site_Country__c;
            newBilling.AcctSeed__Shipping_PostalCode__c = q.Site_Zip__c;
            newBilling.AcctSeed__Date__c = lastDayOfCurrentMonth;
            newBilling.AcctSeed__Due_Date2__c = lastDayOfCurrentMonth.addDays(Integer.valueOf(q.Payment_Due_Days__c));
            newBilling.Customer_Reference_Number__c = q.Customer_Reference_Number__c;
            wOrder=[Select id,Status,BillableTravelHours__c from WorkOrder where CaseID IN:acceptedCaseIds AND Status ='Completed' Order BY LastModifiedDate DESC limit 1];
            WorkOrder worderlist=new WorkOrder();
            WorkOrder worderlist1=new WorkOrder();
            if(wOrder.size()>0)
            {
                worderlist=wOrder.get(0);
                newBilling.WorkOrder__c=worderlist.Id;
            }
            
            
            
            
            if (formatDefault.size() > 0) newBilling.AcctSeed__Billing_Format__c = formatDefault[0].Id;
            newBilling.Quote__c = q.Id;
            //billingToInsert.add(newBilling);
            if(!Test.isRunningTest()){
            insert newBilling;
            }
            System.debug('+++++++++++newBilling'+ newBilling);
            for (SBQQ__QuoteLine__c qL : q.SBQQ__LineItems__r) {
                system.debug('LOOK HERE');
                if (qL.PO_Line_Status__c != 'In Process' && (qL.SBQQ__ProductFamily__c == 'Labor and Service' && q.Labor_Billing__c == 'Billable' && qL.Tax_Category__c  != 'Labor - Internal' || q.P_M_Billing__c == 'Billable' && qL.SBQQ__ProductFamily__c != 'Labor and Service')) {
                    system.debug('this is first insert if --->');
                    billingLinesToInsert.addAll(createBillingLines(1, qL));
                } else if (qL.SBQQ__ProductFamily__c == 'Labor and Service' && q.Labor_Billing__c == 'Billable' || q.P_M_Billing__c == 'Billable' && qL.SBQQ__ProductFamily__c != 'Labor and Service') {
                    system.debug('this is second insert if --->');
                    //billingLinesToInsert.addAll(createBillingLines(1, qL));
                    system.debug('this is travel-->' +qL.SBQQ__Product__c);
                    if(qL.SBQQ__Product__c!='01t34000004eGpG' )
                    {
                    system.debug('This is second if');
                        if (assignhr.TotalTravelHoursfromWOs__c>0){
                         system.debug('This is thrid if');
                            billingLinesToInsert.addAll(createBillingLines(1, qL));
                        }else{
                        system.debug('This is fourth if');
                            billingLinesToInsert.addAll(createBillingLines(1, qL));
                        }
                       
                    }
                    
                }
            }
            
            
            /* INSERTING BILLING -LINE*/
            for (AcctSeed__Billing_Line__c bl : billingLinesToInsert) {
                
                system.debug('this is the main billing type');
                system.debug('this BT---->' +q.BillingType__c);
                system.debug('this is apreceived' +APRecieved);
                
                if(q.BillingType__c=='Mows/Wash' && APRecieved==true){
                    bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2ir'; //1213
                    
                }
                else if(q.BillingType__c=='Mows/Wash' && APRecieved==false){
                    bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2kB'; //2303
                }
                else if(q.BillingType__c=='Mows/Wash- Internal'){
                    system.debug('IF CONDITION');
                    system.debug('Billing Lines check before assign -->' +bl.AcctSeed__Revenue_GL_Account__c);
                    bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2iq'; //1212
                 system.debug('Billing Lines check -->' +bl.AcctSeed__Revenue_GL_Account__c);
                }
                else if(q.BillingType__c=='Internal Labor Only')
                {
                    bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2iq';//1212 gl account
                }
                
                List<SBQQ__QuoteLine__c> quoteline=new  List<SBQQ__QuoteLine__c>();
                quoteline=[select SBQQ__Product__c,Tax_Category__c,Vendor__c,SBQQ__CustomerPrice__c from SBQQ__QuoteLine__c where id=:bl.Quote_Line_Item__c];
                SBQQ__QuoteLine__c  quotelineitems=new SBQQ__QuoteLine__c();
                
                quotelineitems=quoteline.get(0);
                
                system.debug('Q NAME' +quotelineitems.SBQQ__Product__c);
                
                /* THIS IS NON-CONTRACT -BILLIING TYPE LOGIC */
                system.debug('billing type--->' +q.BillingType__c);
                system.debug('ap-->'+ APRecieved);
                system.debug('tax cat-->' +quotelineitems.Tax_Category__c);
                system.debug('vendor-->' +quotelineitems.Vendor__c);
                
                if(q.BillingType__c=='Non-Contract' && APRecieved==false && quotelineitems.Tax_Category__c=='Labor - Internal')
                {
                if(assignhr.TotalLaborHoursfromWOs__c!=null)
                {
                    
                    bl.AcctSeed__Hours_Units__c= assignhr.TotalLaborHoursfromWOs__c;
                    }
                   bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2iq';
                    
                    system.debug('final quantity-->' + bl.AcctSeed__Hours_Units__c);
                }
                if(q.BillingType__c=='Non-Contract' && APRecieved==false && quotelineitems.Tax_Category__c=='Parts/Material'&& quotelineitems.Vendor__c!=null)
                {
                    bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2kB'; //2303 gl account
                    /*if(assignhr.TotalLaborHoursfromWOs__c!=null)
                    {
                    bl.AcctSeed__Hours_Units__c=assignhr.TotalLaborHoursfromWOs__c;
                    }*/
                    
                }
                else if(q.BillingType__c=='Non-Contract' && APRecieved==false && quotelineitems.Tax_Category__c=='Drive Time/Travel - Internal'){
                    bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2iq'; //1212 gl account
                    if(wOrder.size()>0)
                    {
                        worderlist1=wOrder.get(0);
                        if(worderlist1.BillableTravelHours__c!=null)
                        {
                        bl.AcctSeed__Hours_Units__c= worderlist1.BillableTravelHours__c;
                       }
                    }
                }
                else if(q.BillingType__c=='Non-Contract' && APRecieved==false && quotelineitems.Vendor__c!=null  &&(quotelineitems.Tax_Category__c !='Parts/Material' || quotelineitems.Tax_Category__c!='Drive Time/Travel - Internal' || quotelineitems.Tax_Category__c!='Labor - Internal') )
                {
                    bl.AcctSeed__Revenue_GL_Account__c='a1m80000000p2iq';//1212 gl account
                    /*if(assignhr.TotalLaborHoursfromWOs__c!=null)
                    {
                    bl.AcctSeed__Hours_Units__c= assignhr.TotalLaborHoursfromWOs__c;
                    }*/
                }
                
                /*THIS IS INTERNAL LABOR ONLY LOGIC ...   */ 
                if(q.BillingType__c=='Internal Labor Only' && quotelineitems.SBQQ__Product__c=='01t34000004eGpG')
                {
                
                
            
                    
                    
                   
                    
                   
                         bl.AcctSeed__Rate__c = 100;
                        
                       
                       
                     bl.AcctSeed__Hours_Units__c=assignhr.Total_Travel_Hours_from_WO_round__c;
                
                }
               
                //system.debug('product' +quotelineitems.SBQQ__Product__c);
                   else if(assignhr.TotalLaborHoursfromWOs__c>0  && q.BillingType__c=='Internal Labor Only' && quotelineitems.SBQQ__Product__c!='01t34000004eGpG')
                       
                    {
                    
                
                      Decimal d= assignhr.TotalLaborHoursfromWOs__c;
                     
                    String s = String.valueOf(d);
                    system.debug('String' +s);
                    string num=s.substringafter('.');
                    string decimalnum1=num.substring(0,1);
                    //String num= s.split('.').get(0);
                    
                    system.debug('Number substring' +num);
                    Integer num1=Integer.ValueOf(decimalnum1);
                    system.debug('Number substring' +num);
                    system.debug('Number' +num1);
                    system.debug('number' +num);
                    //Decimal d= assignhr.TotalLaborHoursfromWOs__c;
                    //Double num = d.setScale(2) ;
                    if(num1>=5)
                        {
                         system.debug('Entering If');
                        bl.AcctSeed__Hours_Units__c=assignhr.TotalLaborHoursfromWOs__c.round(System.RoundingMode.CEILING);
                        }
                        else
                        {
                        bl.AcctSeed__Hours_Units__c=assignhr.TotalLaborHoursfromWOs__c;
                        }
                        
                       system.debug('Round Off' +bl.AcctSeed__Hours_Units__c);
                       system.debug('Round Off' +num);
                    }
                    
                //}
                
                
                
                bl.Case__c = q.Case__c;
                bl.AcctSeed__Opportunity_Product_Id__c = q.SBQQ__Opportunity2__c;
             bl.AcctSeed__Project__c = q.Project__c;
                bl.AcctSeed__Employee__c = q.OwnerId;
                bl.AcctSeed__Billing__c = newBilling.id;
                
                bl.Description__c=assignhr.Subject;
                system.debug('Billing Lines1111 ' +bl.AcctSeed__Revenue_GL_Account__c);
                system.debug('this is quantity' +bl.AcctSeed__Hours_Units__c);
            }
            system.debug('Billing Lines before insert' +billingLinesToInsert);
            if(!Test.isRunningTest()){
            insert billingLinesToInsert;
            }
            system.debug('Billing Lines ' +billingLinesToInsert);
            
            if(wOrder.size()>0)
                    {
                        worderlist1=wOrder.get(0);
                       
                    }
            
            quoteline1 =[select id from SBQQ__QuoteLine__c where SBQQ__Quote__c=:q.id and SBQQ__Product__c='01t34000004eGpG'];
            if(quoteline1.size()==0 && worderlist1.BillableTravelHours__c>0 && q.BillingType__c=='Internal Labor Only')
            {
            system.debug('This is fivth if');
            
              AcctSeed__Billing_Line__c travelbl = new AcctSeed__Billing_Line__c ();
            
            
               travelbl .Case__c = q.Case__c;
                travelbl .AcctSeed__Opportunity_Product_Id__c = q.SBQQ__Opportunity2__c;
                travelbl .AcctSeed__Project__c = q.Project__c;
                travelbl .AcctSeed__Employee__c = q.OwnerId;
                travelbl .AcctSeed__Billing__c = newBilling.id;
                travelbl .AcctSeed__Revenue_GL_Account__c='a1m80000000p2iq';
                travelbl .AcctSeed__Hours_Units__c=worderlist1.BillableTravelHours__c;
                travelbl .AcctSeed__Date__c = date.today();
                travelbl.AcctSeed__Rate__c=100;
                travelbl.Category__c='Drive Time/Travel - Internal';
                travelbl.Description__c=assignhr.Subject;
                
                
            if(!Test.isRunningTest()){
            insert travelbl ;
            }
            }
            
            
        }
        
    }
    
    
    public static List<AcctSeed__Billing_Line__c> createBillingLines(Integer count,SBQQ__QuoteLine__c QL) {
        system.debug('LOOK HERE2');
        List<AcctSeed__Billing_Line__c> linesToReturn = new List<AcctSeed__Billing_Line__c>();
        /*  if (count == 2) {
linesToReturn.add(createLineType('Billing', QL));
linesToReturn.add(createLineType('Credit', QL));
//linesToReturn.add(createLineType('Debit', QL));
} else*/
        
        
        linesToReturn.add(createLineType('Billing', QL));
        system.debug('this is return-->' +linestoreturn);
        
        
        return linesToReturn;
    }
    public static AcctSeed__Billing_Line__c createLineType(String RecType,SBQQ__QuoteLine__c QL ) {
        system.debug('LOOK HERE3');
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
        System.debug('+++++++++++billinglineToReturnType__'+lineToReturn.AcctSeed__Revenue_GL_Account__c);
        System.debug('Quantity field '+lineToReturn.AcctSeed__Hours_Units__c);
        return lineToReturn;
        
    }
}