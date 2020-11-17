public with sharing class PrintchecksCtrl {


    public Id cashDisbursementId {get;set;}
    
    public Id cashDisbursementBatchId {get;set;}

    public List<cashDisbursementWrapper> getchecksList (){
        
        List<AcctSeed__Cash_Disbursement__c> listOfCaseDisbursement;
        List<cashDisbursementWrapper> listOfCaseDisbursementWrappers = new List<cashDisbursementWrapper>();
        
        if(cashDisbursementId != null){
            listOfCaseDisbursement =  [Select a.X2nd_Vendor__c, a.Name, a.Memo__c, a.Id, a.AcctSeed__X1099_Year__c, a.AcctSeed__X1099_Vendor__c, a.AcctSeed__Vendor__c, a.AcctSeed__Type__c, a.AcctSeed__Status__c, a.AcctSeed__Source__c, a.AcctSeed__Reference__c, a.AcctSeed__Payment_Status__c, a.AcctSeed__Payee__c, a.AcctSeed__Payee_Street__c, a.AcctSeed__Payee_Country__c, a.AcctSeed__Payee_City_State_Zip__c, a.AcctSeed__Full_Remittance__c, a.AcctSeed__Employee__c, a.AcctSeed__Disbursement_Date__c, a.AcctSeed__Default_1099_Box__c, a.AcctSeed__Debit_GL_Account__c, a.AcctSeed__Contact__c, a.AcctSeed__Check_Number__c, a.AcctSeed__Cash_Disbursement_Batch__c, a.AcctSeed__Bank_Account__c, a.AcctSeed__Amount_in_Words__c, a.AcctSeed__Amount__c, a.AcctSeed__Accounting_Year__c, a.AcctSeed__Accounting_Period__c, a.AcctSeed__AP_Voucher_Count__c 
                                ,( select AcctSeed__Account_Payable__r.Remit_to__r.Street_Address__c, AcctSeed__Account_Payable__r.Remit_to__r.Suite_Unit__c, AcctSeed__Account_Payable__r.Remit_to__r.City__c, AcctSeed__Account_Payable__r.Remit_to__r.State__c, AcctSeed__Account_Payable__r.Remit_to__r.Zip_Code__c, AcctSeed__Account_Payable__r.description__c,AcctSeed__Account_Payable__r.memo__c,AcctSeed__Account_payable__r.Name,AcctSeed__Account_payable__r.AcctSeed__Date__c,AcctSeed__Account_payable__r.AcctSeed__Type__c,AcctSeed__Payee_Reference__c,AcctSeed__Paid_Amount__c,AcctSeed__Payable_Amount__c,AcctSeed__Discount_Amount__c,AcctSeed__Net_Amount__c from AcctSeed__Account_Payable_Cash_Disbursements__r) 
                                From AcctSeed__Cash_Disbursement__c a where Id =: cashDisbursementId];
        }
        
        if(cashDisbursementBatchId != null){
            listOfCaseDisbursement = [Select a.X2nd_Vendor__c, a.Name, a.Memo__c, a.Id, a.AcctSeed__X1099_Year__c, a.AcctSeed__X1099_Vendor__c, a.AcctSeed__Vendor__c, a.AcctSeed__Type__c, a.AcctSeed__Status__c, a.AcctSeed__Source__c, a.AcctSeed__Reference__c, a.AcctSeed__Payment_Status__c, a.AcctSeed__Payee__c, a.AcctSeed__Payee_Street__c, a.AcctSeed__Payee_Country__c, a.AcctSeed__Payee_City_State_Zip__c, a.AcctSeed__Full_Remittance__c, a.AcctSeed__Employee__c, a.AcctSeed__Disbursement_Date__c, a.AcctSeed__Default_1099_Box__c, a.AcctSeed__Debit_GL_Account__c, a.AcctSeed__Contact__c, a.AcctSeed__Check_Number__c, a.AcctSeed__Cash_Disbursement_Batch__c, a.AcctSeed__Bank_Account__c, a.AcctSeed__Amount_in_Words__c, a.AcctSeed__Amount__c, a.AcctSeed__Accounting_Year__c, a.AcctSeed__Accounting_Period__c, a.AcctSeed__AP_Voucher_Count__c 
                                ,( select AcctSeed__Account_Payable__r.Remit_to__r.Street_Address__c, AcctSeed__Account_Payable__r.Remit_to__r.Suite_Unit__c, AcctSeed__Account_Payable__r.Remit_to__r.City__c, AcctSeed__Account_Payable__r.Remit_to__r.State__c, AcctSeed__Account_Payable__r.Remit_to__r.Zip_Code__c, AcctSeed__Account_Payable__r.description__c,AcctSeed__Account_Payable__r.memo__c,AcctSeed__Account_payable__r.Name,AcctSeed__Account_payable__r.AcctSeed__Date__c,AcctSeed__Account_payable__r.AcctSeed__Type__c,AcctSeed__Payee_Reference__c,AcctSeed__Paid_Amount__c,AcctSeed__Payable_Amount__c,AcctSeed__Discount_Amount__c,AcctSeed__Net_Amount__c from AcctSeed__Account_Payable_Cash_Disbursements__r ) 
                                From AcctSeed__Cash_Disbursement__c a where AcctSeed__Cash_Disbursement_Batch__c  =: cashDisbursementBatchId];
        }
        
        
        
        for(AcctSeed__Cash_Disbursement__c caseDisbursement:listOfCaseDisbursement){
            listOfCaseDisbursementWrappers.add(new cashDisbursementWrapper(caseDisbursement));
        }
        
        
        return listOfCaseDisbursementWrappers;
    }
    
    
    public class cashDisbursementWrapper{
        public AcctSeed__Cash_Disbursement__c cashDisbursement {get;set;}
        public List<APDisbursementWrapper> apcds {get;set;}
        
        public cashDisbursementWrapper(AcctSeed__Cash_Disbursement__c thecashDisbursement){
            cashDisbursement = thecashDisbursement;
            
            Integer icount = 1;
            
            apcds = new List<APDisbursementWrapper> ();
                
            List<AcctSeed__AP_Disbursement__c> apcdList = new List<AcctSeed__AP_Disbursement__c>();
            
            for(AcctSeed__AP_Disbursement__c apcd:cashDisbursement.AcctSeed__Account_Payable_Cash_Disbursements__r){
                apcdList.add(apcd);
                if(  math.mod(icount, 8) == 0  || icount == cashDisbursement.AcctSeed__Account_Payable_Cash_Disbursements__r.size()){
                    Boolean isLast = false;
                    if(icount == cashDisbursement.AcctSeed__Account_Payable_Cash_Disbursements__r.size()){
                        isLast = true;
                    }
                    APDisbursementWrapper cdW = new APDisbursementWrapper(apcdList,isLast);
                    apcds.add(cdW);
                    apcdList = new List<AcctSeed__AP_Disbursement__c>();
                }  
                icount ++;
            }
        }
    }
    
     public class APDisbursementWrapper{
        
        public List<AcctSeed__AP_Disbursement__c> apds {get;set;}
        public boolean isLast {get;set;}
        
        public APDisbursementWrapper(List<AcctSeed__AP_Disbursement__c> theapds, Boolean isTheLast){
            isLast = isTheLast;
            apds = theapds;
        }
        
     }
    
    @isTest(seeAllData=true)
    public static void TestPrintchecksCtrl(){
        
        PrintchecksCtrl print = new PrintchecksCtrl();
        TestDataSuite.initialize();
        print.cashDisbursementId = TestDataSuite.cashDisbursements[0].Id;
        System.assert(print.getchecksList () != null);
        print.cashDisbursementBatchId = TestDataSuite.cashDisbursementBatch[0].Id;
        System.assert(print.getchecksList () != null);
        
        
    }
    

}