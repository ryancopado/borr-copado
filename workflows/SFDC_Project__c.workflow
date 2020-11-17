<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>AsBuilts</fullName>
        <description>As Builts</description>
        <protected>false</protected>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/AsBuilts</template>
    </alerts>
    <alerts>
        <fullName>As_Built_Production_model</fullName>
        <description>As-Built Production model</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorOperationsandMaintenance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Complete_Create_AsBuilt_Prod_Model</template>
    </alerts>
    <alerts>
        <fullName>Baseline_Dates_Entered</fullName>
        <description>Baseline Dates Entered</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Baseline_Dates_entered</template>
    </alerts>
    <alerts>
        <fullName>CD_Completion_Email</fullName>
        <description>CD Completion Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Set_Completion_Date_Entered</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_1_Week_past_baseline_EAST</fullName>
        <description>CD Forecast 1 Week past baseline-EAST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_1_Week_past_baseline_WEST</fullName>
        <description>CD Forecast 1 Week past baseline- WEST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bwalter@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_1_week_past_prior_forecast_EAST</fullName>
        <description>CD Forecast 1 week past prior forecast-EAST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Director_of_Operations_East_Project_Manager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_1_week_past_prior_forecast</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_1_week_past_prior_forecast_WEST</fullName>
        <description>CD Forecast 1 week past prior forecast-WEST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bwalter@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_1_week_past_prior_forecast</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_2_weeks_past_baseline</fullName>
        <description>CD Forecast 2 weeks past baseline</description>
        <protected>false</protected>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_2_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_Email</fullName>
        <description>CD Forecast Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_Updated</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_Passed</fullName>
        <description>CD Forecast Passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_has_passed</template>
    </alerts>
    <alerts>
        <fullName>CloseoutBinderNorthernCA</fullName>
        <description>Closeout Binder  - Northern CA</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CloseoutBinder</template>
    </alerts>
    <alerts>
        <fullName>CloseoutBinderSouthernCA</fullName>
        <description>Closeout Binder  - Southern CA</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CloseoutBinder</template>
    </alerts>
    <alerts>
        <fullName>Commissioning_Status_Notifications</fullName>
        <description>Commissioning Status Notifications</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Commissioning_Status_Notifications</template>
    </alerts>
    <alerts>
        <fullName>ContractSignedManagement</fullName>
        <description>Contract Signed - Management</description>
        <protected>false</protected>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bvonmoos@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ContractSignedtoManagment</template>
    </alerts>
    <alerts>
        <fullName>ContractSignedNext30Days</fullName>
        <description>Contract Signed - Next 30 Days</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ContractSignedNext30Days</template>
    </alerts>
    <alerts>
        <fullName>ContractorInspectionsComplete</fullName>
        <ccEmails>chris10@borregosolar.com, toddblicense@borregosolar.com, aaron46@borregosolar.com, joemaster@borregosolar.com</ccEmails>
        <description>Contractor - Inspections Complete</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Inspections_Complete_Contractor</template>
    </alerts>
    <alerts>
        <fullName>ContractorPermitApproved</fullName>
        <ccEmails>chris10@borregosolar.com, toddblicense@borregosolar.com, aaron46@borregosolar.com, joemaster@borregosolar.com</ccEmails>
        <description>Contractor - Permit Approved</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Approved_Contractor</template>
    </alerts>
    <alerts>
        <fullName>ContractorProductonSite</fullName>
        <ccEmails>chris10@borregosolar.com, toddblicense@borregosolar.com, aaron46@borregosolar.com, joemaster@borregosolar.com</ccEmails>
        <description>Contractor - Product on Site</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Product_Site_Contractor</template>
    </alerts>
    <alerts>
        <fullName>DeadProjectAlert</fullName>
        <description>Dead Project Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Dead_Job</template>
    </alerts>
    <alerts>
        <fullName>DeadProjectEC</fullName>
        <description>Dead Project - EC</description>
        <protected>false</protected>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/DeadProjectNotice</template>
    </alerts>
    <alerts>
        <fullName>DesignerChange</fullName>
        <description>Designer Change</description>
        <protected>false</protected>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/DesignerChange</template>
    </alerts>
    <alerts>
        <fullName>ECNotice</fullName>
        <description>EC Notice</description>
        <protected>false</protected>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ECNoticeofHandoff</template>
    </alerts>
    <alerts>
        <fullName>ECNoticeofPlansReady</fullName>
        <description>EC Notice of Plans Ready</description>
        <protected>false</protected>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ECNoticeofPlansReady</template>
    </alerts>
    <alerts>
        <fullName>Fed_Rebate_Approved</fullName>
        <description>Fed Rebate Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Federal_Grant_Approved</template>
    </alerts>
    <alerts>
        <fullName>Federal_REbate_Submitted_Acct_Notification</fullName>
        <description>Federal REbate Submitted- Acct Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Federal_Rebate_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Federal_Rebate_Submitted_Sarah_Notification</fullName>
        <description>Federal Rebate Submitted- Sarah Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Federal_Rebate_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Forecast_Date_Passed</fullName>
        <description>Forecast Date Passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_has_passed</template>
    </alerts>
    <alerts>
        <fullName>GLC_As_Built_Production_Models</fullName>
        <description>GLC As Built Production Models</description>
        <protected>false</protected>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Design_Complete_Create_AsBuilt_Prod_Model</template>
    </alerts>
    <alerts>
        <fullName>HandoffPL</fullName>
        <description>Handoff- P&amp;L</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/HandoffAlert</template>
    </alerts>
    <alerts>
        <fullName>InspectionPassedEC</fullName>
        <description>Inspection Passed - EC</description>
        <protected>false</protected>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/InspectionPassed</template>
    </alerts>
    <alerts>
        <fullName>InspectionPassedECNotCA</fullName>
        <description>Inspection Passed - EC + Not CA</description>
        <protected>false</protected>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/InspectionPassedNotCA</template>
    </alerts>
    <alerts>
        <fullName>Inspections_Passed_PC_s</fullName>
        <description>Inspections Passed- PC&apos;s</description>
        <protected>false</protected>
        <recipients>
            <recipient>lbueckner@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lorenaq@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Inspections_Complete</template>
    </alerts>
    <alerts>
        <fullName>JobNumberChange</fullName>
        <description>Job Number Change</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/JobNumberChange</template>
    </alerts>
    <alerts>
        <fullName>Notification_of_PTO_received</fullName>
        <description>Notification of PTO received</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>astice@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Received</template>
    </alerts>
    <alerts>
        <fullName>Notification_of_PTO_received_WestCoast</fullName>
        <description>Notification of PTO received- West Coast</description>
        <protected>false</protected>
        <recipients>
            <recipient>cthompson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kmartinez@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Received</template>
    </alerts>
    <alerts>
        <fullName>PC_notification_of_Subcontractor_Selection</fullName>
        <description>PC notification of Subcontractor Selection- EAST COAST</description>
        <protected>false</protected>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Subcontractrs_Selected</template>
    </alerts>
    <alerts>
        <fullName>PM_Changed</fullName>
        <description>PM Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PM_Changed</template>
    </alerts>
    <alerts>
        <fullName>PM_Reminder_to_update_SF</fullName>
        <description>PM Reminder to update SF</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PM_Reminder_update_Partners_and_picasa</template>
    </alerts>
    <alerts>
        <fullName>PermitNoticeforDesign</fullName>
        <description>Permit Notice for Design</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/DesignStagePermitSet</template>
    </alerts>
    <alerts>
        <fullName>Permit_Completion_Email</fullName>
        <description>Permit Completion Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Set_Completion_Date_Entered</template>
    </alerts>
    <alerts>
        <fullName>Permit_Forecast_1_week_past_prior_forecast_EAST</fullName>
        <description>Permit Forecast 1 week past prior forecast-EAST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Director_of_Operations_East_Project_Manager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Forecast_Date_1_week_past_prior_forecast</template>
    </alerts>
    <alerts>
        <fullName>Permit_Forecast_1_week_past_prior_forecast_WEST</fullName>
        <description>Permit Forecast 1 week past prior forecast-WEST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bwalter@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Forecast_Date_1_week_past_prior_forecast</template>
    </alerts>
    <alerts>
        <fullName>Permit_Forecast_2_weeks_past_baseline</fullName>
        <description>Permit Forecast 2 weeks past baseline</description>
        <protected>false</protected>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Forecast_Date_2_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>Permit_Forecast_Email</fullName>
        <description>Permit Forecast Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Pemit_Forecast_Date_Updated</template>
    </alerts>
    <alerts>
        <fullName>Permit_Forecast_Passed</fullName>
        <description>Permit Forecast Passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Forecast_Date_has_passed</template>
    </alerts>
    <alerts>
        <fullName>Permit_forecast_1_week_past_baseline_EAST</fullName>
        <description>Permit forecast 1 week past baseline-EAST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>Permit_forecast_1_week_past_baseline_WEST</fullName>
        <description>Permit forecast 1 week past baseline-WEST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bwalter@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>PlansReadyBOMReady</fullName>
        <description>Plans Ready - BOM Ready</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/BOMReady</template>
    </alerts>
    <alerts>
        <fullName>PlansReadyDesignReminder</fullName>
        <description>Plans Ready Design Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/UploadBOM</template>
    </alerts>
    <alerts>
        <fullName>Project_Complete</fullName>
        <description>Project Complete</description>
        <protected>false</protected>
        <recipients>
            <recipient>Internal</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Completed</template>
    </alerts>
    <alerts>
        <fullName>ReadytoHandoffNotice</fullName>
        <description>Ready to Handoff Notice</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/NoticeofHandoff</template>
    </alerts>
    <alerts>
        <fullName>RebateClaim</fullName>
        <description>Rebate Claim</description>
        <protected>false</protected>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ArNotificationofRebateClaimSubmission</template>
    </alerts>
    <alerts>
        <fullName>Rebate_Claim_Submitted_EAst_Coast</fullName>
        <description>Rebate Claim Submitted EAst Coast</description>
        <protected>false</protected>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tskraby@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ArNotificationofRebateClaimSubmission</template>
    </alerts>
    <alerts>
        <fullName>Reviewer_Notification_Bradley</fullName>
        <description>Reviewer Notification-Bradley</description>
        <protected>false</protected>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Reviewer_Notification</template>
    </alerts>
    <alerts>
        <fullName>Reviewer_Notification_Chris</fullName>
        <description>Reviewer Notification-Chris</description>
        <protected>false</protected>
        <recipients>
            <recipient>canderson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Reviewer_Notification</template>
    </alerts>
    <alerts>
        <fullName>StartDateChange</fullName>
        <description>Start Date Change</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/StartDateChanges</template>
    </alerts>
    <alerts>
        <fullName>Submit_to_QA_East</fullName>
        <description>Submit to QA- East</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Submitted_for_QA</template>
    </alerts>
    <alerts>
        <fullName>Submit_to_QA_West</fullName>
        <description>Submit to QA- West</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>dmarks@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Submitted_for_QA</template>
    </alerts>
    <alerts>
        <fullName>X50_Completion_Date_Updated</fullName>
        <description>50% Completion Date Updated</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Set_Completion_Date_Entered</template>
    </alerts>
    <alerts>
        <fullName>X50_Forecast_1_week_past_prior_forecast_EAST</fullName>
        <description>50% Forecast 1 week past prior forecast-EAST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Director_of_Operations_East_Project_Manager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_1_week_past_prior_forecast</template>
    </alerts>
    <alerts>
        <fullName>X50_Forecast_1_week_past_prior_forecast_WEST</fullName>
        <description>50% Forecast 1 week past prior forecast-WEST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bwalter@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_1_week_past_prior_forecast</template>
    </alerts>
    <alerts>
        <fullName>X50_Forecast_Email</fullName>
        <description>50% Forecast Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_Updated</template>
    </alerts>
    <alerts>
        <fullName>X50_forecast_1_week_past_baseline_EAST</fullName>
        <description>50% forecast 1 week past baseline-EAST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>X50_forecast_1_week_past_baseline_WEST</fullName>
        <description>50% forecast 1 week past baseline-WEST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bwalter@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>System_Designer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>X50_forecast_2_weeks_past_baseline</fullName>
        <description>50% forecast 2 weeks past baseline</description>
        <protected>false</protected>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_2_week_past_baseline</template>
    </alerts>
    <fieldUpdates>
        <fullName>Commissioning_Status_submitted</fullName>
        <field>Commissioning_Status__c</field>
        <literalValue>Submitted to QA</literalValue>
        <name>Commissioning Status submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Commissioning_Status_submitted_East</fullName>
        <field>Commissioning_Status__c</field>
        <literalValue>Submitted to QA</literalValue>
        <name>Commissioning Status submitted- East</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Construction_Stage_Duration_Update</fullName>
        <field>Construction_Stage_Change_Date__c</field>
        <formula>now()</formula>
        <name>Construction Stage Duration Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ContractorUpdate</fullName>
        <field>Rebate_Assigned_To__c</field>
        <literalValue>Borrego</literalValue>
        <name>Contractor Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Dead_Project2</fullName>
        <field>SFDC_Project_Status__c</field>
        <literalValue>Dead</literalValue>
        <name>Dead Project2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Design_Stage_Duration_Update</fullName>
        <field>Design_Stage_Change_Date__c</field>
        <formula>now()</formula>
        <name>Design Stage Duration Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>East_Update_Initially_Submitted_to_QA</fullName>
        <description>update Initially Submitted to QA date</description>
        <field>Initially_Submitted_to_QA__c</field>
        <formula>Today()</formula>
        <name>East Update-Initially Submitted to QA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EndDate</fullName>
        <field>SFDC_Project_End_Date__c</field>
        <formula>Today()</formula>
        <name>End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ModulesInUpdate</fullName>
        <field>Modules_Status__c</field>
        <literalValue>Delivered</literalValue>
        <name>Modules In Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OwnerUpdate</fullName>
        <field>Rebate_Assigned_To__c</field>
        <literalValue>Host Customer</literalValue>
        <name>Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Prior_50_Forecast_Date_Update</fullName>
        <field>Prior_50_Forecast_Date__c</field>
        <formula>PRIORVALUE( X50_Forecast_Release_Date__c )</formula>
        <name>Prior 50% Forecast Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Prior_CD_Forecast_Date_Update</fullName>
        <field>Prior_CD_Forecast_Date__c</field>
        <formula>PRIORVALUE( CD_Forecast_Release_Date__c )</formula>
        <name>Prior CD Forecast Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Prior_Permit_Forecast_Date_Update</fullName>
        <field>Prior_Permit_Forecast_Date__c</field>
        <formula>PRIORVALUE( Permit_Forecast_Release_Date__c )</formula>
        <name>Prior Permit Forecast Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RackingInUpdate</fullName>
        <field>Racking_Status__c</field>
        <literalValue>Delivered</literalValue>
        <name>Racking In Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Submit_to_QA</fullName>
        <field>Submit_To_Quality_Assurance__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Submit to QA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Handoff_Completed_and_Approved</fullName>
        <field>Handoff_Completed_and_Approved__c</field>
        <formula>Today()</formula>
        <name>Update-Handoff Completed and Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Project_Status_duration</fullName>
        <field>Project_Stage_Change_Date__c</field>
        <formula>now()</formula>
        <name>Update Project Status duration</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>West_Update_Initially_Submitted_to_QA</fullName>
        <description>update the initially submitted to QA field</description>
        <field>Initially_Submitted_to_QA__c</field>
        <formula>Today()</formula>
        <name>West Update-Initially Submitted to QA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_Final_approved_QC</fullName>
        <description>update when commissioning status = approved</description>
        <field>Final_approved_QC__c</field>
        <formula>Today()</formula>
        <name>update - Final approved QC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_Handoff_was_Scheduled</fullName>
        <field>Handoff_Was_Scheduled__c</field>
        <formula>Today()</formula>
        <name>update - Handoff was Scheduled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <tasks>
        <fullName>CheckCoC</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please check with the Foreman that the Certificate of Completion is posted next to the meter.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check CoC</subject>
    </tasks>
    <tasks>
        <fullName>CheckInterconnection</fullName>
        <assignedToType>role</assignedToType>
        <description>The modules have been delivered for this project.

