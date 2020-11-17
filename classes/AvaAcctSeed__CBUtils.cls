/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CBUtils {
    global CBUtils() {

    }
    global static System.PageReference APAdjustSalesTax(Id CurPage, AvaAcctSeed__CBAvaTaxSetting__c Cfg, Boolean TestFlag, Boolean TestResult) {
        return null;
    }
    global static System.PageReference AdjustSalesTax(Id CurPage, AvaAcctSeed__CBAvaTaxSetting__c Cfg, Boolean TestFlag, Boolean TestResult) {
        return null;
    }
    @Future(callout=true)
    global static void AsyncAdjustSalesTax(Id CurPage, Boolean TestFlag, Boolean TestResult) {

    }
    @Future(callout=true)
    global static void AsyncCalculateSalesTax(Id curBillingId, Boolean commitFlag, Boolean testFlag, Boolean testResult) {

    }
    @Future(callout=true)
    global static void AsyncCancelTax(String PropBillingNum, String AltDocCode, Boolean testFlag) {

    }
    global static System.PageReference CalculateSalesTax(Id CurPage, AvaAcctSeed__CBAvaTaxSetting__c Cfg, Boolean commitFlag, Boolean testFlag, Boolean testResult) {
        return null;
    }
    global static AvaAcctSeed__CBAvaTaxSetting__c FetchActiveAvaSettings() {
        return null;
    }
    global static AvaAcctSeed__CBAvaTaxSetting__c FetchCurrentAvaSettings() {
        return null;
    }
    global static Product2 FetchSalesTaxProduct(AvaAcctSeed__CBAvaTaxSetting__c creds) {
        return null;
    }
    global static void LatchedUpdate(SObject dbObj) {

    }
    global static void LatchedUpdate(List<SObject> ldbObj) {

    }
    global static void LoadMessage(AvaAcctSeed__CBMsgBoxText__c msg2Load, List<String> msgLines) {

    }
    global static List<String> MessageChunk(String inMessage, Integer MaxLen) {
        return null;
    }
    global static System.PageReference OppQuoteSalesTax(Id CurPage, AvaAcctSeed__CBAvaTaxSetting__c Cfg, Boolean testFlag, Boolean testResult) {
        return null;
    }
    @Future(callout=true)
    global static void PostTax(String documentCode, Decimal TotalAmount, Decimal TotalTax) {

    }
    global void ShowCPHMessageBox(List<String> LogEntriesMsgLines) {

    }
    global static System.PageReference ShowMessageBox(String MsgBoxTitle, String Msg, Id RetPage) {
        return null;
    }
    global static System.PageReference ShowMessageBox(String MsgBoxTitle, List<String> MsgLines, Id RetPage) {
        return null;
    }
}
