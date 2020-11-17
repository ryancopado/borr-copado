<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>PO_alert_when_User_Story_moves_to_Ready_for_Review</fullName>
        <description>PO alert when User Story moves to Ready for Review</description>
        <protected>false</protected>
        <recipients>
            <field>agf__Product_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/User_Story_Ready_for_Review</template>
    </alerts>
    <fieldUpdates>
        <fullName>agf__Check_Returned_To_Support_Check_Box</fullName>
        <field>agf__Was_Ever_Returned_to_Support__c</field>
        <literalValue>1</literalValue>
        <name>Check Returned To Support Check Box</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>agf__P4_status</fullName>
        <field>agf__Perforce_Status__c</field>
        <name>P4 status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>agf__Clear P4 Status</fullName>
        <actions>
            <name>agf__P4_status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>agf__ADM_Work__c.agf__Resolved__c</field>
            <operation>equals</operation>
            <value>1</value>
        </criteriaItems>
        <description>Clear P4 status when the work record resolved value becomes 1</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>updates PO when Work Story moves to ready for review</fullName>
        <actions>
            <name>PO_alert_when_User_Story_moves_to_Ready_for_Review</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>agf__ADM_Work__c.agf__Status__c</field>
            <operation>equals</operation>
            <value>Ready for Review</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
