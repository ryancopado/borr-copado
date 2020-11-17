public without sharing class PVBidExtension {
    final ApexPages.StandardController controller;
    
    /**
     * Variables to sync from PVBid to SFDC
     * */
    public String finalEPC {get; set;}
    public String ineligibleCosts {get; set;}
    public String finalEPCTotal {get; set;}
    public String directMarginPercentage {get; set;}
    public String modulePriceAssumption {get; set;}
    public String systemSize {get; set;}
    public String grossMargin {get; set;}
    public String bidTitle {get; set;}
    public String directMarginDollars {get; set;}
    public String directCOGS {get; set;}
    public String directCOGSPerWatt {get; set;}
    public String grossMarginPercentage {get; set;}
    public String esdCost {get; set;}
    public String esdFinalPrice {get; set;}
    public String snapshotCreationDate {get; set;}
    public String AffiliateFee {get; set;}
     public String UtilityUpgrades{get; set;}
    public string finaldevcogssum{get; set;}
    public string storagemargin{get; set;}
    
    public string storagepower{get; set;}
    public string storageenergy{get; set;}
    public string energystoragesys{get; set;}
    public string enerystorageunit{get; set;}
    public string pvtotal{get; set;}

    
    /**
     * Variables to send to the JavaScript to do its job
     * */
    public Id pricingRequestId;
    public String bidId {get; set;}
    public String projectId {get; set;}
    public Boolean isPricingRequestLocked {get; set;}
    
    /**
     * Variables to keep in memory and potentially modify
     **/
    private Pricing_Tool_Approval__c theRequest;
    
    /**
     * Standard constructor used to initialize the data elements needed for processing within the JavaScript (isLocked, BidId, and ProjectId).
     * 
     * */
    public PVBidExtension (ApexPages.StandardController controller)
    {
        this.controller = controller;
        
        pricingRequestId = controller.getId();
        theRequest = [SELECT Id, BidId__c, ProjectId__c, Status__c FROM Pricing_Tool_Approval__c WHERE Id = :pricingRequestId LIMIT 1];
        
        bidId = theRequest.BidId__c;
        projectId = theRequest.ProjectId__c;
        //isPricingRequestLocked = theRequest.Status__c != 'New' ;
          if((theRequest.Status__c != 'Recalled') && (theRequest.Status__c != 'New'))
          {
            isPricingRequestLocked = true;
          }
    }
    
    /**
     * Called from the JavaScript actionMethod in order to perform all writes to the Salesforce data model.
     * 
     * */
    public PageReference receiveDataFromPVBid () {
        
        // Execute DML to save fields to the database
        Pricing_Tool_Approval__c request = [SELECT Id, Final_EPC_W__c, Ineligible_costs__c, Final_EPC_Total__c, 
                                            Direct_Margin__c, Module_Price_Assumption__c, System_Size_from_Pricing_Tool__c, 
                                            Gross_Margin_from_the_Pricing_Tool__c, Bid_Title__c, Bid_URL__c,
                                            Direct_Margins__c, Direct_COGS__c, Direct_COGS_w__c, Gross_Margin_Percentage__c,
                                            ESD_Final_Price__c, ESD_Direct_COGS__c, PVBid_Snapshot_Time__c,Affiliate_Fee__c,ESD_Contribution_Margin__c,Utility_Upgrades__c ,
                                            Storage_Power_kW__c,Storage_Energy_kWh__c,System_kWh__c,ESU_kWh__c,PV_Total__c

                                            
                                            FROM Pricing_Tool_Approval__c WHERE Id = :pricingRequestId LIMIT 1];
        
       /* AcctSeed__Project__c getbunit = new AcctSeed__Project__c();
        
       getbunit = [select Sales_Segment__r.name from AcctSeed__Project__c where Pricing_Request__c = :pricingRequestId];
        if (getbunit.sales_segment__r.name == 'Development'){
            
            request.Dev_COGS__c = decimal.valueOf(finaldevcogssum);
        }*/
    
        List<Pricing_Tool_Approval__c> getblist =[select Opportunity__r.team__c from Pricing_Tool_Approval__c where id=:pricingRequestid];
        
       Pricing_Tool_Approval__c getbunit=new Pricing_Tool_Approval__c();
      //  getbunit=[];
        if(getblist.size() >0)
        {
            getbunit =getblist.get(0) ;
        system.debug('Team Id' +getbunit);
         AcctSeed__Accounting_Variable__c teamname=new AcctSeed__Accounting_Variable__c ();
            if (!test.isRunningTest())  {
                 teamname=[select name from AcctSeed__Accounting_Variable__c  where id=:getbunit.Opportunity__r.team__c];
            
       
        
           
      if((teamname.name=='Dev - Emerging')||(teamname.name=='Dev - New England')||(teamname.name=='Dev - New York')||(teamname.name=='Dev- Overhead'))
        {
        
         request.Dev_COGS__c = decimal.valueOf(finaldevcogssum);
         }
        }
         }
  
        
        request.Final_EPC_W__c = Decimal.valueOf(finalEPC);
        request.Ineligible_costs__c = Decimal.valueOf(ineligibleCosts);
        request.Final_EPC_Total__c = Decimal.valueOf(finalEPCTotal);
        request.Direct_Margin__c = Decimal.valueOf(directMarginPercentage);
        request.Module_Price_Assumption__c = modulePriceAssumption;
        request.System_Size_from_Pricing_Tool__c = Decimal.valueOf(systemSize);
        request.Gross_Margin_from_the_Pricing_Tool__c = Decimal.valueOf(grossMargin);
        request.Bid_Title__c = bidTitle;
        request.Bid_URL__c = 'https://dashboard.pvbid.com/#!/projects/' + projectId + '/bids/' + bidId + '/fields';
        request.Direct_Margins__c = Decimal.valueOf(directMarginDollars);
        request.Direct_COGS__c = Decimal.valueOf(directCOGS);
        request.Direct_COGS_w__c = Decimal.valueOf(directCOGSPerWatt);
        request.ESD_Final_Price__c = Decimal.valueOf(esdFinalPrice);//made the changes to bring the storage final price from pvbid to salesforce.
        request.ESD_Direct_COGS__c = Decimal.valueOf(esdCost);
        request.Gross_Margin_Percentage__c = Decimal.valueOf(grossMarginPercentage);
        system.debug('AF' +AffiliateFee);
        request.Affiliate_Fee__c=Decimal.valueOf(AffiliateFee);
        request.Utility_Upgrades__c=Decimal.valueOf(UtilityUpgrades);
         request.ESD_Contribution_Margin__c=Decimal.valueOf(storagemargin);
        
        system.debug('look-->' +storagepower);
        if (storagepower !=''){
        request.Storage_Power_kW__c=decimal.valueof(storagepower);
        }
         system.debug('look-->' +storageenergy);
        if (storageenergy !=''){
        request.Storage_Energy_kWh__c=Decimal.valueOf(storageenergy);
        }
         system.debug('look-->' +energystoragesys);
        if (energystoragesys !=''){
        request.System_kWh__c =Decimal.valueOf(energystoragesys);
        }
         system.debug('look-->' +enerystorageunit);
        if (enerystorageunit !=''){
        request.ESU_kWh__c =Decimal.valueOf(enerystorageunit);
        }
         system.debug('look-->' +pvtotal);
        if (pvtotal != ''){
        request.PV_Total__c=Decimal.valueOf(pvtotal);
        }

        
        
        
        if (snapshotCreationDate != null && snapshotCreationDate.length() > 0) {
            
            // Snapshot comes back from PVBid in an unsupported JavaScript date format. Modify the snapshot string so that we can deserialize it in JS and then input into Salesforce.
            String parsableSnapshotTime = '"' + snapshotCreationDate.substring(0, snapshotCreationDate.length() - 6) + '"';
            try {
                request.PVBid_Snapshot_Time__c = (DateTime) JSON.deserialize(parsableSnapshotTime, DateTime.class);
            }
            catch (Exception e) {
                System.debug(LoggingLevel.WARN, 'Failed to parse DateTime from snapshot date=' + parsableSnapshotTime + ', projectId=' + projectId + ', bidId=' + bidId);
            }
        }
         
        // Sync data to the pricing request and then return to the detail page. 
        update request;
        return new PageReference('/' + pricingRequestId);
    }
    
    /**
     * Used to stay on the visualforce page and display an error message. User can escape by pressing the browser back button.
     * */
    public PageReference errorCondition () {
        
        return null;
    }
    
    /**
     * Used to set/update the project/bid ids from within the JavaScript code.
     * 
     * */
    public PageReference setProjectAndBid () {
        theRequest.BidId__c = bidId;
        theRequest.ProjectId__c = projectId;
        update theRequest;
        
        return null;
    }
}