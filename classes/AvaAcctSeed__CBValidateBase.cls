/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global abstract class CBValidateBase {
    global AvaAcctSeed__CBAvaTaxSetting__c m_Config;
    global Id m_CurPage;
    global AvaAcctSeed.CBAddress m_OriginalAddress {
        get;
        set;
    }
    global Boolean m_TestFlag;
    global Boolean m_TestResult;
    global AvaAcctSeed.CBAddress m_ValidatedAddress {
        get;
        set;
    }
    global CBValidateBase() {

    }
    global abstract void FetchOriginalAddress();
    global System.PageReference PageReturn() {
        return null;
    }
    global abstract System.PageReference UpdateContainer();
    global System.PageReference ValidateAddress() {
        return null;
    }
}
