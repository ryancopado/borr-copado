<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Taxable_False</fullName>
        <field>Taxable__c</field>
        <literalValue>0</literalValue>
        <name>Taxable False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Taxable_True</fullName>
        <field>Taxable__c</field>
        <literalValue>1</literalValue>
        <name>Taxable True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>project_update_on_billing</fullName>
        <field>Project__c</field>
        <formula>AcctSeed__Project__r.Name</formula>
        <name>project update on billing</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
        <targetObject>AcctSeed__Billing__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_BL_Tax_Description</fullName>
        <description>updates the Billing Line description on sales tax billing lines</description>
        <field>Description__c</field>
        <formula>&quot;Sales Tax Total&quot;</formula>
        <name>update BL Tax Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Sales Tax Description</fullName>
        <actions>
            <name>update_BL_Tax_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>AutoFills Sales Tax Description when line is created</description>
        <formula>AcctSeed__Revenue_GL_Account__r.Name= &quot;2204-Sales tax payable-CA&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Taxable False</fullName>
        <actions>
            <name>Taxable_False</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>AcctSeed__Billing_Line__c.AvaAcctSeed__LineTax__c</field>
            <operation>equals</operation>
            <value>0.00</value>
        </criteriaItems>
        <criteriaItems>
            <field>AcctSeed__Billing_Line__c.Category__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>marks Taxable checkbox as &quot;False&quot; when tax is calculated on the Billing Line</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Taxable True</fullName>
        <actions>
            <name>Taxable_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>AcctSeed__Billing_Line__c.AvaAcctSeed__LineTax__c</field>
            <operation>notEqual</operation>
            <value>0.00</value>
        </criteriaItems>
        <criteriaItems>
            <field>AcctSeed__Billing_Line__c.AvaAcctSeed__LineTax__c</field>
            <operation>greaterThan</operation>
            <value>0.00</value>
        </criteriaItems>
        <criteriaItems>
            <field>AcctSeed__Billing_Line__c.Category__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>marks Taxable checkbox as &quot;true&quot; when tax is calculated on the Billing Line</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Project on Billing</fullName>
        <actions>
            <name>project_update_on_billing</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK(AcctSeed__Project__c))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
