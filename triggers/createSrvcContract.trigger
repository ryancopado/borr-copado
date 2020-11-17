trigger createSrvcContract on SFDC_Project__c (after insert, after update) {

   if(approveELI.IsRecursiveUpdate==null) approveELI.IsRecursiveUpdate=false;
    
    if(approveELI.IsRecursiveUpdate==false){

          //If a Project has just received 'Application Complete' status (Int Conn), create a Service Contract
          List<Contract> ListOfContract =new List<Contract>();
          List<SFDC_Project__c> srvcContractCreate = new List<SFDC_Project__c>();
         
          for (Integer i=0; i<Trigger.new.size(); i++) {
            //As per CR on 12th Jan 2012: "Create Service Contract upon “Design Stage = As Built”"
            //if (Trigger.new[i].Interconnection_Status__c == 'Application Complete') {
            if (Trigger.new[i].Design_Stage__c  == 'As Built') {
              if (Trigger.isInsert) {
                srvcContractCreate.add(Trigger.new[i]);
                
               
                Contract Contract=new Contract();
                Contract.Accountid=Trigger.new[i].Account__c;        
                Contract.StartDate=system.now().date();
                Contract.ContractTerm=12;        
                Contract.Service_Schedule_months__c=6;                
                Contract.Contract_Amount__c=0;  
                Contract.Project__c=Trigger.new[i].id;
                ListOfContract.add( Contract);    
              }
              if (Trigger.isUpdate) {
              
                //if (Trigger.old[i].Interconnection_Status__c != 'Application Complete') {
                if (Trigger.old[i].Interconnection_Status__c != 'As Built') {
                
                    List<Contract> ListOfTempContract=[select id from Contract where Project__c in :Trigger.NewMap.keySet()];
                  
                    if (ListOfTempContract.size()<=0){
         
                              srvcContractCreate.add(Trigger.new[i]);
                                Contract Contract=new Contract();
                                Contract.Accountid=Trigger.new[i].Account__c; 
                                Contract.StartDate=system.now().date();
                                Contract.ContractTerm=12;        
                                Contract.Service_Schedule_months__c=6;                
                                Contract.Contract_Amount__c=0;  
                                Contract.Project__c=Trigger.new[i].id;  
                                
                                ListOfContract.add( Contract);
                          }
                          
                }/* else {
                  if (Trigger.new[i].PTO_Date__c != Trigger.old[i].PTO_Date__c) {
                    srvcContractCreate.add(Trigger.new[i]);
                  }
                }*/
              }
            }
          }
          if (ListOfContract.size()>0)
              insert ListOfContract;
              
          System.debug('Test End');
      }
  }