<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Project_Stage_Fixed_Cost</fullName>
        <field>Stage__c</field>
        <formula>IF( TEXT( Project__r.Billing_Status_Feasibility__c ) &lt;&gt; &apos;Completed&apos; , &apos;Feasibility&apos;,  
 IF( TEXT( Project__r.PV_Billing_Status_Design__c ) &lt;&gt; &apos;Completed&apos; , &apos;Design&apos;, 
 IF( TEXT( Project__r.PV_Billing_Status_Procurement__c ) &lt;&gt; &apos;Completed&apos; , &apos;Procurement&apos;,
 &apos;n/a&apos;) ) )</formula>
        <name>Project Stage (Fixed Cost)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
