public with sharing class ConReqGroupControllerExt {
    
    /*
     *  Methods to allow creating and editing a group of Sales Order Line records
     *  that are all associated with the same Con Req Group record and Project record.
     *
     */
    
    ApexPages.StandardController stdController;
    private final Con_Req_Group__c crg;
    private final AcctSeedERP__Sales_Order_Line__c cr;
    private Map<String, Id> solRtMap;
    public Con_Req_Group__c crGroup {get; set;}
    public List<ConReqLineWrapper> crLineList {get; set;}
    public Boolean noSalesOrderLines {get; set;}
    public Boolean selectRecordTypeLine {get; set;}
    public Boolean editGrp {get; set;}
    public Boolean editReqLine {get; set;}
    public Boolean addReqLine {get; set;}
    public Boolean editAllReqs {get; set;}
    public Boolean viewAllReqs {get; set;}
    public Boolean modifyAll {get; set;}
    public Boolean isServiceVisit {get; set;}
    List<Project_Products__c> productList = new List<Project_Products__c>();
    
    public ConReqGroupControllerExt(ApexPages.StandardController stdController) {
        
        this.crg = (Con_Req_Group__c)stdController.getRecord();
        noSalesOrderLines = false;
        selectRecordTypeLine = false;
        editGrp = false;
        editReqLine = false;
        addReqLine = false;
        editAllReqs = false;
        viewAllReqs = false;
        modifyAll = false;
        isServiceVisit = false;
        crGroup = new Con_Req_Group__c();
        
        if (this.crg.Id == null) {
            // Means we are being called to create a new Con Req Group record
            // TODO - do we need to handle creating new Con Req Group records here?
            
        } else {
            
            // Read in all fields of the Con Req Group record and the Sales Order Line records 
            // associated with the Con Req Group record
            getConReqGroup();
            getConReqLines();
            
            Map<Id, Schema.RecordTypeInfo> rtCRGMap = Schema.SObjectType.Con_Req_Group__c.getRecordTypeInfosById();
            if (rtCRGMap.containsKey(crGroup.RecordTypeId) && rtCRGMap.get(crGroup.RecordTypeId).getName() == 'Service Visit') {
                isServiceVisit = true;
            }
            
            // Initialize the set of Products that are associated with the Project
            productList = [select Id, Project__c, Product__c, Product__r.Name,Quantity__c,Product__r.Description,Product_NameDescription__c  from Project_Products__c where Project__c = :crGroup.Project__c];
            system.debug('Look Here' +crLineList);
            for (ConReqLineWrapper crl :crLineList) {
                if (crl.crLine.Opportunity_Product__c == null) {
                    crl.crLine.Opportunity_Product__c = '';
                }
                if (crl.crLine.Opportunity_Product__c != '') {
                    Boolean inList = false;
                    for (Project_Products__c pp :productList) {
                        if (crl.crLine.Opportunity_Product__c == pp.Product__c) {
                            inList = true;
                        }
                    }
                    if (!inList) {
                        crl.crLine.Opportunity_Product__c = '';
                    }
                }
            }
            
            // Get the Sales Order Line record types available to the user.  Ignore the Master record type
            // unless that is the only record type available to the user.
            solRtMap = new Map<String, Id>();
            List<RecordTypeInfo> solRtInfos = AcctSeedERP__Sales_Order_Line__c.SObjectType.getDescribe().getRecordTypeInfos();
            if (solRtInfos.size() > 1) {
                for (RecordTypeInfo rti :solRtInfos) {
                    if (rti.isAvailable() && rti.getName() != 'Master') {
                        solRtMap.put(rti.getName(), rti.getRecordTypeId());
                    }
                }
            } else {
                solRtMap.put(solRtInfos[0].getName(), solRtInfos[0].getRecordTypeId());
            }
        }
        
        ObjectPermissions objPerm = [select Id, SobjectType, PermissionsModifyAllRecords from ObjectPermissions 
                where SObjectType = 'Con_Req_Group__c' and ParentId in (select Id from PermissionSet where PermissionSet.ProfileId = :UserInfo.getProfileId())];
        if (objPerm.PermissionsModifyAllRecords) {
            modifyAll = true;
        }
    }
    
    private void getConReqGroup() {
        
        // Read in all fields of the Con Req Group record
        String selects;
        Map<String, Schema.SObjectField> fMap;
        List<string> selectFields;
        fMap = Schema.getGlobalDescribe().get('Con_Req_Group__c').getDescribe().Fields.getMap();
        selectFields = new List<string>();
        if (fMap != null) {
            for (Schema.SObjectField ft : fMap.values()) {
                Schema.DescribeFieldResult fd = ft.getDescribe();
                selectFields.add(fd.getName());
            }
        }
        selects = 'CreatedBy.Name,LastModifiedBy.Name,';
        if (!selectFields.isEmpty()) {
            for (string s:selectFields) {
                selects += s + ',';
            }
            if (selects.endsWith(',')) {
                selects = selects.substring(0,selects.lastIndexOf(','));
            }
        }
        
        system.debug('*****con req group field list = ' + selects);
        
        crGroup = (Con_Req_Group__c)Database.query('SELECT ' + selects + ' FROM Con_Req_Group__c WHERE Id = \'' + this.crg.Id + '\'');
    }
    
    private String getsolLineFields() {
        
        // Return the string of all fields of the Construction Requisition records
        String selects;
        Map<String, Schema.SObjectField> fMap;
        List<string> selectFields;
        fMap = Schema.getGlobalDescribe().get('AcctSeedERP__Sales_Order_Line__c').getDescribe().Fields.getMap();
        selectFields = new List<string>();
        if (fMap != null) {
            for (Schema.SObjectField ft : fMap.values()) {
                Schema.DescribeFieldResult fd = ft.getDescribe();
                selectFields.add(fd.getName());
            }
        }
        selects = 'CreatedBy.Name,LastModifiedBy.Name,';
        if (!selectFields.isEmpty()) {
            for (string s:selectFields) {
                selects += s + ',';
            }
            if (selects.endsWith(',')) {
                selects = selects.substring(0,selects.lastIndexOf(','));
            }
        }
        
        system.debug('*****solList field list = ' + selects);
        return (selects);
    }
    
    private void getConReqLines() {
        
        // Read in all fields of the Construction Requisition records associated with the Con Req Group
        List<AcctSeedERP__Sales_Order_Line__c> solList = (List<AcctSeedERP__Sales_Order_Line__c>)Database.query('SELECT ' + getsolLineFields() + ' FROM AcctSeedERP__Sales_Order_Line__c WHERE Con_Req_Group__c = \'' + this.crg.Id + '\' ORDER BY Name DESC');
        
        // If there are no Sales Order Lines, set flag so that we don't attempt to display any
        //solList = new List<AcctSeedERP__Sales_Order_Line__c>();
        crLineList = new List<ConReqLineWrapper>();
        if (solList.isEmpty()) {
            noSalesOrderLines = true;
        } else {
            for (AcctSeedERP__Sales_Order_Line__c sol :solList) {
                crLineList.add(new ConReqLineWrapper(sol, true, true));
            }
        }
        
        system.debug('*****solList.size() = ' + solList.size() + ' noSalesOrderLines = ' + noSalesOrderLines + ' editGrp = ' + editGrp);
    }
    
    public List<SelectOption> getsolRecordTypes() {
        List<SelectOption> options = new List<SelectOption>();
        Set<String> Names = new Set<String>();
        
        Names = solRtMap.keySet();
        for (String n :Names) {
            options.add(new SelectOption(solRtMap.get(n), n));
        }
        
        system.debug('*****getsolRecordTypes options.size() = ' + options.size());
        return options;
    }
    
    String solRTSelected = null;
    public String getsolRTSelected() {
        system.debug('*****getsolRTSelected solRTSelected = ' + solRTSelected);
        return solRTSelected;
    }
    
    public void setsolRTSelected(String RTSelected) {
        solRTSelected = RTSelected;
        system.debug('*****setsolRTSelected solRTSelected = ' + solRTSelected);
    }
    
    public PageReference editGroup() {
        editGrp = true;
        return null;
    }
    
    // Submit Con Req Group for approval
    public PageReference submitGroup() {
        
        // First verify that none of the Con Req lines have a negative Remaining Available Budget
        Boolean okToSubmit = true;
        getConReqLines();
        for (ConReqLineWrapper crlw :crLineList) {
            if (crlw.crLine.Remaining_Available_Budget__c != null && crlw.crLine.Remaining_Available_Budget__c < 0) {
                okToSubmit = false;
            }
        }
        
        if (okToSubmit) {
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Con Req Group submit for approval.');
            req.setObjectId(crGroup.Id);
            //req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            try {
                Approval.ProcessResult result = Approval.process(req);
                getConReqGroup();
                getConReqLines();
            } catch (Exception e) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
        } else {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Cannot submit for approval when one or more Construction Requisitions have a negative Remaining Available Budget.'));
        }
        return null;
    }
    
    public PageReference clearLock() {
        PageReference pr = null;
        try {
            crGroup.IsLocked__c = false;
            update crGroup;
            pr = new PageReference('/' + crGroup.Id);
        } catch (Exception e) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
        return pr;
    }
    
    public PageReference recallApproved() {
        
        // recall an already approved Con Req Group
        String errMsg = null;
        
        if (crGroup.Status__c == 'Approved') {
            if (!noSalesOrderLines) {
                
                List<Id> solIds = new List<Id>();
                List<Id> polIds = new List<Id>();
                for (ConReqLineWrapper crlw :crLineList) {
                    solIds.add(crlw.crline.Id);
                    polIds.add(crlw.crLine.AcctSeedERP__Purchase_Order_Line__c);
                }
                List<AcctSeedERP__Purchase_Order_Line__c> polList = new List<AcctSeedERP__Purchase_Order_Line__c>();
                polList = [select Id, AcctSeedERP__Unit_Price__c, Construction_Req__c, AcctSeedERP__Purchase_Order__c, PO_Line_Status__c 
                            from AcctSeedERP__Purchase_Order_Line__c where Id in :polIds or Construction_Req__c in :solIds];
                
                /*
                // Added By Madan - July 28, 2017(Validate related SOL)
                Map<Id,AcctSeedERP__Purchase_Order_Line__c> mapPOL = new Map<Id,AcctSeedERP__Purchase_Order_Line__c>(polList);
                for(ConReqLineWrapper wrap:crLineList) {
                    if(wrap.crLine.AcctSeedERP__Purchase_Order_Line__c != null && 
                            mapPOL.containsKey(wrap.crLine.AcctSeedERP__Purchase_Order_Line__c)) {
                        String status = mapPOL.get(wrap.crLine.AcctSeedERP__Purchase_Order_Line__c).PO_Line_Status__c;
                        if(status != 'Cancelled' || status != 'Rejected') {
                            errMsg = 'Can\'t recall an approved Con Req Group unless all related Purchase Orders are either Cancelled or Rejected.';
                        }
                        
                    }
                }
                */
                
                System.debug('========================errMsg1: ' + errMsg);
                //if (polList.size() == crLineList.size()) {
                    List<Id> poIds = new List<Id>();
                    for (AcctSeedERP__Purchase_Order_Line__c pol :polList) {
                        poIds.add(pol.AcctSeedERP__Purchase_Order__c);
                    }
                    List<AcctSeedERP__Purchase_Order__c> poList = new List<AcctSeedERP__Purchase_Order__c>();
                    poList = [select Id, AcctSeedERP__Status__c FROM AcctSeedERP__Purchase_Order__c WHERE Id in :poIds];
                    Boolean wrongStatus = false;
                    for (AcctSeedERP__Purchase_Order__c po :poList) {
                        if (po.AcctSeedERP__Status__c != 'Cancelled' && po.AcctSeedERP__Status__c != 'Rejected') {
                            wrongStatus = true;
                        }
                    }
                    
                    System.debug('========================errMsg2: ' + errMsg);
                    System.debug('========================wrongStatus: ' + wrongStatus);
                    if (!wrongStatus) {
                        try {
                            System.debug('========================wrongStatus: ' + wrongStatus);
                            crGroup.Status__c = 'Recalled';
                            crGroup.IsLocked__c = false;
                            update crGroup;
                            getConReqGroup();
                            getConReqLines();
                        } catch (Exception e) {
                            errMsg = e.getMessage();
                        }
                        System.debug('========================errMsg3: ' + errMsg);
                    } else {
                        errMsg = 'Can\'t recall an approved Con Req Group unless all related Purchase Orders are either Cancelled or Rejected.';
                    }
                /*} else {
                    errMsg = 'Can\'t recall an approved Con Req Group unless each related Construction Requisition has a Purchase Order Line.';
                }*/
            } else {
                errMsg = 'Can\'t recall an approved Con Req Group without Construction Requisitions.';
            }
        } else {
            errMsg = 'Can only recall an approved Con Req Group.';
        }
        
        System.debug('========================errMsg4: ' + errMsg);
        if (errMsg != null) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, errMsg));
        }
        
        return null;
    }
    
    public PageReference saveGroup() {
        
        // Make sure the record is not locked
        if (!crGroup.IsLocked__c) {
            // Save the edited Con Req Group record.
            try {
                update crGroup;
                editGrp = false;
                getConReqGroup();
                getConReqLines();
            } catch(Exception e) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            }
        } else {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Record is locked - cannot change a locked record.'));
        }
        
        return null;
    }
    
    public PageReference cancelGroup() {
        editGrp = false;
        getConReqGroup();
        return null;
    }
    
    // Populate and return the drop-down list of Project Products
    public List<SelectOption> getProjProducts() {
    //Integer qty;
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('', '--None--'));
        for (Project_Products__c pr :productList) {
        System.debug('Look Here' +pr.Product__r.Name);
          
            if( (pr.Product__r.Name != 'Turnkey Installation Services') && (pr.Product__r.Name=='Miscellaneous' || pr.Product__r.Name=='Electrical Material'))
            
             
            //qty = (Integer)pr.Quantity__c;
            //if(pr.Product__r.Name=='Miscellaneous' ||pr.Product__r.Name=='Electrical Material')
            {
            System.debug('Look Here1');
                options.add(new SelectOption( pr.Product__c,pr.Product_NameDescription__c));
            }
            
            
             else 
             
             
            {
            if(pr.Product__r.Name != 'Turnkey Installation Services')
            {
            System.debug('Look Here2');
                options.add(new SelectOption(pr.Product__c, pr.Product__r.Name));
            }
        }
        }
        return options;
    }
    
    public PageReference detailAllSolLines() {
        
        viewAllReqs = true;
        for (ConReqLineWrapper crlw :crLineList) {
            crlw.isSummary = false;
            crlw.isDetail = true;
            crlw.cancelState = 'Summary';
        }
        return null;
    }
    
    public PageReference editAllSolLines() {
        
        editAllReqs = true;
        viewAllReqs = false;
        for (ConReqLineWrapper crlw :crLineList) {
            crlw.isSummary = false;
            crlw.isDetail = false;
            crlw.cancelState = 'Summary';
        }
        return null;
    }
    
    public PageReference saveAllSolLines() {
        PageReference pr = null;
        Boolean productError = false;
        
        for (ConReqLineWrapper crlw :crLineList) {
            crlw.isProductError = false;
            if (crlw.isMajorComponent ) {
                if (crlw.crLine.Opportunity_Product__c == NULL || crlw.crLine.Opportunity_Product__c == '') {
                    productError = true;
                    crlw.isProductError = true;
                } else {
                    // Take the product selected from the dynamic Project Product pick list and set the Product field
                    crlw.crLine.AcctSeedERP__Product__c = crlw.crLine.Opportunity_Product__c;
                }
            }
            if (crlw.isMinorComponent ) {
                if (crlw.crLine.Opportunity_Product__c == NULL || crlw.crLine.Opportunity_Product__c == '') {
                    productError = true;
                    crlw.isProductError = true;
                } else {
                    // Take the product selected from the dynamic Project Product pick list and set the Product field
                    crlw.crLine.AcctSeedERP__Product__c = crlw.crLine.Opportunity_Product__c;
                }
            }
        }
        
        if (productError) {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Invalid Data. Review all error messages below to correct your data.'));
            
        } else {
            
            List<AcctSeedERP__Sales_Order_Line__c> solUpList = new List<AcctSeedERP__Sales_Order_Line__c>();
            for (ConReqLineWrapper crlw :crLineList) {
                solUpList.add(crlw.crLine);
               
            }
            system.debug('SOLLIST' +solUpList);
            if (!solUpList.isEmpty()) {
                try {
                    update solUpList;
                    editAllReqs = false;
                    viewAllReqs = false;
                    if (!editGrp) {
                        getConReqGroup();
                    }
                    getConReqLines();
                } catch(Exception e) {
                    system.debug('Con Req Group Save All Lines Exception = ' + e.getMessage());
                }
            }
        }
        return pr;
    }
    
    public PageReference cancelAllSolLines() {
        
        editAllReqs = false;
        viewAllReqs = false;
        addReqLine = false;
        getConReqLines();
        return null;
    }
    
    public PageReference detailSolLine() {
        Id solId = ApexPages.currentPage().getParameters().get('solId');
        system.debug('*****detailSolLine solId = ' + solId);
        
        PageReference pr = new PageReference('/' + solId);
        return pr;
    }
    
    public PageReference editSolLine() {
        Id solId = ApexPages.currentPage().getParameters().get('solId');
        system.debug('*****editSolLine solId = ' + solId);
        
        PageReference pr = new PageReference('/' + solId + '/e?retURL=/' + crGroup.Id);
        return pr;
    }
    
    public String deleteSolId {get; set;}
    
    public PageReference deleteSolLine() {
        AcctSeedERP__Sales_Order_Line__c delConReq = new AcctSeedERP__Sales_Order_Line__c();
        system.debug('*****deleteSolLine deleteSolId = ' + deleteSolId);
        delConReq.Id = deleteSolId;
        try {
            delete delConReq;
            if (!editGrp) {
                getConReqGroup();
            }
            getConReqLines();
        } catch(Exception e) {
            system.debug('Con Req Group Delete Line Exception = ' + e.getMessage());
        }
        
        // Force a reload of the entire page - works around a line table refresh problem when using apex:actionFunction
        PageReference pr = new PageReference('/' + crGroup.Id);
        return pr;
    }
    
    public PageReference cloneSolLine() {
        Id cloneSolId = ApexPages.currentPage().getParameters().get('solId');
        AcctSeedERP__Sales_Order_Line__c newConReq = new AcctSeedERP__Sales_Order_Line__c();
        system.debug('*****cloneSolLine cloneSolId = ' + cloneSolId);
        
        PageReference pr = new PageReference('/' + cloneSolId + '/e?clone=1&retURL=/' + crGroup.Id);
        return pr;
    }
    
    public PageReference addSolLine() {
        
        Map<String, Schema.RecordTypeInfo> rtSOLMap = Schema.SObjectType.AcctSeedERP__Sales_Order_Line__c.getRecordTypeInfosByName();
        if (isServiceVisit && rtSOLMap.containsKey('Service')) {
            solRTSelected = rtSOLMap.get('Service').getRecordTypeId();
            selectSolRecordType();
        } else {
            selectRecordTypeLine = true;
        }
        
        addReqLine = true;
        return null;
    }
    
    public PageReference selectSolRecordType() {
        
        // Construction Requisition record type was just selected, initialize a new Construction
        // Requisition record and serve it up for editing
        selectRecordTypeLine = false;
        
        Map<Id, Schema.RecordTypeInfo> rtSOLMap = Schema.SObjectType.AcctSeedERP__Sales_Order_Line__c.getRecordTypeInfosById();
        Id defaultProductId = null;
        if (rtSOLMap.containsKey(solRTSelected) && rtSOLMap.get(solRTSelected).getName() == 'Service') {
            List<Product2> pList = new List<Product2>();
            pList = [select Id, Name from Product2 where Name = 'Miscellaneous'];
            if (!pList.isEmpty()) {
                defaultProductId = pList[0].Id;
            }
        }
        
        // Adding a new Construction Requisition, first initialize the fields from the Con Req Group record
        AcctSeedERP__Sales_Order_Line__c newConReq = new AcctSeedERP__Sales_Order_Line__c();
        newConReq.RecordTypeId = solRTSelected;
        newConReq.AcctSeedERP__Product__c = defaultProductId;
        newConReq.Ship_to_Account__c = crGroup.Ship_to_Account__c;
        newConReq.Status__c = crGroup.Status__c;
        newConReq.Vendor__c = crGroup.Vendor__c;
        newConReq.Vendor_Contact__c = crGroup.Vendor_Contact__c;
        newConReq.Requested_Delivery_Date__c = crGroup.Requested_Delivery_Date__c;
        newConReq.AcctSeedERP__Project__c = crGroup.Project__c;
        newConReq.AcctSeedERP__Sales_Order__c = crGroup.Sales_Order__c;
        newConReq.Project_PM__c = crGroup.Project_PM__c;
        newConReq.Con_Req_Group__c = crGroup.Id;
        
        if (noSalesOrderLines) {
            
            // This is the first Construction Requisition of the group
            noSalesOrderLines = false;
            crLineList.add(new ConReqLineWrapper(newConReq, false, false));
            
        } else {
            
            // Add the new Construction Requisition to the list in the first position
            List<ConReqLineWrapper> tempLineList = new List<ConReqLineWrapper>();
            tempLineList.addAll(crLineList);
            crLineList.clear();
            crLineList.add(new ConReqLineWrapper(newConReq, false, false));
            crLineList.addAll(tempLineList);
        }
        
        return null;
    }
    
    public PageReference cancelSolRecordType() {
        selectRecordTypeLine = false;
        addReqLine = false;
        return null;
    }
    
    public PageReference saveSolLine() {
        PageReference pr = null;
        String solId = ApexPages.currentPage().getParameters().get('solId');
        system.debug('*****saveSolLine solId = ' + solId);
        
        String savedSolId = saveLine(solId);
        
        // Set up return display req line
        if (savedSolId != null) {
            if (solId == null || solId == '') {
                addReqLine = false;
            }
            for (ConReqLineWrapper crlw :crLineList) {
                if (crlw.crLine.Id == savedSolId) {
                    crlw.isSummary = false;
                    crlw.cancelState = 'Summary';
                    crlw.isDetail = true;
                    crlw.crLine = Database.query('SELECT ' + getsolLineFields() + ' FROM AcctSeedERP__Sales_Order_Line__c WHERE Id = \'' + savedSolId + '\'');
                }
            }
            if (!editGrp) {
                getConReqGroup();
            }
            
            // Force redirect to group detail page - avoids resend of form data upon page refresh
            pr = new PageReference('/' + crGroup.Id);
            pr.setRedirect(true);
        }
        
        return pr;
    }
    
    // Save the Construction Requisition - used by both saveSolLine and saveAndNewSolLine
    private String saveLine(String solId) {
        
        String savedSolId = null;
        ConReqLineWrapper crlw = null;
        if (solId == null || solId == '') {
            crlw = crLineList[0];
            crlw.crLine.Ship_to_Account__c = crGroup.Ship_to_Account__c;
            crlw.crLine.Status__c = crGroup.Status__c;
            crlw.crLine.Vendor__c = crGroup.Vendor__c;
            crlw.crLine.Vendor_Contact__c = crGroup.Vendor_Contact__c;
            crlw.crLine.Requested_Delivery_Date__c = crGroup.Requested_Delivery_Date__c;
            crlw.crLine.Service_Visit__c = crGroup.ServiceVisit__c;
            crlw.crLine.WorkOrder__c= crGroup.WorkOrder__c;
            
            //string a = crGroup.WorkOrder__c;
        } else {
            for (ConReqLineWrapper crl :crLineList) {
                if (crl.crLine.Id == solId) {
                    crlw = crl;
                }
            }
        }
        
        // Make sure a Project Product has been selected if Construction Requisition is Major Component
        if (crlw != null) {
            crlw.isProductError = false;
            if (crlw.isMajorComponent ) {
                if (crlw.crLine.Opportunity_Product__c == NULL || crlw.crLine.Opportunity_Product__c == '') {
                    crlw.isProductError = true;
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Invalid Data. Review all error messages below to correct your data.'));
                    return null;
                } else {
                    // Take the product selected from the dynamic Project Product pick list and set the Product field
                    crlw.crLine.AcctSeedERP__Product__c = crlw.crLine.Opportunity_Product__c;
                }
            }
            else if (crlw.isMinorComponent ) {
                if (crlw.crLine.Opportunity_Product__c == NULL || crlw.crLine.Opportunity_Product__c == '') {
                    crlw.isProductError = true;
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Invalid Data. Review all error messages below to correct your data.'));
                    return null;
                } else {
                    // Take the product selected from the dynamic Project Product pick list and set the Product field
                    crlw.crLine.AcctSeedERP__Product__c = crlw.crLine.Opportunity_Product__c;
                }
            }
            
            try {
                upsert crlw.crLine;
                savedSolId = crlw.crLine.Id;
            } catch(Exception e) {
                system.debug('Con Req Group Save Line Exception = ' + e.getMessage());
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Save Exception: ' + e.getMessage()));
            }
        } else {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'No Construction Requisition record selected.'));
        }
        
        return savedSolId;
    }
    
    public PageReference saveAndNewSolLine() {
        String solId = ApexPages.currentPage().getParameters().get('solId');
        system.debug('*****saveAndNewSolLine solId = ' + solId);
        
        String savedSolId = saveLine(solId);
        
        // Set up return display req line
        if (savedSolId != null) {
            addReqLine = true;
            selectRecordTypeLine = true;
            for (ConReqLineWrapper crlw :crLineList) {
                if (crlw.crLine.Id == savedSolId) {
                    crlw.isSummary = false;
                    crlw.cancelState = 'Summary';
                    crlw.isDetail = true;
                    crlw.crLine = Database.query('SELECT ' + getsolLineFields() + ' FROM AcctSeedERP__Sales_Order_Line__c WHERE Id = \'' + savedSolId + '\'');
                }
            }
            if (!editGrp) {
                getConReqGroup();
            }
        }
        
        return null;
    }
    
    public PageReference cancelSolLine() {
        String solId = ApexPages.currentPage().getParameters().get('solId');
        system.debug('*****cancelSolLine solId = ' + solId);
        if (solId == null || solId == '') {
            addReqLine = false;
            if (crLineList.size() == 1) {
                noSalesOrderLines = true;
                crLineList = new List<ConReqLineWrapper>();
            } else {
                List<ConReqLineWrapper> tempLineList = new List<ConReqLineWrapper>();
                tempLineList.addAll(crLineList);
                crLineList = new List<ConReqLineWrapper>();
                for (Integer i=1; i<tempLineList.size(); i++) {
                    crLineList.add(new ConReqLineWrapper(tempLineList[i].crLine, tempLineList[i].isSummary, tempLineList[i].isDetail));
                }
            }
        } else {
            for (ConReqLineWrapper crlw :crLineList) {
                if (crlw.crLine.Id == solId) {
                    if (crlw.cancelState == 'Detail') {
                        crlw.isSummary = false;
                        crlw.cancelState = 'Summary';
                    } else {
                        crlw.isSummary = true;
                    }
                    crlw.isDetail = true;
                    crlw.crLine = Database.query('SELECT ' + getsolLineFields() + ' FROM AcctSeedERP__Sales_Order_Line__c WHERE Id = \'' + solId + '\'');
                }
            }
        }
        return null;
    }
       
    public class ConReqLineWrapper {
        public AcctSeedERP__Sales_Order_Line__c crLine {get; set;}
        public Boolean isSummary {get; set;}
        public Boolean isDetail {get; set;}
        public Boolean isMajorComponent {get; set;}
        public Boolean isProductError {get; set;}
        public String cancelState {get; set;}
        public Boolean isMinorComponent {get; set;}
        public Boolean isOtherComponent {get; set;}
        
        public ConReqLineWrapper(AcctSeedERP__Sales_Order_Line__c crl, Boolean summary, Boolean detail) {
            
            crLine = crl;
            isSummary = summary;
            isDetail = detail;
            isProductError = false;
            cancelState = 'Summary';
            
            Map<Id, Schema.RecordTypeInfo> rtMapById = Schema.SObjectType.AcctSeedERP__Sales_Order_Line__c.getRecordTypeInfosById();
            system.debug('Map is'+rtMapById);
            isMajorComponent = false;
            isMinorComponent = false;
            isOtherComponent = false;
            
            
            if (crLine != null && rtMapById.containsKey(crLine.RecordTypeId) && rtMapById.get(crLine.RecordTypeId).getName() == 'Major Component') 
            {
                isMajorComponent = true;
                system.debug('Major');
            }
            else if((crLine != null && rtMapById.containsKey(crLine.RecordTypeId) && rtMapById.get(crLine.RecordTypeId).getName() == 'Minor Component') ){
                isMinorComponent = true;
                system.debug('Minor');
            } 
            else{
                isOtherComponent = true;
                system.debug('Other');
            }  
        }
    }
}