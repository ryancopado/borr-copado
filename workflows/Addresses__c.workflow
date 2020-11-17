<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Remit_Address_Mirror</fullName>
        <description>See workflow for definition</description>
        <field>Remit_Address_Mirror__c</field>
        <formula>IF( 
ISBLANK( 
Suite_Unit__c ), 
Street_Address__c &amp; BR() &amp; 
City__c + &quot;, &quot; + 
State__c &amp; BR() + &quot; &quot; + Zip_Code__c, 
Street_Address__c &amp; BR() &amp; 
Suite_Unit__c &amp; BR() &amp; 
City__c + &quot;, &quot; + 
State__c &amp; BR() + &quot; &quot; + Zip_Code__c )</formula>
        <name>Remit Address Mirror</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Remit to Address Mirror</fullName>
        <actions>
            <name>Remit_Address_Mirror</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Process builder cannot update long text areas correctly so this workflow is needed as a workaround to get the Remit To Address on the AP Invoice</description>
        <formula>OR( ISNEW(), OR( ISCHANGED( Street_Address__c ), ISCHANGED( Suite_Unit__c ), ISCHANGED( City__c ), ISCHANGED( State__c ), ISCHANGED( Zip_Code__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
