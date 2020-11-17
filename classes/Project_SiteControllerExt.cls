public with sharing class Project_SiteControllerExt {
    
    /*
     *  Controller extension for the AcctSeed__Project__c detail page.
     *
     *  Methods for display and edit of related Site records on the Project detail page
     *  in a tab format.
     *
     */
    
    ApexPages.StandardController stdController;
    public AcctSeed__Project__c project {get; set;}
    public Boolean westLayout {get; set;}
    public boolean otherlayout {get;set;}
     public Boolean devLayout {get; set;}
    public Boolean editMode {get; set;}
    public Boolean cloneMode {get; set;}
    public Boolean plusMode {get; set;}
    public List<Site__c> sites {get; set;}
    public Integer sitesCount {get; set;}       // total number of Site records
    public Integer tabFirst {get; set;}         // Index of first Site/tab to display
    public Integer tabCount {get; set;}         // Number of tabs to display
    public String tabsMaxString = '1';          // User settable field - number of tabs to show
    Integer tabsMax = 1;                        // Integer value of tabsMaxString;
    public Integer maxTabsPerPage {get; set;}   // Maximum number of tabs allowed to be displayed at once
    String selectedTab = '';
    public String lastSelectedTab {get;set;}
    
    public Project_SiteControllerExt(ApexPages.StandardController stdController) {
        lastSelectedTab = '';
        
        this.project = (AcctSeed__Project__c)stdController.getRecord();
        this.project = [select Id, Branch__c, Opportunity_Record_Type_ID__c  from AcctSeed__Project__c where Id = :this.project.Id];
        
        if (this.project.Opportunity_Record_Type_ID__c == '012340000007kaK') {
            westLayout = true;
             otherlayout = false;
        } else {
            westLayout = false;
            otherlayout = true; 
        }
        system.debug('look here recid--> ' +this.project.Opportunity_Record_Type_ID__c);
        devlayout =false;
        editMode = false;
        cloneMode = false;
        plusMode = false;
        maxTabsPerPage = 10;
        currentTabNo = 0;
        system.debug('west--> ' +westlayout);
        system.debug('dev-->'   +devlayout);
        system.debug('other-->'   +otherlayout);
        sites = getSiteList();
        if (sitesCount > 0) {
            selectedTab = sites[0].Name;
            lastSelectedTab = selectedTab;
        }
        setTabs();
    }
    
    public Integer currentTabNo {get;set;}
    
    public void doPrevious() {
        if(currentTabNo > 0) {
            lastSelectedTab = sites[currentTabNo].Name;
            currentTabNo--;
            
            selectedTab = sites[currentTabNo].Name;
        }
    }
    
    public void doNext() {
        if(currentTabNo < tabCount) {
            lastSelectedTab = sites[currentTabNo].Name;
            currentTabNo++;
            
            selectedTab = sites[currentTabNo].Name;
        }
    }
    
    // Get all of the related Site records - all fields
    public List<Site__c> getSiteList() {
        List<Site__c> siteList = new List<Site__c>();
        String selects;
        Map<String, Schema.SObjectField> fMap;
        List<string> selectFields;
        
        fMap = Schema.getGlobalDescribe().get('Site__c').getDescribe().Fields.getMap();
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
        
        system.debug('*****getSiteList field list = ' + selects);
        
        siteList = (List<Site__c>)Database.query('SELECT ' + selects + ' FROM Site__c WHERE Project__c = \'' + this.project.Id + '\' ORDER BY Name ASC');
        sitesCount = siteList.size();
        setsitesColumns(siteList);
        return siteList;
    }
    
    // Set the first tab to display and the number of tabs to display
    private void setTabs() {
        
        tabFirst = 0;
        tabCount = 0;
        if (!String.isBlank(selectedTab) && sitesCount > 0) {
            
            // Set the number of tabs to display
            if (sitesCount <= tabsMax) {
                tabCount = sitesCount;
            } else {
                tabCount = tabsMax;
            }
            
            // Set the sites index of the first tab to display
            Integer sti = -1;
            for (Integer i=0; i<sitesCount; i++) {
                if (sites[i].Name == selectedTab) {
                    sti = i;
                    currentTabNo = i;
                }
            }
            if (sti != -1 && sti >= tabCount) {
                tabFirst = sti + 1 - tabCount;
            }
        }
    }
    
    public void setselectedTab(String tabSelect) {
        lastSelectedTab = selectedTab;
        selectedTab = tabSelect;
        if (selectedTab == '+') {
            plusMode = true;
        } else {
            plusMode = false;
        }
        
        
        if(!plusMode && String.isNotEmpty(selectedTab)) {
            currentTabNo = 0;
            for(Integer i=0;i<sites.size();i++) {
                if(sites[i].Name == selectedTab) {
                    break;
                } else {
                    currentTabNo++;
                }
            }
        }
        
        system.debug('*****setselectedTab selectedTab = ' + selectedTab + ' lastSelectedTab = ' + lastSelectedTab + ' tabFirst = ' + tabFirst + ' tabCount = ' + tabCount);
    }
    
    public String getselectedTab() {
        return selectedTab;
    }
    
    public void settabsMaxString(String tabs) {
        Integer ltm = tabsMax;
        if (String.isBlank(tabs) || !tabs.isNumeric()) {
            tabsMax = 6;
        } else {
            tabsMax = Integer.valueOf(tabs);
            if (tabsMax < 1) {
                tabsMax = 1;
            }
            if (tabsMax > maxTabsPerPage) {
                tabsMax = maxTabsPerPage;
            }
        }
        tabsMaxString = String.valueOf(tabsMax);
        if (tabsMax != ltm) {
            setTabs();
        }
    }
    
    public String gettabsMaxString() {
        return tabsMaxString;
    }
    
    public String plusTabName {get; set;}
    
    public PageReference setplusTab() {
        setSelectedTab(plusTabName);
        setTabs();
        system.debug('*****setplusTab selectedTab = ' + selectedTab + ' lastSelectedTab = ' + lastSelectedTab + ' tabFirst = ' + tabFirst + ' tabCount = ' + tabCount);
        return null;
    }
    
    public PageReference refreshPage() {
        return null;
    }
    
    public PageReference editAllSites() {
        editMode = true;
        return null;
    }
    
    public PageReference cloneSite() {
        
        Site__c siteToClone = new Site__c();
        Site__c siteCloned = new Site__c();
        
        system.debug('*****cloneSite getselectedTab() = ' + getselectedTab());
        for (Site__c s :sites) {
            if (s.Name == selectedTab) {
                siteToClone = s;
            }
        }
        
        if (siteToClone.Name != null) {
            siteCloned = siteToClone.clone(false, true, false, false);
            siteCloned.Name = 'CLONE ' + siteCloned.Name;
            sites.add(siteCloned);
            sitesCount = sites.size();
            setselectedTab(siteCloned.Name);
            setTabs();
            currentTabNo = sites.size()-1;
            editMode = true;
            cloneMode = true;
        }
        
        return null;
    }
    
    public PageReference saveAllSites() {
        
        // Make sure we don't have two Site records with the same name
        Boolean dupSites = false;
        for (Integer i=0; i<sites.size() && !dupSites; i++) {
            for (Integer j=0; j<sites.size() && !dupSites; j++) {
                if (i != j) {
                    if (sites[i].Name == sites[j].Name) {
                        dupSites = true;
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Site names must be unique - duplicate Site name: ' + sites[i].Name));
                    }
                }
            }
        }
        if (dupSites) {
            return null;
        }
        
        try {
            upsert sites;
            if (cloneMode) {
                String lastTab = lastSelectedTab;
                setselectedTab(sites[sites.size() - 1].Name);
                lastSelectedTab = lastTab;
            }
            sites = getSiteList();
            setTabs();
            
            if(cloneMode) {
                currentTabNo = 0;
                for (Integer i=0; i<sites.size(); i++) {
                    if(sites[i].Name == selectedTab) {
                        break;
                    } else {
                        currentTabNo++;
                    }
                }
            }
            
            editMode = false;
            cloneMode = false;
        } catch(Exception e) {
            system.debug('*****Project_SiteControllerExt Site Save All Exception = ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, e.getMessage()));
        }
        return null;
    }
    
    public PageReference cancelAllSites() {
        sites = getSiteList();
        if (cloneMode) {
            setSelectedTab(lastSelectedTab);
        }
        setTabs();
        editMode = false;
        cloneMode = false;
        return null;
    }
    
    List<siteWrapper> scList;
    public List<siteWrapper> getsitesColumns() {
        return scList;
    }
    
    private void setsitesColumns(List<Site__c> siteList) {
        scList = new List<siteWrapper>();
        
        if (!siteList.isEmpty()) {
            Integer rtColRows = siteList.size() / 2;
            Integer rem = math.mod(siteList.size(), 2);
            Integer i = 0;
            do {
                siteWrapper sc = new siteWrapper();
                sc.leftSite = siteList[i];
                if (rtColRows > i) {
                    sc.rightSite = siteList[i + rtColRows + rem];
                }
                scList.add(sc);
                i++;
            } while (i < rtColRows);
            if (math.mod(siteList.size(), 2) != 0 && siteList.size() > 1) {
                siteWrapper sc = new siteWrapper();
                sc.leftSite = siteList[i];
                scList.add(sc);
            }
        }
    }
    
    public class siteWrapper {
        public Site__c leftSite {get; set;}
        public Site__c rightSite {get; set;}
        
        public siteWrapper() {
            leftSite = new Site__c();
            rightSite = new Site__c();
        }
        
        public siteWrapper(Site__c left, Site__c right) {
            leftSite = left;
            rightSite = right;
        }
    }
}