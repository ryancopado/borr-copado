<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ARFinalBilling</fullName>
        <description>AR Final Billing</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PassedInspectionforAR</template>
    </alerts>
    <alerts>
        <fullName>ARFinalBillingRebateDiscrepancy</fullName>
        <description>AR Final Billing - Rebate Discrepancy</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PassedInspectionforARBorregoDiscrepancy</template>
    </alerts>
    <alerts>
        <fullName>AsBuilts</fullName>
        <description>As Builts</description>
        <protected>false</protected>
        <recipients>
            <field>AcctSeed__Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/AsBuilts</template>
    </alerts>
    <alerts>
        <fullName>As_Built_Completed_Date_Populated</fullName>
        <description>As Built Completed Date Populated</description>
        <protected>false</protected>
        <recipients>
            <recipient>Operations_Manager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/As_Built_Completed_Date_Populated_Notification</template>
    </alerts>
    <alerts>
        <fullName>As_Built_Production_model</fullName>
        <description>As-Built Production model</description>
        <protected>false</protected>
        <recipients>
            <field>AcctSeed__Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_90_Complete_Create_AsBuilt_Prod_Model</template>
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
        <fullName>Budget_Finalizedq</fullName>
        <description>Budget Finalizedq</description>
        <protected>false</protected>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Budget_Finalized</template>
    </alerts>
    <alerts>
        <fullName>CD_Completion_Email</fullName>
        <description>CD Completion Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorofEngineeringSystemDesigner</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Engineering_Coordinator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>rly@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_1_week_past_prior_forecast</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_2_weeks_past_baseline</fullName>
        <description>CD Forecast 2 weeks past baseline</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_2_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_Email</fullName>
        <description>CD Forecast Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_Updated</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_Passed</fullName>
        <description>CD Forecast Passed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Date_has_passed</template>
    </alerts>
    <alerts>
        <fullName>CD_Forecast_Release_Date_Change</fullName>
        <description>CD Forecast Release Date Change</description>
        <protected>false</protected>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/CD_Forecast_Release_Date_Change</template>
    </alerts>
    <alerts>
        <fullName>Commissioning_Closeout_Nearing</fullName>
        <description>Commissioning &amp; Closeout Nearing</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>O_M_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Commissioning_Closeout_Nearing</template>
    </alerts>
    <alerts>
        <fullName>ContractSignedManagement</fullName>
        <description>Contract Signed - Management</description>
        <protected>false</protected>
        <recipients>
            <recipient>sysuser@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ContractSignedtoManagment</template>
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
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Dead_Job</template>
    </alerts>
    <alerts>
        <fullName>DesignerChange</fullName>
        <description>Designer Change</description>
        <protected>false</protected>
        <recipients>
            <field>AcctSeed__Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/DesignerChange</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_OM_and_SPG_whenever_PTO_is_reached_and_Performance_Guarantee_is_i</fullName>
        <description>EAST email alert to OM and SPG whenever PTO is reached and Performance Guarantee is included</description>
        <protected>false</protected>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kcrowley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Has_been_Reached_and_Performance_Guarantee_Included</template>
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
        <fullName>Federal_Rebate_Submitted_Sarah_Notification</fullName>
        <description>Federal Rebate Submitted- Sarah Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>sysuser@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Federal_Rebate_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Feedback_Meeting_Reminder</fullName>
        <description>Feedback Meeting Reminder</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>jaskins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>LH_Applications_Eng__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Feedback_Meeting_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Forecast_Date_Passed</fullName>
        <description>Forecast Date Passed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_has_passed</template>
    </alerts>
    <alerts>
        <fullName>GLC_As_Built_Production_Models</fullName>
        <description>GLC As Built Production Models</description>
        <protected>false</protected>
        <recipients>
            <recipient>msponseller@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pwilliams@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_90_Complete_Create_AsBuilt_Prod_Model</template>
    </alerts>
    <alerts>
        <fullName>Hand_Off_Date_Change</fullName>
        <description>Hand Off Date Change</description>
        <protected>false</protected>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Hand_Off_Date_Change</template>
    </alerts>
    <alerts>
        <fullName>Inspection_Checklist_Alert</fullName>
        <description>Inspection Checklist Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Inspection_Checklist_Not_Uploaded</template>
    </alerts>
    <alerts>
        <fullName>Inspections_Passed_PC_s</fullName>
        <description>Inspections Passed- PC&apos;s</description>
        <protected>false</protected>
        <recipients>
            <recipient>Operations_Manager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Inspections_Complete</template>
    </alerts>
    <alerts>
        <fullName>Inverter_Status_Borrego_Received_Del_Date_Changed</fullName>
        <description>Inverter Status Borrego Received &amp; Del Date Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Inverter_Del_Date_Updated_Borrego_Recd_Status</template>
    </alerts>
    <alerts>
        <fullName>Inverter_Status_PO_Placed_Del_Date_Changed</fullName>
        <description>Inverter Status PO Placed &amp; Del Date Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Inverter_Del_Date_Updated_PO_Placed</template>
    </alerts>
    <alerts>
        <fullName>JobNumberChange</fullName>
        <description>Job Number Change</description>
        <protected>false</protected>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>marlise@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/JobNumberChange</template>
    </alerts>
    <alerts>
        <fullName>Margin_Change_Notification_East</fullName>
        <description>Margin Change Notification - East</description>
        <protected>false</protected>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Margin_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Margin_Change_Notification_West</fullName>
        <description>Margin Change Notification - West</description>
        <protected>false</protected>
        <recipients>
            <recipient>etam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Margin_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Mobilization_Date_Passed</fullName>
        <description>Mobilization Date Passed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Mobilization_Date_Passed</template>
    </alerts>
    <alerts>
        <fullName>Module_Del_Date_Updated_PO_Placed</fullName>
        <description>Module Del Date Updated &amp; PO Placed</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Module_Del_Date_Updated_PO_Placed</template>
    </alerts>
    <alerts>
        <fullName>Module_Delivery_Date_Update_Borrego_Received_Status</fullName>
        <description>Module Delivery Date Update &amp; Borrego Received Status</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sosterling@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Module_Del_Date_Updated_Borrego_Received</template>
    </alerts>
    <alerts>
        <fullName>New_Project</fullName>
        <description>New Project</description>
        <protected>false</protected>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/New_Project</template>
    </alerts>
    <alerts>
        <fullName>Notification_of_PTO_received</fullName>
        <description>Notification of PTO received</description>
        <protected>false</protected>
        <recipients>
            <recipient>Accounting_All</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dbacchetti@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>egrenier@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jkraus@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kcorbett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>swillett@borregosolar.com</recipient>
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
            <recipient>Accounting_All</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>COO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dbacchetti@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kmartinez@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sshiokari@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Received</template>
    </alerts>
    <alerts>
        <fullName>On_WIP</fullName>
        <description>On WIP</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bdo@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jhetzel@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kknight@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lforrester@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tskraby@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/On_WIP</template>
    </alerts>
    <alerts>
        <fullName>PC_notification_of_Subcontractor_Selection</fullName>
        <description>PC notification of Subcontractor Selection- EAST COAST</description>
        <protected>false</protected>
        <recipients>
            <recipient>Operations_Manager</recipient>
            <type>role</type>
        </recipients>
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
            <recipient>hfaustino@borregosolar.com</recipient>
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
        <fullName>POST_WIP_status_has_been_reached_begin_Customer_Feedback_process</fullName>
        <description>POST WIP status has been reached - begin Customer Feedback process</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/POST_WIP_Status_Reached_Customer_Feedback_Needed</template>
    </alerts>
    <alerts>
        <fullName>PTO_Date_Change</fullName>
        <description>PTO Date Change</description>
        <protected>false</protected>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Date_Change</template>
    </alerts>
    <alerts>
        <fullName>PTO_Date_Passed</fullName>
        <description>PTO Date Passed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Date_Passed</template>
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
        <recipients>
            <recipient>Engineering_Coordinator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>rly@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Forecast_Date_1_week_past_prior_forecast</template>
    </alerts>
    <alerts>
        <fullName>Permit_Forecast_2_weeks_past_baseline</fullName>
        <description>Permit Forecast 2 weeks past baseline</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Forecast_Date_2_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>Permit_Forecast_Email</fullName>
        <description>Permit Forecast Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Pemit_Forecast_Date_Updated</template>
    </alerts>
    <alerts>
        <fullName>Permit_Forecast_Passed</fullName>
        <description>Permit Forecast Passed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Permit_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>Project_Buyer_Owner_change</fullName>
        <description>Project Buyer / Owner change</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>btaylor@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>klawver@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>saslam@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>soleary@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Internal_Civil_Engineer_L__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>LH_Applications_Eng__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>ROD__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Senior_Design_Engineer_L__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Project_Buyer_Owner</template>
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
        <fullName>Project_Construction_Stage_Reached_Customer_Feedback_Needed_East</fullName>
        <description>Project Construction Stage Reached - Customer Feedback Needed - East</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kcorbett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Construction_Reached_Customer_Feedback_Needed</template>
    </alerts>
    <alerts>
        <fullName>Project_Construction_Stage_Reached_Customer_Feedback_Needed_Mid_Atlantic</fullName>
        <description>Project Construction Stage Reached - Customer Feedback Needed - Mid Atlantic</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Construction_Reached_Customer_Feedback_Needed</template>
    </alerts>
    <alerts>
        <fullName>Project_Construction_Stage_Reached_Customer_Feedback_Needed_Midwest</fullName>
        <description>Project Construction Stage Reached - Customer Feedback Needed - Midwest</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jmeiltoft@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhanagan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Construction_Reached_Customer_Feedback_Needed</template>
    </alerts>
    <alerts>
        <fullName>Project_Construction_Stage_Reached_Customer_Feedback_Needed_Nor_Cal</fullName>
        <description>Project Construction Stage Reached - Customer Feedback Needed - Nor Cal</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbrooke@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhanagan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Construction_Reached_Customer_Feedback_Needed</template>
    </alerts>
    <alerts>
        <fullName>Project_Construction_Stage_Reached_Customer_Feedback_Needed_So_Cal</fullName>
        <description>Project Construction Stage Reached - Customer Feedback Needed - So Cal</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>afernandez@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mhanagan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Construction_Reached_Customer_Feedback_Needed</template>
    </alerts>
    <alerts>
        <fullName>Project_Deadline_Date_Change_Notification_EAST</fullName>
        <description>Project Deadline Date Change Notification - EAST</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Deadline_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_Deadline_Date_Change_Notification_WEST</fullName>
        <description>Project Deadline Date Change Notification - WEST</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Deadline_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_Key_Date_Change_Notification_East</fullName>
        <description>Project Key Date Change Notification - East</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Key_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_Key_Date_Change_Notification_PPA</fullName>
        <description>Project Key Date Change Notification - PPA</description>
        <protected>false</protected>
        <recipients>
            <recipient>aaron@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>wbush@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Key_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_Key_Date_Change_Notification_West</fullName>
        <description>Project Key Date Change Notification - West</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Key_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_Key_Date_Change_Notification_With_PM_East</fullName>
        <description>Project Key Date Change Notification With PM - East</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Key_Date_Change_Notification_With_PM</template>
    </alerts>
    <alerts>
        <fullName>Project_Key_Date_Change_Notification_With_PM_West</fullName>
        <description>Project Key Date Change Notification With PM - West</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Key_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_Margin_Changed_by_25K_NorCal</fullName>
        <description>Project - Margin Changed by $25K NorCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>elaramee@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbrooke@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Project_Margin_Change</template>
    </alerts>
    <alerts>
        <fullName>Project_Margin_Changed_by_25K_SoCal</fullName>
        <description>Project - Margin Changed by $25K SoCal</description>
        <protected>false</protected>
        <recipients>
            <recipient>afernandez@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>elaramee@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Project_Margin_Change</template>
    </alerts>
    <alerts>
        <fullName>Project_Mobilitization_Date_Change_EAST</fullName>
        <description>Project Mobilitization Date Change - EAST</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Mobilization_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_Mobilitization_Date_Change_WEST</fullName>
        <description>Project Mobilitization Date Change - WEST</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Mobilization_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_PTO_Date_Change_Notification_Email_EAST</fullName>
        <description>Project PTO Date Change Notification Email - EAST</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_PTO_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_PTO_Date_Change_Notification_Email_WEST</fullName>
        <description>Project PTO Date Change Notification Email - West</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kkearney@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_PTO_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Project_Team_Has_Been_Updated</fullName>
        <description>Project Team Has Been Updated</description>
        <protected>false</protected>
        <recipients>
            <recipient>Engineering_Coordinator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>rly@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Team_Has_Been_Updated</template>
    </alerts>
    <alerts>
        <fullName>Projection_Locked</fullName>
        <description>Projection Locked</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>hfaustino@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jhetzel@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lraphael@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tdawson@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>LH_Applications_Eng__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Projection_Locked</template>
    </alerts>
    <alerts>
        <fullName>Racking_Status_Borrego_Received_Del_Date_Changed</fullName>
        <description>Racking Status Borrego Received &amp; Del Date Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Racking_Del_Date_Updated_Borrego_Received</template>
    </alerts>
    <alerts>
        <fullName>Racking_Status_PO_Placed_Del_Date_Changed</fullName>
        <description>Racking Status PO Placed &amp; Del Date Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>roleSubordinatesInternal</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Racking_Del_Date_Updated_PO_Placed</template>
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
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/ArNotificationofRebateClaimSubmission</template>
    </alerts>
    <alerts>
        <fullName>Reviewer_Notification</fullName>
        <description>Reviewer Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Reviewer_L__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Reviewer_Notification</template>
    </alerts>
    <alerts>
        <fullName>Site_PTO_Date_Change_Notification_Email_EAST</fullName>
        <description>Site PTO Date Change Notification Email - EAST</description>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>EC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Foreman__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_PTO_Date_Change_Notification</template>
    </alerts>
    <alerts>
        <fullName>Site_Use_Forecast_Date_1_week_past_baseline</fullName>
        <description>Site Use Forecast Date 1 week past baseline</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Site_Use_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>Site_Use_Forecast_email</fullName>
        <description>Site Use Forecast email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Site_Use_Forecast_Date_Updated</template>
    </alerts>
    <alerts>
        <fullName>Site_Use_Permis_Set_Forecast_Date_has_passed</fullName>
        <description>Site Use Permis Set Forecast Date has passed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Site_Use_Permis_Set_Forecast_Date_has_passed</template>
    </alerts>
    <alerts>
        <fullName>Site_Use_Permit_Set_Completion_Date_Updated</fullName>
        <description>Site Use Permit Set Completion Date Updated</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>Engineering_Coordinator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rly@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Site_Use_Permit_Set_Completion_Date_Entered</template>
    </alerts>
    <alerts>
        <fullName>Site_Use_Permit_Set_Completion_Date_Updated_PM</fullName>
        <description>Site Use Permit Set Completion Date Updated - PM</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Site_Use_Permit_Set_Completion_Date_Entered_PM</template>
    </alerts>
    <alerts>
        <fullName>Site_Use_Permit_Set_Forecast_Date_1_week_past_prior_forecast</fullName>
        <description>Site Use Permit Set Forecast Date 1 week past prior forecast</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Site_Use_Permit_Set_Forecast_Date_1_week_past_prior_forecast</template>
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
        <fullName>Total_Indirects_Budgeted_Changed_Email_Alert</fullName>
        <description>Total Indirects Budgeted Changed Email Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>VPFinance</recipient>
            <type>role</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Alerts/Total_Indirects_Budgeted_Changed</template>
    </alerts>
    <alerts>
        <fullName>WEST_Alert_to_OM_and_SPG_whenever_PTO_is_reached_and_Performance_Guarantee_is_i</fullName>
        <description>WEST email alert to OM and SPG whenever PTO is reached and Performance Guarantee is included</description>
        <protected>false</protected>
        <recipients>
            <recipient>bradley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lpollinger@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Has_been_Reached_and_Performance_Guarantee_Included</template>
    </alerts>
    <alerts>
        <fullName>X50_Completion_Date_Updated</fullName>
        <description>50% Completion Date Updated</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>PurchasingandLogisticsManager</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rly@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>msugihara@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_1_week_past_prior_forecast</template>
    </alerts>
    <alerts>
        <fullName>X50_Forecast_Email</fullName>
        <description>50% Forecast Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_Updated</template>
    </alerts>
    <alerts>
        <fullName>X50_Set_Completion_Date_Entered_PM</fullName>
        <description>50% Set Completion Date Entered - PM</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Set_Completion_Date_Entered_PM</template>
    </alerts>
    <alerts>
        <fullName>X50_forecast_1_week_past_baseline_EAST</fullName>
        <description>50% forecast 1 week past baseline-EAST</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbusch@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
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
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_1_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>X50_forecast_2_weeks_past_baseline</fullName>
        <description>50% forecast 2 weeks past baseline</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>bmorrison@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X50_Forecast_Date_2_week_past_baseline</template>
    </alerts>
    <alerts>
        <fullName>X90_Complete_Begin_Closeout</fullName>
        <description>90% Complete - Begin Closeout</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/X90_Complete_Begin_Closeout</template>
    </alerts>
    <alerts>
        <fullName>notification_to_Marketing_project_complete</fullName>
        <description>notification to Marketing- project complete</description>
        <protected>false</protected>
        <recipients>
            <recipient>MarketingDirector</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Website</template>
    </alerts>
    <fieldUpdates>
        <fullName>Check_Sync_with_Procore_field</fullName>
        <description>Checks Synch with Procore field based on Current Contract Price field changes</description>
        <field>Sync_with_Procore__c</field>
        <literalValue>1</literalValue>
        <name>Check Sync with Procore field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
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
        <fullName>Const_Stage_90_Completed_Used</fullName>
        <field>Cons_Stage_90_Completed_Used__c</field>
        <literalValue>1</literalValue>
        <name>Const Stage 90% Completed Used</name>
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
        <fullName>Contract_Value_Update</fullName>
        <field>Project_Contract_Value__c</field>
        <formula>Original_Contract_Price__c</formula>
        <name>Contract Value Update</name>
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
        <fullName>Date_Project_On_WIP_Status</fullName>
        <description>updates Date Project On WIP Status</description>
        <field>Date_Project_On_WIP_Status__c</field>
        <formula>NOW()</formula>
        <name>Date Project On WIP Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Sales_Budget_Locked</fullName>
        <description>records the date when Sales Budget locks</description>
        <field>Date_Sales_Budget_Locked__c</field>
        <formula>TODAY()</formula>
        <name>Date Sales Budget Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Dead_Project2</fullName>
        <field>Overall_Project_Status__c</field>
        <literalValue>Dead</literalValue>
        <name>Dead Project2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
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
        <fullName>Enter_PM_Budget</fullName>
        <field>Contract_Price_at_Budget_Lock__c</field>
        <formula>Final_Contract_PriceProject__c</formula>
        <name>Enter PM Budget</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>HandoffDateUpdate</fullName>
        <field>Hand_off_Date__c</field>
        <formula>Today()</formula>
        <name>Handoff Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>InProgressUpdate</fullName>
        <field>Overall_Project_Status__c</field>
        <literalValue>Construction</literalValue>
        <name>In Progress Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>InverterInUpdate</fullName>
        <field>Inverter_Status__c</field>
        <literalValue>Delivered</literalValue>
        <name>Inverter In Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inverter_Delivery_Date_c</fullName>
        <field>Inverter_Delivery_Date_Updated__c</field>
        <formula>TODAY()</formula>
        <name>Inverter_Delivery_Date__c</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mobilization_Baseline_Date</fullName>
        <field>Mobilization_Baseline__c</field>
        <formula>SFDC_Project_Start_Date__c</formula>
        <name>Mobilization Baseline Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Module_Delivery_Date_Updated</fullName>
        <field>Module_Delivery_Date_Updated__c</field>
        <formula>TODAY()</formula>
        <name>Module Delivery Date Updated</name>
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
        <fullName>Opportunity_Owner_Manager_Email</fullName>
        <description>Updates the Opportunity Owner Manager Email field (hidden) so it can be used on email alerts.</description>
        <field>Opportunity_Owner_Manager_Email__c</field>
        <formula>EC__r.Manager.Email</formula>
        <name>Opportunity Owner Manager Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PTO_Baseline_Date</fullName>
        <field>PTO_Baseline__c</field>
        <formula>PTO_Date__c</formula>
        <name>PTO Baseline Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Parent_ID</fullName>
        <description>updates text field with the ID of the related  Parent account upon project creation</description>
        <field>Parent_ID__c</field>
        <formula>AcctSeed__Account__r.ParentId</formula>
        <name>Parent ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PermissiontoOperate</fullName>
        <field>PTO_Date__c</field>
        <formula>Today()</formula>
        <name>Permission to Operate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pre_Contract_Check</fullName>
        <field>Pre_Contract__c</field>
        <literalValue>1</literalValue>
        <name>Pre-Contract Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Previous_Budget1</fullName>
        <field>Roll_Up_Budget_Line_Items__c</field>
        <formula>AcctSeed__Budgeted_Amount__c</formula>
        <name>Previous Budget1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Previous_Budget_Rollup1</fullName>
        <field>Roll_Up_Budget_Line_Items__c</field>
        <formula>Roll_Up_Budget_Line_Items__c</formula>
        <name>Previous Budget Rollup1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Previous_DM_dollars</fullName>
        <field>Previous_DM_dollars__c</field>
        <formula>PRIORVALUE( Direct_Margin_Dollars__c )</formula>
        <name>Previous DM $</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Previous_Margin</fullName>
        <field>Previous_Margin__c</field>
        <formula>PRIORVALUE( Margin_Active__c )</formula>
        <name>Previous Margin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <fullName>Prior_Key_Date_Changes_1</fullName>
        <description>If mobilization date is changed</description>
        <field>Prior_Project_Mobilization_Date__c</field>
        <formula>IF(ISCHANGED(SFDC_Project_Start_Date__c),PRIORVALUE( SFDC_Project_Start_Date__c ), Prior_Project_Mobilization_Date__c )</formula>
        <name>Prior Key Date Changes 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Prior_Key_Date_Changes_2</fullName>
        <description>If Substantial Completion Date changes</description>
        <field>Prior_Substantial_Completion_Date__c</field>
        <formula>IF(ISCHANGED(SFDC_Project_End_Date__c ),PRIORVALUE( SFDC_Project_End_Date__c ), Prior_Substantial_Completion_Date__c )</formula>
        <name>Prior Key Date Changes 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Prior_Key_Date_Changes_3</fullName>
        <description>If Deadline date is changed</description>
        <field>Prior_Deadline_Date__c</field>
        <formula>IF(ISCHANGED( Deadline_Date__c ),PRIORVALUE( Deadline_Date__c ), Prior_Deadline_Date__c )</formula>
        <name>Prior Key Date Changes 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Prior_Key_Date_Changes_4</fullName>
        <description>If PTO Date changes</description>
        <field>Prior_PTO_Date__c</field>
        <formula>IF(ISCHANGED( PTO_Date__c ),PRIORVALUE( PTO_Date__c ),  Prior_PTO_Date__c  )</formula>
        <name>Prior Key Date Changes 4</name>
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
        <fullName>Prior_Site_Use_Forecast_Date_entered</fullName>
        <field>Prior_Site_Use_Permit_Set_Forecast__c</field>
        <formula>PRIORVALUE( Site_Use_Permit_Set_Forecast__c )</formula>
        <name>Prior Site Use Forecast Date entered</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ProjectComplete</fullName>
        <field>Overall_Project_Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Project Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ProjectStatusPreContract</fullName>
        <field>Overall_Project_Status__c</field>
        <literalValue>Pre-Contract</literalValue>
        <name>Project Status - Pre Contract</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Contract_Value</fullName>
        <field>Project_Contract_Value__c</field>
        <formula>Original_Contract_Price__c</formula>
        <name>Project Contract Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Owner_Update_East</fullName>
        <description>Update the project owner field</description>
        <field>OwnerId</field>
        <lookupValue>jbusch@borregosolar.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Project Owner Update - East</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Owner_Update_West</fullName>
        <field>OwnerId</field>
        <lookupValue>jbrooke@borregosolar.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Project Owner Update - West</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
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
        <fullName>Racking_Delivery_Date_Updated</fullName>
        <field>Racking_Delivery_Date_Updated__c</field>
        <formula>TODAY()</formula>
        <name>Racking Delivery Date Updated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revision_Number_Current</fullName>
        <field>Release_Level_Current__c</field>
        <formula>Latest_Release_Level__c</formula>
        <name>Revision Number (Current)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revision_Number_Prior</fullName>
        <field>Release_Level_Prior__c</field>
        <formula>PRIORVALUE( Latest_Release_Level__c )</formula>
        <name>Revision Number (Prior)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPG_DAS_100_Complete</fullName>
        <description>Captures when the SPG DAS QA Status field reaches 100% Complete</description>
        <field>Date_SPG_DAS_Status_100__c</field>
        <formula>NOW()</formula>
        <name>SPG DAS 100% Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Substantial_Completion_Baseline</fullName>
        <field>Substantial_Completion_Baseline__c</field>
        <formula>SFDC_Project_End_Date__c</formula>
        <name>Substantial Completion Baseline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <fullName>Update_Date_Projection_Locked</fullName>
        <field>Date_Projection_Locked__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Projection Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Design_Notes</fullName>
        <field>Design_Notes__c</field>
        <formula>TEXT(TODAY())+ &quot; &quot; + LEFT($User.Alias,2) + &quot;:&quot; + &quot; &quot;+  New_Design_Note__c  + BR() + 
