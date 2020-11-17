public with sharing class createcaselightning {
    @AuraEnabled
     public  static List<Contract> ProjectId(Id ProId) 
    {
         String roleName;
        
         List<Contract> lstQuery = new List<Contract>();
        roleName = [select Id, Name from UserRole where Id = : UserInfo.getUserRoleId()].Name;
         
        if (roleName == 'O&M Warranty Project Manager')
        {
           lstQuery=[select Id, ContractNumber, ASProject__r.Name, Type__c, Contract_Status__c FROM Contract WHERE ASProject__c = :ProId and (Contract_Status__c = 'Active' or Contract_Status__c = 'Expired' or Contract_Status__c = 'Paid Contract Complete')];
        }
        else
        {
            lstQuery=[select Id, ContractNumber, ASProject__r.Name, Type__c, Contract_Status__c FROM Contract WHERE ASProject__c = :ProId and contract_Status__c = 'Active'];
        }
        system.debug('List' +lstQuery);
        return lstQuery;
        
}
    public static Map<Id, String> recordTypeList;
     @AuraEnabled
    public static  Map<Id, String> fetchRecordTypeValues(Id objectname)
    {
        system.debug('con id' +objectname);
        
        Contract svcon= new Contract();
        List<Contract>svCon1=new List<contract>();
     
       svCon1 = [select Id, Type__c from Contract where Id = :objectname];
        
        if(svCon1.size()>0)
        {
            svcon=svCon1.get(0);
        }
        system.debug('Contarct' +svCon);

        Map<String, ContractTypeCaseRecordTypes__c> ctcrtMap = ContractTypeCaseRecordTypes__c.getAll();
        recordTypeList = new  Map<Id, String>();
                 
                    system.debug('contract type' +ctcrtMap);
                    Map<String, Set<String>> allowedRtMap = new Map<String, Set<String>>();
                    for (String ct :ctcrtMap.keySet()) {
                        allowedRtMap.put(ct, new Set<String>());
                        allowedRtMap.get(ct).addAll(ctcrtMap.get(ct).Case_Record_Types__c.split(';', 0));
                        
                    }
        system.debug('allowed Rt' +allowedRtMap);
                    
                    // Determine case record type list for user selection
                   //

                  Map<Id, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Case.getRecordTypeInfosById();
                   
                    for (Id rt: rtMap.keySet()) {
                        system.debug('enterig for' +rt);
                        if (rtMap.get(rt).isAvailable() && rtMap.get(rt).getName() != 'Master') {
                            system.debug('entering If' +svCon.Type__c);
                            if ( (String.isNotBlank(svCon.Type__c))&& 
                                 (allowedRtMap.containsKey(svCon.Type__c)) && 
                                 (allowedRtMap.get(svCon.Type__c).contains(rtMap.get(rt).getName())) )
                                  {
                                     system.debug('entering If second');
                                
                                recordTypeList.put(rt, rtMap.get(rt).getName());
                               /* if (rtMap.get(rt).isDefaultRecordTypeMapping()) {
                                    selectedRecordTypeId = rt;
                                }*/
                            }
                        }
                    }
        system.debug('final list'  +recordTypeList);
        
        return recordTypeList;
        
}
    @AuraEnabled
    public  static List<Contract> editpage(Id contractid) 
    {
         List<Contract>svCon1=new List<contract>();
   
       svCon1 = [select Id, Type__c,ContractNumber, ASProject__c,Branch__c,Contract_Status__c,AccountId from Contract where Id = :contractid];
        system.debug('contract list' +svCon1);
       return svCon1;
        
        
    }
    
    
}