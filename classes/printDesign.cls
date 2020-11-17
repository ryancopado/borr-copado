public class printDesign {

    ApexPages.StandardController stdController;
    private final SFDC_Project__c p;  
    
  public printDesign(ApexPages.StandardController stdController) {
    this.p = (SFDC_Project__c)stdController.getRecord(); 
    this.stdController = stdController;
    }
    private PSD__c[] psds;
  public PSD__c getPSD(){
    psds = [select p.Today__c, p.System_Sizing_Strategy__c, p.System_Orientation_Azimuth__c, p.SystemModstamp, 
        p.Status__c, p.Status_Change__c, p.Site_Address2__c, p.Shading_Notes__c, p.Roof_Type__c, 
        p.Roof_Space_Off_Limits__c, p.Racking_System__c, p.Proposed_System_Tilt_Angle__c, 
        p.Proposal_Level_Needed__c, p.Opportunity__c, p.On_Hold_Notes__c, p.Number_of_Buildings__c, 
        p.Name, p.Modules__c, p.Module_Location_Description__c, p.Job_Type__c, p.Inverters__c, 
        p.Id, p.Hours__c, p.Electrical_Sizing_Strategy__c, p.Due_Date__c, p.Drawings_Already_Exist__c, 
        p.Designer__c, p.Design_Partner__c, p.Days_Since_Status_Change__c, p.Customer_Name__c, p.CreatedDate, 
        p.Cost__c, p.Building_Type__c, p.Building_Owner__c, p.Additional_Notes__c from PSD__c p 
        where Opportunity__c = :p.Opportunity__c ORDER BY CreatedDate DESC LIMIT 1];    
    if(psds.size() > 0){
      return psds[0];
    } else {
      return null;
    }    
  }
  public static testmethod void invoiceTest() {       
        SFDC_Project__c p = ProjectTestOld.setupTestProj();
        RecordType ContentRT = [select Id FROM RecordType WHERE name='O&M Opportunity'];
        Opportunity opp = [select Id, StageName from Opportunity where Id = :p.Opportunity__c ];
       opp.StageName = 'Qualified';
      //  opp.Development_Only__c = 'No';
      //  opp.Expected_Bid_Date__c = system.today();
      //  opp.of_Sites__c = 1;
        
        update opp;
        PSD__c psd = new PSD__c(Opportunity__c = p.Opportunity__c,
                    Customer_Name__c = 'Test',
                    Proposal_Level_Needed__c = 'L1',
                    Due_Date__c = System.today()+20
                    );

        PageReference pageRef = Page.printDesign;
        Test.setCurrentPage(pageRef);
               
        //Set Page Parameters
        ApexPages.StandardController con = new ApexPages.StandardController(new SFDC_Project__c());
    ApexPages.StandardController con2 = new ApexPages.StandardController(p);
    
        ApexPages.currentPage().getParameters().put('id', p.Id); 
        printDesign ext = new printDesign(con);
        //Call all methods on New page 
      ext.getPSD();
      
    insert psd;
    printDesign ext2 = new printDesign(con2);  
      ext2.getPSD();                 
    } 
}