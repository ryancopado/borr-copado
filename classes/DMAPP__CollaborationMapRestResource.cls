/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@RestResource(urlMapping='/CollaborationMap/*')
global class CollaborationMapRestResource {
    global CollaborationMapRestResource() {

    }
    @Deprecated
    global static void addCompetitors(DMAPP.CollaborationMapRestResource.Node n, List<OpportunityCompetitor> opportunityCompetitors, Map<String,Map<String,DMAPP__DM_Collaboration_Map_Node_Competitor__c>> collabMapNodeCompetitors) {

    }
    @Deprecated
    global static void addCompetitors(DMAPP.CollaborationMapRestResource.Node n, List<OpportunityCompetitor> opportunityCompetitors, Map<String,Map<String,DMAPP__DM_Insight_Map_Node_Competitor__c>> collabMapNodeCompetitors) {

    }
    @HttpPost
    global static DMAPP.CollaborationMapRestResource.MapInfo create(String opportunityid, String name, Boolean template) {
        return null;
    }
    @HttpPut
    global static DMAPP.CollaborationMapRestResource.MapInfo create(String mapid, String opportunityid, String name, Boolean template) {
        return null;
    }
    @Deprecated
    global static DMAPP.CollaborationMapRestResource.CollaborationMap createJSONMap(DMAPP__DM_Collaboration_Map__c cmap, Map<String,List<String>> parentInfo, List<OpportunityCompetitor> opportunityCompetitors, Map<String,Map<String,DMAPP__DM_Collaboration_Map_Node_Competitor__c>> collabMapNodeCompetitors) {
        return null;
    }
    @Deprecated
    global static DMAPP.CollaborationMapRestResource.CollaborationMap createJSONMap(DMAPP__DM_Collaboration_Map__c cmap, Map<String,List<String>> parentInfo, List<OpportunityCompetitor> opportunityCompetitors, Map<String,Map<String,DMAPP__DM_Insight_Map_Node_Competitor__c>> collabMapNodeCompetitors) {
        return null;
    }
    @HttpDelete
    global static void deleteMap() {

    }
    @Deprecated
    global static Map<String,Map<String,DMAPP__DM_Collaboration_Map_Node_Competitor__c>> getCompetitorNodeInfo(DMAPP__DM_Collaboration_Map__c cmap) {
        return null;
    }
    @Deprecated
    global static Map<String,Map<String,DMAPP__DM_Insight_Map_Node_Competitor__c>> getInsightMapCompetitorNodeInfo(DMAPP__DM_Collaboration_Map__c cmap) {
        return null;
    }
    @HttpGet
    global static DMAPP.CollaborationMapRestResource.CollaborationMap getMap() {
        return null;
    }
    @Deprecated
    global static List<OpportunityCompetitor> getOpportunityCompetitors(String oppId) {
        return null;
    }
    @Deprecated
    global static Map<String,List<String>> getParentInfo(DMAPP__DM_Collaboration_Map__c cmap) {
        return null;
    }
    @Deprecated
    global static DMAPP__DM_Collaboration_Map__c readMap(String mapId) {
        return null;
    }
global class Categorization {
}
global class CollaborationMap {
}
global class Competitor {
}
global class Competitors {
}
global class DeprecatedException extends Exception {
}
global class InvalidNameException extends Exception {
}
global class InvalidOpportunityException extends Exception {
}
global class MapInfo {
}
global class Node {
}
global class Nodes {
}
global class Parent {
}
global class ParentNodes {
}
global class UnknownMapException extends Exception {
}
}
