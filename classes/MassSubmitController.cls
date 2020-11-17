public class MassSubmitController {
    
    public AcctSeed__Billing__c billing {get; set;}
    private Set<String> billingIds = new Set<String>();
    
    public MassSubmitController(ApexPages.StandardSetController controller) {
        for (SObject billing : controller.getSelected()) {
            billingIds.add(billing.Id);
        }
        billing = new AcctSeed__Billing__c();
    }
    
    public PageReference submit() {
        try {
            System.debug(billingIds);
            System.debug(billing.User__c);
            
            List<AcctSeed__Billing__c> selectedBillings = [
                SELECT Id, User__c, Mass_Submit_for_Approval__c
                FROM AcctSeed__Billing__c
                WHERE Id IN :billingIds
            ];
            System.debug(selectedBillings);
            
            if (billing.User__c != null && !selectedBillings.isEmpty()) {
                List<Approval.ProcessSubmitRequest> approvalProcesses = new List<Approval.ProcessSubmitRequest>();
                
                for (AcctSeed__Billing__c record : selectedBillings) {
                
                    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                    req.setComments('Submitting request for approval.');
                    req.setObjectId(record.Id);
                    req.setProcessDefinitionNameOrId('Billings_Approval_Tom');
                    req.setSkipEntryCriteria(true);
                    req.setNextApproverIds(new List<Id>{billing.User__c});
                    approvalProcesses.add(req);
                    record.Mass_Submit_for_Approval__c = true;
                    record.User__c = billing.User__c;
                }
                System.debug(approvalProcesses);
                
                List<Approval.ProcessResult> results = Approval.process(approvalProcesses);
                System.debug(results);
                update selectedBillings;
            }
            
            String retUrl = apexpages.currentpage().getParameters().get('retURL');
            String baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
            
            return new PageReference(baseUrl + retUrl);
        } catch(Exception e) {
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.FATAL, e.getMessage()));
            return null;
        }
        
    }
    
}