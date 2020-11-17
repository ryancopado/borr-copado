<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AvaAcctSeed__Rule_on_Tax_Code</fullName>
        <field>AvaAcctSeed__Tax_Code__c</field>
        <formula>Product2.AvaAcctSeed__Tax_Code__c</formula>
        <name>Rule on Tax_Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AvaAcctSeed__TaxRule</fullName>
        <field>AvaAcctSeed__Tax_Code__c</field>
        <formula>&quot;Hello&quot;</formula>
        <name>TaxRule</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AvaAcctSeed__TaxUpdate</fullName>
        <field>AvaAcctSeed__Tax_Code__c</field>
        <formula>Product2.AvaAcctSeed__Tax_Code__c</formula>
        <name>TaxUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AvaAcctSeed__UpadateTax</fullName>
        <field>AvaAcctSeed__Tax_Code__c</field>
        <formula>PricebookEntry.Product2.AvaAcctSeed__Tax_Code__c</formula>
        <name>UpadateTax</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Project_Watts</fullName>
        <field>Project_Watts_Workflow__c</field>
        <formula>Project_Watts__c</formula>
        <name>Project Watts</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>AvaAcctSeed__Rules on Tax Code</fullName>
        <actions>
            <name>AvaAcctSeed__Rule_on_Tax_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AvaAcctSeed__Tax_Code__c  = NULL</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
