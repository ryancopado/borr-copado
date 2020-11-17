/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@RestResource(urlMapping='/DVLSQuicklinkProgess/*')
global class DVLSQuicklinkProgressResource {
    global DVLSQuicklinkProgressResource() {

    }
    @HttpGet
    global static DMAPP.DVLSQuicklinkProgressResource.QuickLink getQuickLinkStatus() {
        return null;
    }
    @HttpPost
    global static DMAPP.DVLSQuicklinkProgressResource.QuickLinkStatus updateProgress(DMAPP.DVLSQuicklinkProgressResource.QuickLink ql) {
        return null;
    }
global class BadQuicklinkProgressRequestException extends Exception {
}
global class QuickLink {
    global QuickLink() {

    }
}
global class QuickLinkStatus {
    global QuickLinkStatus() {

    }
}
}
