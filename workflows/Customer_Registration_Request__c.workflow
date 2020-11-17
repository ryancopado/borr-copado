<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Customer_Registration_Accepted</fullName>
        <description>Customer Registration Accepted</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Customer_Registration_Accepted</template>
    </alerts>
    <alerts>
        <fullName>Customer_Registration_Approved_by_Customer</fullName>
        <description>Customer Registration Approved by Customer</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Customer_Registration_Approved_by_Customer</template>
    </alerts>
    <fieldUpdates>
        <fullName>Customer_Registration_Accepted</fullName>
        <field>Status__c</field>
        <literalValue>Accepted</literalValue>
        <name>Customer Registration Accepted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Customer_Registration_Recalled</fullName>
        <field>Status__c</field>
        <literalValue>Recalled</literalValue>
        <name>Customer Registration Recalled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Customer_Registration_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Customer Registration Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Customer_Registration_Submitted</fullName>
        <field>Status__c</field>
        <literalValue>Submitted by PD</literalValue>
        <name>Customer Registration Submitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Customer Registration Customer Approved</fullName>
        <actions>
            <name>Customer_Registration_Approved_by_Customer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Customer_Registration_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Customer Approved</value>
        </criteriaItems>
        <description>notifies requestor that registration has been accepted by customer</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
