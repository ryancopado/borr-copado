<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Cannot_Complete_email_to_Ops_Center</fullName>
        <description>Cannot Complete email to Ops Center</description>
        <protected>false</protected>
        <recipients>
            <recipient>DirectorOperationsandMaintenance</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Operations_Center_Agent</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Operations_Center_Manager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Cannot_Complete_email_to_Ops_Center</template>
    </alerts>
    <rules>
        <fullName>Cannot Complete Email</fullName>
        <actions>
            <name>Cannot_Complete_email_to_Ops_Center</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>WorkOrder.Status</field>
            <operation>equals</operation>
            <value>Cannot Complete</value>
        </criteriaItems>
        <description>Email to Ops Center when WO is marked &quot;cannot complete&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
