public with sharing class ProjectListView_CreateCaseCtl {
    
    public class Contract_Class {
        public Contract contrct {get; set;}
        private String retURL;
        
        Contract_Class(Contract c, String r) {
            this.contrct = c;
            this.retURL = r;
        }
        
        public PageReference createCase() {
            
            String warrantyRecordTypeId = (this.contrct.Contract_Status__c != 'Active') ? String.valueOf(Schema.SObjectType.Case.getRecordTypeInfosByName().get('Warranty').getRecordTypeId()) : '';
            PageReference pr = new PageReference('/apex/Case_Contract?contractId=' + this.contrct.Id + '&caseRecordTypeId=' + warrantyRecordTypeId + '&retURL=' + this.retURL);
            pr.setRedirect(true);
        
            return pr;
        }
    }
    
    public List<Contract_Class> contractDisplayList {get; set;}
    
    public List<AcctSeed__Project__c> selectedProjects;
    
    private ApexPages.StandardSetController stdSetPro;
    private String roleName;
    
    public ProjectListView_CreateCaseCtl(ApexPages.StandardSetController stdSetPro) {
        List<Contract> lstQuery = new List<Contract>();
        String projectId;
        String retURL;
        
        this.stdSetPro = stdSetPro;
        selectedProjects = new List<AcctSeed__Project__c>();
        
        projectId = ApexPages.currentpage().getParameters().get('projectId');
        if (String.isNotBlank(projectId)) {
            retURL = '/' + projectId;
            selectedProjects.add(new AcctSeed__Project__c(Id = projectId));
        } else {
            retURL = '/apex/Project_Tab';
            selectedProjects = stdSetPro.getSelected();
        }
        
        contractDisplayList = new List<Contract_Class>();
        roleName = [select Id, Name from UserRole where Id = : UserInfo.getUserRoleId()].Name;
        
        if (selectedProjects.size() == 1) {
            lstQuery = [select Id, ContractNumber, ASProject__c, Type__c, Contract_Status__c FROM Contract WHERE ASProject__c = :selectedProjects[0].Id and (Contract_Status__c = 'Active' or Contract_Status__c = 'Expired' or Contract_Status__c = 'Paid Contract Complete')];
            for (Contract c :lstQuery) {
                if (roleName == 'O&M Warranty Project Manager') {
                    contractDisplayList.add(new Contract_Class(c, retURL));
                } else {
                    if (c.Contract_Status__c == 'Active') {
                        contractDisplayList.add(new Contract_Class(c, retURL));
                    }
                }
            }
        } else {
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR, 'You must select only one Project.'));
        }
    }
}