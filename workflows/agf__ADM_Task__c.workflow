<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Admin_Comments</fullName>
        <field>AdminComments__c</field>
        <formula>TEXT(TODAY())+ &quot; &quot; 
+ LEFT($User.Alias,2) + &quot;:&quot; + &quot; &quot; 
+ Current_Admin_Note__c + BR() + 
BR() + PRIORVALUE(  AdminComments__c )</formula>
        <name>Update Admin Comments</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>update admin historical notes</fullName>
        <actions>
            <name>Update_Admin_Comments</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>updates Admin comments with previous current admin note and adds users initials and date stamp</description>
        <formula>ISCHANGED( Current_Admin_Note__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