Please check in on the Interconnection paperwork.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check Interconnection</subject>
    </tasks>
    <tasks>
        <fullName>CheckInterconnectionStatus</fullName>
        <assignedToType>role</assignedToType>
        <description>The modules have been delivered for this project.

Please check in on the Interconnection paperwork.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check Interconnection Status</subject>
    </tasks>
    <tasks>
        <fullName>CheckInwithUtilityonEngineeringReviewApproval</fullName>
        <assignedToType>role</assignedToType>
        <description>Please follow up with the Utility about Interconnection for this project.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check In with Utility on Engineering Review Approval</subject>
    </tasks>
    <tasks>
        <fullName>CheckRebate</fullName>
        <assignedToType>role</assignedToType>
        <description>Verify updated CSI rebate inputs of installed system: solmetric report, orientation and pitch. 

Once rebate is verified, enter Final Rebate Amount and change Rebate Status to Rebate Verified.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check Rebate</subject>
    </tasks>
    <tasks>
        <fullName>CheckRebateCommercial</fullName>
        <assignedToType>role</assignedToType>
        <description>Verify updated CSI rebate inputs of installed system: solmetric report, orientation and pitch. 

Once rebate is verified, enter Final Rebate Amount and change Rebate Status to Rebate Verified.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check Rebate - Commercial</subject>
    </tasks>
    <tasks>
        <fullName>CheckinwithCustomer</fullName>
        <assignedToType>role</assignedToType>
        <description>Please contact the customer and check the status of the Completion form and the Participant&apos;s Agreement.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check in with Customer</subject>
    </tasks>
    <tasks>
        <fullName>CheckinwithUtilityforEngineeringReviewApproval</fullName>
        <assignedToType>role</assignedToType>
        <description>Please follow up with the Utility about Interconnection for this project.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check in with Utility for Engineering Review Approval</subject>
    </tasks>
    <tasks>
        <fullName>CheckonInterconnection</fullName>
        <assignedToType>role</assignedToType>
        <description>The modules have been delivered for this project.

