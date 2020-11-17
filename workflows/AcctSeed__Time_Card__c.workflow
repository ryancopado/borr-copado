<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Time_Card_has_not_been_submitted</fullName>
        <description>Time Card has not been submitted</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Time_Card_Has_Not_Been_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Time_card_approval_reminder</fullName>
        <description>Time card approval reminder</description>
        <protected>false</protected>
        <recipients>
            <recipient>rburrowbridge@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Time_Card_Needs_Approval</template>
    </alerts>
    <alerts>
        <fullName>Time_card_rejected</fullName>
        <description>Time card rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Time_Card_Rejected</template>
    </alerts>
    <alerts>
        <fullName>time_card_approved</fullName>
        <description>time card approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Time_Card_Approved</template>
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
        <fullName>Rejected</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Waiting_for_approval</fullName>
        <field>AcctSeed__Status__c</field>
        <literalValue>Waiting for Approval</literalValue>
        <name>Waiting for approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Time Card Needs Approval</fullName>
        <active>true</active>
        <description>alert to fire if a time card has not been submitted for approval by Monday of the following week.</description>
        <formula>AND(
ISPICKVAL(AcctSeed__Status__c,&quot;Waiting for Approval&quot;), 
!ISBLANK(AcctSeed__Week_Ending_Date__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Time_card_approval_reminder</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>AcctSeed__Time_Card__c.AcctSeed__Week_Ending_Date__c</offsetFromField>
            <timeLength>4</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
