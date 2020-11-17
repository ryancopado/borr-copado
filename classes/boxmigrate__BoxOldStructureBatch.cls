/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class BoxOldStructureBatch extends boxmigrate.BoxBatchBase {
    global Integer calloutCounter;
    global Map<String,String> folderIdToNameMap;
    global Boolean PayloadLimitReached;
    global Integer testJobsize {
        get;
        set;
    }
    global Integer theLimit;
    global Integer theOffset;
    global Integer totalCount;
    global BoxOldStructureBatch(Integer theBatchLimit, Integer theBatchOffset) {

    }
    global void execute(System.SchedulableContext SC) {

    }
    global void execute(Database.BatchableContext BC, List<SObject> scope) {

    }
    global void finish(Database.BatchableContext BC) {

    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return null;
    }
}
