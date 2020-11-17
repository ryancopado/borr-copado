public class createConPO {
    
     /***** Begin Change Order *****/
    public static void updateCO(Con_Req__c[] reqs) {
        Map<Id, Id> reqProj = new Map<Id,Id>();
        List<Id> projects = new List<Id>();
        Map<Id, Id> projOpp = new Map<Id,Id>();
        List<Id> oppos = new List<Id>();
        Map<Id, Opportunity> oppo = new Map<Id, Opportunity>();
        List<Opportunity> updateOpps = new List<Opportunity>();
        Con_Req__c[] req = [SELECT Id, ASProject__c, Final_Change_Order_Amount__c FROM Con_Req__c WHERE Id in :reqs];
        
        for (Integer i = 0; i <req.size(); i++) {
            reqProj.put(req[i].Id, req[i].ASProject__c);
            projects.add(req[i].ASProject__c);
        }
        AcctSeed__Project__c[] p = [select AcctSeed__Opportunity__c from AcctSeed__Project__c where Id in :projects];
        for (Integer i = 0; i <p.size(); i++) {
            projOpp.put(p[i].Id, p[i].AcctSeed__Opportunity__c);
            oppos.add(p[i].AcctSeed__Opportunity__c);
        }
        Opportunity[] opp = [select Change_Orders__c from Opportunity where Id in :oppos];
        for (Integer i = 0; i <opp.size(); i++) {
            oppo.put(opp[i].Id, opp[i]);
        }
        for (Con_Req__c r:reqs){
            if (oppo.get(projOpp.get(reqProj.get(r.Id))).Change_Orders__c == null) {
                oppo.get(projOpp.get(reqProj.get(r.Id))).Change_Orders__c = 0;
            }
            oppo.get(projOpp.get(reqProj.get(r.Id))).Change_Orders__c += r.Final_Change_Order_Amount__c;
            updateOpps.add(oppo.get(projOpp.get(reqProj.get(r.Id))));
        }
        update updateOpps;
    }
    /***** End Change Order *****/
    
    /***** Begin Service Purchase Order *****/
    public static void addserPO(Con_Req__c[] reqs){

        
        List<Id> svId = new List<Id>();
        Map<Id, Id> svReq = new Map<Id, Id>();
        Map<Id, Id> reqSV = new Map<Id, Id>();
        Map<Id, SV__c> svMap = new Map<Id, SV__c>();
        List<Id> ccId = new List<Id>();
        Map<Id, Id> ccReq = new Map<Id, Id>();
        Map<Id, Cost_Code__c> ccMap = new Map<Id, Cost_Code__c>();
        List<Id> catId = new List<Id>();
        Map<Id, Id> catReq = new Map<Id, Id>();
        List<Id> accId = new List<Id>();
        Map<Id, Account> accMap = new Map<Id, Account>();
        
        //Query BLIs from ConReqs, add BLIs to reqID list, put Req Id and BLI Id into conBli
        Con_Req__c[] req = [SELECT Id, Service_Visit__c, Cost_Code__c, Ship_To__c FROM Con_Req__c WHERE Id in :reqs];
        for (Integer i = 0; i <req.size(); i++) {
            svId.add(req[i].Service_Visit__c);
            reqSV.put(req[i].Id, req[i].Service_Visit__c);
            ccId.add(req[i].Cost_Code__c);
            ccReq.put(req[i].Cost_Code__c, req[i].Id);
            accId.add(req[i].Ship_To__c);
        }
        SV__c[] svs = [SELECT Id, Cost__c, Name, Contract__c FROM SV__c WHERE Id in :svId];
        for (Integer i = 0; i <svs.size(); i++) {
            svMap.put(svs[i].Id, svs[i]);
        }
        Cost_Code__c[] ccs = [SELECT Id, Number__c, Category__c FROM Cost_Code__c WHERE Id in :ccId];
        for (Integer i = 0; i <ccs.size(); i++) {
            ccMap.put(ccReq.get(ccs[i].Id), ccs[i]);
        }
        Account[] accs = [SELECT Id, Name, ShippingStreet, ShippingState, ShippingCity, ShippingPostalCode FROM Account WHERE Id in :accId];
        for (Integer i = 0; i <accs.size(); i++) {
            accMap.put(accs[i].Id, accs[i]);
        }
        
        List<SV__c> updatesv = new List<SV__c>();   //List of SVs to be updated         
        
        //Begin to Create POs - includes removing Req Amount from Pending PO and adding to Approved PO (PO_Total__c)
        for (Con_Req__c r:reqs){
            if (r.RecordTypeId == Utilities.getRecordType('Minor Component Requisition').Id) {
                Con_PO__c purchase = new Con_PO__c(
                    Status__c = 'New',
                    Vendor_Account__c = r.Vendor_Account__c,
                    Vendor_Contact__c = r.Vendor_Contact__c,
                    Ship_To__c = r.Ship_To__c,
                    Ship_Address__c = accMap.get(r.Ship_To__c).ShippingStreet + '\n' + accMap.get(r.Ship_To__c).ShippingCity + ', ' 
                                        + accMap.get(r.Ship_To__c).ShippingState + ' ' + accMap.get(r.Ship_To__c).ShippingPostalCode,
                    Date__c = r.Date_Needed__c,
                    Quantity__c = r.Quantity__c,
                    Unit_Price__c = r.Unit_Price__c,
                    OwnerId = r.Project_PM__c,
                    Requested_By__c = r.Project_PM__c,
                    Item_Code__c = r.Part_Number__c,
                    Description__c = r.Product_Description__c,
                    RecordTypeId = Utilities.getRecordType('Minor Component PO').Id,
                    Tax_Rate__c = r.Tax_Rate__c,
                    Shipping__c = r.Shipping__c,
                    Requisition_Number__c = r.Job_Number__c,
                    Project_Name__c = svMap.get(reqSV.get(r.Id)).Name,
                    Cost_Code_Cat__c = ccMap.get(r.Id).Number__c + ' ' +ccMap.get(r.Id).Category__c);
                insert purchase;
                r.Purchase_Order__c = purchase.Id;
            
                if(svMap.get(reqSV.get(r.Id)).Cost__c == null) {
                    svMap.get(reqSV.get(r.Id)).Cost__c = 0;
                }
                //Add Req Total to PO_Total
                svMap.get(reqSV.get(r.Id)).Cost__c += r.Total_Cost_Tax__c;
                
                //Add updated BLIs to updatebli to be mass updated below
                updatesv.add(svMap.get(reqSV.get(r.Id)));                           
            }
            //Subcontractor
            if (r.RecordTypeId == Utilities.getRecordType('Subcontractor Requisition').Id) {
                Con_PO__c purchase = new Con_PO__c(
                    Status__c = 'New',
                    Vendor_Account__c = r.Vendor_Account__c,
                    Vendor_Contact__c = r.Vendor_Contact__c,
                    Date__c = r.Date_Needed__c,
                    Quantity__c = r.Quantity__c,
                    Unit_Price__c = r.Unit_Price__c,
                    OwnerId = r.Project_PM__c,
                    Requested_By__c = r.Project_PM__c,
                    RecordTypeId = Utilities.getRecordType('Subcontractor PO').Id,
                    Requisition_Number__c = r.Job_Number__c,
                    Project_Name__c = svMap.get(reqSV.get(r.Id)).Name,
                    Cost_Code_Cat__c = ccMap.get(r.Id).Number__c + ' ' +ccMap.get(r.Id).Category__c);
                insert purchase;
                r.Purchase_Order__c = purchase.Id;

                if(svMap.get(reqSV.get(r.Id)).Cost__c == null) {
                    svMap.get(reqSV.get(r.Id)).Cost__c = 0;
                }
                //Add Req Total to PO_Total
                svMap.get(reqSV.get(r.Id)).Cost__c += r.Total_Cost_Tax__c;
                
                //Add updated BLIs to updatebli to be mass updated below
                updatesv.add(svMap.get(reqSV.get(r.Id)));                                     
            }
            //Major Component
            if (r.RecordTypeId == Utilities.getRecordType('Major Component Requisition').Id) {
                //Query user to fill Requested By field
                User requester = [select Id from User where Name = 'Aaron Hall'];
                Con_PO__c purchase = new Con_PO__c(
                    Status__c = 'New',
                    Vendor_Account__c = r.Vendor_Account__c,
                    Vendor_Contact__c = r.Vendor_Contact__c,
                    Ship_To__c = r.Ship_To__c,
                    Ship_Address__c = accMap.get(r.Ship_To__c).ShippingStreet + '\n' + accMap.get(r.Ship_To__c).ShippingCity + ', ' 
                                        + accMap.get(r.Ship_To__c).ShippingState + ' ' + accMap.get(r.Ship_To__c).ShippingPostalCode,
                    Date__c = r.Date_Needed__c,
                    Quantity__c = r.Quantity__c,
                    Unit_Price__c = r.Product_Cost__c,
                    Requisition_Number__c = r.Job_Number__c,
                    Project_Name__c = svMap.get(reqSV.get(r.Id)).Name,
                    OwnerId = r.Project_PM__c,
                    Requested_By__c = requester.Id,
                    Product__c = r.Product__c,
                    Item_Code__c = r.Part_Number__c,
                    RecordTypeId = Utilities.getRecordType('Major Component PO').Id,
                    Tax_Rate__c = r.Tax_Rate__c,
                    Cost_Code_Cat__c = ccMap.get(r.Id).Number__c + ' ' +ccMap.get(r.Id).Category__c);
                insert purchase;
                r.Purchase_Order__c = purchase.Id;
                
                if(svMap.get(reqSV.get(r.Id)).Cost__c == null) {
                    svMap.get(reqSV.get(r.Id)).Cost__c = 0;
                }
                //Add Req Total to PO_Total
                svMap.get(reqSV.get(r.Id)).Cost__c += r.Total_Cost_Tax__c;
                
                //Add updated BLIs to updatebli to be mass updated below
                updatesv.add(svMap.get(reqSV.get(r.Id)));                          
            }
        }
        if (updatesv.size() > 0){
            update updatesv;
        } 
    }
    /***** End Service Purchase Order *****/ 
    
    /******** Begin Purchase Order *******/    
    public static void addPO(Con_Req__c[] reqs){
        
        //Query all Record Types
        /*Map<String,Id> rT = new Map<String,Id>();
        
        RecordType[] rTs = [select Name from RecordType];
        for (Integer i = 0; i <rTs.size(); i++) {
            rT.put(rTs[i].Name, rTs[i].Id);
        }*/
        
        Map<Id, Budget_Line_Item__c> bliMap = new Map<Id, Budget_Line_Item__c>();   //Map Budget Line Items
        Map<Id, Id> conBli = new Map<Id, Id>();     //Map ConReq Id to BLI Id
        List<Id> reqID = new List<Id>();    //List of BLI Ids from ConReqs
        List<Id> accId = new List<Id>();
        List<Id> prId = new List<Id>();
        Map<Id, Account> accMap = new Map<Id, Account>();
        Map<Id, SFDC_Project__c> prMap = new Map<Id, SFDC_Project__c>();
    //    List<Id> prID = new List<Id>();
        /*
        Map<Id, List<ProjectPartner__c>> ppMap = new Map<Id, List<ProjectPartner__c>>();
        List<ProjectPartner__c> newPP = new List<ProjectPartner__c>();
        */

        
        //Query BLIs from ConReqs, add BLIs to reqID list, put Req Id and BLI Id into conBli
        Con_Req__c[] req = [SELECT Id, Budget_Line_Item__c, Project__c, Ship_To__c, Vendor_Account__c FROM Con_Req__c WHERE Id in :reqs];
        for (Integer i = 0; i <req.size(); i++) {
            reqID.add(req[i].Budget_Line_Item__c);
            conBli.put(req[i].Id, req[i].Budget_Line_Item__c);
            accId.add(req[i].Ship_To__c);
            accId.add(req[i].Vendor_Account__c);
            prId.add(req[i].Project__c);
        }
        
        //Query BLIs in reqID list, add BLI to bliMap 
        Budget_Line_Item__c[] bli = [select Id, Pending_PO_Total__c, PO_Total__c, Tax_Exemption_Status__c, CC_Number__c, Category_Code__c from Budget_Line_Item__c where Id in :reqID];
        for (Integer i = 0; i <bli.size(); i++) {
            bliMap.put(bli[i].Id, bli[i]);
        }
        
        Account[] accs = [SELECT Id, ShippingStreet, ShippingState, ShippingCity, ShippingPostalCode, Type FROM Account WHERE Id in :accId];
        for (Integer i = 0; i <accs.size(); i++) {
            accMap.put(accs[i].Id, accs[i]);
        }
        //SFDC_Project__c[] prs = [SELECT Id, Name, (Select AccountId__c From Partners__r) FROM SFDC_Project__c WHERE Id in :prId];
        SFDC_Project__c[] prs = [SELECT Id, Name FROM SFDC_Project__c WHERE Id in :prId];
        for (Integer i = 0; i <prs.size(); i++) {
            prMap.put(prs[i].Id, prs[i]);
            //ppMap.put(prs[i].Id, prs[i].Partners__r);           
        }     
        
        List<Budget_Line_Item__c> updatebli = new List<Budget_Line_Item__c>();  //List of BLIs to be updated (PO Total)
        List<OpportunityLineItem> updateproj = new List<OpportunityLineItem>(); //List of OLIs to manage Quantity Requested       
        
        //Begin to Create POs - includes removing Req Amount from Pending PO and adding to Approved PO (PO_Total__c)
        for (Con_Req__c r:reqs){
            //Minor Component
            if (r.RecordTypeId == Utilities.getRecordType('Minor Component Requisition').Id) {
                //Only if Purchase Order doesn't exist
                Con_PO__c purchase = new Con_PO__c(
                    Status__c = 'New',
                    Vendor_Account__c = r.Vendor_Account__c,
                    Vendor_Contact__c = r.Vendor_Contact__c,
                    Ship_To__c = r.Ship_To__c,
                    Ship_Address__c = accMap.get(r.Ship_To__c).ShippingStreet + '\n' + accMap.get(r.Ship_To__c).ShippingCity + ', ' 
                                        + accMap.get(r.Ship_To__c).ShippingState + ' ' + accMap.get(r.Ship_To__c).ShippingPostalCode,
                    Date__c = r.Date_Needed__c,
                    Quantity__c = r.Quantity__c,
                    Unit_Price__c = r.Unit_Price__c,
                    Requisition_Number__c = r.Job_Number__c,
                    Project_Name__c = prMap.get(r.Project__c).Name,
                    OwnerId = r.Project_PM__c,
                    Requested_By__c = r.Project_PM__c,
                    Item_Code__c = r.Part_Number__c,
                    Description__c = r.Product_Description__c,
                    RecordTypeId = Utilities.getRecordType('Minor Component PO').Id,
                    Tax_Rate__c = r.Tax_Rate__c,
                    Shipping__c = r.Shipping__c,
                    Tax_Exemption__c = bliMap.get(r.Budget_Line_Item__c).Tax_Exemption_Status__c,
                    Cost_Code_Cat__c = bliMap.get(r.Budget_Line_Item__c).CC_Number__c + ' ' + bliMap.get(r.Budget_Line_Item__c).Category_Code__c);
                insert purchase;
                r.Purchase_Order__c = purchase.Id;
                
               //If PO_Total is null, set to 0 so addition doesn't fail
                if(bliMap.get(conBli.get(r.Id)).PO_Total__c == null) {
                    bliMap.get(conBli.get(r.Id)).PO_Total__c = 0;
                }
                //Add Req Total to PO_Total
                bliMap.get(conBli.get(r.Id)).PO_Total__c += r.Total_Cost_Tax__c;
                
                //Check that Pending is greater than Req Total, subtract Req Total
                if(bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c >= r.Total_Cost_Tax__c) {
                    bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c -= r.Total_Cost_Tax__c;
                }
                //Add updated BLIs to updatebli to be mass updated below 
                updatebli.add(bliMap.get(conBli.get(r.Id)));                                   
            }
            //Subcontractor
            if (r.RecordTypeId == Utilities.getRecordType('Subcontractor Requisition').Id) {
                //Only if Purchase Order doesn't exist
                Con_PO__c purchase = new Con_PO__c(
                    Status__c = 'New',
                    Vendor_Account__c = r.Vendor_Account__c,
                    Vendor_Contact__c = r.Vendor_Contact__c,
                    Date__c = r.Date_Needed__c,
                    Quantity__c = r.Quantity__c,
                    Unit_Price__c = r.Unit_Price__c,
                    Requisition_Number__c = r.Job_Number__c,
                    Project_Name__c = prMap.get(r.Project__c).Name,
                    OwnerId = r.Project_PM__c,
                    Requested_By__c = r.Project_PM__c,
                    RecordTypeId = Utilities.getRecordType('Subcontractor PO').Id,
                    Tax_Rate__c = r.Tax_Rate__c,
                    Tax_Exemption__c = bliMap.get(r.Budget_Line_Item__c).Tax_Exemption_Status__c,
                    Cost_Code_Cat__c = bliMap.get(r.Budget_Line_Item__c).CC_Number__c + ' ' + bliMap.get(r.Budget_Line_Item__c).Category_Code__c);
                insert purchase;
                r.Purchase_Order__c = purchase.Id;
                
                //If PO_Total is null, set to 0 so addition doesn't fail
                if(bliMap.get(conBli.get(r.Id)).PO_Total__c == null) {
                    bliMap.get(conBli.get(r.Id)).PO_Total__c = 0;
                }
                //Add Req Total to PO_Total
                bliMap.get(conBli.get(r.Id)).PO_Total__c += r.Total_Cost_Tax__c;
                
                //Check that Pending is greater than Req Total, subtract Req Total
                if(bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c >= r.Total_Cost_Tax__c) {
                    bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c -= r.Total_Cost_Tax__c;
                }
                //Add updated BLIs to updatebli to be mass updated below 
                updatebli.add(bliMap.get(conBli.get(r.Id)));
                
                /**** Add Project Partner ****/
                /*
                List<ProjectPartner__c> proPar = ppMap.get(r.Project__c);
                Map<Id, Con_Req__c> pCon = new Map<Id, Con_Req__c>();
                for(Integer i=0; i<proPar.size(); i++){
                    if(proPar[i].AccountId__c == r.Vendor_Account__c){
                        pCon.put(r.Id, r);
                    }
                }
                if(pCon.size() == 0){
                    ProjectPartner__c projPar = new ProjectPartner__c(ProjectId__c = r.Project__c,
                                                                        AccountId__c = r.Vendor_Account__c,
                                                                        Primary_Contact__c = r.Vendor_Contact__c,
                                                                        Role__c = accMap.get(r.Vendor_Account__c).Type);
                    newPP.add(projPar);                                                 
                }
                */                                                  
            }          
            //Major Component
            if (r.RecordTypeId == Utilities.getRecordType('Major Component Requisition').Id) {
                //Query Project from Req to get Opportunity
                SFDC_Project__c project = [select Opportunity__c from SFDC_Project__c where Id = :r.Project__c];
                //Query OLI from Project Opportunity where Product is on Req
                OpportunityLineItem products = [select Quantity, Qty_Requested__c from OpportunityLineItem where PricebookEntry.Product2.Id = :r.Product__c and OpportunityId = :project.Opportunity__c limit 1];
                //If Quantity Requested is null, set to 0 so addition doesn't fail
                if (products.Qty_Requested__c == null){
                    products.Qty_Requested__c = 0;
                }
                //Add Req Quantity to OLI Quantity Requested
                products.Qty_Requested__c += r.Quantity__c;
                //Add products to list to be updated below 
                updateproj.add(products);
                
                //Query user to fill Requested By field
                User requester = [select Id from User where Name = 'Aaron Hall'];
                //Only if Purchase Order doesn't exist
                Con_PO__c purchase = new Con_PO__c(
                    Status__c = 'New',
                    Vendor_Account__c = r.Vendor_Account__c,
                    Ship_To__c = r.Ship_To__c,
                    Vendor_Contact__c = r.Vendor_Contact__c,
                    Ship_Address__c = accMap.get(r.Ship_To__c).ShippingStreet + '\n' + accMap.get(r.Ship_To__c).ShippingCity + ', ' 
                                        + accMap.get(r.Ship_To__c).ShippingState + ' ' + accMap.get(r.Ship_To__c).ShippingPostalCode,
                    Date__c = r.Date_Needed__c,
                    Quantity__c = r.Quantity__c,
                    Unit_Price__c = r.Product_Cost__c,
                    Requisition_Number__c = r.Job_Number__c,
                    Project_Name__c = prMap.get(r.Project__c).Name,
                    OwnerId = r.Project_PM__c,
                    Requested_By__c = requester.Id,
                    Product__c = r.Product__c,
                    Item_Code__c = r.Part_Number__c,
                    RecordTypeId = Utilities.getRecordType('Major Component PO').Id,
                    Tax_Rate__c = r.Tax_Rate__c,
                    Tax_Exemption__c = bliMap.get(r.Budget_Line_Item__c).Tax_Exemption_Status__c,
                    Cost_Code_Cat__c = bliMap.get(r.Budget_Line_Item__c).CC_Number__c + ' ' + bliMap.get(r.Budget_Line_Item__c).Category_Code__c);
                insert purchase;
                r.Purchase_Order__c = purchase.Id;
                
                System.debug('22222222222'+ r);
             
                //If PO_Total is null, set to 0 so addition doesn't fail
                if(bliMap.get(conBli.get(r.Id)).PO_Total__c == null) {
                    bliMap.get(conBli.get(r.Id)).PO_Total__c = 0;
                }
                //Add Req Total to PO_Total
                bliMap.get(conBli.get(r.Id)).PO_Total__c += r.Total_Cost_Tax__c;
                    
                //Check that Pending is greater than Req Total, subtract Req Total
                if(bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c >= r.Total_Cost_Tax__c) {
                    bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c -= r.Total_Cost_Tax__c;
                }
                //Add updated BLIs to updatebli to be mass updated below 
                updatebli.add(bliMap.get(conBli.get(r.Id)));                          
            }               
        }
        //Update OLIs
        if (updateproj.size() > 0){
            approveELI.IsOpportunityLineItemUpdating=true;        
            update updateproj;
            approveELI.IsOpportunityLineItemUpdating=false;            
        }
        //Update BLIs
        if (updatebli.size() > 0){
            update updatebli;
        }
        /*
        if(newPP.size() > 0){
            insert newPP;
        }
        */
    }
    /***** End Purchase Order *****/
    
    /***** Begin Add Pending Amount *****/     
    public static void addPending(Con_Req__c[] reqs){
                
        Map<Id, Budget_Line_Item__c> bliMap = new Map<Id, Budget_Line_Item__c>();
        Map<Id, Id> conBli = new Map<Id, Id>();
        List<Id> reqID = new List<Id>();
        Con_Req__c[] req = [SELECT Id, Budget_Line_Item__c FROM Con_Req__c WHERE Id in :reqs];
        for (Integer i = 0; i <req.size(); i++) {
            reqID.add(req[i].Budget_Line_Item__c);
            conBli.put(req[i].Id, req[i].Budget_Line_Item__c);
        }
        List<Budget_Line_Item__c> bli;
        
        If(reqID.size()>0){
         bli= [select Id, Pending_PO_Total__c from Budget_Line_Item__c where Id in :reqID];
         }
         
         If (bli!=null)
        for (Integer i = 0; i <bli.size(); i++) {
            bliMap.put(bli[i].Id, bli[i]);
        }
        
        List<Budget_Line_Item__c> updatebli = new List<Budget_Line_Item__c>();
        for (Con_Req__c r:reqs){
            if(bliMap.ContainsKey(conBli.get(r.Id))){
                if(bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c == null) {
                    bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c = 0;       
                } 
            
            
            bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c += r.Total_Cost_Tax__c;
            updatebli.add(bliMap.get(conBli.get(r.Id)));          
          }          
        }
        if (updatebli.size() > 0){
            update updatebli;
        }
    }
    /***** End Add Pending Amount *****/
    
    /***** Begin Remove Pending Amount *****/
    public static void removePending(Con_Req__c[] reqs){
                
        Map<Id, Budget_Line_Item__c> bliMap = new Map<Id, Budget_Line_Item__c>();
        Map<Id, Id> conBli = new Map<Id, Id>();
        List<Id> reqID = new List<Id>();
        Con_Req__c[] req = [SELECT Id, Budget_Line_Item__c FROM Con_Req__c WHERE Id in :reqs];
        for (Integer i = 0; i <req.size(); i++) {
            if (req[i].Budget_Line_Item__c != null) {
                reqID.add(req[i].Budget_Line_Item__c);
                conBli.put(req[i].Id, req[i].Budget_Line_Item__c);
            }
        }
        
        if (reqID.size() > 0) {
            Budget_Line_Item__c[] bli = [select Id, Pending_PO_Total__c, PO_Total__c from Budget_Line_Item__c where Id in :reqID];
            for (Integer i = 0; i <bli.size(); i++) {
                bliMap.put(bli[i].Id, bli[i]);
            }
        
            List<Budget_Line_Item__c> updatebli = new List<Budget_Line_Item__c>();
            for (Con_Req__c r:reqs){
                //Check that Pending is greater than Req Total, subtract Req Total
                if(bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c >= r.Total_Cost_Tax__c) {
                    bliMap.get(conBli.get(r.Id)).Pending_PO_Total__c -= r.Total_Cost_Tax__c;
                }
                updatebli.add(bliMap.get(conBli.get(r.Id)));                    
            }
            if (updatebli.size() > 0){
                update updatebli;
            }
        }
    }
    /***** End Remove Pending Amount *****/
    
    /***** Begin Test Method *****/
    public static testMethod void POTest(){
        ProjectTest.FieldUpdate();
    }
    /***** End Test Method *****/
}