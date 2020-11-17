<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>WOLI_Has_Comment</fullName>
        <field>WOL_has_comments__c</field>
        <literalValue>1</literalValue>
        <name>WOLI Has Comment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Work Order Line Item Comment</fullName>
        <actions>
            <name>WOLI_Has_Comment</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>WorkOrderLineItem.Comments__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>tracks whether Work order line item has a comment. Used with Conga reporting</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