Please check in on the Interconnection paperwork.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check on Interconnection</subject>
    </tasks>
    <tasks>
        <fullName>CheckonProjectCompletion</fullName>
        <assignedToType>role</assignedToType>
        <description>Check if customer has mailed Project Completion form.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check on Project Completion</subject>
    </tasks>
    <tasks>
        <fullName>CheckwithUtilityforEngineeringReviewApproval</fullName>
        <assignedToType>role</assignedToType>
        <description>Please follow up with the Utility about Interconnection for this project.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check with Utility for Engineering Review Approval</subject>
    </tasks>
    <tasks>
        <fullName>CheckwithUtilityonEngineeringReviewApproval</fullName>
        <assignedToType>role</assignedToType>
        <description>Please follow up with the Utility about Interconnection for this project.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Check with Utility on Engineering Review Approval</subject>
    </tasks>
    <tasks>
        <fullName>CloseoutProject</fullName>
        <assignedToType>role</assignedToType>
        <description>Please send the paperwork to MTC and create the closeout binder.</description>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Closeout Project</subject>
    </tasks>
    <tasks>
        <fullName>ContactCustomer</fullName>
        <assignedToType>role</assignedToType>
        <description>Please contact the customer about paperwork.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Contact Customer</subject>
    </tasks>
    <tasks>
        <fullName>ContactUtility</fullName>
        <assignedToType>role</assignedToType>
        <description>Please contact the Utility and arrange having the CoC sent to Borrego.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Contact Utility</subject>
    </tasks>
    <tasks>
        <fullName>DataMonitoringIsRequired</fullName>
        <assignedToType>owner</assignedToType>
        <description>The roof mounts are in on this project and data monitoring will need to be installed. Please coordinate with Service to schedule the installation of the data monitoring system.</description>
        <dueDateOffset>4</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Data Monitoring Is Required</subject>
    </tasks>
    <tasks>
        <fullName>DataMonitoringRequired</fullName>
        <assignedToType>role</assignedToType>
        <description>The roof mounts are in on this project and data monitoring will need to be installed. Please coordinate with the PM to schedule the installation of the data monitoring system.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Data Monitoring Required</subject>
    </tasks>
    <tasks>
        <fullName>InspectionHasPassedCloseoutBinder</fullName>
        <assignedToType>role</assignedToType>
        <description>Please make a closeout binder for this project.

