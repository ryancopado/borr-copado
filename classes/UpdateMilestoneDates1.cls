public with sharing class UpdateMilestoneDates1
{

    //public String objectsList { get; set; }
    
    public UpdateMilestoneDates1() {

    }
    public ApexPages.StandardSetController stdSetmilestone;
    public List<Site__c> selectedSites;
    private String listViewFilterId1;
    public String selectedsiteid {get;set;}
    public Boolean showonsiterecordtype {get; set;}
    public Boolean showsite {get; set;}

           
    private String siteId;
    public List<Site__c> lstsiteQuery{get;set;}
    public List<ProjectDeadline__c> lstprojdeadlineQuery{get;set;}
    public List<Site__c> lstsiteQuery1{get;set;}
    public List<ProjectDeadline__c> lstprojdeadlineQuery1{get;set;}
    public List<wrapperSite> siteList {get; set;}
    public List<wrapperSite> projdeadList {get; set;}
    public class wrapperSite
      {
        public Site__c site {get; set;}
        public ProjectDeadline__c projdead {get; set;}
        public List<ProjectDeadline__c> projdeadList {get; set;}
        public Boolean selected {get; set;}        
        public wrapperSite(Site__c b,ProjectDeadline__c  bl) 
            {
                site= b;
                projdead=bl;
                selected = false;
            }
      } 
      
     /** public PageReference siteSelected() 
      {
        List<Site__c> selectedSites= new List<Site__c>();
        system.debug('the selected rows'+sitelist);
        for(wrapperSite csite: siteList) 
        
          {
          system.debug('the selected rows'+csite);
                if(csite.selected == true) 
                { 
                    selectedSites.add(csite.site);
                    system.debug('Select billing - '+csite.site.id);
                }
          }
         return null;
      }**/
     public UpdateMilestoneDates1(ApexPages.StandardSetController stdSetmilestone)
     {
        this.stdSetmilestone= stdSetmilestone;
        showsite=false;
        showonsiterecordtype =false;
        system.debug('UpdateMilestoneDates method');
        List<Site__c>selectedSites= stdSetmilestone.getSelected();
        system.debug('List'+stdSetmilestone.getSelected());
        system.debug('List size'+selectedSites.size());
        siteList= new List<wrapperSite> ();
        projdeadList = new List<wrapperSite> ();
        lstsiteQuery=new List<Site__c>();
        lstprojdeadlineQuery=new List<ProjectDeadline__c>();
        Site__c theSite = new Site__c();
        ProjectDeadline__c theProjectDeadline = new ProjectDeadline__c();
        /**lstsiteQuery=[select Name,MarkettoOwnerDate__c,PB9CCApprovalDate__c,Switchgear_Delivery_Date__c ,Handoff_Date__c,ISA_Received_Date__c,X25PaymentDate__c,id,X75PaymentDate__c,UtilityDesignCompletionDate__c,CD_Forecast_Release_Date__c,CD_IFC_Release_Date__c,EPC_Signed_Date__c,FNTP_Date__c,ProductDeliveryDateUpdated__c ,BuildingPermitObtainedDate__c,Mobilization_Date__c,Energy_Storage_Unit_Delivery_Date__c,Racking_Delivery_Date__c,Module_Delivery_Date__c,Inverter_Delivery_Date__c,Switchboard_Delivery_Date__c,Substantial_Completion_Date__c,PTO_Date__c,Substantial_Completion_NEW__c,Final_Completion__c,Deadline_Date__c,Deadline_Description__c from Site__c where id=:selectedsiteid]; 
        lstprojdeadlineQuery=[select AssociatedMilestone__c,DeadlineDate__c,DeadlineDescription__c,id,Site__c,Name from ProjectDeadline__c where Site__c =:selectedsiteid];     
        for(integer i=0;i<lstsiteQuery.size();i++) 
        {        
            theSite = lstsiteQuery[i];
            if(lstprojdeadlineQuery.size()>0){
                for(integer j=0;j<lstprojdeadlineQuery.size();j++)
                {
                    theProjectDeadline = lstprojdeadlineQuery[j];
                    if(theSite.id==theProjectDeadline.Site__c)
                    {
                        siteList.add(new wrapperSite(theSite ,theProjectDeadline));
                    }
                }
                
            }
            else{                
                siteList.add(new wrapperSite(theSite ,new ProjectDeadline__c()));
            }  
        }*/  
    }       
  
  public List<Site__c> SiteTemp = new List<Site__c>(); 
   
  public List<SelectOption> Sitelist1 
   
    {
        get
        {
            List<Site__c> SiteTemp = [select id,Name from Site__c where id IN : (List<Site__c>) stdSetmilestone.getSelected()];
            if(SiteTemp.Size()>0)
            {
                Sitelist1 = new List<SelectOption>();
                Sitelist1.add(new SelectOption('---','Pick a record'));
                for(Site__c site : SiteTemp)
                {
                    Sitelist1.add(new SelectOption(site.id,site.Name));
                }
            }
            return Sitelist1;
        }
        set;
    }
   public void getsiterecords()
   {
       Site__c theSite = new Site__c();
       ProjectDeadline__c theProjectDeadline = new ProjectDeadline__c();
       lstsiteQuery1=new List<Site__c>();
       lstprojdeadlineQuery1=new List<ProjectDeadline__c>();
       system.debug('selectedsite  is ' +selectedsiteid);
       
       lstsiteQuery=[select Name,MarkettoOwnerDate__c,Project_Kickoff_Date_editable__c,X50_Forecast_Release_Date__c ,New_Comments_on_Schedule__c,Interconnection_App_Submitted_Date__c,LNTP_Date__c,X50_Set_Completed__c,Opportunity_Record_Type__c,CD_IFP_Date__c,PB9CCApprovalDate__c,Switchgear_Delivery_Date__c ,UtilityConstructionCompletionDate__c,Handoff_Date__c,ISA_Received_Date__c,X25PaymentDate__c,id,X75PaymentDate__c,UtilityDesignCompletionDate__c,Transformer_Delivery_Date__c ,CD_Forecast_Release_Date__c,CD_IFC_Release_Date__c,EPC_Signed_Date__c,FNTP_Date__c,ProductDeliveryDateUpdated__c ,BuildingPermitObtainedDate__c,Mobilization_Date__c,Energy_Storage_Unit_Delivery_Date__c,Racking_Delivery_Date__c,Module_Delivery_Date__c,Inverter_Delivery_Date__c,Switchboard_Delivery_Date__c,Substantial_Completion_Date__c,PTO_Date__c,Substantial_Completion_NEW__c,Final_Completion__c,Deadline_Date__c,Deadline_Description__c from Site__c where id=:selectedsiteid]; 
       lstprojdeadlineQuery=[select AssociatedMilestone__c,DeadlineDate__c,DeadlineDescription__c,id,Site__c,Name,RelatedMilestoneDate__c,Mitigation_Plan__c from ProjectDeadline__c where Site__c =:selectedsiteid];
       if(lstsiteQuery.Size()>0)
       {
           theSite=lstsiteQuery[0];
           
           
           system.debug('Thesite  is ' +theSite);
           system.debug('Thesite opportunity recordtype  is ' +theSite.Opportunity_Record_Type__c);
           if(theSite.Opportunity_Record_Type__c=='captive/onsite')
           {
                 showsite=true;
                 showonsiterecordtype=false;
                 system.debug('showsite Value'+showsite+' record type'+showonsiterecordtype);
             
                   if(lstprojdeadlineQuery.size()>0)
                   {
                   projdeadList.clear();
                   for(integer j=0;j<lstprojdeadlineQuery.size();j++)
                        {
                            theProjectDeadline = lstprojdeadlineQuery[j];
                            if(theSite.id==theProjectDeadline.Site__c)
                            {
                                siteList.clear();
                                siteList.add(new wrapperSite(theSite ,theProjectDeadline));
                                projdeadList.add(new wrapperSite(theSite ,theProjectDeadline));
                                
                            }
                        }
                        
                    }
                    else{
                        projdeadList.clear();
                        siteList.clear();
                        siteList.add(new wrapperSite(theSite ,new ProjectDeadline__c()));
                        projdeadList.add(new wrapperSite(theSite ,new ProjectDeadline__c()));
                        system.debug('List' +siteList);
                    }
            } 
            else
            {
               
              showsite=false;
              showonsiterecordtype=true;
              system.debug('showsite Value'+showsite+' record type'+showonsiterecordtype);
               theSite=lstsiteQuery[0];
               system.debug('Thesite  is ' +theSite);
               if(lstprojdeadlineQuery.size()>0)
                   {
                       projdeadList.clear();
                       for(integer j=0;j<lstprojdeadlineQuery.size();j++)
                            {
                                theProjectDeadline = lstprojdeadlineQuery[j];
                                if(theSite.id==theProjectDeadline.Site__c)
                                    {
                                        siteList.clear();
                                        siteList.add(new wrapperSite(theSite ,theProjectDeadline));
                                        projdeadList.add(new wrapperSite(theSite ,theProjectDeadline));
                        
                                    }
                            }
                
                }
               else{
                    projdeadList.clear();
                    siteList.clear();
                    siteList.add(new wrapperSite(theSite ,new ProjectDeadline__c()));
                    projdeadList.add(new wrapperSite(theSite ,new ProjectDeadline__c()));
                    system.debug('List' +siteList);   
                   }
            }
        
        }
    }
        
       
       
            
       
    Public pagereference Save() 
    {       
        System.debug('Site List' +siteList);
        System.debug('Site List' +siteList.size());
        if(siteList.size()>0)
        {
            update lstsiteQuery;
            update lstprojdeadlineQuery;                          
        }
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Record has been saved successfully'));
    
        return null;
    }
}