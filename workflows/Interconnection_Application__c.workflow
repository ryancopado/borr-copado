<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_to_Rob_Tompkins_whenever_HOLD_status_on_Intx_App_is_changed</fullName>
        <description>Alert to Rob Tompkins whenever HOLD status on Intx App is changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Intx_Hold_Status_Change</template>
    </alerts>
    <alerts>
        <fullName>Best_Estimate_Section_modified</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>Best Estimate Section modified</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_of_Grid_Integration</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Sr_Interconnection_Coordinator_West</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>bfoss-michaelis@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jinnes@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jzha@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Best_Estimate_Section_Modified</template>
    </alerts>
    <alerts>
        <fullName>Date_Modified_Changed_Best_Estimate</fullName>
        <description>Date Modified Changed, Best Estimate</description>
        <protected>false</protected>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Date_Modified_Changed_Best_Estimate</template>
    </alerts>
    <alerts>
        <fullName>Detailed_Studay_Underway_Date_Change_Notification</fullName>
        <description>Detailed Studay Underway Date Change Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>eshambeau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Detailed_Study_Underway_Date_has_Changed</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Interconnection_Manager_uppon_Submission_of_New_Intx_App</fullName>
        <description>Email Alert to Interconnection Manager uppon Submission of New Intx App</description>
        <protected>false</protected>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Interconnection_Request</template>
    </alerts>
    <alerts>
        <fullName>Email_to_TS_Customer_Survey</fullName>
        <description>Email to TS- Customer Survey</description>
        <protected>false</protected>
        <recipients>
            <recipient>acain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Received_Customer_Survey_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Interconnection_Application_Expected_Date_Notification</fullName>
        <description>Interconnection Application Expected Date Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>mconway@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pretelle@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Interconnection_Application</template>
    </alerts>
    <alerts>
        <fullName>Interconnection_Application_Request_Complete</fullName>
        <description>Interconnection Application Request Complete</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>cbain@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>eshambeau@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Assigned_Apps_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Interconnection_Request_Approved_2</template>
    </alerts>
    <alerts>
        <fullName>Interconnection_Application_Request_Rejected</fullName>
        <description>Interconnection Application Request Denied</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Assigned_Apps_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Interconnection_Request_Denied</template>
    </alerts>
    <alerts>
        <fullName>Notification_of_PTO_received_EAST</fullName>
        <description>Notification of PTO received EAST</description>
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
            <recipient>MarketingDirector</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
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
            <recipient>swillett@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Received_2</template>
    </alerts>
    <alerts>
        <fullName>Notification_of_PTO_received_WEST</fullName>
        <description>Notification of PTO received WEST</description>
        <protected>false</protected>
        <recipients>
            <recipient>Accounting_All</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>MarketingDirector</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>aworthen@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bbarker@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kmartinez@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rbird@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sshiokari@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tkeane@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/PTO_Received_2</template>
    </alerts>
    <alerts>
        <fullName>Notify_Oppty_Owner_IA_AE_Approved</fullName>
        <description>Notify Oppty Owner IA AE Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Oppty_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/IA_AE_Approved</template>
    </alerts>
    <alerts>
        <fullName>Notify_Oppty_Owner_IA_Submitted_to_Utility</fullName>
        <description>Notify Oppty Owner IA Submitted to Utility</description>
        <protected>false</protected>
        <recipients>
            <field>Oppty_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/IA_Submitted_to_Utility</template>
    </alerts>
    <alerts>
        <fullName>Study_Underway_Date_Changed</fullName>
        <description>Study Underway Date Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Study_Underway_Date_Changed</template>
    </alerts>
    <alerts>
        <fullName>Study_Underway_has_passed</fullName>
        <description>Study Underway has passed</description>
        <protected>false</protected>
        <recipients>
            <field>Internal_EE_from_Project_Site__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Study_Underway_has_passed</template>
    </alerts>
    <alerts>
        <fullName>X20_BD_After_Study_Underway</fullName>
        <ccEmails>intx@borregosolar.com</ccEmails>
        <description>20 BD After Study Underway</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X20_BD_After_Study_Underway</template>
    </alerts>
    <fieldUpdates>
        <fullName>App_Accepted_End</fullName>
        <field>App_Accepted_End__c</field>
        <formula>Date_Send_Follow_on_Studies_Cost_Agmt__c</formula>
        <name>App Accepted End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_Accepted_Start</fullName>
        <field>App_Accepted_Start__c</field>
        <formula>Date_Review_App_for_Completeness__c</formula>
        <name>App Accepted Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_Submitted_End</fullName>
        <field>App_Submitted_End__c</field>
        <formula>Date_Review_App_for_Completeness__c</formula>
        <name>App Submitted End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>App_Submitted_Start</fullName>
        <field>App_Submitted_Start__c</field>
        <formula>TODAY()</formula>
        <name>App Submitted Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_AE_Completed</fullName>
        <field>Date_AE_Completed__c</field>
        <formula>TODAY()</formula>
        <name>Date AE Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Approved</fullName>
        <description>Autofill the date of final approval</description>
        <field>Date_Approved__c</field>
        <formula>NOW()</formula>
        <name>Date Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Expected_ISA_MA_Expedited</fullName>
        <field>Date_Expected_ISA__c</field>
        <formula>IF(TEXT(Status__c) == &quot;Supplemental Review&quot;,Expected_Date_Complete_Supp_Review__c + 14 + Borrego_Days_Supp_Review__c + Excusable_Delays_Supp_Review__c,

IF(TEXT(Status__c) == &quot;Send Follow-on Studies Cost/Agreement&quot;,TODAY() + 42,

IF(TEXT(Status__c) == &quot;Complete Review of all Screens&quot;,Date_Review_App_for_Completeness__c + 77 + Borrego_Days_Rev_App_for_Completeness__c + Excusable_Delays_Review_Application__c,

IF(TEXT(Status__c) == &quot;Review Application for Completeness&quot;,Date_Acknowledge_Receipt_of_Application__c + 91 + Borrego_Days_Acknowledge_Receipt__c + Excusable_Delays_Acknowledge_Receipt__c,

IF(TEXT(Status__c) == &quot;Acknowledge Receipt of Application&quot;,
Date_Application_Submitted_to_Utility__c + 94,
null)))))</formula>
        <name>Date Expected ISA MA Expedited</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Modified_IR</fullName>
        <description>Updates the &quot;Date Modified&quot; field with the date there was a change to any of the fields in the &quot;Initial Review&quot; subsection.</description>
        <field>IR_Date_Modified__c</field>
        <formula>TODAY()</formula>
        <name>Date Modified IR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Modified_OB</fullName>
        <description>Updates the &quot;Date Modified&quot; field with the date there was a change to any of the fields in the &quot;Override / Best Estimate&quot; subsection.</description>
        <field>OB_Date_Modified__c</field>
        <formula>TODAY()</formula>
        <name>Date Modified OB</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Modified_SIS</fullName>
        <description>Updates the &quot;Date Modified&quot; field with the date there was a change to any of the fields in the &quot;System Impact Study&quot; subsection.</description>
        <field>SIS_Date_Modified__c</field>
        <formula>TODAY()</formula>
        <name>Date Modified SIS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_PE_Approved</fullName>
        <field>Date_PE_Approved__c</field>
        <formula>TODAY()</formula>
        <name>Date PE Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Request_Submitted</fullName>
        <description>auto updates Date the REquest was submitte for approval</description>
        <field>Date_Request_Submitted__c</field>
        <formula>TODAY()</formula>
        <name>Date Request Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_Withdrawn</fullName>
        <field>Date_Withdrawn__c</field>
        <formula>TODAY()</formula>
        <name>Date Withdrawn</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Detailed_Study_Underway_Early_ISA_Execut</fullName>
        <field>Status__c</field>
        <literalValue>Detailed Study Underway</literalValue>
        <name>Detailed Study Underway/Early ISA Execut</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Dtld_Study_Early_ISA_Start</fullName>
        <field>Ready_for_Dtld_Study_Start__c</field>
        <formula>Ready_for_Detailed_Study_Early_ISA__c</formula>
        <name>Dtld Study/Early ISA Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Dtld_Study_Underway_End</fullName>
        <field>Detailed_Study_Underway_End__c</field>
        <formula>Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c</formula>
        <name>Dtld Study Underway End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Dtld_Study_Underway_Start</fullName>
        <field>Detailed_Study_Underway_Start__c</field>
        <formula>Dtld_Study_Underway_Early_ISA_Executed__c</formula>
        <name>Dtld Study Underway Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DueDate</fullName>
        <field>DueDate__c</field>
        <formula>Next_Milestone_Date_New__c</formula>
        <name>DueDate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Executed_Final_ISA_End</fullName>
        <field>Executed_Final_ISA_End__c</field>
        <formula>Utility_Construction_Start_Date__c</formula>
        <name>Executed Final ISA End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Executed_Final_ISA_Start</fullName>
        <field>Executed_Final_ISA_Start__c</field>
        <formula>Executed_ISA__c</formula>
        <name>Executed Final ISA Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Executed_ISA</fullName>
        <field>Status__c</field>
        <literalValue>Executed Agreement</literalValue>
        <name>Executed Agreement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expected_ISA_Date_MA_Complex</fullName>
        <description>Set the Expected ISA Date field for Application Type MA Complex.</description>
        <field>Expected_ISA_Date__c</field>
        <formula>CASE(1, IF(ISPICKVAL(Status__c, &quot;Application Requested&quot;), 1, 0), IF(ISBLANK(Date_Request_Submitted__c), null, Date_Request_Submitted__c + 162 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Application Submitted&quot;), 1, 0), IF(ISBLANK(Date_Application_Submitted_to_Utility__c), null, Date_Application_Submitted_to_Utility__c + 154 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Initial Review&quot;), 1, 0), IF(ISBLANK(Date_Review_App_for_Completeness__c), null, Date_Review_App_for_Completeness__c + 140 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Study&quot;), 1, 0), IF(ISBLANK(Date_Send_Follow_on_Studies_Cost_Agmt__c), null, TODAY() + 105 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Study Underway&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_D_Submitted_Impact_Study__c), null, Date_Exhibit_D_Submitted_Impact_Study__c + 105 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Agreement&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c), null, Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c + 21 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
