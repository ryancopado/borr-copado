public class ServiceCostsThisYearRollUp {
	/*
	private ApexPages.StandardSetController setController;
	public String filterId {get; private set;}
	public Boolean isError {get; private set;}
	public Boolean isProcessed {get; private set;}
	private List<Id> svConIds = new List<Id>();
	public List<Contract> selectedSVCons {get; private set;}
	
	public ServiceCostsThisYearRollUp(ApexPages.StandardSetController setController) {
                                
        selectedSVCons = new List<Contract>();
        this.setController = setController;
        filterId = setController.getFilterId().subString(0,15);
        isError = FALSE;
        isProcessed = FALSE;
		for (Contract con : (Contract[])setController.getSelected()) {
			svConIds.add(con.Id);
		}
		
		if (svConIds.size() > 0) {
			selectedSVCons = [SELECT Id, ContractNumber, Project__c, Acct_Branch__c, Contract_Number__c, Type__c, Contract_Status__c, Service_Costs_this_year__c FROM Contract WHERE Id IN: svConIds];
		} else {
			isError = TRUE;
			ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.INFO, 'You must select at least one Service Contract.'));
		}
    }
    
    public PageReference rollupServiceCosts() {
        
         Savepoint sp = Database.setSavepoint();
        
        try {
            ServiceCostsThisYearRollUpUtility.rollUpServiceCosts(svConIds);
            selectedSVCons = [SELECT Id, ContractNumber, Project__c, Acct_Branch__c, Contract_Number__c, Type__c, Contract_Status__c, Service_Costs_this_year__c FROM Contract WHERE Id IN: svConIds];
            ApexPages.addmessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Service Costs (this year) has been recalculated for ' + svConIds.size() + ' Service Contracts.'));
            isProcessed = TRUE;   
        }
        catch (Exception ex) {
            Database.rollback(sp);
            ApexPages.addMessages(ex);
        }
        
        return null;
    }
    
    @IsTest(SeeAllData=true)
    public static void testServiceCostsThisYearRollUp() {
        List<Account> accounts = new List<Account>();
        
        accounts.add(
            new Account(
                Name = 'TOOTALOO',
                AcctSeed__Accounting_Type__c = 'Customer and Vendor',
                AcctSeed__Credit_Card_Vendor__c = true,
                ShippingCity = 'Park City'
            )
        );

        accounts.add(
            new Account(
                Name = 'LOOTJUNK',
                AcctSeed__Accounting_Type__c = 'Customer and Vendor',
                AcctSeed__Credit_Card_Vendor__c = true,
                ShippingCity = 'Park City'
            )
        );
        
        accounts.add(
            new Account(
                Name = 'JAMBONAROO',
                AcctSeed__Accounting_Type__c = 'Customer and Vendor',
                AcctSeed__Credit_Card_Vendor__c = true,
                ShippingCity = 'Park City'
            )
        );            
        insert accounts;
        
        accounts[0].AcctSeed__Accounting_Type__c = 'Vendor';
        accounts[1].AcctSeed__Accounting_Type__c = 'Vendor';
        accounts[2].AcctSeed__Accounting_Type__c = 'Vendor';
        update accounts;
        
        // Create a Service Contract and Service Visits
        List<Contract> svContracts = new List<Contract>();
        svContracts.add(
        	new Contract(
        		AccountId = accounts[0].Id,
        		Contract_Amount__c = 30000,
        		ContractTerm = 120,
        		Service_Schedule_months__c = 12
        	)
        );
        insert svContracts;
        
        List<SV__c> serviceVisits = new List<SV__c>();
        serviceVisits.add(
        	new SV__c(
        		Account__c = accounts[0].Id,
        		Visit_Date__c = system.today(),
        		Visit_Reason__c = 'Reactive Service',
        		Vegetation__c = '6"',
        		Soiling__c = 'Light',
        		Weather_Conditions__c = 'Sunny',
        		Cost__c = 500,
        		Status__c = 'Complete',
        		Contract__c = svContracts[0].Id,
        		Notes__c = 'This is a note'
        	)
        );
        serviceVisits.add(
        	new SV__c(
        		Account__c = accounts[0].Id,
        		Visit_Date__c = system.today(),
        		Visit_Reason__c = 'Reactive Service',
        		Vegetation__c = '6"',
        		Soiling__c = 'Light',
        		Weather_Conditions__c = 'Sunny',
        		Cost__c = 500,
        		Status__c = 'Complete',
        		Contract__c = svContracts[0].Id,
        		Notes__c = 'This is a note'
        	)
        );
        insert serviceVisits;
        
        ApexPages.StandardSetController setController = new ApexPages.StandardSetController(svContracts);
        ServiceCostsThisYearRollUp rusc = new ServiceCostsThisYearRollUp(setController);

        rusc.rollupServiceCosts();
        
    }
    */
}