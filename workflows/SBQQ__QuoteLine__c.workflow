<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Vendor_Count</fullName>
        <field>VendorListed__c</field>
        <formula>1</formula>
        <name>Update Vendor Count</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Vendor count upon creation</fullName>
        <actions>
            <name>Update_Vendor_Count</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>used with billing type field</description>
        <formula>Not(isblank(Vendor__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
