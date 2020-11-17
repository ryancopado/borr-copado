trigger contract on Contract (before insert,before Update) {
    //contractNum.create(Trigger.new);
    
    
      

    
    
    
    
    String Prefix='';
    Integer Code;
    
    String StrJobNoForBerkeley;
    String StrJobNoForBoston;
    String StrJobNoForSanDiego;
    String StrJobNoForMidAtlantic;  
    String StrJobNoForPuertoRico;      
              
    string JobNOForBerkeley;
    string JobNOForBoston;
    string JobNOForSanDiego;
    string JobNOForMidAtlantic;
    string JobNOForPuertoRico;
  
    List<Contract> ListOfContract=[select Contract_Number__c,JobNo__C from Contract  
                                                Where Contract_Number__c!='' and Contract_Number__c!=null and Acct_Branch__c = 'Berkeley' and JobNo__C!=null and JobNo__C!=''  order by JobNo__C desc Limit 1];
    

    
    if(ListOfContract.size()>=1)
    {
        StrJobNoForBerkeley=(string) ListOfContract[0].Contract_Number__c ;
        JobNOForBerkeley=(string) ListOfContract[0].JobNo__C ;
    }
    
    ListOfContract=[select Contract_Number__c,JobNo__C from Contract  
                                                Where Contract_Number__c!='' and Contract_Number__c!=null and Acct_Branch__c = 'Boston' and JobNo__C!=null and JobNo__C!=''  order by JobNo__C desc Limit 1];
    

    
    if(ListOfContract.size()>=1)
    {
        StrJobNoForBoston=(string) ListOfContract[0].Contract_Number__c ;
        JobNOForBoston=(string) ListOfContract[0].JobNo__C ;
    }
    
    ListOfContract=[select Contract_Number__c,JobNo__C from Contract  
                                                Where Contract_Number__c!='' and Contract_Number__c!=null and Acct_Branch__c = 'San Diego' and JobNo__C!=null and JobNo__C!=''  order by JobNo__C desc Limit 1];
    

    
    if(ListOfContract.size()>=1)
    {
        StrJobNoForSanDiego=(string) ListOfContract[0].Contract_Number__c ;
        JobNOForSanDiego=(string) ListOfContract[0].JobNo__C ;
    }
    
   ListOfContract=[select Contract_Number__c,JobNo__C from Contract  
                                                Where Contract_Number__c!='' and Contract_Number__c!=null and Acct_Branch__c = 'Mid Atlantic' and JobNo__C!=null and JobNo__C!=''  order by JobNo__C desc Limit 1];
    

    
    if(ListOfContract.size()>=1)
    {
        StrJobNoForMidAtlantic=(string) ListOfContract[0].Contract_Number__c ;
        JobNOForMidAtlantic=(string) ListOfContract[0].JobNo__C ;
    }    
    
   ListOfContract=[select Contract_Number__c,JobNo__C from Contract  
                                                Where Contract_Number__c!='' and Contract_Number__c!=null and Acct_Branch__c = 'Puerto Rico' and JobNo__C!=null and JobNo__C!=''  order by JobNo__C desc Limit 1];
    

    
    if(ListOfContract.size()>=1)
    {
        StrJobNoForPuertoRico=(string) ListOfContract[0].Contract_Number__c ;
        JobNOForPuertoRico=(string) ListOfContract[0].JobNo__C ;
    } 
    
    
    
    List<id> ListOfProjectID=new List<ID>();    
    Map<id,id> MapOfUser=new Map<id,id>();
    
    for(Contract Contract:Trigger.new)
    {
        ListOfProjectID.Add(Contract.ASProject__c);
    }
    
    for(AcctSeed__Project__c Project:[Select id,OwnerID from AcctSeed__Project__c where ID in :ListOfProjectID])
    {
        MapOfUser.Put(Project.id,Project.OwnerID);
    } 
    
    
   // system.debug('Job Code===='+StrJobNo);    
    
    

    For(Contract Contract: Trigger.New){
    
    
    
     if(Contract.Acct_Branch__c == 'Berkeley')  {
                if (StrJobNoForBerkeley!='' && StrJobNoForBerkeley!=null && StrJobNoForBerkeley.length()==8 && JobNOForBerkeley!='null' && JobNOForBerkeley.length()==4) 
                        Code= Integer.valueof(JobNOForBerkeley)+1;
                Else
                        Code=1;       
                        
                JobNOForBerkeley=string.Valueof(Code);
              }
        if(Contract.Acct_Branch__c == 'Boston')   {
                if (StrJobNoForBoston!='' && StrJobNoForBoston!=null && StrJobNoForBoston.length()==8 && JobNOForBoston!='null' && JobNOForBoston.length()==4) 
                        Code= Integer.valueof(JobNOForBoston)+1;
                Else
                        Code=1;       
                        
                JobNOForBoston=string.Valueof(Code);
              }
        if(Contract.Acct_Branch__c == 'San Diego')  {
                if (StrJobNoForSanDiego!='' && StrJobNoForSanDiego!=null && StrJobNoForSanDiego.length()==8 && JobNOForSanDiego!='null' && JobNOForSanDiego.length()==4) 
                        Code= Integer.valueof(JobNOForSanDiego)+1;
                Else
                        Code=1;       
                        
                JobNOForSanDiego=string.Valueof(Code);
              }
        if(Contract.Acct_Branch__c == 'Mid Atlantic')   {
                if (StrJobNoForMidAtlantic!='' && StrJobNoForMidAtlantic!=null && StrJobNoForMidAtlantic.length()==8 && JobNOForMidAtlantic!='null' && JobNOForMidAtlantic.length()==4) 
                        Code= Integer.valueof(JobNOForMidAtlantic)+1;
                Else
                        Code=1;       
                        
                JobNOForMidAtlantic=string.Valueof(Code);
              }
                
                
     if(Contract.Acct_Branch__c == 'Puerto Rico')   {
                if (StrJobNoForPuertoRico!='' && StrJobNoForPuertoRico!=null && StrJobNoForPuertoRico.length()==8 && JobNOForPuertoRico!='null' && JobNOForPuertoRico.length()==4) 
                        Code= Integer.valueof(JobNOForPuertoRico)+1;
                Else
                        Code=1;       
                        
                JobNOForPuertoRico=string.Valueof(Code);
              }
        
        
    
     ID ProjectId=MapOfUser.Get(Contract.ASProject__c);
     
     system.debug('User ======' + ProjectId);
     
     Contract.PM__c=ProjectId;
     
    
        if(Contract.Type__c =='Warranty and Paid'){
     system.debug('Branch==='+ (string) Contract.Account.Branch__c);        
             
           
        if(Contract.Acct_Branch__c == 'Berkeley')  
                Prefix = '802';         
        if(Contract.Acct_Branch__c == 'Boston')  
                Prefix = '805';        
        if(Contract.Acct_Branch__c == 'San Diego') 
                Prefix = '801';         
        if(Contract.Acct_Branch__c == 'Mid Atlantic')  
                Prefix = '808';        
        if(Contract.Acct_Branch__c == 'Puerto Rico')  
                Prefix = '809';      
                 
        String finalCode;
                 

                
                       
        
        if (Trigger.isInsert){
                if(code < 10){
                    finalCode = '000'+code;
                } else if (code >= 10 && code < 100) {
                    finalCode = '00'+code;
                } else if (code >= 100 && code < 1000) {
                    finalCode = '0'+code;
                } else {
                    finalCode = code+'';
                }  
                  Contract.Contract_Number__c=Prefix + '-' +finalCode ;    
        }
        
        if (Trigger.IsUpdate){
              if (Contract.Contract_Number__c!='' 
                  && Contract.Contract_Number__c!=null 
                  && Contract.Contract_Number__c.length()==8){
                                        finalCode =Contract.Contract_Number__c.SubString(4,8);       
                                             
              }     
              else
                    if(code < 10){
                        finalCode = '000'+code;
                    } else if (code >= 10 && code < 100) {
                        finalCode = '00'+code;
                    } else if (code >= 100 && code < 1000) {
                        finalCode = '0'+code;
                    } else {
                        finalCode = code+'';
                    } 
                    Contract.Contract_Number__c=Prefix + '-' +finalCode ; 
        }
        
              
                 
            ListOfContract.add(Contract);
                
        }
    
    }
/*    
       if (trigger.isUpdate==true){
       
       For(Contract Contract:Trigger.NewMap.values()){
           Contract.Service_Costs_this_year__c=0;
       }
        
        For(Service_PO__c  ServicePo: [Select s.SCR_Total_Cost__c
            , s.Service_Construction_Requisition__r.Service_Visit__r.Contract__c 
            from Service_PO__c s  where s.SCR_Status__c <> 'Cancel' 
            and  CALENDAR_YEAR(s.CreatedDate)=2011 
            and s.Service_Construction_Requisition__r.Service_Visit__r.Contract__c in :Trigger.NewMap.Keyset()]){
            
                Contract Contract=Trigger.NewMap.Get(ServicePo.Service_Construction_Requisition__r.Service_Visit__r.Contract__c);
                if (Contract!=null)
                    Contract.Service_Costs_this_year__c+=ServicePo.SCR_Total_Cost__c;
            }
    }
*/    
   // UpSert ListOfContract;
    
}