<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Disbursement_Date</fullName>
        <field>DisbursementDate2__c</field>
        <formula>AcctSeed__Cash_Disbursement__r.AcctSeed__Disbursement_Date__c</formula>
        <name>Disbursement Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Disbursement Date</fullName>
        <actions>
            <name>Disbursement_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AcctSeed__AP_Disbursement__c.Payment_Period__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
