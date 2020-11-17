public class APLineUtilities {
    
    // Account Payable Line utility methods
    
    public static void aplSetBranch(Map<Id, AcctSeed__Project__c> projMap, List<AcctSeed__Account_Payable_Line__c> aplList) {
        
        // For all AP Line records, map the value of the associated Project field Branch__c to the AP Line fields
        // Branch__c and AcctSeed__GL_Account_Variable_1__c
        
        List<AcctSeed__Accounting_Variable__c> avList = new List<AcctSeed__Accounting_Variable__c>();
        Map<String, AcctSeed__Accounting_Variable__c> avMap = new Map<String, AcctSeed__Accounting_Variable__c>();
        String projectBranch;
        
        // Create a mapping between Accounting Variable Name field values and Accounting Variable records
        avList = [SELECT Id, Name, AcctSeed__Active__c, AcctSeed__Type__c FROM AcctSeed__Accounting_Variable__c 
                    WHERE AcctSeed__Active__c =: TRUE AND AcctSeed__Type__c =: 'GL Account Variable 1'];
                    system.debug('AVLIST' +avList);
        for (AcctSeed__Accounting_Variable__c av : avList) {
        System.debug('entering for');
            if (!avMap.containsKey(av.Name)) {
                avMap.put(av.Name, av);
            }
         system.debug('AVMAP' +av.Name);   
         //AcctSeed__Accounting_Variable__c projectbranchname=avMap.get(av.Name);
        }
        
     
        
        // Iterate through the supplied list of Account Payable Line records and set the Branch__c and AcctSeed__GL_Account_Variable_1__c fields
        for (AcctSeed__Account_Payable_Line__c apl : aplList) {
            
            if (apl.AcctSeed__Project__c != NULL && projMap.containsKey(apl.AcctSeed__Project__c)) {
            
                projectBranch = projMap.get(apl.AcctSeed__Project__c).Branch__c;
                system.debug('Branch' + projectBranch);
               List<AcctSeed__Accounting_Variable__c>branchid=new List<AcctSeed__Accounting_Variable__c>();
              
         branchid=[select id,Name from AcctSeed__Accounting_Variable__c where Name=:projectBranch];
         if(branchid.size()>0)
         {
         system.debug('entering if' +branchid);
          AcctSeed__Accounting_Variable__c branchrecords= new AcctSeed__Accounting_Variable__c();
          branchrecords=branchid.get(0);
          
               apl.AcctSeed__GL_Account_Variable_1__c = branchrecords.Id ; 
               apl.Branch__c= branchrecords.Name;
               system.debug('APL BRANCH' + apl.Branch__c);
               }
                
               /* if (projectBranch != NULL) {
                 
                    
                    if (projectBranch == 'Boston' && avMap.containsKey('New England')) {
                        apl.AcctSeed__GL_Account_Variable_1__c = avMap.get('New England').Id;
                        apl.Branch__c = 'New England';
                    }
                    
                    if (projectBranch == 'Mid Atlantic' && avmap.containsKey('Mid Atlantic')) {
                        apl.AcctSeed__GL_Account_Variable_1__c = avMap.get('Mid Atlantic').Id;
                    }
                    
                    if (projectBranch == 'San Diego' && avMap.containsKey('So Cal')) {
                        apl.AcctSeed__GL_Account_Variable_1__c = avMap.get('So Cal').Id;
                        apl.Branch__c = 'So Cal';
                    }
                    
                    if (projectBranch == 'Puerto Rico' && avMap.containsKey('Puerto Rico')) {
                        apl.AcctSeed__GL_Account_Variable_1__c = avMap.get('Puerto Rico').Id;
                    }
                    
                    if (projectBranch == 'Oakland' && avMap.containsKey('Nor Cal')) {
                        apl.AcctSeed__GL_Account_Variable_1__c = avMap.get('Nor Cal').Id;
                        apl.Branch__c = 'Nor Cal';
                    }
                    
                    if (projectBranch == 'Berkeley' && avMap.containsKey('Nor Cal')) {
                        apl.AcctSeed__GL_Account_Variable_1__c = avMap.get('Nor Cal').Id;
                        apl.Branch__c = 'Nor Cal';
                    }
                    
                    // Added By Madan - Dec 11, 2017(populate two newly added branches)
                    if(projectBranch == 'Mid Atlantic' && avMap.containsKey('Mid-Atlantic')) {
                        apl.AcctSeed__GL_Account_Variable_1__c = avMap.get('Mid-Atlantic').Id;
                        apl.Branch__c = 'Mid Atlantic';
                    }
                    
                    // Added By Madan - Dec 11, 2017(populate two newly added branches)
                    if(projectBranch == 'Midwest' && avMap.containsKey('Midwest')) {
                        apl.AcctSeed__GL_Account_Variable_1__c = avMap.get('Midwest').Id;
                        apl.Branch__c = 'Midwest';
                    }
                }*/
            }
        }
    }
}