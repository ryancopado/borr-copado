<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_alert_to_Sales_Analyst_that_Analysis_Request_has_been_submitted</fullName>
        <description>Email alert to Sales Analyst that Analysis Request has been submitted</description>
        <protected>false</protected>
        <recipients>
            <recipient>pniemann@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Analysis_Request_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Email_alert_to_requestor_that_analysis_request_has_been_completed</fullName>
        <description>Email alert to requestor that analysis request has been completed</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Analysis_Request_Completed</template>
    </alerts>
    <alerts>
        <fullName>Email_to_creator_that_the_analysis_request_needs_more_information</fullName>
        <description>Email to creator that the analysis request needs more information</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Analysis_Request_Needs_More_Information</template>
    </alerts>
    <alerts>
        <fullName>Energy_Storage_Analysis_Request_Complete</fullName>
        <description>Energy Storage Analysis Request Complete</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>mchristian@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Energy_Storage_Analysis_Request</template>
    </alerts>
    <fieldUpdates>
        <fullName>Analysis_Request_COMPLETED</fullName>
        <description>field update and email alert when status is moved to complete</description>
        <field>Date_Completed__c</field>
        <formula>NOW()</formula>
        <name>Analysis Request COMPLETED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Analysis_Request_Date_Submitted</fullName>
        <field>Date_Submitted__c</field>
        <formula>NOW()</formula>
        <name>Analysis Request Date Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Analysis Request COMPLETED</fullName>
        <actions>
            <name>Email_alert_to_requestor_that_analysis_request_has_been_completed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Analysis_Request_COMPLETED</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Analysis_Request__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>date stamps when status was updated to Complete</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Analysis Request Needs More Information</fullName>
        <actions>
            <name>Email_to_creator_that_the_analysis_request_needs_more_information</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Analysis_Request__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Need More Information</value>
        </criteriaItems>
        <description>updates status and emails creator when status is moved to Needs More Information</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Analysis Request SUBMITTED</fullName>
        <actions>
            <name>Email_alert_to_Sales_Analyst_that_Analysis_Request_has_been_submitted</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Analysis_Request_Date_Submitted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Analysis_Request__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <description>date stamps when status was updated to Submit</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Energy Storage Analysis Request</fullName>
        <actions>
            <name>Energy_Storage_Analysis_Request_Complete</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(   INCLUDES(Type__c, &quot;Energy Storage&quot;),   ISPICKVAL(Request_Status__c, &quot;Completed&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
