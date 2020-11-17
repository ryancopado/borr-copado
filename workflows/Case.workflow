<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_to_Owner_No_solution_in_progress</fullName>
        <description>Alert to Owner- No solution in progress</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Case_Alert_Owner</template>
    </alerts>
    <alerts>
        <fullName>CEO_Notification_Case_Open</fullName>
        <description>CEO Notification- Case Open</description>
        <protected>false</protected>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/CEO_Notification_48_Hours</template>
    </alerts>
    <alerts>
        <fullName>CEO_Open_Case_120_Hour_Notification</fullName>
        <description>CEO Open Case 120 Hour Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>mike@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Case_Alert_Mike</template>
    </alerts>
    <alerts>
        <fullName>Case_Alert_no_solution_in_progress_Brendan</fullName>
        <description>Case Alert- no solution in progress Brendan</description>
        <protected>false</protected>
        <recipients>
            <recipient>bneagle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Case_Alert_Brendan</template>
    </alerts>
    <alerts>
        <fullName>Case_Assignment_Alert</fullName>
        <description>Case Assignment Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Case_Assignment</template>
    </alerts>
    <alerts>
        <fullName>Case_Expected_Days_on_Hold_has_been_Reached</fullName>
        <description>Case Expected Days on Hold has been Reached</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Case_Expected_Days_on_Hold_has_been_reached</template>
    </alerts>
    <alerts>
        <fullName>CheckforReimbursementDue</fullName>
        <description>Check for Reimbursement Due</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PotentialReimbursementforSystemDown</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Case_Owner_when_NO_Case_Comment_is_posted_24_hours_after_creation</fullName>
        <description>Email Alert to Case Owner when NO Case Comment is posted 24 hours after open</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/No_Case_Comment_1st_24_hours</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_O_M_Coordinator_when_Maintenanc_Case_is_completed</fullName>
        <description>Email Alert to O&amp;M Coordinator when Maintenanc Case is completed</description>
        <protected>false</protected>
        <recipients>
            <recipient>kgiannasca@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Maintenance_Case_Complete</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_SPG_group_that_Case_is_closed_and_DAS_alerts_have_been_suspended</fullName>
        <description>Email Alert to SPG group that Case is closed and DAS alerts have been suspended</description>
        <protected>false</protected>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/DAS_Alerts_Suspended</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_no_case_comment_on_high_priority_reactive_open_case</fullName>
        <description>Email alert no case comment on high priority reactive open case</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/No_Case_Comment_1st_24_hours_High_Priority</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_no_case_comment_on_non_reactive_cases_and_7_business_days_have_passe</fullName>
        <description>Email alert no case comment on non-reactive cases and 7 business days have passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorOperationsandMaintenance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Vice_President_O_M</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/No_Case_Comment_7_Days_Non_Reactive_Case</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_to_Case_Owner_that_a_reactive_case_has_no_comment_after_24_hours</fullName>
        <description>Email alert to Case Owner that a reactive case has no comment after 24 hours</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/No_Case_Comment_1st_24_hours</template>
    </alerts>
    <alerts>
        <fullName>Email_notifcation_of_closed_case_with_DAS_component</fullName>
        <description>Email notifcation of closed case with DAS component</description>
        <protected>false</protected>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Case_Closed_Component_DAS_Notification</template>
    </alerts>
    <alerts>
        <fullName>Emergency_Priority_Case_1st_48_Hours_no_resolution</fullName>
        <description>Emergency Priority Case - 1st 48 Hours no resolution</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Emergency_Priority_Not_Closed_1st_48_Hours</template>
    </alerts>
    <alerts>
        <fullName>High_Priority_Case_Alert_BOS_Component_250_500K_Size_48_hours_passed</fullName>
        <description>High Priority Case Alert BOS Component, 250-500K Size, 48 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/High_Priority_Not_Closed_48_Hours</template>
    </alerts>
    <alerts>
        <fullName>High_Priority_Case_Alert_BOS_Component_500_kw_36_hours_passed</fullName>
        <description>High Priority Case Alert BOS Component, 500+ kw, 36 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/High_Priority_Not_Closed_36_Hours</template>
    </alerts>
    <alerts>
        <fullName>High_Priority_Case_Alert_BOS_Component_less_than_250_kw_72_hours_passed</fullName>
        <description>High Priority Case Alert BOS Component, less than 250 kw, 72 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/High_Priority_Not_Closed_72_Hours</template>
    </alerts>
    <alerts>
        <fullName>High_Priority_Case_Alert_DAS_Component_0_250kw_Size_72_hours_passed</fullName>
        <description>High Priority Case Alert DAS Component, 0-250kw Size, 72 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/High_Priority_Not_Closed_72_Hours</template>
    </alerts>
    <alerts>
        <fullName>High_Priority_Case_Alert_DAS_Component_250_500K_Size_48_hours_passed</fullName>
        <description>High Priority Case Alert DAS Component, 250-500K Size, 48 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/High_Priority_Not_Closed_48_Hours</template>
    </alerts>
    <alerts>
        <fullName>High_Priority_Case_Alert_DAS_Component_500kw_Size_36_hours_passed</fullName>
        <description>High Priority Case Alert DAS Component, 500kw Size, 36 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/High_Priority_Not_Closed_36_Hours</template>
    </alerts>
    <alerts>
        <fullName>High_Priority_Case_Alert_ROOF_Component_24_hours_passed</fullName>
        <description>High Priority Case Alert ROOF Component, 24 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/High_Priority_Not_Closed_24_Hours</template>
    </alerts>
    <alerts>
        <fullName>High_Priority_Case_Alert_SwitchGear_Inverters_less_than_250_kw_72_hours_passed</fullName>
        <description>High Priority Case Alert SwitchGear/Inverters, less than 250 kw, 72 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/High_Priority_Not_Closed_72_Hours</template>
    </alerts>
    <alerts>
        <fullName>High_Priority_Case_Alert_Switchgear_Inverter_Component_250_Kw_48_hours_passed</fullName>
        <description>High Priority Case Alert Switchgear/Inverter Component, 250+ Kw, 48 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/High_Priority_Not_Closed_48_Hours</template>
    </alerts>
    <alerts>
        <fullName>Medium_Priority_Case_Inverter_10_days_250_kw_all_other_components</fullName>
        <description>Medium Priority Case Inverter, 10 days, less than 250+kw, all other components</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Medium_Priority_Not_Closed_10_Days</template>
    </alerts>
    <alerts>
        <fullName>Medium_Priority_Case_Inverter_5_days_250_kw</fullName>
        <description>Medium Priority Case Inverter, 5 days, 250+kw</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Medium_Priority_Not_Closed_5_Days</template>
    </alerts>
    <alerts>
        <fullName>Medium_Priority_Case_Inverter_5_days_250_kw_all_other_components</fullName>
        <description>Medium Priority Case Inverter, 5 days, 250+kw, all other components</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Medium_Priority_Not_Closed_5_Days</template>
    </alerts>
    <alerts>
        <fullName>Medium_Priority_Case_Inverter_7_days_less_than_250kw</fullName>
        <description>Medium Priority Case Inverter, 7 days, less than 250kw</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Medium_Priority_Not_Closed_7_Days</template>
    </alerts>
    <alerts>
        <fullName>Medium_Priority_Case_Inverter_Component_48_hours_passed</fullName>
        <description>Medium Priority Case Inverter Component 48 hours passed</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Medium_Priority_Not_Closed_48_Hours</template>
    </alerts>
    <alerts>
        <fullName>Medium_Priority_Case_Roof_96_Hours_Still_Open</fullName>
        <description>Medium Priority Case - Roof - 96 Hours Still Open</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmurphy@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>trobicheau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Medium_Priority_Not_Closed_4_Days</template>
    </alerts>
    <alerts>
        <fullName>Notify_Boston_Portal_Case_My_Systems_Not_Working</fullName>
        <description>Notify Boston Portal Case My Systems Not Working</description>
        <protected>false</protected>
        <recipients>
            <recipient>kcrowley@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tsunderland@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_Tommy_Portal_Case_My_Systems_Not_Working</template>
    </alerts>
    <alerts>
        <fullName>Notify_NorCal_Portal_Case_My_Systems_Not_Working</fullName>
        <description>Notify NorCal Portal Case My Systems Not Working</description>
        <protected>false</protected>
        <recipients>
            <recipient>gbuchanan@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lpollinger@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tsunderland@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_Tommy_Portal_Case_My_Systems_Not_Working</template>
    </alerts>
    <alerts>
        <fullName>Notify_SoCal_Portal_Case_My_Systems_Not_Working</fullName>
        <description>Notify SoCal Portal Case My Systems Not Working</description>
        <protected>false</protected>
        <recipients>
            <recipient>dmarks@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tsunderland@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_Tommy_Portal_Case_My_Systems_Not_Working</template>
    </alerts>
    <alerts>
        <fullName>Notify_Tommy_Portal_Case_General_Inquiries_Feedback</fullName>
        <description>Notify Tommy Portal Case General Inquiries/Feedback</description>
        <protected>false</protected>
        <recipients>
            <recipient>jthorpe@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Notify_Tommy_Portal_Case</template>
    </alerts>
    <alerts>
        <fullName>Notify_Tommy_Portal_Case_My_Systems_Not_Working</fullName>
        <description>Notify Tommy Portal Case My Systems Not Working</description>
        <protected>false</protected>
        <recipients>
            <recipient>jthorpe@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_Tommy_Portal_Case_My_Systems_Not_Working</template>
    </alerts>
    <alerts>
        <fullName>O_M_Admin_Case_Complete_Notification_to_Requestor</fullName>
        <description>O&amp;M Admin Case Complete Notification to Requestor</description>
        <protected>false</protected>
        <recipients>
            <field>Requested_By__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/O_M_Admin_Case_Complete_Notification</template>
    </alerts>
    <alerts>
        <fullName>O_M_Admin_Case_Needs_more_Information</fullName>
        <description>O&amp;M Admin Case Needs more Information</description>
        <protected>false</protected>
        <recipients>
            <field>Requested_By__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/O_M_Admin_Case_Needs_More_Information</template>
    </alerts>
    <alerts>
        <fullName>Portal_Case_Closed</fullName>
        <description>Portal Case Closed</description>
        <protected>false</protected>
        <recipients>
            <field>Notifications_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Customer_Satisfaction/Portal_Case_Closed</template>
    </alerts>
    <alerts>
        <fullName>Portal_Case_Created_Made_Visible</fullName>
        <description>Portal Case Created/Made Visible</description>
        <protected>false</protected>
        <recipients>
            <field>Notifications_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Customer_Satisfaction/Portal_Case_Created</template>
    </alerts>
    <alerts>
        <fullName>Portal_Case_New_Public_Comment</fullName>
        <description>Portal Case New Public Comment</description>
        <protected>false</protected>
        <recipients>
            <field>Notifications_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Customer_Satisfaction/Portal_Case_New_Public_Comment</template>
    </alerts>
    <alerts>
        <fullName>Portal_Case_Solution_in_Progress</fullName>
        <description>Portal Case Solution in Progress</description>
        <protected>false</protected>
        <recipients>
            <field>Notifications_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Customer_Satisfaction/Portal_Case_Solution_in_Progress</template>
    </alerts>
    <alerts>
        <fullName>RemindertofileManufacturerServiceRebate</fullName>
        <description>Reminder to file Manufacturer Service Rebate</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SupportEmails/SendManufacturerServiceRebate</template>
    </alerts>
    <alerts>
        <fullName>SFDC_TEST</fullName>
        <ccEmails>jvilchez@salesforce.com</ccEmails>
        <description>SFDC TEST</description>
        <protected>false</protected>
        <recipients>
            <recipient>pryder@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Medium_Priority_Not_Closed_10_Days</template>
    </alerts>
    <alerts>
        <fullName>Service_Case_has_been_Closed</fullName>
        <description>Service Case has been Closed</description>
        <protected>false</protected>
        <recipients>
            <recipient>treas@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Case_Email_Alerts/Service_Case_Closed_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Auto_Pop_Subject</fullName>
        <field>Subject</field>
        <formula>Project__r.Name + &quot;: &quot; +  RecordType.Name</formula>
        <name>Auto Pop Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_pop_Description</fullName>
        <field>Description</field>
        <formula>Project__r.Name + &quot;: &quot; + RecordType.Name</formula>
        <name>Auto pop Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CY_Landscaping</fullName>
        <field>CY_Landscaping__c</field>
        <formula>1</formula>
        <name>CY Landscaping</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>CY_ModuleWash</fullName>
        <field>CY_Module_Washing__c</field>
        <formula>1</formula>
        <name>CY ModuleWash</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Cause_Auto_Resolved_Cases</fullName>
        <field>Case_Cause__c</field>
        <literalValue>Auto-Resolved</literalValue>
        <name>Case Cause Auto Resolved Cases</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Cause_False_Alert</fullName>
        <field>Case_Cause__c</field>
        <literalValue>False Alert</literalValue>
        <name>Case Cause  False Alert</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Closed_Status</fullName>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Case Closed Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Comment_Date_Visit_Comment_Date</fullName>
        <field>Latest_Case_Comment_Date__c</field>
        <formula>DATETIMEVALUE(LatestVisitCommentDate__c)</formula>
        <name>Case Comment Date = Visit Comment Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Resolved_in_Subject_Closed_Status</fullName>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Case Resolved in Subject = Closed Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Status_Active_when_modified</fullName>
        <field>Status</field>
        <literalValue>Active</literalValue>
        <name>Case Status Active when modified</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Emergency_Priority_Case_Date_Field_Updat</fullName>
        <field>Emergency_Priority_Date__c</field>
        <formula>TODAY()</formula>
        <name>Emergency Priority Case Date Field Updat</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expected_Hold_Days_Clears</fullName>
        <field>Expected_of_Days_on_Hold__c</field>
        <name>Expected # Hold Days Clears</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>High_Priority_Case_Field_Date_Update</fullName>
        <field>High_Priority_Date__c</field>
        <formula>TODAY()</formula>
        <name>High Priority Case Field Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Hold_Release_Date_Updates_Status</fullName>
        <field>Status</field>
        <literalValue>Active</literalValue>
        <name>Hold Release Date Updates Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Labor_Billing_Billable</fullName>
        <description>updates field Labor Billing to Billable</description>
        <field>Labor_Billing__c</field>
        <literalValue>Billable</literalValue>
        <name>Labor Billing:  Billable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Labor_Billing_Not_Billable</fullName>
        <description>updates field Labor Billing to Not Billable</description>
        <field>Labor_Billing__c</field>
        <literalValue>Not Billable</literalValue>
        <name>Labor Billing:  Not Billable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Low_Priority_Date_Field_Update</fullName>
        <field>Date_Low_Priority__c</field>
        <formula>TODAY()</formula>
        <name>Low Priority Date Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Maintenance_Case_Complete</fullName>
        <description>auto date stamps Date Case Completed when status Completed is selected</description>
        <field>Date_Maintenance_Completed__c</field>
        <formula>TODAY()</formula>
        <name>Maintenance Case Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Maintenance_Case_Report_Sent_Case_Comple</fullName>
        <description>auto updates status to Completed whenever report date sent is updated</description>
        <field>Status</field>
        <literalValue>Completed</literalValue>
        <name>Maintenance Case Report Sent Case Comple</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Medium_Priority_Date_Field_Update</fullName>
        <field>Date_Medium_Priority__c</field>
        <formula>TODAY()</formula>
        <name>Medium Priority Date Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>O_M_Admin_Case_Completed</fullName>
        <field>Admin_Support_Completion_Date__c</field>
        <formula>TODAY()</formula>
        <name>O&amp;M Admin Case Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Portal_Case_New_Public_Comment</fullName>
        <field>NewPublicPortalCaseComment__c</field>
        <literalValue>0</literalValue>
        <name>Portal Case New Public Comment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPG_Cases_Component_Default</fullName>
        <description>upon creation defaults component to NONE</description>
        <field>Component__c</field>
        <literalValue>None</literalValue>
        <name>SPG Cases Component Default</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPG_Cases_Default_Case_Type</fullName>
        <description>defaults upon creation to Project</description>
        <field>O_M_Issue_Tracking__c</field>
        <literalValue>Performance Investigation</literalValue>
        <name>SPG Cases Default Case Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPG_Cases_Reported_Issue_Default</fullName>
        <description>upon creation default reported issue</description>
        <field>Reason</field>
        <literalValue>Performance Investigation</literalValue>
        <name>SPG Cases Reported Issue Default</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SPG_Transfer_to_O_M_Mgr</fullName>
        <field>SPG_Transfer_to_O_M_Mgr__c</field>
        <formula>NOW()</formula>
        <name>SPG Transfer to O&amp;M Mgr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Solution_in_progress</fullName>
        <description>when the case is closed uncheck solution in progress</description>
        <field>Solution_in_Progress__c</field>
        <literalValue>0</literalValue>
        <name>Solution in progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_Date_Most_Recent_Status_Change</fullName>
        <field>Start_Date_of_Most_Recent_Status_Change2__c</field>
        <formula>NOW()</formula>
        <name>Start Date Most Recent Status Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_Date_of_Most_Recent_Hold</fullName>
        <field>Start_Date_of_Most_Recent_Hold__c</field>
        <formula>TODAY()</formula>
        <name>Start Date of Most Recent Hold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_On_Hold_Update</fullName>
        <field>Total_Days_on_Hold__c</field>
        <formula>IF(ISBLANK(Total_Days_on_Hold__c) ,(TODAY() -  Start_Date_of_Most_Recent_Hold__c  ), Total_Days_on_Hold__c + (TODAY() -  Start_Date_of_Most_Recent_Hold__c ))</formula>
        <name>Total Days On Hold Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Deployment_Review_F_Update</fullName>
        <field>Total_Days_on_Deployment_Review__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_Deployment_Review__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c),  Total_Days_on_Deployment_Review__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK(  Total_Days_on_Deployment_Review__c ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ),  Total_Days_on_Deployment_Review__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Deployment Review F Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Escalated_to_Director_FU</fullName>
        <field>Total_Days_on_Escalated_to_Director__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_Escalated_to_Director__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c),  Total_Days_on_Escalated_to_Director__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK(  Total_Days_on_Escalated_to_Director__c  ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ),  Total_Days_on_Escalated_to_Director__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Escalated to Director FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Escalated_to_RM_FU</fullName>
        <field>Total_Days_on_Escalated_to_RM__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_Escalated_to_RM__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c),  Total_Days_on_Escalated_to_RM__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK(  Total_Days_on_Escalated_to_RM__c  ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ),  Total_Days_on_Escalated_to_RM__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Escalated to RM FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Escalated_to_SPG_FU</fullName>
        <field>Total_Days_on_Escalated_to_SPG__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_Escalated_to_SPG__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c),  Total_Days_on_Escalated_to_SPG__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK(  Total_Days_on_Escalated_to_SPG__c  ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ),  Total_Days_on_Escalated_to_SPG__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Escalated to SPG FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Hold_Follow_Up_FU</fullName>
        <field>Total_Days_on_On_Hold_Follow_Up__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_On_Hold_Follow_Up__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c), Total_Days_on_On_Hold_Follow_Up__c +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK( Total_Days_on_On_Hold_Follow_Up__c ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ), Total_Days_on_On_Hold_Follow_Up__c +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Hold Follow Up FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Hold_Parts_FU</fullName>
        <field>Total_Days_On_Hold_Parts__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_On_Hold_Parts__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c), Total_Days_On_Hold_Parts__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK( Total_Days_On_Hold_Parts__c  ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ), Total_Days_On_Hold_Parts__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Hold Parts FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Hold_RMA_FU</fullName>
        <field>Total_Days_on_On_Hold_RMA__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_On_Hold_RMA__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c),  Total_Days_on_On_Hold_RMA__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK(  Total_Days_on_On_Hold_RMA__c  ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ),  Total_Days_on_On_Hold_RMA__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Hold RMA FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Hold_Weather</fullName>
        <field>Total_Days_on_On_Hold_Weather__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_On_Hold_Weather__c ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c), Total_Days_on_On_Hold_Weather__c +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK( Total_Days_on_On_Hold_Weather__c),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ), Total_Days_on_On_Hold_Weather__c +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Hold Weather</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Inventory_Fulfillment_FU</fullName>
        <field>Total_Days_on_Inventory_Fulfillment__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_Inventory_Fulfillment__c ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c), Total_Days_on_Inventory_Fulfillment__c +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK( Total_Days_on_Inventory_Fulfillment__c ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ), Total_Days_on_Inventory_Fulfillment__c +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Inventory Fulfillment FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_New_Case_Status_FU</fullName>
        <field>Total_Days_on_New_Case_Status__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_New_Case_Status__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c), Total_Days_on_New_Case_Status__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK( Total_Days_on_New_Case_Status__c  ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ), Total_Days_on_New_Case_Status__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on New Case Status FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_ON_Hold_Customer_FU</fullName>
        <field>Total_Days_on_On_hold_customer__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_On_hold_customer__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c),  Total_Days_on_On_hold_customer__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK(  Total_Days_on_On_hold_customer__c  ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ),  Total_Days_on_On_hold_customer__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on ON Hold - Customer FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Ops_Review_Field_Update</fullName>
        <field>Total_Days_on_Ops_Review__c</field>
        <formula>/*IF(ISBLANK(   Total_Days_on_Ops_Review__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c),  Total_Days_on_Ops_Review__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK( Total_Days_on_Ops_Review__c ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ),  Total_Days_on_Ops_Review__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Ops Review Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Pending_Quote_FU</fullName>
        <field>Total_Days_on_Pending_Quote__c</field>
        <formula>/*IF(ISBLANK( Total_Days_on_Pending_Quote__c ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c), Total_Days_on_Pending_Quote__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK( Total_Days_on_Pending_Quote__c  ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ), Total_Days_on_Pending_Quote__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Pending Quote FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Ready_to_Schedule_FU</fullName>
        <field>Total_Days_on_Ready_to_Schedule__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_Ready_to_Schedule__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c), Total_Days_on_Ready_to_Schedule__c  +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK( Total_Days_on_Ready_to_Schedule__c ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ), Total_Days_on_Ready_to_Schedule__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Ready to Schedule FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_on_Subcontracted_FU</fullName>
        <field>Total_Days_on_Subcontracted__c</field>
        <formula>/*IF(ISBLANK( Total_Days_on_Subcontracted__c ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c), Total_Days_on_Subcontracted__c +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK( Total_Days_on_Subcontracted__c),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ), Total_Days_on_Subcontracted__c +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total Days on Subcontracted FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_days_on_Scheduled</fullName>
        <field>Total_Days_on_Scheduled__c</field>
        <formula>/*IF(ISBLANK(  Total_Days_on_Scheduled__c  ),(NOW()- Start_Date_of_Most_Recent_Status_Change2__c),  Total_Days_on_Scheduled__c +(NOW()-Start_Date_of_Most_Recent_Status_Change2__c))*/


