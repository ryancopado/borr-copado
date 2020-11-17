<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Rebate_Request_Accepted</fullName>
        <description>Rebate Request Accepted</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Rebate_Request_Accepted</template>
    </alerts>
    <alerts>
        <fullName>Rebate_Request_Rejected</fullName>
        <description>Rebate Request Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Rebate_Request_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Deadline_Set_to_9_30</fullName>
        <field>Deadline_or_Required_Submission_Date__c</field>
        <formula>DATE(2012,09,30)</formula>
        <name>Deadline Set to 9/30</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected_by_AM</fullName>
        <field>Status__c</field>
        <literalValue>Rejected by Asset Management</literalValue>
        <name>Rejected by AM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submitted_to_AM</fullName>
        <field>Status__c</field>
        <literalValue>Submitted to Asset Management</literalValue>
        <name>Submitted to AM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>accepted_by_asset_management</fullName>
        <field>Status__c</field>
        <literalValue>Accepted by Asset Management</literalValue>
        <name>accepted by asset management</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
