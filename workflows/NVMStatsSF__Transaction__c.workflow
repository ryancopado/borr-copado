<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>NVMStatsSF__Trigger_Channel_Check</fullName>
        <description>Set Checked flag true, firing Trigger to check Channel OK
Use this in Time Based Workflow - 2 hours after Transaction record created, set the Checked flag true if Last_Inbound = True</description>
        <field>NVMStatsSF__checked__c</field>
        <literalValue>1</literalValue>
        <name>Trigger Channel Check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
