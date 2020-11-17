<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>New_Asset_Watts_kw_STC</fullName>
        <field>Watts__c</field>
        <formula>kW_STC__c * 1000</formula>
        <name>New Asset Watts = kw(STC)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>New Asset Update Watts if kw%28STC%29 is not blank</fullName>
        <actions>
            <name>New_Asset_Watts_kw_STC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>upon creation of a wew Asset formula will update Watts if kw(STC) is not blank</description>
        <formula>NOT(ISBLANK( kW_STC__c ))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
