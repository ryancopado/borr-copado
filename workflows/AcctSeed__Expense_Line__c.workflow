<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Vendor_Employee_Paid</fullName>
        <description>updates Vendor/Employee Paid when JEL is created</description>
        <field>AcctSeed__Vendor_Employee_Paid__c</field>
        <literalValue>1</literalValue>
        <name>Vendor/Employee Paid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>JEL Created- Update Vendor%2FEmp Paid</fullName>
        <actions>
            <name>Vendor_Employee_Paid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeed__Expense_Line__c.JELCount__c</field>
            <operation>equals</operation>
            <value>1</value>
        </criteriaItems>
        <description>updates the Vendor/employee paid checkbox when JEL is created - used to update status to posted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
