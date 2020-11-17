trigger AS_ProjectCreate on AcctSeed__Project__c (before insert, before update) {
/*
   if(approveELI.IsRecursiveUpdate==null) approveELI.IsRecursiveUpdate=false;
    
    if(approveELI.IsRecursiveUpdate==false){
            
            if(Trigger.isInsert){
                List<AcctSeed__Project__c> newProjects = new List<AcctSeed__Project__c>();
                for (Integer i=0; i<Trigger.new.size(); i++) {
                    if (Trigger.new[i].AcctSeed__Opportunity__c != null) {
                        newProjects.add(Trigger.new[i]);
                    }
                }
                
                if(!newProjects.isEmpty()){
                    ProjectCreate.createprojects(newProjects);
                }
            }
            if(Trigger.isUpdate){
                List<AcctSeed__Project__c> upProj = new List<AcctSeed__Project__c>();
                List<AcctSeed__Project__c> upPCProj = new List<AcctSeed__Project__c>();
                for(Integer i = 0; i<Trigger.new.size(); i++){
                    if (Trigger.new[i].Branch__c != null) { 
                        if (Trigger.new[i].Pre_Contract__c != true) {
                            if (Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) {
                                upProj.add(Trigger.new[i]);
                            } else {
// CN: not mapping
                                //if (Trigger.new[i].Project_Type__c != Trigger.old[i].Project_Type__c) {
                                    //Don't change the Project Job Number if only changing Project Type from Direct Sales to Smarts and Parts
                                    //if (!((Trigger.old[i].Project_Type__c == 'Direct Sales') && (Trigger.new[i].Project_Type__c == 'Smarts and Parts'))) {
                                        //upProj.add(Trigger.new[i]);
                                    //}
                                //}
//
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
// CN: not mapping
                                        //if (Trigger.new[i].Project_Type__c != Trigger.old[i].Project_Type__c) {
                                            //Don't change the Project Job Number if only changing Project Type from Direct Sales to Smarts and Parts
                                            //if (!((Trigger.old[i].Project_Type__c == 'Direct Sales') && (Trigger.new[i].Project_Type__c == 'Smarts and Parts'))) {
                                                //upProj.add(Trigger.new[i]);
                                            //}
                                        //}
//
                                    }
                                }
                            } else {
                                if (Trigger.new[i].Branch__c != Trigger.old[i].Branch__c) {
                                    upProj.add(Trigger.new[i]);
                                } else {
// CN: not mapping
                                    //if (Trigger.new[i].Project_Type__c != Trigger.old[i].Project_Type__c) {
                                        //Don't change the Project Job Number if only changing Project Type from Direct Sales to Smarts and Parts
                                        //if (!((Trigger.old[i].Project_Type__c == 'Direct Sales') && (Trigger.new[i].Project_Type__c == 'Smarts and Parts'))) {
                                            //upProj.add(Trigger.new[i]);
                                        //}
                                    //}
//
                                }
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
            
            //workaround for the accountingseed problem where opportunity is not set on creation
            if(Trigger.isUpdate){
                
                List<AcctSeed__Project__c> newProjects = new List<AcctSeed__Project__c>();
                for (Integer i=0; i<Trigger.new.size(); i++) {
                    if (Trigger.old[i].AcctSeed__Opportunity__c == null && (Trigger.new[i].Job_Number__c == null || Trigger.new[i].Job_Number__c == '')  && Trigger.new[i].AcctSeed__Opportunity__c != null) {
                        newProjects.add(Trigger.new[i]);
                    }
                }
                if(!newProjects.isEmpty()){
                    ProjectCreate.createprojects(newProjects);
                }
            }
            
            
     }
*/
}