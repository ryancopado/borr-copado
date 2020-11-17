<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Smartsheet_Schedule_Created</fullName>
        <ccEmails>mhanagan@borregosolar.com</ccEmails>
        <description>New Smartsheet Schedule Created</description>
        <protected>false</protected>
        <recipients>
            <recipient>dmoyer@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rtompkins@borregosolar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Smartsheet_Schedule_Created</template>
    </alerts>
    <rules>
        <fullName>New Smartsheet Created</fullName>
        <actions>
            <name>New_Smartsheet_Schedule_Created</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>com_smartsheet__Smartsheet__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>used to send email alerts out when a Smartsheet has been created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
