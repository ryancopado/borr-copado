/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global abstract class MapUpgrade implements Database.Batchable<SObject>, Database.Stateful {
    global static String GOAL_TYPE;
    global static String INITIATIVE_TYPE;
    global static String OBSTACLE_TYPE;
    global static String PRESSURE_TYPE;
    global static String SOLUTION_TYPE;
    global MapUpgrade() {

    }
    global abstract SObject createNewEdge(String param0, String param1);
    global abstract String getComplexTypeName();
    global abstract String getComplexTypePreferredParentType();
    global abstract String getDemotedComplexTypeName();
    global String getMapId() {
        return null;
    }
    global abstract String getRetainedComplexTypeName();
    global abstract Map<String,String> getSimpleConversions();
    global abstract List<SObject> loadEdges();
    global abstract Map<String,SObject> loadNodes();
    global void startUpgrade() {

    }
    global void upgrade(SObject m) {

    }
global class MapUpgradeFailureException extends Exception {
}
}
