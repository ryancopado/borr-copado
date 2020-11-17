<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Quote_Approved_Notification</fullName>
        <description>Quote Approved Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>SBQQ__SalesRep__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Quote_Email_Templates/Quote_Approved_Notification</template>
    </alerts>
    <alerts>
        <fullName>Quote_Customer_Reminder_Notification</fullName>
        <description>Quote Customer Reminder Notification</description>
        <protected>false</protected>
        <recipients>
            <field>SBQQ__PrimaryContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Quote_Email_Templates/Quote_Customer_Reminder_Notification</template>
    </alerts>
    <alerts>
        <fullName>Quote_Rejected_Notification</fullName>
        <description>Quote Rejected Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Quote_Email_Templates/Quote_Rejected_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_RT_to_Approved</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Approved</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update RT to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Approved</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Update Status to Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Denied</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>Denied</literalValue>
        <name>Update Status to Denied</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Draft</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>Draft</literalValue>
        <name>Update Status to Draft</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_In_Review</fullName>
        <field>SBQQ__Status__c</field>
        <literalValue>In Review</literalValue>
        <name>Update Status to In Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Quote Customer Reminder Notifications</fullName>
        <active>false</active>
        <criteriaItems>
            <field>SBQQ__Quote__c.SBQQ__Status__c</field>
            <operation>equals</operation>
            <value>Presented</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Quote_Customer_Reminder_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SBQQ__Quote__c.Sent_Date__c</offsetFromField>
            <timeLength>48</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Quote_Customer_Reminder_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>SBQQ__Quote__c.Sent_Date__c</offsetFromField>
            <timeLength>4</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