null)</formula>
        <name>Expected ISA Date: MA Complex</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expected_ISA_Date_MA_Expedited</fullName>
        <description>Set the Expected ISA Date field for Application Type =  MA Expedited.</description>
        <field>Expected_ISA_Date__c</field>
        <formula>CASE(1, IF(ISPICKVAL(Status__c, &quot;Application Requested&quot;), 1, 0), IF(ISBLANK(Date_Request_Submitted__c), null, Date_Request_Submitted__c + 99 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Application Submitted&quot;), 1, 0), IF(ISBLANK(Date_Application_Submitted_to_Utility__c), null, Date_Application_Submitted_to_Utility__c + 91 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Initial Review&quot;), 1, 0), IF(ISBLANK(Date_Review_App_for_Completeness__c), null, Date_Review_App_for_Completeness__c + 77 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Study&quot;), 1, 0), IF(ISBLANK(Date_Send_Follow_on_Studies_Cost_Agmt__c), null, TODAY() + 42 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Study Underway&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_D_Submitted_Impact_Study__c), null, Date_Exhibit_D_Submitted_Impact_Study__c + 42 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Study&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c), null, Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c + 14 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
null)</formula>
        <name>Expected ISA Date: MA Expedited</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expected_ISA_Date_MA_Standard</fullName>
        <description>Set the Expected ISA Date field for Application Type MA Standard.</description>
        <field>Expected_ISA_Date__c</field>
        <formula>CASE(1, IF(ISPICKVAL(Status__c, &quot;Application Requested&quot;), 1, 0), IF(ISBLANK(Date_Request_Submitted__c), null, Date_Request_Submitted__c + 155 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Application Submitted&quot;), 1, 0), IF(ISBLANK(Date_Application_Submitted_to_Utility__c), null, Date_Application_Submitted_to_Utility__c + 147 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Initial Review&quot;), 1, 0), IF(ISBLANK(Date_Review_App_for_Completeness__c), null, Date_Review_App_for_Completeness__c + 133 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Study&quot;), 1, 0), IF(ISBLANK(Date_Send_Follow_on_Studies_Cost_Agmt__c), null, TODAY() + 98 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Study Underway&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_D_Submitted_Impact_Study__c), null, Date_Exhibit_D_Submitted_Impact_Study__c + 98 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Study&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c), null, Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c + 21 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