BR() 
+ PRIORVALUE( Design_Notes__c )</formula>
        <name>Update Design Notes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <fullName>Update_Margin_Change_Explanation</fullName>
        <description>copies the New Margin Change Explanation into the Margin Change Explanation to capture historical comments</description>
        <field>Comments_on_Budget__c</field>
        <formula>TEXT(TODAY())+ &quot; &quot; 
+ LEFT($User.Alias,2) + &quot;:&quot; + &quot; &quot; 
+ Margin_Change_Explanation__c + BR() + 
BR() + PRIORVALUE( Comments_on_Budget__c )</formula>
        <name>Update Margin Change Explanation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Margin_Flag</fullName>
        <field>MarginIsChanged__c</field>
        <literalValue>1</literalValue>
        <name>Update Margin Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Margin_Flag1</fullName>
        <field>MarginIsChanged__c</field>
        <literalValue>0</literalValue>
        <name>Update Margin Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Previous_Budget</fullName>
        <field>Previous_Budget__c</field>
        <formula>PRIORVALUE( Total_Indirects_Budgeted__c )</formula>
        <name>Update Previous Budget</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WIP_Accounting_period</fullName>
        <field>WIP_Accounting_period__c</field>
        <formula>TEXT(YEAR(TODAY())) &amp; &quot;-&quot; &amp; LPAD(TEXT(MONTH(TODAY())),2,&quot;0&quot;)</formula>
        <name>WIP Accounting period</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>change_margin1</fullName>
        <field>Change_In_Margin__c</field>
        <formula>IF(ISNULL(Previous_Margin__c),0, Previous_Margin__c)-  IF(ISNULL(Margin_Active__c),0, Margin_Active__c)</formula>
        <name>change margin1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>change_margin2</fullName>
        <field>Change_In_Margin__c</field>
        <formula>0</formula>
        <name>change margin2</name>
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
    <rules>
        <fullName>Budget Finalized Notification</fullName>
        <actions>
            <name>Budget_Finalizedq</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.Budget_Finalized_100__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Budgeted Expense Change</fullName>
        <actions>
            <name>Previous_Budget1</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Previous_Budget_Rollup1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED( Previous_DM_dollars__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Construction Reached - Customer Survey - East</fullName>
        <actions>
            <name>Project_Construction_Stage_Reached_Customer_Feedback_Needed_East</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>alerts specific users in eastern region that construction has been reached and time for customer feedback survey to be sent</description>
        <formula>AND( ISPICKVAL(Overall_Project_Status__c,&quot;Construction&quot;),   OR( ISPICKVAL( Branch__c , &quot;New England&quot;), ISPICKVAL( Branch__c, &quot;Boston&quot;)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Construction Reached - Customer Survey - Mid Atlantic</fullName>
        <actions>
            <name>Project_Construction_Stage_Reached_Customer_Feedback_Needed_Mid_Atlantic</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>alerts specific users in mid atlantic region that construction has been reached and time for customer feedback survey to be sent</description>
        <formula>AND( ISPICKVAL(Overall_Project_Status__c,&quot;Construction&quot;),   ISPICKVAL( Branch__c , &quot;Mid Atlantic&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Construction Reached - Customer Survey - Midwest</fullName>
        <actions>
            <name>Project_Construction_Stage_Reached_Customer_Feedback_Needed_Midwest</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>alerts specific users in midwest region that construction has been reached and time for customer feedback survey to be sent</description>
        <formula>AND( ISPICKVAL(Overall_Project_Status__c,&quot;Construction&quot;),   ISPICKVAL( Branch__c , &quot;Midwest&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Construction Reached - Customer Survey - NorCal</fullName>
        <actions>
            <name>Project_Construction_Stage_Reached_Customer_Feedback_Needed_Nor_Cal</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>alerts specific users in northren ca region that construction has been reached and time for customer feedback survey to be sent</description>
        <formula>AND( ISPICKVAL(Overall_Project_Status__c,&quot;Construction&quot;),   OR( ISPICKVAL( Branch__c , &quot;Oakland&quot;), ISPICKVAL( Branch__c, &quot;Berkley&quot;), ISPICKVAL( Branch__c, &quot;NorCal&quot;)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Construction Reached - Customer Survey - SoCal</fullName>
        <actions>
            <name>Project_Construction_Stage_Reached_Customer_Feedback_Needed_So_Cal</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>alerts specific users in southern ca region that construction has been reached and time for customer feedback survey to be sent</description>
        <formula>AND( ISPICKVAL(Overall_Project_Status__c,&quot;Construction&quot;),   OR( ISPICKVAL( Branch__c , &quot;San Diego&quot;), ISPICKVAL( Branch__c, &quot;NorCal&quot;)) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Date Project On WIP Status</fullName>
        <actions>
            <name>Date_Project_On_WIP_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.WIP_Status__c</field>
            <operation>equals</operation>
            <value>On WIP</value>
        </criteriaItems>
        <criteriaItems>
            <field>AcctSeed__Project__c.Date_Project_On_WIP_Status__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>updates Date Project On WIP Status field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Dead Project</fullName>
        <actions>
            <name>DeadProjectAlert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Dead_Project2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISPICKVAL(AcctSeed__Opportunity__r.StageName ,&quot;Closed Lost&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Hand Off Date Change</fullName>
        <actions>
            <name>Hand_Off_Date_Change</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Notify Ryan Burrowbridge if this date changes</description>
        <formula>ISCHANGED( Hand_off_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Margin Change %2425K NorCal</fullName>
        <actions>
            <name>Project_Margin_Changed_by_25K_NorCal</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Sends an email alert to ROD when the Margin changes by $25K over/under.</description>
        <formula>AND( OR( ISPICKVAL( Branch__c, &quot;Oakland&quot; ), ISPICKVAL( Branch__c, &quot;Berkeley&quot; ) ), ISCHANGED( Direct_Margin_Dollars__c ), OR( Previous_DM_dollars__c &gt; ( Direct_Margin_Dollars__c + 10000 ), Previous_DM_dollars__c &lt; ( Direct_Margin_Dollars__c - 10000 ) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Margin Change %2425K SoCal</fullName>
        <actions>
            <name>Project_Margin_Changed_by_25K_SoCal</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Sends an email alert to ROD when the Margin changes by $25K over/under.</description>
        <formula>AND( ISPICKVAL( Branch__c, &quot;San Diego&quot; ), ISCHANGED( Direct_Margin_Dollars__c ), OR( Previous_DM_dollars__c &gt; ( Direct_Margin_Dollars__c + 25000 ), Previous_DM_dollars__c &lt; ( Direct_Margin_Dollars__c - 25000 ) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Margin Change Notification - East</fullName>
        <actions>
            <name>Margin_Change_Notification_East</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Margin_Flag1</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>change_margin2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>alert when the Margin Changes more than 1% (both increase and decrease)</description>
        <formula>AND( MarginIsChanged__c ==true,OR(ISPICKVAL( Branch__c,&quot;Boston&quot;),ISPICKVAL( Branch__c,&quot;Mid Atlantic&quot;)),OR( Change_In_Margin__c &gt;= 0.01, Change_In_Margin__c &lt;= -0.01))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Margin Change Notification - West</fullName>
        <actions>
            <name>Margin_Change_Notification_West</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Margin_Flag1</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>change_margin2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>alert when the Margin Changes more than 1% (both increase and decrease)</description>
        <formula>AND( MarginIsChanged__c ==true,OR(ISPICKVAL( Branch__c,&quot;Oakland&quot;),ISPICKVAL( Branch__c,&quot;San Diego&quot;),ISPICKVAL( Branch__c,&quot;Puerto Rico&quot;)),OR( Change_In_Margin__c &gt;= 0.01, Change_In_Margin__c &lt;= -0.01))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Margin Change Explanation</fullName>
        <actions>
            <name>Update_Margin_Change_Explanation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED( Margin_Change_Explanation__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>On WIP</fullName>
        <actions>
            <name>On_WIP</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Date_Project_On_WIP_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>WIP_Accounting_period</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.WIP_Status__c</field>
            <operation>equals</operation>
            <value>On WIP</value>
        </criteriaItems>
        <description>If a project moves onto the WIP</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PM Budget Contract Value Update</fullName>
        <actions>
            <name>Enter_PM_Budget</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Fills in the PM Budget Contract field when the PM Budget gets locked</description>
        <formula>PM_Lock__c=TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PM Changed</fullName>
        <actions>
            <name>PM_Changed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>emails accounting when PM is changed on a project</description>
        <formula>ISCHANGED( OwnerId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>POST WIP Reached - Customer Survey</fullName>
        <actions>
            <name>POST_WIP_status_has_been_reached_begin_Customer_Feedback_process</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>alerts specific users that a project has moved to POST WIP status and its time for customer feedback survey to be sent</description>
        <formula>ISPICKVAL( WIP_Status__c ,&quot;Post WIP&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Parent ID</fullName>
        <actions>
            <name>Parent_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>populates text field Parent ID with the SF ID of the related Parent Account on the project, used mostly in Customer Portal to help with filtering/permissions</description>
        <formula>AND( RecordType.DeveloperName=&apos;O_M_Project&apos;,
NOT(ISBLANK(Parent_Account__c)),
ISCHANGED( Parent_Account__c )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Pre-Contract Creation</fullName>
        <actions>
            <name>Pre_Contract_Check</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ProjectStatusPreContract</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( Job_Number__c &lt;&gt; &quot;901-0515&quot;,(OR(ISPICKVAL( AcctSeed__Opportunity__r.StageName, &quot;Prospecting&quot;), ISPICKVAL( AcctSeed__Opportunity__r.StageName, &quot;Qualified&quot;), ISPICKVAL( AcctSeed__Opportunity__r.StageName, &quot;Project Awarded&quot;), ISPICKVAL( AcctSeed__Opportunity__r.StageName, &quot;LOI Signed&quot;),ISPICKVAL( AcctSeed__Opportunity__r.StageName, &quot;Option Lease Executed&quot;),ISPICKVAL( AcctSeed__Opportunity__r.StageName, &quot;Proposal Submitted&quot;), 
ISPICKVAL( AcctSeed__Opportunity__r.StageName, &quot;Shortlisted/Interviews&quot;))))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project Buyer %2F Owner Email Alert</fullName>
        <actions>
            <name>Project_Buyer_Owner_change</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISCHANGED( Buyer__c ),     NOT( ISNEW() ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Project Complete</fullName>
        <actions>
            <name>Project_Complete</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.SFDC_Project_Stage__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>email notification of complete project</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project Created</fullName>
        <actions>
            <name>New_Project</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Opportunity_Owner_Manager_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Project_Contract_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.Name</field>
            <operation>notEqual</operation>
            <value>1</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>ProjectContractValue</fullName>
        <actions>
            <name>Project_Contract_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.Job_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>updates the contract value from the oppty upon creation.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Projection Locked</fullName>
        <actions>
            <name>Feedback_Meeting_Reminder</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Projection_Locked</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Date_Projection_Locked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.PM_Lock__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Projection/Budget Locked Email Alerts</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SPG DAS 100%25 Complete</fullName>
        <actions>
            <name>SPG_DAS_100_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.SPG_DAS_QA_Status__c</field>
            <operation>equals</operation>
            <value>100% Complete</value>
        </criteriaItems>
        <description>captures when the SPG DAS QA status field is equal to 100% Complete</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Sales Budget Locked</fullName>
        <actions>
            <name>Date_Sales_Budget_Locked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.Sales_Budget_Locked__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>records the date when the Sales Budget is locked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Total Indirects Budgeted Changed</fullName>
        <actions>
            <name>Total_Indirects_Budgeted_Changed_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Previous_Budget</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sends a notification when the value for Total Indirects Budgeted changes.</description>
        <formula>Previous_Budget__c &lt;&gt; Budgets_Total__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Procore Project Sync Checkbox</fullName>
        <actions>
            <name>Check_Sync_with_Procore_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Checks Sync with Procore checkbox if changes are made that need to be synced with Procore</description>
        <formula>AND(
NOT( ISBLANK( Procore_Project_ID__c )),
OR(
ISCHANGED( Final_Contract_PriceProject__c ),
ISCHANGED( Overall_Project_Size_Watts_STC__c ),
ISCHANGED( Procore_Project_ID__c )
)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>z%2E Dead Project - AR</fullName>
        <actions>
            <name>DeadProjectAlert</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>AcctSeed__Project__c.Overall_Project_Status__c</field>
            <operation>equals</operation>
            <value>Dead</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>z%2E Job Number Change</fullName>
        <actions>
            <name>JobNumberChange</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>PRIORVALUE( Job_Number__c )  &lt;&gt;  Job_Number__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
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
        <fullName>ProjectSetforWebsite</fullName>
        <assignedTo>sysuser@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Please put this project online.</description>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Project Set  for Website</subject>
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
        <fullName>RebateAbouttoExpire2</fullName>
        <assignedTo>sysuser@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>The rebate on this project is about to expire. Please contact the PD.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Rebate About to Expire</subject>
    </tasks>
    <tasks>
        <fullName>RebateAbouttoExpireNorthernCA</fullName>
        <assignedTo>sysuser@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>The rebate on this project is about to expire. Please contact the EC.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Rebate About to Expire - Northern CA</subject>
    </tasks>
    <tasks>
        <fullName>RebateVerifiedRequestPayment</fullName>
        <assignedTo>sysuser@borregosolar.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>The rebate for this project has been verified. Please request Rebate Payment.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Rebate Verified - Request Payment</subject>
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