Please inform the EC when you are done.</description>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Inspection Has Passed - Closeout Binder</subject>
    </tasks>
    <tasks>
        <fullName>InspectionPassed</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please pass any necessary paperwork to Customer Care</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Inspection Passed</subject>
    </tasks>
    <tasks>
        <fullName>InspectionPassedCloseoutBinder</fullName>
        <assignedTo>sysuser@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Please make a closeout binder for this project.

Please inform the EC when you are done.</description>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Inspection Passed - Closeout Binder</subject>
    </tasks>
    <tasks>
        <fullName>InspectionPassedCommercialCloseoutBinder</fullName>
        <assignedToType>role</assignedToType>
        <description>Please make a closeout binder for this project.

Please inform the EC when you are done.</description>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Inspection Passed - Commercial Closeout Binder</subject>
    </tasks>
    <tasks>
        <fullName>InterconnectionPlansAreReady</fullName>
        <assignedToType>role</assignedToType>
        <description>The plans are ready for this project. Please submit the initial interconnection paperwork to the utility.

Please change Interconnection Status to Initial Paperwork Submitted.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Interconnection - Plans Are Ready</subject>
    </tasks>
    <tasks>
        <fullName>InterconnectionPlansReady</fullName>
        <assignedToType>role</assignedToType>
        <description>The plans are ready for this project. Please submit the initial interconnection paperwork to the utility.

