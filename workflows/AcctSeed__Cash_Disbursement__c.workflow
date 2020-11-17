<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>OK_to_Email_True</fullName>
        <field>OK_To_Email__c</field>
        <literalValue>1</literalValue>
        <name>OK to Email - True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>OK to Email</fullName>
        <actions>
            <name>OK_to_Email_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Defaults to true when the Vendor has at least 1 Billing Contact. Used w/ ACH disbursement email.</description>
        <formula>AND( 
NOT( ISBLANK( Name )), AcctSeed__Vendor__r.Vendor_Billing_Contacts__c &gt; 0)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
