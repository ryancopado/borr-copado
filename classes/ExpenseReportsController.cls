public class ExpenseReportsController {
    Set<Id> setSelectedId = new Set<Id>();
    String retUrl;
    public ExpenseReportsController(ApexPages.StandardSetController stdSetCont) {
        if(ApexPages.currentPage().getParameters().containsKey('retUrl')) {
            retUrl = ApexPages.currentPage().getParameters().get('retUrl');
        }
        
        for(sObject selectedObj:stdSetCont.getSelected()) {
            setSelectedId.add((Id)selectedObj.get('Id'));
            
            
        }
    }
    
    public PageReference doLoad() {
        Savepoint sp = Database.setSavepoint();
        try {
            System.debug('=============setSelectedId: ' + setSelectedId);
            
            if(setSelectedId.size() > 0) {
                //List<AcctSeed__Journal_Entry__c> insertJournalEntries = new List<AcctSeed__Journal_Entry__c>();
                Map<Integer,List<AcctSeed__Journal_Entry_Line__c>> mapJEI = new Map<Integer,List<AcctSeed__Journal_Entry_Line__c>>();
                
				// Create Single Journal Entry Record
				AcctSeed__Journal_Entry__c JE = new AcctSeed__Journal_Entry__c();
				JE.AcctSeed__Journal_Date__c = System.today();
				JE.Name = System.now().format('yyyyMMdd') + ' Expense Reports';
				
				AcctSeed__Accounting_Period__c accPeriod;
				// Search Accounting Period Record for current Month
				String periodName = System.now().year() + '-' + System.now().format('MM');
				for(AcctSeed__Accounting_Period__c aPeriod:[Select Id From AcctSeed__Accounting_Period__c Where Name=:periodName Limit 1]) {
					accPeriod = aPeriod;
				}
				
				// Create new Accounting Period Record for current Month if not exist in Open Stage
				if(accPeriod == null) {
					Integer numberOfDays = Date.daysInMonth(System.now().year(), System.now().month());
					accPeriod = new AcctSeed__Accounting_Period__c(
										Name=periodName,
										AcctSeed__Start_Date__c=Date.newInstance(System.now().year(),System.now().month(),1),
										AcctSeed__End_Date__c=Date.newInstance(System.now().year(),System.now().month(),numberOfDays),
										AcctSeed__Status__c='Open');
					insert accPeriod;
				}
				
				JE.AcctSeed__Accounting_Period__c = accPeriod.Id;
				insert JE;
				
				List<AcctSeed__Expense_Report__c> lstExpenseReport = [Select Id,
                                                        (Select Id, AcctSeed__Expense_GL_Account__c,Branch__c,AcctSeed__Date__c,
                                                                AcctSeed__Project__c,Sales_Segment__c,AcctSeed__Amount__c,
                                                                AcctSeed__Project_Task__c,AcctSeed__Internal_Comment__c,Ops_Division__c
                                                            From AcctSeed__Expense_Lines__r) 
                                                        From AcctSeed__Expense_Report__c a 
                                                    Where Id IN:setSelectedId];
				
				// Collect Branch Name to populate Branch Lookup
				Set<String> setBranchName = new Set<String>();
				for(AcctSeed__Expense_Report__c er:lstExpenseReport) {
					for(AcctSeed__Expense_Line__c expLine:er.AcctSeed__Expense_Lines__r) {
                    	if(expLine.Branch__c != null) {
                    		if(expLine.Branch__c == 'Mid Atlantic') {
                    			setBranchName.add('Mid-Atlantic');
                    		}
                    		setBranchName.add(expLine.Branch__c);
                    	}
					}
				}
				map<String,AcctSeed__Accounting_Variable__c> mapBranchToAccountingVar = new Map<String,AcctSeed__Accounting_Variable__c>();
				
				if(setBranchName.size() > 0) {
					for(AcctSeed__Accounting_Variable__c branch:[Select Id,Name From AcctSeed__Accounting_Variable__c 
																					Where AcctSeed__Type__c='GL Account Variable 1' AND 
																					AcctSeed__Active__c=true AND
																					Name IN:setBranchName]) {
						if(branch.Name == 'Mid-Atlantic') {
                			mapBranchToAccountingVar.put('Mid Atlantic',branch);
                		}
						mapBranchToAccountingVar.put(branch.Name,branch);
						
					}
				}
				
				Integer index = 0;
				for(AcctSeed__Expense_Report__c er:lstExpenseReport) {
                    
                    mapJEI.put(index,new List<AcctSeed__Journal_Entry_Line__c>());
                    for(AcctSeed__Expense_Line__c expLine:er.AcctSeed__Expense_Lines__r) {
                        AcctSeed__Journal_Entry_Line__c jei = new AcctSeed__Journal_Entry_Line__c();
                        jei.AcctSeed__GL_Account__c = expLine.AcctSeed__Expense_GL_Account__c;
                        jei.AcctSeed__Date__c = expLine.AcctSeed__Date__c;
                        jei.AcctSeed__Project__c = expLine.AcctSeed__Project__c;
                        jei.AcctSeed__Debit__c = expLine.AcctSeed__Amount__c;
                        jei.AcctSeed__Project_Task__c = expLine.AcctSeed__Project_Task__c;
                        
                        // Set Branch
                        if(expLine.Branch__c != null && mapBranchToAccountingVar.containsKey(expLine.Branch__c)) {
                        	jei.AcctSeed__GL_Account_Variable_1__c = mapBranchToAccountingVar.get(expLine.Branch__c).Id;
                        }
                        
                        jei.Description__c = expLine.AcctSeed__Internal_Comment__c;
                        
                        jei.AcctSeed__GL_Account_Variable_3__c = expLine.Ops_Division__c;
                        jei.AcctSeed__GL_Account_Variable_2__c = expLine.Sales_Segment__c;
						jei.Expense_Line__c = expLine.Id;
                        mapJEI.get(index).add(jei);
                    }
                    index++;                                    
                }
                
				// Insert Child Records and also first populate Parent id
				List<AcctSeed__Journal_Entry_Line__c> insertChildJEI = new List<AcctSeed__Journal_Entry_Line__c>();
				for(Integer i:mapJEI.keySet()) {
					Id parentId = JE.Id;
					for(AcctSeed__Journal_Entry_Line__c jel:mapJEI.get(i)) {
						jel.AcctSeed__Journal_Entry__c = parentId;
						insertChildJEI.add(jel);
					}
				}
				
				if(insertChildJEI.size() > 0) {
					insert insertChildJEI;
					
					// Create Map of ExpenseLine Id to Journal Entry Line Id
					Map<Id,Id> mapExpLineIdToJEId = new Map<Id,Id>();
					for(AcctSeed__Journal_Entry_Line__c jel:insertChildJEI) {
						mapExpLineIdToJEId.put(jel.Expense_Line__c,jel.Id);
					}
					
					// Populate JEI Id to Expense Line records
					List<AcctSeed__Expense_Line__c> updateExpLine = new LIst<AcctSeed__Expense_Line__c>();
					for(AcctSeed__Expense_Report__c er:lstExpenseReport) {
	                    for(AcctSeed__Expense_Line__c expLine:er.AcctSeed__Expense_Lines__r) {
	                    	expLine.Journal_Entry_Line__c = mapExpLineIdToJEId.get(expLine.Id);
	                    	updateExpLine.add(expLine);
	                    }
					}
					
					if(updateExpLine.size() > 0) {
						update updateExpLine;
					}
				}
				
				return new PageReference('/' + JE.Id);
                //return goBack();
            } else {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select Atleast one Record.'));
            }
        } catch(Exception ex) {
        	Database.rollback(sp);
        	
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ex.getMessage()));
            System.debug('===========EXCEPTION: ' + ex.getMessage() + '==' + ex.getStackTraceString());
        }
        return null;
    }
    
    public PageReference goBack() {
        if(String.isNotEmpty(retUrl)) {
            return new PageReference(retUrl);
        }
        return null;
    }
}