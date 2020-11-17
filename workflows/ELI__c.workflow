<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ELI_Stage_Update</fullName>
        <field>Stage__c</field>
        <formula>&apos;Feasibility&apos;</formula>
        <name>ELI Stage Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expense_Line_Stage</fullName>
        <field>Stage__c</field>
        <formula>IF( TEXT(Project__r.Billing_Status_Feasibility__c) &lt;&gt; &apos;Completed&apos; , &apos;Feasibility&apos;, IF(TEXT(Project__r.PV_Billing_Status_Design__c) &lt;&gt; &apos;Completed&apos; , &apos;Design&apos; , IF(TEXT(Project__r.PV_Billing_Status_Procurement__c) &lt;&gt; &apos;Completed&apos; , &apos;Procurement&apos; , &apos;n/a&apos;)))</formula>
        <name>Expense Line Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mileage_Vendor</fullName>
        <field>Vendor__c</field>
        <formula>&apos;n/a&apos;</formula>
        <name>Mileage Vendor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Request_Amount_to_Approved_Amount</fullName>
        <field>Approved_Amount__c</field>
        <formula>Expenditure_Amount__c</formula>
        <name>Request Amount to Approved Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Mileage_Rate</fullName>
        <field>Use_IRS_Mileage__c</field>
        <literalValue>Yes</literalValue>
        <name>Update Mileage Rate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
