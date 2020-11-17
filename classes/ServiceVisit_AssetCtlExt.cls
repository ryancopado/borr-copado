public with sharing class ServiceVisit_AssetCtlExt {
    
    /*
     *  Service Visit controller extension - allows user to select an asset for the service visit
     *  from a filtered list of assets related to the project referenced on the service visit record.
     *
     */
    
    ApexPages.StandardController stdController;
    
    public SV__c serviceVisit {get; set;}
    public Boolean isAdmin {get; set;}
    
    String assetName;
    String selectedAsset;
    
    public ServiceVisit_AssetCtlExt(ApexPages.StandardController stdController) {
        
        this.serviceVisit = (SV__c)stdController.getRecord();
        this.serviceVisit = readServiceVisit(this.serviceVisit.Id);
        
        if (this.serviceVisit.Id == null) {
            this.serviceVisit.RecordTypeId = ApexPages.currentPage().getParameters().get('RecordType');
            this.serviceVisit.Account__c = ApexPages.currentPage().getParameters().get('accountId');
            this.serviceVisit.Case__c = ApexPages.currentPage().getParameters().get('caseId');
            this.serviceVisit.Contract__c = ApexPages.currentPage().getParameters().get('contractId');
            this.serviceVisit.Project__c = ApexPages.currentPage().getParameters().get('projectId');
            this.serviceVisit.Contract_Type__c = ApexPages.currentPage().getParameters().get('contractType');
            this.serviceVisit.Asset__c = ApexPages.currentPage().getParameters().get('assetId');
            
            if (this.serviceVisit.Asset__c != null) {
                Asset tempAsset = [select Id, Name, Component_Type__c from Asset where Id = :this.serviceVisit.Asset__c];
                assetName = tempAsset.Name;
                this.serviceVisit.AssetType__c = tempAsset.Component_Type__c;
            }
        } else {
            assetName = (serviceVisit.Asset__c != null) ? serviceVisit.Asset__r.Name : '';
        }
        
        Profile prf = [select Id, Name from Profile where Id = :UserInfo.getProfileId()];
        isAdmin = (prf.Name == 'Sys Admin w/o HR') ? true : false;
    }
    
    // Read in all the fields of the Service Visit object
    private static SV__c readServiceVisit(Id svId) {
        String selects;
        SV__c sv = new SV__c();
        
        if (svId != null) {
            Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get('SV__c').getDescribe().Fields.getMap();
            List<string> selectFields = new List<string>();
            
            if (fMap != null) {
                for (Schema.SObjectField ft : fMap.values()) {
                    Schema.DescribeFieldResult fd = ft.getDescribe();
                    selectFields.add(fd.getName());
                }
            }
            selects = '';
            if (!selectFields.isEmpty()) {
                for (string s:selectFields) {
                    selects += s + ',';
                }
                selects += 'Asset__r.Name';
            }
            
            sv = (SV__c)Database.query('SELECT ' + selects + ' FROM SV__c WHERE Id = \'' + svId + '\'');
        }
        
        return sv;
    }
    
    public List<SelectOption> getassets() {
        List<SelectOption> assetOptions = new List<SelectOption>();
        List<Asset> assetList = new List<Asset>();
        
        selectedAsset = null;
        assetOptions.add(new SelectOption('--None--','--None--'));
        if (serviceVisit.Project__c != null) {
            Map<String, Schema.RecordTypeInfo> rtAssetMap = Schema.SObjectType.Asset.getRecordTypeInfosByName();
            assetList = [select Id, Name, Project__c from Asset where Project__c = :serviceVisit.Project__c and RecordTypeId =: rtAssetMap.get('Operations Asset').getRecordTypeId() and Asset_Status__c !='InActive' order by Name];  //'and Asset_Status__c ='Active'
            system.debug('look here' + assetList);
            for (Asset a :assetList) {
                assetOptions.add(new SelectOption(a.Id, a.Name));
                if (serviceVisit.Asset__c == a.Id) {
                    selectedAsset = a.Id;
                }
            }
            
            if (selectedAsset == null) {
            system.debug('This is the second Loop');
                if (serviceVisit.Asset__c != null) {
                    assetOptions.add(new SelectOption(serviceVisit.Asset__c, assetName));
                    selectedAsset = serviceVisit.Asset__c;
                } else {
                system.debug('This is the third Loop');
                    selectedAsset = assetOptions[0].getValue();
                }
            }
        }
        
        return assetOptions;
    }
    
    public String getselectedAsset() {
        return selectedAsset;
    }
    
    public void setselectedAsset(String aId) {
        selectedAsset = aId;
    }
    
    public PageReference assetChanged() {
        
        if (selectedAsset == '--None--') {
            serviceVisit.Asset__c = null;
            serviceVisit.AssetType__c = '';
            serviceVisit.AssetFault__c = '';
            serviceVisit.Asset_Offline__c = null;
            serviceVisit.Asset_Online__c = null;
            serviceVisit.Was_Asset_Offline__c = '';
            serviceVisit.Case_Resolved__c = '';
        } else {
            try {
                serviceVisit.Asset__c = selectedAsset;
                Asset newAsset = [select Id, Component_Type__c from Asset where Id = :selectedAsset];
                servicevisit.AssetType__c = newAsset.Component_Type__c;
                serviceVisit.AssetFault__c = '';
                serviceVisit.Asset_Offline__c = null;
                serviceVisit.Asset_Online__c = null;
                serviceVisit.Was_Asset_Offline__c = '';
                serviceVisit.Case_Resolved__c = '';
            } catch(Exception e) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Asset read exception: ' + e.getMessage()));
            }
        }
        return null;
    }
    
    public PageReference assetOfflineChanged() {
        
        if (serviceVisit.Asset_Offline__c == null) {
            serviceVisit.Was_Asset_Offline__c = '';
        } else {
            if (String.isBlank(serviceVisit.Was_Asset_Offline__c) || serviceVisit.Was_Asset_Offline__c == 'No') {
                serviceVisit.Was_Asset_Offline__c = 'Yes';
            }
        }
        return null;
    }
    
    // Save the changes made to the Asset field and dependent fields
    public PageReference saveAsset() {
        PageReference pr = null;
        
        try {
            upsert serviceVisit;
            pr = new PageReference('/' + serviceVisit.Id);
        } catch(Exception e) {
            String errMsg = 'Service Visit save exception: ' + e.getMessage();
            if (errMsg.contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')) {
                errMsg = errMsg.substringBetween('FIELD_CUSTOM_VALIDATION_EXCEPTION, ', ': [');
            }
            if (String.isBlank(errMsg)) {
                errMsg = 'Service Visit save exception: ' + e.getMessage();
            }
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, errMsg));
        }
        
        return pr;
    }
}