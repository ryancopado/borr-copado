trigger trgOnConReqToUpdateAdjustedSystemSize on Con_Req__c (before insert, before update) {
//trigger trgOnConReqToUpdateAdjustedSystemSize on Con_Req__c (after delete, after insert, after update, before insert, before update) 
    
    
    if (approveELI.IsRecursiveUpdate == null) {
        approveELI.IsRecursiveUpdate = false;
    }

    if (approveELI.IsRecursiveUpdate == false) {
        approveELI.IsRecursiveUpdate = true;
        
        if (trigger.isBefore) {
            
            // Set the Prior Change Orders field for Subcontractor and Material COs - only set the field
            // if the CO is not approved.
            for (Con_Req__c cr :trigger.new) {
            
                if (cr.Status__c != 'Borrego Approved' && cr.Status__c != 'Customer Approved') {
                    cr.Prior_Change_Orders_SUB_MAT__c = cr.prior_Change_Order_From_Purchase__c;
                    system.debug('this is working' +cr.prior_Change_Order_From_Purchase__c);
                }
            }
            
            Con_Req__c  cr1 = trigger.new[0];
            AcctSeed__Project__c PrjList = new AcctSeed__Project__c();
            if (cr1.ASProject__c != null){
           PrjList = [select Project_Change_Order_Total__c from AcctSeed__Project__c where id = :cr1.ASProject__c];
           if (PrjList !=null)
           {
           system.debug('this is the prior change value' +PrjList.Project_Change_Order_Total__c );
           // if (cr1.status__c == 'Approved By Customer'){
             cr1.Prior_Change_Orders__c = PrjList.Project_Change_Order_Total__c ;
           
           }
           
          
           
         //   }
         }
        }
        /*
        else {
            
            List<Id> oppIds = new List<Id>();
            List<Id> projIds = new List<Id>();
            List<Con_Req__c> coList = new List<Con_Req__c>();
            List<Project_Products__c> ppDelete = new List<Project_Products__c>();
            List<Project_Products__c> ppUpsert = new List<Project_Products__c>();
            Map<Id, Con_Req__c> coMap = new Map<Id, Con_Req__c>();
            Map<Id, AcctSeed__Project__c> projMap = new Map<Id, AcctSeed__Project__c>();
            Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();
            Map<Id, Project_Products__c> ppMap = new Map<Id, Project_Products__c>();
            
            // Get all of the associated Projects and Opportunities
            if (trigger.isDelete) {
                coList.addAll(trigger.old);
            } else {
                coList.addAll(trigger.new);
            }
            
            for (Con_Req__c co :coList) {
                projIds.add(co.ASProject__c);
            }
            projMap = new Map<Id, AcctSeed__Project__c>([select Id, AcctSeed__Opportunity__c from AcctSeed__Project__c where Id in :projIds]);
            for (AcctSeed__Project__c p :projMap.values()) {
                oppIds.add(p.AcctSeed__Opportunity__c);
            }
            
            // Get all the Opportunities and Project Products
            oppMap = new Map<Id, Opportunity>([select Id, Change_Orders__c, Project_System_Size__c from Opportunity where Id in :oppIds]);
            ppMap = new Map<Id, Project_Products__c>([select Id, Project__c, Product__c, Quantity__c from Project_Products__c where Project__c in :projMap.keySet()]);
                
            if (trigger.isUpdate) {
                
                // Determine what Products need to change on Projects - Customer Change Orders that have
                // just changed to "Approved By Customer" and Internal Change Orders that have just changed
                // to "Borrego Approved" may have changes to Project Products.
                for (Con_Req__c co :trigger.new) {
                    if (co.Change_Order_Type__c == 'System Size or Product Change') {
                        if (co.Status__c != trigger.oldMap.get(co.Id).Status__c) {
                            if ( (co.RecordTypeName__c == 'Customer Change Order' && co.Status__c == 'Approved By Customer') ||
                                 (co.RecordTypeName__c == 'Internal Change Order' && co.Status__c == 'Borrego Approved') ) {
                                coMap.put(co.Id, co);
                            }
                        }
                    }
                }
                
                // Create new and update existing Project Product records as indicated by the Change Orders
                for (Con_Req__c co :coMap.values()) {
                    
                    system.debug('*****Original_ProjectProductId = ' + co.Original_ProjectProductId__c);
                    
                    if (co.Original_ProjectProductId__c != null && ppMap.containsKey(co.Original_ProjectProductId__c)) {
                        if (co.New_Quantity__c == 0) {
                            ppDelete.add(ppMap.get(co.Original_ProjectProductId__c));
                            system.debug('*****Delete ProjectProductId = ' + co.Original_ProjectProductId__c);
                        }
                        if (co.New_Quantity__c > 0) {
                            ppMap.get(co.Original_ProjectProductId__c).Quantity__c = co.New_Quantity__c;
                            ppUpsert.add(ppMap.get(co.Original_ProjectProductId__c));
                            system.debug('*****Update Original_ProjectProductId = ' + co.Original_ProjectProductId__c);
                        }
                    }
                    
                    if (co.New_Product__c != null && co.New_Quantity__c > 0) {
                        ppUpsert.add(new Project_Products__c(
                                Site__c = co.Site__c,
                                Quantity__c = co.New_Quantity__c,
                                Project__c = co.ASProject__c,
                                Product__c = co.New_Product__c
                            )
                        );
                    }
                }
                
                system.debug('*****ppDelete.size = ' + ppDelete.size() + ' ppUpsert.size = ' + ppUpsert.size());
                            
                try {
                    //approveELI.IsOpportunityLineItemUpdating = true;
                    if (!ppDelete.isEmpty()) {
                        delete ppDelete;
                    }
                    if (!ppUpsert.isEmpty()) {
                        upsert ppUpsert;
                    }
                } catch (Exception e) {
                    System.debug(Logginglevel.ERROR, 'Failed to delete or upsert Project Products. Error = ' + e);
                } finally {
                    //approveELI.IsOpportunityLineItemUpdating = false;
                }
            }
                   
            Map<id,Decimal> MapOfChangeOrder = new Map<Id, Decimal>();
            Map<id,Decimal> MapOfChangeOrderBorrego = new Map<Id, Decimal>();
            Map<id,Decimal> MapOfChangeOrderPending = new Map<Id, Decimal>();
            
            List<Con_Req__c> ListOfNewConReq = [select Id, Status__c, Final_Change_Order_Amount__c, Amount_Requested__c, 
                    ASProject__r.AcctSeed__Opportunity__c, Change_Order_Type__c, 
                    Subtotal__c, Additional_Cost_Total__c, Tax_Rate__c, Labor_Total__c, Overhead_Total__c, Profit_Total__c, 
                    Current_Change_Order_Subtotal__c, Pending_Change_Orders__c, Prior_Change_Orders__c, Original_Unit_Price2__c, 
                    RecordTypeName__c, Purchase_Order2__c, Adjusted_System_Size__c, Original_ProjectProductId__c, 
                    New_Product__r.Watts_STC__c, Original_Product__r.Watts_STC__c, New_Quantity__c  
                    from Con_Req__c where ASProject__r.AcctSeed__Opportunity__c in :oppMap.keySet()];
            
            for (Con_Req__c ConReq :ListOfNewConReq) {
                
                if (ConReq.RecordTypeName__c == 'Customer Change Order') {
                    
                    // connect change order and sum up the cost break down where status approved by customer.
                    if (ConReq.Status__c == 'Approved By Customer') {
                        if (MapOfChangeOrder.containsKey(ConReq.ASProject__r.AcctSeed__Opportunity__c)) {
                            if (MapOfChangeOrder.get(ConReq.ASProject__r.AcctSeed__Opportunity__c) == null) {
                                MapOfChangeOrder.put(ConReq.ASProject__r.AcctSeed__Opportunity__c, 0);
                            } else {            
                                Decimal CO = MapOfChangeOrder.get(ConReq.ASProject__r.AcctSeed__Opportunity__c) + ConReq.Current_Change_Order_Subtotal__c;
                                MapOfChangeOrder.put(ConReq.ASProject__r.AcctSeed__Opportunity__c, CO);            
                            }                
                        } else {
                            MapOfChangeOrder.put(ConReq.ASProject__r.AcctSeed__Opportunity__c, ConReq.Current_Change_Order_Subtotal__c);
                        }
                    }
                    
                    if (ConReq.Status__c == 'Borrego Approved') {
                        if (MapOfChangeOrderBorrego.containsKey(ConReq.ASProject__r.AcctSeed__Opportunity__c)) {
                            if (MapOfChangeOrderBorrego.get(ConReq.ASProject__r.AcctSeed__Opportunity__c) == null) {
                                MapOfChangeOrderBorrego.put(ConReq.ASProject__r.AcctSeed__Opportunity__c, 0);
                            } else {            
                                Decimal CO = MapOfChangeOrderBorrego.get(ConReq.ASProject__r.AcctSeed__Opportunity__c) + ConReq.Current_Change_Order_Subtotal__c;
                                MapOfChangeOrderBorrego.put(ConReq.ASProject__r.AcctSeed__Opportunity__c, CO);            
                            }                
                        } else {
                            MapOfChangeOrderBorrego.put(ConReq.ASProject__r.AcctSeed__Opportunity__c, ConReq.Current_Change_Order_Subtotal__c);
                        }
                    }
                }
                
                if (ConReq.Purchase_Order2__c != null && ConReq.Status__c == 'Approval Pending') {
                    if (MapOfChangeOrderPending.containsKey(ConReq.Purchase_Order2__c)) {
                        if (MapOfChangeOrderPending.get(ConReq.Purchase_Order2__c) == null) {
                            MapOfChangeOrderPending.put(ConReq.Purchase_Order2__c, 0);
                        } else {            
                            Decimal CO = MapOfChangeOrderPending.get(ConReq.Purchase_Order2__c) + ConReq.Amount_Requested__c;
                            MapOfChangeOrderPending.put(ConReq.Purchase_Order2__c, CO);            
                        }
                    } else {
                        MapOfChangeOrderPending.put(ConReq.Purchase_Order2__c, ConReq.Amount_Requested__c);
                    }
                }
            }
            
            for (Opportunity Opp :oppMap.values()) {
                if (MapOfChangeOrder.containsKey(Opp.Id)) {
                    Opp.Change_Orders__c = MapOfChangeOrder.Get(Opp.Id);
                } else {
                    Opp.Change_Orders__c = 0; 
                }
                if (MapOfChangeOrderBorrego.containsKey(Opp.Id)) {
                    Opp.Pending_CO_Amount__c = MapOfChangeOrderBorrego.Get(Opp.Id);
                } else {
                    Opp.Pending_CO_Amount__c = 0;
                } 
            } 
            update oppMap.values();
            
            // Set Prior Change Orders, Pending Change Orders and Adjusted System Size fields on the COs
            Decimal watts;
            Decimal quantity;
            Decimal currentSize;
            Decimal amountRequested;
            
            for (Con_Req__c cr :ListOfNewConReq) {
                if (MapOfChangeOrder.containsKey(cr.ASProject__r.AcctSeed__Opportunity__c)) {
                    if (cr.RecordTypeName__c == 'Customer Change Order' && cr.Status__c != 'Approved By Customer') {
                        cr.Prior_Change_Orders__c = MapOfChangeOrder.get(cr.ASProject__r.AcctSeed__Opportunity__c);
                    }
                }
                if (MapOfChangeOrderPending.containsKey(cr.Purchase_Order2__c)) {
                    if (cr.Status__c != 'Approval Pending' && cr.Status__c != 'Borrego Approved' && cr.Status__c != 'Approved By Customer') {
                        cr.Pending_Change_Orders__c = MapOfChangeOrderPending.get(cr.Purchase_Order2__c);
                    }
                    if (cr.Status__c == 'Approval Pending') {
                        amountRequested = 0;
                        if (cr.Amount_Requested__c != null) {
                            amountRequested = cr.Amount_Requested__c;
                        }
                        cr.Pending_Change_Orders__c = MapOfChangeOrderPending.get(cr.Purchase_Order2__c) - amountRequested;
                    }
                }
                
                if (cr.Change_Order_Type__c == 'System Size or Product Change' && cr.Status__c != 'Approved By Customer' && 
                        (cr.RecordTypeName__c == 'Customer Change Order' || cr.RecordTypeName__c == 'Internal Change Order')) {
                    
                    watts = 0;
                    quantity = 0;
                    currentSize = 0;
                    
                    if (cr.New_Product__c != null && cr.New_Product__r.Watts_STC__c != null) {
                        watts = cr.New_Product__r.Watts_STC__c;
                        if (cr.New_Quantity__c != null) {
                            quantity = cr.New_Quantity__c;
                        }
                    }
                    if (cr.Original_Product__c != null && cr.Original_Product__r.Watts_STC__c != null) {
                        watts = cr.Original_Product__r.Watts_STC__c;
                        if (cr.New_Quantity__c != null && ppMap.containsKey(cr.Original_ProjectProductId__c)) {
                            quantity = cr.New_Quantity__c - ppMap.get(cr.Original_ProjectProductId__c).Quantity__c;
                        }
                    }
                    if (oppMap.get(cr.ASProject__r.AcctSeed__Opportunity__c).Project_System_Size__c != null) {
                        currentSize = oppMap.get(cr.ASProject__r.AcctSeed__Opportunity__c).Project_System_Size__c;
                    }
                    cr.Adjusted_System_Size__c = currentSize + (watts * quantity);
                    
                    system.debug('*****currentSize = ' + currentSize + ' watts = ' + watts + ' quantity = ' + quantity);
                    system.debug('*****cr.ASProject__r.AcctSeed__Opportunity__c = ' + cr.ASProject__r.AcctSeed__Opportunity__c);
                    system.debug('oppMap.get(cr.ASProject__r.AcctSeed__Opportunity__c).Project_System_Size__c = ' + oppMap.get(cr.ASProject__r.AcctSeed__Opportunity__c).Project_System_Size__c);
                }
            }
            
            if (ListOfNewConReq != null && ListOfNewConReq.size() > 0) {
                update ListOfNewConReq;
            }
        }
        */
        
        approveELI.IsRecursiveUpdate = false;
    }
}