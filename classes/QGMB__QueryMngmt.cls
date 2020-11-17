/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class QueryMngmt {
    global QueryMngmt() {

    }
    webService static String deleteQuery(String Query_Name) {
        return null;
    }
    webService static List<QGMB__userDefinedQuery__c> listQueries(String Parent_Object) {
        return null;
    }
    webService static List<QGMB__userDefinedQuery__c> loadQuery(String Query_Name) {
        return null;
    }
    webService static String renameQuery(String old_Query_Name, String new_Query_Name) {
        return null;
    }
    webService static QGMB.QueryMngmt.retStatus saveQuery(QGMB__userDefinedQuery__c userDefQry) {
        return null;
    }
    webService static QGMB.QueryMngmt.retStatus saveQueryList(List<QGMB__userDefinedQuery__c> userDefQry) {
        return null;
    }
global class retStatus {
    @WebService
    webService Id id;
    @WebService
    webService String status;
    global retStatus(String status, Id id) {

    }
}
}
