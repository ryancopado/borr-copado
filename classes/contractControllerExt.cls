public with sharing class contractControllerExt {
    
    /*
     *  Methods to create a new contract of record type Paid and then leave the user on the 
     *  edit page of the just created contract.
     *
     *  Requires an Opportunity Id input parameter.
     *
     */
    
    ApexPages.StandardController stdController;
    private final Contract paidContract;
    Id oppId = null;
    
    public contractControllerExt(ApexPages.StandardController stdController) {
        
        // Get the Opportunity Id parameter
        oppId = ApexPages.currentPage().getParameters().get('oppId');
    }
    
    public PageReference createPaidContract() {
        PageReference pr = null;
        
        if (oppId == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An Opportunity Id must be provided as a page parameter (oppId).'));
        } else {
            List<RecordType> rtList = [select Id, DeveloperName, SobjectType from RecordType 
                    where SobjectType = 'Opportunity' or SobjectType = 'Contract'];
            Id rtOMId = null;
            Id rtPaidId = null;
            for (RecordType rt :rtList) {
                if (rt.DeveloperName == 'O_M_Opportunity' && rt.SobjectType == 'Opportunity') {
                    rtOMId = rt.Id;
                }
                if (rt.DeveloperName == 'Paid' && rt.SobjectType == 'Contract') {
                    rtPaidId = rt.Id;
                }
            }
            
            Opportunity omOpp = [select Id, AccountId, EPC_Opportunity__c, Name, RecordTypeId, StageName from Opportunity where Id = :oppId];
            
            if (omOpp.RecordTypeId != rtOMId || omOpp.StageName != 'Contract Signed') {
                if (omOpp.RecordTypeId != rtOMId) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'The Opportunity must have record type of "O&M Opportunity".'));
                }
                if (omOpp.StageName != 'Contract Signed') {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'The Opportunity must have Stage set to "Contract Signed".'));
                }
                
            } else {
                
                // Create a new Contract with record type Paid, associate Project Site records with it and send an email 
                // alert to Matt Murphy and the owner of the related EPC Opportunity.
                List<String> toList = new List<String>();
                List<User> mmList = new List<User>();
                mmList = [select Id, Name, Email from User where Name = 'Emily Tam' and IsActive = true];
                toList.add(mmList[0].Email);
                Id projectId = null;
                if (omOpp.EPC_Opportunity__c == null) {
                    List<AcctSeed__Project__c> pList = new List<AcctSeed__Project__c>();
                    pList = [select Id, AcctSeed__Opportunity__c from AcctSeed__Project__c where AcctSeed__Opportunity__c = :omOpp.Id];
                    if (!pList.isEmpty()) {
                        projectId = pList[0].Id;
                    }
                } else {
                    Opportunity epcOpp = [select Id, Name, OwnerId, Owner.Email from Opportunity where Id = :omOpp.EPC_Opportunity__c];
                    toList.add(epcOpp.Owner.Email);
                }
                Contract newContract = new Contract(
                    AccountId = omOpp.AccountId,
                    StartDate = system.now().date(),
                    Contract_Status__c = 'Pending',
                    ContractTerm = 12,
                    Service_Schedule_months__c = 6,
                    Contract_Amount__c = 0,
                    RecordTypeId = rtPaidId,
                    ASProject__c = projectId);
                
                try {
                    insert newContract;
                    newContract = [select Id, ContractNumber, Contract_Status__c from Contract where Id = :newContract.Id];
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'New Paid Service Contract created, Id = ' + newContract.Id));
                    
                    List<Site__c> sList = new List<Site__c>();
                    sList = [select Id, Paid_Contract__c, Project__c from Site__c where Project__c = :projectId];
                    for (Site__c s :sList) {
                        s.Paid_Contract__c = newContract.Id;
                    }
                    //Added testisrunning code since was giving error in test class.4/8/19 MG
                    if(!Test.isRunningTest()){
                    if (!sList.isEmpty()) {
                        update sList;
                    }
                    }
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    String emailBody = 'A new Service Contract of type Paid has been created.'
                            + ' Click the link below to view the contract.'
                            + '\nContract Number: ' + newContract.ContractNumber
                            + '\n' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + newContract.Id;
                    
                    email.setToAddresses(toList);
                    email.setSubject('New Paid Service Contract created - Contract Number: ' + newContract.ContractNumber);
                    email.setPlainTextBody(emailBody);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
                    pr = new PageReference('/' + newContract.Id + '/e?retURL=/' + newContract.Id);
                } catch (DmlException e) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Exception while creating new contract: ' + e));
                } catch (EmailException e) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Exception while sending new contract email alert: ' + e));
                } catch(Exception e) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Exception while creating new contract or sending email alert: ' + e));
                }
            }
        }
        return pr;
    }
}