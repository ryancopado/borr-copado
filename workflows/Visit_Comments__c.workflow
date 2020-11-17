<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Latest_Visit_Checkbox</fullName>
        <field>Comment_on_visit__c</field>
        <literalValue>1</literalValue>
        <name>Latest Visit Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Service_Visit__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Latest_Visit_Comment</fullName>
        <field>Latest_Visit_Comment__c</field>
        <formula>Comment__c</formula>
        <name>Update Latest Visit Comment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>Service_Visit__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Update Visit Comment on SV</fullName>
        <actions>
            <name>Latest_Visit_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Latest_Visit_Comment</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Visit_Comments__c.Comment__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
