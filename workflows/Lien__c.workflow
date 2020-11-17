<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Lien_Waiver_Contact</fullName>
        <field>Waiver_Email_Contact__c</field>
        <formula>AP_Invoice__r.AcctSeed__Vendor__r.Lien_Waiver_Contact__r.Email</formula>
        <name>Lien Waiver Contact</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Update Lien Waiver Contact Field</fullName>
        <actions>
            <name>Lien_Waiver_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR( ISNEW(),ISCHANGED( AP_Invoice__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
