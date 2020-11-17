trigger ProjectCreate on SFDC_Project__c (before insert, before update) {
   
   /* ALL CODE COMMENTED OUT - TRIGGER IS NOT NECESSARY AND DOESN'T DO ANYTHING - 12/7/2018
   if(approveELI.IsRecursiveUpdate==null) approveELI.IsRecursiveUpdate=false;
    
    if(approveELI.IsRecursiveUpdate==false){
            
            if(Trigger.isInsert){
                ProjectCreate.createprojects(Trigger.new);
            }
            if(Trigger.isUpdate){
                List<SFDC_Project__c> upProj = new List<SFDC_Project__c>();
                List<SFDC_Project__c> upPCProj = new List<SFDC_Project__c>();
                for(Integer i = 0; i<Trigger.new.size(); i++){
                    if (Trigger.new[i].Branch__c != null) { 
                        
                        //if(Trigger.new[i].Pre_Contract__c != true && 
                                //((Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) ||
                                //(Trigger.new[i].Project_Type__c != Trigger.old[i].Project_Type__c))){
                            //upProj.add(Trigger.new[i]);
                        //}
                        
                        if (Trigger.new[i].Pre_Contract__c != true) {
                            if (Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) {
                                upProj.add(Trigger.new[i]);
                            } else {
                                if (Trigger.new[i].Project_Type__c != Trigger.old[i].Project_Type__c) {
                                    //Don't change the Project Job Number if only changing Project Type from Direct Sales to Smarts and Parts
                                    if (!((Trigger.old[i].Project_Type__c == 'Direct Sales') && (Trigger.new[i].Project_Type__c == 'Smarts and Parts'))) {
                                        upProj.add(Trigger.new[i]);
                                    }
                                }
                            }
                        }
        
                        if (Trigger.new[i].Pre_Contract__c == true) {
                            if (Trigger.new[i].Job_Number__c != null) {
                                if (Trigger.new[i].Job_Number__c.startsWith('950')) {
                                    if (Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) {
                                        upPCProj.add(Trigger.new[i]);
                                    }
                                } else {
                                    if (Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) {
                                        upProj.add(Trigger.new[i]);
                                    } else {
                                        if (Trigger.new[i].Project_Type__c != Trigger.old[i].Project_Type__c) {
                                            //Don't change the Project Job Number if only changing Project Type from Direct Sales to Smarts and Parts
                                            if (!((Trigger.old[i].Project_Type__c == 'Direct Sales') && (Trigger.new[i].Project_Type__c == 'Smarts and Parts'))) {
                                                upProj.add(Trigger.new[i]);
                                            }
                                        }
                                    }
                                    
                                    //if ( (Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) ||
                                         //(Trigger.new[i].Project_Type__c != Trigger.old[i].Project_Type__c) ) {
                                         //upProj.add(Trigger.new[i]);
                                    //}
                                    
                                }
                            } else {
                                if (Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) {
                                    upProj.add(Trigger.new[i]);
                                } else {
                                    if (Trigger.new[i].Project_Type__c != Trigger.old[i].Project_Type__c) {
                                        //Don't change the Project Job Number if only changing Project Type from Direct Sales to Smarts and Parts
                                        if (!((Trigger.old[i].Project_Type__c == 'Direct Sales') && (Trigger.new[i].Project_Type__c == 'Smarts and Parts'))) {
                                            upProj.add(Trigger.new[i]);
                                        }
                                    }
                                }
                                
                                //if ( (Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) ||
                                         //(Trigger.new[i].Project_Type__c != Trigger.old[i].Project_Type__c) ) {
                                         //upProj.add(Trigger.new[i]);
                                //}
                                
                            }
                        }
                    }
                }      
                if(upProj.size() > 0) {
                    ProjectCreate.upNum(upProj);
                }
                if(upPCProj.size() > 0) {
                    ProjectCreate.upJNum(upPCProj);
                }
            }
            
     }
     
     END OF COMMENTING OUT THE CODE - 12/7/2018 */
}