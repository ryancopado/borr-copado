<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Project_Finance_Checklist_has_been_approved</fullName>
        <description>Project Finance Checklist has been approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Finance_Checklist_Approved</template>
    </alerts>
    <alerts>
        <fullName>Project_Finance_Checklist_has_been_rejected</fullName>
        <description>Project Finance Checklist has been rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Project_Finance_Checklist_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Final_Approver</fullName>
        <description>Updates the Project Finance Final Approver field with the actual approver</description>
        <field>Project_Finance_Final_Approver__c</field>
        <formula>$User.FirstName &amp; &quot; &quot; &amp; $User.LastName</formula>
        <name>Update Final Approver</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Approved</fullName>
        <description>updates the status field to Approved</description>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Pending_Approval</fullName>
        <description>updates status field to Pending Approval</description>
        <field>Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Update Status Pending Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_Rejected</fullName>
        <description>updates the status field to rejected</description>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Update Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