Please change Interconnection Status to Initial Paperwork Submitted.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Interconnection - Plans Ready</subject>
    </tasks>
    <tasks>
        <fullName>MoveFoldertoCompleted</fullName>
        <assignedToType>role</assignedToType>
        <description>Please move the Customer folder to Completed on the server.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Move Folder to Completed</subject>
    </tasks>
    <tasks>
        <fullName>PassedInspectionPermittoSCE</fullName>
        <assignedToType>role</assignedToType>
        <description>This project passed inspection and the utility company is SCE - please send the signed permit  to the utility.</description>
        <dueDateOffset>4</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Passed Inspection - Permit to SCE</subject>
    </tasks>
    <tasks>
        <fullName>PlansReady</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please send the customer plans and notes for approval. Be sure to CC the EC on the email you send to the customer.

The PDF of the plans is located in the Notes and Attachments section of the project.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Plans Ready</subject>
    </tasks>
    <tasks>
        <fullName>PlansReadyPermit</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please send the building permit to AHJ.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Plans Ready - Permit</subject>
    </tasks>
    <tasks>
        <fullName>PlansReadySendPaperwork</fullName>
        <assignedTo>ElectricalEngineer</assignedTo>
        <assignedToType>role</assignedToType>
        <description>Please do the following:

- Send the SRI to MTC
- Send the Interconnection Application to the Utility</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Plans Ready - Send Paperwork</subject>
    </tasks>
    <tasks>
        <fullName>RebateAbouttoExpire</fullName>
        <assignedToType>owner</assignedToType>
        <description>The rebate on this project will expire in 120 days. If this project is inactive, please change the Project Status to On Hold and contact the EC.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Rebate About to Expire</subject>
    </tasks>
    <tasks>
        <fullName>RebateApproved</fullName>
        <assignedToType>role</assignedToType>
        <description>Please send the commitment letter/award packet/participant agreement to the client.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Rebate Approved</subject>
    </tasks>
    <tasks>
        <fullName>RebateHasBeenVerifiedRequestPayment</fullName>
        <assignedToType>role</assignedToType>
        <description>The rebate for this project has been verified. Please request payment from the utility. Change Rebate Status to Payment Requested.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Rebate Has Been Verified - Request Payment</subject>
    </tasks>
    <tasks>
        <fullName>RebatewasVerifiedRequestPayment</fullName>
        <assignedToType>role</assignedToType>
        <description>The rebate for this project has been verified. Please mail incentive claim form to customer. Please request payment from the utility. 

