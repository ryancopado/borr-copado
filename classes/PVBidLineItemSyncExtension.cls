public without sharing class PVBidLineItemSyncExtension {
    final ApexPages.StandardController controller;
    
    // Set by JS, used by controller.
    public String componentIds {get; set;}
    public String costs {get; set;}
    public String titles {get; set;}
    public Boolean fullSuccess {get; set;}
    
    // Set by controller, used by JS.
    public String availablePVBidCodes {get; set;}
    public String bidId {get; set;}
    public String projectId {get; set;}
 
    private Id acctSeedProjectId;
    private List <Cost_Code__c> availableCodes;
    
    public PVBidLineItemSyncExtension (ApexPages.StandardController controller)
    {
        this.controller = controller;
        
        acctSeedProjectId = controller.getId();
        AcctSeed__Project__c project = [SELECT Id, Pricing_Request__c FROM AcctSeed__Project__c WHERE Id = :acctSeedProjectId LIMIT 1];
    	Pricing_Tool_Approval__c theRequest = [SELECT Id, BidId__c, ProjectId__c FROM Pricing_Tool_Approval__c WHERE Id = :project.Pricing_Request__c LIMIT 1];
        
        bidId = theRequest.BidId__c;
        projectId = theRequest.ProjectId__c;
        
        availableCodes = [SELECT PVBidComponentID__c FROM Cost_Code__c WHERE PVBidComponentID__c != null AND PVBidComponentID__c != ''];
    	
        availablePVBidCodes = '';
        for (Cost_Code__c cc : availableCodes) {
            availablePVBidCodes += cc.PVBidComponentID__c + ',';
        }
    }
    
    /**
     * Call from the JavaScript actionMethod in order to perform all writes to the Salesforce data model.
     * 
     * */
    public PageReference addLineItems () {
        System.debug ('addLIs...');
        System.debug (Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName().get('Budget_Line_Item'));
       	Id recordTypeId = Schema.SObjectType.AcctSeed__Project_Task__c.getRecordTypeInfosByName()
                  .get('Budget Line Item').getRecordTypeId();
        
        List<String> allCosts = costs.split(',');
        List<String> allIds = componentIds.split(',');
		List<String> allTitles = titles.split(',');
       	
        System.debug ('cost size=' + allCosts.size());
        System.debug ('ids size=' + allIds.size());
        System.debug ('fullSuccess=' + fullSuccess);
        
        // Grab the existing line items. If they already exist, we'll update them.
        Map <String, AcctSeed__Project_Task__c> existingLineItems = new Map <String, AcctSeed__Project_Task__c> ();
        for (AcctSeed__Project_Task__c task : [SELECT Id, Cost_Code__r.PVBidComponentID__c, Sales_Budget__c, AcctSeed__Project__c FROM AcctSeed__Project_Task__c WHERE AcctSeed__Project__c = :acctSeedProjectId]) {
            existingLineItems.put (task.Cost_Code__r.PVBidComponentId__c, task);
        }
        
        AcctSeed__Project_Task__c toCombine = null; // Used in Bonds business requirement below
        for (Integer i = 0; i < allIds.size(); i++) {
            
            // Embedded Business Requirement: 
            // 
            // If Cost Code = 882 (08-1604 - Sub Bonds), we need to combine with Cost Code = 432 (Bonds and Insurance- Fees).
            // 
            // Save whichever cost code we encounter first in the "toCombine" object and then add the costs together once the second one pops up.
            // Always set the identifier to 432 since 882 does not exist within the Salesforce system due to this business requirement.
            
            // Currently we're only combining 882 and 432. Leave room to scale for others.
            Boolean combinedLineItem = allIds[i] == '882' || allIds [i] == '432';
            String lookupId = allIds[i] == '882' ? '432' : allIds[i]; // handle combination

            AcctSeed__Project_Task__c bli = existingLineItems.get(lookupId);
            
            // New record
            if (bli == null) {
                bli = new AcctSeed__Project_Task__c (AcctSeed__Project__c = acctSeedProjectId, RecordTypeId = recordTypeId, Cost_Code__r = new Cost_Code__c (PVBidComponentID__c = lookupId));
            	System.debug ('Line item not found. Creating new line item.');
            }
            
            System.debug (bli);
            
            // It's combined and we already have the first half of it. Add this half to the budget and don't create a new LI.
            if (combinedLineItem && toCombine != null) {
                toCombine.Sales_Budget__c += Decimal.valueOf(allCosts[i]).setScale(2);
            }
            // Not a combined item. Just add the budget and put it in the map.
            else {
                bli.Sales_Budget__c = Decimal.valueOf(allCosts[i]).setScale(2);
                existingLineItems.put(lookupId, bli);
                
                // We're in the first half of a combined line item if this is true.
                if (combinedLineItem) {
                    toCombine = bli;
                }
            }
        }
        
        try {
            List<Database.UpsertResult> srList = Database.upsert(existingLineItems.values(), false);
            // Iterate through each returned result
            Integer successCounter = 0;
            Integer failureCounter = 0;
            
            for (Database.UpsertResult sr : srList) {
                if (sr.isSuccess()) {
                    successCounter++;
                    System.debug('Successfully upserted AcctSeed__Project_Task__c, ID=' + sr.getId());
                }
                else {
                    failureCounter++;
                    
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {   
                        System.debug (String.valueOf(err.getStatusCode()));
                        System.debug (err.getMessage());
                    }
                }
                
            }  
            
            System.debug ('Num Successes=' + successCounter + ', Num Failures=' + failureCounter);
            
            if (failureCounter != 0 || !fullSuccess)
                return errorCondition();
            
        }
        catch (Exception e) {
            System.debug (LoggingLevel.WARN, 'Caught exception upserting records');
            System.debug (LoggingLevel.WARN, e.getStackTraceString());
            return errorCondition ();
        }
         
        return successCondition ();
    }
    
    public PageReference errorCondition () {
        
        
        return null;
    }
    
    public PageReference successCondition () {
        return new PageReference('/' + acctSeedProjectId);
    }
}