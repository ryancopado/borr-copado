<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>APL_Amount_Update_for_O_M</fullName>
        <description>auto fills</description>
        <field>AcctSeed__Amount__c</field>
        <formula>AcctSeed__Quantity__c *  Rate__c</formula>
        <name>APL Amount Update for O&amp;M</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Auto Fill Amount</fullName>
        <actions>
            <name>APL_Amount_Update_for_O_M</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeed__Account_Payable__c.Invoice_Type__c</field>
            <operation>equals</operation>
            <value>O&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>AcctSeed__Account_Payable_Line__c.Rate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>auto fills Amount when O&amp;M Invoice and Qty &amp; Rate are fllled in</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
