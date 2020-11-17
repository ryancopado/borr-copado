public with sharing class CashDisbursementCtlExt {
    
    /*
     *  Set controller extension for Cash Disbursement object.
     *      - Send ACH Payment email for selected Cash Disbursement records.
     *
     */
    
    private final List<AcctSeed__Cash_Disbursement__c> cashDisbSelected;
    public String retURL {get; set;}
    
    public CashDisbursementCtlExt(ApexPages.StandardSetController controller) {
        this.cashDisbSelected = (List<AcctSeed__Cash_Disbursement__c>)controller.getSelected(); 
    }    
    
    public ApexPages.StandardSetController cashDisbRecords {
        get {
            if (cashDisbRecords == null) {
                cashDisbRecords = new ApexPages.StandardSetController(
                    Database.getQueryLocator([SELECT Id, Name, OK_To_Email__c, AcctSeed__Vendor__c FROM AcctSeed__Cash_Disbursement__c WHERE Id IN :cashDisbSelected]));
            }
            return cashDisbRecords;
        }
        private set;
    }
    public List<AcctSeed__Cash_Disbursement__c> getCashDisbRecs() {
        return (List<AcctSeed__Cash_Disbursement__c>)cashDisbRecords.getRecords();
    }
    
    // Send an ACH Payment email for selected Cash Disbursement records
    public PageReference sendACHEmail() {
        List<AcctSeed__Cash_Disbursement__c> cdList;
        PageReference pr = null;
        Boolean OkToEmail = true;
        Boolean billingContactsOk = true;
        Boolean apDisbursementsOk = true;
        String cdNames = '';
        
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        cdList = getCashDisbRecs();
        Set<Id> aIds = new Set<Id>();
        Set<Id> cdIds = new Set<Id>();
        for (AcctSeed__Cash_Disbursement__c cd :cdList) {
            cdIds.add(cd.Id);
            if (cd.AcctSeed__Vendor__c != null) {
                aIds.add(cd.AcctSeed__Vendor__c);
            }
            if (!cd.OK_To_Email__c) {
                OkToEmail = false;
                if (String.isBlank(cdNames)) {
                    cdNames = cd.Name;
                } else {
                    cdNames += ', ' + cd.Name;
                }
            }
        }
        
        if (!cdList.isEmpty() && OkToEmail) {
            
            // Get the Billing Contact email address for each Cash Disbursement record - verify that each
            // Cash Disbursement record has a valid Billing Contact email address
            List<Contact> billingContacts = new List<Contact>();
            billingContacts = [select Id, AccountId, Contact_Type__c, Email 
                    from Contact where AccountId in :aIds and Contact_Type__c includes ('Billing Contact')];
            Map<Id, List<Contact>> bcMap = new Map<Id, List<Contact>>();
            for (Contact c :billingContacts) {
                if (String.isNotBlank(c.Email)) {
                    if (!bcMap.containsKey(c.AccountId)) {
                        bcMap.put(c.AccountId, new List<Contact>());
                    }
                    bcMap.get(c.AccountId).add(c);
                }
            }
            
            for (AcctSeed__Cash_Disbursement__c cd :cdList) {
                if (!bcMap.containsKey(cd.AcctSeed__Vendor__c)) {
                    billingContactsOk = false;
                    if (String.isBlank(cdNames)) {
                        cdNames = cd.Name;
                    } else {
                        cdNames += ', ' + cd.Name;
                    }
                }
            }
            
            if (billingContactsOk) {
                
                // Get the AP Disbursement records for each Cash Disbursement record selected
                List<AcctSeed__AP_Disbursement__c> apdList = new List<AcctSeed__AP_Disbursement__c>();
                apdList = [select Id, Name, AcctSeed__Account_Payable__c, AcctSeed__Cash_Disbursement__c, 
                        AcctSeed__Account_Payable__r.AcctSeed__Payee_Reference__c, AcctSeed__Account_Payable__r.AcctSeed__Date__c, 
                        AcctSeed__Account_Payable__r.AcctSeed__Total__c, AcctSeed__Account_Payable__r.AcctSeed__Paid_Amount__c,AcctSeed__Cash_Disbursement__r.AcctSeed__Amount__c,AcctSeed__Paid_Amount__c 
                        from AcctSeed__AP_Disbursement__c where AcctSeed__Cash_Disbursement__c in :cdIds];
                Map<Id, List<AcctSeed__AP_Disbursement__c>> cdAPDMap = new Map<Id, List<AcctSeed__AP_Disbursement__c>>();
                for (AcctSeed__AP_Disbursement__c apd :apdList) {
                    if (!cdAPDMap.containsKey(apd.AcctSeed__Cash_Disbursement__c)) {
                        cdAPDMap.put(apd.AcctSeed__Cash_Disbursement__c, new List<AcctSeed__AP_Disbursement__c>());
                    }
                    cdAPDMap.get(apd.AcctSeed__Cash_Disbursement__c).add(apd);
                }
                
                // Verify there is at least one AP Disbursement per Cash Disbursement
                for (AcctSeed__Cash_Disbursement__c cd :cdList) {
                    if (!cdAPDMap.containsKey(cd.Id)) {
                        apDisbursementsOk = false;
                        if (String.isBlank(cdNames)) {
                            cdNames = cd.Name;
                        } else {
                            cdNames += ', ' + cd.Name;
                        }
                    }
                }
                
                if (apDisbursementsOk) {
                    
                    // Send ACH email for each Cash Disbursement
                    List<Messaging.SingleEmailMessage>  achEmailList = new List<Messaging.SingleEmailMessage>();
                    List<String> toAddresses = new List<String>();
                    String textBody;
                    String htmlBody;
                    String imgURL = 'https://c.' + system.URL.getSalesforceBaseUrl().getHost().substringBefore('.') + '.content.force.com/servlet/servlet.ImageServer?id=015300000005cLU&oid=' + UserInfo.getOrganizationId();
                    
                    for (AcctSeed__Cash_Disbursement__c cd :cdList) {
                        Messaging.SingleEmailMessage achEmail = new Messaging.SingleEmailMessage();
                        toAddresses.clear();
                        
                        //toAddresses.add('sthompto@gmail.com');
                        //toAddresses.add('pryder@borregosolar.com');
                        //toAddresses.add('elaramee@borregosolar.com');
                        
                        for (Contact c :bcMap.get(cd.AcctSeed__Vendor__c)) {
                            toAddresses.add(c.Email);
                        }
                        
                        system.debug('*****ACH EMAIL to addresses = ' + toAddresses);
                        
                        achEmail.setToAddresses(toAddresses);
                        achEmail.setReplyTo('apdocs@borregosolar.com');
                        achEmail.setSenderDisplayName('Borrego Solar Accounts Payable');
                        achEmail.setBccSender(true);
                        achEmail.setSubject('Borrego Solar ACH Payment');
                        
                        textBody = 'A payment has been made for the following invoice(s) and will be deposited in your account the next business day.\n';
                        
                        htmlBody = '<p>';
                        htmlBody += '<a href="http://www.borregosolar.com"><img src="' + imgURL + '" alt="Borrego Solar Logo" height="105" width="148"/></a>';
                        htmlBody += '</p>';
                        htmlBody += '<p>';
                        htmlBody += 'A payment has been made for the following invoice(s) and will be deposited in your account the next business day.';
                        htmlBody += '</p>';
                        String totalAmt;
                        Decimal tempTotal;
                        for (AcctSeed__AP_Disbursement__c apd :cdAPDMap.get(cd.Id)) {
                            if (apd.AcctSeed__Paid_Amount__c == null) {
                                totalAmt = '0.00';
                            } else {
                                tempTotal = Decimal.valueOf(Math.roundToLong(apd.AcctSeed__Paid_Amount__c * 100)) / 100;
                                totalAmt = (tempTotal.setScale(2) + (tempTotal >= 0 ? 0.001 : -0.001)).format();
                                totalAmt = totalAmt.substring(0, totalAmt.length() - 1);
                            }
                                                        
                            textBody += '\n';
                            textBody += 'Invoice Number:  ' + apd.AcctSeed__Account_Payable__r.AcctSeed__Payee_Reference__c + '\n';
                            textBody += 'Invoice Date:  ' + String.valueOf(apd.AcctSeed__Account_Payable__r.AcctSeed__Date__c) + '\n';
                            textBody += 'Total:  $' + totalAmt;
                            textBody += '\n';
                            
                            htmlBody += '<p>';
                            htmlBody += 'Invoice Number:  ' + apd.AcctSeed__Account_Payable__r.AcctSeed__Payee_Reference__c + '<br/>';
                            htmlBody += 'Invoice Date:  ' + String.valueOf(apd.AcctSeed__Account_Payable__r.AcctSeed__Date__c) + '<br/>';
                            htmlBody += 'Total:  $' + totalAmt;
                            htmlBody += '<p/>';
                        }
                        achEmail.setPlainTextBody(textBody);
                        achEmail.setHtmlBody(htmlBody);
                        achEmailList.add(achEmail);
                    }
                    
                    Messaging.sendEmail(achEmailList);
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.INFO, 'ACH email has been sent for all selected Cash Disbursement records.'));
                    
                } else {
                    ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'All Cash Disbursement records selected must have at least one AP Disbursement.  The following records do not: ' + cdNames));
                }
                
            } else {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'All Cash Disbursement records selected must have a valid Billing Contact.  The following records do not: ' + cdNames));
            }
            
        } else {
            if (cdList.isEmpty()) {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'Please select at least one Cash Disbursement record.'));
            } else {
                ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'All Cash Disbursement records selected must be "OK To Email".  The following records are not: ' + cdNames));
            }
        }
        
        
        
        return pr;
    }
}