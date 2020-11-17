<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Journal_Entry_Rejected</fullName>
        <description>Journal Entry Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Journal_Entry_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Journal_Entry_approved</fullName>
        <description>Journal Entry approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Journal_Entry_Approved</template>
    </alerts>
    <fieldUpdates>
        <fullName>Status_Approved</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Rejected</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Status Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Waiting_for_Approval</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Waiting for Approval</literalValue>
        <name>Status Waiting for Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
