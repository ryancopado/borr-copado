/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class InsightMapComponentController extends DMAPP.TASBaseController {
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.MapInfo createMap(String oppId, String name, Boolean template) {
        return null;
    }
    @RemoteAction
    global static void deleteMap(String mapId) {

    }
    @RemoteAction
    global static void deleteMapNodes(List<String> nodeIds) {

    }
    @RemoteAction
    global static List<DMAPP.InsightMapComponentController.InsightMap> getAvailableMaps(String oppExtraId) {
        return null;
    }
    @RemoteAction
    global static List<Contact> getContacts(String searchTerm, String extra) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.CollaborationMap getMap(String mapId) {
        return null;
    }
    @RemoteAction
    global static List<Object> search(String objectName, Id nodeId, String filter) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.MapInfo updateMap(String oppId, String mapId, String name, Boolean template) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.CollaborationMap upsertNodes(DMAPP.CollaborationMapRestResource.CollaborationMap collaborationMapNodes) {
        return null;
    }
global class InsightMap {
}
}