IF(ISBLANK(  Total_Days_on_Scheduled__c  ),(NOW()- PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c) ),  Total_Days_on_Scheduled__c  +(NOW()-PRIORVALUE(Start_Date_of_Most_Recent_Status_Change2__c)))</formula>
        <name>Total days on Scheduled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Branch_East_Coast</fullName>
        <field>Branch__c</field>
        <literalValue>Boston</literalValue>
        <name>Update Branch - East Coast</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Branch_NorCal</fullName>
        <field>Branch__c</field>
        <literalValue>Berkeley</literalValue>
        <name>Update Branch - NorCal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Branch_SoCal</fullName>
        <field>Branch__c</field>
        <literalValue>San Diego</literalValue>
        <name>Update Branch - SoCal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Ownerid_adamico</fullName>
        <field>OwnerId</field>
        <lookupValue>gbuchanan@borregosolar.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Update Ownerid adamico</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Ownerid_mmurphy</fullName>
        <field>OwnerId</field>
        <lookupValue>kcrowley@borregosolar.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Update Ownerid mmurphy</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Admin Case Complete</fullName>
        <actions>
            <name>O_M_Admin_Case_Complete_Notification_to_Requestor</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>O_M_Admin_Case_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>O&amp;M Admin Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>auto date stamps when status of completed is selected on Admin Cases</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Assign Owner adamico</fullName>
        <actions>
            <name>Update_Ownerid_adamico</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.isPortalCase__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.MailID__c</field>
            <operation>contains</operation>
            <value>gbuchanan</value>
        </criteriaItems>
        <description>temporarily assigned to Gary B</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assign Owner dmarks</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.isPortalCase__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.MailID__c</field>
            <operation>contains</operation>
            <value>dmarks</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Auto Complete Maintenance Case</fullName>
        <actions>
            <name>Maintenance_Case_Report_Sent_Case_Comple</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>auto update status to Comleted whenever date of report sent out is updated</description>
        <formula>AND(
RecordType.Id = &quot;012340000007kUM&quot;, ISCHANGED ( Date_Most_Recent_Email__c  )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Auto Update Status to Active</fullName>
        <actions>
            <name>Case_Status_Active_when_modified</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>auto updates status to active upon initial edits to an existing case</description>
        <formula>AND(  
ISPICKVAL(Status, &quot;New&quot;), 
NOT(ISPICKVAL( Component__c, &quot;&quot;)),
NOT(ISBLANK(Account.Name)), 
NOT(CONTAINS(Subject, &quot;Resolved&quot;)),  
RecordTypeId = &quot;012340000007kUH&quot;  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CY Landscaping</fullName>
        <actions>
            <name>CY_Landscaping</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( RecordTypeId = &quot;01234000000BnNj&quot;, ISPICKVAL(Status, &quot;Closed&quot;),  DATEVALUE(ClosedDate) &gt;=  ServiceContract_Case__r.Current_Year_Contract_Start__c,  DATEVALUE(ClosedDate) &lt;  ServiceContract_Case__r.Current_Year_Contract_End__c  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CY ModuleWash</fullName>
        <actions>
            <name>CY_ModuleWash</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( RecordTypeId = &quot;01234000000BnNk&quot;, ISPICKVAL(Status, &quot;Closed&quot;),  DATEVALUE(ClosedDate) &gt;=  ServiceContract_Case__r.Current_Year_Contract_Start__c,  DATEVALUE(ClosedDate) &lt;  ServiceContract_Case__r.Current_Year_Contract_End__c  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case Cause - False Alert</fullName>
        <actions>
            <name>Case_Closed_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Case_Cause__c</field>
            <operation>equals</operation>
            <value>False Alert - Duplicate,False Alert - Shade,False Alert - No Action Required,False Alert - Non-managed Site,False Alert - Other,False Alert - Planned Site Activity</value>
        </criteriaItems>
        <description>when one of the false alerts are used dto identify the cause the case is auto closed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case Cause Auto Resolved Cases</fullName>
        <actions>
            <name>Case_Cause_Auto_Resolved_Cases</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed - Issue Resolved Automatically</value>
        </criteriaItems>
        <description>auto populates Case Cause with value of Auto-Resolved anytime a Case is closed with Status = Issue Resolved Automatically</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case Closed Component %3D DAS  Notification</fullName>
        <actions>
            <name>Email_notifcation_of_closed_case_with_DAS_component</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>DAS</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case Closed DAS Alerts</fullName>
        <actions>
            <name>Email_Alert_to_SPG_group_that_Case_is_closed_and_DAS_alerts_have_been_suspended</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.DAS_Alerts_Suspended__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>email to SPG group to tnotfiy them to restore proper Alert settings.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case Comment %3D Visit Comment</fullName>
        <actions>
            <name>Case_Comment_Date_Visit_Comment_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>temp WF to make these two fields match until auto closure email to case code can be updated.</description>
        <formula>ISCHANGED( LatestVisitCommentDate__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Case Creation auto pop descript %26 subject</fullName>
        <actions>
            <name>Auto_Pop_Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Auto_pop_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Case.CaseNumber</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>,Module Washing,Preoperational Commissioning,Construction Closeout,Reactive - Borrego Warranty,Operational Commissioning,Landscaping,Additional Services,Project,Maintenance Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.SuppliedName</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.SuppliedEmail</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subject</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Description</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>upon creation of a Case auto update subject, description with project name + case record type</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Case Emergency Priority Date Field Update</fullName>
        <actions>
            <name>Emergency_Priority_Case_Date_Field_Updat</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Emergency</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case High Priority Date Field Update</fullName>
        <actions>
            <name>High_Priority_Case_Field_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case Low Priority Date Field Update</fullName>
        <actions>
            <name>Low_Priority_Date_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Low</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case Medium Priority Date Field Update</fullName>
        <actions>
            <name>Medium_Priority_Date_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Medium</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case On Hold Expected Days Reached 2</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>On Hold,On Hold - ENG/SPG Review,On Hold - RMA,On Hold - Waiting for Parts,On Hold - Weather Advisory</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Case_Expected_Days_on_Hold_has_been_Reached</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Expected_Hold_Days_Clears</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Hold_Release_Date_Updates_Status</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.Expected_Hold_Release_Date__c</offsetFromField>
            <timeLength>12</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Case Open 120 hours - 2</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed,Closed - Issue Resolved Automatically</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>O&amp;M Admin Support</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>CEO_Open_Case_120_Hour_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.CreatedDate</offsetFromField>
            <timeLength>120</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Case Resolved in Subject %3D Closed Status</fullName>
        <actions>
            <name>Case_Resolved_in_Subject_Closed_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2) OR (3 AND 4)</booleanFilter>
        <criteriaItems>
            <field>Case.Subject</field>
            <operation>contains</operation>
            <value>Resolved,Reminder</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.SuppliedEmail</field>
            <operation>equals</operation>
            <value>powertrack@alsoenergy.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Subject</field>
            <operation>contains</operation>
            <value>Ended</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.SuppliedEmail</field>
            <operation>equals</operation>
            <value>support@auroravision.net</value>
        </criteriaItems>
        <description>automatically sets Status to Closed if Resolved is in the Subject</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Case Total Days on Hold</fullName>
        <actions>
            <name>Total_Days_On_Hold_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>workflow that calculates a cumulative days on hold based on On Hold Status and value from Days on Hold</description>
        <formula>AND(   
ISCHANGED(Status),    
OR( ISPICKVAL(PRIORVALUE(Status), &quot;On Hold&quot;),  ISPICKVAL(PRIORVALUE(Status), &quot;On Hold - ENG/SPG Review&quot;) , ISPICKVAL(PRIORVALUE(Status), &quot;On Hold - RMA&quot;) , ISPICKVAL(PRIORVALUE(Status), &quot;On Hold - Waiting for Parts&quot;), ISPICKVAL(PRIORVALUE(Status), &quot;On Hold - Weather Advisory&quot;) ), 

    OR( NOT(ISPICKVAL(Status, &quot;On Hold&quot;)), NOT(ISPICKVAL(Status, &quot;On Hold - ENG/SPG Review&quot;)), NOT(ISPICKVAL(Status, &quot;On Hold - RMA&quot;)), NOT(ISPICKVAL(Status, &quot;On Hold - Waiting for Parts&quot;)), NOT(ISPICKVAL(Status, &quot;On Hold - Weather Advisory&quot;)) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Emergency Priority - Not Closed 1st 48 Hours</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Emergency</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <description>email alert to O &amp; M Director that a case with Emergency Priority has not yet be resolved and 48 hours has passed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Emergency_Priority_Case_1st_48_Hours_no_resolution</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Emergency_Priority_Date__c</offsetFromField>
            <timeLength>48</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>High Priority Case - Roof - 24 Hours</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>Roof</value>
        </criteriaItems>
        <description>email notification on a High priority case that is still open after 24  hours and has roof as a  component</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>High_Priority_Case_Alert_ROOF_Component_24_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.High_Priority_Date__c</offsetFromField>
            <timeLength>24</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>High Priority Case BOS  %3E 500kw - 36 Hours</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterOrEqual</operation>
            <value>500000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>notEqual</operation>
            <value>Inverter,Roof,DAS,Switch Gear</value>
        </criteriaItems>
        <description>email notification on a BOS High priority case that is greater than 500 kw that its still open after 36 hours</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>High_Priority_Case_Alert_BOS_Component_500_kw_36_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.High_Priority_Date__c</offsetFromField>
            <timeLength>36</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>High Priority Case BOS 0 - 250K - 72 Hours</fullName>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>notEqual</operation>
            <value>DAS,Inverter,Roof,Switch Gear</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>lessThan</operation>
            <value>250000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>email notification on a BOS High priority case that is blank or up to 20K in size that its still open after 72  hours</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>High_Priority_Case_Alert_BOS_Component_less_than_250_kw_72_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.High_Priority_Date__c</offsetFromField>
            <timeLength>72</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>High Priority Case BOS 250 - 499k - 48 Hours</fullName>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterOrEqual</operation>
            <value>250000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>lessThan</operation>
            <value>500000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>notEqual</operation>
            <value>DAS,Inverter,Roof,Switch Gear</value>
        </criteriaItems>
        <description>email notification on a BOS High priority case that is 250 - 499k that its still open after 48  hours</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>High_Priority_Case_Alert_BOS_Component_250_500K_Size_48_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.High_Priority_Date__c</offsetFromField>
            <timeLength>48</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>High Priority Case DAS %3E 500kw - 36 Hours</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterOrEqual</operation>
            <value>500000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>DAS</value>
        </criteriaItems>
        <description>email notification on a DAS High priority case that is greater than 500 kw that its still open after 36 hours</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>High_Priority_Case_Alert_DAS_Component_500kw_Size_36_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.High_Priority_Date__c</offsetFromField>
            <timeLength>36</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>High Priority Case DAS 0 - 250K - 72 Hours</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>DAS</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>lessThan</operation>
            <value>250000</value>
        </criteriaItems>
        <description>email notification on a DAS High priority case that is blank or up to 20K in size that its still open after 72  hours</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>High_Priority_Case_Alert_DAS_Component_0_250kw_Size_72_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.High_Priority_Date__c</offsetFromField>
            <timeLength>72</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>High Priority Case DAS 250 - 499k - 48 Hours</fullName>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterOrEqual</operation>
            <value>250000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>lessThan</operation>
            <value>500000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>DAS</value>
        </criteriaItems>
        <description>email notification on a DAS High priority case that is 250 - 499k that its still open after 48  hours</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>High_Priority_Case_Alert_DAS_Component_250_500K_Size_48_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.High_Priority_Date__c</offsetFromField>
            <timeLength>48</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>High Priority Case Switchgear%2FInverters 250%2B kw -  48 Hours</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterOrEqual</operation>
            <value>250000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>Inverter,Switch Gear</value>
        </criteriaItems>
        <description>email notification on a High priority case that is 250+ that its still open after 48  hours and has switchgear or inverter components</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>High_Priority_Case_Alert_Switchgear_Inverter_Component_250_Kw_48_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.High_Priority_Date__c</offsetFromField>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>High Priority Case Switchgear%2FInverters Less than 250kw -  72 Hours</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>lessThan</operation>
            <value>250000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>Inverter,Switch Gear</value>
        </criteriaItems>
        <description>email notification on a High priority case that is less than 250 kw that its still open after 72  hours and has switchgear or inverter components</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>High_Priority_Case_Alert_SwitchGear_Inverters_less_than_250_kw_72_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.High_Priority_Date__c</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Labor Billing%3A Landscaping Exceeds Count</fullName>
        <actions>
            <name>Labor_Billing_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates Labor Billing field if Landscaping visit count is above contract allotment for free or prepaid visits</description>
        <formula>AND(   RecordTypeId  = &quot;01234000000BnNj&quot;,  ServiceContract_Case__r.CY_Completed_Landscaping_Visits__c  &gt;   ServiceContract_Case__r.Landscaping_Visits_Number__c ,  ISPICKVAL( Status , &quot;Closed&quot;)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing%3A Not Billable Landscaping Is Below Count</fullName>
        <actions>
            <name>Labor_Billing_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates Labor Billing field if Landscaping visit count is below contract allotment for free or prepaid visits</description>
        <formula>AND(   RecordTypeId  = &quot;01234000000BnNj&quot;,   NOT(ISPICKVAL(ServiceContract_Case__r.Landscaping_Visits_per_Year__c, &quot;OnCall Billable&quot;)),   ServiceContract_Case__r.CY_Completed_Landscaping_Visits__c  &lt;=  ServiceContract_Case__r.Landscaping_Visits_Number__c ,  ISPICKVAL( Status , &quot;Closed&quot;)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing%3A Not Billable Not Billable Landscaping As Needed</fullName>
        <actions>
            <name>Labor_Billing_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates Labor Billing field if Landscaping visit count is below contract allotment for free or prepaid visits</description>
        <formula>AND(   RecordTypeId  = &quot;0124C000000LBFJ&quot;,   ServiceContract_Case__r.Landscaping_Visits_Number__c = 9999,  ISPICKVAL( Status , &quot;Closed&quot;)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing%3A Not Billable Washing As Needed</fullName>
        <actions>
            <name>Labor_Billing_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates Labor Billing field if Washing visit count is below contract allotment for free or prepaid visits</description>
        <formula>AND(   RecordTypeId  = &quot;0124C000000LAsA&quot;,    ServiceContract_Case__r.Module_Washings_Number__c  = 9999,  ISPICKVAL( Status , &quot;Closed&quot;)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing%3A Not Billable Washing Is Below Count</fullName>
        <actions>
            <name>Labor_Billing_Not_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates Labor Billing field if Washing visit count is below contract allotment for free or prepaid visits</description>
        <formula>AND(   RecordTypeId  = &quot;0124C000000LAsA&quot;,   NOT(ISPICKVAL( ServiceContract_Case__r.Modules_Washings_per_Year__c , &quot;OnCall Billable&quot;)),    ServiceContract_Case__r.CY_Completed_Module_Wash_Visits__c   &lt;=   ServiceContract_Case__r.Module_Washings_Number__c   ,  ISPICKVAL( Status , &quot;Closed&quot;)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing%3A OnCall Billable Landscaping Visit</fullName>
        <actions>
            <name>Labor_Billing_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates Labor Billing field if Landscaping visit is on call billable, always billable</description>
        <formula>AND(   RecordTypeId  = &quot;0124C000000LBFJ&quot;,   ISPICKVAL(ServiceContract_Case__r.Landscaping_Visits_per_Year__c, &quot;OnCall Billable&quot;),   ISPICKVAL( Status , &quot;Closed&quot;)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing%3A OnCall Billable Washing Visit</fullName>
        <actions>
            <name>Labor_Billing_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates Labor Billing field if Washing visit is on call billable, always billable</description>
        <formula>AND(   RecordTypeId  = &quot;0124C000000LAsA&quot;,   ISPICKVAL( ServiceContract_Case__r.Modules_Washings_per_Year__c , &quot;OnCall Billable&quot;),   ISPICKVAL( Status , &quot;Closed&quot;)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Labor Billing%3A Washing Exceeds Count</fullName>
        <actions>
            <name>Labor_Billing_Billable</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>updates Labor Billing field if Washing visit count is above contract allotment for free or prepaid visits</description>
        <formula>AND(   RecordTypeId  = &quot;0124C000000LAsA&quot;,   ServiceContract_Case__r.CY_Completed_Module_Wash_Visits__c   &gt;    ServiceContract_Case__r.Module_Washings_Number__c  ,  ISPICKVAL( Status , &quot;Closed&quot;)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Maintenance Case Complete</fullName>
        <actions>
            <name>Maintenance_Case_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Maintenance Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>auto date stamps when status of completed is selected on Maintenance Cases</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Medium Priority Case - 250%2B kw - 5 days - All Other Components</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Medium</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>Module,Racking,Electrical,DAS,Other,Tracker,Transformer</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterOrEqual</operation>
            <value>250000</value>
        </criteriaItems>
        <description>email notification on a medium priority case that is still open after 5 days and all other components are listed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Medium_Priority_Case_Inverter_5_days_250_kw_all_other_components</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Date_Medium_Priority__c</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Medium Priority Case - Roof - Open 4 Days</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Medium</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>Roof</value>
        </criteriaItems>
        <description>email notification on a medium priority case that is still open after 96 Hours/4 days - Roof Component</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Medium_Priority_Case_Roof_96_Hours_Still_Open</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Date_Medium_Priority__c</offsetFromField>
            <timeLength>4</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Medium Priority Case - less than 250%2B kw - 10 days - All Other Components</fullName>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Medium</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>notEqual</operation>
            <value>Inverter,Roof,Switch Gear</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>lessThan</operation>
            <value>250000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>email notification on a medium priority case that is still open after 10 days and all other components are listed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Medium_Priority_Case_Inverter_10_days_250_kw_all_other_components</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Date_Medium_Priority__c</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Medium Priority Case Inverter - 250%2B kw - 5 days</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Medium</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>Inverter</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterOrEqual</operation>
            <value>250000</value>
        </criteriaItems>
        <description>email notification on a medium priority case that is still open after 5 days and has inverter components</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Medium_Priority_Case_Inverter_5_days_250_kw</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Date_Medium_Priority__c</offsetFromField>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Medium Priority Case Inverter - less than 250 kw - 7 days</fullName>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Medium</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>Inverter</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>lessThan</operation>
            <value>250000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Current_Project_System_Size__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>email notification on a medium priority case that is still open after 7 days and has inverter components</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Medium_Priority_Case_Inverter_7_days_less_than_250kw</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Date_Medium_Priority__c</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Medium Priority Case Switchgear - 48 Hours</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Medium</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Component__c</field>
            <operation>equals</operation>
            <value>Switch Gear</value>
        </criteriaItems>
        <description>email notification on a medium priority case that is still open after 48  hours and has switchgear components</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Medium_Priority_Case_Inverter_Component_48_hours_passed</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Date_Medium_Priority__c</offsetFromField>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Most Recent Status Change</fullName>
        <actions>
            <name>Start_Date_Most_Recent_Status_Change</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the field Most Recent Status Change</description>
        <formula>OR(ISNEW(),ISCHANGED(Status))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>No Case Comment - Case Owner Notification</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.O_M_Issue_Tracking__c</field>
            <operation>equals</operation>
            <value>Reactive</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Latest_Case_Comment_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>If case is open reactive and no case comment after 24 hours from opening, email goes to Case Owner</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_alert_to_Case_Owner_that_a_reactive_case_has_no_comment_after_24_hours</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.CreatedDate</offsetFromField>
            <timeLength>24</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>No Case Comment - High Priority Reactive</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.O_M_Issue_Tracking__c</field>
            <operation>equals</operation>
            <value>Reactive</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Latest_Case_Comment_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <description>If case is open, and high prioirty reactive with no case comment after 24 hours from opening, email goes to Matt Murphy</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_alert_no_case_comment_on_high_priority_reactive_open_case</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Date_1_Business_Day_From_Open_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>No Case Comment - Low Priority Reactive</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.O_M_Issue_Tracking__c</field>
            <operation>equals</operation>
            <value>Reactive</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Latest_Case_Comment_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Low</value>
        </criteriaItems>
        <description>If case is open, and low prioirty reactive with no case comment after 7 business days from opening, email goes to Matt Murphy</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Case.Date_7_Business_Days_From_Open_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>No Case Comment - Medium Priority Reactive</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.O_M_Issue_Tracking__c</field>
            <operation>equals</operation>
            <value>Reactive</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Latest_Case_Comment_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Medium</value>
        </criteriaItems>
        <description>If case is open, and medium prioirty reactive with no case comment after 3 business days from opening, email goes to Matt Murphy</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Case.Date_3_Business_Days_From_Open_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>No Case Comment Non-Reactive Case Type</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Case.O_M_Issue_Tracking__c</field>
            <operation>equals</operation>
            <value>Project,Issue Tracking,Construction Closeout,Satcon,Residential,Carport Investigation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Service</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Latest_Case_Comment_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>If case is open, and is of type Project, Issue Tracking, Construction Closeout, Satcon, Residential, Carport Investigation email goes to Matt Murphy after 7 business days from opening</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_alert_no_case_comment_on_non_reactive_cases_and_7_business_days_have_passe</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.Date_7_Business_Days_From_Open_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Notify Boston Portal Case My Systems Not Working</fullName>
        <actions>
            <name>Notify_Boston_Portal_Case_My_Systems_Not_Working</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Portal_Inquiry_Type__c</field>
            <operation>equals</operation>
            <value>My System Is Not Working</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Branch__c</field>
            <operation>equals</operation>
            <value>Mid Atlantic,Boston</value>
        </criteriaItems>
        <description>Notify Boston O&amp;M Contact and Tommy Sunderland</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify Josh Portal Case My Systems Not Working</fullName>
        <actions>
            <name>Notify_Tommy_Portal_Case_My_Systems_Not_Working</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Portal_Inquiry_Type__c</field>
            <operation>equals</operation>
            <value>My System Is Not Working</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify NorCal Portal Case My Systems Not Working</fullName>
        <actions>
            <name>Notify_NorCal_Portal_Case_My_Systems_Not_Working</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Portal_Inquiry_Type__c</field>
            <operation>equals</operation>
            <value>My System Is Not Working</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Branch__c</field>
            <operation>equals</operation>
            <value>Berkeley</value>
        </criteriaItems>
        <description>Notify NorCal O&amp;M Contact and Tommy Sunderland</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify O%26M General Inquiries%2FFeedback</fullName>
        <actions>
            <name>Notify_Tommy_Portal_Case_General_Inquiries_Feedback</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Portal_Inquiry_Type__c</field>
            <operation>equals</operation>
            <value>General Inquiries/Feedback</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify SoCal Portal Case My Systems Not Working</fullName>
        <actions>
            <name>Notify_SoCal_Portal_Case_My_Systems_Not_Working</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Portal_Inquiry_Type__c</field>
            <operation>equals</operation>
            <value>My System Is Not Working</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Branch__c</field>
            <operation>equals</operation>
            <value>San Diego</value>
        </criteriaItems>
        <description>Notify SoCal O&amp;M Contact and Tommy Sunderland</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>O%26M Admin Case More Information Needed</fullName>
        <actions>
            <name>O_M_Admin_Case_Needs_more_Information</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>O&amp;M Admin Support</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>More Info Needed</value>
        </criteriaItems>
        <description>sends email to Requestor with lastest case comment outlining what additional information is needed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Portal Case Closed</fullName>
        <actions>
            <name>Portal_Case_Closed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Send email notification when a portal visible case has been closed.</description>
        <formula>AND(  IsClosed = TRUE,  isPortalCase__c =TRUE,  Notifications_Contact__r.VIP_Contact__c =TRUE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Portal Case Created%2FMade Visible</fullName>
        <actions>
            <name>Portal_Case_Created_Made_Visible</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Workflow evaluates to true if a case was created that is visible in the customer portal.</description>
        <formula>AND(isPortalCase__c =TRUE,  Notifications_Contact__r.VIP_Contact__c =TRUE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Portal Case New Public Comment</fullName>
        <actions>
            <name>Portal_Case_New_Public_Comment</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Portal_Case_New_Public_Comment</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Send email notification when a new public comment has been created/made public.</description>
        <formula>AND( Solution_in_Progress__c =TRUE,  isPortalCase__c =TRUE,  Notifications_Contact__r.VIP_Contact__c =TRUE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Portal Case Solution in Progress</fullName>
        <actions>
            <name>Portal_Case_Solution_in_Progress</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Send email alert when portal case is marked Solution in Progress.</description>
        <formula>AND( Solution_in_Progress__c =TRUE,  isPortalCase__c =TRUE,  Notifications_Contact__r.VIP_Contact__c =TRUE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SPG Cases Creation Defaults</fullName>
        <actions>
            <name>SPG_Cases_Component_Default</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SPG_Cases_Default_Case_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SPG_Cases_Reported_Issue_Default</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>spgcases@borregosolar.com</value>
        </criteriaItems>
        <description>upon creation of a new case certain fields should be set to default values</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>SPG Transfer to O%26M Manager</fullName>
        <actions>
            <name>SPG_Transfer_to_O_M_Mgr</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>auto fills date of transfer</description>
        <formula>AND(  CreatedBy.Profile.Id = &quot;00e80000001OEPb&quot;,  Owner:User.ProfileId = &quot;00e340000018vgR&quot; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Service Case Closed Notification</fullName>
        <actions>
            <name>Service_Case_has_been_Closed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notification to Finance when closed so they know when to processes invoices for billable services</description>
        <formula>AND(ISPICKVAL( Status , &quot;Closed&quot;),
NOT(ISPICKVAL( ServiceContract_Case__r.Type__c , &quot;Warranty&quot;)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Solution in progress</fullName>
        <actions>
            <name>Solution_in_progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>uncheck the solution in progress checkbox if the case is closed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Start Date of Most Recent Hold</fullName>
        <actions>
            <name>Start_Date_of_Most_Recent_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>On Hold,On Hold - ENG/SPG Review,On Hold - RMA,On Hold - Waiting for Parts,On Hold - Weather Advisory</value>
        </criteriaItems>
        <description>auto date stamps date Hold is checked off</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Total Days On Hold - Parts WF</fullName>
        <actions>
            <name>Total_Days_on_Hold_Parts_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field Total Days on Hold - Parts on Case</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;On Hold - Waiting for Parts&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;On Hold - Waiting for Parts&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;On Hold - Waiting for Parts&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on %22On Hold Customer%22 WF</fullName>
        <actions>
            <name>Total_Days_on_ON_Hold_Customer_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field Total Days on hold - customer</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;On Hold - Waiting Customer Response&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;On Hold - Waiting Customer Response&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;On Hold - Waiting Customer Response&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Deployment Review</fullName>
        <actions>
            <name>Total_Days_on_Deployment_Review_F_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Total Days on Deployment Review field</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Deployment Review&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Deployment Review&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Deployment Review&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Escalated to Director</fullName>
        <actions>
            <name>Total_Days_on_Escalated_to_Director_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Escalated to Director&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Escalated to Director&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Escalated to Director&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Escalated to RM WF</fullName>
        <actions>
            <name>Total_Days_on_Escalated_to_RM_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field total days on Escalated to RM</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Escalated to Regional Manager&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Escalated to Regional Manager&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Escalated to Regional Manager&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Escalated to SPG WF</fullName>
        <actions>
            <name>Total_Days_on_Escalated_to_SPG_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field Total Days on Escalated to SPG</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Escalated to SPG&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Escalated to SPG&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Escalated to SPG&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Hold Follow Up</fullName>
        <actions>
            <name>Total_Days_on_Hold_Follow_Up_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field total days on hold follow up</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;ON HOLD Follow Up&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;ON HOLD Follow Up&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;ON HOLD Follow Up&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Hold RMA</fullName>
        <actions>
            <name>Total_Days_on_Hold_RMA_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field total days on hold rma on case</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;On Hold - RMA&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;On Hold - RMA&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;On Hold - RMA&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Inventory Fulfillment WF</fullName>
        <actions>
            <name>Total_Days_on_Inventory_Fulfillment_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates total days on inventory fulfillment field on Case</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Inventory Fulfillment&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Inventory Fulfillment&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Inventory Fulfillment&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on New Case Status WF</fullName>
        <actions>
            <name>Total_Days_on_New_Case_Status_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field Total Days on New Case Status</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;New Case&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;New Case&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;New Case&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Ops Review</fullName>
        <actions>
            <name>Total_Days_on_Ops_Review_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Ops Review&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Ops Review&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Ops Review&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Pending Quote WF</fullName>
        <actions>
            <name>Total_Days_on_Pending_Quote_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field Total Days on Pending Quote on Case</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Pending Quote&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Pending Quote&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Pending Quote&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Ready to Schedule</fullName>
        <actions>
            <name>Total_Days_on_Ready_to_Schedule_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field Total Days on Ready to Schedule</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Ready to Schedule&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Ready to Schedule&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Ready to Schedule&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Scheduled WF</fullName>
        <actions>
            <name>Total_days_on_Scheduled</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field total days on scheduled</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Scheduled&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Scheduled&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Scheduled&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on Subcontracted</fullName>
        <actions>
            <name>Total_Days_on_Subcontracted_FU</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;Subcontracted&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;Subcontracted&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;Subcontracted&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Total Days on hold -weather</fullName>
        <actions>
            <name>Total_Days_on_Hold_Weather</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>updates field total days on hold weather on Case</description>
        <formula>/*AND( ISCHANGED(Status), TEXT(PRIORVALUE(Status)) = &quot;On Hold - Weather Advisory&quot; )  AND( ISCHANGED(Status), ISPICKVAL(PRIORVALUE(Status),&quot;On Hold - Weather Advisory&quot;) )*/  AND( ISCHANGED(Status),   OR(ISPICKVAL(PRIORVALUE(Status),&quot;On Hold - Weather Advisory&quot;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>ReminderSendCheckRequest</fullName>
        <assignedToType>owner</assignedToType>
        <description>Once you have submitted the request, please check off the Check Request Submitted box.</description>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Reminder: Send Check Request</subject>
    </tasks>
</Workflow>
