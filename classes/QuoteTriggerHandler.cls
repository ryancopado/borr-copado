public class QuoteTriggerHandler {
    public static void approvedQuote(List<Id> approvedQuoteIds) {
        system.debug('in approved quote handler');
        Map<Id, List<SBQQ__QuoteLine__c>> quoteLines = new Map<Id, List<SBQQ__QuoteLine__c>>();
        List<SBQQ__QuoteLine__c> quoteLinesToUpdate = new List<SBQQ__QuoteLine__c>();
        List<Con_Req_Group__c> ConReqsToInsert = new List<Con_Req_Group__c>();
        List<AcctSeedERP__Sales_Order_Line__c > SOLtoInsert = new List<AcctSeedERP__Sales_Order_Line__c >();
        List<AcctSeedERP__Sales_Order__c > SOtoInsert = new List<AcctSeedERP__Sales_Order__c >();
        Set<Id> AccountIDsForSO = new Set<Id>();
        Set<Id> projectIDs = new Set<Id>();
        
        List<SBQQ__Quote__c> quoteList = [SELECT Id, Project__c, OwnerId, Project_Description__c, 
                                          Contract__c, SBQQ__Account__c,Site_Address__c,Site_City__c,Site_State__c,Site_Country__c,Site_Zip__c ,(SELECT Vendor__c, Vendor_Contact__c FROM SBQQ__LineItems__r)
                                         FROM SBQQ__Quote__c WHERE ID IN :approvedQuoteIds];
        
        List<SBQQ__QuoteLine__c> quoteLineList = [ SELECT SBQQ__Quote__c, Project__c,SBQQ__Quote__r.OwnerId, Project_Line_Item__c,
                                                  SBQQ__Quote__r.Project_Description__c, SBQQ__Quote__r.Contract__c, Tax_Category__c, SBQQ__Quote__r.SBQQ__PrimaryContact__c,
                                                  SBQQ__Quote__r.SBQQ__Account__c, Vendor__c, Vendor_Contact__c, SBQQ__UnitCost__c,
                                                  SBQQ__Product__c,SBQQ__Quantity__c, SBQQ__Quote__r.Case__c, SBQQ__Quote__r.SBQQ__MasterContract__c,SBQQ__Quote__r.Site_Address__c,SBQQ__Quote__r.Site_City__c,SBQQ__Quote__r.Site_State__c,SBQQ__Quote__r.Site_Country__c,SBQQ__Quote__r.Site_Zip__c 
                                                  FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c IN :approvedQuoteIds AND Vendor__c != null];
        
        system.debug('quotelinelist: ' + quoteLineList);
        //for (SBQQ__Quote__c quote : quoteList) {
        for (SBQQ__QuoteLine__c quoteLine : quoteLineList /*quote.SBQQ__LineItems__r*/) {
            if (quoteLines.get(quoteLine.Vendor__c) == null) {
                List<SBQQ__QuoteLine__c> newList = new List<SBQQ__QuoteLine__c>{quoteLine};
                    quoteLines.put(quoteLine.Vendor__c, newList);
            } else {
                quoteLines.get(quoteLine.Vendor__c).add(quoteLine);
            }
            system.debug('quoteLines: ' + quoteLines);
            AccountIDsForSO.add(quoteLine.SBQQ__Quote__r.SBQQ__Account__c);
            projectIDs.add(quoteLine.Project__c);
        }
        //}
        system.debug('quoteLines: ' + quoteLines);
        /*for (Id AcctId : AccountIdsForSO) {
            AcctSeedERP__Sales_Order__c newSO = new AcctSeedERP__Sales_Order__c();
            newSO.AcctSeedERP__Customer__c = AcctId;
            
            SOtoInsert.add(newSO);
        }
        
        insert SOtoInsert;*/
        system.debug('SOtoInsert: ' + SOtoInsert);
        
        Map<Id, AcctSeedERP__Sales_Order__c> SOInsertedMap = new Map<Id, AcctSeedERP__Sales_Order__c>();
        for (AcctSeedERP__Sales_Order__c SO : [SELECT Id,Project__c,AcctSeedERP__Customer__c FROM AcctSeedERP__Sales_Order__c WHERE Project__c IN :projectIDs]) {
            SOInsertedMap.put(SO.Project__c, SO);
        }
        
        for (String key : quoteLines.keySet()) {
            List<SBQQ__QuoteLine__c> currentLines = quoteLines.get(key);
            if (currentLines.size() > 0) {
                if (currentLines[0].Vendor__c != null) {
                    Con_Req_Group__c newCon = new Con_Req_Group__c();
                    newCon.Vendor__c = currentLines[0].Vendor__c;
                    newCon.Vendor_Contact__c = currentLines[0].Vendor_Contact__c;
                    newCon.Quote__c = currentLines[0].SBQQ__Quote__c;
                    newCon.Project__c = currentLines[0].Project__c;
                    newCon.Contact__c = currentLines[0].SBQQ__Quote__r.OwnerId;
                    newCon.Project_Detail__c = currentLines[0].SBQQ__Quote__r.Project_Description__c;
                    newCon.Service_Contract__c = currentLines[0].SBQQ__Quote__r.Contract__c;
                    newCon.Ship_to_Account__c = currentLines[0].SBQQ__Quote__r.SBQQ__Account__c;
                    newCon.Sales_Order__c = SOInsertedMap.get(currentLines[0].Project__c).Id;
                    newCon.Case__c = currentLines[0].SBQQ__Quote__r.Case__c;
                    newCon.Service_Contract__c = currentLines[0].SBQQ__Quote__r.SBQQ__MasterContract__c;
                    newCon.RecordTypeId = Schema.SObjectType.Con_Req_Group__c.getRecordTypeInfosByName().get('Service Visit').getRecordTypeId();
                    newCon.Use_Project_Ship_To__c = true;
                    newCon.Ship_To_Contact__c = currentLines[0].SBQQ__Quote__r.SBQQ__PrimaryContact__c;
                    newCon.Ship_To_Street__c=currentLines[0].SBQQ__Quote__r.Site_Address__c;
                    newCon.Ship_To_City__c=currentLines[0].SBQQ__Quote__r.Site_City__c;
                    newCon.Ship_To_State__c=currentLines[0].SBQQ__Quote__r.Site_State__c;
                    newCon.Ship_To_Zip__c=currentLines[0].SBQQ__Quote__r.Site_Zip__c;
                    
                   
                    newCon.Ownerid= currentLines[0].SBQQ__Quote__r.OwnerId;
                    //newCon.Status__c='New';
                    //Add more fields here
                    
                    ConReqsToInsert.add(newCon); 
                }
                
                
                //AccountIDsForSO.add(currentLines[0].SBQQ__Quote__r.SBQQ__Account__c);
               
            }
        }
        system.debug('conreqstoinsert: ' + ConReqsToInsert);
        if (ConReqsToInsert.size() > 0) insert ConReqsToInsert;
        system.debug('conreqstoinsert: ' + ConReqsToInsert);
         
        
       
        
        /*for (Id AcctId : AccountIdsForSO) {
            AcctSeedERP__Sales_Order__c newSO = new AcctSeedERP__Sales_Order__c();
            newSO.AcctSeedERP__Customer__c = AcctId;
            
            SOtoInsert.add(newSO);
        }
        
       insert SOtoInsert;
       system.debug('SOtoInsert: ' + SOtoInsert);*/
       
        /*Map<Id, AcctSeedERP__Sales_Order__c> SOInsertedMap = new Map<Id, AcctSeedERP__Sales_Order__c>();
        for (AcctSeedERP__Sales_Order__c SO : [SELECT Id,Project__c,AcctSeedERP__Customer__c FROM AcctSeedERP__Sales_Order__c WHERE AcctSeedERP__Customer__c IN :AccountIdsForSO]) {
            SOInsertedMap.put(SO.AcctSeedERP__Customer__c, SO);
        }*/
        
        Map<Id, Con_Req_Group__c> conReqInsertedMap = new Map<Id, Con_Req_Group__c>();
        for (Con_Req_Group__c con : [SELECT Id, Vendor__c FROM Con_Req_Group__c WHERE Vendor__c IN :quoteLines.keySet() AND CreatedDate > :Datetime.now().addMinutes(-15)]) {
            conReqInsertedMap.put(con.Vendor__c, con);
        }
        
        for (String key : quoteLines.keySet()) {
            
            List<SBQQ__QuoteLine__c> currentLines = quoteLines.get(key);
            if (currentLines.size() > 0) {
                for (SBQQ__QuoteLine__c quoteLine : currentLines) {
                    if (quoteLine.Vendor__c != null) {
                        //when creating vendor SOL mark quoteline as new
                        AcctSeedERP__Sales_Order_Line__c newSOL = new AcctSeedERP__Sales_Order_Line__c();
                        newSOL.Vendor__c = quoteLine.Vendor__c;
                        newSOL.Vendor_Contact__c = quoteLine.Vendor_Contact__c;
                        newSOL.Con_Req_Group__c = conReqInsertedMap.get(key).Id;
                        newSOL.AcctSeedERP__Project__c = quoteLine.Project__c;
                        newSOL.AcctSeedERP__Project_Task__c = quoteLine.Project_Line_Item__c;
                        if (quoteLine.SBQQ__UnitCost__c != null) {
                            newSOL.Unit_Cost__c = quoteLine.SBQQ__UnitCost__c;
                        } else {
                            newSOL.Unit_Cost__c = 0.00;
                        }
                        newSOL.AcctSeedERP__Product__c = quoteLine.SBQQ__Product__c;
                        newSOL.AcctSeedERP__Quantity_Ordered__c = quoteLine.SBQQ__Quantity__c;
                        newSOL.AcctSeedERP__Sales_Order__c = SOInsertedMap.get(quoteLine.Project__c).Id;
                        newSOL.Ship_to_Account__c = quoteLine.SBQQ__Quote__r.SBQQ__Account__c;
                        newSOL.Quote_Line_Item__c = quoteLine.id;
                        newSOL.RecordTypeId = Schema.SObjectType.AcctSeedERP__Sales_Order_Line__c.getRecordTypeInfosByName().get('Service').getRecordTypeId();
                        //newSOL.AcctSeedERP__Project_Task__c
                        newSOL.Tax_Category__c = quoteLine.Tax_Category__c;
                        //newSOL.Status__c='New';
                    
                        SOLtoInsert.add(newSOL); 
                        
                        quoteLine.PO_Line_Status__c = 'In Process';
                        quoteLinesToUpdate.add(quoteLine);
                    }
                }
                
                
            }
        }
        system.debug('SOLtoInsert: ' + SOLtoInsert);
        insert SOLtoInsert;
        update quoteLinesToUpdate;
        Con_Req_Group__c  conreq=new Con_Req_Group__c  ();
         
         //Con_Req_Group__c  con= new Con_Req_Group__c  ();
        /* if(ConReqsToInsert.size()>0)
         {
         
         system.debug('Entering If');
         
    //sleep for 9s
    conreq=ConReqsToInsert.get(0);
         Con_Req_Group__c  con= new Con_Req_Group__c  ();
        con.Status__c='Approved';
        con.Id=conreq.Id;
        update con;
   
         
        }*/
        
        
        
    }
}