null)</formula>
        <name>Expected ISA Date: MA Standard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expected_ISA_Date_MA_Standard_Complex</fullName>
        <description>Set the Expected ISA Date field for record type MA - Standard Complex.</description>
        <field>Expected_ISA_Date__c</field>
        <formula>CASE(1, IF( ISPICKVAL( Status__c , &quot;Impact Study&quot;), 1, 0), 
 IF( ISBLANK( Date_Exhibit_D_Submitted_Impact_Study__c ) , null,  Date_Exhibit_D_Submitted_Impact_Study__c + 126), 
IF( ISPICKVAL( Status__c , &quot;Send Follow-on Studies Cost/Agreement&quot;), 1, 0), TODAY() + 133,
IF( ISPICKVAL( Status__c , &quot;Complete Standard Process Initial Review&quot;), 1, 0), Date_Review_App_for_Completeness__c + 168 + BLANKVALUE(Borrego_Days_Rev_App_for_Completeness__c, 0) + BLANKVALUE(Excusable_Delays_Review_Application__c, 0),
IF( ISPICKVAL( Status__c , &quot;Review Application for Completeness&quot;), 1, 0), Date_Acknowledge_Receipt_of_Application__c + 182 + BLANKVALUE(Borrego_Days_Acknowledge_Receipt__c, 0) + BLANKVALUE(Excusable_Delays_Acknowledge_Receipt__c, 0),
IF( ISPICKVAL( Status__c , &quot;Acknowledge Receipt of Application&quot;), 1, 0), Date_Application_Submitted_to_Utility__c + 185,
null)</formula>
        <name>Expected ISA Date: MA - Standard Complex</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expected_ISA_Date_NY_Expedited</fullName>
        <description>Set the Expected ISA Date field for Application Type NY Expedited</description>
        <field>Expected_ISA_Date__c</field>
        <formula>CASE(1, IF(ISPICKVAL(Status__c, &quot;Application Requested&quot;), 1, 0), IF(ISBLANK(Date_Request_Submitted__c), null, Date_Request_Submitted__c +85+ IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Initial Review&quot;), 1, 0), IF(ISBLANK(Date_Application_Submitted_to_Utility__c), null, Date_Application_Submitted_to_Utility__c + 77+ IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Initial Review&quot;), 1, 0), IF(ISBLANK(Date_Review_App_for_Completeness__c), null, Date_Review_App_for_Completeness__c +70+ IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Study&quot;), 1, 0), IF(ISBLANK(Date_Send_Follow_on_Studies_Cost_Agmt__c), null, TODAY() +49+ IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Study Underway&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_D_Submitted_Impact_Study__c), null, Date_Exhibit_D_Submitted_Impact_Study__c +49+ IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Agreement&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c), null, Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c + 21 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
null)</formula>
        <name>Expected ISA Date: NY Expedited</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expected_ISA_Date_NY_Standard</fullName>
        <description>Set the Expected ISA Date field for Application Type NY Standard.</description>
        <field>Expected_ISA_Date__c</field>
        <formula>CASE(1, IF(ISPICKVAL(Status__c, &quot;Application Requested&quot;), 1, 0), IF(ISBLANK(Date_Request_Submitted__c), null, Date_Request_Submitted__c + 141 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Application Submitted&quot;), 1, 0), IF(ISBLANK(Date_Application_Submitted_to_Utility__c), null, Date_Application_Submitted_to_Utility__c + 133 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Initial Review&quot;), 1, 0), IF(ISBLANK(Date_Review_App_for_Completeness__c), null, Date_Review_App_for_Completeness__c + 126 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Study&quot;), 1, 0), IF(ISBLANK(Date_Send_Follow_on_Studies_Cost_Agmt__c), null, TODAY() + 105 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Study Underway&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_D_Submitted_Impact_Study__c), null, Date_Exhibit_D_Submitted_Impact_Study__c + 105 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
