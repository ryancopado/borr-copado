/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@RestResource(urlMapping='/DMContact/*')
global class ProxyResource implements DMAPP.NodeReportsTo {
    global ProxyResource() {

    }
    @Deprecated
    @HttpPost
    global static Contact postIt(Contact c, String opportunityId) {
        return null;
    }
    global static Contact postIt(Contact c, String planunitid, String opportunityId) {
        return null;
    }
    global static Contact postIt(Contact c, String planunitid, String opportunityId, Boolean isAccMap, String mapId, String reportsToLinkType) {
        return null;
    }
global class AMMapNotSupportedException extends Exception {
}
global class DeprecatedException extends Exception {
}
global class UnknownLinkTypeException extends Exception {
}
}
