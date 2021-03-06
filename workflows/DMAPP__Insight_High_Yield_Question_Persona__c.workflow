<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>DMAPP__Updated_Dealmaker_ID_Field</fullName>
        <field>DMAPP__DealmakerID__c</field>
        <formula>$Organization.Id  + &apos;-&apos; + Id</formula>
        <name>Updated Dealmaker ID Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>DMAPP__Set Insight_High_Yield_Question_Persona GUID</fullName>
        <actions>
            <name>DMAPP__Updated_Dealmaker_ID_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISBLANK(DMAPP__DealmakerID__c) || ISNULL(DMAPP__DealmakerID__c)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
