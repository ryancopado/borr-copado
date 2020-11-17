<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Expense_Approved</fullName>
        <description>Expense Approved</description>
        <protected>false</protected>
        <recipients>
            <field>AcctSeed__Employee__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Expense_Approval</template>
    </alerts>
    <alerts>
        <fullName>Expense_Rejected</fullName>
        <description>Expense Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>AcctSeed__Employee__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Procurement/Expense_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expense_Rejected</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Expense Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pending</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Pending Approval</literalValue>
        <name>Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recalled</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_update_to_Posted</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Posted</literalValue>
        <name>Status update to Posted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Update Status to Posted</fullName>
        <actions>
            <name>Status_update_to_Posted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeed__Expense_Report__c.AcctSeed__Paid_Expenses__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>Updates the status when an AP Invoice has been created</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
