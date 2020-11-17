/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class APIDelegateController {
    global APIDelegateController() {

    }
    @RemoteAction
    global static DMAPP.OrgChartContactRestResource.OrgChartContacts addOrgChartContact(DMAPP.OrgChartContactRestResource.OrgChartContacts occs) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AMOrgChartContactRestResource.OrgChartContacts addOrgChartContactAM(DMAPP.AMOrgChartContactRestResource.OrgChartContacts occs) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OrgChartContactRestResource.OrgChartContact addPlaceholderContact(String mapId, String reportsToId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AccountOrgChartContactRestResource.OrgChartContact addPlaceholderContactAM(String mapId, String reportsToId) {
        return null;
    }
    @RemoteAction
    global static void associateAccountLevelMap(String opportunityExtraId, String accountPolMapId) {

    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.MapInfo createCollaborationMap(String id, String name, Boolean template) {
        return null;
    }
    @RemoteAction
    global static void createDecisionCriteria(String opportunityId, String criterion, String ourPosition) {

    }
    @RemoteAction
    global static SObject createObject(SObject sObjectTOCreate) {
        return null;
    }
    @RemoteAction
    global static SObject createObjectUsingMap(String objectType, Map<String,Object> params) {
        return null;
    }
    @RemoteAction
    global static DMAPP.StrategyMapRestResource.MapInfo createStrategyMap(DMAPP.StrategyMapRestResource.MapInfo req, Boolean template) {
        return null;
    }
    @RemoteAction
    global static void delOpportunityMapAdmin(String id) {

    }
    @RemoteAction
    global static DMAPP.PPTRestResourceDelegate.DeleteResult delPPTX(String id) {
        return null;
    }
    @RemoteAction
    global static void deleteAction(String id) {

    }
    @RemoteAction
    global static void deleteCollaborationMap(String id) {

    }
    @RemoteAction
    global static void deleteCollaborationMapNode(String id) {

    }
    @RemoteAction
    global static DMAPP.OpportunityCompetitorsRestResource.Response deleteCompetitiveStrategyCompetitor(String compId) {
        return null;
    }
    @RemoteAction
    global static void deleteDecisionCriteria(String opportunityId) {

    }
    @RemoteAction
    global static DMAPP.ForecastTeamRestResourceDelegate.ForecastTeam deleteForecastTeam(String forecaseID) {
        return null;
    }
    @RemoteAction
    global static void deleteObjective(String id) {

    }
    @RemoteAction
    global static void deleteOpportunityMapUnitSolutionCompetitor(String competitorId) {

    }
    @RemoteAction
    global static List<DMAPP.UnitSolutionOpportunityRestResource.UnitSolutionOpp> deleteOpportunityMapUnitSolutionOpp(String unitSolutionOppId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBQualifierQuicklinkAdminRestDlgt.QualifierQuicklink deletePlaybookQualifierQuicklinkAdmin(String quicklinkId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBQuicklinkRestResourceDlgt.Quicklink deletePlaybookQuicklink(String id) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBSalesProcessAdminRestResourceDlgt.SalesProcessDeleteResponse deleteSalesProcessAdmin(String id, String replaceId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBSalesProcessQualifierAdminRestDlgt.SalesProcessQualifier deleteSalesProcessQualifierAdmin(String qualifierId) {
        return null;
    }
    @RemoteAction
    global static void deleteStrategyMap(String id) {

    }
    @RemoteAction
    global static void deleteStrategyMapNode(String nodeId) {

    }
    @RemoteAction
    global static void genericAjaxDelete(String objectType, String id) {

    }
    @RemoteAction
    global static Object genericAjaxGet(String objectType, String id) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AssessmentRestResource.Assessment getAssessment(String id) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CoachMeRestResource.CoachMeOpportunitiesView getCoachMeOpportunitiesView(String opportuniytId) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP__DM_Coach_Rule__c> getCoachMeRules() {
        return null;
    }
    @RemoteAction
    global static DMAPP.CompetitiveStrategyRestResource.CompetitiveStrategy getCompetitiveStrategy(String id) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP__DM_Opportunity_Competitor_Extra__c> getCompetitiveStrategyCompetitors(String oppId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.DVLSAssessmentResource.DVLSAssessmentQuizzView getDVLSAssessment(String componentid) {
        return null;
    }
    @RemoteAction
    global static DMAPP.DVLSCurriculumResource.DVLSCurriculaView getDVLSCurricula() {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.PBDealmakerStageRestResourceDlgt.DealmakerStage> getDealmakerStageAdmin() {
        return null;
    }
    @RemoteAction
    global static Object getDecisionCriteria(String opportunityId) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.ForecastTeamRestResourceDelegate.ForecastTeam> getForecastTeam(String forecastID) {
        return null;
    }
    @RemoteAction
    global static List<String> getIncludedPlanOpportunityIds(String planId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AccountPlanObjectivesRestResource.PlanObjectives getJSR(String planId, String accountUnitId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.MarketViewDetail2RestResourceDlg.MarketViewDetail getMarketViewDetail(String reportId, String solutionId, String planId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.MarketViewDoubleCountRestDelegate.MarketViewDoubleCount getMarketViewDoubleCount(String repId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.MarketView2RestResourceDelegate.MarketViewReport getMarketViewReport(String reportId, String extra) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CRUDRestResourceDelegate.GetResult getMetaData(String objectType) {
        return null;
    }
    @RemoteAction
    global static DMAPP.MilestonesRestResourceDelegate.Milestones getMilestones(String opportunityId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OpportunityMapRestResource.OpportunityMapView getOpportunityMap(String id, Boolean targetted) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OpportunityMapRestResource.OpportunityMapView getOpportunityMap(String id, Boolean targetted, String filterName) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OpportunityMapAdminRestResourceDelegate.GetResult getOpportunityMapAdmin(String id) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.UnitSolutionCompetitorRestResource.UnitSolutionCompetitor> getOpportunityMapUnitSolutionCompetitor(String unitSolutionId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.UnitSolutionOpportunityRestResource.GetResult getOpportunityMapUnitSolutionOpp(String planId, String solutionId, String unitId, String oppType) {
        return null;
    }
    @RemoteAction
    global static DMAPP.UnitSolutionOpportunityRestResource.GetResult getOpportunityMapUnitSolutionOpp(String planId, String solutionId, String unitId, String oppType, String filterName) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.UnitSolutionRestResource.UnitSolution> getOpportunityMapUnitSolution(String planId, String solutionId, String unitId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PPTRestResourceDelegate.GetResult getPPTX(String id) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PlanActivityRestResourceDelegate.PlanActivityDetails getPlanActivityDetails(String planId) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.AccountPlanCompetitorRestResource.PlanCompetitor> getPlanCompetitor(String searchString) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AccountPlanDetailRestResource.PlanDetails getPlanDetails(String planId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PlanOpportunityRestResource.Opportunities getPlanOpportunity(String paramString) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.PBQuicklinkRestResourceDlgt.Quicklink> getPlaybookQuicklink(String searchString) {
        return null;
    }
    @RemoteAction
    global static Boolean getProfileVisible() {
        return null;
    }
    @RemoteAction
    global static DMAPP.QualifierRestResource.GetResponse getQualification(String opportunityId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.RoleAjaxResource.Response getRoleInformation(String id) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.PBSalesProcessAdminRestResourceDlgt.SalesProcess> getSalesProcessAdmin(String id) {
        return null;
    }
    @RemoteAction
    global static Map<String,List<DMAPP.PBSalesProcessQualifierAdminRestDlgt.SalesProcessQualifier>> getSalesProcessQualifierAdmin(String salesProcessId) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.PBSalesProcessStageAdminRestResourceDlgt.SalesProcessStage> getSalesProcessStage(String id) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AMScoreCardRestResourceDelegate.ScoreCardDetails getScoreCardDetails(String planId) {
        return null;
    }
    @RemoteAction
    global static String getSearchableFields(String objtype) {
        return null;
    }
    @RemoteAction
    global static DMAPP.SegmentationRestResource.GetResponse getSegmentation(String id) {
        return null;
    }
    @RemoteAction
    global static DMAPP.UnMappedPlanOpportunitiesRestResourceDlg.PlanOpportunities getUnmappedOpportunityLines(String planId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.ValueMapRestResource.GetResponse getValueMap(String id) {
        return null;
    }
    @RemoteAction
    global static void importFromAccountOrgChartsToAccountForPlanUnit(String accountmapid, String planunitid, List<String> mapids) {

    }
    @Deprecated
    @RemoteAction
    global static void importFromAccountOrgChartsToAccount(String accountmapid, List<String> mapids) {

    }
    @RemoteAction
    global static void importFromAccountOrgCharts(String opportunityExtraId, List<String> mapids) {

    }
    @RemoteAction
    global static void importFromOpportunityOrgChartsToAccountForPlanUnit(String accountmapid, String planunitid, List<String> oppids) {

    }
    @Deprecated
    @RemoteAction
    global static void importFromOpportunityOrgChartsToAccount(String accountmapid, List<String> oppids) {

    }
    @RemoteAction
    global static void importFromOpportunityOrgCharts(String opportunityExtraId, List<String> oppids) {

    }
    @RemoteAction
    global static void insertPlanSolution(DMAPP__AM_Plan_Solution__c sol) {

    }
    @RemoteAction
    global static DMAPP.AMOrgChartRestResource.OrgChart loadAMOrgChart(String accountUnitId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.CollaborationMap loadCollaborationMap(String id) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OrgChartRestResource.OrgChart loadOMOrgChart(String orgChartId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.StrategyMapRestResource.StrategyMap loadStrategyMaps(String id) {
        return null;
    }
    @RemoteAction
    global static void logDVLSQuicklinkUsageHit(String quicklinkId) {

    }
    @RemoteAction
    global static void logQuicklinkHit() {

    }
    @RemoteAction
    global static void logQuicklinkUsageHit(String quicklinkId) {

    }
    @RemoteAction
    global static DMAPP.MarketViewAdminRestResourceDelegate.PutResult marketViewPut(String id, DMAPP.MarketViewAdminRestResourceDelegate.PutParam params) {
        return null;
    }
    @RemoteAction
    global static Object planClone(String id, String newName) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AccountPlanOpportunityRestResource.AccountPlanOpportunity postAccountPlanOpportunity(String id, DMAPP.AccountPlanOpportunityRestResource.AccountPlanOpportunityChange accountPlanOpportunityChange) {
        return null;
    }
    @RemoteAction
    global static String postCompetitiveStrategyCompetitor(String oppId, DMAPP.OpportunityCompetitorsRestResource.CompetitorChanges competitorChanges) {
        return null;
    }
    @RemoteAction
    global static DMAPP.ForecastTeamRestResourceDelegate.ForecastTeam postForecastTeam(String ownerId, DMAPP.ForecastTeamRestResourceDelegate.ForecastTeamChanges forecastTeamChanges) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OpportunityMapAdminRestResourceDelegate.PutResult postOpportunityMapAdmin(String id, DMAPP.OpportunityMapAdminRestResourceDelegate.PutParam param) {
        return null;
    }
    @RemoteAction
    global static DMAPP.UnitSolutionRestResource.UnitSolution postOpportunityMapUnitSolution(String planId, String solutionId, String unitId, DMAPP.UnitSolutionRestResource.UnitSolutionChanges unitSolutionChanges) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.UnitSolutionCompetitorRestResource.UnitSolutionCompetitor> postOpportunityMapUnitSolutionCompetitor(String unitSolutionId, DMAPP.UnitSolutionCompetitorRestResource.UnitSolutionCompetitorChanges unitSolutionCompetitorChanges) {
        return null;
    }
    @Deprecated
    @RemoteAction
    global static List<DMAPP.UnitSolutionOpportunityRestResource.UnitSolutionOpp> postOpportunityMapUnitSolutionOpp(String solutionId, DMAPP.UnitSolutionOpportunityRestResource.UnitSolutionOppChanges unitSolutionOppChanges) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.UnitSolutionOpportunityRestResource.UnitSolutionOpp> postOpportunityMapUnitSolutionOpp(String solutionId, DMAPP.UnitSolutionOpportunityRestResource.UnitSolutionOppChanges unitSolutionOppChanges, String potentialOppId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PPTRestResourceDelegate.PostResult postPPTX(String id, DMAPP.PPTRestResourceDelegate.PostParam param) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AccountPlanCompetitorRestResource.PlanCompetitor postPlanCompetitor(DMAPP.AccountPlanCompetitorRestResource.PlanCompetitorChanges planCompetitorChanges) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.PBQualifierQuicklinkAdminRestDlgt.QualifierQuicklink> postPlaybookQualifierQuicklinkAdmin(String quicklinkId, List<String> quicklinkIds) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBQuicklinkRestResourceDlgt.Quicklink postPlaybookQuicklink(DMAPP.PBQuicklinkRestResourceDlgt.QuicklinkChanges quicklinkChanges) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBSalesProcessAdminRestResourceDlgt.SalesProcessCloneResponse postSalesProcessAdmin(String salesProcessToCloneId, DMAPP.PBSalesProcessAdminRestResourceDlgt.SalesProcessChanges salesProcessChanges) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.PBSalesProcessQualifierAdminRestDlgt.SalesProcessQualifier> postSalesProcessQualifierAdmin(String id, List<String> qualifierIds) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.PBSalesProcessStageAdminRestResourceDlgt.SalesProcessStage> postSalesProcessStage(String id, List<DMAPP.PBDealmakerStageRestResourceDlgt.DealmakerStage> stages) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AssessmentRestResource.Response putAssessment(String id, DMAPP.AssessmentRestResource.LineChange linechange) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CompetitiveStrategyRestResource.Response putCompetitiveStrategy(String id, DMAPP.CompetitiveStrategyRestResource.CompetitiveStrategyChanges changes) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OpportunityCompetitorsRestResource.Response putCompetitiveStrategyCompetitor(String oppId, DMAPP.OpportunityCompetitorsRestResource.CompetitorChanges competitorChanges) {
        return null;
    }
    @RemoteAction
    global static DMAPP.ForecastTeamRestResourceDelegate.ForecastTeam putForecastTeam(String teamId, DMAPP.ForecastTeamRestResourceDelegate.ForecastTeamChanges forecastTeamChanges) {
        return null;
    }
    @RemoteAction
    global static DMAPP.MilestonesRestResourceDelegate.Response putMilestones(String opportunityId, DMAPP.MilestonesRestResourceDelegate.LineChange linechange) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OpportunityMapAdminRestResourceDelegate.PutResult putOpportunityMapAdmin(String id, DMAPP.OpportunityMapAdminRestResourceDelegate.PutParam param) {
        return null;
    }
    @RemoteAction
    global static DMAPP.UnitSolutionRestResource.UnitSolution putOpportunityMapUnitSolution(String id, DMAPP.UnitSolutionRestResource.UnitSolutionChanges unitSolutionChanges) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.UnitSolutionCompetitorRestResource.UnitSolutionCompetitor> putOpportunityMapUnitSolutionCompetitor(DMAPP.UnitSolutionCompetitorRestResource.UnitSolutionCompetitorChanges unitSolutionCompetitorChanges) {
        return null;
    }
    @RemoteAction
    global static DMAPP.UnitSolutionOpportunityRestResource.UnitSolutionOpp putOpportunityMapUnitSolutionOpp(String unitSolutionId, DMAPP.UnitSolutionOpportunityRestResource.UnitSolutionOppChange unitSolutionOppChange) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PPTRestResourceDelegate.PutResult putPPTX(DMAPP.PPTRestResourceDelegate.PutParam param) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AccountPlanDetailRestResource.Response putPlanDetails(String planId, DMAPP.AccountPlanDetailRestResource.LineChange line) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBQualifierAdminRestResourceDlgt.PlaybookQualifier putPlaybookQualifierAdmin(String qualifierId, String overwriteQualifierId, DMAPP.PBQualifierAdminRestResourceDlgt.PlaybookQualifierChanges changes) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.PBQualifierQuicklinkAdminRestDlgt.QualifierQuicklink> putPlaybookQualifierQuicklinkAdmin(List<String> quicklinkIds) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBQuicklinkRestResourceDlgt.Quicklink putPlaybookQuicklink(String id, DMAPP.PBQuicklinkRestResourceDlgt.QuicklinkChanges quicklinkChanges) {
        return null;
    }
    @RemoteAction
    global static DMAPP.QualifierRestResource.PutPostReponse putQualification(DMAPP.QualifierRestResource.PutPostParam params) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.SalesProcessQualifierRestResourceDlgt.Qualifier> putQualifier(DMAPP.SalesProcessQualifierRestResourceDlgt.Qualifier params) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBSalesProcessAdminRestResourceDlgt.SalesProcess putSalesProcessAdmin(String salesProcessId, DMAPP.PBSalesProcessAdminRestResourceDlgt.SalesProcessChanges salesProcessChanges) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.PBSalesProcessQualifierAdminRestDlgt.SalesProcessQualifier> putSalesProcessQualifierAdmin(String qualifierId, DMAPP.PBSalesProcessQualifierAdminRestDlgt.SalesProcessQualifierChanges salesProcessQualifierChanges) {
        return null;
    }
    @RemoteAction
    global static DMAPP.PBSalesProcessStageAdminRestResourceDlgt.SalesProcessStage putSalesProcessStage(String id, DMAPP.PBSalesProcessStageAdminRestResourceDlgt.SalesProcessStageChanges salesProcessStageChanges) {
        return null;
    }
    @RemoteAction
    global static DMAPP.SegmentationRestResource.PutPostReponse putSegmentation(String planId, DMAPP.SegmentationRestResource.PutPostParam params) {
        return null;
    }
    @RemoteAction
    global static DMAPP.ValueMapRestResource.PutPostReponse putValueMap(String id, DMAPP.ValueMapRestResource.PutPostParam params) {
        return null;
    }
    @RemoteAction
    global static Object query(String soql) {
        return null;
    }
    @RemoteAction
    global static void removeMultipleOrgChartContactsAM(List<String> contactIds) {

    }
    @RemoteAction
    global static void removeMultipleOrgChartContacts(List<String> contactIds) {

    }
    @RemoteAction
    global static void removeOrgChartContact(String contactId) {

    }
    @RemoteAction
    global static void removeOrgChartContactAM(String id) {

    }
    @RemoteAction
    global static DMAPP.PBSalesProcessStageAdminRestResourceDlgt.SalesProcessStageDeleteResponse removeSalesProcessStage(String stageId, String blankOpportunityStageString) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OrgChartRestResource.ContactInfo replacePlaceholder(String mapId, String id, String replacementContactId) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AccountOrgChartRestResource.ContactInfo replacePlaceholderAM(String mapId, String id, String replacementContactId) {
        return null;
    }
    @RemoteAction
    global static void resetDVLSAssessmentAnswers(String testId) {

    }
    @RemoteAction
    global static DMAPP.StrategyMapRestResource.StrategyMap saveStrategyMapNodes(DMAPP.StrategyMapRestResource.StrategyMap strategymapnodes) {
        return null;
    }
    @RemoteAction
    global static DMAPP__AM_Plan_Unit__c saveUnitLOR(DMAPP__AM_Plan_Unit__c au) {
        return null;
    }
    @RemoteAction
    global static Object searchPlanOpportunities(String paramString) {
        return null;
    }
    @RemoteAction
    global static List<DMAPP.SalesProcessQualifierRestResourceDlgt.Qualifier> searchQualifiers(DMAPP.SalesProcessQualifierRestResourceDlgt.SearchQualifierParams params) {
        return null;
    }
    @RemoteAction
    global static void startDVLSCurriculum(String currid) {

    }
    @RemoteAction
    global static DMAPP.DVLSAssessmentResource.DVLSAssessmentQuizzView submitDVLSAssessment(DMAPP.DVLSAssessmentResource.DVLSAssessmentQuizzView a) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.MapInfo updateCollaborationMap(String mapId, String name, String opId, Boolean template) {
        return null;
    }
    @RemoteAction
    global static DMAPP.OrgChartContactRestResource.OrgChartContacts updateContactAttribute(DMAPP.OrgChartContactRestResource.OrgChartContacts occs) {
        return null;
    }
    @RemoteAction
    global static DMAPP.AMOrgChartContactRestResource.OrgChartContacts updateContactAttributeAM(DMAPP.AMOrgChartContactRestResource.OrgChartContacts occs) {
        return null;
    }
    @RemoteAction
    global static DMAPP.DVLSQuicklinkProgressResource.QuickLinkStatus updateDVLSQuicklinkProgress(DMAPP.DVLSQuicklinkProgressResource.QuickLink ql) {
        return null;
    }
    @RemoteAction
    global static void updateDecisionCriteria(String criterionId, String opportunityId, String criterion, String ourPosition) {

    }
    @RemoteAction
    global static DMAPP__DM_Decision_Criterion_Score__c updateDecisionCriteriaScore(String rankId, String importance) {
        return null;
    }
    @RemoteAction
    global static void updatePoliticalMapContact(String id, Boolean keyPlayer) {

    }
    @Deprecated
    @RemoteAction
    global static Contact updateReportsTo(String id, Contact c) {
        return null;
    }
    @RemoteAction
    global static Contact updateReportsToForPlanUnit(String id, String planunitid, Contact c) {
        return null;
    }
    @RemoteAction
    global static Contact updateReportsToForPlanUnit2(String id, String planunitid, Contact c, Boolean isAccMap, String mapId, String reportsToLinkType) {
        return null;
    }
    @RemoteAction
    global static DMAPP.StrategyMapRestResource.MapInfo updateStrategyMap(DMAPP.StrategyMapRestResource.MapInfo req, Boolean template) {
        return null;
    }
    @RemoteAction
    global static Task upsertAction(DMAPP.TaskWrapper task) {
        return null;
    }
    @RemoteAction
    global static DMAPP.CollaborationMapRestResource.CollaborationMap upsertNodes(DMAPP.CollaborationMapRestResource.CollaborationMap collaborationmapnodes) {
        return null;
    }
    @RemoteAction
    global static SObject upsertObject(SObject sObjectTOCreate) {
        return null;
    }
    @RemoteAction
    global static SObject upsertObjectUsingMap(String objectType, String id, Map<String,Object> params) {
        return null;
    }
    @RemoteAction
    global static DMAPP__Account_Plan_Objective__c upsertObjective(DMAPP__Account_Plan_Objective__c objective) {
        return null;
    }
global class DeprecatedException extends Exception {
}
}