IF(ISPICKVAL(Status__c, &quot;Ready for Agreement&quot;), 1, 0), IF(ISBLANK(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c), null, Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c + 21 + IF(ISBLANK(Additional_Days__c), 0, Additional_Days__c)), 
null)</formula>
        <name>Expected ISA Date: NY Standard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expected_ISA_Date_Recalculate</fullName>
        <description>Clear the Recalculate flag for Expected ISA Date.</description>
        <field>Recalculate__c</field>
        <literalValue>0</literalValue>
        <name>Expected ISA Date: Recalculate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IEE_EMail</fullName>
        <field>Internal_EE_from_Project_Site__c</field>
        <formula>Site__r.Electrical_Engineer__r.Email</formula>
        <name>IEE EMail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IR_Confidence_Interval</fullName>
        <description>Overwrite Confidence Interval field in Best Estimate section</description>
        <field>OB_Confidence_Interval__c</field>
        <formula>IR_Confidence_Interval__c</formula>
        <name>IR Confidence Interval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IR_Cost_Estimates</fullName>
        <description>Overwrites Cost Estimate field in the Best Estimate Section</description>
        <field>OB_Cost_Estimate__c</field>
        <formula>IR_Cost_Estimate__c</formula>
        <name>IR Cost Estimate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IR_Date_Modified</fullName>
        <description>Overwrites Date Modified field in the Best Estimate Section</description>
        <field>OB_Date_Modified__c</field>
        <formula>TODAY()</formula>
        <name>IR Date Modified</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IR_Estimated_Timeline</fullName>
        <description>Overwrites Estimate Timeline field in the Best Estimate Section</description>
        <field>OB_Estimated_Timeline__c</field>
        <formula>IR_Estimated_Timeline__c</formula>
        <name>IR Estimated Timeline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Interconnection_Request_PE_Approval</fullName>
        <field>Request_Status__c</field>
        <literalValue>Request Approved</literalValue>
        <name>Interconnection Request Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_Construction</fullName>
        <field>Status__c</field>
        <literalValue>Construction Timeline</literalValue>
        <name>Intx App Construction</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_PTO_Checkbox</fullName>
        <field>Status__c</field>
        <literalValue>Permission To Operate</literalValue>
        <name>Intx App PTO Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_Ready_Final_ISA_Start</fullName>
        <field>Ready_for_Final_ISA_Start__c</field>
        <formula>Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c</formula>
        <name>Intx App Ready Final ISA Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_Ready_ISA</fullName>
        <field>Status__c</field>
        <literalValue>Ready for Agreement</literalValue>
        <name>Ready for Agreement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_Status_Update</fullName>
        <description>auto updates application status to App Requested</description>
        <field>Status__c</field>
        <literalValue>Application Requested</literalValue>
        <name>Intx App Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_Status_Update_Accepted</fullName>
        <field>Status__c</field>
        <literalValue>Initial Review</literalValue>
        <name>Intx App Status Initial Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_Status_Update_App_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Application Approved</literalValue>
        <name>Intx App Status Update App Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_Status_Update_Ready_SIS_CESIR</fullName>
        <field>Status__c</field>
        <literalValue>Ready for Study</literalValue>
        <name>Intx App Status Ready for Study</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_Status_Update_Submitted</fullName>
        <field>Status__c</field>
        <literalValue>Application Submitted</literalValue>
        <name>Intx App Status Update Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_App_Submitted_Start_Date</fullName>
        <field>App_Submitted_Start__c</field>
        <formula>Date_Application_Submitted_to_Utility__c</formula>
        <name>Intx App Submitted Start Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_Request_Status</fullName>
        <description>auto updates Request status to in progress</description>
        <field>Request_Status__c</field>
        <literalValue>In Progress</literalValue>
        <name>Intx Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_Request_Status_AE_Completed</fullName>
        <field>Request_Status__c</field>
        <literalValue>AE Approved</literalValue>
        <name>Intx Request Status AE Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_Request_Status_Cancelled</fullName>
        <field>Request_Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Intx Request Status Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_Request_Status_Declined</fullName>
        <field>Request_Status__c</field>
        <literalValue>Declined</literalValue>
        <name>Intx Request Status Declined</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_Request_Status_Revise_Resubmit</fullName>
        <field>Request_Status__c</field>
        <literalValue>Revise &amp; Resubmit</literalValue>
        <name>Intx Request Status Revise &amp; Resubmit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Intx_Status_Update_SIS_CESIR_Underway</fullName>
        <field>Status__c</field>
        <literalValue>Study Underway</literalValue>
        <name>Intx Status Update SIS/CESIR Underway</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>No_Longer_Active</fullName>
        <field>Active__c</field>
        <literalValue>0</literalValue>
        <name>No Longer Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_SIS_CESIR_Date_Set</fullName>
        <field>Ready_SIS_CESIR_Date_Set__c</field>
        <formula>IF(ISBLANK(Date_Send_Follow_on_Studies_Cost_Agmt__c), null, TODAY())</formula>
        <name>Ready SIS/CESIR - Date Set</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_SIS_CESIR_End</fullName>
        <field>Ready_SIS_CESIR_End__c</field>
        <formula>Date_Exhibit_D_Submitted_Impact_Study__c</formula>
        <name>Ready SIS/CESIR End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_SIS_CESIR_Start</fullName>
        <field>Ready_SIS_CESIR_Start__c</field>
        <formula>Date_Send_Follow_on_Studies_Cost_Agmt__c</formula>
        <name>Ready SIS/CESIR Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_for_Detailed_Study_Early_ISA</fullName>
        <field>Status__c</field>
        <literalValue>Ready for Detailed Study</literalValue>
        <name>Ready for Detailed Study</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_for_Detailed_Study_End</fullName>
        <field>Ready_for_Dtld_Study_End__c</field>
        <formula>Dtld_Study_Underway_Early_ISA_Executed__c</formula>
        <name>Ready for Detailed Study End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ready_for_Final_ISA_End</fullName>
        <field>Ready_for_Final_ISA_End__c</field>
        <formula>Executed_ISA__c</formula>
        <name>Ready for Final ISA End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revert_Status_when_Date_Field_is_Cleared</fullName>
        <field>Status__c</field>
        <name>Revert Status when Date Field is Cleared</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>PreviousValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SIS_CESIR_Underway_END_Detailed_Study</fullName>
        <field>SIS_CESIR_Underway_End__c</field>
        <formula>Ready_for_Detailed_Study_Early_ISA__c</formula>
        <name>SIS/CESIR Underway END Detailed Study</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SIS_CESIR_Underway_End_No_Detailed_Study</fullName>
        <field>SIS_CESIR_Underway_End__c</field>
        <formula>Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c</formula>
        <name>SIS/CESIR Underway End No Detailed Study</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SIS_CESIR_Underway_Start</fullName>
        <field>SIS_CESIR_Underway_Start__c</field>
        <formula>Date_Exhibit_D_Submitted_Impact_Study__c</formula>
        <name>SIS/CESIR Underway Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SIS_Confidence_Interval</fullName>
        <description>When checkbox is checked update the Confidence Interval field in the Best Estimate section to 99%</description>
        <field>OB_Confidence_Interval__c</field>
        <formula>0.99</formula>
        <name>SIS Confidence Interval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SIS_Cost_Estimate</fullName>
        <description>Overwrites Cost Estimate Fields in the Best Estimate Section</description>
        <field>OB_Cost_Estimate__c</field>
        <formula>SIS_Cost_Estimate__c</formula>
        <name>SIS Cost Estimate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SIS_Date_Modified</fullName>
        <description>Overwrites Date Modified field in the Best Estimate Section</description>
        <field>OB_Date_Modified__c</field>
        <formula>TODAY()</formula>
        <name>SIS Date Modified</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SIS_Estimated_Timeline</fullName>
        <description>Overwrites Estimated Timeline field in the Best Estimate Section</description>
        <field>OB_Estimated_Timeline__c</field>
        <formula>SIS_Estimated_Timeline__c</formula>
        <name>SIS Estimated Timeline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SIS_Utility_Provided_Timeline</fullName>
        <description>Overwrites Confidence Interval field in the Best Estimate Section</description>
        <field>OB_Utility_Provided_Timeline__c</field>
        <formula>SIS_Utility_Provided_Timeline__c</formula>
        <name>SIS Utility Provided Timeline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_Date_of_Most_Recent_Hold</fullName>
        <field>Start_Date_Most_Recent_Hold__c</field>
        <formula>TODAY()</formula>
        <name>Start Date of Most Recent Hold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Withdrawn</fullName>
        <field>Status__c</field>
        <literalValue>Withdrawn</literalValue>
        <name>Status Withdrawn</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Total_Days_On_Hold_Update</fullName>
        <description>auto adds days on hold to this field each time it changes</description>
        <field>Total_Days_on_Hold__c</field>
        <formula>IF(ISBLANK(Total_Days_on_Hold__c) ,(TODAY() -  Start_Date_Most_Recent_Hold__c ), Total_Days_on_Hold__c + (TODAY() - Start_Date_Most_Recent_Hold__c))</formula>
        <name>Total Days On Hold Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_IR_Best_Estimate</fullName>
        <description>Unchecks the IR Best Estimate checkbox if it is checked</description>
        <field>Initial_Review_Best_Estimate__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck IR Best Estimate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_SIS_Best_Estimate</fullName>
        <description>Unchecks the SIS Best Estimate checkbox if it is checked</description>
        <field>SIS_Best_Estimate__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck SIS Best Estimate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Oppty_Owner_Email_field</fullName>
        <description>updates the oppty owner email field so it can be used in an email alert later on</description>
        <field>Oppty_Owner_Email__c</field>
        <formula>ASProject__r.EC__r.Email</formula>
        <name>Update Oppty Owner Email field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_text_value_of_status</fullName>
        <field>Text_value_of_Status__c</field>
        <formula>TEXT( Status__c )</formula>
        <name>Update text value of status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>add_todays_date</fullName>
        <field>Status_Change_Date__c</field>
        <formula>TODAY()</formula>
        <name>add todays date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>20 Days After Study Underway</fullName>
        <active>true</active>
        <description>20BD after an Interconnection Application has been marked as &quot;Study Underway&quot; for Massachusetts application types only</description>
        <formula>AND( ISPICKVAL( Status__c , &quot;SIS/CESIR Underway&quot;), OR(  ISPICKVAL(Application_Type__c, &quot;MA Standard&quot;),  ISPICKVAL(Application_Type__c, &quot;MA Complex&quot;),  ISPICKVAL(Application_Type__c, &quot;MA Expedited&quot;) ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>X20_BD_After_Study_Underway</name>
                <type>Alert</type>
            </actions>
            <timeLength>20</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Best Estimate Section Updated</fullName>
        <actions>
            <name>Best_Estimate_Section_modified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(OB_Date_Modified__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Date Change Time Stamp</fullName>
        <actions>
            <name>add_todays_date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>DueDate</fullName>
        <actions>
            <name>DueDate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>auto updates date that is in Next Milestone Date upon any change in date field on the form</description>
        <formula>OR(
ISCHANGED( Additional_Days__c ),
  ISCHANGED( Date_Application_Submitted_to_Utility__c ), 
  ISCHANGED( Date_Review_App_for_Completeness__c ),
  ISCHANGED( Date_Send_Follow_on_Studies_Cost_Agmt__c ),
  ISCHANGED( Date_Exhibit_D_Submitted_Impact_Study__c ),
  ISCHANGED( Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c ),
ISCHANGED( Executed_ISA__c  ),
ISCHANGED( Utility_Construction_Start_Date__c )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Expected ISA Date%3A MA Complex</fullName>
        <actions>
            <name>Expected_ISA_Date_MA_Complex</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Expected_ISA_Date_Recalculate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Calculates the Expected ISA Date for Application Type MA Complex.</description>
        <formula>ISPICKVAL(Application_Type__c, &quot;MA Complex&quot;) &amp;&amp; ISBLANK(Executed_ISA__c) &amp;&amp; (Recalculate__c || ISNEW() || ISCHANGED(Executed_ISA__c) || ISCHANGED(Application_Type__c) || ISCHANGED(Status__c) || ISCHANGED(Date_Request_Submitted__c) || ISCHANGED(Date_Application_Submitted_to_Utility__c) || ISCHANGED(Additional_Days__c) || ISCHANGED(Date_Review_App_for_Completeness__c) || ISCHANGED(Date_Send_Follow_on_Studies_Cost_Agmt__c) || ISCHANGED(Date_Exhibit_D_Submitted_Impact_Study__c) || ISCHANGED(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Expected ISA Date%3A MA Expedited</fullName>
        <actions>
            <name>Expected_ISA_Date_MA_Expedited</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Expected_ISA_Date_Recalculate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Calculates the Expected ISA Date when Application Type =  MA Expedited.</description>
        <formula>ISPICKVAL(Application_Type__c, &quot;MA Expedited&quot;) &amp;&amp; ISBLANK(Executed_ISA__c) &amp;&amp; (Recalculate__c || ISNEW() || ISCHANGED(Executed_ISA__c) || ISCHANGED(Application_Type__c) || ISCHANGED(Status__c) || ISCHANGED(Date_Request_Submitted__c) || ISCHANGED(Date_Application_Submitted_to_Utility__c) || ISCHANGED(Additional_Days__c) || ISCHANGED(Date_Review_App_for_Completeness__c) || ISCHANGED(Date_Send_Follow_on_Studies_Cost_Agmt__c) || ISCHANGED(Date_Exhibit_D_Submitted_Impact_Study__c) || ISCHANGED(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Expected ISA Date%3A MA Standard</fullName>
        <actions>
            <name>Expected_ISA_Date_MA_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Expected_ISA_Date_Recalculate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Calculates the Expected ISA Date for Application Type MA Standard.</description>
        <formula>ISPICKVAL(Application_Type__c, &quot;MA Standard&quot;) &amp;&amp; ISBLANK(Executed_ISA__c) &amp;&amp; (Recalculate__c || ISNEW() || ISCHANGED(Executed_ISA__c) || ISCHANGED(Application_Type__c) || ISCHANGED(Status__c) || ISCHANGED(Date_Request_Submitted__c) || ISCHANGED(Date_Application_Submitted_to_Utility__c) || ISCHANGED(Additional_Days__c) || ISCHANGED(Date_Review_App_for_Completeness__c) || ISCHANGED(Date_Send_Follow_on_Studies_Cost_Agmt__c) || ISCHANGED(Date_Exhibit_D_Submitted_Impact_Study__c) || ISCHANGED(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Expected ISA Date%3A NY Expedited</fullName>
        <actions>
            <name>Expected_ISA_Date_NY_Expedited</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Expected_ISA_Date_Recalculate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Calculates the Expected ISA Date for Application Type NY Expedited</description>
        <formula>ISPICKVAL(Application_Type__c, &quot;NY Expedited&quot;) &amp;&amp; ISBLANK(Executed_ISA__c) &amp;&amp; (Recalculate__c || ISNEW() || ISCHANGED(Executed_ISA__c) || ISCHANGED(Application_Type__c) || ISCHANGED(Status__c) || ISCHANGED(Date_Request_Submitted__c) || ISCHANGED(Date_Application_Submitted_to_Utility__c) || ISCHANGED(Additional_Days__c) || ISCHANGED(Date_Review_App_for_Completeness__c) || ISCHANGED(Date_Send_Follow_on_Studies_Cost_Agmt__c) || ISCHANGED(Date_Exhibit_D_Submitted_Impact_Study__c) || ISCHANGED(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Expected ISA Date%3A NY Standard</fullName>
        <actions>
            <name>Expected_ISA_Date_NY_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Expected_ISA_Date_Recalculate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Calculates the Expected ISA Date for Application Type NY Standard.</description>
        <formula>ISPICKVAL(Application_Type__c, &quot;NY Standard&quot;) &amp;&amp; ISBLANK(Executed_ISA__c) &amp;&amp; (Recalculate__c || ISNEW() || ISCHANGED(Executed_ISA__c) || ISCHANGED(Application_Type__c) || ISCHANGED(Status__c) || ISCHANGED(Date_Request_Submitted__c) || ISCHANGED(Date_Application_Submitted_to_Utility__c) || ISCHANGED(Additional_Days__c) || ISCHANGED(Date_Review_App_for_Completeness__c) || ISCHANGED(Date_Send_Follow_on_Studies_Cost_Agmt__c) || ISCHANGED(Date_Exhibit_D_Submitted_Impact_Study__c) || ISCHANGED(Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>IEE Email</fullName>
        <actions>
            <name>IEE_EMail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>auto fills email address of Internal Electicial Engineer from related Site</description>
        <formula>ISCHANGED ( Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Initial Review Override</fullName>
        <actions>
            <name>IR_Confidence_Interval</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>IR_Cost_Estimates</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>IR_Date_Modified</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>IR_Estimated_Timeline</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Uncheck_SIS_Best_Estimate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When checkbox is checked, overwrite Best Estimate section</description>
        <formula>Initial_Review_Best_Estimate__c = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Initial Review Section Modified</fullName>
        <actions>
            <name>Date_Modified_IR</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Records date &quot;Initial Review&quot; subsection fields were modified</description>
        <formula>OR(ISCHANGED(IR_Cost_Estimate__c),     ISCHANGED(IR_Estimated_Timeline__c),     ISCHANGED(IR_Confidence_Interval__c),    ISCHANGED(IR_Notes__c),    ISCHANGED(IR_Link_to_Evaluation_Spreadsheet__c)   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Accepted</fullName>
        <actions>
            <name>App_Accepted_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>App_Submitted_End</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Intx_App_Status_Update_Accepted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED (Date_Review_App_for_Completeness__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Application Approved</fullName>
        <actions>
            <name>Intx_App_Status_Update_App_Approved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Date_Approved__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Construction</fullName>
        <actions>
            <name>Executed_Final_ISA_End</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Intx_App_Construction</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Utility_Construction_Start_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Executed Agreement</fullName>
        <actions>
            <name>Executed_ISA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Interconnection_Application__c.Executed_ISA__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Executed Final ISA</fullName>
        <actions>
            <name>Executed_Final_ISA_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Executed_ISA</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ready_for_Final_ISA_End</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Executed_ISA__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App PTO EAST</fullName>
        <actions>
            <name>Notification_of_PTO_received_EAST</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Intx_App_PTO_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Interconnection_Application__c.PTO__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Interconnection_Application__c.Branch__c</field>
            <operation>equals</operation>
            <value>Mid Atlantic,Boston,New England</value>
        </criteriaItems>
        <criteriaItems>
            <field>Interconnection_Application__c.Overall_project_Status__c</field>
            <operation>notEqual</operation>
            <value>Complete,Completed</value>
        </criteriaItems>
        <description>when PTO box is checked auto update status to Permission to Operate, this status will also have tiggers associated with it to update SITE PTO...for EAST COAST branches</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_to_TS_Customer_Survey</name>
                <type>Alert</type>
            </actions>
            <timeLength>90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Intx App PTO WEST</fullName>
        <actions>
            <name>Notification_of_PTO_received_WEST</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Intx_App_PTO_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Interconnection_Application__c.PTO__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Interconnection_Application__c.Branch__c</field>
            <operation>equals</operation>
            <value>Puerto Rico,San Diego,Berkeley,Oakland</value>
        </criteriaItems>
        <criteriaItems>
            <field>Interconnection_Application__c.Overall_project_Status__c</field>
            <operation>notEqual</operation>
            <value>Complete,Completed</value>
        </criteriaItems>
        <description>when PTO box is checked auto update status to Permission to Operate, this status will also have tiggers associated with it to update SITE PTO...for WEST COAST branches</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_to_TS_Customer_Survey</name>
                <type>Alert</type>
            </actions>
            <timeLength>90</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Intx App Ready Final ISA</fullName>
        <actions>
            <name>Dtld_Study_Underway_End</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Intx_App_Ready_Final_ISA_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Intx_App_Ready_ISA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Ready for Agreement</fullName>
        <actions>
            <name>Intx_App_Ready_ISA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Interconnection_Application__c.Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Ready for Detailed Study%2FEarly ISA</fullName>
        <actions>
            <name>Dtld_Study_Early_ISA_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ready_for_Detailed_Study_Early_ISA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Ready_for_Detailed_Study_Early_ISA__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Ready for Study</fullName>
        <actions>
            <name>App_Accepted_End</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Intx_App_Status_Update_Ready_SIS_CESIR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ready_SIS_CESIR_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Date_Send_Follow_on_Studies_Cost_Agmt__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Study Underway</fullName>
        <actions>
            <name>Intx_Status_Update_SIS_CESIR_Underway</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ready_SIS_CESIR_End</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SIS_CESIR_Underway_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Date_Exhibit_D_Submitted_Impact_Study__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Submitted to Utilitiy</fullName>
        <actions>
            <name>Intx_App_Status_Update_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Intx_App_Submitted_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Date_Application_Submitted_to_Utility__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx App Submitted to Utility</fullName>
        <actions>
            <name>Notify_Oppty_Owner_IA_Submitted_to_Utility</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Intx_App_Status_Update_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Intx_App_Submitted_Start_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Date_Application_Submitted_to_Utility__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx AppDetailed Study Underway%2FEarly ISA Executed</fullName>
        <actions>
            <name>Detailed_Studay_Underway_Date_Change_Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Detailed_Study_Underway_Early_ISA_Execut</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Dtld_Study_Underway_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Ready_for_Detailed_Study_End</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Dtld_Study_Underway_Early_ISA_Executed__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx Application HOLD notification</fullName>
        <actions>
            <name>Alert_to_Rob_Tompkins_whenever_HOLD_status_on_Intx_App_is_changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>notifies Rob anytime HOLD status changes on an intx application</description>
        <formula>ISCHANGED(  Hold__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Intx Total Days On HOld</fullName>
        <actions>
            <name>Total_Days_On_Hold_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Interconnection_Application__c.Hold__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>workflow that calculates a cumulative days on hold based on On Hold being checked and Days on Hold</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Intx Withdrawn</fullName>
        <actions>
            <name>Date_Withdrawn</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>No_Longer_Active</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Status_Withdrawn</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Interconnection_Application__c.Withdrawn__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Override %2F Best Estimate Section Modified</fullName>
        <actions>
            <name>Date_Modified_Changed_Best_Estimate</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Date_Modified_OB</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>records date &quot;Override / Best Estimate&quot; subsection fields were modified</description>
        <formula>OR(ISCHANGED(OB_Cost_Estimate__c),     ISCHANGED(OB_Estimated_Timeline__c),     ISCHANGED(OB_Utility_Provided_Timeline__c),    ISCHANGED(OB_Confidence_Interval__c),    ISCHANGED(OB_Notes__c)   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Ready SIS%2FCESIR - Date Set</fullName>
        <actions>
            <name>Ready_SIS_CESIR_Date_Set</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Records the date that field Ready SIS/CESIR is changed.</description>
        <formula>OR(   ISNEW(),   ISCHANGED(Date_Send_Follow_on_Studies_Cost_Agmt__c) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Revert Status when Date Field is Cleared</fullName>
        <actions>
            <name>Revert_Status_when_Date_Field_is_Cleared</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>puts status back to prior value when date field is cleared</description>
        <formula>ISCHANGED( Date_Review_App_for_Completeness__c)  &amp;&amp;  ISBLANK( Date_Review_App_for_Completeness__c) || 

ISCHANGED(  Date_Application_Submitted_to_Utility__c ) &amp;&amp;  ISBLANK(  Date_Application_Submitted_to_Utility__c)|| 

ISCHANGED(   Date_Send_Follow_on_Studies_Cost_Agmt__c  )  &amp;&amp;  ISBLANK(   Date_Send_Follow_on_Studies_Cost_Agmt__c)  || 

ISCHANGED(    Date_Exhibit_D_Submitted_Impact_Study__c  )  &amp;&amp;  ISBLANK(   Date_Exhibit_D_Submitted_Impact_Study__c)   || 

ISCHANGED(     Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c )  &amp;&amp;  ISBLANK(  Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c)     || 

ISCHANGED(   Executed_ISA__c )  &amp;&amp;  ISBLANK( Executed_ISA__c ) || 

ISCHANGED(     Utility_Construction_Start_Date__c  )  &amp;&amp;  ISBLANK(   Utility_Construction_Start_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SIS%2FCESIR Underway END Detailed Study</fullName>
        <actions>
            <name>SIS_CESIR_Underway_END_Detailed_Study</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISCHANGED(  Ready_for_Detailed_Study_Early_ISA__c  ),  ISPICKVAL( Detailed_Study__c, &quot;Yes&quot;)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>SIS%2FCESIR Underway End No Detailed Study</fullName>
        <actions>
            <name>SIS_CESIR_Underway_End_No_Detailed_Study</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ISCHANGED( Date_Exhibit_G_Submitted_3rd_Pty_Agmt__c ),  OR ( ISPICKVAL( Detailed_Study__c, &quot;No&quot;), ISBLANK(TEXT(Detailed_Study__c)) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Start Date of Most Recent Hold</fullName>
        <actions>
            <name>Start_Date_of_Most_Recent_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Interconnection_Application__c.Hold__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>auto date stamps date Hold is checked off</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Study Underway Date has changed</fullName>
        <actions>
            <name>Study_Underway_Date_Changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>email alert when IA Study  Underway field has changed</description>
        <formula>ISCHANGED( Date_Exhibit_D_Submitted_Impact_Study__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Study Underway has passed</fullName>
        <actions>
            <name>Study_Underway_has_passed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>email alert to internal EE that the status of the interconnection app has passed &quot;Study Underway&quot;</description>
        <formula>ISPICKVAL((PRIORVALUE( Status__c )), &quot;Study Underway&quot;)&amp;&amp;
TEXT(Status__c) &lt;&gt; &quot;Study Underway&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>System Impact Study Override</fullName>
        <actions>
            <name>SIS_Confidence_Interval</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SIS_Cost_Estimate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SIS_Date_Modified</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SIS_Estimated_Timeline</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SIS_Utility_Provided_Timeline</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Uncheck_IR_Best_Estimate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>When checkbox is checked, overwrite Best Estimate section</description>
        <formula>SIS_Best_Estimate__c  = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>System Impact Study Section Modified</fullName>
        <actions>
            <name>Date_Modified_SIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Records date &quot;System Impact Study&quot; subsection fields were modified</description>
        <formula>OR(ISCHANGED(SIS_Cost_Estimate__c),     ISCHANGED(SIS_Estimated_Timeline__c),     ISCHANGED(SIS_Utility_Provided_Timeline__c),    ISCHANGED(SIS_Notes__c),    ISCHANGED(SIS_Link_to_Evaluation_Spreadsheet__c)   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update text value of status</fullName>
        <actions>
            <name>Update_text_value_of_status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
