<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_notification_that_Intx_Request_has_been_in_2nd_Review_for_1_day</fullName>
        <description>Email Alert notification that Intx Request has been in 2nd Review for 1 day</description>
        <protected>false</protected>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mconway@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pryder@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Intx_Request_has_been_in_2nd_Review_for_1_Day</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_notification_that_Intx_Request_has_been_in_Initial_Review_Status_for</fullName>
        <description>Email Alert notification that Intx Request has been in Initial Review Status for 4 days</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>pryder@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Intx_Request_has_been_in_Initial_Review_for_4_days</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_that_Interconnection_Request_has_been_denied</fullName>
        <description>Email alert that Interconnection Request has been denied</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Assigned_Apps_Engineer_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Interconnection_Request_Denied</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_to_Project_Coordinator_that_Interconnection_Request_is_complete</fullName>
        <description>Email alert to Project Coordinator that Interconnection Request is complete</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_Apps_Engineer_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Interconnection_Request_Approved</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_to_Project_Coordinator_that_Interconnection_Request_was_been_submitt</fullName>
        <description>Email alert to Project Coordinator that Interconnection Request was been submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Interconnection_Request</template>
    </alerts>
    <alerts>
        <fullName>email_alert_to_managers_that_intx_request_has_been_pending_initial_review_for_7</fullName>
        <description>email alert to managers that intx request has been pending initial review for 7 days</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>alarner@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>areed@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mconway@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <field>Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Intx_Request_has_been_pending_initial_review_for_7_days</template>
    </alerts>
    <fieldUpdates>
        <fullName>Assigned_Apps_Engineer_Email_Update</fullName>
        <description>pulls from opportunity</description>
        <field>Assigned_Apps_Engineer_Email__c</field>
        <formula>Project_Name__r.AcctSeed__Opportunity__r.Assigned_Apps_Engineer__r.Email</formula>
        <name>Assigned Apps Engineer Email Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Update_Date_AE_Completed</fullName>
        <field>Date_AE_Completed__c</field>
        <formula>NOW()</formula>
        <name>Auto Update Date AE Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Update_Date_Submitted_by_PD</fullName>
        <field>Date_Submitted_by_PD__c</field>
        <formula>TODAY()</formula>
        <name>Auto Update Date Submitted by PD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_AE_Approved</fullName>
        <field>Date_AE_Completed__c</field>
        <formula>TODAY()</formula>
        <name>Date AE Approved</name>
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
        <fullName>Date_Requested_by_PD</fullName>
        <field>Date_Submitted_by_PD__c</field>
        <formula>TODAY()</formula>
        <name>Date Requested by PD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Interconnection_Request_AE_Approval</fullName>
        <field>Request_Status__c</field>
        <literalValue>AE Approval</literalValue>
        <name>Interconnection Request AE Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Interconnection_Request_Final_Approval</fullName>
        <field>Request_Status__c</field>
        <literalValue>Final Approval</literalValue>
        <name>Interconnection Request Final Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Interconnection_Request_Initial_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>In progress</literalValue>
        <name>Interconnection Request Initial Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Interconnection_Request_Rejection_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>Declined</literalValue>
        <name>Interconnection Request Rejection Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Interconnection_Request_Revise_Resubmi</fullName>
        <field>Request_Status__c</field>
        <literalValue>Revise &amp; Resubmit</literalValue>
        <name>Interconnection Request Revise &amp; Resubmi</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Interconnection_Request_Status</fullName>
        <field>Request_Status__c</field>
        <literalValue>In progress</literalValue>
        <name>Interconnection Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requeste_Status_Cancelled</fullName>
        <field>Request_Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Requeste Status Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
