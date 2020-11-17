public class conPO {
    public static void updatePrice(Map<Id, Con_PO__c> pos) {        
        Map<Id, Con_Req__c> reqs = new Map<Id, Con_Req__c>();   //Map of PO Ids and Requisitions
        Map<Id, Budget_Line_Item__c> blis = new Map<Id, Budget_Line_Item__c>(); //Map of BLIs
        List<Id> reqBli = new List<Id>();   //List of BLIs from Reqs
        List<Budget_Line_Item__c> lines = new List<Budget_Line_Item__c>();  //List of BLIs
        List<Id> svId = new List<Id>(); //List of SV from Reqs
        Map<Id, SV__c> svs = new Map<Id, SV__c>();  //Map of SVs
        Map<Id, Id> reqSV = new Map<Id, Id>();
        List<SV__c> visits = new List<SV__c>();
        
        //Query Reqs, put PO ID and Req in reqs map, add Req BLI to reqBLI list
        Con_Req__c[] req = [select Budget_Line_Item__c, Purchase_Order__c, Service_Visit__c from Con_Req__c where Purchase_Order__c in :pos.keySet()];
        for (Integer i = 0; i <req.size(); i++) {
            reqs.put(req[i].Purchase_Order__c, req[i]);
            reqBli.add(req[i].Budget_Line_Item__c);
            svId.add(req[i].Service_Visit__c);
            reqSV.put(req[i].Id, req[i].Service_Visit__c);
        }
        //Query BLIs from reqBli list to get PO_Total, put BLIs in blis Map
        List<Budget_Line_Item__c> bli = new List<Budget_Line_Item__c>();
        if(reqBli.size() > 0){      
            bli = [select Id, PO_Total__c from Budget_Line_Item__c where Id in :reqBli];
            for (Integer i = 0; i <bli.size(); i++) {
                blis.put(bli[i].Id, bli[i]); 
            }
        }
        List<SV__c> sv = new List<SV__c>();
        if(svId.size() > 0){
            sv = [select Id, Cost__c from SV__c where Id in :svId];
            for (Integer i = 0; i <sv.size(); i++) {
                svs.put(sv[i].Id, sv[i]);
            }
        }
        //Query POs in map passed from Trigger for Total Cost Change
        Con_PO__c[] p = [select Id, Total_Cost_Change__c from Con_PO__c where Id in :pos.keySet()];
        if(bli.size()> 0){
        //Loop through POs
            for (Integer i = 0; i <p.size(); i++) {
            //Loop through BLIs
                for (Integer m = 0; m <bli.size(); m++) {
                    //If number of POs equals number of BLIs, POs and BLIs are one to one. (PO-Req-BLI not PO-Reqs-BLI)
                    if (i == m) {
                        //Add Total Cost Change to BLI PO Total and add BLI to lines list
                        if(blis.get(reqs.get(p[i].Id).Budget_Line_Item__c).PO_Total__c == null){
                            blis.get(reqs.get(p[i].Id).Budget_Line_Item__c).PO_Total__c = 0.0;
                        } 
                        blis.get(reqs.get(p[i].Id).Budget_Line_Item__c).PO_Total__c += pos.get(p[i].Id).Total_Cost_Change__c;
                        lines.add(blis.get(reqs.get(p[i].Id).Budget_Line_Item__c));
                    //If number of POs not equal to BLIs, BLI will loop through multiple times. 
                    } else {
                        //Add Total Cost Change to BLI PO Total then set the value of that BLI in lines list.
                        blis.get(reqs.get(p[i].Id).Budget_Line_Item__c).PO_Total__c += pos.get(p[i].Id).Total_Cost_Change__c;
                        lines.set(m, blis.get(reqs.get(p[i].Id).Budget_Line_Item__c));
                    }
                }
            }
        }   
        if(sv.size()>0){
            for (Integer i = 0; i <p.size(); i++) {
                for (Integer m = 0; m <sv.size(); m++) {
                    //If number of POs equals number of BLIs, POs and BLIs are one to one. (PO-Req-BLI not PO-Reqs-BLI)
                    if (i == m) {
                        //Add Total Cost Change to BLI PO Total and add BLI to lines list
                        if(svs.get(reqs.get(p[i].Id).Service_Visit__c).Cost__c == null) {
                            svs.get(reqs.get(p[i].Id).Service_Visit__c).Cost__c = 0.00;
                        }
                        svs.get(reqs.get(p[i].Id).Service_Visit__c).Cost__c += pos.get(p[i].Id).Total_Cost_Change__c;
                        visits.add(svs.get(reqs.get(p[i].Id).Service_Visit__c));
                    //If number of POs not equal to BLIs, BLI will loop through multiple times. 
                    } else {
                        //Add Total Cost Change to BLI PO Total then set the value of that BLI in lines list.
                        svs.get(reqs.get(p[i].Id).Service_Visit__c).Cost__c += pos.get(p[i].Id).Total_Cost_Change__c;
                        visits.set(m, svs.get(reqs.get(p[i].Id).Service_Visit__c));
                    }
                }
            }
        }
        //Update BLIs
        if(lines.size() > 0) {
            update lines; 
        }
        if(visits.size() > 0) {
            update visits; 
        }
    }
    public static void upQTY(Con_PO__c[] po){
        List<Id> poID = new List<Id>();
        List<Id> poProd = new List<Id>();
        for(Integer i = 0; i<po.size(); i++){
            poID.add(po[i].Id);
            poProd.add(po[i].Product__c);
        }
        List<Id> project = new List<Id>();
        List<Id> opp = new List<Id>();
        Map<Id, Con_Req__c> poReq = new Map<Id, Con_Req__c>();
        Map<Id, Id> reqProjOpp = new Map<Id, Id>();
        List<OpportunityLineItem> oli = new List<OpportunityLineItem>();
        Map<Id, List<OpportunityLineItem>> opLine = new Map<Id, List<OpportunityLineItem>>();
        Map<Id, Id> poEntry = new Map<Id, Id>();
        
        Con_Req__c[] cr = [select Purchase_Order__c, ASProject__c, Quantity__c, Service_Visit__c from Con_Req__c where Purchase_Order__c in :poID];
        for(Integer i = 0; i<cr.size(); i++){
            poReq.put(cr[i].Purchase_Order__c, cr[i]);
            project.add(cr[i].ASProject__c);
        } 
        AcctSeed__Project__c[] proj = [select AcctSeed__Opportunity__c, Id from AcctSeed__Project__c where Id in :project];
        for(Integer i = 0; i<proj.size(); i++){
            reqProjOpp.put(proj[i].Id, proj[i].AcctSeed__Opportunity__c);
            opp.add(proj[i].AcctSeed__Opportunity__c);
        }
        Opportunity[] opps = [select o.Id, (select OpportunityId, PricebookEntryId, Qty_Requested__c from OpportunityLineItems) from Opportunity o 
                                        where o.Id in :opp];
        for(Integer i = 0; i<opps.size(); i++){
            opLine.put(opps[i].Id, opps[i].OpportunityLineItems);
        }
        PricebookEntry[] pbe = [select Product2Id, Id from PricebookEntry  where Product2Id in :poProd];
        for(Integer i = 0; i<pbe.size(); i++){
            poEntry.put(pbe[i].Id, pbe[i].Id);
        }
        Map<Id, OpportunityLineItem> upOLI = new Map<Id, OpportunityLineItem>();
        for(Integer i = 0; i<po.size(); i++){
            if(poReq!=null && poReq.ContainsKey(po[i].Id) && poReq.get(po[i].Id).Service_Visit__c == null){
                Double requested = 0;           
                List<OpportunityLineItem> nOLI = opLine.get(reqProjOpp.get(poReq.get(po[i].Id).ASProject__c));
                for(Integer m = 0; m<nOLI.size(); m++){
                    requested = po[i].Quantity__c - poReq.get(po[i].Id).Quantity__c;
                    if(poEntry.get(nOLI[m].PricebookEntryId) != null){
                    
                        if(nOLI[m].Qty_Requested__c!=null)
                            nOLI[m].Qty_Requested__c += requested;
                        else
                            nOLI[m].Qty_Requested__c = requested;
                            
                        upOLI.put(nOLI[m].Id, nOLI[m]);
                    }
                }
            }
        }
        if(upOLI.size() > 0){
           approveELI.IsOpportunityLineItemUpdating=true;   
            update upOLI.values();
           approveELI.IsOpportunityLineItemUpdating=false;               
        }                               
    }  
    public static testMethod void conPOTest(){
    
    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert acc;
    AcctSeed__Project__c p = ProjectTest.setupTestProj();
    Contract con = new Contract(AccountId = acc.Id); insert con; 
    SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;
    
   // Budget__c budget = new Budget__c(ASProject__c = p.Id);  insert budget; 
   // Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Pending_PO_Total__c = 0.0); insert bli;
    
    List<RecordType> LR=[select Id,Name from RecordType where Name IN ('Major Component PO','Subcontractor PO')];
    
    RecordType major,SubContractorPO;
    
    IF(LR!=Null && LR.Size()>0){
        For(RecordType RT:LR){
            if(RT.Name=='Major Component PO')
                major=RT;
            else if(RT.Name=='Subcontractor PO')
                SubContractorPO=RT;
        }
    }
    
    Product2 ProdMake;
    User bh = [select Id from User where Name = 'Bradley Hibberd'];
    System.runAs(bh){
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
    }
    TEST.starttest();
    Con_PO__c po = new Con_PO__c(Unit_Price__c = 10.00,Recordtypeid=SubContractorPO.id); insert po;
    Con_PO__c po2 = new Con_PO__c(Unit_Price__c = 10.00,Recordtypeid=SubContractorPO.id); insert po2;
    Con_Req__c[] req = new Con_Req__c[1];
/*    req.add(new Con_Req__c(Service_Visit__c = sv.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00,Purchase_Order__c = po.Id,  
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Tax_Rate__c = 7.25, Product__c = ProdMake.Id)); 
    req.add(new Con_Req__c(Project__c = p.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Purchase_Order__c = po2.Id, 
                                Unit_Price__c = 30, Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Tax_Rate__c = 7.25));*/
  
   req[0]=new Con_Req__c(Service_Visit__c = sv.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Purchase_Order__c = po.Id, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Tax_Rate__c = 7.25, Product__c = ProdMake.Id); 
//    req[1]=new Con_Req__c(ASProject__c = p.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Purchase_Order__c = po2.Id, 
 //                               Unit_Price__c = 30, Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Tax_Rate__c = 7.25);
  
  
    insert req;                                                     
    po.Unit_Price__c = 12.00; update po;
    po2.Unit_Price__c = 12.00; update po2;
    	test.stoptest();
    }
    
    public static testMethod void conPOTest2(){
    	
    Account acc = new Account(Name = 'Knight - 2456',Type = 'Customers',Job_Type__c = 'Residential',Branch__c = 'Berkeley', 
                                     Project_End_Date__c = null, ShippingCity = 'Park City'); insert acc;
    AcctSeed__Project__c p = ProjectTest.setupTestProj();
    Contract con = new Contract(AccountId = acc.Id); insert con; 
    SV__c sv = new SV__c(Contract__c = con.Id, Visit_Date__c = System.Today(), Cost__c = 10.00); insert sv;
    
    //Budget__c budget = new Budget__c(ASProject__c = p.Id);  insert budget; 
    //Budget_Line_Item__c bli = new Budget_Line_Item__c(Budget__c = budget.Id, Pending_PO_Total__c = 0.0); insert bli;
    
    List<RecordType> LR=[select Id,Name from RecordType where Name IN ('Major Component PO','Subcontractor PO')];
    
    RecordType major,SubContractorPO;
    
    IF(LR!=Null && LR.Size()>0){
        For(RecordType RT:LR){
            if(RT.Name=='Major Component PO')
                major=RT;
            else if(RT.Name=='Subcontractor PO')
                SubContractorPO=RT;
        }
    }
    
    Product2 ProdMake;
    User bh = [select Id from User where Name = 'Bradley Hibberd'];
    System.runAs(bh){
        ProdMake = new Product2(Name = 'Sharp 170', Manufacturer__c = 'Sharp', Family = 'Solar Modules', 
                                        Cost__c = 15, IsActive = true, Status__c = 'Approved for Sale'); insert ProdMake;
    }
    TEST.starttest();
    Con_PO__c po = new Con_PO__c(Unit_Price__c = 10.00,Recordtypeid=SubContractorPO.id); insert po;
    Con_PO__c po2 = new Con_PO__c(Unit_Price__c = 10.00,Recordtypeid=SubContractorPO.id); insert po2;
    Con_Req__c[] req = new Con_Req__c[1];
/*    req.add(new Con_Req__c(Service_Visit__c = sv.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00,Purchase_Order__c = po.Id,  
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Tax_Rate__c = 7.25, Product__c = ProdMake.Id)); 
    req.add(new Con_Req__c(Project__c = p.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Purchase_Order__c = po2.Id, 
                                Unit_Price__c = 30, Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Tax_Rate__c = 7.25));*/
  
   req[0]=new Con_Req__c(Service_Visit__c = sv.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Purchase_Order__c = po.Id, 
                                Unit_Price__c = 30, Date_Needed__c = System.Today(), Tax_Rate__c = 7.25, Product__c = ProdMake.Id); 
   // req[1]=new Con_Req__c(ASProject__c = p.Id, Vendor_Account__c = acc.Id, Quantity__c = 10.00, Purchase_Order__c = po2.Id, 
    //                            Unit_Price__c = 30, Budget_Line_Item__c = bli.Id, Date_Needed__c = System.Today(), Tax_Rate__c = 7.25);
  
  
    insert req;                                                     
    
    po2.RecordTypeId = major.Id;
    po2.Quantity__c = 12.00;
    update po2;
    TEST.stoptest();
    }
}