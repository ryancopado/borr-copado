trigger ptoReceived on SFDC_Project__c (after insert, after update) {
/*
   if(approveELI.IsRecursiveUpdate==null) approveELI.IsRecursiveUpdate=false;
    
    if(approveELI.IsRecursiveUpdate==false){

            //If a Project has just received Permission to Operate, create Asset records
            //for Products listed on the Opportunity.  Also if the Permission to Operate
            //date has changed, update all the associated Asset records.
            
            List<SFDC_Project__c> proAssetCreate = new List<SFDC_Project__c>();
            List<SFDC_Project__c> proAssetUpdate = new List<SFDC_Project__c>();
            for (Integer i=0; i<Trigger.new.size(); i++) {
                //As per CR on 12th Jan 2012: "Create Assets upon “Construction Stage= 90% Complete”"
                //if (Trigger.new[i].Interconnection_Status__c == 'Permission to Operate') {
                if (Trigger.new[i].SFDC_Project_Stage__c == 'Work 90% Completed') {
                
                    if (Trigger.isInsert) {
                        proAssetCreate.add(Trigger.new[i]);
                    }
                    if (Trigger.isUpdate) {
                        //if (Trigger.old[i].Interconnection_Status__c != 'Permission to Operate') {
                        if (Trigger.old[i].SFDC_Project_Stage__c != 'Work 90% Completed') {
                            proAssetCreate.add(Trigger.new[i]);
                        } else {
                            if (Trigger.new[i].PTO_Date__c != Trigger.old[i].PTO_Date__c) {
                                proAssetUpdate.add(Trigger.new[i]);
                            }
                        }
                    }
                }
            }
            
            if (proAssetCreate.size() > 0) {
                    system.debug('Test4');
                autoAssets.createAssets(proAssetCreate);
            }
            if (proAssetUpdate.size() > 0) {
                autoAssets.assetWarranty(proAssetUpdate);
            }
        }
 */
 }