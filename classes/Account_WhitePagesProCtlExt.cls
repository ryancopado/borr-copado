public class Account_WhitePagesProCtlExt {
    
    /*
     *  Controller extension to update the phone number on selected Account records using WhitePages.
     */
    
    private ApexPages.StandardSetController stdSetCon;
    private Map<Id, Account> accMap;
    private String filterId;
    
    public List<Account> selectedAccounts;
    public Boolean isError {get; set;}
    
    public Account_WhitePagesProCtlExt(ApexPages.StandardSetController stdSetCon) {
        this.stdSetCon = stdSetCon;
        selectedAccounts = stdSetCon.getSelected();
        filterId = stdSetCon.getFilterId();
        isError = false;
        
        if (selectedAccounts.size() > 0 && selectedAccounts.size() <= 20) {
            Set<Id> accIds = new Set<Id>();
            for (Account a :selectedAccounts) {
                accIds.add(a.Id);
            }
            accMap = new Map<Id, Account>([select Id, Name, BillingCity, BillingCountry, BillingPostalCode, BillingState, BillingStreet, Owner_Name__c, Phone, Updated_with_WhitePages__c from Account where Id in :accIds]);
        } else {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select at least one and no more than 20 Account records.'));
            isError = true;
        }
    }
    
    // Update the first name, last name and phone number on the lead via WhitePages from address information
    public PageReference reverseAddress() {
        WhitePagesPro.WPP_RA_Response_Class raResp;
        String errors = 'WhitePages ReverseAddress Errors:';
        List<Account> accUpList = new List<Account>();
        Integer noPhoneCount = 0;
        PageReference pr = null;
        
        if (!isError) {
            
            try {
                for (Account a :accMap.values()) {
                    raResp = WhitePagesPro.reverseAddress(a.BillingStreet, null, a.BillingCity, a.BillingPostalCode, a.BillingState, a.BillingCountry);
                    if (raResp.result != 'SUCCESS') {
                        errors += ' Account = ' + a.Name + ', error = ' + raResp.result + ';';
                    } else if (raResp.reverseAddress.current_residents == null || raResp.reverseAddress.current_residents.isEmpty()) {
                        errors += ' Account = ' + a.Name + ', no current residents;';
                    } else if (raResp.reverseAddress.current_residents[0].id.startsWith('Person')) {
                        a.Owner_Name__c = raResp.reverseAddress.current_residents[0].firstname;
                        if (String.isNotBlank(a.Owner_Name__c)) {
                            a.Owner_Name__c += ' ';
                        }
                        a.Owner_Name__c += raResp.reverseAddress.current_residents[0].lastname;
                        if (raResp.reverseAddress.current_residents[0].phones == null || raResp.reverseAddress.current_residents[0].phones.isEmpty()) {
                            errors += ' Account = ' + a.Name + ', no phone number found;';
                            noPhoneCount++;
                        } else {
                            a.Phone = raResp.reverseAddress.current_residents[0].phones[0].phone_number;
                        }
                        a.Updated_with_WhitePages__c = system.now();
                        accUpList.add(a);
                    } else if (raResp.reverseAddress.current_residents[0].id.startsWith('Business')) {
                        a.Owner_Name__c = raResp.reverseAddress.current_residents[0].name;
                        if (raResp.reverseAddress.current_residents[0].phones == null || raResp.reverseAddress.current_residents[0].phones.isEmpty()) {
                            errors += ' Account = ' + a.Name + ', no phone number found;';
                            noPhoneCount++;
                        } else {
                            a.Phone = raResp.reverseAddress.current_residents[0].phones[0].phone_number;
                        }
                        a.Updated_with_WhitePages__c = system.now();
                        accUpList.add(a);
                    } else {
                        errors += ' Account = ' + a.Name + ', bad current residents id = ' + raResp.reverseAddress.current_residents[0].id + ';';
                    }
                }
                
                if (!accUpList.isEmpty()) {
                    update accUpList;
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'The owner name field was updated on ' + accUpList.size() + ' Account record(s) and the phone field was updated on ' + (accUpList.size() - noPhoneCount) + ' Account record(s).'));
                }
            } catch(Exception e) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Account update exception: ' + e.getMessage()));
            }
            
            if (errors != 'WhitePages ReverseAddress Errors:') {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, errors));
            }
        }
        
        return pr;
    }
}