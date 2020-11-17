/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class SmartMapController extends DMAPP.TASBaseController {
    global SmartMapController() {

    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.MapInfo createMap(String name, List<DMAPP.CollaborationMapRestResource.Categorization> categorySelection, String tags, String description, Boolean active) {
        return null;
    }
    @RemoteAction
    global static void deleteMap(String mapId) {

    }
    @RemoteAction
    global static void deleteMapNodes(String mapId, List<String> nodeIds) {

    }
    @RemoteAction
    global static String exportSmartMap(String mapId) {
        return null;
    }
    @RemoteAction
    global static String exportSmartMapAndNodes(String mapId) {
        return null;
    }
    @RemoteAction
    global static String exportSmartMaps() {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.InsightMapComponentController.InsightMap> getAvailableMaps() {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.InsightExpressAdminHelper.InsightSmartNode> getInsightSmartNodesByNamespace(String type, String namespaceId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.CollaborationMap getMap(String mapId) {
        return null;
    }
    @RemoteAction
    global static Map<String,String> getTruncatedDescriptions(List<String> ids) {
        return null;
    }
    @RemoteAction
    global static DMAPP.SmartMapController.ImportMapResult importSmartMap(String JSONString) {
        return null;
    }
    @RemoteAction
    global static DMAPP.SmartMapController.ImportMapResults importSmartMaps(String JSONString) {
        return null;
    }
    @RemoteAction
    global static String logBrowse(DMAPP__Align_Search__c alignSearch, DMAPP.SmartMapController.UsageLog alignSearchUsage) {
        return null;
    }
    @RemoteAction
    global static String logSearch(DMAPP__Align_Search__c alignSearch) {
        return null;
    }
    @RemoteAction
    global static void logUsage(DMAPP.SmartMapController.UsageLog alignSearchUsage) {

    }
    @RemoteAction
    global static List<DMAPP.InsightExpressAdminHelper.InsightSmartNode> searchSmartNodes(String mapId, String type, String keywords, Boolean searchAll) {
        return null;
    }
    @RemoteAction
    global static List<Object> search(String objectName, Id nodeId, String filter) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.MapInfo updateMap(String mapId, String name, List<DMAPP.CollaborationMapRestResource.Categorization> categorySelection, String tags, String description, Boolean active) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.CollaborationMap upsertNodes(DMAPP.CollaborationMapRestResource.CollaborationMap collaborationMapNodes) {
        return null;
    }
global class ImportMapResult {
    global ImportMapResult() {

    }
}
global class ImportMapResults {
    global ImportMapResults() {

    }
}
global class UsageLog {
    global UsageLog() {

    }
}
}
