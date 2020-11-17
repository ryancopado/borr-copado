<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Product_Quote_Approved</fullName>
        <description>Product Quote Approved</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Product_Quote_Approved</template>
    </alerts>
    <alerts>
        <fullName>Product_Quote_Rejected</fullName>
        <description>Product Quote Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Alerts/Product_Quote_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approval_Pending</fullName>
        <field>Status__c</field>
        <literalValue>Approval Pending</literalValue>
        <name>Approval Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Product_Quote_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Product Quote Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Product_Quote_Cancelled</fullName>
        <field>Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Product Quote Cancelled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Product_Quote_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Product Quote Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
</Workflow>
