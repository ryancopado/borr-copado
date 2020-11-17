@isTest
private class SDGenerateReportTest {
    @isTest(SeeAllData=true)
    private static void testSDGenerateReport() {
        Test.setCurrentPageReference(Page.SDGenerateReport);
        ApexPages.currentPage().getParameters().put('object', 'Case');
        //this is the doclist id which should be run while testclass in Training Sandbox
       // ApexPages.currentPage().getParameters().put('doclist', 'a2R34000008dsEs,a2R34000008dsEx,a2R340000093ygy,a2R340000093yh3,a2R3400000940ER,a2R3400000940EW');
       // these are the doclist id which shold be run while testclass in Prod.
        ApexPages.currentPage().getParameters().put('doclist', 'a2R34000008dsEsEAI,a2R34000008dsExEAI,a2R340000093ygyEAA,a2R340000093yh3EAA,a2R3400000940EREAY,a2R3400000940EWEAY');
        ApexPages.currentPage().getParameters().put('id', String.valueOf([SELECT Id FROM Case LIMIT 1].Id));
        SDGenerateReport sdgr = new SDGenerateReport();
        sdgr.generateReport();
        sdgr.redirectWhenJobsAreCompleted();
    }
}