Change Rebate Status to Payment Requested.</description>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Rebate was Verified - Request Payment</subject>
    </tasks>
    <tasks>
        <fullName>RequestPayment</fullName>
        <assignedToType>role</assignedToType>
        <description>Please be sure that the rebate has been verified and that a Final Rebate Amount has been entered on the project. Please request the rebate and change rebate status to Payment Requested.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Request Payment</subject>
    </tasks>
    <tasks>
        <fullName>ReviewProjectPhotos</fullName>
        <assignedToType>role</assignedToType>
        <description>This project is closed out. Please review the photos on the server and move those appropriate for marketing to the Noteworthy Photo folder.

Please resize the rest of the photos with the VSO resizer.</description>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Project Photos</subject>
    </tasks>
    <tasks>
        <fullName>SendSRItoMTC</fullName>
        <assignedToType>role</assignedToType>
        <description>Please send the SRI to the MTC.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Send SRI to MTC</subject>
    </tasks>
    <tasks>
        <fullName>SubmitBuildingPermitConfirmEquipment</fullName>
        <assignedTo>ElectricalEngineer</assignedTo>
        <assignedToType>role</assignedToType>
        <description>Please confirm the equipment and submit the signed building permit to the utility.
Change Interconnection Status to Application Complete.

Please add Inverters as Assets.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Submit Building Permit, Confirm Equipment</subject>
    </tasks>
    <tasks>
        <fullName>SubmitInitialInterconnectionPaperwork</fullName>
        <assignedToType>role</assignedToType>
        <description>This project has been permitted. Please submit the initial paperwork to the utility.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Submit Initial Interconnection Paperwork</subject>
    </tasks>
    <tasks>
        <fullName>SubmittheBuildingPermitConfirmEquipment</fullName>
        <assignedToType>role</assignedToType>
        <description>Please confirm the equipment and submit the signed building permit to the utility.
Change Interconnection Status to Application Complete.

Please request the rebate. Change rebate status to Payment Requested.

Please add Inverters as Assets.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Submit the Building Permit, Confirm Equipment</subject>
    </tasks>
    <tasks>
        <fullName>SubmittheInitialInterconnectionPaperwork</fullName>
        <assignedToType>role</assignedToType>
        <description>This project has been permitted. Please submit the initial paperwork to the utility.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Submit the Initial Interconnection Paperwork</subject>
    </tasks>
    <tasks>
        <fullName>x1stContactRequired</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please email or call the customer and introduce yourself.
Please enter the 1st contract date in the appropriate field.

** IMPORTANT **
If this system has Data Monitoring, task your Regional Service Technician to check on the project.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>1st Contact Required</subject>
    </tasks>
</Workflow>
