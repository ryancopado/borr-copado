/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class CallRecordingConsentV1 {
    global NVMContactWorld.CallRecordingConsentV1.CallRecordingConsentParty fromParty {
        get;
        set;
    }
    global NVMContactWorld.CallRecordingConsentV1.CallRecordingConsentParty toParty {
        get;
        set;
    }
    global CallRecordingConsentV1() {

    }
    global static NVMContactWorld.CallRecordingConsentV1 fromJson(String jsonString) {
        return null;
    }
    global Boolean isValid() {
        return null;
    }
    global String toJson() {
        return null;
    }
global class CallRecordingConsentParty {
    global NVMContactWorld.CallRecordingConsentV1.CallRecordingConsentType consent {
        get;
        set;
    }
    global CallRecordingConsentParty() {

    }
}
global enum CallRecordingConsentType {OneParty, TwoParty, Unknown}
}
